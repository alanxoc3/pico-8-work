function scr_x(x)
    local midr = 7/2*TILE_RADIUS
    return x*TILE_RADIUS+g_offx-midr+TILE_RADIUS/2-1
end

function scr_y(y)
    local midr = 7/2*TILE_RADIUS
    return y*TILE_RADIUS+g_offy-midr+TILE_RADIUS/2-1
end

zclass[[tile_sprite,pos|
    draw,%tile_sprite_draw
]]

|[tile_sprite_draw]| function(a)
    if a.sind then
        spr(a.sind, scr_x(a.x)-g_spr_info[a.sind][3], scr_y(a.y)-g_spr_info[a.sind][4], g_spr_info[a.sind][1], g_spr_info[a.sind][2])
    end
end $$

zclass[[hermit,actor,tile_sprite,drawlayer_50|
    x,@, y,@, update,%hermit_update
]]

|[hermit_update]| function(a)
    local xdiff = g_sword.x - a.x
    local ydiff = g_sword.y - a.y
        if xdiff == 0 and ydiff < 0 then a.sind = 0
    elseif xdiff == 0 and ydiff > 0 then a.sind = 2
    elseif ydiff == 0 and xdiff < 0 then a.sind = 4
    elseif ydiff == 0 and xdiff > 0 then a.sind = 36

    elseif xdiff > 0 and ydiff > 0 then a.sind = 67
    elseif xdiff > 0 and ydiff < 0 then a.sind = 64
    elseif xdiff < 0 and ydiff > 0 then a.sind = 70
    elseif xdiff < 0 and ydiff < 0 then a.sind = 73
    end
end $$

zclass[[sword|
    x,@, y,@
]]

zclass[[enemy|]]
zclass[[snake,tile_sprite,enemy,drawlayer_50|
    x,@, y,@,
    sind,196
]]

zclass[[pos_real,tile_sprite,actor|
    gamestate,@, itemind,@, x,@, y,@, sind,@, sel_sind,@,
    update,%possible_move_obj_update;
]]

zclass[[pos_preview,tile_sprite,actor,drawlayer_50|
    gamestate,@, itemind,@, x,@, y,@, sind,@, sel_sind,@,
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
