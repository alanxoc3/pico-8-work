zclass[[tile_sprite,pos|
    sw,2, sh,2,
    draw,%tile_sprite_draw
]]

|[tile_sprite_draw]| function(a)
    local midr = 7/2*TILE_RADIUS
    spr(a.sind, a.x*TILE_RADIUS+cx-midr-1+8, a.y*TILE_RADIUS+cy-midr-1+8, a.sw, a.sh)
end $$

zclass[[hermit,tile_sprite,drawlayer_50|
    x,@, y,@,
    sind,SPR_PL
]]

zclass[[possible_move_obj,actor,drawlayer_50|
    x,@,y,@,
    draw,%test_draw;
]]

|[test_init]|   function(a) a.color += 1                   end $$
|[test_update]| function(a) a.x += xbtn() a.y += ybtn()    end $$
|[test_draw]|   function(a) circfill(a.x, a.y, 2, a.color) end $$
