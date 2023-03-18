-- todo: make it so showing a different player's stats also shows their name in draw2.
-- todo: need something that takes percent & function for moves that have 10% chance to do something extra.
-- todo: disable move needs to show disabled message if move is disabled on the same turn.

-- todo: initial wave: make every move do things (rest sets sleep...)
-- todo: second wave: make states actually have an effect and unset properly (dig/rest/poison....)

-- todo: fix error, bonerang related bug
-- runtime error line 17 tab 0
-- endfunc()
-- attempt to call local 'endfunc' (a nil value)
-- at line 0 (tab 0)

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
    local prev = a.stages[stat]
    if not a.misted then
        a.stages[stat] = mid(-6, 6, prev+inc)
    end
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
    local stage = a.stages[stat]
    return _ceil(_mid(1, 999,
        a[stat]*(
            (stat == 'evasion' or stat == 'accuracy')
            and _mid(1, 1+stage/3, 3)/_mid(1, 1-stage/3, 3)
             or _mid(2, 2+stage,   8)/_mid(2, 2-stage,   8)
        )
    ))
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

|[f_move_disable]| function(_ENV)
    if otheractive.disabledtimer > 0 then return true end
    local moves = f_get_moves(otheractive)
    if #moves == 0 then return true end

    otheractive.disabledtimer = f_flr_rnd'6'+2
    otheractive.disabledslot  = moves[f_flr_rnd(#moves)+1].slot
    f_addaction(self, other, "|"..otheractive.mynewmoves[otheractive.disabledslot].name.."|disabled")

    -- if the move disabled is a multiturn move, we need to stop the multiturn timer
    -- no need to worry about trapping moves, because you won't be able to use disable during a trapping move
    if otheractive.moveturn ~= 0 and otheractive.curmove.slot == otheractive.disabledslot then
        otheractive.moveturn = 0
    end
end $$

|[f_move_mimic]| function(_ENV)
    -- todo: can any logic be combined with transform?
    local othermoves = f_get_moves(otheractive, true)
    local newmove = f_create_move(othermoves[f_flr_rnd(#othermoves)+1].num, move.slot)
    newmove.pp, newmove.maxpp = 5, 5
    selfactive.mynewmoves[move.slot] = newmove
    f_addaction(self, self, "|copied|"..newmove.name)
end $$

|[f_move_conversion]| function(_ENV)
    -- todo: token crunch here
    selfactive.type1 = otheractive.type1
    selfactive.type2 = otheractive.type2
    selfactive.conversion = true
    f_addaction(self, self, "|copied|types")
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

|[f_move_haze]| function(_ENV)
    _foreach({other, self}, function(pl)
        f_zobj_set(pl.active.stages, [[
            special, 0, attack, 0,
            defense, 0, speed,  0,
            accuracy,0, evasion,0
        ]])

        f_addaction(self, pl, "|reset|modifiers")
    end)
end $$

-- recover and softboiled
|[f_move_heal]| function(_ENV, pl, amount)
    amount = min(amount, pl.active.maxhp-pl.active.hp)
    if amount > 0 then
        f_addaction(self, pl, "|+"..amount.."|hitpoints", function()
            pl.active.shared.hp += amount
        end)
    else
        return true
    end
end $$

|[f_move_recover]| function(_ENV)
    return f_move_heal(_ENV, self, selfactive.maxhp\2)
end $$

|[f_move_metronome]| function(_ENV)
    -- movelogic will subtract pp from new move, so that doesn't matter
    f_movelogic(self, f_create_move(f_flr_rnd(164)+1, move.slot))
end $$

|[f_move_mirror_move]| function(_ENV)
    if selfactive.lastmoverecv > 0 then
        f_movelogic(self, f_create_move(selfactive.lastmoverecv, move.slot))
    else
        return true
    end
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

    return f_move_other(_ENV, f_movehelp_minor, 'toxiced')
end $$

|[f_move_splash]| function(_ENV)
    f_addaction(self, self, "|does|nothing")
end $$

|[f_move_major_other]| function(_ENV, majorind)
    -- todo, prevent electric from getting paralyzed, fire from getting burned, ice frozen, grass leech, poison poisoned...
    if f_get_type_advantage(move, otheractive) > 0 and f_movehelp_major(otheractive, majorind) then
        f_addaction(self, other, "|is|"..c_major_names[majorind])
    else
        return true
    end
end $$

|[f_movehelp_minor]| function(_ENV, pl, minor, val)
    if not pl.active[minor] then
        pl.active[minor] = val or true
        -- todo: minor here will break with minification... i should change minors to numbers instead
        f_addaction(self, pl, "|becomes|"..minor)
    else
        return true
    end
end $$

|[f_move_self]|  function(_ENV, func, ...) return func(_ENV, self,  ...) end $$
|[f_move_other]| function(_ENV, func, ...) return func(_ENV, other, ...) end $$

|[f_movehelp_confuse]| function(_ENV, pl)
    return f_movehelp_minor(_ENV, pl, 'confused', f_flr_rnd'4'+1)
end $$

|[f_move_substitute]| function(_ENV)
    -- todo: the max is probably not needed. if i'm tight on tokens, I can remove it. (add comment if i do saying a bound isn't needed
    local subhp = _max(1, selfactive.maxhp\4)
    if subhp >= selfactive.hp or selfactive.substitute > 0 then
        return true
    end

    f_move_setdmg_self(_ENV, subhp)
    f_addaction(self, self, "|created|substitute", function()
        selfactive.substitute = subhp
    end)
end $$

---------- DAMAGING MOVES BELOW ----------
|[f_move_rest]| function(_ENV)
    selfactive.shared.major = C_MAJOR_SLEEPING
    f_addaction(self, self, "|is|sleeping")
    f_move_heal(_ENV, self, selfactive.maxhp)
    selfactive.toxic = false
end $$

|[f_move_counter]| function(_ENV)
    -- the modulus here is to check if the last move was a physical move
    if c_moves[selfactive.lastmoverecv].type % 2 == 1 then
        return f_move_setdmg(_ENV, (selfactive.turnstarthp-selfactive.hp)*2)
    else
        return true
    end
end $$

|[f_move_multihit_set]| function(_ENV, hitcount, endfunc)
    if hitcount > 0 then
        f_addaction(self, self, "|begin|hit #"..hitcount, function()
            _ENV.otheractive = other.active
            if f_move_default(_ENV) then
                -- multihit can fail midway if a new pokemon enters in mid attack
                f_addaction(self, self, "|failed|hit #"..hitcount)
            end

            f_move_multihit_set(_ENV, hitcount-1, endfunc)
        end)
    else
        endfunc()
    end
end $$

|[f_move_multihit_var]| function(_ENV, hitcount)
    f_move_multihit_set(_ENV, 2+f_flr_rnd'4',f_nop)
end $$

|[f_move_multihit_twin]| function(_ENV)
    f_move_multihit_set(_ENV, 2, function()
        if _rnd'100' < 20 then
            f_move_major_other(_ENV, C_MAJOR_POISONED)
        end
    end)
end $$

|[f_move_thrash]| function(_ENV)
    f_set_moveturn(selfactive, f_flr_rnd'2'+2, f_create_move(move.num, move.slot))
    f_move_default(_ENV)

    if selfactive.moveturn == 1 then
        f_move_self(_ENV, f_movehelp_confuse, 'confused')
    end
end $$

-- solarbeam/razorwind/skullbash/skyattack
|[f_move_prepare]| function(_ENV)
    f_set_moveturn(selfactive, 2, move)

    if selfactive.moveturn == 1 then
        f_move_default(_ENV)
    else
        f_addaction(self, self, "|preparing|attack")
        move.pp += 1 -- increment 1 pp, since 1 pp was just used, if the attack is interrupted, a pp should not be consumed
    end
end $$

-- todo: implement the "attack goes up" thing for rage
-- todo: combine with thrash logic
|[f_move_rage]| function(_ENV)
    f_set_moveturn(selfactive, -1, f_create_move(move.num, move.slot))
    f_move_default(_ENV)
end $$

|[f_move_recoil]| function(_ENV)
    local dmg = f_calc_move_damage(selfactive, otheractive, move)
    if f_move_setdmg(_ENV, dmg) then
        return true
    else
        f_move_setdmg_self(_ENV, max(1, dmg\4))
    end
end $$

|[f_move_default]| function(_ENV)
    return f_move_setdmg(_ENV, f_calc_move_damage(selfactive, otheractive, move))
end $$

|[f_move_dreameater]| function(_ENV)
    if selfactive.major == C_MAJOR_SLEEPING then
        f_move_drain(_ENV)
    else
        return true
    end
end $$

|[f_move_drain]| function(_ENV)
    local dmg = f_calc_move_damage(selfactive, otheractive, move)
    if f_move_setdmg(_ENV, dmg) then
        return true
    else
        f_move_heal(_ENV, self, max(dmg\2, 1))
    end
end $$

-- for moves that do damage, then an extra effect
-- todo: movepercent logic can probably be combined with movedefault logic ( could have < (percent or 0) and 100 means always apply
|[f_move_percent]| function(_ENV, percent, func, ...)
    if f_move_default(_ENV) then
        return true
    else
        if _rnd'100' < percent then
            func(_ENV, ...)
        end
    end
end $$

-- ohko moves only work on slower foes
|[f_move_ohko]| function(_ENV)
    if selfactive.speed >= otheractive.speed then
        return f_move_setdmg(_ENV, otheractive.hp)
    else
        return true
    end
end $$

-- ohko moves only work on slower foes
|[f_move_psywave]| function(_ENV)
    -- number is C_LEVEL*1.5 -- 75 in this case
    return f_move_setdmg(_ENV, 1+f_flr_rnd'75')
end $$

|[f_move_superfang]| function(_ENV)
    return f_move_setdmg(_ENV, max(otheractive.hp\2, 1))
end $$

-- zero damage means resistance
-- all opponent dmg goes through here. good, because it gives a central place to track substitute/counter/bide/rage information
|[f_move_setdmg]| function(_ENV, dmg)
    if dmg > 0 and f_get_type_advantage(move, otheractive) > 0 then
        f_addaction(self, other, "|-"..dmg.."|hitpoints", function()
            if otheractive.substitute > 0 then
                otheractive.substitute = _max(otheractive.substitute-dmg, 0)
            else
                otheractive.shared.hp = _max(otheractive.shared.hp-dmg, 0)
            end
        end, otheractive.substitute > 0 and "substitute")
    else
        return true -- todo: maybe instead of returning true, can return a message
    end
end $$

-- assumes non zero damage

-- all self inflicting dmg goes here, includes:
-- recoil, confuse, poison, burn, seed, explode, substitute-create
-- that's good, because self inflicting damage should bypass substitute
|[f_move_setdmg_self]| function(_ENV, dmg)
    -- todo: combine with f_move_setdmg logic token & removed second shared
    f_addaction(self, self, "|-"..dmg.."|hitpoints", function()
        selfactive.shared.hp = _max(selfactive.shared.hp-dmg, 0)
    end)
end $$
