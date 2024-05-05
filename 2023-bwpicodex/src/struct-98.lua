|[f_get_default_pkmn]| function(pkmn_num)
  local pkmn = setmetatable(f_zobj([[num,@, edit_moves,#, view_moves,#, seen_moves,#]], pkmn_num), {__index=c_pokemon[pkmn_num]})

  pkmn.gender_bit = pkmn_num
  pkmn.item = pkmn.default_item
  pkmn.level = 50

  -- todo: moves could change as you unlock them. so all 3s might not be the best approach. or at least i should call getparty then saveparty
  pkmn.edit_moves = split[[3,3,3,3]] -- all 3s, because 0-2 are ___ empty moves for all pkmn. the get party function below will figure out 
  return pkmn
end $$

|[f_get_party_pkmn]| function(party_num, spot_num)
  local num_loc = S_PARTY1+party_num*48+spot_num*8
  local pkmn_num = min(P_NONE, @num_loc)
  if pkmn_num < P_NONE and not c_pokemon[pkmn_num].lock then pkmn_num = P_NONE end
  local pkmn = f_zobj[[level,50, edit_moves,#, view_moves,#, seen_moves,#]]
  pkmn = setmetatable(pkmn, {__index=c_pokemon[pkmn_num]}) -- none is set too.

  if pkmn_num < P_NONE then
    pkmn.valid = true
    -- if for some reason a locked pokemon is saved, try to find the next valid pkmn.
    -- while not c_pokemon[pkmn_num].lock do
    --   pkmn_num = (pkmn_num+1)%252
    -- end

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
      add(pkmn.edit_moves, move)
      add(pkmn.view_moves, pkmn.possible_moves[move+1])
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
  poke(num_loc+4, edit_moves[1])
  poke(num_loc+5, edit_moves[2])
  poke(num_loc+6, edit_moves[3])
  poke(num_loc+7, edit_moves[4])
end $$
