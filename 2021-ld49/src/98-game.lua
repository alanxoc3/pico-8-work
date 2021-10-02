-- game logic is in this file

function game_init(a)
    _g.fader_in(.5, nf, nf)
    g_room = ztable[[ x:0; y:0; w:15; h:8; ]]
    g_pl = _g.pl(g_room.w/2, g_room.h/2)
    _g.simple_enemy(3, 2)
end

function game_update(a)
    batch_call_new(acts_loop, [[
        timer,     tick;
        act,       update;
        mov,       mov_update;
        pl,        move_check,@1; -- collision
        simple_enemy,        move_check,@2; -- collision
        simple_enemy,        move_check,@3; -- collision
        rel,       rel_update;
        vec,       vec_update;
        x_bounded, check_bounds_x;
        y_bounded, check_bounds_y;
        act,       clean;
    ]], g_act_arrs['col'], g_act_arrs['pl'], g_act_arrs['fist'])
end

function game_draw(a)
    fade(g_card_fade)

    local x1, x2, y1, y2 = 8-g_room.w/2, 8+g_room.w/2-1/8, 8-g_room.h/2, 8+g_room.h/2-1/8
    local off_x, off_y = 0, 0

    zclip(x1*8+off_x*8, y1*8+off_y*8, x2*8+off_x*8, y2*8+off_y*8)
    zcls(1)

    camera(-x1*8-off_x*8, -y1*8-off_y*8)

    -- unneeded rectangle:
    rect(0, 2, 10, 10, 7, 8)

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
