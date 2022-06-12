function scr_x(x)
    local midr = 7/2*TILE_RADIUS
    return x*TILE_RADIUS+g_offx-midr+TILE_RADIUS/2-1
end

function scr_y(y)
    local midr = 7/2*TILE_RADIUS
    return y*TILE_RADIUS+g_offy-midr+TILE_RADIUS/2-1
end

zclass[[tile_sprite,pos|
    sx,8, sy,8,
    sw,2, sh,2,
    draw,%tile_sprite_draw
]]

|[tile_sprite_draw]| function(a)
    spr(a.sind, scr_x(a.x)-a.sx, scr_y(a.y)-a.sy, a.sw, a.sh)
end $$

zclass[[hermit,tile_sprite,drawlayer_50|
    x,@, y,@,
    sind,SPR_PL
]]

zclass[[sword,tile_sprite,drawlayer_50|
    x,@, y,@,
    sy,16,
    sw,2, sh,3,
    sind,128
]]

zclass[[enemy|]]
zclass[[snake,tile_sprite,enemy,drawlayer_50|
    x,@, y,@,
    sx,3,sy,8,
    sw,1,sh,2,
    sind,196
]]

zclass[[pos_move,tile_sprite,actor,drawlayer_50|
    sind,140,
    sx,4, sy,4,
    sw,1, sh,1,
    gamestate,@, itemind,@, x,@, y,@,
    update,%possible_move_obj_update;
]]

zclass[[pos_sword,tile_sprite,actor,drawlayer_50|
    sind,141,
    sx,4, sy,4,
    sw,1, sh,1,
    gamestate,@, itemind,@, x,@, y,@,
    update,%possible_move_obj_update;
]]

zclass[[pos_attack,tile_sprite,actor,drawlayer_50|
    sind,141,
    sx,4, sy,4,
    sw,1, sh,1,
    gamestate,@, itemind,@, x,@, y,@,
    update,%possible_move_obj_update;
]]

zclass[[pos_move_small,tile_sprite,actor,drawlayer_50|
    sind,171,
    sx,4, sy,4,
    sw,1, sh,1,
    gamestate,@, itemind,@, x,@, y,@,
    update,%possible_move_small_obj_update;
]]

zclass[[pos_sword_small,tile_sprite,actor,drawlayer_50|
    sind,155,
    sx,4, sy,4,
    sw,1, sh,1,
    gamestate,@, itemind,@, x,@, y,@,
    update,%possible_move_small_obj_update;
]]

|[possible_move_obj_update]| function(a)
    if a.gamestate.curr ~= 'move_select' then
        a:kill()
    end
end $$

|[possible_move_small_obj_update]| function(a)
    if a.gamestate.itemind ~= a.itemind or a.gamestate.curr ~= 'card_select' then
        a:kill()
    end
end $$
