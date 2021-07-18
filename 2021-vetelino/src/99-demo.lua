-- We write save data to the general purpose buffer, until a save platform
-- is triggered.

-- DEBUG_BEGIN
g_debug = false
-- DEBUG_END

g_card_fade = 8
poke(0x5f5c, 15) -- set the initial delay before repeating.
poke(0x5f5d, 15) -- set the repeating delay.

function _init()
    music(0, 3000)
    g_tl = ztable([[
        --x=64, y=64, i=@2, u=nf, d=@1, tl_max_time=2.5; -- logo
        i=@3, u=@4, d=@5;  -- title
        i=@6, u=@7, d=@8;  -- game
    ]], logo_draw, function() sfx'63' end,
    title_init, title_update, title_draw,
    game_init, game_update, game_draw
    )
end

function reset_level()
    batch_call_new(acts_loop, [[
        confined,room_end;
        confined,delete
    ]])
    printh("RESET")
    g_pl = nil
    g_truck = nil
    g_intro_pl = nil
    g_intro_truck = nil

    game_init()
end

function title_init()
    g_title_selection = 0
    g_codename = ""
    _g.fader_in(.5, nf, nf)
end

function title_draw()
    fade(g_card_fade)
    local width = 7*8*2
    local height = 3*8*2
    local bounce = min(2, max(-2, sin(t())*3))
    sspr(16, 70, 7*8, 3*8, 64-width/2, 8+bounce, width, height)

    spr(g_title_selection == 0 and 229 or 224, 64-5*8/2-24+bounce, 64-16+15, 5, 2)
    spr(g_title_selection == 1 and 229 or 224, 64-5*8/2+24-bounce, 64-16+15, 5, 2)

    zprint("select player then", 64, 96+4-bounce, 0, 11, 1)
    zprint("z or x to play", 64, 96+4+8-bounce, 0, 11, 1)
end

function title_update(tl)
    g_title_selection = min(1, max(0, g_title_selection+xbtn()))
    if btnp(4) or btnp(5) then
        g_codename = g_title_selection == 0 and "pendae" or "popguin"
        _g.fader_out(.5,nf,function()
            tl:next()
        end)
    end

    batch_call_new(acts_loop, [[
        act, update;
        act, clean;
    ]])
end

function game_init()
    _g.fader_in(.5, nf, nf)
    g_intro_pl = _g.intro_pl()
    g_intro_truck = _g.intro_truck()

    _g.mission_text("\^y8codename: "..g_codename.."\nobjective: eat ice cream", 4, function()
        g_intro_pl:kill()
        g_intro_truck:kill()
    end)

    _g.road_gen()
    g_cur_room = ztable[[x:1;y:2;w:14;h:16;c:0;]]
end

function game_update()
    batch_call_new(acts_loop, [[
        act, update;
        mov, move;
        vehicle,move_check,@1;
        popsicle,move_check,@2;
        throwing_star,move_check,@3;
        vec, vec_update;
        bounded, check_bounds;
        timed, tick;
        act, clean;
    ]], g_act_arrs['col'], g_act_arrs['vehicle'], g_act_arrs['truck'])
end

function game_draw()
    fade(g_card_fade)
    zcls(3)

    if not g_truck then
        draw_health_bar(1, 1)
    else
        draw_health_bar(g_truck.health, g_truck.max_health)
    end

    isorty(g_act_arrs.drawable)
    batch_call_new(acts_loop, [[
        pre_drawable, d;
        drawable, d;
        post_drawable, d;
    ]])

    rect(0, 0, 127, 127, 2)
    -- DEBUG_BEGIN
    if g_debug then acts_loop('dim', 'debug_rect') end
    -- DEBUG_END
end

function logo_draw(a)
   local logo_opacity = 8+cos(a.tl_tim/a.tl_max_time)*4-4

   fade(logo_opacity)
   camera(logo_opacity > 1 and rnd_one())
   zspr(108, a.x, a.y, 4, 2)
   fade'0'
   camera()
end

function _update60()
   -- DEBUG_BEGIN
   if g_debug then poke(0x5f42,15) -- glitch sound
   else poke(0x5f42,0) -- no glitch sound
   end
   -- DEBUG_END

   -- DEBUG_BEGIN
   if btnp'5' and btn'4' then g_debug = not g_debug end
   -- DEBUG_END

   tl_node(g_tl)
end

function _draw()
    cls()

    call_not_nil(g_tl, 'd', g_tl)

    -- DEBUG_BEGIN
    if g_debug then
        rect(0,0,127,127,8)
    end
    -- DEBUG_END
end

-- CAMERA STUFF
function shiftx(view)
    return (view.x-view.off_x-8)*8
end

function shifty(view)
    return (view.y-view.off_y-8)*8
end

function camera_to_view(view)
   camera(shiftx(view), shifty(view))
end

function map_draw(view, x, y)
   if view then
      local rx = x - view.w/2
      local ry = y - view.h/2

      view.off_x = -(16-view.w)/2+rx
      view.off_y = -(16-view.h)/2+ry

      local x1, x2 = rx*8+4, (rx+view.w)*8-5
      local y1, y2 = ry*8+4, (ry+view.h)*8-5
      camera_to_view(view)

      zclip(x1, y1, x2, y2)
      zcls(g_cur_room.c)

      batch_call_new(acts_loop, [[
            pre_drawable, d;
            pre_drawable_1, d;
            pre_drawable_2, d;
        ]])

      isorty(g_act_arrs.drawable)
      batch_call_new(acts_loop, [[
         drawable,      d;
         drawable_1,      d;
         drawable_2,      d;
         post_drawable, d;
         post_drawable_1, d;
         post_drawable_2, d;
      ]])

      -- DEBUG_BEGIN
      if g_debug then acts_loop('dim', 'debug_rect') end
      -- DEBUG_END

      clip()
      camera()
      -- zrect(x1, y1, x2, y2)
   end
end
