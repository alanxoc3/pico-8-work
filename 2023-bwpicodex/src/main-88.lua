-- TODO: combine active and mkpkmn funcs.
-- TODO: remove some get_sel things with @SAVE_LOCATION syntax. Maybe I can remove all like that?

-- lemme think... when calling update_grid, what should the order be?
-- One idea:
-- 1. calc bounds
-- 2. seleave
--   1. call init
--   2. calc bound
-- 3. lrfunc
-- 4. vert/horiz movement

-- calculate grids only when a select/leave/move happens
-- benefits to putting preview_op in ui gridpofunc?
-- can reuse some preview_ops or whatever

-- TODO: dedup this if it's only used once and maybe try a btnp(i) approach instead (for loop)
|[_update]| function()
  --printh(stat'0') -- check memory
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
  g_cg_m     = g_top_grid.g_cg_m -- TODO: refactor/simplify. maybe dont need all these variables. do what is less tokens
  g_cg_s     = g_top_grid.g_cg_s

  if not g_grid_called_init then
    g_top_grid:init()
    g_grid_called_init = true
    g_top_grid.op, g_top_grid.preview_op, g_top_grid.lrlist = {}, {}, {}
    g_top_grid:gridpofunc()
  end

  -- needs to go after if statement, because if statement populates op.
  gridpo     = g_top_grid.op

  if g_title_timer == C_TITLETIMER then
    f_update_grid(g_cg_m, gridpo)
  end
end $$

-- TODO: Make an "on-shake" part of the player logic. And maybe make it so you can't select or lr when
|[_draw]| function() -- since there is very minimal animation, doing 30fps. this gives me cpu so i can make some things slower to save tokens.
  cls'C_1' -- TODO: I could maybe add a C_0 for the background. I had this before then got rid of it because I couldn't find enough colors. Maybe I could try again with the colors though.
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
  if g_top_grid then
    f_draw_grid(g_top_grid.g_cg_m, g_top_grid.op,         @g_top_grid.g_cg_m.sel, @g_top_grid.g_cg_m.view, g_top_grid.g_cg_m.x, g_top_grid.g_cg_m.y+easing*24, true)
    f_draw_grid(g_top_grid.g_cg_s, g_top_grid.preview_op, -1,                     0,                       g_top_grid.g_cg_s.x, g_top_grid.g_cg_s.y-easing*45)
  end

  pal(c_palettes[g_palette],1)
  g_shake_timer += 1 -- i don't care if this overflows. won't actually mess up the shaking.
end $$
