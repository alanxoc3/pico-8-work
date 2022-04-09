zclass[[pl,actor,model,drawlayer_20,team_blue|
    x,@, y,@,
    missile_ready,yes,
    model,%PLAYER_SPACESHIP,
    shoot_percent,1, shoot_enabled,yes,
    hit,%pl_hit,
    collision_func,%good_collision_circ;
    start;duration,1.5,next,run;
    run;update,%pl_update,
]]

|pl_update| function(a)
    a.shoot_percent = min(1,a.shoot_percent+.01)
    if a.shoot_percent == 1 then
        a.shoot_enabled = true
    end

    if (btn'5' or btn'4') and a.missile_ready then
        a.shoot_percent = max(0,a.shoot_percent-.125)
        _g.missile(a.x+cos(a.ang)*.8,a.y+sin(a.ang)*.8,a.dx,a.dy,a.ang)
        a.missile_ready = false
        a:start_timer('missile_cooldown', 0.15, function() a.missile_ready=true end)
        if a.shoot_percent == 0 then a.shoot_enabled = false end
    end

    if ybtn() > 0 then
        a.speed = -.00875*.75
    elseif ybtn() < 0 then
        a.speed = .01*.75
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
        if b.id == "chaser" then b:explode() end
    end
end $$

zclass[[pl_alert,anchor_pos,actor,drawlayer_30|
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
        local x2, y2 = x1+cos(a.ang)*min(1,dist/minimize*scale), y1+sin(a.ang)*min(1,dist/minimize*scale)

        -- fillp(0b0100111100101111)
        line(zoomx(x1), zoomy(y1), zoomx(x2), zoomy(y2), a.pointing_to.alert_color or 7)
        -- fillp()
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

zclass[[bar,actor,anchor_pos,drawlayer_03|
    anchoring,@, percent_func,@, fg,@, initial_rmin,@, initial_rmax,@, timeout,@,
    rmin,0,rmax,0,
    draw,%bar_draw,
    percent,1;
    start;duration,.1, update,%bar_update_starting, next,run;
    run;duration,~timeout, next,dying, update,%bar_update;
    dying;duration,.1,update,%bar_update_dying;
]]

|bar_update_starting| function(a)
    a.rmin = a:get_elapsed_percent'state'*a.initial_rmin
    a.rmax = a:get_elapsed_percent'state'*a.initial_rmax
end $$

|bar_update_dying| function(a)
    a.rmin = a.initial_rmin - a:get_elapsed_percent'state'*a.initial_rmin
    a.rmax = a.initial_rmax - a:get_elapsed_percent'state'*a.initial_rmax
end $$

|bar_update| function(a)
    local prev_percent = a.percent
    a.percent = a.percent_func()
    if not a.anchoring.alive then a:load'dying'
    elseif prev_percent ~= a.percent then a:load"run" end
end $$

|bar_draw| function(a)
    fillp(0b0111101111011110)
    zcircfill(a.x, a.y, a.rmin, a.fg)
    fillp()

    local rad = (a.rmax-a.rmin)*a.percent+a.rmin
    circ(zoomx(a.x), zoomy(a.y), zoom(rad), a.fg)
    circ(zoomx(a.x), zoomy(a.y), zoom(rad)-1, 0)
end $$

function zcircfill(x, y, rad, col) circfill(zoomx(x), zoomy(y), zoom(rad), col) end
