-- pl,1-4,false - select a move slot  are move slots
-- pl,0,false   - select default move (solar beam charge, hyper beam recharge, struggle, ...)
-- pl,1-6,true  - switch with team slot

|[f_select_switch]| function(pl, pkmn)
    f_addaction(pl, pl, "|comes|back", function(s, o) -- self, other
        s.active = f_team_pkmn_to_active(pkmn)
        s.active.invisible = true
        f_addaction(s, s, "|comes|out", function(s, o) -- self, other
            s.active.invisible = false
        end)
    end)

    -- there are different levels of priority & switch is the highest one
    pl.priority = C_PRIORITY_SWITCH
end $$

-- metronome would call this function as well as select_move
-- todo: get _ENV working here & populated with correct things, actually, env should populate on add action
|[f_movelogic]| function(self, move)
    f_addaction(self, self, "|uses|"..move.name, function(self, other)
        f_movehelp_update_pp(move)

        -- explosion & self destruct hurt the user first, then they might miss, so this part of that logic must go outside the normal flow
        if move.num == M_EXPLOSION or move.num == M_SELF_DESTRUCT then
            f_move_setdmg_self(f_zobj([[self,@, selfactive,@]], self, self.active), self.active.hp)
        end

        if f_does_move_miss(self.active, other.active, move) then
            f_addaction(self, self, "|missed|"..move.name)

            if move.num == M_HIGH_JUMP_KICK or move.num == M_JUMP_KICK then
                -- todo: will break until _ENV is working here
                f_move_setdmg_self(_ENV, 1)
            end
        else
            if move.accuracy ~= 0 then -- -1 is swift, positive is most moves. mirrormove has 0 acc, so you can't copy that. haze is -1 too
                other.active.lastmoverecv = move.num
            end

            -- todo: might be nice if other things were supported (miss, fail, resist)
            if move:func(self, other) then
                f_addaction(self, self, "|failed|"..move.name)
            end
        end
    end)
end $$

|[f_select_move]| function(pl, move)
    pl.actions = {}
    local priority_class = C_PRIORITY_ATTACK

    f_movelogic(pl, move)

    -- hardcoding the only moves that can change priority for now. Maybe there is a more token efficient way to do this?
    if move.num == M_QUICK_ATTACK then priority_class = C_PRIORITY_QUICKATTACK end
    if move.num == M_COUNTER or move.num == M_WHIRLWIND or move.num == M_ROAR or move.num == M_TELEPORT then
        priority_class = C_PRIORITY_COUNTER
    end

    -- speed can be between 1 and 999, so multiples of 1000 can be priority
    -- highest priority goes first. if priority is same, roll a dice to decide
    pl.priority = _min(C_PRIORITY_SWITCH, priority_class+pl.active:f_movehelp_getstat'speed')
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
            elseif p ~= game.p0 then
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

        -- for explosion, you should finish the turn before switching in your pokemon
        if s.active.hp <= 0 and s.active.major == C_MAJOR_FAINTED then
            s.active = f_team_pkmn_to_active(f_get_next_active(s.team))
            return f_newaction(s, "|comes|out")
        end
    end
end $$

-- returns possible moves that can be used in the fight.
|[f_get_moves]| function(pkmn)
    local moves = {}

    _foreach(pkmn.mynewmoves, function(m)
        if m.num > 0 then
            _add(moves, m)
        end
    end)

    return moves
end $$

|[f_get_possible_moves]| function(pkmn)
    local moves = {}

    _foreach(f_get_moves(pkmn), function(m)
        if m.pp > 0 then
            _add(moves, m)
        end
    end)

    return moves
end $$

|[f_select_random_move]| function(active)
    local possible_moves = f_get_possible_moves(active)
    return possible_moves[f_flr_rnd(#possible_moves)+1] or f_create_move(M_STRUGGLE)
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

-- this crit formula is slightly different than the original games.
-- electrode 
|[f_get_crit_ratio]| function(_ENV, movenum)
    -- slash:        _min(.99, (base_speed+76)/128) -- times .3 is close enough
    -- focus energy: _min(.99, (base_speed+236)/512) -- times .3 is close enough
    -- focus energy + crit move: .99 -- with my damage calculation, technically, slowpoke ends up at 98

    -- range is 0 to 255. then random roll is done out of 256, so high crit still has like a .5% chance of failing.
    local divisor = 1024
    if movenum == M_RAZOR_LEAF or movenum == M_SLASH or movenum == M_KARATE_CHOP or movenum == M_CRABHAMMER then divisor *= .3 end
    if focused then divisor *= .3 end

    -- decimal here is 255/256. close enough to the actual formula
    return _rnd'1' < _min(.99, (base_speed+76)/divisor) and 2 or 1
end $$

-- pokemon stadium has a 1/65536 chance of a move missing
|[f_does_move_miss]| function(attacker, defender, move)
    -- todo: token crunch, think about a ~= and func again.
    if move.accuracy <= 0  then return false end -- this catches swift and self status moves... swift is negative
    if defender.digging and move.num ~= M_FISSURE and move.num ~= M_EARTHQUAKE                          then return true end
    if defender.flying  and move.num ~= M_GUST    and move.num ~= M_THUNDER and move.num ~= M_WHIRLWIND then return true end
    return _rnd(defender.evasion) > move.accuracy/100*attacker:f_movehelp_getstat'accuracy' or f_flr_rnd'256' == 0 and f_flr_rnd'256' == 0
end $$

-- returns .5, 0, 1, or 2
|[f_get_type_modifier]| function(move_type, pkmn_type)
    return c_types[move_type][pkmn_type] or 1
end $$

-- type advantage used to calculate resistance too
|[f_get_type_advantage]| function(move, defender)
    return f_get_type_modifier(move.type, defender.type1)*f_get_type_modifier(move.type, defender.type2)
end $$

-- see: https://web.archive.org/web/20140711082447/http://www.upokecenter.com/content/pokemon-red-version-blue-version-and-yellow-version-timing-notes
-- and: https://bulbapedia.bulbagarden.net/wiki/Damage
-- only returns "zero" if there is a resistance
|[f_calc_move_damage]| function(attacker, defender, move)
    -- todo: need to factor in if burned
    -- todo: token crunch this algorithm
    local iscontact = move.type % 2 == 1
    local critical = f_get_crit_ratio(attacker, move.num)
    local stab = (move.type == attacker.type1 or move.type == attacker.type2) and 1.5 or 1
    local attack, defense = attacker:f_movehelp_getstat'special', defender:f_movehelp_getstat'special'

    if iscontact then
        attack, defense = attacker:f_movehelp_getstat'attack', defender:f_movehelp_getstat'defense'
        if defender.reflected then
            defense *= 2
        end
    elseif defender.screened then
        defense *= 2
    end

    -- 3 is min, because 3+2=5... 5*1*.5*.5*.85\1 = 1, so this makes the lowest damage possible 1 (not zero)
    local base_damage = _mid(
        3, 997,
        (2*attacker.level*critical/5+2)/50 -- [.44,.84]
        *move.damage                       -- [6.6,285.6] -- [15,340]
        *mid(10, .2, attack/defense)       -- [1.32,2856]
    )+2

    -- max possible damage: 5994
    -- end of formula multiplies by a random number (217/255)
    return base_damage
        *stab
        *f_get_type_advantage(move, defender)
        *(_rnd'.15'+.85)\1
end $$
