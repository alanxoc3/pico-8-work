function tbox_draw_arrow(x, y, col, hor)
	for i=0, 2 do
		local p1, p2 = x+4-i, y+i
		if hor then p1, p2 = x+i, y+4-i end
		line(x+i, y+i, p1, p2, col)
	end
end
