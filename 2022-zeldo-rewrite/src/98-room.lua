zclass[[room_bounds,box|x,@,y,@,rx,@,ry,@]]

|[room_init]| function(state) 
    local r = g_rooms[peek'MEM_ROOM_IND']
    g_room_bounds = _g.room_bounds(r.w/2, r.h/2+.25, r.w/2+.125, r.h/2+.125)

    g_pl = _g.pl(peek'MEM_PL_X'/POS_MULTIPLIER_FOR_MEMORY, peek'MEM_PL_Y'/POS_MULTIPLIER_FOR_MEMORY, peek'MEM_PL_XF'>0)
    g_fairy = _g.fairy(g_pl, g_pl.x, g_pl.y-.125)
    _g.stat(1, 119, g_fairy)


    _g.inventory(g_pl)

    -- create the objects in the room
    foreach(r.objects, function(obj_template)
        _g[g_obj_map[obj_template.index]](obj_template.x+.5, obj_template.y+.5)
    end)
end $$

|[room_update]| function(state)
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
    ]], g_zclass_entities.solid, g_rooms[peek'MEM_ROOM_IND'], g_zclass_entities.pl)

    if not g_pl:inside(g_room_bounds) then
        _g.fader_out(function()
            local abx, aby = g_pl:abside(g_room_bounds)
            local nri = peek'MEM_ROOM_IND' + aby*16+abx
            local nr = g_rooms[nri]
            local pl_x, pl_y, pl_xf

            if peek'MEM_ROOM_IND' > LAST_ROOM_INDEX then
                pl_x, pl_y, pl_xf = peek'MEM_RET_PL_X'/POS_MULTIPLIER_FOR_MEMORY, peek'MEM_RET_PL_Y'/POS_MULTIPLIER_FOR_MEMORY, g_pl.xf
                nri = peek'MEM_RET_ROOM_IND' 
            elseif nr then
                local helper = function(x, w) return w/2-x*w/2+1.25*x end
                if abx ~= 0 then pl_x, pl_y, pl_xf = helper(abx, nr.w), g_pl.y, abx < 0
                            else pl_y, pl_x, pl_xf = helper(aby, nr.h)+.25, g_pl.x, g_pl.xf end
            else
                pl_x, pl_y, pl_xf = LOST_ROOM_START_X, LOST_ROOM_START_Y, g_pl.xf
                nri = LOST_ROOM_INDEX
            end

            zcall(poke, [[
                1;,MEM_ROOM_IND,@;
                2;,MEM_PL_X,@;
                3;,MEM_PL_Y,@;
                4;,MEM_PL_XF,@;
            ]], nri,
                pl_x*POS_MULTIPLIER_FOR_MEMORY,
                pl_y*POS_MULTIPLIER_FOR_MEMORY,
                pl_xf and 1 or 0
            )

            state:load'room'
        end)
    end
end $$

|[room_draw]| function(state)
    isorty(g_zclass_entities['drawlayer_50'])

    draw_room(g_rooms[peek'MEM_ROOM_IND'], CARD_CX, CARD_CY, function()
        zcall(loop_entities, [[
            1;,drawlayer_50, draw;
            2;,drawlayer_60, draw;
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
            1;,drawlayer_90, draw;
            2;,drawlayer_95, draw;
            3;,drawlayer_99, draw;
        ]])
    end)

    zcall(draw_bar, [[
        1;,18,6,109,11,@,0,8,2
    ]], g_pl.energy)
end $$
