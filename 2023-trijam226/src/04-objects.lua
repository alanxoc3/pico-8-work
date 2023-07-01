-- this file has objects that appear in rooms

create_actor([[portal;2;col,pre_drawable,confined|
    x:@1; y:@2; u:@3; d:@4;
    rx:.125;
    ry:.125;
    radius:.2;
    touchable:no;
]], function(a)
    if not a:any_timer_active('spawn', 'die') then
        a:create_timer('spawn', 40, function()
            local baddie = rnd_item{_g.bad_nurse, _g.bad_police, _g.bad_patient}
            baddie(a.x, a.y, false)
            a:create_timer('die', 15, function()
                a.alive = false
            end)
        end)
    end

    if a:any_timer_active('spawn') then
        a.radius=.2+a:get_timer_percent'spawn'*.6
    elseif a:any_timer_active('die') then
        a.radius=.8-a:get_timer_percent'die'*.6
    end

    _g.powerup_particle(a.x+rnd(.5)-.25, a.y+rnd(.5)-.25, rnd_item{1,2})
end, function(a)
    scr_ovalfill(a.x-a.radius, a.y-.2, a.x+a.radius, a.y+.2, 1)
end)

create_actor([[portal_spawner;0;confined,|
    u:@1;
]], function(a)
    if not a:any_timer_active('cooldown') then
        a:create_timer('cooldown', 5*60, function()
            _g.portal(flr_rnd(g_room.w-4)+2, flr_rnd(g_room.h-4)+2)
        end)
    end
end)
