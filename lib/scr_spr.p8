--- tokens: 55
-- con_scr()
function scr_spr(ind, x, y, w, h, xflip, yflip)
	spr(ind, scr_x(x), scr_y(y), w or 1, h or 1, xflip, yflip)
end

