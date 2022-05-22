zclass[[nopause|nopause_update,nop]] -- update for things that shouldn't run when room is paused.
zclass[[room_bounds,box|x,@,y,@,rx,@,ry,@]]

|room_init| function(state)
    local r = g_rooms[state.room_index]
    g_room_bounds = _g.room_bounds(r.w/2, r.h/2+.25, r.w/2+.125, r.h/2+.125)
    g_pl = _g.pl(state.pl_x, state.pl_y, state.pl_xf)
    g_fairy = _g.fairy(g_pl, state.fairy_x, state.fairy_y)
    _g.inventory(g_pl)
end $$

|room_update| function(state)
    if state:get_elapsed'state' > FADE_SPEED and not state.leaving then
        zcall(loop_entities, [[
            1;,nopause, nopause_update;
            2;,mov,     mov_update;
            3;,tilecol, adjust_deltas_for_tiles, @;
            4;,vec,     vec_update;
        ]], g_rooms[state.room_index])
    end

    if not state.leaving and not g_pl:inside(g_room_bounds) then
        state.leaving = true
        _g.fader_out(FADE_SPEED, function()
            local x, y = g_pl:abside(g_room_bounds)
            state.room_index += y*16+x
            local nr = g_rooms[state.room_index]
            local helper = function(x, w) return w/2-x*w/2+1.25*x end
            if x ~= 0
            then state.pl_x, state.pl_y, state.pl_xf = helper(x, nr.w), g_pl.y, x < 0
            else state.pl_y, state.pl_x, state.pl_xf = helper(y, nr.h)+.25, g_pl.x, g_pl.xf end
            state.fairy_x, state.fairy_y = state.pl_x-x*2, state.pl_y-y*2
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
            2;,drawlayer_99, draw;
        ]])
    end)

    zcall(draw_bar, [[
        1;,18,6,109,11,@,20,0,8,2
    ]], 10)

    draw_stat(9, 112, -1, "lank", function() zspr(88,0,0) zspr(91,0,0) end, 10, 5)
    draw_stat(127-8, 112,  1, "bady", function() zspr(118,0,0,1,1,true) end, 4, 3)
    draw_tbox(64, 112)
end $$
