-- game logic is in this file

function game_init(a)
    _g.fader_in(.5, nf, nf)
    g_room = ztable[[ x:0; y:0; w:15; h:12; ]]
    g_pl = _g.pl(g_room.w/2, g_room.h/2)
    _g.simple_enemy(3, 2)

    -- draws the hearts at the top of the screen, with particles!
    _g.heart_particle_spawner(6.5, 1, 3)
    _g.heart_particle_spawner(9.5, 1, 2)
    _g.heart_particle_spawner(  8, 1, 1)

    _g.powerup_particle_spawner(3 , 1 , 0, 13 , 72)
    _g.powerup_particle_spawner(4 , 15, 1, 3 , 74)
    _g.powerup_particle_spawner(8 , 15, 2, 14 , 76)
    _g.powerup_particle_spawner(12, 15, 3, 12, 78)
    _g.powerup_particle_spawner(13, 1 , 4, 8 , 104)

    tbox"hello, how are^you?"
end

function game_update(a)
    batch_call_new(acts_loop, [[
        timer,     tick;
        act,       update;
        mov,       mov_update;
        pl,        move_check,@1; -- collision
        enemy,        move_check,@2; -- collision
        enemy,        move_check,@3; -- collision
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

    -- zclip(x1*8+off_x*8, y1*8+off_y*8, x2*8+off_x*8, y2*8+off_y*8)
    -- zcls(1)

    camera(-x1*8-off_x*8, -y1*8-off_y*8)

    map(0,0,0,0,15,12)

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

    -- clip()
    camera()

    batch_call_new(acts_loop, [[
        above_map_drawable, d;
        above_map_drawable_1, d;
    ]])

    tbox_draw(16,48)

    -- design below
    local y = 14.5
    -- zspr(72, 10, 118, 2, 2)
    -- scr_rect(.625   ,y+0  ,1.625   ,y+1  ,7) -- normal face
    -- scr_rect(14.375 ,y+0  ,15.375  ,y+1  ,7) -- angry face
end
