function draw_cur_room()
   cur_room = g_rooms[g_cur_room]
   w = min(16, cur_room.w)*8
   h = min(12, cur_room.h)*8
   x, y = 64-w/2, g_v1*8+(12*8-h)/2
   clip(x, y, w, h)
   -- rectfill(x+2, y+2, x+w-3, y+h-3, cur_room.c)
   
   scr_rectfill(cur_room.x+2/8, cur_room.y+2/8, cur_room.x+cur_room.w-3/8, cur_room.y+cur_room.h-3/8, cur_room.c)
	scr_map(cur_room.x, cur_room.y, cur_room.x, cur_room.y, cur_room.w, cur_room.h)
end

function map_init()
   g_rooms = {
      -- color, x, y, w, h, l, r, u, d
      dun00={c=4, x=96,  y=0,  w=8, h=8, u={"dun70",4,8}, d={"dun10",4,0}},
      dun01={c=2, x=104, y=0,  w=8, h=8},
      dun02={c=2, x=112, y=0,  w=8, h=8},
      dun03={c=2, x=120, y=0,  w=8, h=8},
      dun10={c=4, x=96,  y=8,  w=8, h=8, u={"dun00",4,8}, d={"dun20",4,0}},
      dun11={c=2, x=104, y=8,  w=8, h=8},
      dun12={c=2, x=112, y=8,  w=8, h=8},
      dun13={c=2, x=120, y=8,  w=8, h=8},
      dun20={c=4, x=96,  y=16, w=8, h=8, u={"dun10",4,8}, d={"villa", 18.5,3}},
      dun21={c=2, x=104, y=16, w=8, h=8},
      dun22={c=2, x=112, y=16, w=8, h=8},
      dun23={c=2, x=120, y=16, w=8, h=8},
      dun30={c=6, x=96,  y=24, w=8, h=8},
      dun31={c=6, x=104, y=24, w=8, h=8},
      dun32={c=6, x=112, y=24, w=8, h=8},
      dun33={c=6, x=120, y=24, w=8, h=8},
      dun40={c=6, x=96,  y=32, w=8, h=8},
      dun41={c=6, x=104, y=32, w=8, h=8},
      dun42={c=6, x=112, y=32, w=8, h=8},
      dun43={c=6, x=120, y=32, w=8, h=8},
      dun50={c=6, x=96,  y=40, w=8, h=8},
      dun51={c=6, x=104, y=40, w=8, h=8},
      dun52={c=6, x=112, y=40, w=8, h=8},
      dun53={c=6, x=120, y=40, w=8, h=8},
      -- lost forest
      dun60={c=3, x=96,  y=48, w=8, h=8, u={"dun71",4,8}, d={"dun70",4,0}, r={"dun61",0,4}, l={"dun71",8,4}},
      dun61={c=3, x=104, y=48, w=8, h=8, u={"dun71",4,8}, d={"dun71",4,0}, r={"dun62",0,4}, l={"dun60",8,4}},
      dun62={c=3, x=112, y=48, w=8, h=8, u={"dun71",4,8}, d={"dun72",4,0}, r={"dun71",0,4}, l={"dun61",8,4}},
      dun63={c=3, x=120, y=48, w=8, h=8, d={"bossw",8,0}},
      dun70={c=3, x=96,  y=56, w=8, h=8, u={"dun60",4,8}, d={"dun00",4,0}, r={"dun71",0,4}, l={"dun71",8,4}},
      dun71={c=3, x=104, y=56, w=8, h=8, u={"dun70",4,8}, d={"dun70",4,0}, r={"dun70",0,4}, l={"dun70",8,4}},
      dun72={c=3, x=112, y=56, w=8, h=8, u={"dun62",4,8}, d={"dun71",4,0}, r={"dun73",0,4}, l={"dun71",8,4}},
      dun73={c=3, x=120, y=56, w=8, h=8, u={"bossw",8,12}, l={"dun72",8,4}},
      villa={c=3, x=29,  y=0,  w=22, h=25, r={"field",0,26}, u={"lankp",5,20}, doors={{"dun20",4,8,18.5,2.5,.5,.5}, {"shop",4,8,4,11.5,.5,.5}, {"banjo_academy",4,8,17,19.5,.5,.5}}},
      field={c=3, x=0,   y=0,  w=29, h=32, l={"villa",22,13}, r={"gravp",0,3}, u={"mount",7,25}},
      bossw={c=3, x=64,  y=12, w=16, h=12, d={"dun73",4,0}, u={"dun63",4,8}},
      lankp={c=3, x=32,  y=32, w=10, h=20, d={"villa",4,0}},
      gravp={c=5, x=29,  y=25, w=19, h=7,  l={"field",29,18}, r={"grave",0,3}, u={"templ",8,12}},
      grave={c=5, x=48,  y=25, w=16, h=21, l={"gravp",19,4}},
      mount={c=4, x=51,  y=0,  w=13, h=25, d={"field",12,0}, u={"castl",8,12}}, -- mtn
      castl={c=5, x=32,  y=52, w=16, h=12, d={"mount",6,0}},
      templ={c=5, x=64,  y=0,  w=16, h=12, d={"gravp",11,0}},

      novi_grave={c=4, x=54, y=46, w=5,  h=6 }, -- xs room 1
      ivan_grave={c=4, x=59, y=46, w=5,  h=6 }, -- xs room 2
      house_1={c=4, x=42, y=46, w=6,  h=6 }, -- small room 1
      house_2={c=4, x=48, y=46, w=6,  h=6 }, -- small room 2
      house_3={c=4, x=42, y=32, w=6,  h=7 }, -- medium room 1
      house_4={c=4, x=42, y=39, w=6,  h=7 }, -- medium room 2
      lanks_house={c=4, x=64, y=24, w=8,  h=8 }, -- big room 1
      shop={c=4, x=72, y=24, w=8,  h=8, d={"villa",4,12} }, -- big room 2
      banjo_academy={c=4, x=80, y=24, w=8,  h=8, d={"villa",17,20}}, -- big room 3
      gravekeepers_house={c=4, x=88, y=24, w=8,  h=8}, -- big room 4

      bossi={c=0, x=48, y=52, w=16, h=12}, -- final hard ivan battle
      bossc={c=5, x=80, y=0,  w=16, h=12}, -- cannon boss
      endls={c=3, x=80, y=12, w=16, h=12}, -- endless mode
   }
end

function load_room(new_room, rx, ry)
   g_cur_room = new_room
   cur_room = g_rooms[g_cur_room]
   x, y, w, h = cur_room.x, cur_room.y, cur_room.w, cur_room.h

   -- for debugging now
   g_pl.x = x + rx
   g_pl.y = y + ry
   -- end debugging

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
