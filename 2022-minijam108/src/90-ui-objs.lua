function scr_x(x)
    local midr = 7/2*TILE_RADIUS
    return x*TILE_RADIUS+g_offx-midr+TILE_RADIUS/2-1
end

function scr_y(y)
    local midr = 7/2*TILE_RADIUS
    return y*TILE_RADIUS+g_offy-midr+TILE_RADIUS/2-1
end

zclass[[tile_entity,mov,actor|
    to_target,%tile_entity_to_target,
    target_x,null, target_y,null,
    draw,%tile_sprite_draw
]]

|[tile_entity_to_target]| function(a)
    local xdiff, ydiff = a.target_x - a.x, a.target_y - a.y
    if abs(xdiff) < .25 and abs(ydiff) < .25 then
        a.x = a.target_x
        a.y = a.target_y
        a.speed = 0
    else
        a.ang = atan2(xdiff, ydiff)
        a.speed = .05
    end
end $$

|[tile_sprite_draw]| function(a)
    if a.sind then
        spr(a.sind, scr_x(a.x)-g_spr_info[a.sind][3], scr_y(a.y)-g_spr_info[a.sind][4], g_spr_info[a.sind][1], g_spr_info[a.sind][2])
    end
end $$

zclass[[puddle,actor,drawlayer_25|
    x,@, y,@,
    sind,168,
    target_x,~x,
    target_y,~y,
    draw,%tile_sprite_draw
]]

zclass[[hermit,mov,actor,drawlayer_50|
    x,@, y,@,
    target_x,~x,
    target_y,~y,
    to_target,%tile_entity_to_target,
    draw,%tile_sprite_draw,
    destroyed,%hermit_destroyed,
    update,%hermit_update
]]

|[hermit_destroyed]| function(a)
    g_sword.target_x = -100
    g_sword.target_y = -100
    g_sword:kill()
end $$

|[hermit_update]| function(a)
    local xdiff = g_sword.target_x - a.target_x
    local ydiff = g_sword.target_y - a.target_y
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

zclass[[sword,actor,drawlayer_50|
    target_x,@, target_y,@
]]

zclass[[pos_preview,actor,drawlayer_50|
    gamestate,@, itemind,@, x,@, y,@, sind,@,
    update,%possible_move_small_obj_update,
    draw,%tile_sprite_draw
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
        spr(g_icon_lookup[m.seltype].s, scr_x(m.x)-3, scr_y(m.y)-3)
    end

    local m = g_level_state.moves[g_level_state.moves_ind]
    spr(g_icon_lookup[m.seltype].l, scr_x(m.x)-5, scr_y(m.y)-5, 2, 2)
end $$
