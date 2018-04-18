--- tokens: 64
-- example usage:
-- a.x, a.hs = update_in_box(a.x, a.hs, a.rad, 0, 16)
-- a.y, a.vs = update_in_box(a.y, a.vs, a.rad, 0, 16)
function coll_in_box(pos, spd, rad, dmin, dmax)
	local col = 0

	if pos + spd < dmin + rad then
		pos = dmin + rad
		spd = max(0, spd)
	elseif pos + spd > dmax - rad then col = 2
		pos = dmax - rad
		spd = min(0, spd)
	end

	return pos, spd
end
