zclass[[room_bounds,box|x,@,y,@,rx,@,ry,@]]

|[room_init]| function(state) 
    local r = g_rooms[peek'MEM_ROOM_IND']
    
    local mus = flr(r.music/2)*8+(r.music%2)*5
    poke(0x5f43, 0) -- ensure music is not faded anymore
    if g_music_ind ~= mus then
        g_music_ind = mus
        music(mus, 0, 7)
    end

    g_room_bounds = _g.room_bounds(r.w/2, r.h/2, r.w/2-.375, r.h/2-.375)

    g_pl = _g.pl(
        peek'MEM_PL_X'/POS_MULTIPLIER_FOR_MEMORY,
        peek'MEM_PL_Y'/POS_MULTIPLIER_FOR_MEMORY,
        peek'MEM_PL_XF'*2-1,
        peek'MEM_PL_HEALTH',
        peek'MEM_PL_MAX_HEALTH',
        _g.inventory()
    )

    g_fairy = _g.fairy(g_pl.x, g_pl.y-.125)
    g_rstat_left, g_rstat_right = _g.rstat(1, 36, 'ma_left'), _g.rstat(-1, 93, 'ma_right')

    _g.energybar(g_pl)
    _g.coin_count()

    -- create the objects in the room
    foreach(r.objects, function(obj_template)
        _g[g_obj_map[obj_template.index]](obj_template.x+.5, obj_template.y+.5)
    end)
end $$

|[room_update]| function(state)
    -- DEBUG_BEGIN
    -- easy way to save
    if g_debug and btnp'BTN_ITEM_SELECT' and g_pl and g_pl:is_alive() then
        zcall(poke, [[
            1;,MEM_PL_X,       @;
            2;,MEM_PL_Y,       @;
            3;,MEM_PL_XF,      @;
        ]], g_pl.x*POS_MULTIPLIER_FOR_MEMORY,
            g_pl.y*POS_MULTIPLIER_FOR_MEMORY,
            (g_pl.xf+1)\2
        )
        memcpy(REAL_SAVE_LOCATION, MEM_SAVE_LOCATION, SAVE_LENGTH)
    end
    -- DEBUG_END

    zcall(loop_entities, [[
        pls,@, solids,@, room,@, statitems,@, smaller_slimes,@;

        1 ;,timer,       tick;
        2 ;,actor,       state;
        3 ;,pushable,    update_push;
        4 ;,mov,         mov_update;
        5 ;,enemy,       pl_collide_func_batch, ~pls;

        6 ;,collidable,  adjust_deltas_for_solids, %set_x_delta, ~solids;
        7 ;,collidable,  adjust_deltas_for_tiles,  %set_x_delta, ~room;
        8 ;,collidable,  adjust_deltas_for_screen, %set_x_delta2;
        9 ;,vec,         vec_update_x;

        10;,collidable,  adjust_deltas_for_solids, %set_y_delta, ~solids;
        11;,collidable,  adjust_deltas_for_tiles,  %set_y_delta, ~room;
        12;,collidable,  adjust_deltas_for_screen, %set_y_delta2;
        13;,vec,         vec_update_y;

        14;,smaller_slimes,statcollide, ~smaller_slimes;
        15;,smaller_slimes,statcollide, ~statitems;
        16;,slobs,statcollide, ~statitems;
        17;,slimy_boss_minion_2,statcollide, ~statitems;
        18;,anchor,      update_anchor;
        19;,target,      update_target, ~pls;
        20;,rstat,       buffer_update;
        21;,healthobj,   health_update;
    ]], g_zclass_entities.pl, g_zclass_entities.solid, g_rooms[peek'MEM_ROOM_IND'], g_zclass_entities.statitem, g_zclass_entities.smaller_slimes)

    poke(MEM_PL_HEALTH, g_pl.health)
    poke(MEM_PL_MAX_HEALTH, g_pl.max_health)

    if not does_entity_exist'fader' and (not g_pl:inside(g_room_bounds) or peek'MEM_PL_HEALTH' <= 0) then
        local abx, aby = g_pl:abside(g_room_bounds)
        local nri = peek'MEM_ROOM_IND' + aby*16+abx

        -- if currently in a small room
        if peek'MEM_ROOM_IND' > LAST_ROOM_INDEX then
            load_room(peek'MEM_RET_ROOM_IND', peek'MEM_RET_PL_X'/POS_MULTIPLIER_FOR_MEMORY, peek'MEM_RET_PL_Y'/POS_MULTIPLIER_FOR_MEMORY, g_pl.xf)

        -- if the adjacent room does exist
        elseif g_rooms[nri] then
            if abx ~= 0 then load_room(nri, ROOM_RX-abx*ROOM_RX+1.25*abx, g_pl.y, abx)
                        else load_room(nri, g_pl.x, ROOM_RY-aby*ROOM_RY+1.25*aby+.25, g_pl.xf)
            end

        -- if the adjacent room doesn't exist
        else
            zcall(load_room, [[1;,LOST_ROOM_INDEX,LOST_ROOM_START_X,LOST_ROOM_START_Y,@;]], g_pl.xf) 
        end
    end
end $$

|[room_draw]| function(state)
    isorty(g_zclass_entities['drawlayer_50'])

    local coffx = 0 -- g_pl:is_active'stunned' and cos(g_fi/4) or 0
    draw_room(g_rooms[peek'MEM_ROOM_IND'], CARD_CX+coffx, CARD_CY, function()
        zcall(loop_entities, [[
            1;,drawlayer_25, draw;
            2;,drawlayer_50, draw;
            3;,drawlayer_75, draw;
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
end $$

function load_room(rind, x, y, xf)
    if not does_entity_exist'fader' then
        -- explode created with fader.... init won't be called.
        _g.fader_out(function()
            if peek'MEM_PL_HEALTH' <= 0 then
                g_state:load'gameover'
            else
                zcall(poke, [[
                    1;,MEM_ROOM_IND, @;
                    2;,MEM_PL_X,     @;
                    3;,MEM_PL_Y,     @;
                    4;,MEM_PL_XF,    @;
                ]], rind,
                    x*POS_MULTIPLIER_FOR_MEMORY,
                    y*POS_MULTIPLIER_FOR_MEMORY,
                    (xf+1)\2
                )

                g_state:load'room'
            end
        end)
    end
end
