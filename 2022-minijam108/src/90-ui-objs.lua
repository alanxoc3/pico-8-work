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
    sy,11,
    sx,9,
    sind,SPR_PL
]]

zclass[[sword,tile_sprite,drawlayer_50|
    x,@, y,@,
    sy,8,
    sx,6,
    sw,2, sh,2,
    sind,200
]]

zclass[[enemy|]]
zclass[[snake,tile_sprite,enemy,drawlayer_50|
    x,@, y,@,
    sx,3,sy,8,
    sw,1,sh,2,
    sind,196
]]

zclass[[pos_real,tile_sprite,actor|
    gamestate,@, itemind,@, x,@, y,@, sind,@, sel_sind,@,
    sw,1, sh,1, sx,3, sy,3,
    update,%possible_move_obj_update;
]]

zclass[[pos_preview,tile_sprite,actor,drawlayer_50|
    gamestate,@, itemind,@, x,@, y,@, sind,@, sel_sind,@,
    sw,1, sh,1, sx,3, sy,3,
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

zclass[[selected_move,actor,drawlayer_50|
    update,%selected_move_update,
    draw,%selected_move_draw
]]

|[selected_move_update]| function(a)
    if g_level_state.curr ~= 'move_select' then
        a:kill()
    end
end $$

|[selected_move_draw]| function(a)
    for m in all(g_level_state.moves) do
        spr(m.sind, scr_x(m.x)-3, scr_y(m.y)-3)
    end

    local m = g_level_state.moves[g_level_state.moves_ind]
    spr(m.sel_sind, scr_x(m.x)-5, scr_y(m.y)-5, 2, 2)
end $$
