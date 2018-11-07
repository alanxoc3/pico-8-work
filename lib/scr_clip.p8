--- tokens: 43
-- see scr_mirrored
function scr_clip(x1, y1, x2, y2)
	clip(scr_x(x1), scr_y(y1), (x2-x1)*8, (x2-x1)*8)
end

--- tokens: 31
function scr_circ(x, y, r, col)
	circfill(scr_x(x),scr_y(y), r*8, col)
end
