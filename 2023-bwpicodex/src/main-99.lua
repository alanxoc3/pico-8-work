-- TODO: dedup this if it's only used once and maybe try a btnp(i) approach instead (for loop)
|[_update]| function()
  -- printh(stat'0') -- check memory
  if t() >= 1.5 then
    if g_title_timer == 0 then
      f_minisfx(SFX_LEAVE)
    end
    g_title_timer = min(C_TITLETIMER, (g_title_timer+1))
  end
  g_preview_timer = max(0, g_preview_timer-1)

  g_top_grid_cont = g_gridstack[#g_gridstack]
  g_top_grid = g_top_grid_cont.obj
  gridpofunc = g_top_grid.gridpofunc
  params     = g_top_grid.params

  if g_top_grid_cont.init_func then
    g_top_grid_cont.init_func()
    g_top_grid_cont.init_func = nil
    g_top_grid.op, g_top_grid.preview_op, g_top_grid.lrlist = {}, {}, {}
    gridpofunc(g_top_grid, unpack(g_top_grid.params))
  end

  -- needs to go after if statement, because if statement populates op.
  gridpo     = g_top_grid.op
  g_cg_m     = g_top_grid.g_cg_m -- TODO: refactor/simplify. maybe dont need all these variables. do what is less tokens
  g_cg_s     = g_top_grid.g_cg_s

  grid_previewop = g_top_grid.preview_op

  if g_title_timer == C_TITLETIMER then
    f_update_grid(g_cg_m, gridpo)
  end
end $$

-- TODO: Make an "on-shake" part of the player logic. And maybe make it so you can't select or lr when
sfx'63' -- Plays all the 4 sound effects in picodex as the logo/startup tune.
g_shake_timer = 0
|[_draw]| function() -- since there is very minimal animation, doing 30fps. this gives me cpu so i can make some things slower to save tokens.
  cls'C_1'
  if g_title_timer < C_TITLETIMER then
    print"\^j47\|e\f3alanxoc3\n\^j4a\|9\f2presents"
    for i=1,6 do
      if .5 << i & btn() > 0 then
        g_palette = i
      end
    end
  end

  local var = 1-min(C_TITLETIMER, g_title_timer)/C_TITLETIMER
  local easing = var*var
  if g_cg_m then
    f_draw_grid(g_cg_m, gridpo, @g_cg_m.sel, @g_cg_m.view, g_cg_m.x, g_cg_m.y+easing*24, true)
    f_draw_grid(g_cg_s, #grid_previewop > 0 and grid_previewop or {{draw=g_cg_s.df}},   -1,          0,               g_cg_s.x, g_cg_s.y-easing*45)
  end

  pal(c_palettes[g_palette],1)
  g_shake_timer = (g_shake_timer+1) % 4
end $$
