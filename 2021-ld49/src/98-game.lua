-- game logic is in this file

function game_init(a)
    _g.fader_in(.5, nf, nf)
    g_room = ztable[[ x:0; y:0; w:15; h:12; ]]
    g_pl = _g.pl(g_room.w/2, g_room.h/2)
    _g.simple_enemy(3, 2)

    tbox"hello, how are^you?"
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

   if g_tbox_update then
      -- zsfx(2,5)
      if g_tbox_writing then
         g_tbox_anim = #g_tbox_active.l1+#g_tbox_active.l2
      else
         del(g_tbox_messages, g_tbox_active)
         g_tbox_active, g_tbox_anim = g_tbox_messages[1], 0
      end

      -- if not g_tbox_active then
         -- unpause()
         -- g_tbox_messages.trigger()
      -- end

      g_tbox_update = false
   end

    tbox_interact()
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


        -- rectfill(16,48,112,80,0)
        -- rect(17,49,111,79,7)
        -- rect(22,54,41,74,7)
        -- print("hello, how are", 47, 58, 7)
        -- print("you? 6789012345", 47, 58+8, 7)

    tbox_draw(16,48)

    -- design below
    local y = 14.5
    scr_rect(.625   ,y+0  ,1.625   ,y+1  ,8) -- normal face
    scr_rect(14.375 ,y+0  ,15.375  ,y+1  ,8) -- angry face

    scr_rect(2.125      ,y+.125,2.125+3.75,y+.875,8) -- left
    scr_rect(6.125      ,y+.125,6.125+3.75,y+.875,8) -- middle
    scr_rect(13.875-3.75,y+.125,13.875    ,y+.875,8) -- right

    scr_rect(2.125+3.75,y+.375,6.125    ,y+.625,8) -- connect left
    scr_rect(13.875-3.75-.25,y+.375,13.875-3.75    ,y+.625,8) -- connect right

    scr_rect(5.375+.5+.125 ,.5  ,5.375+1.5+.125  ,1.5 ,8)
    scr_rect(5.375+2+.125  ,.5  ,5.375+3+.125    ,1.5 ,8)
    scr_rect(5.375+3.5+.125,.5  ,5.375+4.5+.125  ,1.5 ,8)
end
