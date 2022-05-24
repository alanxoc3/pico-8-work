g_obj_map = split[[bed,signtest,pot,housetest,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil]]

-- {
--   [y*16+x]: {
--     w:12, h:10,
--     tiles_1: {[y*12+x]: 0},
--     tiles_2: {[y*12+x]: 0},
--     objects: {{x:0, y:0, index:0}...},
--     color:0,
--     music:0,
--     get_spr
--   }
-- }

function decode_map()
    local rooms, cur_loc = {}, 0x2000
    local peek_inc = function()
        cur_loc += 1
        return @(cur_loc-1)
    end

    while @cur_loc ~= CON_END do
        local room, room_ind = zobj[[tiles_1;,;tiles_2;,;objects;,;w,ROOM_W,h,ROOM_H,color,0,music,0]], peek_inc()
        if room_ind > LAST_ROOM_INDEX then room.w, room.h = HUT_W, HUT_H end

        room.color = 0x0f & @cur_loc
        room.music = 0xf0 & peek_inc() >>> 4

        local byte, is_fill, is_tile, layer, ind, offx, offy = 0, false, true, room.tiles_1, 0, 0, 0
        while byte ~= CON_END do
            byte = peek_inc()

            if byte >= CON_L1 and byte <= CON_OBJ_55 then
                is_fill, is_tile = nil
            end

            if     byte == CON_L1     then is_tile = true  layer = room.tiles_1
            elseif byte == CON_L2     then is_tile = true  layer = room.tiles_2
            elseif byte == CON_OBJ_00 then offx = 0  offy = 0
            elseif byte == CON_OBJ_50 then offx = .5 offy = 0
            elseif byte == CON_OBJ_05 then offx = 0  offy = .5
            elseif byte == CON_OBJ_55 then offx = .5 offy = .5
            elseif byte == CON_FILL   then is_fill = true
            elseif byte < 128         then ind = byte
            elseif byte < CON_END     then
                local p1 = 0x7f & byte
                if is_tile then
                    if is_fill then
                        local p2 = 0x7f & peek_inc()
                        for yy=p1\12,p2\12 do
                            for xx=p1%12,p2%12 do
                                layer[yy*12+xx] = ind+128
                            end
                        end
                    else
                        layer[p1] = ind+128
                    end
                else
                    add(room.objects, {index=ind+1, x=p1%12+offx, y=p1\12+offy})
                end
            end
        end

        rooms[room_ind] = room
    end

    return rooms
end
