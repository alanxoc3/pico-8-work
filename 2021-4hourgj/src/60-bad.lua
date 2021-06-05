create_actor([[wallspike;4;drawable,confined,spr,bad,kill_too_high|
    x:@1; y:@2; sind:@3; xf:@4;
    rx:.25;
    touchable:no;
    i:@5;
]], function(a)
    if a.xf then
        a.ixx = 3
    else
        a.ixx = -3
    end
end)

create_actor([[minispike;4;drawable,confined,spr,bad,kill_too_high|
    x:@1; y:@2; sind:@3; xf:@4;
    ry:.25;
    iyy:-2;
    touchable:no;
]])

create_actor([[boulder_spawner;4;confined,pos,dim,above_map_post_camera_drawable|
    x:@1; y:@2; sind:@3; xf:@4;
    u:@5; d:@6;
]], function(a)
    if a.y < g_main_view.y - g_main_view.h/2 - 3 then
        _g.boulder(a.x, a.y, a.sind, a.xf)
        a:kill()
    end
end, function(a)
    if a.y < g_main_view.y - g_main_view.h/2 then
        zprint("!",  a.x*8-shiftx(g_main_view), 1, 0, 8, 2)
    end
end)

create_actor([[boulder;4;confined,bad,pos,drawable,spr,vec|
    x:@1; y:@2; sind:@3; xf:@4;
    dy:.2;
    rx:.25; ry:.25;
    touchable:no;
    tl_max_time=10,;
]])

create_actor([[coin;2;confined,vec,drawable,spr,mov,col,kill_too_high|
    touchable:no;
    sind:41;
    x:@1;y:@2;
    rx:.25; ry:.25;

    destroyed:@3;
    obtain:@4;
]], function(a)
    g_level_max_coins += 1
    if a.obtained then
        g_level_coins += 1
        sfx(1)
    end
end, function(a)
    a.obtained = true
    a:kill()
end)

create_actor([[danger_spawner;3;confined,pos,dim,above_map_post_camera_drawable|
    x:@1; y:@2; spawn_func:@3;
    u:@4;d:@5;
]], function(a)
    if a.y < g_main_view.y + g_main_view.h/2 + 3 then
        a.spawn_func(a.x, a.y)
        a:kill()
    end
end, function(a)
    if a.y < g_main_view.y + g_main_view.h/2 + 6 then
        zprint("!",  a.x*8-shiftx(g_main_view), 128-8-7, 0, 8, 2)
    end
end)

create_actor([[nice_spawner;3;confined,pos,dim,above_map_post_camera_drawable|
    x:@1; y:@2; spawn_func:@3;
    u:@4;d:@5;
]], function(a)
    if a.y < g_main_view.y + g_main_view.h/2 + 3 then
        a.spawn_func(a.x, a.y)
        a:kill()
    end
end, function(a)
    if a.y < g_main_view.y + g_main_view.h/2 + 6 then
        zprint("!",  a.x*8-shiftx(g_main_view), 128-8-7, 0, 10, 4)
    end
end)
