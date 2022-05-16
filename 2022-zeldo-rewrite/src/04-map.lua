-- {
--   w:12, h:10,
--   tiles_1: {[y*ROOM_W+x]:0},
--   tiles_2: {[y*ROOM_W+x]:0},
--   objects: {{x:0, y:0, index:0}...},
--   color:0, music:0,
-- }
function draw_room(room, center_x, center_y, post_tile_func, post_card_func)
    local offx, offy = center_x-room.w*8\2, center_y-room.h*8\2
    rectfill(offx, offy, offx+room.w*8-1, offy+room.h*8-1, room.color)
    for location, index in pairs(room.tiles_1) do
        local x, y = location%ROOM_W, location\ROOM_W
        spr(index, offx+x*8, offy+y*8)
    end

    for location, index in pairs(room.tiles_2) do
        local x, y = location%ROOM_W, location\ROOM_W
        spr(index, offx+x*8, offy+y*8)
    end

    post_tile_func()
    post_card_func()
end
