-- game logic is in this file

function title_init(a)
    _g.fader_in(.5, nf, function() g_title_enabled = true end)
    g_title_enabled = false
    title_o=0
end

function title_update(a)
    if g_title_enabled and (btn(4) or btn(5)) then
        g_title_enabled = false
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

    cls()
    title_b=-1
    title_t=-1
    title_o=title_o+.04

    rectfill(0,64,127,300,1)
    for title_i=0,32 do
        title_c=5
        title_r=title_i+64
        l=64-title_i
        if (64/(title_i+7)+title_o)%2<1 then
            title_w=title_i/12
            title_c=13 title_t=l title_b=title_r
        end

        line(l-32,title_t,l-32,title_b,title_c)
        line(title_r+32,title_t,title_r+32,title_b,title_c)
    end

    rectfill(64-40, 32-20, 64+40, 32+20, 0)
    zspr(200, 64+1, 64+5, 8, 3)
end
