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
    if not a.misted or inc > 0 then
        a.stages[stat] = _mid(-6, 6, prev+inc)
    end
    return prev ~= a.stages[stat]
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
|[f_move_disable]| function(_ENV)
    if otheractive.disabledtimer > 0 then return true end
    local moves = f_get_moves(otheractive)
    if #moves == 0 then return true end

    otheractive.disabledtimer = f_flr_rnd'6'+2
    otheractive.disabledslot  = moves[f_flr_rnd(#moves)+1].slot
    addaction(other, "|"..otheractive.mynewmoves[otheractive.disabledslot].name.."|disabled")

    -- if the move disabled is a multiturn move, we need to stop the multiturn timer
    -- no need to worry about trapping moves, because you won't be able to use disable during a trapping move
    if otheractive.curmove and otheractive.curmove.slot == otheractive.disabledslot then
        otheractive.moveturn = 0
    end
end $$

|[f_movehelp_movecopy]| function(_ENV, num, slot)
    local newmove = f_create_move(num, slot)
    newmove.pp, newmove.maxpp = 5, 5
    mynewmoves[slot] = newmove
    return newmove
end $$

|[f_move_mimic]| function(_ENV)
    local othermoves = f_get_moves(otheractive, true)
    addaction(self, "|copies|"..f_movehelp_movecopy(selfactive, othermoves[f_flr_rnd(#othermoves)+1].num, move.slot).name)
end $$

|[f_move_transform]| function(_ENV)
    if selfactive.transform then
        return true
    else
        addaction(self, "|copies|"..otheractive.name, function()
            selfactive.transform = true
            _foreach(_split'num,attack,defense,speed,special,type1,type2', function(key)
                selfactive[key] = otheractive[key]
            end)

            selfactive.mynewmoves = {}
            _foreach(otheractive.mynewmoves, function(m)
                f_movehelp_movecopy(selfactive, m.num, m.slot)
            end)
        end)
    end
end $$

|[f_move_conversion]| function(_ENV)
    f_zobj_set(selfactive, [[ type1,@, type2,@ ]], otheractive.type1, otheractive.type2)
    addaction(self, "|copies|types")
end $$

|[f_move_haze]| function(_ENV)
    _foreach({other, self}, function(pl)
        f_zobj_set(pl.active.stages, [[
            special, 0, attack, 0,
            defense, 0, speed,  0,
            accuracy,0, evasion,0
        ]])

        addaction(pl, "|resets|stats")
    end)
end $$

-- recover and softboiled
|[f_move_heal]| function(_ENV, pl, amount)
    amount = _min(amount, pl.active.maxhp-pl.active.hp)
    if amount > 0 then
        addaction(pl, f_format_num_sign(amount, "|hitpoints"), function()
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

|[f_format_num_sign]| function(num, remainder)
    return (_sgn(num) > 0 and '|+' or '|-').._abs(num)..remainder
end $$

|[f_move_self]|  function(_ENV, func, ...) return func(_ENV, self,  ...) end $$
|[f_move_other]| function(_ENV, func, ...) return func(_ENV, other, ...) end $$

-- leverages f_move_(self|other)
|[f_move_stat]| function(_ENV, pl, key, stage)
    if f_movehelp_incstat(pl.active, key, stage) then
        addaction(pl, f_format_num_sign(stage, "/6|"..c_stages[key].longname))
    else
        return true
    end
end $$

|[f_move_toxic]| function(_ENV)
    if f_move_major_other(_ENV, C_MAJOR_POISONED) and otheractive.major ~= C_MAJOR_POISONED then
        return true
    end

    return f_move_other(_ENV, f_movehelp_minor, "|badly|poisoned", 'toxiced', 1)
end $$

|[f_move_splash]| function(_ENV)
    addaction(self, "|does|nothing")
end $$

|[f_move_major_other]| function(_ENV, majorind)
    -- todo, prevent electric from getting paralyzed, fire from getting burned, ice frozen, grass leech, poison poisoned...
    if f_get_type_advantage(move, otheractive) > 0 and otheractive.shared.major == C_MAJOR_NONE then
        addaction(other, "|is now|"..c_major_names[majorind], function()
            otheractive.shared.major = majorind

            -- every time major stat is set, sleep timer is set, but sleep timer isn't used unless pkmn is actually sleeping
            f_start_sleep_timer(otheractive)
        end)
    else
        return true
    end
end $$

-- leverages f_move_(self|other)
-- focus/screen/seed/mist/reflct/toxic
|[f_movehelp_minor]| function(_ENV, pl, message, minor, val)
    if (pl.active[minor] or 0) == 0 then
        pl.active[minor] = val or 1
        addaction(pl, message)
    else
        return true
    end
end $$

|[f_movehelp_flinch]| function(_ENV, pl)
    pl.active.flinching = true
end $$

|[f_movehelp_confuse]| function(_ENV, pl)
    return f_movehelp_minor(_ENV, pl, "|becomes|confused", 'confused', f_flr_rnd'4'+1)
end $$

|[f_move_substitute]| function(_ENV)
    local subhp = selfactive.maxhp\4 -- bound isn't needed here, because every pokemon has a maxhp of greater than 4.
    if subhp >= selfactive.hp or selfactive.substitute > 0 then
        return true
    end

    f_move_setdmg_self(_ENV, subhp)
    addaction(self, "|created|substitute", function()
        selfactive.substitute = subhp
    end)
end $$

---------- MULTITURN MOVES ---------------
-- todo: combine with thrash logic
|[f_move_rage]| function(_ENV)
    f_set_moveturn(selfactive, -1, f_create_move(move.num, move.slot))
    f_move_default(_ENV)
end $$

|[f_move_bide]| function(_ENV)
    -- the modulus here is to check if the last move was a physical move
    if not selfactive.curmove then
        f_set_moveturn(selfactive, f_flr_rnd'2'+1, f_create_move(move.num, move.slot))
        addaction(self, "|"..move.name.."|begins")
        selfactive.bidedmg = 0
    end

    if selfactive.moveturn == 0 then
        f_move_setdmg(_ENV, selfactive.bidedmg*2)
    end
end $$

|[f_move_thrash]| function(_ENV)
    f_set_moveturn(selfactive, f_flr_rnd'2'+1, f_create_move(move.num, move.slot))
    f_move_default(_ENV)

    if selfactive.moveturn == 0 then
        f_move_self(_ENV, f_movehelp_confuse, 'confused')
    end
end $$

|[f_move_trapping]| function(_ENV)
    -- the "trappedother" stuff is used to check if the opponent switched out.
    -- the trapper will continue trapping 1 more turn if the opponent used teleport but if they switch, that wouldn't happen.
    -- i think that's a cool strat
    -- this is because teleport goes after all trapping moves.
    if not selfactive.curmove then
        f_set_moveturn(selfactive, f_flr_rnd'4'+1, f_create_move(move.num, move.slot))
        selfactive.trappedother = otheractive
    end

    if selfactive.trappedother == otheractive then
        f_move_default(_ENV)
    else
        return true -- fail if not equal, this triggers if opponent is switched out this turn
    end
end $$

|[f_move_flydig]| function(_ENV, desc)
    if selfactive.curmove then
        f_move_default(_ENV)
    else
        addaction(self, desc, function()
            f_set_moveturn(selfactive, 1, f_create_move(move.num, move.slot))
        end)
    end
end $$

-- solarbeam/razorwind/skullbash/skyattack
|[f_move_prepare]| function(_ENV)
    if selfactive.curmove then
        f_move_default(_ENV)
    else
        addaction(self, "|charges|energy")
        f_set_moveturn(selfactive, 1, move)
        move.pp += 1 -- increment 1 pp, since 1 pp was just used, if the attack is interrupted, a pp should not be consumed
    end
end $$

|[f_move_hyperbeam]| function(_ENV)
    if selfactive.curmove then
        addaction(self, "|recharges|energy")
    else
        f_move_default(_ENV)

        -- accuracy is set to 0, because recharge can't miss.
        local m = f_create_move(move.num, move.slot)
        m.accuracy = 0
        f_set_moveturn(selfactive, 1, m)
    end
end $$

---------- DAMAGING MOVES BELOW ----------
|[f_start_sleep_timer]| function(_ENV)
    sleeping = f_flr_rnd'3'+2
    -- ^^ If I change the sleep timer amount, remember that
end $$

|[f_move_rest]| function(_ENV)
    selfactive.shared.major = C_MAJOR_SLEEPING
    f_start_sleep_timer(selfactive) -- has check, must go after setting major
    addaction(self, "|is|sleeping")
    f_move_heal(_ENV, self, selfactive.maxhp)
    selfactive.toxiced = 0
end $$

|[f_move_counter]| function(_ENV)
    -- the modulus here is to check if the last move was a physical move
    if selfactive.counterdmg > 0 then
        f_move_setdmg(_ENV, selfactive.counterdmg*2)
    else
        return true
    end
end $$

-- todo: weird order with multihit and rage (when it says +1 attack).
|[f_move_multihit_set]| function(_ENV, hitcount, endfunc, isresume)
    if hitcount > 0 then
        addaction(self, isresume and "|resumes|"..move.name, function()
            _ENV.otheractive = other.active -- needed because the fight logic removes new other actives
            if f_move_default(_ENV) then
                -- multihit can fail midway if a new pokemon enters in mid attack with resistance
                addaction(self, "|fails|"..move.name)
            else
                f_move_multihit_set(_ENV, hitcount-1, endfunc, true)
            end
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

|[f_move_recoil]| function(_ENV)
    local dmg = f_calc_move_damage(selfactive, otheractive, move)
    if f_move_setdmg(_ENV, dmg) then
        return true
    else
        f_move_setdmg_self(_ENV, _max(1, dmg\4))
    end
end $$

-- can either just do default damage, or an effect based on probability can be added after the default damage
-- some moves have extra effects
|[f_move_default]| function(_ENV, percent, func, ...)
    if f_move_setdmg(_ENV, f_calc_move_damage(selfactive, otheractive, move)) then
        return true
    else
        -- if percent is not specified, the func will never run, so func is required when percent is specified
        if _rnd'100' < (percent or 0) then
            func(_ENV, ...)
        end
    end
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
        f_move_heal(_ENV, self, _max(dmg\2, 1))
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
    return f_move_setdmg(_ENV, _max(otheractive.hp\2, 1))
end $$

-- 8190

|[f_movehelp_setdmg]| function(_ENV, pl, dmg, isself)
    local active = pl.active
    local issub = not isself and active.substitute > 0
    addaction(pl, f_format_num_sign(-dmg, "|hitpoints"), function()
        active.bidedmg += dmg
        -- rage increment
        if active.curmove and active.curmove.num == M_RAGE then
            f_move_stat(_ENV, pl, 'attack', 1)
        end

        if issub then
            active.substitute = _max(active.substitute-dmg, 0)
        else
            active.shared.hp = _max(active.shared.hp-dmg, 0)
        end
    end, issub and "substitute")
end $$

-- zero damage means resistance
-- all opponent dmg goes through here.
-- good, because it gives a central place to track substitute/counter/bide/rage information
|[f_move_setdmg]| function(_ENV, dmg)
    if dmg > 0 and f_get_type_advantage(move, otheractive) > 0 then
        if move.type % 2 == 1 then -- check if physical attack
            otheractive.counterdmg += dmg
        end

        f_movehelp_setdmg(_ENV, other, dmg)
    else
        return true -- todo: maybe instead of returning true, can return a message
    end
end $$

-- assumes non zero damage
-- all self inflicting dmg goes here, includes: recoil, confuse, poison, burn, seed, explode, substitute-create
-- that's good, because self inflicting damage should bypass substitute
|[f_move_setdmg_self]| function(_ENV, dmg)
    f_movehelp_setdmg(_ENV, self, dmg, true)
end $$
