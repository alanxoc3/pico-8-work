-- game logic is in this file

function game_init(a)
    _g.fader_in(.5, nf, nf)
    g_floormap = create_map()
    g_room = ztable[[ x:0; y:0; w:128; h:32; ]]
    g_pl = _g.pl(4, 4)
    g_view = _g.view(15, 15, 4, g_pl)
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

    -- tbox"hello, how are^you?"
end

function game_update(a)
    batch_call_new(acts_loop, [[
        timer,     tick;
        act,       update;
        mov,       mov_update;
        pl,        move_check,@1; -- collision
        enemy,        move_check,@2; -- collision
        enemy,        move_check,@3; -- collision
        tcol,coll_tile,@4;
        rel,       rel_update;
        vec,       vec_update;
        x_bounded, check_bounds_x;
        y_bounded, check_bounds_y;
        view,update_view;
        act,       clean;

    ]], g_act_arrs['col'], g_act_arrs['pl'], g_act_arrs['fist'], function(x, y)
        return x >= g_room.x and x < g_room.x+g_room.w and
            y >= g_room.y and y < g_room.y+g_room.h and
            fget(mget(x, y), 0)
    end)

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

function shiftx(view) return (view.x-view.off_x-8)*8 end
function shifty(view) return (view.y-view.off_y-8)*8 end
function camera_to_view(view) camera(shiftx(view), shifty(view)) end

function game_draw(a)
    fade(g_card_fade)

    local x, y = 8, 8
    local rx = x - g_view.w/2
    local ry = y - g_view.h/2

    g_view.off_x = -(16-g_view.w)/2+rx
    g_view.off_y = -(16-g_view.h)/2+ry

    local x1, x2 = rx*8+4, (rx+g_view.w)*8-5
    local y1, y2 = ry*8+4, (ry+g_view.h)*8-5
    camera_to_view(g_view)

    scr_map(0,0,0,0,128,32) 

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

    -- Draw minimap.
    for mx=1,g_floormap.width do
        for my=1,g_floormap.height do
            local color = g_floormap.map[mx][my].type == 0 and 8 or 9
            pset(94+mx, 94+my, color)
        end
    end
end
