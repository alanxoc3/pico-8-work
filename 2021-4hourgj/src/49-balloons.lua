create_parent([[balloon;0;confined,col,knock,drawable,spr|
    balloon:yes;
    touchable:no;
    popped:no;
    pop:@1;
]], function(a)
    a.popped = true
    a:kill()
end)

create_actor([[simpleballoon;2;balloon,|
    x:@1; y:@2;
    dy:-.05;
    destroyed:@3;
    sh:2;
    iyy:6;
    i:@4;
    tl_max_time=10,;
]], function(a)
    if a.popped then
        sfx'3'
    end
end, function(a)
    a.xf = flr_rnd(2) == 0
    a.sind = rnd_item{36, 37, 39, 40}
end)

create_actor([[bubble;2;balloon,mov|
    x:@1; y:@2; sind:46;
    destroyed:@3;
    i:@6;
    u=@5,;
    i=@4,u=nf,tl_max_time=10,;
]], function(a)
    if a.popped then
        sfx'3'
    end
end, function(a)
    local pl = get_pl()
    amov_to_point(a, .01, pl.x, pl.y)
end, function(a)
    local pl = get_pl()
    if pl.y > a.y + 3 then
        a:next()
    end
end, function(a)
    a.xf = flr_rnd(2) == 0
end)

create_actor([[coin_bubble;2;balloon,mov|
    x:@1; y:@2; sind:42;
    destroyed:@3;
    i:@6;
    u=@5,;
    i=@4,u=nf,tl_max_time=10,;
]], function(a)
    g_level_max_coins += 1
    if a.popped then
        g_level_coins += 1
        sfx'3'
    end
end, function(a)
    local pl = get_pl()
    amov_to_point(a, .01, pl.x, pl.y)
end, function(a)
    local pl = get_pl()
    if pl.y > a.y + 3 then
        a:next()
    end
end, function(a)
    a.xf = flr_rnd(2) == 0
end)

create_actor([[clown_bubble;2;balloon,bad,mov|
    x:@1; y:@2; sind:44;
    destroyed:@3;
    i:@6;
    u=@5,;
    i=@4,u=nf,tl_max_time=10,;
]], function(a)
    if a.popped then
        sfx'3'
    end
end, function(a)
    local pl = get_pl()
    amov_to_point(a, .01, pl.x, pl.y)
end, function(a)
    local pl = get_pl()
    if pl.y > a.y + 3 then
        a:next()
    end
end, function(a)
    a.xf = flr_rnd(2) == 0
end)
