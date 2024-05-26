-- this is a battle team

  -- TODO: consolidate edit/view/seen moves. I can't deal with so many move structures.
  -- TODO: do I need layers of pokemon, like I did in the og picodex.

  -- pkmn.gender_bit = pkmn_num
  -- pkmn.item = pkmn.default_item
  -- todo: moves could change as you unlock them. so all 3s might not be the best approach. or at least i should call getparty then saveparty

|[f_mkpkmn]| function(ind, respect_locks, gender_bit, item, ...)
  local pkmn = f_zobj([[
    num,@, gender_bit,@, item,@, valid,@,
    seen_moves, #,            -- A move to boolean map that is used to disable things on the move edit screen and populate edit_moves.
    major,      C_MAJOR_NONE, -- The major status condition in pokemon battles: fainted, burned, frozen, paralyzed, poisoned, sleeping
    gender,     0,            -- This gets populated from gender bit & pkmn.genders. TODO: this line could be removed if pressed for compression!
    evasion,    1,
    accuracy,   1,
    crit,       1;

    stages;
      attack,         0,
      defense,        0,
      specialattack,  0,
      specialdefense, 0,
      speed,          0,
      crit,           0,
      evasion,        0,
      accuracy,       0; -- TODO: delete the semicolon
  ]], ind, gender_bit, item % C_LEN_ITEMS, ind < P_NONE)
  pkmn = setmetatable(pkmn, {__index=c_pokemon[ind]}) -- none is set too.
  pkmn.gender     = pkmn.genders[pkmn.gender_bit%#pkmn.genders+1]

  local moves = {...}
  for i=1,4 do -- yes, there is some weird number logic here because I want to use modulo but index starts at 1.
    local move = mid(1, moves[i], #pkmn.possible_moves)
    while pkmn.seen_moves[move] or respect_locks and not c_moves[pkmn.possible_moves[move]].lock do
      move = move%#pkmn.possible_moves+1
    end

    pkmn.seen_moves[move] = true
    pkmn[i] = {id=pkmn.possible_moves[move], pid=move}
  end

  return pkmn
end $$

|[f_team_party]| function(party_num)
  local team = {}
  for spot_num=0,5 do
    add(team, f_get_party_pkmn(party_num, spot_num))
  end
  return team
end $$

|[f_team_league]| function(trainer_num)
  local team = {}
  local trainer = c_trainers[trainer_num]
  for pkmn_ind in all(trainer) do
    local last_move = 8
    local possible_moves = c_pokemon[pkmn_ind].possible_moves
    -- the "9" hear means: skip 1-4 empty move slots. 5,6,7 are the first 3 moves. 8 is the last move, which we want to check if we overwrite
    for i=9,#possible_moves do
      if possible_moves[i] == trainer.move then
        last_move = i
        break
      end
    end
    add(team, f_mkpkmn(pkmn_ind, false, 1, c_pokemon[pkmn_ind].default_item, 5, 6, 7, last_move))
  end

  return team
end $$

|[f_get_party_pkmn]| function(party_num, spot_num)
  local num_loc = S_PARTY1+party_num*42+spot_num*7
  local pkmn_num = min(P_NONE, @num_loc)
  if pkmn_num < P_NONE and not c_pokemon[pkmn_num].lock then pkmn_num = P_NONE end
  local pkmn = f_mkpkmn(pkmn_num, true, @(num_loc+1), @(num_loc+2), @(num_loc+3), @(num_loc+4), @(num_loc+5), @(num_loc+6))
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
