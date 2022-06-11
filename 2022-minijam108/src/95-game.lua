-- BASIC EXAMPLE FOR SIMPLE GAME BELOW:
zclass[[test_obj,actor,drawlayer_50|x,@,y,@,color,7,init,%test_init,update,%test_update,draw,%test_draw;]]
|[test_init]|   function(a) a.color += 1                   end $$
|[test_update]| function(a) a.x += xbtn() a.y += ybtn()    end $$
|[test_draw]|   function(a) circfill(a.x, a.y, 2, a.color) end $$

|[game_init]| function()
    g_grid = set_grid(0)
    _g.fader_in()
    _g.test_obj(64, 64)
end $$

|[game_update]| function()
    loop_entities('actor', 'state')
end $$

|[game_draw]| function()
    draw_tiles(64, 64)
    rect(0, 0, 127, 127, 8)
    loop_entities('drawlayer_50', 'draw')
end $$

function draw_tiles(cx, cy)
    local midr = 7/2*TILE_RADIUS
    for ind, tile in pairs(g_grid) do
        local x,y = ind%7, ind\7
        if tile.active then
            local sind = TILE_SPR_1
            if (y*7+x)%2 == 0 then sind = TILE_SPR_2 end
            spr(sind, x*TILE_RADIUS+cx-midr-1, y*TILE_RADIUS+cy-midr-1, 2, 2)
        end
    end
end

-- [ind]: {active}
function set_grid(level)
    local mapx, mapy = level%16, level\16
    local grid = {}

    for y=0,6 do
        for x=0,6 do
            local objind = mget(mapx*8+x, mapy*8+y)
            grid[y*7+x] = {active = (objind ~= 0)}
        end
    end
    return grid
end
