zclass[[room_bounds,box|x,@,y,@,rx,@,ry,@]]

|room_init| function(state)
    local r = g_rooms[state.room_index]
    g_room_bounds = _g.room_bounds(r.w/2, r.h/2, r.w/2+.25, r.h/2+.25)
    g_pl = _g.pl(state.pl_x, state.pl_y)
    g_fairy = _g.fairy(g_pl, state.fairy_x, state.fairy_y)
end $$

|room_update| function(state)
    if state:get_elapsed'state' > FADE_SPEED and not state.leaving then
        zcall(loop_entities, [[
            1;,mov,     mov_update;
            2;,tilecol, adjust_deltas_for_tiles, @;
            3;,vec,     vec_update;
        ]], g_rooms[state.room_index])
    end

    -- DEBUG_BEGIN
    if g_debug then debug_boxes(g_pl, g_room_bounds) end
    -- DEBUG_END

    if not state.leaving and not g_pl:inside(g_room_bounds) then
        state.leaving = true
        _g.fader_out(FADE_SPEED, function()
            local x, y = g_pl:abside(g_room_bounds)
            state.room_index += y*16+x
            local nr = g_rooms[state.room_index]
            if x ~= 0
            then state.pl_x, state.pl_y = nr.w/2-x*nr.w/2+.75*x, g_pl.y
            else state.pl_y, state.pl_x = nr.w/2-y*nr.w/2+.75*y, g_pl.x end
            state.fairy_x, state.fairy_y = state.pl_x-x*2, state.pl_y-y*2
            state:load'room'
        end)
    end
end $$

|room_draw| function(state)
    draw_room(g_rooms[state.room_index], 64, 64, function()
        loop_entities('outlayer_50', 'drawout')
        loop_entities('drawlayer_50', 'draw')

        -- DEBUG_BEGIN
        if g_debug then
            for inst in all(g_zclass_entities['box']) do
                scr_rect(inst.x-inst.rx, inst.y-inst.ry, inst.x+inst.rx-.125, inst.y+inst.ry-.125, 8)
            end
        end
        -- DEBUG_END
    end)

    -- loop_entities('outlayer_99', 'drawout')
    -- loop_entities('drawlayer_99', 'draw')
end $$
