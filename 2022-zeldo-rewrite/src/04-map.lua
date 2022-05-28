-- {
--   w:12, h:10,
--   tiles_1: {[y*ROOM_W+x]:0},
--   tiles_2: {[y*ROOM_W+x]:0},
--   objects: {{x:0, y:0, index:0}...},
--   color:0, music:0,
-- }

function loop_through_tiles(room, func)
    for tiles in all{room.tiles_1, room.tiles_2} do
        for location, index in pairs(tiles) do
            local x, y = location%ROOM_W, location\ROOM_W
            func(lookup_tile_animation(index), x*8, y*8)
        end
    end
end

function draw_room(room, center_x, center_y, post_tile_func, post_card_func)
    local x1, y1 = center_x-room.w*8\2, center_y-room.h*8\2
    draw_card(center_x, center_y, room.w*4-2, room.h*4-2, -2, -2, function()
        rectfill(0, 0, 127, 127, room.color)

        loop_through_tiles(room, function(sind, x, y)
            if not fget(sind, 1) then
                spr(sind, x, y)
            end
            -- DEBUG_BEGIN
            if g_debug then
                rect(x+1, y+1, x+6, y+6, 0)
            end
            -- DEBUG_END
        end)

        post_tile_func(x1, y1)
    end, post_card_func)
end

function create_tile_animation_lookup(room)
    local lookup = {}
    for layer in all{room.tiles_1, room.tiles_2} do
        for x=0,11 do
            local tbl = {}
            for y=0,9 do add(tbl, layer[y*12+x]) end
            lookup[layer[x] or 0] = tbl
        end
    end
    return lookup
end

function lookup_tile_animation(sind)
    local anim = g_tile_animation_lookup[sind]
    return anim and anim[g_i%#anim+1] or sind
end
