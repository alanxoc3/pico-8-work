|[f_create_grid]| function(name, ...)
  _g[name] = f_zobj([[
    numloc,@,
    w,@, len,@, vh,@,
    x,@, y,@,
    cw,@, ch,@,
    selbg,@, bg,@,
    df,@
  ]], ...)
end $$

|[f_update_grid]| function(grid)
  local h = @grid.numloc\grid.w*grid.w
  local viewloc = grid.numloc + 1

  if btnp'0' then poke(grid.numloc, max(h, @grid.numloc-1)) end
  if btnp'1' then poke(grid.numloc, min(h+grid.w-1, @grid.numloc+1)) end
  if btnp'2' then poke(grid.numloc, max(@grid.numloc%grid.w, @grid.numloc-grid.w)) end
  if btnp'3' then poke(grid.numloc, min(grid.len-grid.w+@grid.numloc%grid.w, @grid.numloc+grid.w)) end

  if @grid.numloc >= grid.len then poke(grid.numloc, grid.len-1) end

  if @grid.numloc\grid.w-grid.vh+1 > @viewloc then poke(viewloc, (@viewloc+1)%((grid.len-grid.vh+1)\grid.w)) end
  if @grid.numloc\grid.w           < @viewloc then poke(viewloc, (@viewloc-1)%((grid.len-grid.vh+1)\grid.w)) end
end $$

|[f_draw_grid]| function(grid)
  for j=0,grid.vh*grid.w-1 do
    local i = j + @(grid.numloc+1)*grid.w
    if i >= grid.len then return end
    local xloc, yloc = grid.x+i%grid.w*grid.cw, grid.y+j\grid.w*grid.ch
    camera(-xloc-1, -yloc-1)

    local l, r, u, d = 0, 0, 0, 0

    if i == 0                          then l = 1 u = 1 end
    if i == grid.w-1                   then r = 1 u = 1 end
    if i == grid.len-1                 then r = 1 d = 1 end
    if i == (grid.len-1)\grid.w*grid.w then l = 1 d = 1 end

    rectfill(-1+l, -1,   grid.cw-2-r, grid.ch-2,   i == @grid.numloc and grid.selbg or grid.bg)
    rectfill(-1,   -1+u, grid.cw-2,   grid.ch-2-d, i == @grid.numloc and grid.selbg or grid.bg)

    clip(xloc, yloc, grid.cw, grid.ch) -- camera goes in one, but clip doesn't. dont want to go in for the title screen animation
    grid.df(i, i == @grid.numloc)
    camera()
    clip()
  end
end $$
