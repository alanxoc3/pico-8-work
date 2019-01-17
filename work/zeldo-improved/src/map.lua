g_rooms = {
   {4,  96,  0,  8,  8}, -- dun 00
   {2, 104,  0,  8,  8}, -- dun 01
   {2, 112,  0,  8,  8}, -- dun 02
   {2, 120,  0,  8,  8}, -- dun 03

   {4,  96,  8,  8,  8}, -- dun 10
   {2, 104,  8,  8,  8}, -- dun 11
   {2, 112,  8,  8,  8}, -- dun 12
   {2, 120,  8,  8,  8}, -- dun 13

   {4,  96, 16,  8,  8}, -- dun 20
   {2, 104, 16,  8,  8}, -- dun 21
   {2, 112, 16,  8,  8}, -- dun 22
   {2, 120, 16,  8,  8}, -- dun 23

   {6,  96, 24,  8,  8}, -- dun 30
   {6, 104, 24,  8,  8}, -- dun 31
   {6, 112, 24,  8,  8}, -- dun 32
   {6, 120, 24,  8,  8}, -- dun 33

   {6,  96, 32,  8,  8}, -- dun 40
   {6, 104, 32,  8,  8}, -- dun 41
   {6, 112, 32,  8,  8}, -- dun 42
   {6, 120, 32,  8,  8}, -- dun 43

   {6,  96, 40,  8,  8}, -- dun 50
   {6, 104, 40,  8,  8}, -- dun 51
   {6, 112, 40,  8,  8}, -- dun 52
   {6, 120, 40,  8,  8}, -- dun 53

   {3,  96, 48,  8,  8}, -- dun 60
   {3, 104, 48,  8,  8}, -- dun 61
   {3, 112, 48,  8,  8}, -- dun 62
   {3, 120, 48,  8,  8}, -- dun 63

   {3,  96, 56,  8,  8}, -- dun 70
   {3, 104, 56,  8,  8}, -- dun 71
   {3, 112, 56,  8,  8}, -- dun 72
   {3, 120, 56,  8,  8}, -- dun 73

   {4, 54, 46,  5,  6}, -- xs room 1
   {4, 59, 46,  5,  6}, -- xs room 2
   {4, 42, 46,  6,  6}, -- small room 1
   {4, 48, 46,  6,  6}, -- small room 2
   {4, 42, 32,  6,  7}, -- medium room 1
   {4, 42, 39,  6,  7}, -- medium room 2
   {4, 64, 24,  8,  8}, -- big room 1
   {4, 72, 24,  8,  8}, -- big room 2
   {4, 80, 24,  8,  8}, -- big room 3
   {4, 88, 24,  8,  8}, -- big room 4
   {0, 48, 52, 16, 12}, -- final hard ivan battle
   {5, 32, 52, 16, 12}, -- castle entrance
   {3, 32, 32, 10, 20}, -- lank to vill
   {5, 48, 25, 16, 21}, -- graveyard
   {5, 29, 25, 20,  7}, -- path to grave
   {0,  0,  0, 0,   0}, -- none
   {3,  0,  0, 29, 32}, -- field
   {3, 29,  0, 22, 25}, -- village
   {4, 51,  0, 13, 25}, -- mtn
   {5, 64,  0, 16, 12}, -- temple entrance
   {5, 80,  0, 16, 12}, -- cannon boss
   {3, 80, 12, 16, 12}, -- endless mode
   {3, 64, 12, 16, 12}, -- woods boss
}

function draw_cur_room()
   cur_room = g_rooms[g_cur_room]
   w = min(16, cur_room[4])/2*8
   h = min(16, cur_room[5])/2*8
   clip(64-w, 64-h, 2*w, 2*h)
   rectfill(0,0,128,128,cur_room[1])
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
