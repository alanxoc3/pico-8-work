-- pkmn must be non-nil and match the team table structure defined in f_create_team_pkmn
|[f_pkmn_comes_out]| function(pl, pkmn)
    local moves = {}

    -- need to copy each move just for mimic to work when switching
    foreach(pkmn.mynewmoves, function(m)
        add(moves, m)
    end)

    pl.active = setmetatable(f_zobj([[
        isactive,~c_yes, -- used for a drawing function, should draw fainted pokemon if they are not active, but not if they are active.
        lastmoverecv,0,  -- last move targeted at user, for mirrormove
        accuracy,1,      -- accuracy stat for battle
        evasion,1,       -- evasion stat for battle
        moveturn,0,      -- turn move is on. > 0, decrements each turn. 0, is the same. -1, is multiturn move that doesn't end (rage).
        invisible,~c_yes,

        -- conditions are all numbers ...
        counterdmg,0,    -- resets to zero each turn
        bidedmg,0,       -- resets to zero when using bide
        disabledtimer,0, -- how long the disabled move should last
        confused,0,      -- for confusion, how long pkmn is confused
        sleeping,@,      -- for sleeping, how long pkmn is sleeping. must start at non-zero in case a pokemon is switched in
        substitute,0,    -- for substitute obviously
        toxiced,0,       -- how bad the toxic is

        -- curmove -- used for multiturn moves, if moveturn ~= 0, this must be set
        shared,@,
        mynewmoves,@;

        stages; special, 0, attack, 0,
                defense, 0, speed,  0,
                accuracy,0, evasion,0
    ]], f_flr_rnd'7'+1, pkmn, moves), {__index=pkmn})
    -- ^^ hard-coding sleep timer here

    return f_newaction(pl, "|enters|fight", function()
        f_minisfx(pl.active.num)
        pl.active.invisible = false
    end)
end $$

|[f_in_moves]| function(movenum, str)
    for m in all(split(str)) do
        if m == movenum then
            return true
        end
    end
end $$

|[f_select_switch]| function(pl, pkmn)
    f_addaction(pl, pl, "|leaves|fight", function(params) -- self, other
        params.selfactive.invisible = true

        f_addaction(pl, pl, false, function()
            add(pl.actions, f_pkmn_comes_out(pl, pkmn))
        end)
    end)

    -- there are different levels of priority & switch is the highest one
    pl.priority = C_PRIORITY_SWITCH
end $$

-- metronome would call this function as well as select_move
|[f_movelogic]| function(self, move)
    local desc = self.active.curmove and "|resumes|" or (move.ofunc == f_move_multiturn and "|begins|" or "|uses|")

    f_addaction(self, self, desc..move.name, function(params)
        params.move = move

        local _ENV = params
        if move.num > 0 then
            move.pp -= 1
        end

        -- explosion & self destruct hurt the user first, then they might miss, so this part of that logic must go outside the normal flow
        if f_in_moves(move.num, 'M_EXPLOSION,M_SELF_DESTRUCT') then
            f_move_setdmg_self(_ENV, selfactive.hp)
        end

        if (function() -- miss logic
            if move.accuracy <= 0  then return false end -- this catches swift and self status moves... swift is negative

            -- charging moves & fly/dig can't miss on the first turn
            if (move.ofunc == f_move_prepare or move.ofunc == f_move_flydig) and not selfactive.curmove then return false end

            -- selfactive misses if otheractive is using fly/dig
            if otheractive.curmove and otheractive.curmove.ofunc == f_move_flydig then return true end

            -- selfactive can't miss trapping moves if the first hit succeeded
            if selfactive.curmove and selfactive.curmove.ofunc == f_move_trapping then return false end

            -- every move aimed at oppenent in pokemon stadium has a 1/65536 chance of a move missing, besides swift
            return rnd(otheractive:f_movehelp_getstat'evasion') > move.accuracy/100*selfactive:f_movehelp_getstat'accuracy' or f_flr_rnd'256' == 0 and f_flr_rnd'256' == 0
        end)() then
            addaction(self, "|misses|"..move.name)

            if f_in_moves(move.num, 'M_HIGH_JUMP_KICK,M_JUMP_KICK') then
                f_move_setdmg_self(_ENV, 1)
            end
        else
            if move.func(_ENV) then
                addaction(self, "|fails|attack")
            end
        end

        if move.accuracy ~= 0 then -- -1 is swift, positive is most moves. mirrormove has 0 acc, so you can't copy that. haze is -1 too
            otheractive.lastmoverecv = move.num
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

        if selfactive.major == C_MAJOR_FROZEN then
            if rnd'1' < .2 then
                addaction(self, "|thawed|out")
                selfactive.shared.major = C_MAJOR_NONE
            else
                addaction(self, "|is|frozen")
                return
            end
        end

        if otheractive.trappedother == selfactive                          then addaction(self, "|is|trapped")
        elseif selfactive.disabledslot == move.slot                        then addaction(self, "|is|disabled")
        elseif selfactive.major == C_MAJOR_PARALYZED and f_flr_rnd'4' == 0 then addaction(self, "|fully|paralyzed")
        elseif selfactive.flinching                                        then addaction(self, "|is|flinching")
        else
            if selfactive.confused > 0 then
                addaction(self, "|is|confused")
                if f_flr_rnd'2' == 0 then
                    addaction(self, "|hurt|itself")
                    f_move_setdmg_self(_ENV, f_calc_move_damage(selfactive, otheractive, f_create_move(-1))) -- can't be a string
                    return
                end
            end

            f_movelogic(self, move)
        end
    end)
end $$

|[f_decrement_timer]| function(active, key, endfunc)
    if active[key] > 0 then
        active[key] -= 1
        if active[key] == 0 then
            endfunc()
        end
    end
end $$

|[f_postmove_logic]| function(self)
    return f_newaction(self, false, function(_ENV)
        -- flinching is reset at the psel init level, so you can't be flinching the next turn. no need to reset flinching here.
        -- counterdmg is also reset at psel init level.

        -- reset moveturn if you sleep or are frozen. this is done at end of the turn to prevent weird cases (you freeze then unfreeze same turn).
        -- if you are using rage and freeze then unfreeze in the same turn, you continue your rage.
        -- if opponent is slower, then dies from leech/psn/brn, the trapper could lose a turn
        -- but that's just a super edge case, so i don't care about changing it
        if selfactive.major == C_MAJOR_SLEEPING                                   -- sleep
            or selfactive.major == C_MAJOR_FROZEN                                 -- freeze
            or selfactive.trappedother and selfactive.trappedother ~= otheractive -- trapping & opponent switched
        then
            selfactive.moveturn = 0
        end

        -- check for if the multiturn move ended naturally. an unnatural check is right before the player starts the turn.
        -- if the moveturn is zero, we must make sure curmove is nil, because some multiturn moves check the first move based on curmove == nil
        if selfactive.moveturn == 0 then
            selfactive.trappedother, selfactive.curmove = nil
        end

        local statdmg = max(selfactive.maxhp\16,1)
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

        if selfactive.major == C_MAJOR_BURNED then inflictstatdmg"|burn" end

        if selfactive.seeded then
            inflictstatdmg"|seed"
            if otheractive.hp < otheractive.maxhp then
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
    end)
end $$

|[f_select_move]| function(pl, move)
    pl.actions = {}
    local priority_class = C_PRIORITY_ATTACK

    f_premovelogic(pl, move)

    -- hardcoding the only moves that can change priority for now. Maybe there is a more token efficient way to do this?
    if move.num == M_QUICK_ATTACK then priority_class = C_PRIORITY_QUICKATTACK end
    if f_in_moves(move.num, 'M_COUNTER,M_WHIRLWIND,M_ROAR,M_TELEPORT') then
        priority_class = C_PRIORITY_COUNTER
    end

    -- speed can be between 1 and 999, so multiples of 1000 can be priority
    -- highest priority goes first. if priority is same, roll a dice to decide
    pl.priority = min(C_PRIORITY_SWITCH, priority_class+pl.active:f_movehelp_getstat'speed')
end $$

|[f_get_other_pl]| function(game, pl)
    return pl == game.p1 and game.p2 or game.p1   
end $$

---------------------------------------------------------------------------
-- misc stuff
---------------------------------------------------------------------------
|[f_newaction]| function(pactive, message, logic, name) -- name, message, and logic can be nil, pactive cannot
    return f_zobj([[pl,@, name,@, active,@, message,@, logic,@]], pactive, name or pactive.active.name, pactive.active, message or false, logic or f_nop)
end $$

|[f_addaction]| function(p0, ...)
    add(p0.actions, f_newaction(...))
end $$

|[f_psel_update]| function(_ENV)
    if g_bpx then
        _ENV:f_modes_push'pselactions'
        f_minisfx'B_OKAY'
    end

    f_invalid_button()
end $$

|[f_invalid_button]| function()
    if g_bpo or g_bph | g_bpv ~= 0 then f_beep() end
end $$

-- only "x" will progress the fight. if you spam, at least you don't miss the end screen.
|[f_turn_update]| function(game)
    f_invalid_button()

    if g_bpx then f_minisfx'B_BACK' end
    if g_bpx or not game.cur_action then
        -- while loop exists for actions that don't have a message.
        -- actions without a message are meant to optionally create actions.
        while true do
            -- check for win condition before selecting every action
            for p in all{game.p1, game.p2} do
                if not f_get_next_active(p.team) then
                    game.pwin = f_get_other_pl(game, p)
                    game:f_actor_load'fightover'
                    return
                end
            end

            local action = f_pop_next_action(game)
            if action then
                local actionpl = action.active == game.p1.active and game.p1 or game.p2
                local envparams = f_zobj([[move,@, self,@, other,@, addaction,@]], move, actionpl, f_get_other_pl(game, actionpl), function(...)
                    f_addaction(actionpl, ...)
                end)

                envparams.selfactive, envparams.otheractive = envparams.self.active, envparams.other.active
                action.logic(envparams)
                if action.message then
                    -- this must be in the if statement, because you can't end with an invisible action (draw will fail).
                    game.cur_action = action
                    return
                else
                end
            else
                -- this if statement is needed for being able to show battle when selecting move.
                game:f_actor_load() -- next turn
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
    for p in all{game.p1,game.p2} do
        if p.active.hp <= 0 then
            if p.active.major ~= C_MAJOR_FAINTED then
                return f_newaction(p, "|has|fainted", function(_ENV)
                    selfactive.shared.major = C_MAJOR_FAINTED
                end)
            elseif p ~= game.p0 then
                return f_pkmn_comes_out(p, f_get_next_active(p.team))
            end
        end
    end

    for s in all{game.p0, f_get_other_pl(game, game.p0)} do
        local o = f_get_other_pl(game, s)

        -- if the active pokemon shouldn't faint right now, find the next action that references a pokemon still on the field.
        while #s.actions > 0 do
            local action = deli(s.actions, 1)
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
    for m in all(mynewmoves) do
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

    foreach(pkmn.mynewmoves, function(m)
        if m.num > 0 and (ismimic or m.pp > 0 and pkmn.disabledslot ~= m.slot) then
            add(moves, m)
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

-- movetype advantage used to calculate resistance too
|[f_get_type_advantage]| function(move, defender)
    return (c_types[move.movetype][defender.type1] or 1)*(c_types[move.movetype][defender.type2] or 1)
end $$

-- see: https://web.archive.org/web/20140711082447/http://www.upokecenter.com/content/pokemon-red-version-blue-version-and-yellow-version-timing-notes
-- and: https://bulbapedia.bulbagarden.net/wiki/Damage
-- only returns "zero" if there is a resistance, so damage is guaranteed to be at least 1 unless there is resistance.
-- returns: dmg, iscrit, movetype ratio
|[f_calc_move_damage]| function(attacker, defender, move)
    local attack, defense = attacker:f_movehelp_getstat'special', defender:f_movehelp_getstat'special'

    if move.movetype % 2 == 1 then -- iscontact
        attack, defense = attacker:f_movehelp_getstat'attack', defender:f_movehelp_getstat'defense'
        if defender.reflected then
            defense *= 2
        end
    elseif defender.screened then
        defense *= 2
    end

    ----- BEGIN CRIT LOGIC
    -- this crit formula is only very slightly different than the original games. might be like 1% off.
    -- takes in the hard-coded base speed value for the pkmn, so electrode would have highest crit ratio.
    -- slash:        min(.99, (base_speed+76)/128) -- times .3 is close enough
    -- focus energy: min(.99, (base_speed+236)/512) -- times .3 is close enough
    -- focus energy + crit move: .99 -- with my damage calculation, technically, slowpoke ends up at 98
    -- range is 0 to 255. then random roll is done out of 256, so high crit still has like a .5% chance of failing.

    local divisor = 1024
    if f_in_moves(move.num, 'M_RAZOR_LEAF,M_SLASH,M_KARATE_CHOP,M_CRABHAMMER') then divisor *= .3 end
    if focused then divisor *= .3 end

    -- decimal here is 255/256. close enough to the actual formula. >0 check filters out struggle and confuse dmg.
    local crit = rnd'1' < min(.99, (attacker.base_speed+76)/divisor) and move.num > 0 and 2 or 1
    ----- END CRIT LOGIC

    -- 3 is min, because 3+2=5... 5*1*.5*.5*.85\1 = 1, so this makes the lowest damage possible 1 (not zero)
    local base_damage = mid(
        3, 997,
        (100*crit/5+2)/50             -- [.44,.84], 100 comes from attacker.level*2, level is always 50
        *move.damage                  -- [6.6,285.6] -- [15,340]
        *mid(10, .2, attack/defense) -- [1.32,2856]
    )+2

    -- max possible damage: 5994
    -- end of formula multiplies by a random number (217/255)
    local dmg, advantage = base_damage, f_get_type_advantage(move, defender)
        *((move.movetype == attacker.type1 or move.movetype == attacker.type2) and 1.5 or 1) -- stab
        *(rnd'.15'+.85)

    if advantage > 0 then
        return mid(1, 999, dmg*advantage\1), crit > 1
    end

    return 0, false
end $$
