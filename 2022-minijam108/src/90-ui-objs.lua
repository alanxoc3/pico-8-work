zclass[[tile_sprite,pos|
    sx,0, sy,4,
    sw,2, sh,2,
    draw,%tile_sprite_draw
]]

|[tile_sprite_draw]| function(a)
    local midr = 7/2*TILE_RADIUS
    spr(a.sind, a.x*TILE_RADIUS+64-midr-1-a.sx, a.y*TILE_RADIUS+64-midr-1-a.sy, a.sw, a.sh)
end $$

zclass[[hermit,tile_sprite,drawlayer_50|
    x,@, y,@,
    sind,SPR_PL
]]

zclass[[snake,tile_sprite,drawlayer_50|
    x,@, y,@,
    sind,SPR_SNAKE
]]

zclass[[possible_move_obj,actor,drawlayer_50|
    x,@,y,@,
    draw,%test_draw;
]]

|[test_init]|   function(a) a.color += 1                   end $$
|[test_update]| function(a) a.x += xbtn() a.y += ybtn()    end $$
|[test_draw]|   function(a) circfill(a.x, a.y, 2, a.color) end $$
