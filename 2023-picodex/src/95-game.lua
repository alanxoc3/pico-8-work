-- BASIC EXAMPLE FOR SIMPLE GAME BELOW:
zclass[[test_obj,actor,drawlayer_50|x,@,y,@,color,7,init,%test_init,update,%test_update,draw,%test_draw;]]
|[test_init]|   function(a) a.color += 1                   end $$
|[test_update]| function(a) a.x += xbtn() a.y += ybtn()    end $$
|[test_draw]|   function(a) circfill(a.x, a.y, 2, a.color) end $$

|[game_init]| function(a)
    _g.test_obj(64, 64)
    sfx(61,0)
    menuitem(1, "close picodex", function()
        menuitem(1)
        a:load'closing'
    end)

end $$

|[game_update]| function(a)
    loop_entities('actor', 'state')
end $$

|[game_draw]| function(a)
    cls()
    draw_picodex(1, nop, nop, nop, a.light)
end $$
