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
|[_update]| function()
  -- printh(stat(0)) -- TODO: remove?
  if t() >= 1.5 then
    if g_title_timer == 0 then
      f_minisfx(SFX_LEAVE)
    end
    g_title_timer = min(C_TITLETIMER, (g_title_timer+1))
  end
  g_preview_timer = max(0, g_preview_timer-1)
  top_grid = g_gridstack[#g_gridstack]
  g_cg_m     = top_grid.g_cg_m -- TODO: refactor/simplify. maybe dont need all these variables. do what is less tokens
  g_cg_s     = top_grid.g_cg_s
  gridpofunc = top_grid.gridpofunc
  params     = top_grid.params
  gridpo     = top_grid.op
  grid_previewop = top_grid.preview_op

  if g_title_timer == C_TITLETIMER then
    f_update_grid(g_cg_m, gridpo, top_grid)
  end
end $$

-- TODO: Bring back the on-logo palette change.
-- TODO: Make an "on-shake" part of the player logic. And maybe make it so you can't select or lr when
sfx'63' -- Plays all the 4 sound effects in picodex as the logo/startup tune.
g_shake_timer = 0
|[_draw]| function() -- since there is very minimal animation, doing 30fps. this gives me cpu so i can make some things slower to save tokens.
  cls'C_1'

  if g_title_timer < C_TITLETIMER then
    print("\^y7\f4aLANxOC3\n\f3pRESENTS", 16, 26)
    for i=1,6 do
      if .5 << i & btn() > 0 then
        g_palette = i
      end
    end
  end

  local var = 1-min(C_TITLETIMER, g_title_timer)/C_TITLETIMER
  local easing = var*var
  if g_cg_m then
    f_draw_grid(g_cg_m, gridpo, g_cg_m.sel, g_cg_m.view, g_cg_m.x, g_cg_m.y+easing*24, true)
    f_draw_grid(g_cg_s, #grid_previewop > 0 and grid_previewop or {{draw=g_cg_s.df}},   -1,          0,               g_cg_s.x, g_cg_s.y-easing*45)
  end

  pal(c_palettes[g_palette],1)
  g_shake_timer = (g_shake_timer+1) % 4
end $$
