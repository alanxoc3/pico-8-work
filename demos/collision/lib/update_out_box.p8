-- alan morgan

-- example usage:
-- a.x, a.y, a.hs, a.vs = update_out_box(a.x, a.y, a.hs, a.vs, a.rad, a.rad, 2, 2, 4, 4)
function update_out_box(x, y, hs, vs, xrad, yrad, bx1, by1, bx2, by2)
	x, hs = dim_spd_col(x, y, hs, vs, bx1, bx2, by1, by2, xrad)
	y, vs = dim_spd_col(y, x, vs, hs, by1, by2, bx1, bx2, yrad)

	return x, y, hs, vs
end

-- util function
function dim_spd_col(p1, p2, ps1, ps2, p1b1, p1b2, p2b1, p2b2, rad)
	local col = 0 
	if p1 + rad <= p1b1 and p1 + rad + ps1 >= p1b1 then
		col = 1
	end

	if p1 - rad >= p1b2 and p1 - rad + ps1 <= p1b2 then
		col = 2
	end

	if col > 0 and p2 + ps2 + rad > p2b1 and p2 + ps2 - rad < p2b2 then
		ps1 = 0
		if col == 1 then p1 = p1b1 - rad
		else p1 = p1b2 + rad end
	end

	return p1, ps1
end
