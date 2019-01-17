function draw_cur_room()
   cur_room = g_rooms[g_cur_room]
   w = min(16, cur_room.w)/2*8
   h = min(16, cur_room.h)/2*8
   clip(64-w, 64-h, 2*w, 2*h)
   rectfill(0,0,128,128,cur_room.c)
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
      villa={c=3, x=29,  y=0,  w=22, h=25, r={"field",0,26}, u={"lankp",5,20}},
      field={c=3, x=0,   y=0,  w=29, h=32, l={"villa",22,13}, r={"gravp",0,3}, u={"mount",7,25}},
      bossw={c=3, x=64,  y=12, w=16, h=12, d={"dun73",4,0}, u={"dun63",4,8}},
      lankp={c=3, x=32,  y=32, w=10, h=20, d={"villa",4,0}},
      gravp={c=5, x=29,  y=25, w=19, h=7,  l={"field",29,18}, r={"grave",0,3}, u={"templ",8,12}},
      grave={c=5, x=48,  y=25, w=16, h=21, l={"gravp",19,4}},
      mount={c=4, x=51,  y=0,  w=13, h=25, d={"field",12,0}, u={"castl",8,12}}, -- mtn
      castl={c=5, x=32,  y=52, w=16, h=12, d={"mount",6,0}},
      templ={c=5, x=64,  y=0,  w=16, h=12, d={"gravp",14,0}},

      room0={c=4, x=54, y=46, w=5,  h=6 }, -- xs room 1
      room1={c=4, x=59, y=46, w=5,  h=6 }, -- xs room 2
      room2={c=4, x=42, y=46, w=6,  h=6 }, -- small room 1
      room3={c=4, x=48, y=46, w=6,  h=6 }, -- small room 2
      room4={c=4, x=42, y=32, w=6,  h=7 }, -- medium room 1
      room5={c=4, x=42, y=39, w=6,  h=7 }, -- medium room 2
      room6={c=4, x=64, y=24, w=8,  h=8 }, -- big room 1
      room7={c=4, x=72, y=24, w=8,  h=8 }, -- big room 2
      room8={c=4, x=80, y=24, w=8,  h=8 }, -- big room 3
      room9={c=4, x=88, y=24, w=8,  h=8 }, -- big room 4
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

	load_view(x, y-2, w, h+4, 5, 11)
	center_view(g_pl.x, g_pl.y)

   -- get rid of current text.
   tbox_clear()
end

function room_update()
   cur_room = g_rooms[g_cur_room]
   if g_pl.y > g_ry+g_rh-2 and cur_room.d then
      load_room(cur_room.d[1], cur_room.d[2], cur_room.d[3])
   elseif g_pl.y < g_ry+2 and cur_room.u then
      load_room(cur_room.u[1], cur_room.u[2], cur_room.u[3])
   elseif g_pl.x > g_rx+g_rw and cur_room.r then
      load_room(cur_room.r[1], cur_room.r[2], cur_room.r[3])
   elseif g_pl.x < g_rx and cur_room.l then
      load_room(cur_room.l[1], cur_room.l[2], cur_room.l[3])
   end
end
