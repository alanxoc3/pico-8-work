create_actor([[pl_meow;1;post_drawable,rel,confined|
    rel_actor:@1;
    d:@2;
    u:@3;
    i:@4;
]], function(a)
    zprint("meow", (a.x+a.dx)*8, (a.y+a.dy)*8-2*8, 0, 11, 1)
end, function(a)
    if not btn(5) then
        a:kill()
    end
end, function(a)
    sfx'0'
end)

create_actor([[pl;2;drawable,spr,mov,tcol,col,confined,bounded|
    x:@1; y:@2;
    sw:2; sh:2;
    xf:no;
    ix:.90; iy:.98;
    touching_ground:no;
    jump_speed:.5;
    sind:6;
    ay:.01;
    u:@3;
    tile_hit:@4;
    ,;
    i=@5,u=nf;
]], function(a)
    local above_water = a.y < 14

    a.ax = 0
    if above_water then
        a.ax = .02*xbtn()
        if xbtn() > 0 then a.xf = false end
        if xbtn() < 0 then a.xf = true end
        if a.touching_ground and btn(4)  then
            a.dy = -a.jump_speed
            sfx'1'
        end

        if btn(5) and (not a.meow or not a.meow.alive) then
            a.meow = _g.pl_meow(a)
        end

        if not a.touching_ground then
            if a.dy < -.1 then
                a.sind = 70
            elseif a.dy < .05 then
                a.sind = 72
            else
                a.sind = 74
            end
        elseif xbtn() ~= 0 then
            local s = .25
            local tmods = t() % s
            if tmods < .25*s then
                a.sind = 64
            elseif tmods < .5*s then
                a.sind = 66
            elseif tmods < .75*s then
                a.sind = 96
            else
                a.sind = 68
            end
        else
            a.sind = t() % 1 < .25 and 96 or 64
        end
    else
        a:next()
    end
    a.touching_ground = false
end, function(a, dir)
    local above_water = a.y < 14
    if above_water then
        if dir == 3 then a.touching_ground = true end
    end
end, function(a)
    _g.fader_out(.5, nf, function()
         a:kill()
         game_init()
    end)
end)
