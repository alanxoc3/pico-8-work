-- game logic is in this file

function game_init(a)
    _g.fader_in(.5, nf, nf)
    g_view = ztable[[ off_x:0; off_y:0; ]]
    g_room = ztable[[ w:15; h:8; ]]
end

function game_update(a)
    batch_call_new(acts_loop, [[
        act, update;
        act, clean;
    ]])
end

function game_draw(a)
    fade(g_card_fade)

    local x1, x2, y1, y2 = 8-g_room.w/2, 8+g_room.w/2, 8-g_room.h/2, 8+g_room.h/2
    local off_x, off_y = 0, 0

    camera(-off_x*8, -off_y*8)
    zclip(x1*8+off_x*8, y1*8+off_y*8, x2*8+off_x*8, y2*8+off_y*8)
    zcls(1)
    zrect(x1*8+5, y1*8+5, x2*8-5, y2*8-5)

    batch_call_new(acts_loop, [[
        pre_drawable, d;
        pre_drawable_1, d;
        pre_drawable_2, d;
    ]])

    isorty(g_act_arrs.drawable)
    batch_call_new(acts_loop, [[
        drawable,        d;
        drawable_1,      d;
        drawable_2,      d;
        post_drawable,   d;
        post_drawable_1, d;
        post_drawable_2, d;
    ]])

    -- DEBUG_BEGIN
    if g_debug then acts_loop('dim', 'debug_rect') end
    -- DEBUG_END

    clip()
    camera()
end
