-- game logic is in this file
-- 3 rooms: dungeon, void, hospital

function reset_the_dungeon()
    _g.fader_in(.5, nf, nf)
    g_room = ztable[[ x:0; y:0; w:128; h:32; ]]
    -- g_pl = _g.pl_monster_control(4, 4)
    -- g_pl = _g.pl_patient_control_passive(4, 4)

    -- DEBUG_BEGIN
    if _g.c_is_patient then
        g_pl = _g.pl_patient_control_fight(7, 7)
    else
        g_pl = _g.pl_monster_control(7, 7)
    end
    -- DEBUG_BEGIN

    g_view = _g.view(15.25, 11.5, 3, g_pl)
    _g.simple_enemy(8, 6)

    -- draws the hearts at the top of the screen, with particles!
    _g.heart_particle_spawner(6.5, 1, 3)
    _g.heart_particle_spawner(9.5, 1, 2)
    _g.heart_particle_spawner(  8, 1, 1)

    _g.powerup_particle_spawner(3 , 1 , 0, _g.c_color_normal  , 72)
    _g.powerup_particle_spawner(4 , 15, 1, _g.c_color_insane_1, 74)
    _g.powerup_particle_spawner(8 , 15, 2, _g.c_color_insane_2, 76)
    _g.powerup_particle_spawner(12, 15, 3, _g.c_color_insane_3, 78)
    _g.powerup_particle_spawner(13, 1 , 4, _g.c_color_angry   , 104)

    -- tbox"hello, how are^you?"
end

function reset_the_void()
    _g.fader_in(.5, nf, nf)
    g_room = ztable[[ x:0; y:0; w:128; h:32; ]]
    g_pl = _g.pl_monster(7, 7)
    g_view = _g.view(15.25, 11.5, 3, g_pl)
    _g.simple_enemy(8, 6)

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

function game_init()
    g_floormap = create_map()

    -- _g.fader_out(1,nf,resetlevel)
    -- batch_call_new(acts_loop, [[
        -- confined,room_end;
        -- confined,kill;
        -- confined,delete
    -- ]])

    reset_the_dungeon()
    -- reset_the_void()
end

function game_update()
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

function game_draw()
    fade(g_card_fade)

    local x, y = 8, 8
    local rx = x - g_view.w/2
    local ry = y - g_view.h/2

    g_view.off_x = -(16-g_view.w)/2+rx
    g_view.off_y = -(16-g_view.h)/2+ry

    local x1, x2 = rx*8, (rx+g_view.w)*8-1
    local y1, y2 = ry*8, (ry+g_view.h)*8-1

    rect(x1-2, y1-2, x2+2, y2+2, 1)
    zclip(x1, y1, x2, y2)
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
    clip()

    batch_call_new(acts_loop, [[
        above_map_drawable, d;
        above_map_drawable_1, d;
    ]])

    tbox_draw(16,48)

    -- Draw minimap.
    -- DEBUG_BEGIN
    if g_debug then
        g_floormap:draw_mini()
    end
    -- DEBUG_END
end
