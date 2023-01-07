-- BASIC EXAMPLE FOR SIMPLE GAME BELOW:
zclass[[test_obj,actor,drawlayer_50|x,@,y,@,color,7,init,%test_init,update,%test_update,draw,%test_draw;]]

|[test_init]|   function(a) a.color += 1                   end $$
|[test_update]| function(a) a.x += xbtn() a.y += ybtn()    end $$
|[test_draw]|   function(a) circfill(a.x, a.y, 2, a.color) end $$

zclass[[modes,actor|
    drawl,nop, drawtr,nop, drawbr,nop, curr,main, main_hover_index,0;
    defaults; init,nop, update,nop, drawl,nop, drawtr,nop, drawbr,nop;

    main;   update,%main_update, drawl,%main_drawl;
    browse; update,%main_update, drawl,%main_drawl;
]]

|[game_init]| function(a)
    a.modes = _g.modes()
    sfx(61,0)
    menuitem(2, "close picodex", function()
        menuitem(2)
        a:load'closing'
    end)
end $$

|[game_update]| function(a)
    loop_entities('modes', 'state')
end $$

|[game_draw]| function(a)
    cls()
    draw_picodex(1,
        function() a.modes:drawl() end,
        function() a.modes:drawtr() end, 
        function() a.modes:drawbr() end, 
        4)
end $$

-- if i run the minifier, we need a separate display name from the state it's mapped to.
c_modes = zobj[[
    len,6;
    0; name,"battle",  state,battle;
    1; name,"party",   state,party;
    2; name,"browse",  state,browse;
    3; name,"quiz",    state,quiz;
    4; name,"config",  state,config;
    5; name,"credits", state,credits;
]]

c_mode_positions = split"1,8,16,25,32"

|[main_update]| function(a)
    if btnp'2' or btnp'0' then a.main_hover_index = (a.main_hover_index - 1) % c_modes.len end
    if btnp'3' or btnp'1' then a.main_hover_index = (a.main_hover_index + 1) % c_modes.len end
end $$

|[main_drawl]| function(a)
        rectfill(0,14,37,23,1)

        for i=0,4 do
            local text, y = c_modes[(i+a.main_hover_index)%c_modes.len].name, c_mode_positions[i+1]
            if i == 2 then
                wobble_text(text, 19, y, 13)
            else
                zprint(text, 19, y, 1, 0)
            end
        end

end $$
