function credits_init(a)
    _g.fader_in(.5, nf, function() g_credits_enabled = true end)
    g_credits_enabled = false
    credits_o=0
end

function credits_update(a)
    if g_credits_enabled and (btn(4) or btn(5)) then
        g_credits_enabled = false
        _g.fader_out(.5, nf, function()
            g_tl:next()
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

    zspr(200, 64, 16, 8, 3)
    print("credits!", 64, 64, 8)

    local base = 48
    zspr(72 ,   16    , base   , 2, 2) zprint("hello", 16+12, base-1, _g.c_color_normal, -1)
    zspr(74 ,   128-16, base+16, 2, 2) zprint("hello", 128-16-12, base+16-1, _g.c_color_normal, -1)
    zspr(76 ,   16    , base+32, 2, 2) zprint("hello", 16+12, base+32-1, _g.c_color_normal, -1)
    zspr(78 ,   128-16, base+48, 2, 2) zprint("hello", 128-16-12, base+48-1, _g.c_color_normal, -1)
    zspr(104,  16     , base+64, 2, 2) zprint("hello", 16+12, base+64-1, _g.c_color_normal, -1)


--    zspr(72,  64+cos(t()/5+.0)*45, 64+sin(t()/3+.0)*45, 2, 2, t() % 5 < 2.5, false)
--    zspr(74,  64+cos(t()/5+.2)*45, 64+sin(t()/3+.2)*45, 2, 2, false, t() % 5 > 2.5)
--    zspr(76,  64+cos(t()/5+.4)*45, 64+sin(t()/3+.4)*45, 2, 2, t() % 5 < 2.5, false)
--    zspr(78,  64+cos(t()/5+.6)*45, 64+sin(t()/3+.6)*45, 2, 2, t() % 5 > 2.5, false)
--    zspr(104, 64+cos(t()/5+.8)*45, 64+sin(t()/3+.8)*45, 2, 2, false, t() % 5 < 2.5)

end
