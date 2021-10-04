-- game logic is in this file
-- 3 rooms: dungeon, void, hospital

function game_init()
    hospitalify_the_map()

    -- array of {x, y, xf, sind}
    _g.all_deadbody_templates = {dungeon={}, bossroom={}, hospital={}}

    -- array of {x, y, func, alive}
    -- don't remove things from this array!
    _g.all_enemy_templates = get_all_enemies_for_story_mode()

    g_floormap = create_map()

    -- this controls which room you start in
    g_reset_room=reset_the_dungeon
    -- g_reset_room=reset_the_bossroom
    g_reset_room()
end

function game_update()
    batch_call_new(acts_loop, [[
        timer,       tick;
        act,         update;
        mov,         mov_update;

        good_character, move_check,@1; -- wall
        bad_character,  move_check,@1; -- wall

        good_attack, move_check,@2; -- bad_character
        bad_attack,  move_check,@3; -- good_character

        pl_control, move_check,@4; -- portal

        tcol,coll_tile,@5;
        rel,       rel_update;
        vec,       vec_update;
        x_bounded, check_bounds_x;
        y_bounded, check_bounds_y;
        view,update_view;
        act,       clean;

    ]], g_act_arrs['wall'], g_act_arrs['bad_character'], g_act_arrs['good_character'], g_act_arrs['portal'], function(x, y)
        return x >= g_room.x and x < g_room.x+g_room.w and
            y >= g_room.y and y < g_room.y+g_room.h and
            fget(mget(x, y), 0)
    end)

   if g_tbox_update then
      if g_tbox_writing then
         g_tbox_anim = #g_tbox_active.l1+#g_tbox_active.l2
      else
         del(g_tbox_messages, g_tbox_active)
         g_tbox_active, g_tbox_anim = g_tbox_messages[1], 0
      end

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
