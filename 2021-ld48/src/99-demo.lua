-- We write save data to the general purpose buffer, until a save platform
-- is triggered.

-- DEBUG_BEGIN
g_debug = false
-- DEBUG_END

poke(0x5f5c, 15) -- set the initial delay before repeating.
poke(0x5f5d, 15) -- set the repeating delay.

menuitem(1, "restart", function()
   extcmd'reset'
end)

g_level_coins = 0
g_level_max_coins = 0
g_stats = {
    time_start = 0,
    coins = 0,
    max_coins = 0,
    deaths = 0,
    shots = 0,
}

function _init()
    music(0, 3000)
    g_tl = ztable([[
        x=64, y=64, i=@8, u=nf, d=@1, tl_max_time=2.5; -- logo
        i=@2, u=@3, d=@4;  -- game
        i=@5, u=@6, d=@7;  -- end game
    ]], logo_draw,
    game_init, game_update, game_draw,
    end_init, end_update, end_draw, function() sfx(63) end
    )
end

function get_pl()
    if g_bucket_control.bucket.pl_in_bucket then
        return g_bucket_control.bucket
    else
        return g_bucket_control.bucket.pl
    end
end

function tolevel(level)
    if (g_cur_level == nil or g_cur_level < 4) and level == 4 then
        music(16, 2000)
   end

    batch_call_new(acts_loop, [[
        confined,room_end;
        confined,kill;
        confined,delete
    ]])

    g_cur_level = level
    g_blocks = {}
    g_block_context, g_cur_room, g_bucket_control, g_main_view = gen_lvl(level)

    g_card_fade = 8
    g_water_gauge = _g.water_gauge()
    _g.fader_in(.5, nf, nf)

    if level > 0 then
        _g.cur_level_status()
    end
end

function resetlevel()
    g_level_coins = 0
    g_level_max_coins = 0

    local default_level = 0
    tolevel(g_cur_level or default_level)
end

create_actor([[water_gauge;0;above_map_post_camera_drawable,pos,confined|
    x:111;
    y:123;
    charge_max:10;
    charge:10;
    charge_speed:.5;

    d:@1; fill:@2; can_shoot:@3; empty:@4; u:@5;
]], function(a)
    local multiplier = 3
    local max_charge_len = a.charge_max*multiplier
    local charge_len = a.charge*multiplier
    local ytop = a.y-1
    local ybot = a.y+2

    local col1 = 12
    local col2 = 1

    if t() % 1 < .25 then
        if a:can_shoot() then
            col1 = 6
            col2 = 5
        end
    end

    rect( a.x-max_charge_len+1, ytop, a.x-max_charge_len+1, ybot, col2 )
    rect( a.x, ytop, a.x, ybot, col2 )

    if charge_len > 0 then
        rectfill( a.x-max_charge_len+1 + (max_charge_len - charge_len), ytop, a.x, ybot, col1 )
        rectfill( a.x-max_charge_len+1 + (max_charge_len - charge_len), ybot, a.x, ybot, col2 )
    end

end, function(a)
    if not a.empty_state then
        a.charge = min(a.charge_max, a.charge + a.charge_speed)
    end
end, function(a)
    return not a.empty_state and a.charge == a.charge_max
end, function(a)
    if a:can_shoot() then
        a.empty_state = true
    end
end, function(a)
    if a.empty_state then
        a.charge = max(0, a.charge - a.charge_speed*3)
        if a.charge == 0 then
            a.empty_state = false
        end
    end
end)

function game_init(a)
    g_stats.coins = 0
    g_level_coins = 0
    g_level_max_coins = 0
    resetlevel()
end

function game_update(a)
   allocate_level(g_blocks, g_block_context, g_bucket_control.y+3)

   g_card_shake_x = 0

   batch_call_new(
      acts_loop, [[
         act,update;
         drawable_obj,reset_off;
         mov,move;
         pl,move_check,@1;
         bucket,move_check,@1;
         water_shot,move_check,@1;
         tcol,coll_tile,@2;
         rel,rel_update;
         vec,vec_update;
         kill_too_high,check_height;
         bounded,check_bounds;
         anim,anim_update;
         timed,tick;
         view,update_view;
      ]], g_act_arrs['col'],
      function(x, y)
         return x >= g_cur_room.x and x < g_cur_room.x+g_cur_room.w and
                y >= g_cur_room.y and y < g_cur_room.y+g_cur_room.h and
                g_blocks[flr(y)] and g_blocks[flr(y)][flr(x)] and
                g_blocks[flr(y)][flr(x)].id == 'solid'
      end
   )

   batch_call_new(acts_loop, [[act, clean]])
end

function isorty(t)
   if t then
    for n=2,#t do
        local i=n
        while i>1 and t[i].y<t[i-1].y do
            t[i],t[i-1]=t[i-1],t[i]
            i=i-1
        end
    end
 end
end

function game_draw(a)
   fade(g_card_fade)
   map_draw(g_main_view, 8 + g_card_shake_x * sin(t()*8)/8, 7.5)
   camera_to_view(g_main_view)
   if g_menu_open then
      if g_selected == 5 then g_pl.outline_color = SL_UI end
      g_pl.d(g_pl)
   end
   camera()
   acts_loop('above_map_post_camera_drawable', 'd')
   spr(41, 14, 120)
   zprint(":"..(g_stats.coins + g_level_coins), 21, 121, -1, 10, 5)
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
   if g_debug then
      poke(0x5f42,15) -- glitch sound
   else
      poke(0x5f42,0) -- no glitch sound
   end
   -- DEBUG_END

   -- DEBUG_BEGIN
   if btnp'5' and btn'4' then
      g_debug = not g_debug
   end
   -- DEBUG_END

   tl_node(g_tl)
end

function _draw()
    cls()

    -- DEBUG_BEGIN
    if g_debug then
        rect(0,0,127,127,8)
    end
    -- DEBUG_END

    call_not_nil(g_tl, 'd', g_tl)
end

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
      draw_lvl_blocks(g_blocks)

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
