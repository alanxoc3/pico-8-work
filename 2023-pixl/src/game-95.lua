-- BASIC EXAMPLE FOR SIMPLE GAME BELOW:
-- I need an object that has a list of pixels that can be applied to the screen.
-- i need to easily create a pixel list object

|[f_game_init]| function(_ENV)
    ball = f_create_pixelgroup(8, 8)
    ball:set(3,3,13)
    ball.update = f_ball_update
end $$

|[f_draw_pixelgroup]| function(_ENV)
    -- todo: wrapping and maybe centering?
    for yy=0,31 do
        for xx=0,31 do
            if _ENV[yy] and _ENV[yy][xx] then
                pset((xx+x), (yy+y), _ENV[yy][xx])
            end
        end
    end
end $$

|[f_pixelgroup_set_pixel]| function(_ENV, x, y, c)
    -- TODO: wrapping
    if not _ENV[y] then _ENV[y] = {} end
    _ENV[y][x] = c
end $$

|[f_ball_update]| function(_ENV)
    x += f_xbtn()*.5
    y += f_ybtn()*.5
end $$

|[f_create_pixelgroup]| function(x, y)
    local group = f_zclass[[
        draw, ~f_draw_pixelgroup,
        set,  ~f_pixelgroup_set_pixel
    ]]
    group.x = x
    group.y = y
    return group
end $$

|[f_game_update]| function(_ENV)
    ball:state()
end $$

|[f_game_draw]| function(_ENV)
    poke(0x5f55, 0x00) clip(0,0,32,32) cls(0) -- screen is spritesheet, so drawing operations happen there
    -- BEGIN DRAWING OPERATIONS

    ball:draw()
    pset(8+t(),4,9)
    rect(0,0,31,31,9)

    -- END DRAWING OPERATIONS
    clip() poke(0x5f55, 0x60) -- screen is the actual screen
    sspr(0,0,32,32, 0,0,128,128)
end $$

|[f_zbtn]| function(f, a) return f(a) and f(a+1) and 0 or f(a) and -1 or f(a+1) and 1 or 0 end $$
|[f_xbtn]| function()     return f_zbtn(btn, 0) end $$
|[f_ybtn]| function()     return f_zbtn(btn, 2) end $$

|[f_draw]| function(callback)
end $$
