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
|[f_move_roar]| function(move, self, other)
    local pkmn = f_movehelp_switch(other)
    if pkmn then
        f_select_switch(other, pkmn)
    else
        f_addaction(self, self, "|failed|"..move.name)
    end
end $$

|[f_move_stat_self]| function(move, self, other, key, stage)
    -- todo: add message if stat does not increase
    if f_movehelp_incstat(self.active, key, stage) then
        -- todo: token crunch create function that formats a num with +/- & apply it to move_stat_self and battle logic
        f_addaction(self, self, "|+"..stage.."/6|"..key)
    else
        f_addaction(self, self, "|failed|"..move.name)
    end
end $$

-- todo: token crunch, combine logic with move_stat_self
|[f_move_stat_other]| function(move, self, other, key, stage)
    -- todo: add message if stat does not increase
    if f_movehelp_incstat(other.active, key, stage) then
        -- todo: token crunch create function that formats a num with +/- & apply it to move_stat_self and battle logic
        f_addaction(self, other, "|-"..abs(stage).."/6|"..key)
    else
        f_addaction(self, self, "|failed|"..move.name)
    end
end $$

|[f_move_major_other]| function(move, self, other, majorind)
    -- todo: add message if stat does not increase
    if f_movehelp_major(other.active, majorind) then
        f_addaction(self, other, "|is|"..c_major_names[majorind])
    else
        f_addaction(self, self, "|failed|"..move.name)
    end
end $$

|[f_move_transform]| function(move, self, other)
    if self.active.transform then
        f_addaction(self, self, "|failed|transform")
    else
        f_addaction(self, self, "|copied|"..other.active.name, function()
            self.active.transform = true
            foreach(split'num,attack,defense,speed,special,type1,type2', function(key)
                self.active[key] = other.active[key]
            end)

            self.active.mynewmoves = {}
            foreach(other.active.mynewmoves, function(m)
                local newmove = f_create_move(m.num)
                newmove.pp, newmove.maxpp = 5, 5
                _add(self.active.mynewmoves, newmove)
            end)
        end)
    end
end $$

|[f_movehelper_resistance]| function(move, self, other, func)
    local dmg = f_calc_move_damage(self.active, other.active, move)
    if dmg > 0 then
        func(dmg)
    else
        f_addaction(self, other, "|resisted|"..move.name)
    end
end $$

|[f_move_default]| function(move, self, other)
    f_movehelper_resistance(move, self, other, function(dmg)
        f_addaction(self, other, "|-"..dmg.."|hitpoints", function()
            other.active.shared.hp = _max(0, other.active.shared.hp-dmg)
        end)
    end)
end $$

-- ohko moves only work on slower foes
|[f_move_ohko]| function(move, self, other)
    if self.active.speed >= other.active.speed then
        f_movehelper_resistance(move, self, other, function()
            f_addaction(self, other, "|-"..other.active.shared.hp.."|hitpoints", function()
                other.active.shared.hp = 0
            end)
        end)
    else
        f_addaction(self, self, "|failed|"..move.name)
    end
end $$
