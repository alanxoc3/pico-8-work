-- every state change will clean up all the entities.
|[f_game_state_init]| function(state)
    if state.mysfx then f_minisfx(state.mysfx) end
    state:sinit()
end $$

function _update60()
    local _ENV = _g
    g_bpo, g_bpx, g_bph, g_bpv = btnp'4', btnp'5', btnp'0' and btnp'1' and 0 or btnp'0' and -1 or btnp'1' and 1 or 0, btnp'2' and btnp'3' and 0 or btnp'2' and -1 or btnp'3' and 1 or 0

    if @S_SWAP_CONTROLS == 1 then
        g_bpo, g_bpx = g_bpx, g_bpo
    end

    g_picodex:f_actor_state()

    -- you can set the music speed with this
    -- poke(0x4055, 96)
    if g_cur_sound then
        -- returns nothing, so sets to nil
        g_cur_sound = f_minisfx_now(g_cur_sound)
    end
end

function _draw()
    local _ENV = _g
    g_picodex:draw()
end

-------------------------------------------------------
-- BELOW IS INIT LOGIC. NOT IN FUNCTION TO SAVE TOKENS!
-------------------------------------------------------

|[c_types]| f_zobj[[ -- 0 to 17 are all tables
  0;# ;;# ;;# ;;# ;;# ;;# ;;# ;;# ;;#
  ;;# ;;# ;;# ;;# ;;# ;;# ;;# ;;# ;;#
]] $$

|[c_trainers]| f_zobj[[]] $$

local _ENV = _g -- todo: this can be removed i think

-- clear all the read only memory. testing things out showed that this doesn't get cleared automatically.
memset(0x8000, 0, 0x7fff)

f_zcall(poke, [[
   ;,0x5f5c, 8 -- set btn initial delay before repeating. 255 means never repeat.
  ;;,0x5f5d, 1 -- set btn repeating delay.
]]) -- TODO: I could do something really hacky if I need to save 4 tokens... Combine this with the memcpy below and find a spot with a "1" and "8". Love it...

-- TODO: replace peeks with peek_inc, save tokens.

-- unpack all sprites
f_zcall(memcpy, [[;,0x8000, L_SPRITES, 0x2000]])

for i=0,323 do -- 18*18 = 324 (18 types)
  c_types[i\18][i%18] = peek(L_TYPECHART+i)\2
end

-- at the end of picodex development, i stored half the trainers in code. half are stored in cartridge data.
for i=0,56 do
    c_trainers[i] = {name=c_trainer_names[i]}
    for j=0,5 do
        add(c_trainers[i], peek(L_TRAINER+i*8+j))
    end
    c_trainers[i].item = peek(L_TRAINER+i*8+6)
    c_trainers[i].move = peek(L_TRAINER+i*8+7)
end
