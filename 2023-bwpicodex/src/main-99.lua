-------------------------------------------------------
-- BELOW IS INIT LOGIC. NOT IN FUNCTION TO SAVE TOKENS!
-------------------------------------------------------

|[c_trainers]| f_zobj[[]] $$

local _ENV = _g -- todo: this can be removed i think

-- clear all the read only memory. testing things out showed that this doesn't get cleared automatically.
memset(0x8000, 0, 0x7fff)

f_zcall(poke, [[
   ;,0x5f5c, 8 -- set btn initial delay before repeating. 255 means never repeat.
  ;;,0x5f5d, 1 -- set btn repeating delay.
]]) -- TODO: I could do something really hacky if I need to save 4 tokens... Combine this with the memcpy below and find a spot with a "1" and "8". Love it...

-- TODO: replace peeks with peek_inc, save tokens.

-- unpack all sprites ... dont need to do this actually.
-- f_zcall(memcpy, [[;,0x8000, L_SPRITES, 0x2000]])

-- STEP 2: UNPACK TYPE CHART
|[c_types]| f_zobj[[ -- 0 to 17 are all tables
  0;, ;;, ;;, ;;, ;;, ;;, ;;, ;;, ;;,
  ;;, ;;, ;;, ;;, ;;, ;;, ;;, ;;, ;;,
]] $$

|[f_init_peek_inc]| function()
  g_init_peek_loc += 1
  return peek(g_init_peek_loc-1)
end $$

for i=0,323 do -- 18*18 = 324 (18 types)
  c_types[i\18][i%18] = f_init_peek_inc()\2
end

-- STEP 3: UNPACK PkMN
for i=0,251 do
  c_pokemon[i] = {}
  for key in all(split'prevolve,type1,type2,hp,att,def,spd,sat,sdf,gender_item') do
    c_pokemon[i][key] = f_init_peek_inc()
  end
end

-- STEP 4: UNPACK MOVES
for i=0,251 do
  c_moves[i] = {}
  for key in all(split'pow,type,acc,pp') do
    c_moves[i][key] = f_init_peek_inc()
  end
end

print("done") printh("done")
