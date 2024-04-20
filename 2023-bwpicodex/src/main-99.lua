------------------------------------------------------
-- GLOBALS USED IN INIT
-------------------------------------------------------
-- No, missingno should be 252, then i don't have to do a weird thing for horde mode. And zero should be empty. Also don't have to shift everything in the sprite sheet.

-- pVp cVc pVc league horde
-- pLR1 pLR2 cPU1 cPU2
-- league turns into horde when you beat it.
-- pvp can customize to cpu

-- Turn a string into a question marks with the same length
|[f_strtoq]| function(s)
  local ns = ""
  for i=1,#s do ns ..= "?" end
  return ns
end $$

-- d_browse = {}
-- for i=0,251 do add(d_browse, f_create_cell(true)) end

-- TODO: check if this already exists?
|[f_nf]| function() end $$

-- todo: only used in dp_edit so far
|[f_loop_through_team_pkmn]| function(party_num, callback)
  for ii=0,5 do
    local party_loc = S_PARTY1+party_num*42
    local pkmn_ind = @(party_loc+ii*7)
    callback(g_lock_pokemon[pkmn_ind] and pkmn_ind, ii)
  end
end $$

-- TODO: It would be fun to be able to customize pkmn colors.
g_palettes = { -- todo: can this go in cartridge data?
  --   bg1 bg2 mg  fg1 fg2   5,   6,  7,  8,  9, 10, 11, 12, 13, 14, 15
--   {[0]=  1,129, 13,  6,  7,139, 141, 14,  6,143,142, 12,  9,  8,  4,  5}, -- default
--   {[0]=131,129,  3, 11, 10,139, 141, 14,  6,143,142, 12,  9,  8,  4,  5}, -- green
--   {[0]=129,  1,140, 12,  6,139, 141, 14,  6,143,142, 12,  9,  8,  4,  5}, -- blues
--   {[0]=8,    0, 10,136,  9,139, 141, 14,  6,143,142, 12,  9,  8,  4,  5}, -- hotdog
--   {[0]=7,    6,  0,134,  5,139, 141, 14,  6,143,  2, 12,  1,  8,  4,  5}, -- invert
--   {[0]=128,130,141,134,135,139, 141, 14,  6,143,142, 12,  9,  8,  4,  5}, -- purple yel

  {[0]=  1,129, 13,  6,  7, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6}, -- default
  {[0]=131,129,  3, 11, 10, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6}, -- green
  {[0]=129,  1,140, 12,  6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6}, -- blues
  {[0]=8,    0, 10,136,  9, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6}, -- hotdog
  {[0]=7,    6,  0,134,  5, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6}, -- invert
  {[0]=128,130,141,134,135, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6}, -- purple yel
}
g_palette = 0
g_gridstack = {g_grid_title}
g_preview_timer = 0
g_title_timer = 0
g_title_l = 254
g_title_r = 254
g_title_an_timer = 70 -- starts at 70, so both are centered and not shaking. TODO: try setting with better syntax

-- TODO: dedup this if it's only used once
function bitmaskToIndex(bitmask)
  for i = 0, 5 do
    if bitmask & (1 << i) ~= 0 then
      return i
    end
  end
  return nil -- Return -1 if no bits are set
end

|[_update60]| function()
  g_title_timer = min(80, (g_title_timer+1))
  g_preview_timer = max(0, g_preview_timer-1)
  g_cg_m, g_cg_s, gridpo, params = unpack(g_gridstack[#g_gridstack])
  gridpo = gridpo(unpack(params)) -- TODO: Maybe I shouldn't be calling this every frame and instead only on adds.

  if g_title_timer == 80 then
    g_cg_m.updatefunc() -- This is used for the title animation and maybe other animations. TODO: Refactor me.
    g_cg_s.updatefunc() -- This is used for the title animation and maybe other animations. TODO: Refactor me.
    f_update_grid(g_cg_m, gridpo)
  elseif g_title_timer < 80 then
    local b = bitmaskToIndex(btnp())
    if b then
      g_palette = b
    end
  end
end $$

|[_draw]| function()
  cls'C_0'

  if g_title_timer < 80 then
    print("\^y7\f4aLANxOC3\n\-d \f2pRESENTS",  32-4*4, 32-6)
  end

  local easing = sin(max(60, g_title_timer)/80)
  f_draw_grid(g_cg_m, gridpo, @g_cg_m.mem, @g_cg_m.memview, g_cg_m.x, g_cg_m.y+easing*20, true)
  f_draw_grid(g_cg_s, {{}},   -1,          0,               g_cg_s.x, g_cg_s.y-easing*45)

  pal(g_palettes[g_palette+1],1)
end $$
