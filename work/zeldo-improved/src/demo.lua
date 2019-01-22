-- 2% compression here.
-- 3522 3529 3503 3510 3521 3523 3538 3526 3487 3428 3635 3660 3652 3545 3494
-- 3487 3743 3686 3675 3585 3591 3797 3802 3759 3755 3861 4663 4470 4457 4478
-- 4477 4488 4387 4353 4369 4404 4338 4330 4316 4308 4288 4280 4259 4257 4272
-- 4295 4275 4259 4223 4206 4205 4212 4200 4198 4187 4232 4232 4230 4227 4212
-- 4206 4198 4283 4219 4321 4312 4190 4104 4094 4087 4123 4121 4119 4141 4099
-- 4089 4075 4040 4015 4169 4180 4170 4145 4225 4665 5565 5549 5800 6043 4775
-- 4760 4755 4746

-- 80% 95% 96%

function _init()
   poke(0x5f34, 1) -- for pattern colors.
   g_pal_gray = gun_vals("5,5,13,13,5,6,6,6,6,6,6,6,13,6,6")
   g_pal_norm = gun_vals("1,2,3,4,5,6,7,8,9,10,11,12,13,14,15")
   g_pal = g_pal_norm

	g_tl = tl_init(
		--{ init_logo,  2.5, update_logo,  draw_logo },
		--{ title_init, 1,   title_update, title_draw },
		{ game_init,  nil, game_update,  game_draw }
	)

   tbox("lank:...:where am i?:this must be another pico 8 cartridge demo.:i'm getting sick of these things.")
end

function _update60()
   tl_update(g_tl)
   tbox_interact()
end

function _draw()
	cls()
	tl_draw(g_tl)
   ttbox_draw(7, 0)
   print(stat(1), 44, 2, 7)
end

function game_update()
   menu_update()

   if not g_menu_open then
      batch_call(
         acts_loop, [[
            {drawable,reset_off},
            {stunnable, stun_update},
            {act,update},
            {mov,move},
            {col,move_check,@},
            {tcol,coll_tile,@},
            {rel,rel_update,@},
            {vec,vec_update},
            {act, clean},
            {starable,stare},
            {anim,anim_update},
            {timed,tick}
         ]],
         g_act_arrs["col"],
         function(x, y)
            return x >= g_rx and x < g_rx+g_rw and
                   y >= g_ry and y < g_ry+g_rh and
                   fget(mget(x, y), 1)
         end,
         g_pl
      )

      update_view(g_pl.x, g_pl.y)
      room_update()
   end
end

function game_draw()
   if g_menu_open then g_pal = g_pal_gray
   else g_pal = g_pal_norm end

   restore_pal()

   rectfill(0, 0, 127, 127, 0x1)

   draw_cur_room()

   if g_menu_open then
      draw_menu()
   end

   draw_status_bars()
   -- batch_call(rectfill, "{0,0,127,15,0}, {0,112,127,127,0}")
   -- draw_glitch_effect()
end

function draw_glitch_effect()
   o1 = flr(rnd(0x1f00)) + 0x6040
   o2 = o1 + flr(rnd(0x4)-0x2)
   len = flr(rnd(0x40))
   memcpy(o1,o2,len)
end

function game_init()
	-- palt(0, false)
   -- deku_spawner(3.5, 22.5, true)
   map_init()

   for i=0,10,2 do gen_spawner(12, 15+i, gen_deku, 12, true) end
   g_pl = gen_pl(0, 0)

   -- gen_spawner(71, 53, gen_top, 12)
   for i=4,12,2 do
      gen_spawner(i, 20, gen_top, 12)
   end

   -- load_room("dun73", 4, 4)
   load_room("field", 6, 5.5)
end
