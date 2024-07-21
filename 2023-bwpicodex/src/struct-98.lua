-- this is a battle team
-- https://www.dragonflycave.com/mechanics/stat-stages

  -- TODO: consolidate edit/view/seen moves. I can't deal with so many move structures.
  -- TODO: do I need layers of pokemon, like I did in the og picodex.

  -- pkmn.gender_bit = pkmn_num
  -- pkmn.item = pkmn.default_item
  -- todo: moves could change as you unlock them. so all 3s might not be the best approach. or at least i should call getparty then saveparty

|[f_mkpkmn]| function(ind, base, respect_locks, gender_bit, item, ...)
  -- base is the parent table. at the start of a battle and when loading for edit, base is c_pokemon[ind].
  -- when a pokemon becomes active, it calls mkpkmn with base being the bench/initial battle stats.
  -- hp/item/major changes must happen on "base"

  -- TODO: do i need base? Maybe? not actually using it as of 2024-07-16
  local pkmn = f_zobj_setmeta(base, [[
    num,@, base,@, gender_bit,@, item,@, valid,@,
    seen_moves, #,            -- A move to boolean map that is used to disable things on the move edit screen and populate edit_moves.
    major,      C_MAJOR_NONE, -- The major status condition in pokemon battles: fainted, burned, frozen, paralyzed, poisoned, sleeping
    gender,     0,            -- This gets populated from gender bit & pkmn.gender_mask. TODO: this line could be removed if pressed for compression!
    substitute, 0, -- substitute hp
    evasion,    100,
    accuracy,   100,
    crit,       1,
    numtimes,   0; -- this gets reset each turn, probably all these should go together

    stages;
      attack,         0,
      defense,        0,
      specialattack,  0,
      specialdefense, 0,
      speed,          0,
      crit,           0,
      evasion,        0,
      accuracy,       0; -- TODO: delete the semicolon
  ]], ind, base, gender_bit, item % C_LEN_ITEMS, ind < P_NONE)
  pkmn.gender = pkmn.gender_mask

  -- Using local variable for gender_bit to save a token, though maybe i could just set _ENV here, idk.
  if gender_bit and pkmn.gender_mask == G_BOTH then
    pkmn.gender = gender_bit%2+1 -- 1
  end

  local moves = {...}
  for i=1,4 do -- yes, there is some weird number logic here because I want to use modulo but index starts at 1.
    local move = mid(1, moves[i], #pkmn.possible_moves)
    while pkmn.seen_moves[move] or respect_locks and not c_moves[pkmn.possible_moves[move]].lock do
      move = move%#pkmn.possible_moves+1
    end

    pkmn.seen_moves[move] = true
    local num = pkmn.possible_moves[move]
    pkmn[i] = f_zobj_setmeta(c_moves[num], [[num,@, pid,@]], num, move)
  end
  pkmn[0] = f_zobj_setmeta(c_moves[M_STRUGGLE], [[num,M_STRUGGLE, pid,1]])

  return pkmn
end $$

|[f_team_party]| function(party_num)
  local team = {fill_ind=7, trainer={}}
  for spot_num=0,5 do
    add(team, f_get_party_pkmn(party_num, spot_num))
  end
  return team
end $$

-- this gets called to populate a trainer and when a pokemon dies (for horde mode).
|[f_fill_team]| function(team, spot) -- TODO: use _ENV syntax
  local pkmn_ind = team.trainer[team.fill_ind]
  if pkmn_ind then
    local last_move = 8
    local possible_moves = c_pokemon[pkmn_ind].possible_moves
    -- the "9" hear means: skip 1-4 empty move slots. 5,6,7 are the first 3 moves. 8 is the last move, which we want to check if we overwrite
    for i=9,#possible_moves do
      if possible_moves[i] == team.trainer.move then
        last_move = i
        break
      end
    end
    team[spot] = f_mkpkmn(pkmn_ind, c_pokemon[pkmn_ind], false, team.trainer.num, c_pokemon[pkmn_ind].default_item, 5, 6, 7, last_move)
    team.fill_ind += 1
  end
end $$

|[f_team_league]| function(trainer_num, fill_ind)
  local team = {fill_ind=fill_ind, trainer=c_trainers[trainer_num]}
  for i=1,6 do
    f_fill_team(team, i)
  end
  return team
end $$

|[f_get_party_pkmn]| function(party_num, spot_num)
  local num_loc = S_PARTY1+party_num*42+spot_num*7
  local pkmn_num = min(P_NONE, @num_loc)
  if pkmn_num < P_NONE and not c_pokemon[pkmn_num].lock then pkmn_num = P_NONE end
  local pkmn = f_mkpkmn(pkmn_num, c_pokemon[pkmn_num], true, @(num_loc+1), @(num_loc+2), @(num_loc+3), @(num_loc+4), @(num_loc+5), @(num_loc+6))
  f_save_party_pkmn(pkmn, party_num, spot_num)
  return pkmn
end $$

|[f_save_party_pkmn]| function(_ENV, party_num, spot_num)
  local num_loc = S_PARTY1+party_num*42+spot_num*7
  poke(num_loc, num)
  poke(num_loc+1, gender_bit)
  poke(num_loc+2, item)
  poke(num_loc+3, _ENV[1].pid)
  poke(num_loc+4, _ENV[2].pid)
  poke(num_loc+5, _ENV[3].pid)
  poke(num_loc+6, _ENV[4].pid)
end $$

|[f_stat_crit]| function(crit)
  -- 0,0.0625 | 1,0.125 | 2,0.25 | 3,0.33333333333333 | 4,0.5 | 5,1 | 6,1
  -- used lagrange polynomial interpolation to get a function
  return mid(0, 1, .0095*crit^4 - .0746*crit^3 + .1883*crit^2 - .0607*crit + .0625)
end $$

-- TODO: implement brightpowder somewhere
-- if special and stat == 'evasion' and active.item == I_BRIGHTPOWDER then base *= 1.2 end
|[f_stat_evac]| function(stat)
  -- 3/3 | 3/5 | 3/6 | 3/7 | 3/8 | 3/9
  return mid(1, 1+stat/3, 3)/mid(1, 1-stat/3, 3)
end $$

-- Stat Stages Guide: https://www.dragonflycave.com/mechanics/stat-stages
-- IDEA: all stats could be normalized to a number between 0 and 1. technically, it looks like it doesn't really matter if its decimal or not. besides fixed point numbers of course.
|[f_stat_calc]| function(active, stat, special)
  local stage = active.stages[stat] or 0
  local base = active[stat]*mid(2, 2+stage, 8)/mid(2, 2-stage, 8) -- TODO: verify this is correct, copied from og picodex.

  if special then
    if stat == 'attack' and major == C_MAJOR_BURNED then base *= .5 end
    if stat == 'defense'        and active.reflected then base *= 2 end
    if stat == 'specialdefense' and active.screened  then base *= 2 end
    if stat == 'speed' then
      if major == C_MAJOR_PARALYZED then
        base *= .25
      end
      if active.item == I_QUICKCLAW and rnd() < .23 then
        base = 999
      end
    end
  end

  -- TODO: i might be able to remove the mid if i'm positive nothing can ever go over 999 or below 1. only if i'm really pressed on tokens.
  return mid(1, 999, base) -- all stats cap at 999, though evasion/accuracy wouldn't really get that high.
end $$
