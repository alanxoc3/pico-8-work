|[f_get_party_pkmn]| function(party_num, pkmn_num)
  local num_loc = S_PARTY1+party_num*48+pkmn_num*8
  local pkmn_num = @num_loc%C_LEN_PKMN
  local pkmn = setmetatable(f_zobj([[num,@, edit_moves,#, view_moves,#, seen_moves,#]], pkmn_num), {__index=c_pokemon[pkmn_num]})
  if pkmn_num > 0 then
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
  return pkmn
end $$

|[f_save_party_pkmn]| function(_ENV, party_num, pkmn_num)
  local num_loc = S_PARTY1+party_num*48+pkmn_num*8
  poke(num_loc, num)
  poke(num_loc+1, gender_bit)
  poke(num_loc+2, item)
  poke(num_loc+3, level-1)
  poke(num_loc+4, edit_moves[1])
  poke(num_loc+5, edit_moves[2])
  poke(num_loc+6, edit_moves[3])
  poke(num_loc+7, edit_moves[4])
end $$
