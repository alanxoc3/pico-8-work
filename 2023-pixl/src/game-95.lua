-- BASIC EXAMPLE FOR SIMPLE GAME BELOW:

|[f_test_init]|   function(_ENV) col += 1                  end $$
|[f_test_update]| function(_ENV) x += f_xbtn() y += f_ybtn() end $$
|[f_test_draw]|   function(_ENV) circfill(x, y, 2, col)    end $$

|[f_game_init]| function(_ENV)
    ball = f_zclass[[
        x,      64,
        y,      64,
        col,    7,
        init,   ~f_test_init,
        update, ~f_test_update,
        draw,   ~f_test_draw;
    ]]
end $$

|[f_game_update]| function(_ENV)
    ball:f_zclass_state()
end $$

|[f_game_draw]| function(_ENV)
    cls()
    -- rect(0, 0, 127, 127, 8)
    -- In this game, objects draw to the sprite sheet. So displaying the game is just a sspr call.
    sspr(0,0,32,32, 0,0,128,128)
    --ball:draw()
end $$

|[f_zbtn]| function(f, a) return f(a) and f(a+1) and 0 or f(a) and -1 or f(a+1) and 1 or 0 end $$
|[f_xbtn]| function()     return f_zbtn(btn, 0) end $$
|[f_ybtn]| function()     return f_zbtn(btn, 2) end $$

-- |[f_draw_rectkjk
