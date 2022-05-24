zclass[[room_bounds,box|x,@,y,@,rx,@,ry,@]]

|room_init| function(state)
    local r = g_rooms[state.room_index]
    g_room_bounds = _g.room_bounds(r.w/2, r.h/2+.25, r.w/2+.125, r.h/2+.125)
    g_pl = _g.pl(state.pl_x, state.pl_y, state.pl_xf)
    g_fairy = _g.fairy(g_pl, state.fairy_x, state.fairy_y)
    _g.inventory(g_pl)

    -- create the objects in the room
    foreach(r.objects, function(obj_template)
        _g[g_obj_map[obj_template.index]](obj_template.x+.5, obj_template.y+.5)
    end)
end $$

|room_update| function(state)
    if state:get_elapsed'state' > FADE_SPEED and not state.leaving then
        zcall(loop_entities, [[
            1;,timer,       tick;
            2;,actor,       state;
            3;,mov,         mov_update;
            4;,collidable,  adjust_deltas_for_tiles, @;
            5;,collidable,  adjust_deltas_for_solids, @;
            6;,vec,         vec_update;
            7;,anchor,      update_anchor;
            8;,target,      update_target, @;
        ]], g_rooms[state.room_index], g_zclass_entities.solid, g_zclass_entities.pl)
    end

    if not state.leaving and not g_pl:inside(g_room_bounds) then
        state.leaving = true
        _g.fader_out(FADE_SPEED, function()
            local abx, aby = g_pl:abside(g_room_bounds)
            local nri = state.room_index + aby*16+abx
            local nr = g_rooms[nri]
            if nr then
                local helper = function(x, w) return w/2-x*w/2+1.25*x end
                if abx ~= 0 then state.pl_x, state.pl_y, state.pl_xf = helper(abx, nr.w), g_pl.y, abx < 0
                          else state.pl_y, state.pl_x, state.pl_xf = helper(aby, nr.h)+.25, g_pl.x, g_pl.xf end
            else
                state.pl_x, state.pl_y, state.pl_xf = LOST_ROOM_START_X, LOST_ROOM_START_Y, g_pl.xf
                nri = LOST_ROOM_INDEX
            end
            state.room_index = nri

            state.fairy_x, state.fairy_y = state.pl_x-abx*2, state.pl_y-aby*2
            state:load'room'
        end)
    end
end $$

|room_draw| function(state)
    draw_room(g_rooms[state.room_index], CARD_CX, CARD_CY, function()
        loop_entities('outlayer_50', 'drawout')
        loop_entities('drawlayer_50', 'draw')
        zcall(loop_entities, [[
            1;,outlayer_50, drawout;
            2;,drawlayer_50, draw;
            3;,drawlayer_70, draw;
            4;,drawlayer_75, draw;
        ]])

        -- DEBUG_BEGIN
        if g_debug then
            for inst in all(g_zclass_entities['box']) do
                scr_zrect(inst.x, inst.y, inst.rx, inst.ry, 8)
            end
        end
        -- DEBUG_END
    end, function()
        zcall(loop_entities, [[
            1;,outlayer_99, drawout;
            2;,drawlayer_90, draw;
            3;,drawlayer_95, draw;
            4;,drawlayer_99, draw;
        ]])
    end)

    zcall(draw_bar, [[
        1;,18,6,109,11,@,0,8,2
    ]], g_pl.energy)
end $$
