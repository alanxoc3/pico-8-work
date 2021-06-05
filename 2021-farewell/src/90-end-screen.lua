function end_init()
    music(0,2000)
    batch_call_new(acts_loop, [[
        confined,room_end;
        confined,kill;
        confined,delete
    ]])

    g_stats.total_time = flr(t() - g_stats.time_start)
    _g.fader_in(.5, nf, nf)
    g_card_fade = 8
end

function end_update()
    batch_call_new(acts_loop, [[act,update;]])
end

function end_draw()
    fade(g_card_fade)
    -- rect(0,0,127,127,8)

    zspr(134, 64, 36, 10, 8)

    -- zprint("made for ludum dare #48", 64, 68, 0, 7, 5)
    zprint("you win!", 64, 68, 0, 11, 1)

    draw_stats(89-4)

    zprint("@alanxoc3       code & sfx   ", 64, 118-8-8, 0, 6, 1)
    zprint("@thegreatcadet  gfx & sfx    ", 64, 118-8, 0, 6, 1)
    zprint("@codecodymorgan gfx & design ", 64, 118, 0, 6, 1)
end

function seconds_to_str(d)
    local seconds = flr(d % 60)
    local minutes = flr(d / 60)
    return ""..minutes.."M "..seconds.."S"
end

function draw_stats(y)
    rect(-1, y-7, 128, y+12, 1)

    zprint("time : "..seconds_to_str(g_stats.total_time), 6, y-4, -1, 15, 2)
    zprint("shots: "..g_stats.shots, 6, y+4, -1, 12, 1)
    zprint("died : "..g_stats.deaths, 70, y-4, -1, 8, 2)
    zprint("coins: "..g_stats.coins.."/"..g_stats.max_coins, 70, y+4, -1, 10, 4)
end
