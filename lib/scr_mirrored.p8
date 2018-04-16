--- tokens: 38
function scr_mirrored(ind, x, y, w, h)
	scr_spr(ind, x, y, w, h)
	scr_spr(ind, x+w, y, w, h, true)
end
