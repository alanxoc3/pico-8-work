-- {
--   w:12, h:10,
--   tiles_1: {[y*ROOM_W+x]:0},
--   tiles_2: {[y*ROOM_W+x]:0},
--   objects: {{x:0, y:0, index:0}...},
--   color:0, music:0,
-- }
function draw_room(room, center_x, center_y, post_tile_func, post_card_func)
    local x1, y1 = center_x-room.w*8\2, center_y-room.h*8\2
    local pw, ph = room.w*8-1, room.h*8-1
    local x2, y2 = x1+pw, y1+ph

    clip(x1+4, y1+4, pw-7, ph-7)
    rectfill(x1, y1, x2, y2, room.color)
    for tiles in all{room.tiles_1, room.tiles_2} do
        for location, index in pairs(tiles) do
            local x, y = location%ROOM_W, location\ROOM_W
            spr(lookup_tile_animation(index), x1+x*8, y1+y*8)
        end
    end
    post_tile_func(x1, y1)
    clip()
    
    for i, color in pairs{1, 13, 1, 0} do
        i=4-i
        rect(x1+i, y1+i, x2-i, y2-i, color)
        i+=1
        pset(x1+i, y1+i, color) pset(x1+i, y2-i, color)
        pset(x2-i, y1+i, color) pset(x2-i, y2-i, color)
    end

    post_card_func(x1, y1)
end

g_tile_animation_lookup = {}
g_tile_animation_index = 0
function initialize_tile_animation_lookup(room)
    for layer in all{room.tiles_1, room.tiles_2} do
        for x=0,11 do
            local tbl = {}
            for y=0,9 do add(tbl, layer[y*12+x]) end
            g_tile_animation_lookup[layer[x] or 0] = tbl
        end
    end
end

function update_tile_animation_lookup()
    if t() % TILE_ANIMATION_SPEED == 0 then
        g_tile_animation_index = (g_tile_animation_index+1)%60
    end
end

function lookup_tile_animation(sind)
    local anim = g_tile_animation_lookup[sind]
    return anim and anim[g_tile_animation_index%#anim+1] or sind
end
