create_actor([[falling_clown;3;mov,drawable,spr|
    x:@1; y:@2;
    sind:30;
    ay:.015;
    tl_max_time=5,;
]])

create_actor([[clown_hold_balloon;1;dim,col,mov,rel,bad|
    touchable:no;
    rel_actor:@1;
    rel_y:1;
    destroyed:@2;
]], function(a)
    _g.falling_clown(a.x, a.y, a.rel_actor.xf)
end)

create_actor([[clownballoon;2;confined,col,knock,drawable,spr,vec,mov|
    balloon:yes;
    x:@1; y:@2;
    ry:.5;
    iyy:4;
    ix:.99; iy:.99;
    sind:38; sh:2;
    touchable:no;

    i:@3;
    u:@4;
    destroyed:@5;
    pop:@6;
]], function(a)
    _g.clown_hold_balloon(a)
end, function(a)
    local pl = get_pl()
    a.xf = sgn(pl.x - a.x) == -1
    amov_to_point(a, .005, pl.x, pl.y - 2)
end, function(a)
    if a.popped then
        -- _g.coin(a.x, a.y+.75)
        sfx'3'
    end
end, function(a)
    a.popped = true
    a:kill()
end)

create_actor([[clown_spawner;0;confined,col,knock,drawable,spr,vec,mov|
    tl_loop:yes;
    fall_count:3;

    i=nf,u=nf,wait_state=yes,tl_max_time=6,;
    i=@1,u=@2,wait_state=no,;
]], function(a)
    local ang = rnd(1)
    local radius = 12
    sfx'14'
    a.clown = _g.clownballoon(g_bucket_control.x + cos(ang)*radius, g_bucket_control.y + sin(ang)*radius)
end, function(a)
    if not a.clown or not a.clown.alive then
        a.fall_count -= 1

        if a.fall_count <= 0 then
            g_block_context.infinite = false
            -- g_block_context.room.h += 10
            a:kill()
        else
            a.wait_state = true
            a:next()
        end
    end
end)
