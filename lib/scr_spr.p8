--- tokens: 55
-- i made this function, because i had duplicate logic of:
-- times the position by 8 and subtract from the scr_y pos.
-- for multiple sprites.
function scr_spr(ind, x, y, w, h, xflip, yflip)
	spr(ind, (x - g_x)*8, (y - g_y)*8, w or 1, h or 1, xflip, yflip)
end

