-- BASIC EXAMPLE FOR SIMPLE GAME BELOW:

g_bounds = zobj[[x,0, y,0, w,128, h,64, tx_off,0, ty_off,0]]

|[game_init]| function()
    _g.fader_in()
    g_pbox = _g.pbox(find_in_room(16))
    g_follow_panda = _g.follow_panda()

    for y=g_bounds.ty_off,g_bounds.ty_off+g_bounds.h-1 do
        for x=g_bounds.tx_off,g_bounds.tx_off+g_bounds.w-1 do
            if mget(x, y) == 104 then
                --_g.breakable_platform(x, y)
                mset(x, y, 0)
            elseif mget(x, y) == 98 then
                _g.pbox_spawn(x+.5, y+.5)
                mset(x, y, 0)
            end
        end
    end

    return def_x, def_y
end $$

|[game_update]| function()
    zcall(loop_entities, [[
        col_tile_func,@,
        pandas,@;
        1 ;,timer,       tick;
        2 ;,actor,       state;
        3 ;,mov,         mov_update;
        4 ;,tcol,        coll_tile, ~col_tile_func;

        5 ;,collidable,  adjust_deltas_for_tiles, %grav_x_tile_check;
        6 ;,collidable,  adjust_deltas_for_screen, %set_x_delta2;
        7 ;,vec,         vec_update_x;

        8 ;,pbox,        pandas_col_y;
        9 ;,collidable,  adjust_deltas_for_tiles, %grav_y_tile_check;
        10;,collidable,  adjust_deltas_for_screen, %set_y_delta2;
        11;,vec,         vec_update_y;

        12;,follow_panda,update;
        13;,anchor,      update_anchor;
    ]], function(x, y)
         return x >= g_bounds.x and x <= g_bounds.w and
                y >= g_bounds.y and y <= g_bounds.h and
                fget(mget(g_bounds.tx_off+x, g_bounds.ty_off+y), 0)
      end, g_zclass_entities.panda)
end $$

|[game_draw]| function()
    local camera_x = max(g_bounds.x, min((g_bounds.w-8)*8, g_follow_panda.x*8-32))
    local camera_y = max(g_bounds.y, min((g_bounds.h-8)*8, g_follow_panda.y*8-32))

    camera(camera_x, camera_y)

    map(g_bounds.tx_off, g_bounds.ty_off, 0, 0, g_bounds.w, g_bounds.h, 0x80)
    loop_entities('drawlayer_20', 'draw') -- checkpoint
    loop_entities('drawlayer_25', 'draw') -- pbox
    loop_entities('drawlayer_50', 'draw') -- pl
    loop_entities('drawlayer_75', 'draw') -- na

    -- DEBUG_BEGIN
    if g_debug then
        for inst in all(g_zclass_entities['box']) do
            scr_zrect(inst.x, inst.y, inst.rx, inst.ry, 8)
        end
    end
    -- DEBUG_END

    camera()
end $$
