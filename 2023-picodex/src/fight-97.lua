-- pl,1-4,false - select a move slot  are move slots
-- pl,0,false   - select default move (solar beam charge, hyper beam recharge, struggle, ...)
-- pl,1-6,true  - switch with team slot

|[f_select_switch]| function(pl, slot)
    f_addaction(pl, pl, "|comes|back", function(s, o) -- self, other
        s.active = f_team_pkmn_to_active(s.team[slot])
        s.active.invisible = true
        f_addaction(s, s, "|comes|out", function(s, o) -- self, other
            s.active.invisible = false
        end)
    end)

    -- there are different levels of priority & switch is the highest one
    pl.priority = C_PRIORITY_SWITCH
end $$

|[f_select_move]| function(pl, move)
    pl.actions = {}
    local priority_class = C_PRIORITY_ATTACK

    f_addaction(pl, pl, "|uses|"..move.name, function(s, o) -- self, other
        f_generic_attack(s, o, move)
    end)

    -- hardcoding the only moves that can change priority for now. Maybe there is a more token efficient way to do this?
    if move.num == M_QUICK_ATTACK then priority_class = C_PRIORITY_QUICKATTACK end
    if move.num == M_COUNTER or move.num == M_WHIRLWIND or move.num == M_ROAR or move.num == M_TELEPORT then
        priority_class = C_PRIORITY_COUNTER
    end

    -- speed can be between 1 and 999, so multiples of 1000 can be priority
    -- highest priority goes first. if priority is same, roll a dice to decide
    pl.priority = _min(C_PRIORITY_SWITCH, priority_class+pl.active:getstat'speed')
end $$

|[f_get_other_pl]| function(game, pl)
    return pl == game.p1 and game.p2 or game.p1   
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
end $$

-- self pl, other pl
-- return faint action if %c_no hp and not dead
-- return nothing if end of turn
|[f_pop_next_action]| function(game)
    -- if an active pokemon has %c_no hp, but not the faint status yet, return an action that makes the pokemon faint.
    for p in _all{game.p1,game.p2} do
        if p.active.hp <= 0 then
            if p.active.major ~= C_MAJOR_FAINTED then
                return f_newaction(p, "|is|fainted", f_logic_faint)
            else
                p.active = f_team_pkmn_to_active(f_get_next_active(p.team))
                return f_newaction(p, "|comes|out")
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

-- returns possible moves that can be used in the fight.
|[f_get_possible_moves]| function(active)
    local possible_moves = {}

    for i=1,4 do
        if active.mynewmoves[i].num > 0 and active.mynewmoves[i].pp > 0 then
            _add(possible_moves, active.mynewmoves[i])
        end
    end

    return possible_moves
end $$

|[f_select_random_move]| function(active)
    local possible_moves = f_get_possible_moves(active)
    return possible_moves[f_flr_rnd(#possible_moves)+1] or f_create_move(M_STRUGGLE)
end $$

|[f_generic_attack]| function(self, other, move)
    -- only less than 0 for struggle and none moves. none move would never be selected though
    if move.num > 0 then
        move.pp -= 1
    end

    local dmg = f_calc_move_damage(self.active, other.active, move)
    if dmg > 0 then
        f_addaction(self, other, "|-"..dmg.."|hitpoints", function()
            other.active.shared.hp = _max(0, other.active.shared.hp-dmg)
        end)

    -- otherwise, it is splash for now i guess
    else
        f_addaction(self, self, "|does|nothing")
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
-- todo: (wait) make high crit moves & focus energy work
|[f_get_crit_ratio]| function(base_speed)
    -- slash:        _min(.99, (base_speed+76)/128)
    -- focus energy: _min(.99, (base_speed+236)/512)
    -- focus energy + crit move: .99609

    -- range is 0 to 255. then random roll is done out of 256, so high crit still has like a .5% chance of failing.
    local ratio = (base_speed+76)/1024

    -- decimal here is 255/256. close enough to the actual formula
    return _rnd'1' < _min(.99609, ratio) and 2 or 1
end $$

-- pokemon rb just have one rnd check here. but stadium makes it two.
|[f_move_accuracy_rate]| function()
    return f_flr_rnd'256' == 0 and f_flr_rnd'256' == 0
end $$

-- returns .5, 0, 1, or 2
|[f_get_type_modifier]| function(move_type, pkmn_type)
    return c_types[move_type][pkmn_type] or 1
end $$

|[f_calc_move_damage]| function(attacker, defender, move)
    -- this if check is needed for moves with a "-1" damage. though technically those moves shouldn't be called by this function.
    if move.damage <= 0 then return 0 end

    -- todo: token crunch this algorithm
    local critical = f_get_crit_ratio(attacker.base_speed)
    local stab = (move.type == attacker.type1 or move.type == attacker.type2) and 1.5 or 1
    local base_damage = _min(997, (2*attacker.level*critical/5+2)*max(0, move.damage)*(attacker:getstat'attack'/defender:getstat'defense')/50+2)

    -- end of formula multiplies by a random is a rab
    return base_damage
        *stab
        *f_get_type_modifier(move.type, defender.type1)
        *f_get_type_modifier(move.type, defender.type2)
        *(_rnd'.15'+.85)\1
end $$

