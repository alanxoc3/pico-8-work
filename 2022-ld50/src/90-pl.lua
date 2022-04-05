zclass[[pl,actor,model,drawable,team_blue|
    x,@, y,@,
    missile_ready,yes,
    model,%PLAYER_SPACESHIP,
    update,%pl_update,
    hit,%pl_hit,
    collision_func,%good_collision_circ,
]]

|pl_update| function(a)
    if btn'4' and a.missile_ready then
        _g.missile(a.x+cos(a.ang)*.8,a.y+sin(a.ang)*.8,a.dx,a.dy,a.ang)
        a.missile_ready = false
        a:start_timer('missile_cooldown', 0.1, function() a.missile_ready=true end)
    end

    if ybtn() > 0 then
        a.speed = -.005
    elseif ybtn() < 0 then
        a.speed = .01
    else
        a.speed = 0
    end

    
    a.d_ang = -xbtn()*.01
end $$

|pl_hit| function(a, b, dx, dy)
    if b.parents['team_blue'] then -- if same team as player, just bump
        if b.id == 'zipper' then return end
        a.dx += dx
        a.dy += dy
    else
        a:explode()
    end
end $$

zclass[[pl_alert,anchor_pos,actor,drawable|
    alert_radar,@, anchoring,@, pointing_to,@,
    model, %PLAYER_ALERT,
    update, %pl_alert_update,
    dist, 0, scale,1,
    destroyed, %pl_alert_destroy,
    draw, %pl_alert_draw;

    start;duration,1, next,normal;
    normal;,;
    dying;duration,.25, update,nop, next,wait;
    wait;duration,1, draw,nop
]]

|pl_alert_destroy| function(a)
    a.alert_radar.alerts[a.pointing_to] = nil
end $$

|pl_alert_update| function(a)
    if a.anchoring.alive and a.pointing_to.alive then
        local x, y = a.pointing_to.x-a.anchoring.x, a.pointing_to.y-a.anchoring.y
        a.ang = atan2(x, y)
        a.dist = dist_between_circles(a.pointing_to, a.anchoring)
    else
        if a.curr == 'normal' then a:load'dying' end
    end
end $$

|pl_alert_draw| function(a)
    local dist = max(1, a.dist/2)
    local scale = 1
    if a.curr == 'dying' then
        scale = 1-a:get_elapsed_percent[[state]]
    end

    if dist > 2 then
        local minimize = 12
        local x1, y1 = a.x+cos(a.ang)*1.5, a.y+sin(a.ang)*1.5
        local x2, y2 = x1+cos(a.ang)*dist/minimize*scale, y1+sin(a.ang)*dist/minimize*scale
        line(zoomx(x1), zoomy(y1), zoomx(x2), zoomy(y2), a.pointing_to.alert_color or 7)
    end
end $$

zclass[[alert_radar,anchor_pos|
    alerts;,;
    anchoring,@,
    model,%ALERT_RADAR_CIRC,
    register, %alert_radar_register,
    update, %alert_radar_update,
    draw, %pl_alert_draw,
]]

|alert_radar_register| function(a, others)
    foreach(others, function(other)
        if not a.alerts[other] then
            a.alerts[other] = _g.pl_alert(a, a.anchoring, other)
        end
    end)
end $$
