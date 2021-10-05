function credits_init(a)
    _g.fader_in(.5, nf, function() g_credits_enabled = true end)
    g_credits_enabled = false
    credits_o=0
end

function credits_update(a)
    if g_credits_enabled and (btn(4) or btn(5)) then
        g_credits_enabled = false
        _g.fader_out(.5, nf, function()
            g_tl.tl_next = 2
        end)
    end

    batch_call_new(acts_loop, [[
        timer, tick;
        act,   update;
        act,   clean;
    ]])
end

function credits_draw(a)
    fade(g_card_fade)

    zspr(200, 64, 16+8, 8, 3)

    local base = 48
    zspr(72 , 16, base   , 2, 2)
    zspr(74 , 16, base+16, 2, 2)
    zspr(76 , 16, base+32, 2, 2)
    zspr(78 , 16, base+48, 2, 2)
    zspr(104, 16, base+64, 2, 2)

    local diagnosis
    if g_endgame_stats.frames < 3600 then
        diagnosis = "skittish"
    elseif g_endgame_stats.enemy_kill_count == 0 then
        diagnosis = "healthy"
    elseif g_endgame_stats.enemy_kill_count == g_endgame_stats.enemy_total_count then
        if g_endgame_stats.deaths == 0 then
            if g_endgame_stats.frames < 10800 then 
                diagnosis = "unbelievable"
            else
                diagnosis = "impressive"
            end 
        else
            diagnosis = "insane"
        end
    else
        diagnosis = "unstable"
    end

    zprint("diagnosis: "..diagnosis                                                            , 16+12, base-1     , 13, -1)
    zprint('- - - - - - - - - - - - - - - - - - - - - - -'                                     , 16+12, base+8-1   , 1 , -1)
    zprint("kills : "..g_endgame_stats.enemy_kill_count.."/"..g_endgame_stats.enemy_total_count, 16+12, base+16-1  , 3 , -1)
    zprint("deaths: "..g_endgame_stats.deaths                                                  , 16+12, base+16+8-1, 4 , -1)
    zprint("time  : "..format_time()                                                           , 16+12, base+32-1  , 9 , -1)
    zprint('- - - - - - - - - - - - - - - - - - - - - - -'                                     , 16+12, base+32+8-1, 1 , -1)
    zprint("@alanxoc3: code/music"                                                             , 16+12, base+48-1  , 12, -1)
    zprint("@denial: code/design"                                                              , 16+12, base+48+8-1, 14, -1)
    zprint("@thegreatcadet: gfx/map"                                                           , 16+12, base+64-1  , 8 , -1)
end
