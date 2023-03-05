-- pl,1-4,false - select a move slot  are move slots
-- pl,0,false   - select default move (solar beam charge, hyper beam recharge, struggle, ...)
-- pl,1-6,true  - switch with team slot
|[f_select_move]| function(pl, slot, switch)
    pl.actions = {}
    local priority_class = C_PRIORITY_ATTACK

    if switch then
        priority_class = C_PRIORITY_SWITCH
        f_addaction(pl, pl, "#,comes,back", function(s, o) -- self, other
            s.active = f_team_pkmn_to_active(s.team[slot])
            s.active.invisible = true
            f_addaction(s, s, "#,comes,out", function(s, o) -- self, other
                s.active.invisible = false
            end)
        end)
    else
        local move = pl.active.mynewmoves[slot]
        f_addaction(pl, pl, "#,uses,"..move.name, function(s, o) -- self, other
            f_generic_attack(s, o, slot)
        end)

        -- hardcoding the only moves that can change priority for now. Maybe there is a more token efficient way to do this?
        if move.num == M_QUICK_ATTACK then priority_class = C_PRIORITY_QUICKATTACK end
        if move.num == M_COUNTER or move.num == M_WHIRLWIND or move.num == M_ROAR or move.num == M_TELEPORT then
            priority_class = C_PRIORITY_COUNTER
        end
    end

    -- speed can be between 1 and 999, so multiples of 1000 can be priority
    -- highest priority goes first. if priority is same, roll a dice to decide
    pl.priority = _min(C_PRIORITY_SWITCH, priority_class+pl.active:getstat'speed')
end $$

|[f_get_other_pl]| function(game, pl)
    return pl == game.p1 and game.p2 or game.p1   
end $$

|[f_draw_hp]| function(x, y, hp, maxhp, align, col)
    _rectfill(x, y-2, x-align*_max(_ceil(hp/maxhp*40), 0), y+2, col)
end $$

---------------------------------------------------------------------------
-- misc stuff
---------------------------------------------------------------------------
|[f_newaction]| function(pactive, message, logic)
    return {pl=pactive, active=pactive.active, message=message, logic=logic or f_nop}
end $$

|[f_addaction]| function(p0, ...)
    _add(p0.actions, f_newaction(...))
end $$

-- switch if there is a next pokemon
-- otherwise, do nothing. turn logic will check every turn if there is a win condition
|[f_logic_faint]| function(s)
    s.active.shared.major = C_MAJOR_FAINTED
    s:dielogic()
    _add(s.deadnums, s.active.num) -- trainer battles and horde unlock pokemon with this.
end $$

-- self pl, other pl
-- return faint action if %c_no hp and not dead
-- return nothing if end of turn
|[f_pop_next_action]| function(game)
    -- if an active pokemon has %c_no hp, but not the faint status yet, return an action that makes the pokemon faint.
    for p in _all{game.p1,game.p2} do
        if p.active.hp <= 0 then
            if p.active.major ~= C_MAJOR_FAINTED then
                return f_newaction(p, "#,is,fainted", f_logic_faint)
            else
                p.active = f_team_pkmn_to_active(f_get_next_active(p.team))
                return f_newaction(p, "#,comes,out")
            end
        end
    end

    for s in _all{game.p0, f_get_other_pl(game, game.p0)} do
        local o = f_get_other_pl(game, s)

        -- if the active pokemon shouldn't faint right now, find the next action that references a pokemon still on the field.
        while #s.actions > 0 do
            local action = _deli(s.actions, 1)
            if action.active.major ~= C_MAJOR_FAINTED and (action.active == s.active or action.active == o.active) then
                return action
            end
        end
    end
end $$

-- returns move slot number. 0 means to use struggle.
|[f_get_possible_move_slots]| function(active)
    local possible_moves = {}

    for i=1,4 do
        if active.mynewmoves[i].num > 0 and active.mynewmoves[i].pp > 0 then
            _add(possible_moves, i)
        end
    end

    return possible_moves
end $$

|[f_select_random_move_slot]| function(active)
    local possible_moves = f_get_possible_move_slots(active)
    return possible_moves[f_flr_rnd(#possible_moves)+1] or M_STRUGGLE
end $$

-- [s]elf pl, [o]ther pl, [m]ove slot
|[f_generic_attack]| function(s, o, m)
    local move = s.active.mynewmoves[m]

    -- only less than 0 for struggle and none moves. none move would never be selected though
    if move.num > 0 then
        s.active.mynewmoves[m].pp -= 1
    end

    local dmg = move.damage -- f_calc_move_damage(s.active.level, s.active.attack, defense, critical, move_power)
    if dmg > 0 then
        f_addaction(s, o, "#,-"..dmg..",hitpoints", function()
            o.active.shared.hp = _max(0, o.active.shared.hp-dmg)
        end)

    -- otherwise, it is splash for now i guess
    else
        f_addaction(s, s, "#,does,nothing")
    end
end $$

-- turn_actions = {
--   message?                  -- lowered attack
--   function (does something) -- takes attack down 1
--   koed!
-- }

-- there are stat stages for modifying moves. accuracy doesn't have same stat stages though: https://www.smogon.com/rb/articles/stadium_guide
-- here is where the table came from: https://gamefaqs.gamespot.com/gameboy/367023-pokemon-red-version/faqs/64175/stat-modifiers

-- fire can't be burned by fire type moves. ice can't be frozen by ice type moves. ground can't be paralyzed by electric type moves. anyone can sleep. poison can't be poisoned by poison type moves.

-- a battle's turn consists of actions. once both players have made their moves, the actions are compiled, then applied one at a time. Each action has a status message.
-- turn_actions = {
--   message?                  -- lowered attack
--   function (does something) -- takes attack down 1
--   koed!
-- }

-- func that generates actions for status effects
-- func that generates actions for dealing damage

-- i use game states?
-- or battle uses extra states?

-- for fight
-- selecting action is a menu, so it pushes on the game stack
-- turn -> turn -> select -> turn -> turn -> select
-- turn init will switch the 2 pokemon. select will set it.

-- takes in the hard-coded base speed value for the pkmn, so electrode would have highest crit ratio.
|[f_get_crit_ratio]| function(base_speed)
    -- range is 0 to 255. then random roll is done out of 256, so high crit still has like a .5% chance of failing.
    -- todo (wait): redo these slightly
    -- (bs+76)/4 | (bs+236)/2 | (bs+76)/4*8 (crit move)
    return _min(.99, (base_speed+76)/1024)
    -- slash:        _min(.99, (base_speed+76)/128)
    -- focus energy: _min(.99, (base_speed+236)/512)
end $$

-- pokemon rb just have one rnd check here. but stadium makes it two.
|[f_move_accuracy_rate]| function()
    return f_flr_rnd'256' == 0 and f_flr_rnd'256' == 0
end $$

|[f_calc_move_damage]| function(level, attack, defense, critical, move_power)
    -- critical is 1 or 2
    -- need function for attack/defense ratio to prevent divide by zero
    -- base_damage can be a _max of 997
    local base_damage = (2*level*critical/5+2)*move_power*(attack/defense)/50+2

    -- stab is 1.5 of base damage if move type equals pkmn type
    -- types are .5, 1, or 2, based on move's effectivenes against the opposing dual type pokemon
    -- random is between 217/255 and 255/255 inclusive
    return base_damage*stab*type1*type2*random
end $$

