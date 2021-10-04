-- game logic is in this file
-- 3 rooms: dungeon, void, hospital

function game_init()
    -- array of {x, y, xf, sind}
    local d_and_h = {} _g.all_deadbody_templates = {dungeon=d_and_h, bossroom={}, hospital=d_and_h}

    -- array of {x, y, func, alive}
    -- don't remove things from this array!
    _g.all_enemy_templates = get_all_enemies_for_story_mode()

    -- g_floormap = create_map()

    -- Frames updated in game_update. Deaths updated in 03-pl-control (just before the room is reset).
    -- Achievements: carnage, unstable, pacifist
    g_endgame_stats = {
        frames=0,
        deaths=0,
        achievement="pacifist",
        enemy_kill_count=0,
        enemy_total_count=0
    }

    -- this controls which room you start in
    -- g_reset_room=reset_the_dungeon
    g_reset_room=reset_the_hospital
    -- g_reset_room=reset_the_bossroom
    g_reset_room()

    -- DEBUG_BEGIN
    g_pl.x = 15
    g_pl.y = 5
    -- DEBUG_END
end

function game_update()
    g_endgame_stats.frames = g_endgame_stats.frames + 1
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

    g_endgame_stats.enemy_kill_count  = #_g.all_deadbody_templates.dungeon
    g_endgame_stats.enemy_total_count = #_g.all_enemy_templates.dungeon

    if g_endgame_stats.enemy_kill_count == 0 then
        g_endgame_stats.achievement = "pacifist"
    elseif g_endgame_stats.enemy_kill_count == enemy_total_count then
        g_endgame_stats.achievement = "genocide"
    else
        g_endgame_stats.achievement = "unstable"
    end

    -- ran into token limit. may enable again?
    -- tbox_interact()
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

    -- ran into token limit. may enable again?
    -- tbox_draw(16,48)

    -- Draw minimap.
    -- DEBUG_BEGIN
    if g_debug then
        -- g_floormap:draw_mini()
        print(g_endgame_stats.achievement, 2, 2, 8)
        print('time= '..format_time()..', deaths= '..g_endgame_stats.deaths..' kill: '..g_endgame_stats.enemy_kill_count..'/'..g_endgame_stats.enemy_total_count, 2, 120, 8)
    end
    -- DEBUG_END
end

function format_time()
    local seconds = flr(g_endgame_stats.frames/60)
    local mins = flr(seconds/60)
    seconds = seconds%60
    mins    = mins    < 10 and '0'..mins or mins
    seconds = seconds < 10 and '0'..seconds or seconds
    return ''..mins..':'..seconds
end
