zclass[[room_bounds,box|x,@,y,@,rx,@,ry,@]]

|room_init| function(state) 
    state.room_index = zdget_value'MEM_ROOM_IND'

    local r = g_rooms[state.room_index]
    g_room_bounds = _g.room_bounds(r.w/2, r.h/2+.25, r.w/2+.125, r.h/2+.125)
    g_pl = _g.pl(zdget_value'MEM_PL_X'/POS_MULTIPLIER_FOR_MEMORY, zdget_value'MEM_PL_Y'/POS_MULTIPLIER_FOR_MEMORY, zdget'MEM_PL_XF')

    local abx, aby = g_pl:abside(g_room_bounds)
    g_fairy = _g.fairy(g_pl, g_pl.x+abx*1.25, g_pl.y+aby*1.25)

    _g.inventory(g_pl)

    -- create the objects in the room
    foreach(r.objects, function(obj_template)
        _g[g_obj_map[obj_template.index]](obj_template.x+.5, obj_template.y+.5)
    end)
end $$

|room_update| function(state)
    if does_entity_exist'fader' then return end

    zcall(loop_entities, [[
        1;,timer,       tick;
        2;,actor,       state;
        3;,mov,         mov_update;
        4;,collidable,  adjust_deltas_for_solids, @;
        5;,collidable,  adjust_deltas_for_tiles, @;
        6;,vec,         vec_update;
        7;,anchor,      update_anchor;
        8;,target,      update_target, @;
    ]], g_zclass_entities.solid, g_rooms[state.room_index], g_zclass_entities.pl)

    if not g_pl:inside(g_room_bounds) then
        _g.fader_out(function()
            local abx, aby = g_pl:abside(g_room_bounds)
            local nri = state.room_index + aby*16+abx
            local nr = g_rooms[nri]
            local pl_x, pl_y, pl_xf

            if state.room_index > LAST_ROOM_INDEX then
                pl_x, pl_y, pl_xf = zdget_value'MEM_RET_PL_X'/POS_MULTIPLIER_FOR_MEMORY, zdget_value'MEM_RET_PL_Y'/POS_MULTIPLIER_FOR_MEMORY, g_pl.xf
                nri = zdget_value'MEM_RET_ROOM_IND' 
            elseif nr then
                local helper = function(x, w) return w/2-x*w/2+1.25*x end
                if abx ~= 0 then pl_x, pl_y, pl_xf = helper(abx, nr.w), g_pl.y, abx < 0
                            else pl_y, pl_x, pl_xf = helper(aby, nr.h)+.25, g_pl.x, g_pl.xf end
            else
                pl_x, pl_y, pl_xf = LOST_ROOM_START_X, LOST_ROOM_START_Y, g_pl.xf
                nri = LOST_ROOM_INDEX
            end

            state.room_index = nri

            zdset(MEM_ROOM_IND,nri)
            zdset(MEM_PL_X, pl_x*POS_MULTIPLIER_FOR_MEMORY)
            zdset(MEM_PL_Y, pl_y*POS_MULTIPLIER_FOR_MEMORY)
            zdset(MEM_PL_XF,pl_xf and 1 or 0)

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
            3;,drawlayer_60, draw;
            4;,drawlayer_70, draw;
            5;,drawlayer_75, draw;
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
