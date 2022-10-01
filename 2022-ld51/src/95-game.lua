-- BASIC EXAMPLE FOR SIMPLE GAME BELOW:

g_bounds = zobj[[x,0, y,0, w,128, h,64, tx_off,0, ty_off,0]]

|[game_init]| function()
    _g.fader_in()
    g_pl = _g.panda(find_in_room(32))
    g_follow_panda = _g.follow_panda(g_pl)
end $$

|[game_update]| function()
    zcall(loop_entities, [[
        1 ;,timer,       tick;
        2 ;,actor,       state;
        3 ;,mov,         mov_update;
        4 ;,tcol,        coll_tile, @;
        5 ;,collidable,  adjust_deltas_for_tiles;
        6 ;,vec,         vec_update;
    ]], function(x, y)
         return x >= g_bounds.x and x < g_bounds.w and
                y >= g_bounds.y and y < g_bounds.h and
                fget(mget(g_bounds.tx_off+x, g_bounds.ty_off+y), 0)
      end)
end $$

|[game_draw]| function()
    local camera_x = max(g_bounds.x, min((g_bounds.w-8)*8, g_pl.x*8-32))
    local camera_y = max(g_bounds.y, min((g_bounds.h-8)*8, g_follow_panda.y*8-32))

    camera(camera_x, camera_y)
    rect(0, 0, 63, 63, 8)

    map(g_bounds.tx_off, g_bounds.ty_off, 0, 0, g_bounds.w, g_bounds.h, 0x80)
    loop_entities('drawlayer_50', 'draw')
    camera()
end $$
