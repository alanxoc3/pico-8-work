function decode_map()
    local rooms, cur_loc = {}, 0x2000

    while peek(cur_loc) ~= CON_END do
        local room = {
            tiles={{}, {}},
            objs={},
            color=0,
            music=0
        }

        local room_ind = peek(cur_loc)
        cur_loc += 1

        local musfill = peek(cur_loc)
        room.color = band(0x0f, musfill)
        room.music = lshr(band(0xf0, musfill), 4)
        cur_loc += 1

        local is_fill = false
        local is_tile = true
        local layer = 1
        local ind = 0
        local offx, offy = 0, 0
        local byte = 0
        while byte ~= CON_END do
            byte = peek(cur_loc)
            cur_loc += 1

            if     byte == CON_L1     then is_fill = false is_tile = true  layer = 1
            elseif byte == CON_L2     then is_fill = false is_tile = true  layer = 2
            elseif byte == CON_OBJ_00 then is_fill = false is_tile = false offx = 0 offy = 0
            elseif byte == CON_OBJ_50 then is_fill = false is_tile = false offx = 1 offy = 0
            elseif byte == CON_OBJ_05 then is_fill = false is_tile = false offx = 0 offy = 1
            elseif byte == CON_OBJ_55 then is_fill = false is_tile = false offx = 1 offy = 1
            elseif byte == CON_FILL   then is_fill = true
            elseif byte < 128         then ind = byte
            elseif byte < CON_END     then
                local p1 = band(0x7f, byte)
                if is_tile then
                    if is_fill then
                        local p2 = band(0x7f, peek(cur_loc))
                        cur_loc += 1

                        local xb,yb,xe,ye = p1%12,flr(p1/12), p2%12,flr(p2/12)
                        for yy=yb,ye do
                            for xx=xb,xe do
                                room.tiles[layer][yy*12+xx] = ind
                            end
                        end
                    else
                        room.tiles[layer][p1] = ind
                    end
                else
                    local x, y = p1 % 12, flr(p1/12)
                    room.objs[y*2*24+offy*24+(x*2+offx)] = ind
                end
            end
        end

        rooms[room_ind] = room
    end

    return rooms
end
