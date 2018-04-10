-- alan morgan

g_x, g_y = 0, 0

function load_view(room_x, room_y, room_w, room_h, scr1, scr2)
	g_rx, g_ry, g_rw, g_rh, g_s1, g_s2 = room_x, room_y, room_w, room_h, scr1, scr2
end

function center_view(x, y)
	g_x, g_y = x - 8, y - 8
	update_view(x, y)
end

function update_view_helper(pc, gc, rc, rd)
	-- order matters here.
	-- this helper shaved over 30 tokens.
	if pc < gc + g_s1 then gc = pc - g_s1 end
	if pc > gc + g_s2 then gc = pc - g_s2 end
	if gc < rc        then gc = rc end
	if gc+16 > rc+rd  then gc = rc+rd-16 end
	if rd < 16        then gc = rd/2 - 8 + rc end
	return gc
end

-- example usage: update_view
function update_view(p_x, p_y)
	g_x, g_y = update_view_helper(p_x, g_x, g_rx, g_rw), update_view_helper(p_y, g_y, g_ry, g_rh)
end

-- i made this function, because i had duplicate logic of:
-- times the position by 8 and subtract from the scr_y pos.
-- for multiple sprites.
function scr_spr(ind, x, y, w, h, xflip, yflip)
	if not w then w = 1 end
	if not h then h = 1 end
	spr(ind, (x - g_x)*8, (y - g_y)*8, w, h, xflip, yflip)
end

function scr_rectfill(x1, y1, x2, y2, col)
	rectfill((x1-g_x)*8, (y1-g_y)*8, (x2-g_x)*8-1, (y2-g_y)*8-1, col)
end

function scr_rect(x1, y1, x2, y2, col)
	rect((x1-g_x)*8, (y1-g_y)*8, (x2-g_x)*8-1, (y2-g_y)*8-1, col)
end

function scr_circ(x, y, r, col)
	circfill((x-g_x)*8, (y-g_y)*8, r*8, col)
end

function scr_map(cel_x, cel_y, sx, sy, cel_w, cel_h)
	map(cel_x, cel_y, (sx-g_x)*8, (sy-g_y)*8, cel_w, cel_h)
end

function scr_txt(txt, x, y, col)
	print(txt, (x-g_x)*8, (y-g_y)*8, col)
end
