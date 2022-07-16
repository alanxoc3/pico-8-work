-- BASIC EXAMPLE FOR SIMPLE GAME BELOW:

g_levels = zobj[[
    1;x,0, y,0, w,122, h,16, tx_off,0, ty_off,0;
    2;x,0, y,0, w,128, h,16, tx_off,0, ty_off,16;
    3;x,0, y,0, w,128, h,16, tx_off,0, ty_off,32;
]]

|[game_init]| function()
    g_room_bounds = g_levels[1]
    _g.fader_in()
    cube = create_dice(find_in_room(16, 8, 8))
    cube.dir = 1
    _g.ant(find_in_room(32))
end $$

|[game_update]| function()
    if btnp(0) then cube.dir = -1 elseif btnp(1) then cube.dir = 1 end
    if btn(4) then cube:roll(cube.dir)
              else cube:sit() end

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

    --zcall(loop_entities, [[
    --    pls,@, solids,@, room,@, statitems,@;

    --    1 ;,timer,       tick;
    --    2 ;,actor,       state;
    --    4 ;,enemy,       pl_collide_func_batch, ~pls;
    --    5 ;,collidable,  adjust_deltas_for_solids, ~solids;
    --    6 ;,collidable,  adjust_deltas_for_tiles, ~room;
    --    7 ;,collidable,  adjust_deltas_for_screen;
    --    9 ;,slimy_shared,statcollide, ~statitems;
    --    10;,anchor,      update_anchor;
    --    11;,target,      update_target, ~pls;
    --    12;,rstat,       update;
    --    13;,healthobj,   health_update;

end $$

|[game_draw]| function()
    rect(0, 0, 127, 127, 8)

    map(g_room_bounds.tx_off, g_room_bounds.ty_off, 0, 0, g_room_bounds.w, g_room_bounds.h)
    loop_entities('drawlayer_50', 'draw')
end $$
