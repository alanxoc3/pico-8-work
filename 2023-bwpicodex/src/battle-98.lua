-- Some globals that we manage in the battle:
-- p_1:            player 1: this is the bottom player on the UI. it never changes throughout the battle.
-- p_2:            player 2: this is the top    player on the UI. it never changes throughout the battle.
-- p_self:         this is the current highlighted player. also corresponds to the player who is currently running an action.
-- p_other:        this is the non highlighted player. also corresponds to the player who is currently running an action.
-- p_first:        this is the player who went first this turns. this changes before each turn starts and is unavailable during move selection.
-- p_last:         this is the player who went first this turns. this changes before each turn starts and is unavailable during move selection.
-- a_addaction:    this is a convenience function available to all action logic functions. adds an action to the current player's turn.
-- a_self_active:  a_self.active, convenience for action logic functions
-- a_other_active: a_other.active, convenience for action logic functions

-- Some player specific things

|[f_create_active]| function(team, ind)
  return setmetatable(f_zobj([[
    spot,@,
    stages,#,
    base,@
  ]], ind, team[ind]), {__index=team[ind]})
end $$

|[f_create_player]| function(team, name, subname, iscpu)
  local active = nil -- active guaranteed to be set because we can't enter the battle without it.
  for i=1,6 do
    if team[i].valid then
      active = f_create_active(team, i)
      break
    end
  end

  return f_zobj([[
    active,@,         -- The single active pokemon.
    team,@,           -- The 1-6 benched pokemon.
    name,@,           -- The player's name (enemy/player...)
    subname,@,        -- The real team name (team1/lance...)
    iscpu,@,          -- Whether or not the player is a cpu
    turnover,~c_no,   -- Whether or not the player has executed its end-of-turn logic when actions are empty. TODO: this could be removed, here so i don't forget that it must be updated each turn
    actions,#,        -- Actions for the player.
    -- nextmove,~c_no -- 0-3 for a move index into the moveset. false value for switching. Commented out to save on compression, defaults to nil value
  ]], active, team, name, subname, iscpu)
end $$

|[f_get_other_pl]| function(player)
  return player == p_1 and p_2 or p_1
end $$

|[f_set_pself]| function(player)
  p_self, p_other = player, f_get_other_pl(player)
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
  f_set_pself(player)
  f_pop_ui_stack() -- battle scene TODO: convert to a zcall?
  f_pop_ui_stack() -- p_2 select scene
  f_pop_ui_stack() -- p_1 select scene
  f_add_to_ui_stack(g_grid_battle_results)
end $$

-- player cannot be nil, others can. the player turn is passed and the current active is extracted.
-- the current active is needed because if it dies, we want to skip over actions
-- if message is false/nil, the logic function is executed immediately, then the next action is executed
|[f_newaction]| function(player, message, logic)
  return f_zobj([[player,@, active,@, message,@, logic,@]], player, player.active, message, logic or f_nop)
end $$

-- adds an action to a player's turn
|[f_addaction]| function(player, ...)
  add(player.actions, f_newaction(...))
end $$

|[f_pkmn_comes_out]| function(player, spot) -- assumes that the pkmn coming is not nil.
  local pkmn = player.team[spot]

  -- need to copy each move just for mimic to work when switching

  -- TODO: i should combine this with f_mkpkmn. so all pkmn stuff is just in 1 place.
  player.active = setmetatable(f_zobj([[
    isactive,     ~c_yes, -- used for a drawing function, should draw fainted pokemon if they are not active, but not if they are active.
    lastmoverecv, 0,      -- last move targeted at user, for mirrormove
    moveturn,     0,      -- turn move is on. > 0, decrements each turn. 0, is the same. -1, is multiturn move that doesn't end (rage).
    invisible,    ~c_yes,

    -- conditions are all numbers ...
    counterdmg,    0, -- resets to zero each turn
    bidedmg,       0, -- resets to zero when using bide
    disabledtimer, 0, -- how long the disabled move should last
    confused,      0, -- for confusion, how long pkmn is confused
    sleeping,      @, -- for sleeping, how long pkmn is sleeping. must start at non-zero in case a pokemon is switched in
    substitute,    0, -- for substitute obviously
    toxiced,       0, -- how bad the toxic is

    -- curmove -- used for multiturn moves, if moveturn ~= 0, this must be set
    spot,@,
    base,@;

    stages;
      attack,         0,
      defense,        0,
      specialattack,  0,
      specialdefense, 0,
      speed,          0,
      crit,           0, -- TODO: rename crit
      evasion,        0,
      accuracy,       0; -- TODO: delete the semicolon
  ]], f_flr_rnd'7'+1, spot, pkmn), {__index=pkmn})
  -- ^^ hard-coding sleep timer here

  for i=1,4 do
    player.active[i] = pkmn[i]
  end

  return f_newaction(player, "enters fight", function()
    player.active.invisible = false
    return player.active.num
  end)
end $$

-- self player, other player
-- return faint action if ~c_no hp and not dead
-- return nothing if end of turn
|[f_pop_next_action]| function()
  -- if an active pokemon has no hp, but not the faint status yet, return an action that makes the pokemon faint.
  -- switch if there is a next pokemon
  -- otherwise, do nothing. turn logic will check every turn if there is a win condition
  for player in all{p_first,p_last} do -- TODO: try _ENV syntax here?
    if player.active.major == C_MAJOR_FAINTED then
      if not player.active.invisible then
        return f_newaction(player, "leaves fight", function()
          player.active.invisible = true
        end)
      else -- TODO: this is slightly diff logic than og picodex, check if there are any issues here
        return f_pkmn_comes_out(player, f_get_next_active(player)) -- TODO: is there a nil issue here?
      end
    end
  end

  for player in all{p_first,p_last} do
    local other = f_get_other_pl(player) -- TODO: i think i can move this below. only 1 usage

    -- if the active pokemon shouldn't faint right now, find the next action that references a pokemon still on the field.
    while #player.actions > 0 do
      local action = deli(player.actions, 1)
      if action.active.major ~= C_MAJOR_FAINTED and (action.active == player.active or action.active == other.active) then
        return action
      end
    end

    -- for explosion, you should finish the turn before switching in your pokemon
    if player.active.hp <= 0 and player.active.major == C_MAJOR_FAINTED then
      return f_pkmn_comes_out(player, f_get_next_active(player.team))
    end

    if not player.turnover then
      player.turnover = true
      return f_postmove_logic(player)
    end
  end

  -- TODO: add turn ending things (futuresight, etc)
end $$

|[f_postmove_logic]| function(self) -- TODO: this is only used once, the function could go away.
  return f_newaction(self, false, function()
    -- flinching is reset at the psel init level, so you can't be flinching the next turn. no need to reset flinching here.
    -- counterdmg is also reset at psel init level.

    -- TODO: change/remove this comment vvvvv. from old picodex
    -- reset moveturn if you sleep or are frozen. this is done at end of the turn to prevent weird cases (you freeze then unfreeze same turn).
    -- if you are using rage and freeze then unfreeze in the same turn, you continue your rage.
    -- if opponent is slower, then dies from leech/psn/brn, the trapper could lose a turn
    -- but that's just a super edge case, so i don't care about changing it
    local statdmg = max(a_self_active.maxhp\16,1) -- TODO: if I really need it to save tokens, I could remove the max, because all pokemon have > 16 max hp.
    local inflictstatdmg = function(title) -- title must start with "|" to save 2 tokens
      f_addaction(self, title.." damage")
      f_move_setdmg_self(_ENV, statdmg)
    end

    if a_self_active.major == C_MAJOR_POISONED then
      if a_self_active.toxiced > 0 then
        statdmg *= a_self_active.toxiced
        a_self_active.toxiced += 1
      end
      inflictstatdmg"poison"
    end
  end)
end $$

-- TODO: I'M HERE.
|[f_set_player_priority]| function(player)
  local priority_class = C_PRIORITY_ATTACK
  local movenum = player.nextmove and player.nextmove.num
  if movenum then
    printh("M: "..movenum)
  end
  local other = f_get_other_pl(player)

  -- TODO: in picodex, I was calling f_premovelogic(player, move) here

  -- TODO: is there a good way to simplify tokens here?
  if not movenum                                                         then priority_class = C_PRIORITY_SWITCH
  elseif movenum == M_PURSUIT and not other.movenum                      then priority_class = C_PRIORITY_PURSUIT
  elseif f_in_split(movenum, 'M_WHIRLWIND,M_ROAR,M_TELEPORT')            then priority_class = C_PRIORITY_ROAR
  elseif f_in_split(movenum, 'M_QUICKATTACK,M_MACHPUNCH,M_EXTREMESPEED') then priority_class = C_PRIORITY_QUICKATTACK
  elseif f_in_split(movenum, 'M_COUNTER,M_MIRRORCOAT')                   then priority_class = C_PRIORITY_COUNTER
  elseif movenum == M_VITALTHROW                                         then priority_class = C_PRIORITY_VITALTHROW
  end -- TODO: ensure quickclaw is accounted for

  -- speed can be between 1 and 999, so multiples of 1000 can be priority
  -- highest priority goes first. if priority is same, roll a dice to decide
  -- speed can technically affect a switch/pursuit, but doesn't actually matter in that case.
  -- the og picodex had a min(C_PRIORITY_SWITCH, ...) here.
  player.priority = priority_class+f_stat_calc(player.active, 'speed', true)
end $$

|[f_turn_end_p2]| function()
  f_set_player_priority(p_1)
  f_set_player_priority(p_2)

  -- if priorities are equal, then coin flip!
  if p_1.priority == p_2.priority then p_2.priority += sgn(rnd'2'-1) end
  p_first = p_1.priority > p_2.priority and p_1 or p_2
  p_last  = f_get_other_pl(p_first)

  for player in all{p_first,p_last} do
    if player.nextmove then
      f_addaction(player, player, "uses "..c_move_names[player.nextmove.num], function()
        c_move_funcs[player.nextmove.num]()
      end)
    end
  end

  f_pop_ui_stack()
  f_s_bataction()
  f_add_to_ui_stack(g_grid_battle_actions)
end $$

|[f_turn_end_p1]| function()
  f_set_pself(p_2)
  if p_2.iscpu then
    local possible_moves = {}
    for i=1,4 do
      if p_2.active[i].num < M_NONE and p_2.active[i].pp > 0 then
        add(possible_moves, i)
      end
    end
    if #possible_moves > 0 then
      p_2.nextmove = p_2.active[f_flr_rnd(#possible_moves)+1]
    else
      p_2.nextmove = c_moves[M_STRUGGLE]
    end
    f_turn_end_p2()
  else
    f_pop_ui_stack()
    f_add_to_ui_stack(g_grid_battle_turnbeg)
  end
end $$

|[f_calc_movemod]| function(active, move)
  return 1
  -- movemod: must be <= 32 to prevent any possible number overflow
  --   rollout:    2^(n+d) -- n=times, d=defcurl and 1 or 0
  --   furycutter: 2^n     -- n=times
  --   rage:       num of times user damaged while using rage
  --   triplekick: 1, 2, then 3 for each kick
  --   pursuit:    2 -- if target is switching
  --   stomp:      2 -- if target minimized
  --   gust:       2 -- if target is flying
  --   twister:    2 -- if target is flying
  --   earthquake: 2 -- if target is digging
  --   magnitude:  2 -- if target is digging
  --   explosion:  2 -- always
  --   selfdstrct: 2 -- always
  --   payday:     3 -- if holding amulet coin
  --   rain:       1.5 -- if water pktype move is used during rain
  --   sun:        1.5 -- if solar beam or fire pktype move used during sunlight
  --   rain:       .5  -- if solar beam or fire pktype move used during rain
  --   sun:        .5  -- if water pktype move is used during sun
  --   else:       1 -- for every other scenario
end $$

|[f_get_type_advantage]| function(move, defender)
  return (c_types[move.pktype][defender.type1] or 1)*(c_types[move.pktype][defender.type2] or 1)
end $$

--   ((.44*power*att/def)*item*crit+2)*weather*stab*movemod*pktype*random
-- damage formula: https://bulbapedia.bulbagarden.net/wiki/Damage#Generation_II
|[f_calc_move_damage]| function(attacker, defender, move)
  -- BEGIN: PHYSICAL/SPECIAL
  local attack, defense = attacker:f_stat_calc('specialattack', true), defender:f_stat_calc('specialdefense', true)
  if move.pktype % 2 == 1 then -- iscontact
    attack, defense = attacker:f_stat_calc('attack', true), defender:f_stat_calc('defense', true)
  end

  -- BEGIN: CRIT
  -- TODO: really implement all the stuff here (focus energy, etc)
  local crit = rnd'1' < f_stat_crit(0) and 2 or 1
  local stab = (move.pktype == attacker.pktype1 or move.pktype == attacker.pktype2) and 1.5 or 1
  local itemdmg = 1 -- TODO: fill this out! item is 1.1 if move pktype equals item specialty for type boost items

  local base_damage = mid( -- min: .44*1*.2*1*1+2 = 2.088 | max: .44*999*10*1.1*2+2 = 9672.32
      1, 999,
      .44*move.pow
      *mid(10, .2, attack/defense) -- this .2 to 10 ratio range comes from the original picodex. it exists to bound minimum and maximum damages
      *itemdmg
      *crit+2
  )

  -- min: 1*1*.25 = .25 | max: 999*1.5*4 = 5994
  base_damage = mid(1, 999, base_damage*stab*f_get_type_advantage(move, defender))

  -- min: 1*1 = 1 | max: 999*32 = 31968
  base_damage = mid(1, 999, base_damage*f_calc_movemod(attacker, move)*(rnd'.15'+.85))

  return base_damage\1
end $$
