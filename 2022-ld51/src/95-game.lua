-- BASIC EXAMPLE FOR SIMPLE GAME BELOW:

g_levels = zobj[[
    1;x,0, y,0, w,122, h,16, tx_off,0, ty_off,0;
    2;x,0, y,0, w,128, h,16, tx_off,0, ty_off,16;
    3;x,0, y,0, w,128, h,16, tx_off,0, ty_off,32;
]]

|[game_init]| function()
    g_room_bounds = g_levels[1]
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
         return x >= g_room_bounds.x and x < g_room_bounds.w and
                y >= g_room_bounds.y and y < g_room_bounds.h and
                fget(mget(g_room_bounds.tx_off+x, g_room_bounds.ty_off+y), 0)
      end)
end $$

|[game_draw]| function()
    camera(g_pl.x*8-32, g_follow_panda.y*8-32)
    rect(0, 0, 63, 63, 8)

    map(g_room_bounds.tx_off, g_room_bounds.ty_off, 0, 0, g_room_bounds.w, g_room_bounds.h, 0x80)
    loop_entities('drawlayer_50', 'draw')
    camera()
end $$
