-- BASIC EXAMPLE FOR SIMPLE GAME BELOW:
zclass[[test_obj,actor,drawlayer_50|x,@,y,@,color,7,init,%test_init,update,%test_update,draw,%test_draw;]]
|[test_init]|   function(a) a.color += 1                   end $$
|[test_update]| function(a) a.x += xbtn() a.y += ybtn()    end $$
|[test_draw]|   function(a) circfill(a.x, a.y, 2, a.color) end $$

|[game_init]| function()
    _g.fader_in()
    cube = create_dice(64, 64)
    cube.dir = 1
    _g.test_obj(64, 64)
end $$

|[game_update]| function()
    if btnp(0) then cube.dir = -1 elseif btnp(1) then cube.dir = 1 end
    if btn(4) then cube:roll(cube.dir)
              else cube:sit() end

    loop_entities('actor', 'state')
end $$

|[game_draw]| function()
    rect(0, 0, 127, 127, 8)
    loop_entities('drawlayer_50', 'draw')
end $$
