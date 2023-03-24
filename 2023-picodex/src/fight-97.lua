-- 8181 baseline

-- pl,1-4,false - select a move slot  are move slots
-- pl,0,false   - select default move (solar beam charge, hyper beam recharge, struggle, ...)
-- pl,1-6,true  - switch with team slot

-- todo: switch while trapped should stop the trapping
-- todo: make it so exiting the screen for your turn will show the battle screen
-- todo: refactor the way counter (and bide) work.
|[f_pkmn_comes_out]| function(pl, pkmn)
    pl.active = f_team_pkmn_to_active(pkmn)
    return f_newaction(pl, "|comes|out")
end $$

|[f_select_switch]| function(pl, pkmn)
    f_addaction(pl, pl, "|comes|back", function(params) -- self, other
        params.selfactive.invisible = true

        f_addaction(pl, pl, false, function()
            _add(pl.actions, f_pkmn_comes_out(pl, pkmn))
        end)
    end)

    -- there are different levels of priority & switch is the highest one
    pl.priority = C_PRIORITY_SWITCH
end $$

-- metronome would call this function as well as select_move
|[f_movelogic]| function(self, move)
    f_addaction(self, self, "|uses|"..move.name, function(params)
        params.move = move

        local _ENV = params
        if move.num > 0 then
            move.pp -= 1
        end

        -- explosion & self destruct hurt the user first, then they might miss, so this part of that logic must go outside the normal flow
        if move.num == M_EXPLOSION or move.num == M_SELF_DESTRUCT then
            f_move_setdmg_self(_ENV, selfactive.hp)
        end

        if f_does_move_miss(selfactive, otheractive, move) then
            addaction(self, "|missed|"..move.name)

            if move.num == M_HIGH_JUMP_KICK or move.num == M_JUMP_KICK then
                f_move_setdmg_self(_ENV, 1)
            end
        else
            if move.accuracy ~= 0 then -- -1 is swift, positive is most moves. mirrormove has 0 acc, so you can't copy that. haze is -1 too
                otheractive.lastmoverecv = move.num
            end

            -- todo: might be nice if other things were supported (miss, fail, resist)
            if move.func(_ENV) then
                addaction(self, "|failed|"..move.name)
            end
        end
    end)
end $$

-- no param means decrement 1, param means set to val
-- you can't change if -1 (rage), gotta switch out to reset that move
|[f_set_moveturn]| function(_ENV, newval, newcurmove)
    if not curmove and moveturn == 0 then
        moveturn, curmove = newval, newcurmove
    end
end $$

-- premove must create at least 1 action, otherwise the battle might crash
|[f_premovelogic]| function(self, move)
    f_addaction(self, self, false, function(params)
        params.move = move
        local _ENV = params

        selfactive:f_decrement_timer('moveturn', f_nop)

        -- C_MAJOR_SLEEPING - 1-3 turns, reset if switch out
        if selfactive.major == C_MAJOR_SLEEPING then
            selfactive:f_decrement_timer('sleeping', function()
                addaction(self, "|suddenly|woke up")
                selfactive.shared.major = C_MAJOR_NONE
            end)

            if selfactive.major == C_MAJOR_SLEEPING then
                addaction(self, "|fast|asleep")
                return
            end
        end

        -- middle of rage... you freeze then immediately unfreeze... that shouldn't cost a pp, should it? If you are on your last pp, you wouldn't have a move this turn.
        -- i think it shouldn't cost a pp in this case.
        if selfactive.major == C_MAJOR_FROZEN then
            if _rnd'1' < .2 then
                addaction(self, "|thawed|out")
                selfactive.shared.major = C_MAJOR_NONE
            else
                addaction(self, "|is|frozen")
                return
            end
        end

        -- trapped
        if otheractive.curmove and otheractive.curmove.ofunc == f_move_trapping then
            addaction(self, "|is|trapped")
            return
        end

        -- and how should trapping move when selecting a move? is it that the trapped can select a move, but the trapper can't? yes.
        -- how does trapping moves work with thrash/rage/beams? multiturn moves are reset. thrash/rage/hyperbeam use a pp, but skyattack/solar beam don't.
        -- any issues with metronome/mirrormove/mimic + multiturn moves? no, i don't think so.

        -- if a move was used on the same turn disable was used
        if selfactive.disabledslot == move.slot then
            addaction(self, "|is|disabled")
            return
        end

        -- confuse - 50% self attack 1-4 turns
        if selfactive.confused > 0 and f_flr_rnd'2' == 0 then
            addaction(self, "|confuse|damage")
            f_move_setdmg_self(_ENV, f_calc_move_damage(selfactive, otheractive, f_create_move(-1))) -- todo, try string here '-1'
            return
        end

        -- paralysis
        if selfactive.major == C_MAJOR_PARALYZED and f_flr_rnd'4' == 0 then
            addaction(self, "|fully|paralyzed")
            return
        end

        if selfactive.flinching then
            addaction(self, "|is|flinching")
            return
        end

        f_movelogic(self, move)
    end)
end $$

|[f_decrement_timer]| function(active, key, endfunc)
    if active[key] > 0 then
        active[key] -= 1
        if active[key] == 0 then
            endfunc() -- todo, maybe default to f_nop? depends on token saving or not (wait)
        end
    end
end $$

-- todo: make minor statuses numbers instead
|[f_postmove_logic]| function(self)

    -- todo: i can probably token crunch this section
    return f_newaction(self, false, function(_ENV)
        -- flinching is reset at the psel init level, so you can't be flinching the next turn. no need to reset flinching here.

        -- moveturn is also reset at the psel init level. if a condition lasts only 1 turn, jjj

        -- reset moveturn if you sleep or are frozen. this is done at end of the turn to prevent weird cases (you freeze then unfreeze same turn).
        -- if you are using rage and freeze then unfreeze in the same turn, you continue your rage.
        if selfactive.major == C_MAJOR_SLEEPING or selfactive.major == C_MAJOR_FROZEN then
            selfactive.moveturn = 0
        end

        -- check for if the multiturn move ended naturally. an unnatural check is right before the player starts the turn.
        -- if the moveturn is zero, we must make sure curmove is nil, because some multiturn moves check the first move based on curmove == nil
        if selfactive.moveturn == 0 then
            selfactive.curmove = nil
        end

        local statdmg = _max(selfactive.maxhp\16,1)
        local inflictstatdmg = function(title) -- title must start with "|" to save 2 tokens
            addaction(self, title.."|damage")
            f_move_setdmg_self(_ENV, statdmg)
        end

        if selfactive.major == C_MAJOR_POISONED then
            if selfactive.toxiced > 0 then
                statdmg *= selfactive.toxiced
                selfactive.toxiced += 1
            end
            inflictstatdmg"|poison"
        end

        if selfactive.major == C_MAJOR_BURNED then inflictstatdmg"|burn"   end

        if selfactive.seeded then
            inflictstatdmg"|seed"
            if otheractive.hp < otheractive.maxhp then
                addaction(other, "|seed|leeching")
                f_move_heal(_ENV, other, statdmg)
            end
        end

        selfactive:f_decrement_timer('confused', function()
            addaction(self, "|confusion|ended")
        end)

        selfactive:f_decrement_timer('disabledtimer', function()
            addaction(self, "|"..selfactive.mynewmoves[selfactive.disabledslot].name.."|enabled")
            selfactive.disabledslot = 0
        end)

        -- todo: sleepcountdown
    end)
end $$

|[f_select_move]| function(pl, move)
    pl.actions = {}
    local priority_class = C_PRIORITY_ATTACK

    f_premovelogic(pl, move)

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
|[f_newaction]| function(pactive, message, logic, name)
    return {pl=pactive, name=name or pactive.active.name, active=pactive.active, message=message, logic=logic or f_nop}
end $$

|[f_addaction]| function(p0, ...)
    _add(p0.actions, f_newaction(...))
end $$

-- only "x" will progress the fight. if you spam, at least you don't miss the end screen.
|[f_turn_update]| function(game)
    if g_bpo then f_beep() end

    if g_bpx then f_minisfx'B_BACK' end
    if g_bpx or not game.cur_action then
        -- while loop exists for actions that don't have a message.
        -- actions without a message are meant to optionally create actions.
        while true do
            -- check for win condition before selecting every action
            for p in _all{game.p1, game.p2} do
                if not f_get_next_active(p.team) then
                    game.p0 = f_get_other_pl(game, p)
                    game:load'fightover'
                    return
                end
            end

            local action = f_pop_next_action(game)
            if action then
                local actionpl = action.active == game.p1.active and game.p1 or game.p2
                local envparams = f_zobj([[move,@, self,@, other,@, addaction,@]], move, actionpl, f_get_other_pl(game, actionpl), function(...)
                    f_addaction(actionpl, ...)
                end)

                envparams.selfactive = envparams.self.active
                envparams.otheractive = envparams.other.active

                action.logic(envparams)
                if action.message then
                    -- this must be in the if statement, because you can't end with an invisible action (draw will fail).
                    game.cur_action = action
                    return
                else
                end
            else
                game:load() -- next turn
                return
            end
        end
    end
end $$

-- self pl, other pl
-- return faint action if ~c_no hp and not dead
-- return nothing if end of turn
|[f_pop_next_action]| function(game)
    -- if an active pokemon has no hp, but not the faint status yet, return an action that makes the pokemon faint.
    -- switch if there is a next pokemon
    -- otherwise, do nothing. turn logic will check every turn if there is a win condition
    for p in _all{game.p1,game.p2} do
        if p.active.hp <= 0 then
            if p.active.major ~= C_MAJOR_FAINTED then
                return f_newaction(p, "|is|fainted", function(_ENV)
                    selfactive.shared.major = C_MAJOR_FAINTED
                end)
            elseif p ~= game.p0 then
                return f_pkmn_comes_out(p, f_get_next_active(p.team))
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
            return f_pkmn_comes_out(s, f_get_next_active(s.team))
        end

        if not s.turnover then
            s.turnover = true
            return f_postmove_logic(s)
        end
    end
end $$

|[f_pkmn_has_move]| function(_ENV, moveid)
    for m in _all(mynewmoves) do
        if m.num == moveid then
            return true
        end
    end
end $$

|[f_pkmn_isempty]| function(_ENV)
    return #f_get_moves(_ENV, true) == 0
end $$

-- returns possible moves that can be used in the fight.
-- used for: mimic, disable, f_get_possible_moves
-- mimic can mimic moves with no pp. disable/possible moves take pp/disabled into account.
|[f_get_moves]| function(pkmn, ismimic)
    -- moves is both an array and a map
    local moves = {}

    _foreach(pkmn.mynewmoves, function(m)
        if m.num > 0 and (ismimic or m.pp > 0 and pkmn.disabledslot ~= m.slot) then
            _add(moves, m)
            moves[m] = true -- this is to make "disabled" in the UI easier
        end
    end)

    return moves
end $$

-- used for: AI, player
-- returns possible moves that can be used in the fight, and takes multiturn moves into account.
|[f_get_possible_moves]| function(_ENV)
    if moveturn ~= 0 then
        -- curmove is always set when moveturn is set to something other than zero
        return {curmove} -- there is no ui for second-turn multiturn moves, so no key needs to be set.
    else
        return f_get_moves(_ENV)
    end
end $$

|[f_select_random_move]| function(active)
    local possible_moves = f_get_possible_moves(active)
    return possible_moves[f_flr_rnd(#possible_moves)+1] or f_create_move(M_STRUGGLE)
end $$

-- this crit formula is only very slightly different than the original games. might be like 1% off.
-- takes in the hard-coded base speed value for the pkmn, so electrode would have highest crit ratio.
|[f_get_crit_ratio]| function(_ENV, movenum)
    -- slash:        _min(.99, (base_speed+76)/128) -- times .3 is close enough
    -- focus energy: _min(.99, (base_speed+236)/512) -- times .3 is close enough
    -- focus energy + crit move: .99 -- with my damage calculation, technically, slowpoke ends up at 98

    -- range is 0 to 255. then random roll is done out of 256, so high crit still has like a .5% chance of failing.
    local divisor = 1024
    if movenum == -1 then return 1 end -- if confusion damage, you can't critical hit.
    if movenum == M_RAZOR_LEAF or movenum == M_SLASH or movenum == M_KARATE_CHOP or movenum == M_CRABHAMMER then divisor *= .3 end
    if focused then divisor *= .3 end

    -- decimal here is 255/256. close enough to the actual formula
    return _rnd'1' < _min(.99, (base_speed+76)/divisor) and 2 or 1
end $$

-- every move aimed at oppenent in pokemon stadium has a 1/65536 chance of a move missing, besides swift
|[f_does_move_miss]| function(attacker, defender, move)
    if move.accuracy <= 0  then return false end -- this catches swift and self status moves... swift is negative

    -- charging moves & fly/dig can't miss on the first turn
    if (move.ofunc == f_move_prepare or move.ofunc == f_move_flydig) and not attacker.curmove then return false end

    -- attacker misses if defender is using fly/dig
    if defender.curmove and defender.curmove.ofunc == f_move_flydig then return true end

    -- attacker can't miss trapping moves if the first hit succeeded
    if attacker.curmove and attacker.curmove.ofunc == f_move_trapping then return false end

    return _rnd(defender:f_movehelp_getstat'evasion') > move.accuracy/100*attacker:f_movehelp_getstat'accuracy' or f_flr_rnd'256' == 0 and f_flr_rnd'256' == 0
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
    local attack, defense = attacker:f_movehelp_getstat'special', defender:f_movehelp_getstat'special'

    if move.type % 2 == 1 then -- iscontact
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
        (2*attacker.level*f_get_crit_ratio(attacker, move.num)/5+2)/50 -- [.44,.84]
        *move.damage                       -- [6.6,285.6] -- [15,340]
        *_mid(10, .2, attack/defense)       -- [1.32,2856]
    )+2

    -- max possible damage: 5994
    -- end of formula multiplies by a random number (217/255)
    return base_damage
        *((move.type == attacker.type1 or move.type == attacker.type2) and 1.5 or 1) -- stab
        *f_get_type_advantage(move, defender)
        *(_rnd'.15'+.85)\1
end $$
