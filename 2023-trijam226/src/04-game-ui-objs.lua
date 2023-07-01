create_actor([[heart_particle_spawner;3;particle_spawner/.125/.125/1/3/%slow_small_ui_particle,above_map_drawable_1|
    x:@1; y:@2; heart_number:@3; u:@4; d:@5; color: 8;
]], function(a)
    if g_pl.health < a.heart_number then
        a.hidden = true
    else
        a:update_particles()
        a.hidden = false
    end
end, function(a)
    if not a.hidden then
        zspr(16, a.x*8, a.y*8+1)
    end
end)

create_actor([[powerup_particle_spawner;5;particle_spawner/2/.125/1/1/%slow_medium_ui_particle,above_map_drawable_1|
    x:@1; y:@2; powerup_level:@3; color:@4; sind:@5; u:@6; d:@7
]], function(a)
    if g_pl.alive and g_pl.strength == a.powerup_level then
        a:update_particles()
    end
end, function(a)
    if g_pl.alive and g_pl.strength == a.powerup_level then
        zspr(a.sind, a.x*8, a.y*8, 2, 2, g_pl.is_facing_left, false)
    end
end)

SBULLET=0
SHEARTS=1
SRELOAD=2
SHASTEN=3
create_actor([[statsels;0;above_map_drawable,confined|
    ry:.25;
    sel:0; -- 0:tl 1:tr 2:bl 3:br 4:go 5:no
    radius:.2;
    touchable:no;
    i:@1;
    d:@2;
    u:@3;
    modstat:@4;
]], function(a)
    a.stats = {
        [SBULLET] = 2,
        [SHEARTS] = 2,
        [SRELOAD] = 2,
        [SHASTEN] = 2,
    }
end, function(a)
    for i=0,3 do
        local col = i == a.sel and 3 or 2
        if i == a.sel then
            rectfill(0, 98+8*i-1, 127, 98+8*i+7-2, 1)
        end
        rectfill(a.stats[i]*8+31+19+8, 98+8*i-1,
                 a.stats[i]*8+37+19+8, 98+8*i+7-2, col)
    end

    zprint("bullet 1 2 3", 64, 98+8*0, 13, 0)
    zprint("hearts 1 2 3", 64, 98+8*1, 13, 0)
    zprint("reload 1 2 3", 64, 98+8*2, 13, 0)
    zprint("hasten 1 2 3", 64, 98+8*3, 13, 0)

end, function(a)
  if btn(5) then
    a.sel = mid(0, 3, a.sel+ybtnp())
    a:modstat(a.sel, xbtnp())
  end
end, function(a, s, d)
    local curr = a.stats[s]
    local new = mid(1, 3, curr+d)
    if new ~= curr then
        a.stats[s] = new
        for i=1,3 do
            local ind = (s+i)%4
            local nn = mid(1, 3, a.stats[ind] - d)
            if nn ~= a.stats[ind] then
                a.stats[ind] = nn
                break
            end
        end
    end
end)

create_actor([[objective_arrow;2;post_drawable_2,confined|
    x:@1; y:@2; u:@3; d:@4;
    ry:.25;
    radius:.2;
    touchable:no;
    smallest_dist:0;
]], function(a)
    local smallest_dist
    local objective

    for g_ind in all{'bad_character', 'portal'} do
        for b in all(g_act_arrs[g_ind]) do
            local dist = approx_dist(g_pl.x-b.x, g_pl.y-b.y)
            if not smallest_dist or dist < smallest_dist then
                smallest_dist = dist
                objective = b
            end
        end
    end

    a.smallest_dist = smallest_dist
    a.objective = objective
end, function(a)
    if a.objective and a.smallest_dist > 3.5 then
        local dir = atan2(a.objective.x - g_pl.x, a.objective.y - g_pl.y)
        dir = round(dir*16)/16
        local dx = cos(dir)
        local dy = sin(dir)
        local offy = -.5
        local color = 1

        local len_multiplier = 1.75
        if t() % .5 < .25 then
            len_multiplier *= 1.125
        end

        local x1=g_pl.x+dx
        local y1=offy+g_pl.y+dy
        local x2=g_pl.x+dx*len_multiplier
        local y2=offy+g_pl.y+dy*len_multiplier

        scr_line(x1, y1, x2, y2, color)

        local turn=.375
        local length=.375
        local x3=x2+cos(dir+turn)*length
        local y3=y2+sin(dir+turn)*length
        local x4=x2+cos(dir-turn)*length
        local y4=y2+sin(dir-turn)*length
        scr_line(x2, y2, x3, y3, color)
        scr_line(x2, y2, x4, y4, color)
    end
end)
