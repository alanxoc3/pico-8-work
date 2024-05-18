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
    callback(c_pokemon[pkmn_ind].lock and pkmn_ind, ii)
  end
end $$

-- at one point, i was thinking pokemon could have colors, but I don't want that anymore.
  --   bg1 bg2 mg  fg1 fg2   5,   6,  7,  8,  9, 10, 11, 12, 13, 14, 15
--   {[0]=  1,129, 13,  6,  7,139, 141, 14,  6,143,142, 12,  9,  8,  4,  5}, -- default
--   {[0]=131,129,  3, 11, 10,139, 141, 14,  6,143,142, 12,  9,  8,  4,  5}, -- green
--   {[0]=129,  1,140, 12,  6,139, 141, 14,  6,143,142, 12,  9,  8,  4,  5}, -- blues
--   {[0]=8,    0, 10,136,  9,139, 141, 14,  6,143,142, 12,  9,  8,  4,  5}, -- hotdog
--   {[0]=7,    6,  0,134,  5,139, 141, 14,  6,143,  2, 12,  1,  8,  4,  5}, -- invert
--   {[0]=128,130,141,134,135,139, 141, 14,  6,143,142, 12,  9,  8,  4,  5}, -- purple yel

-- TODO: dedup this if it's only used once and maybe try a btnp(i) approach instead (for loop)
function bitmaskToIndex(bitmask)
  for i = 0, 5 do
    if bitmask & (1 << i) ~= 0 then
      return i
    end
  end
  return nil -- Return -1 if no bits are set
end

|[_update60]| function()
  -- printh(stat(0)) -- TODO: remove?
  g_title_timer = min(C_TITLETIMER, (g_title_timer+1))
  g_preview_timer = max(0, g_preview_timer-1)
  top_grid = g_gridstack[#g_gridstack]
  g_cg_m     = top_grid.g_cg_m -- TODO: refactor/simplify. maybe dont need all these variables. do what is less tokens
  g_cg_s     = top_grid.g_cg_s
  gridpofunc = top_grid.gridpofunc
  params     = top_grid.params
  gridpo     = top_grid.op

  if g_title_timer == C_TITLETIMER then
    f_update_grid(g_cg_m, gridpo, top_grid)

    if g_cg_m.name == 'g_grid_title' then
      g_title_an_timer = (g_title_an_timer+1)%300
      if     g_title_an_timer == 0   then g_title_r = rnd"252"\1
      elseif g_title_an_timer == 150 then g_title_l = rnd"252"\1
      elseif g_title_an_timer == 40  then f_minisfx(g_title_r-1)
      elseif g_title_an_timer == 190 then f_minisfx(g_title_l-1) end
    end
  elseif g_title_timer < C_TITLETIMER then
    local b = bitmaskToIndex(btnp())
    if b then
      g_palette = b
    end
  end
end $$

sfx'63' -- Plays all the 4 sound effects in picodex as the logo/startup tune.

|[_draw]| function()
  cls'C_1'

  if g_title_timer < C_TITLETIMER then
    print("\^y7\f4aLANxOC3\n\-d \f3pRESENTS",  32-4*4, 32-6)
  end

  local easing = sin(max(.75*C_TITLETIMER, g_title_timer)/C_TITLETIMER)
  if g_cg_m then
    f_draw_grid(g_cg_m, gridpo, g_cg_m.sel, g_cg_m.view, g_cg_m.x, g_cg_m.y+easing*20, true)
    f_draw_grid(g_cg_s, {{draw=g_cg_s.df}},   -1,          0,               g_cg_s.x, g_cg_s.y-easing*45)
  end

  pal(c_palettes[g_palette+1],1)
end $$
