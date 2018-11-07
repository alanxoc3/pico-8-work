--- tokens: 47
function scr_rect(x1, y1, x2, y2, col)
	rect(scr_x(x1),scr_y(y1),scr_x(x2),scr_y(y2),col)
end
--- tokens: 47
function scr_rectfill(x1, y1, x2, y2, col)
	rectfill(scr_x(x1),scr_y(y1),scr_x(x2),scr_y(y2),col)
end
--- tokens: 29
function scr_print(txt, x, y, col)
	print(txt, scr_x(x),scr_y(y), col)
end
--- tokens: 38
function scr_mirrored(ind, x, y, w, h)
	scr_spr(ind, x, y, w, h)
	scr_spr(ind, x+w, y, w, h, true)
end
--- tokens: 37
function scr_map(cel_x, cel_y, sx, sy, cel_w, cel_h)
	map(cel_x, cel_y, scr_x(sx), scr_y(sy), cel_w, cel_h)
end

--- tokens: 43
-- see scr_mirrored
function scr_clip(x1, y1, x2, y2)
	clip(scr_x(x1), scr_y(y1), (x2-x1)*8, (x2-x1)*8)
end

--- tokens: 31
function scr_circ(x, y, r, col)
	circfill(scr_x(x),scr_y(y), r*8, col)
end
