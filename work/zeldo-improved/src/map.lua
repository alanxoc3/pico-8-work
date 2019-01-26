function draw_cur_room()
   cur_room = g_rooms[g_cur_room]
   w = min(16, cur_room.w)*8
   h = min(12, cur_room.h)*8
   x, y = 64-w/2, g_v1*8+(12*8-h)/2

   clip(x, y, w, h)
   -- rectfill(x+2, y+2, x+w-3, y+h-3, cur_room.c)
   
   scr_rectfill(cur_room.x+4/8, cur_room.y+4/8, cur_room.x+cur_room.w-5/8, cur_room.y+cur_room.h-5/8, cur_room.c)
	scr_map(cur_room.x, cur_room.y, cur_room.x, cur_room.y, cur_room.w, cur_room.h)

   isorty(g_act_arrs["spr"])
   acts_loop("spr", "draw")

	scr_map(cur_room.x, cur_room.y, cur_room.x, cur_room.y, cur_room.w, cur_room.h, 1)
   clip()
end

function isorty(t)
    for n=2,#t do
        local i=n
        while i>1 and t[i].y<t[i-1].y do
            t[i],t[i-1]=t[i-1],t[i]
            i-=1
        end
    end
end

function map_init()
   g_rooms = gun_vals[[
   villa={c=#3, x=#29,  y=#0,  w=#22, h=#25, r={field,#0,#26}, l={lankp,#10,#17},
      doors={
         {cave,#4,#24,#18.5,#2.5,#.5,#.5},
         {shop,#4,#8,#4,#11.5,#.5,#.5},
         {banjo_academy,#4,#8,#17,#19.5,#.5,#.5},
         {fandude_house,#3,#7,#5,#2.5,#.5,#.5},
         {house_1,#3,#6,#17,#7.5,#.5,#.5},
         {house_2,#3,#6,#6,#18.5,#.5,#.5},
         {house_3,#3,#7,#15,#13.5,#.5,#.5}
      }
   },

   cave={c=#4, x=#96,  y=#24,  w=#8, h=#24, u={dun70,#4,#8}, d={villa, #18.5,#3}},

   dun60={c=#3, x=#96,  y=#48, w=#8, h=#8, u={dun71,#4,#8}, d={dun70,#4,#0}, r={dun61,#0,#4}, l={dun71,#8,#4}},
   dun61={c=#3, x=#104, y=#48, w=#8, h=#8, u={dun71,#4,#8}, d={dun71,#4,#0}, r={dun62,#0,#4}, l={dun60,#8,#4}},
   dun62={c=#3, x=#112, y=#48, w=#8, h=#8, u={dun71,#4,#8}, d={dun72,#4,#0}, r={dun71,#0,#4}, l={dun61,#8,#4}},
   dun63={c=#3, x=#120, y=#48, w=#8, h=#8, d={bossw,#8,#0}},
   dun70={c=#3, x=#96,  y=#56, w=#8, h=#8, u={dun60,#4,#8}, d={cave,#4,#0}, r={dun71,#0,#4}, l={dun71,#8,#4}},
   dun71={c=#3, x=#104, y=#56, w=#8, h=#8, u={dun70,#4,#8}, d={dun70,#4,#0}, r={dun70,#0,#4}, l={dun70,#8,#4}},
   dun72={c=#3, x=#112, y=#56, w=#8, h=#8, u={dun62,#4,#8}, d={dun71,#4,#0}, r={dun73,#0,#4}, l={dun71,#8,#4}},
   dun73={c=#3, x=#120, y=#56, w=#8, h=#8, u={bossw,#8,#12}, l={dun72,#8,#4}},

   castle_1={c=#5, x=#64,  y=#0, w=#16, h=#12, d={castl,#8,#2}, u={castle_2,#8,#12}},
   castle_2={c=#5, x=#80,  y=#0, w=#16, h=#12, d={castle_1,#8,#0}, u={castle_3,#8,#12}},
   castle_3={c=#5, x=#96,  y=#0, w=#16, h=#12, d={castle_2,#8,#0}, u={castle_4,#8,#12}},
   castle_4={c=#5, x=#112, y=#0, w=#16, h=#12, d={castle_3,#8,#0}},

   field={c=#3, x=#0,   y=#0,  w=#29, h=#32, l={villa,#22,#13}, r={gravp,#0,#3}, u={mount,#7,#25}},
   bossw={c=#3, x=#96,  y=#12, w=#16, h=#12, d={dun73,#4,#0},   u={dun63,#4,#8}},
   gravp={c=#5, x=#29,  y=#25, w=#19, h=#7,  l={field,#29,#18}, r={grave,#0,#18}, u={templ,#8,#12}},
   mount={c=#4, x=#51,  y=#0,  w=#13, h=#25, d={field,#12,#0},  u={castl,#8,#12}},
   templ={c=#5, x=#32,  y=#52,  w=#16, h=#12, d={gravp,#11,#0}, u={temple_r1,#2.5,#6}, doors={
      {crypt_novi,#2.5,#8,#3.5,#1.5,#.5,#.5},
      {crypt_ivan,#2.5,#8,#12.5,#1.5,#.5,#.5}
   }},
   temple_r1={c=#5, x=#54,  y=#46,  w=#5, h=#6, d={templ,#8,#0}, u={temple_r2,#2.5,#6}},
   temple_r2={c=#5, x=#59,  y=#46,  w=#5, h=#6, d={temple_r1,#2.5,#0}},

   lankp={c=#3, x=#32,  y=#32, w=#10, h=#20, r={villa,#0,#20},   doors={{lanks_house,#4,#8,#5,#2.5,#.5,#.5}}},
   grave={c=#5, x=#48,  y=#25, w=#16, h=#21, l={gravp,#19,#4}, u={grave_boss,#8,#12}, doors={{gravekeepers_house,#4,#8,#14,#16.5,#.5,#.5}}},
   castl={c=#5, x=#64,  y=#12, w=#16, h=#12, d={mount,#6,#0},   doors={{castle_1,#8,#12,#8,#1.5,#.5,#.5}}},

   crypt_novi={c=#13, x=#118, y=#24, w=#5,  h=#8, d={templ,#3.5,#2}, r={crypt_r1,#0,#5.5}},
   crypt_ivan={c=#13, x=#123, y=#24, w=#5,  h=#8, d={templ,#12.5,#2}, l={crypt_r1,#16,#2.5}},

   crypt_r1={c=#13, x=#112, y=#32, w=#16,  h=#8, d={crypt_r2,#11.5,#0}, l={crypt_novi,#5,#5.5}, r={crypt_ivan,#0,#2.5}, u={crypt_r3,#1.5,#16}},
   crypt_r2={c=#13, x=#112, y=#40, w=#16,  h=#8, u={crypt_r1,#11.5,#8}},
   crypt_r3={c=#13, x=#104, y=#32, w=#8,  h=#16, d={crypt_r1,#1.5,#0}, u={crypt_r4,#4.5,#8}},
   crypt_r4={c=#13, x=#104, y=#24, w=#14,  h=#8, d={crypt_r3,#4.5,#0}, u={crypt_boss,#8,#12}},
   crypt_boss={c=#13, x=#112, y=#12, w=#16,  h=#12, d={crypt_r4,#10,#0}},

   house_1={c=#4, x=#42, y=#46, w=#6,  h=#6, d={villa,#17,#8}},
   house_2={c=#4, x=#48, y=#46, w=#6,  h=#6, d={villa,#6, #19}},
   house_3={c=#4, x=#42, y=#32, w=#6,  h=#7, d={villa,#15,#14}},

   fandude_house={c=#4, x=#42, y=#39, w=#6,  h=#7, d={villa,#5,#3}, u={endless,#8,#12}},
   endless={c=#3, x=#80, y=#12, w=#16, h=#12, d={fandude_house,#3,#0}},

   lanks_house={c=#4, x=#64, y=#24, w=#8,  h=#8, d={lankp,#5,#3}},
   shop={c=#4, x=#72, y=#24, w=#8,  h=#8, d={villa,#4,#12} },
   banjo_academy={c=#4, x=#80, y=#24, w=#8,  h=#8, d={villa,#17,#20}},
   gravekeepers_house={c=#4, x=#88, y=#24, w=#8,  h=#8, d={grave,#14,#17}},
   grave_boss={c=#5, x=#112, y=#12, w=#16,  h=#12, d={grave,#8,#0}},
   ]]
end

function load_room(new_room, rx, ry)
   g_cur_room = new_room
   cur_room = g_rooms[g_cur_room]
   x, y, w, h = cur_room.x, cur_room.y, cur_room.w, cur_room.h

   -- for debugging now
   g_pl.x = x + rx
   g_pl.y = y + ry
   -- end debugging
   g_ma = 54

	load_view(x, y, w, h, 5, 11, 1.5, 2.5)
	center_view(g_pl.x, g_pl.y)

   -- get rid of current text.
   tbox_clear()
end

function room_update()
   cur_room = g_rooms[g_cur_room]

   -- "room", out_x, out_y, x, y, rx, ry
   foreach(cur_room.doors or {}, function(d)
      if point_in_rect(g_pl, {x=g_rx+d[4], y=g_ry+d[5], rx=d[6], ry=d[7]}) then
         load_room(d[1], d[2], d[3])
      end
   end)

   if g_pl.y > g_ry+g_rh and cur_room.d then
      load_room(cur_room.d[1], cur_room.d[2], cur_room.d[3])
   elseif g_pl.y < g_ry and cur_room.u then
      load_room(cur_room.u[1], cur_room.u[2], cur_room.u[3])
   elseif g_pl.x > g_rx+g_rw and cur_room.r then
      load_room(cur_room.r[1], cur_room.r[2], cur_room.r[3])
   elseif g_pl.x < g_rx and cur_room.l then
      load_room(cur_room.l[1], cur_room.l[2], cur_room.l[3])
   end
end
