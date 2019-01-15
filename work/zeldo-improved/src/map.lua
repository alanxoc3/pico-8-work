function draw_cur_room()
   batch_call(scr_rectfill, "{0,0,49.5,64,3}, {49.5,31,95,64,3}, {64,31,95,64,4}, {78.5,0,95,31,4}, {49.5,0,78.5,31,5}, {82,0,93,18,5}, {63,0,65,64,12}")
	scr_map(0, 0, 0, 0, 128, 64)
end

function map_init()
   
end
