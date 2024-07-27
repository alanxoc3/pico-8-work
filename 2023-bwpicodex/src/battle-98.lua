-- battle: this file contains functions that help with all logic of pkmn battles besides logic executed during a move.
-- examples of things that would be in this file:
-- - weather at end of turn. futuresight effect at end of turn
-- - switching logic. battle data structures. turn logic.
-- - priority logic. logic for executing moves. determining when battle ends.

-- Some globals that we manage in the battle:

-- Some terminology:
-- - battle: from when both players send out their first pokemon until one player forfeits or has all their pokemon faint.
-- - round:  from when you select you move/switch action until the next time you can choose your move/switch action.
-- - turn:   the current action stack that is being popped from. starts with p_first then p_last for each level
-- - action: within the current turn, an action is a discrete message and/or function that operates on a player

-- p_battle_bot  & p_battle_top:   bottom (1) and top (2) players on the ui gets set when the battle starts and never changes throughout the battle.
-- p_round_first & p_round_last:   the player that goes first/last. this changes before each round starts and should not be used during move/action selection.
-- p_turn_self   & p_turn_other:   the player currently executing actions from an action stack.
-- p_action_self & p_action_other: the current highlighted player or the player currently executing an action.

-- some convenience active pokemon variables are available for actions:
-- p_turn_self_active   & p_turn_other_active
-- p_action_self_active & p_action_other_active

-- Some player specific things

|[f_create_player]| function(name, team, subname, num, iscpu)
  local player = f_zobj([[
    team,@,           -- The 1-6 benched pokemon.
    name,@,           -- The player's name (enemy/player...)
    subname,@,        -- The real team name (team1/lance...)
    num,@,            -- The sprite number of the player.
    iscpu,@,          -- Whether or not the player is a cpu
    actions,#,        -- Actions for the player.
    greed,7           -- The next spot in the buffer. This is only used for horde.
    -- nextmove,~c_no -- 0-3 for a move index into the moveset. false value for switching. Commented out to save on compression, defaults to nil value
  ]], team, name, subname, num, iscpu)

  for i=1,6 do
    if team[i].valid then
      player.active = f_create_active(player, i)
      break
    end
  end

  return player
end $$

|[f_get_other_pl]| function(player)
  return player == p_battle_bot and p_battle_top or p_battle_bot
end $$

|[f_set_both_players]| function(zobjtext, player)
  f_zobj_set(_g, zobjtext, player, f_get_other_pl(player), player.active, f_get_other_pl(player).active)
end $$

|[f_get_live_pkmn]| function(player)
  local newteam = {} -- TODO: _ENV syntax here?
  for i=1,6 do
    local ind = (player.active.spot+i-1)%6+1
    local pkmn = player.team[ind]
    if pkmn.valid and pkmn.major ~= C_MAJOR_FAINTED then
      add(newteam, ind)
    end
  end
  return newteam
end $$

-- Could return the current pokemon if that's the only one. TODO: it wasnt an issue in the previous pokedex, but determine if it would be an issue in this one.
|[f_get_next_active]| function(player)
  return f_get_live_pkmn(player)[1]
end $$

-- This is called when a player either gives up or loses.
-- Pass in the loser player.
|[f_end_battle]| function(player)
  f_set_both_players([[p_action_self,@, p_action_other,@, p_action_self_active,@, p_action_other_active,@]], player) -- TODO: Could this be removed?

  f_zcall(f_pop_ui_stack, [[
     ;, -- battle scene TODO: convert to a zcall?
    ;;, -- p_battle_top select scene
    ;;, -- p_battle_bot select scene
  ]])

  f_add_to_ui_stack(g_grid_battle_results)
end $$

-- player cannot be nil, others can. the player turn is passed and the current active is extracted.
-- the current active is needed because if it dies, we want to skip over actions
-- if message is false/nil, the logic function is executed immediately, then the next action is executed
|[f_newaction]| function(level, player, message, logic, isplayeraction)
  -- TODO: why does the "message or false" line need an "or false"?
  return f_zobj([[level,@, player,@, message,@, logic,@, isplayeraction,@]], level, player, message or false, logic or f_nop, isplayeraction)
end $$

-- adds an action to a player's action list
|[f_addaction]| function(player, ...)
  -- TODO: can this be token crunched?
  add(player.actions, f_newaction(...)) -- TODO: try adding at "1" location
end $$

-- a lot of attacks just add subsequent actions to the attack level of the current turn, so here is a wrapper around that.
|[f_turn_addattack]| function(...)
  f_addaction(p_turn_self, L_ATTACK, ...)
end $$

|[f_pkmn_comes_out]| function(player, spot, level) -- assumes that the pkmn coming is not nil. TODO: level could go away I think?
  local pkmn = player.team[spot]

  -- need to copy each move just for mimic to work when switching

  -- TODO: i should combine this with f_mkpkmn. so all pkmn stuff is just in 1 place.
  player.active = f_create_active(player, spot) -- TODO: the mkactive stuff could go in this comes out function i think, since the only other place it is called is on startup.

  return f_newaction(level, player, "sends "..player.active.name, function()
    player.active.invisible = false
    return player.active.num
  end, true)
end $$

-- self player, other player
-- return faint action if ~c_no hp and not dead
-- return nothing if end of turn

-- timing notes:
-- L_PICK: after this level, p_first and p_last could change.
-- L_ATTACK: if a pokemon faints during (or before, though should be impossible) all actions affecting the fainted pokemon are removed.
-- L_TRIGGER: initial attack stuff goes in trigger, then it creates attacks, which is a lower level.
-- Remaining: execute checks and do things.
|[f_pop_next_action]| function()
  -- if an active pokemon has no hp, but not the faint status yet, return an action that makes the pokemon faint.
  -- switch if there is a next pokemon
  -- otherwise, do nothing. turn logic will check every turn if there is a win condition
  for player in all{p_first,p_last} do -- TODO: try _ENV syntax here?
    if player.active.major == C_MAJOR_FAINTED then
      if player.active.invisible then
        return player, f_pkmn_comes_out(player, f_get_next_active(player), L_ATTACK) -- The level here doesn't actually matter. TODO: is there a nil issue here? And maybe L_ATTACK could be nil.
      else
        -- delete all instances of the current player from the attack phase. remember trigger is part of the considered attack phase (poision/burn in trigger). this prevents moves from glitching or end of attack stuff from being applied (eg: poison)
        for np in all{p_first, p_last} do
          for action in all(np.actions) do
            if action.level <= L_TRIGGER and player == action.player then -- Using del is a hack to save on tokens
              del(np.actions, action)
            end
          end
        end

        -- Actually, it doesn't matter what the Level is here since it is returned. Just saying L_PICK, why not. TODO: maybe i can have L_PICK and not have a return? Maybe that's a bad idea. thank about it tho!
        return player, f_newaction(L_PICK, player, "backs "..player.active.name, function()
          player.active.invisible = true
          f_fill_team(player.team, player.active.spot) -- this is for horde mode, the team will be refilled once the pokemon has fainted.
        end, true)
      end
    end
  end

  for level=1,L_END do
    for player in all{p_first,p_last} do
      for action in all(player.actions) do
        if action.level == level then
          return player, del(player.actions, action)
        end
      end
    end
  end
end $$

|[f_set_player_priority]| function(player)
  f_set_both_players([[p_action_self,@, p_action_other,@, p_action_self_active,@, p_action_other_active,@]], player)
  local priority_class = C_PRIORITY_ATTACK
  local movenum = p_action_self.nextmove and p_action_self.nextmove.num

  -- TODO: in OG picodex, I was calling f_premovelogic(player, move) here

  -- TODO: is there a good way to simplify tokens here?
  if not movenum                                                         then priority_class = C_PRIORITY_SWITCH
  elseif movenum == M_PURSUIT and not p_action_other.movenum             then priority_class = C_PRIORITY_PURSUIT
  elseif f_in_split(movenum, 'M_WHIRLWIND,M_ROAR,M_TELEPORT')            then priority_class = C_PRIORITY_ROAR
  elseif f_in_split(movenum, 'M_QUICKATTACK,M_MACHPUNCH,M_EXTREMESPEED') then priority_class = C_PRIORITY_QUICKATTACK
  elseif f_in_split(movenum, 'M_COUNTER,M_MIRRORCOAT')                   then priority_class = C_PRIORITY_COUNTER
  elseif movenum == M_VITALTHROW                                         then priority_class = C_PRIORITY_VITALTHROW
  end -- TODO: ensure quickclaw is accounted for

  -- speed can be between 1 and 999, so multiples of 1000 can be priority
  -- highest priority goes first. if priority is same, roll a dice to decide
  -- speed can technically affect a switch/pursuit, but doesn't actually matter in that case.
  -- the og picodex had a min(C_PRIORITY_SWITCH, ...) here.
  p_action_self.priority = priority_class+f_stat_calc(p_action_self_active, 'speed', true)
end $$

|[f_movelogic]| function(player)
  local move = player.nextmove
  -- TODO: verify the resumes thing
  f_addaction(player, L_TRIGGER, player, (player.active.curmove and "resumes " or (move.func == f_move_multiturn and "begins " or "uses "))..c_move_names[move.num], function()
    -- TODO: how does metronome work with solar beam. would pp get deducted twice?
    move.pp_obj.pp = max(0, move.pp_obj.pp-1) -- needs a zero bounds check, because struggle could go negative without this.

    if (function() -- miss logic TODO: fix this to be in line with gen 2 logic. this was copied from gen 1 picodex
      if move.accuracy <= 0 then return false end -- swift/haze (-1) and status moves (0)

      -- -- charging moves & fly/dig can't miss on the first turn
      -- if (move.func == f_move_prepare or move.func == f_move_flydig) and not p_action_self_active.curmove then return false end

      -- -- p_action_self_active misses if p_action_other_active is using fly/dig
      -- if p_action_other_active.curmove and p_action_other_active.curmove.func == f_move_flydig then return true end

      -- -- p_action_self_active can't miss trapping moves if the first hit succeeded
      -- if p_action_self_active.curmove and p_action_self_active.curmove.func == f_move_trapping then return false end

      -- every move aimed at oppenent in pokemon stadium has a 1/65536 chance of a move missing, besides swift
      return rnd(f_stat_evac(p_action_other_active.stages['evasion'])) > move.accuracy/100*f_stat_evac(p_action_self_active.stages['accuracy']) or f_flr_rnd'256' == 0 and f_flr_rnd'256' == 0
    end)() then
      f_turn_addattack(player, "misses "..move.name)

      if f_in_split(move.num, 'M_HIGH_JUMP_KICK,M_JUMP_KICK') then
        -- TODO: 1/8 recoil of what it would have inflicted. TODO: Maybe I can modify this to 1/16 of health like leech seed. umm, that might be more damage. whatever maybe not
        f_moveutil_dmgself'1'
      end
    else
      if move:func(unpack(move.params)) then -- TODO: calc attack fail based on whether or not an action was added
        f_turn_addattack(player, "fails attack")
      end
    end

    -- explosion and selfdestruct self-inflict damage whether or not the attack hit the opponent.
    -- and this happens after the attack hits
    if f_in_split(move.num, 'M_EXPLOSION,M_SELFDESTRUCT') then -- TODO: maybe func could be checked? Might save tokens
      f_moveutil_dmgself(p_action_self_active.hp)
    end

    -- TODO: populate last move... OG picodex had this logic
    -- if move.accuracy ~= 0 then -- -1 is swift & haze. targeting moves
    --   p_action_other_active.lastmoverecv = move.num
    -- end
  end)

  f_addaction(player, L_TRIGGER, player, false, function()
    f_hurt_self("poison", 8, p_turn_self_active.major == C_MAJOR_POISONED)
    f_hurt_self("burn",   8, p_turn_self_active.major == C_MAJOR_BURNED)
    f_hurt_self("curse",  4, p_turn_self_active.cursed)
    f_hurt_self("dream",  4, p_turn_self_active.nightmare)
  end)
end $$

|[f_start_turn]| function()
  local x = function()
    if p_action_self.iscpu then
      local possible_moves = {}
      for i=1,4 do
        if p_action_self_active[i].num < M_NONE and p_action_self_active[i].pp_obj.pp > 0 then
          add(possible_moves, i)
        end
      end
      if #possible_moves > 0 then
        p_action_self.nextmove = p_action_self_active[possible_moves[f_flr_rnd(#possible_moves)+1]]
      else
        p_action_self.nextmove = c_moves[M_STRUGGLE]
      end
      f_movelogic(p_action_self)
    else
      -- umm, this may be a hack. i have "begins turn" again here, so the text doesn't change, but this action is immediately replaced by an action selection screen.
      f_addaction(p_action_self, L_PICK, p_action_self, "begins turn", function()
        f_pop_ui_stack()

        -- this is a quality of life thing. when switching and spamming x, i never wanted to switch 2 times in a row. most commonly you just want to fight right after.
        f_setsel('g_grid_battle_select', 0)

        if p_action_self == p_battle_bot then
          g_grid_battle_select.g_cg_m.sel   = S_P1_BATACTION
          g_grid_statbattle.g_cg_m.sel      = S_P1_BATSTAT
          g_grid_battle_movesel.g_cg_m.sel  = S_P1_MOVE
          g_grid_battle_select.g_cg_m.view  = S_P1_BATACTION+1
          g_grid_statbattle.g_cg_m.view     = S_P1_BATSTAT+1
          g_grid_battle_movesel.g_cg_m.view = S_P1_MOVE+1
        else
          g_grid_battle_select.g_cg_m.sel   = S_P2_BATACTION
          g_grid_statbattle.g_cg_m.sel      = S_P2_BATSTAT
          g_grid_battle_movesel.g_cg_m.sel  = S_P2_MOVE
          g_grid_battle_select.g_cg_m.view  = S_P2_BATACTION+1
          g_grid_statbattle.g_cg_m.view     = S_P2_BATSTAT+1
          g_grid_battle_movesel.g_cg_m.view = S_P2_MOVE+1
        end

        f_add_to_ui_stack(g_grid_battle_select)
      end, true)
    end
  end

  f_set_both_players([[p_first,@, p_last,@]], p_battle_bot)

  f_addaction(p_battle_bot, L_PICK, p_battle_bot, not p_battle_bot.iscpu and "begins turn", x, true)
  f_addaction(p_battle_top, L_PICK, p_battle_top, not p_battle_top.iscpu and "begins turn", x, true)

  -- calculate priorities. this just has to be on 1 of the 2 players so it gets executed.
  f_addaction(p_battle_bot, L_PRIORITY, p_battle_bot, false, function()
    f_set_player_priority(p_battle_bot)
    f_set_player_priority(p_battle_top)

    -- if priorities are equal, then coin flip!
    if p_battle_bot.priority == p_battle_top.priority then p_battle_top.priority += sgn(rnd'2'-1) end
    f_set_both_players([[p_first,@, p_last,@]], p_battle_bot.priority > p_battle_top.priority and p_battle_bot or p_battle_top)

    -- f_s_bataction()
  end)
end $$

|[f_start_battle]| function(p1winfunc, ...)
  p_battle_bot, p_battle_top = f_create_player("playr", f_team_party(@S_TEAM1), c_team_names[@S_TEAM1], P_MALETRNR+@S_TEAM1%2, @S_TEAM1 > 1), f_create_player("enemy", ...)
  f_set_both_players([[p_first,@, p_last,@]], p_battle_bot) -- without this line, the initial sending pkmn out part doesn't work.
  g_p1_winfunc = p1winfunc

  f_set_both_players([[p_action_self,@, p_action_other,@, p_action_self_active,@, p_action_other_active,@]], p_battle_bot)
  memset(S_P1_BATACTION, 0, 12) -- resets battle ui to zeros

  f_addaction(p_battle_bot, L_PICK, p_battle_bot, "begins battle", f_nop, true)
  add(p_battle_bot.actions, f_pkmn_comes_out(p_battle_bot, p_battle_bot.active.spot, L_PICK))

  f_addaction(p_battle_top, L_PICK, p_battle_top, "begins battle", f_nop, true)
  add(p_battle_top.actions, f_pkmn_comes_out(p_battle_top, p_battle_top.active.spot, L_PICK))

  -- the normal action grid has an init function which is called immediately.
  -- this adds a special first action which is the same as a normal action but with no init function.
  -- this could also be solved by creating an initial empty action. TODO: experiment with which can save more tokens.
  f_add_to_ui_stack(g_grid_battle_firstaction)

  f_s_bataction() -- call once, because need to pop the first action!
end $$
