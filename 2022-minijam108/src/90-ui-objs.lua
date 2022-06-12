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

zclass[[enemy|]]
zclass[[snake,tile_sprite,enemy,drawlayer_50|
    x,@, y,@,
    sind,SPR_SNAKE
]]

zclass[[possible_move_obj,actor,drawlayer_50|
    gamestate,@, x,@, y,@,
    update,%possible_move_obj_update,
    draw,%possible_move_obj_draw;
]]

|[possible_move_obj_update]| function(a)
    if a.gamestate.curr ~= 'move_select' then
        a:kill()
    end
end $$

|[possible_move_obj_draw]| function(a)
    circ(scr_x(a.x), scr_y(a.y), 12, 1)
end $$
