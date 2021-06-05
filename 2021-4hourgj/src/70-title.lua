create_actor([[title_control;0;pos,above_map_post_camera_drawable|
    d:@1;
    tl_max_time=.5,;
    u=@2,;
]], function(a)
    local offset = 0
    if t() % 2 < .25 then offset  = sin(t()*4)*2 end
    zspr(72, 64 + offset, 38, 8, 2)

    rectfill(0, 78, 125, 86, 1)
    rectfill(0, 79, 125, 85, 0)
    if t() % 2 < 1.75 then
        print("press x or z", 64-12*2, 80, 7)
    end

    zprint("a game for ld #48", 64, 113-8-8, 0, 6, 1)
end, function(a)
    if btn(4) or btn(5) then
        g_stats.time_start = t()
        a:kill()
        g_block_context.infinite = false
        _g.fader_out(.5, nf, function() tolevel(1) end)
    end
end)
