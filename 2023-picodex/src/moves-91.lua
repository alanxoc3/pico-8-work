-- todo: make it so showing a different player's stats also shows their name in draw2.
-- todo: need something that takes percent & function for moves that have 10% chance to do something extra.

-- todo: initial wave: make every move do things (rest sets sleep...)
-- todo: second wave: make states actually have an effect and unset properly (dig/rest/poison....)

-- roar/whirlwind/teleport
|[f_movehelp_switch]| function(pl)
    local team = f_get_team_live(pl.team)
    _del(team, pl.active.shared)

    if #team > 0 then
        return team[f_flr_rnd(#team)+1]
    end
end $$

-- returns true if it increased, false otherwise
|[f_movehelp_incstat]| function(a, stat, inc)
    local prev = a.stages[stat] or 0
    a.stages[stat] = mid(-6, 6, prev+inc)
    return prev ~= a.stages[stat]
end $$

|[f_movehelp_major]| function(a, major)
    if a.shared.major == C_MAJOR_NONE then
        a.shared.major = major
        return true
    end
end $$

|[f_movehelp_getstat]| function(a, stat)
    -- evasion and accuracy have a different formula: https://www.smogon.com/rb/articles/stadium_guide
    -- all stats cap at 999: https://www.smogon.com/rb/articles/rby_mechanics_guide
    local stage = a.stages[stat] or 0
    return _ceil(_mid(1, 999,
        a[stat]*(
            (stat == 'evasion' or stat == 'accuracy')
            and _mid(1, 1+stage/3, 3)/_mid(1, 1-stage/3, 3)
             or _mid(2, 2+stage,   8)/_mid(2, 2-stage,   8)
        )
    ))
end $$

-- move utility funcs
|[f_movehelp_update_pp]| function(move)
    -- only less than 0 for struggle and none moves. none move would never be selected though
    if move.num > 0 then
        move.pp -= 1
    end
end $$

--------------------------------
---------- move funcs ----------
--------------------------------
-- move funcs take in "_ENV", which has some useful things
-- returning "true" means the move failed

|[f_move_implement]| function(_ENV)
    -- todo: wait. remove me when all moves are done
    f_addaction(self, self, "|not|implemented")
end $$

-- todo: moves should have a slot index (for mimic and maybe something else). metronome/mirrormove should pass it's slot index to the new move it creates.
|[f_move_metronome]| function(_ENV)
    -- movelogic will subtract pp from new move, so that doesn't matter
    f_movelogic(self, f_create_move(f_flr_rnd(164)+1))
end $$

-- move funcs take in "_ENV", which has some useful things
-- returning "true" means the move failed
|[f_move_roar]| function(_ENV)
    local pkmn = f_movehelp_switch(other)
    if pkmn then
        f_select_switch(other, pkmn)
    else
        return true
    end
end $$

|[f_move_teleport]| function(_ENV)
    local pkmn = f_movehelp_switch(self)
    if pkmn then
        f_select_switch(self, pkmn)
    else
        return true
    end
end $$

|[f_move_stat_self]| function(_ENV, key, stage)
    if f_movehelp_incstat(selfactive, key, stage) then
        -- todo: token crunch create function that formats a num with +/- & apply it to move_stat_self and battle logic
        f_addaction(self, self, "|+"..stage.."/6|"..key)
    else
        return true
    end
end $$

-- todo: token crunch, combine logic with move_stat_self
|[f_move_stat_other]| function(_ENV, key, stage)
    if f_movehelp_incstat(otheractive, key, stage) then
        -- todo: token crunch create function that formats a num with +/- & apply it to move_stat_self and battle logic
        f_addaction(self, other, "|-".._abs(stage).."/6|"..key)
    else
        return true
    end
end $$

|[f_move_toxic]| function(_ENV)
    if f_move_major_other(_ENV, C_MAJOR_POISONED) and otheractive.major ~= C_MAJOR_POISONED then
        return true
    end

    return f_move_minor_other(_ENV, 'toxiced')
end $$

|[f_move_splash]| function(_ENV)
    f_addaction(self, self, "|does|nothing")
end $$

|[f_move_major_other]| function(_ENV, majorind)
    if f_movehelp_major(otheractive, majorind) then
        f_addaction(self, other, "|is|"..c_major_names[majorind])
    else
        return true
    end
end $$

-- for confuse, flinch, leechseed
|[f_move_minor_other]| function(_ENV, minor)
    if not otheractive[minor] then
        otheractive[minor] = true
        -- todo: minor here will break with minification... i should change minors to numbers instead
        f_addaction(self, other, "|is|"..minor)
    else
        return true
    end
end $$

-- for focusenergy...
|[f_move_minor_self]| function(_ENV, minor)
    if not selfactive[minor] then
        selfactive[minor] = true
        -- todo: minor here will break with minification... i should change minors to numbers instead
        f_addaction(self, self, "|is|"..minor)
    else
        return true
    end
end $$

|[f_move_transform]| function(_ENV)
    if selfactive.transform then
        return true
    else
        f_addaction(self, self, "|copied|"..otheractive.name, function()
            selfactive.transform = true
            _foreach(_split'num,attack,defense,speed,special,type1,type2', function(key)
                selfactive[key] = otheractive[key]
            end)

            selfactive.mynewmoves = {}
            _foreach(otheractive.mynewmoves, function(m)
                local newmove = f_create_move(m.num)
                newmove.pp, newmove.maxpp = 5, 5
                _add(selfactive.mynewmoves, newmove)
            end)
        end)
    end
end $$

|[f_movehelper_resistance]| function(_ENV, func)
    local dmg = f_calc_move_damage(selfactive, otheractive, move)
    if dmg > 0 then
        func(dmg)
    else
        f_addaction(self, other, "|resisted|"..move.name)
    end
end $$

|[f_move_default]| function(_ENV)
    f_movehelper_resistance(_ENV, function(dmg)
        f_addaction(self, other, "|-"..dmg.."|hitpoints", function()
            otheractive.shared.hp = _max(0, otheractive.shared.hp-dmg)
        end)
    end)
end $$

-- for moves that do damage, then an extra effect
-- todo: movepercent logic can probably be combined with movedefault logic ( could have < (percent or 0) and 100 means always apply
|[f_move_percent]| function(_ENV, percent, func, ...)
    local params = {...}
    f_movehelper_resistance(_ENV, function(dmg)
        f_addaction(self, other, "|-"..dmg.."|hitpoints", function()
            otheractive.shared.hp = _max(0, otheractive.shared.hp-dmg)
        end)

        if _rnd'100' < percent then
            func(_ENV, _unpack(params))
        end
    end)
end $$

-- ohko moves only work on slower foes
|[f_move_ohko]| function(_ENV)
    if selfactive.speed >= otheractive.speed then
        f_movehelper_resistance(_ENV, function()
            f_addaction(self, other, "|-"..otheractive.shared.hp.."|hitpoints", function()
                otheractive.shared.hp = 0
            end)
        end)
    else
        return true
    end
end $$
