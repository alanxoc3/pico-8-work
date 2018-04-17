--- tokens: 55
function scr_spr(ind, x, y, w, h, xflip, yflip)
	spr(ind, scr_x(x-.5), scr_y(y-.5), w or 1, h or 1, xflip, yflip)
end

