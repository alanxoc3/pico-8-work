-- needs: moves, flags
|[f_get_default_pkmn]| function(pkmn_num)
  -- TODO: consolidate edit/view/seen moves. I can't deal with so many move structures.
  -- TODO: do I need layers of pokemon, like I did in the og picodex.
  local pkmn = f_zobj([[
    num, @,
    seen_moves, #,            -- A move to boolean map that is used to disable things on the move edit screen and populate edit_moves.
    major,      C_MAJOR_NONE, -- The major status condition in pokemon battles: fainted, burned, frozen, paralyzed, poisoned, sleeping

    gender_bit, 0,            -- The gender bit. This number is modded by the Pokemon's possible genders to figure out the gender. TODO: maybe this could be randomized
    gender,     0,            -- This gets populated from gender bit & pkmn.genders.

    level,      50,           -- The level is always 50. 50 is the only level in Picodex. TODO: This should be removed
    item,       I_NONE,       -- The item the Pokemon has
    evasion,    1,
    accuracy,   1,
    crit,       1;

    1; id,M_NONE, pid,3; -- start at 3 because there are usually 3 none spots
    2; id,M_NONE, pid,4; -- id: the actual move id. pid: the possible move id (local to pkmn)
    3; id,M_NONE, pid,5;
    4; id,M_NONE, pid,6;

    stages;
      attack,         0,
      defense,        0,
      specialattack,  0,
      specialdefense, 0,
      speed,          0,
      crit,           0,
      evasion,        0,
      accuracy,       0; -- TODO: delete the semicolon
  ]], pkmn_num)

  -- pkmn.gender_bit = pkmn_num
  -- pkmn.item = pkmn.default_item

  -- todo: moves could change as you unlock them. so all 3s might not be the best approach. or at least i should call getparty then saveparty
  return pkmn
end $$

|[f_get_party_pkmn]| function(party_num, spot_num)
  local num_loc = S_PARTY1+party_num*48+spot_num*8
  local pkmn_num = min(P_NONE, @num_loc)
  if pkmn_num < P_NONE and not c_pokemon[pkmn_num].lock then pkmn_num = P_NONE end
  local pkmn = f_get_default_pkmn(pkmn_num)
  pkmn = setmetatable(pkmn, {__index=c_pokemon[pkmn_num]}) -- none is set too.

  if pkmn_num < P_NONE then
    pkmn.moves = {}
    pkmn.valid = true
    pkmn.gender_bit = @(num_loc+1) -- this is how you should change the gender. just add 1
    pkmn.gender     = pkmn.genders[pkmn.gender_bit%#pkmn.genders+1]
    pkmn.item       = @(num_loc+2)%C_LEN_ITEMS
    pkmn.level      = @(num_loc+3)%C_LEN_LEVELS+1

    for i=4,7 do
      local move = @(num_loc+i)%#pkmn.possible_moves
      while pkmn.seen_moves[move] or not c_moves[pkmn.possible_moves[move+1]].lock do
        move = (move + 1)%#pkmn.possible_moves
      end

      pkmn.seen_moves[move] = true
      pkmn[i-3] = {id=pkmn.possible_moves[move+1], pid=move}
    end
  end

  -- saving in the get to ensure validity
  f_save_party_pkmn(pkmn, party_num, spot_num)
  return pkmn
end $$

|[f_save_party_pkmn]| function(_ENV, party_num, spot_num)
  local num_loc = S_PARTY1+party_num*48+spot_num*8
  poke(num_loc, num)
  poke(num_loc+1, gender_bit)
  poke(num_loc+2, item)
  poke(num_loc+3, level-1)
  poke(num_loc+4, _ENV[1].pid)
  poke(num_loc+5, _ENV[2].pid)
  poke(num_loc+6, _ENV[3].pid)
  poke(num_loc+7, _ENV[4].pid)
end $$
