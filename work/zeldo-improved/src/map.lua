g_rooms = {
   {0,  0, 0, 0,  0 }, -- none
   {3,  0, 0, 29, 32}, -- field
   {3, 29, 0, 22, 25}, -- village
   {4, 51, 0, 13, 25}, -- mtn
}

function draw_cur_room()
   cur_room = g_rooms[g_cur_room]
   w = min(16, cur_room[4])/2*8
   rectfill(64-w, 0, 63+w, 128, cur_room[1])
	scr_map(cur_room[2], cur_room[3], cur_room[2], cur_room[3], cur_room[4], cur_room[5])
end

function map_init()
end

function load_room(new_room)
   g_cur_room = new_room
   cur_room = g_rooms[g_cur_room]
   x, y, w, h = cur_room[2], cur_room[3], cur_room[4], cur_room[5]

   -- for debugging now
   g_pl.x = x + 3
   g_pl.y = y + 3
   -- end debugging

	load_view(x, y-2, w, h+4, 5, 11)
	center_view(g_pl.x, g_pl.y)
end
