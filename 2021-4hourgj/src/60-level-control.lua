create_actor([[next_lvl_control;1;above_map_post_camera_drawable,confined|
    bucket_control:@1;
    u:@2; d:@3;
    able_to_go_to_next_level:no;
]], function(a)
    if a.bucket_control.bucket.pl_in_bucket then
        a.able_to_go_to_next_level = true
    else
        a.able_to_go_to_next_level = false
    end

    if a.able_to_go_to_next_level and btn(3) then
        -- Yeah, this isn't very clean. Whatever.
        a.bucket_control.bucket.ang_speed = 0
        a.bucket_control.bucket.eject_player_out_of_bucket = nf
        a.bucket_control.u = nf
        a.bucket_control.dy = .1

        _g.fader_out(1, nf,
            function()
                g_stats.coins += g_level_coins
                g_stats.max_coins += g_level_max_coins
                g_level_coins = 0
                g_level_max_coins = 0

                if g_cur_level == 4 then
                    g_tl.next()
                else
                    tolevel((g_cur_level or 0) + 1)
                end
            end
        )

        a:kill()
    end
end, function(a)
    if a.able_to_go_to_next_level then
        local extra = t() % 1 < .25 and 1 or 0
        zprint("press down", 64, 96 - extra, 0, 7, 5)
    end
end)

g_puns = ztable[[
    1:"well come";
    2:"rock well";
    3:"bub wells";
    4:"not well";
]]

create_actor([[cur_level_status;0;above_map_post_camera_drawable,vec,|
    d:@1;
    x:64; y:1;
    tl_max_time=1.5,;
    tl_max_time=1,dy=-1;
]], function(a)
    if g_cur_level > 0 then
        zprint("level "..g_cur_level, a.x, a.y, 0, 7, 5)
        if g_puns[g_cur_level] then
            zprint(g_puns[g_cur_level], a.x, a.y+8, 0, 7, 5)
        end
    end
end)
