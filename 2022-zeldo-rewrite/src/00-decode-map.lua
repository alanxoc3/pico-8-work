function decode_map()
    local rooms, cur_loc = {}, 0x2000

    local peek_inc = function()
        cur_loc += 1
        return peek(cur_loc-1)
    end

    while peek(cur_loc) ~= CON_END do
        local room, room_ind = zobj"tiles;1;,;tiles;2;,;objs;,;color,0,music,0", peek_inc()
        local musfill = peek_inc()
        room.color = 0x0f & musfill
        room.music = 0xf0 & musfill >>> 4

        local byte, is_fill, is_tile, layer, ind, offx, offy = 0, false, true, 1, 0, 0, 0
        while byte ~= CON_END do
            byte = peek_inc()

            if byte >= CON_L1 and byte <= CON_OBJ_55 then
                is_fill = false
                is_tile = false
            end

            if     byte == CON_L1     then is_tile = true  layer = 1
            elseif byte == CON_L2     then is_tile = true  layer = 2
            elseif byte == CON_OBJ_00 then offx = 0 offy = 0
            elseif byte == CON_OBJ_50 then offx = 1 offy = 0
            elseif byte == CON_OBJ_05 then offx = 0 offy = 1
            elseif byte == CON_OBJ_55 then offx = 1 offy = 1
            elseif byte == CON_FILL   then is_fill = true
            elseif byte < 128         then ind = byte
            elseif byte < CON_END     then
                local p1 = 0x7f & byte
                if is_tile then
                    if is_fill then
                        local p2 = 0x7f & peek_inc()

                        for yy=p1\12,p2\12 do
                            for xx=p1%12,p2%12 do
                                room.tiles[layer][yy*12+xx] = ind
                            end
                        end
                    else
                        room.tiles[layer][p1] = ind
                    end
                else
                    room.objs[p1\12*48+offy*24+p1%12*2+offx] = ind
                end
            end
        end

        rooms[room_ind] = room
    end

    return rooms
end
