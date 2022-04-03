zclass[[pl,actor,model,drawable|
    x,@, y,@,
    missile_ready,yes,
    model_obj,%PLAYER_SPACESHIP,
    update,%pl_update,
    hit,%pl_hit,
    collision_func,%good_collision_circ
]]

|pl_update| function(a)
    if btn'4' and a.missile_ready then
        _g.missile(a.x+cos(a.ang)*.8,a.y+sin(a.ang)*.8,a.ang)
        a.missile_ready = false
        a:set_timer('missile_cooldown', 0.1, function() a.missile_ready=true end)
    end
    a.speed = -ybtn()*.01
    a.d_ang = -xbtn()*.01
end $$

|pl_hit| function(a, b, dx, dy)
    a.dx += dx
    a.dy += dy
    a:explode()
    b:explode()
end $$
