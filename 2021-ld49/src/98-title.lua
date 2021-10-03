-- game logic is in this file

function disable_looping_on_music(music_num)
    local addr = 0x3101 + music_num*4
    poke(addr, 0b01111111 & peek(addr))
end

function title_init(a)
    _g.fader_in(.5, nf, function() g_title_enabled = true end)
    g_title_enabled = false
    title_o=0
end

function title_update(a)
    if g_title_enabled and (btn(4) or btn(5)) then
        g_title_enabled = false
        disable_looping_on_music(2) -- i can now use looping effectively!
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

function title_draw(a)
    fade(g_card_fade)

    zspr(72,  64+cos(t()/5+.0)*45, 64+sin(t()/3+.0)*45, 2, 2, t() % 5 < 2.5, false)
    zspr(74,  64+cos(t()/5+.2)*45, 64+sin(t()/3+.2)*45, 2, 2, false, t() % 5 > 2.5)
    zspr(76,  64+cos(t()/5+.4)*45, 64+sin(t()/3+.4)*45, 2, 2, t() % 5 < 2.5, false)
    zspr(78,  64+cos(t()/5+.6)*45, 64+sin(t()/3+.6)*45, 2, 2, t() % 5 > 2.5, false)
    zspr(104, 64+cos(t()/5+.8)*45, 64+sin(t()/3+.8)*45, 2, 2, false, t() % 5 < 2.5)

    zspr(200, 64, 64, 8, 3)
end
