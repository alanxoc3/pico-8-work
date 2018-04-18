--- tokens: 76
-- example usage:
-- a.x, a.y, a.hs, a.vs = update_out_box(a.x, a.y, a.hs, a.vs, a.rad, a.rad, 2, 2, 4, 4)
function coll_out_box(x, y, hs, vs, xrad, yrad, bx1, by1, bx2, by2)
	x, hs = coll_dim_spd(x, y, hs, vs, bx1, bx2, by1, by2, xrad)
	y, vs = coll_dim_spd(y, x, vs, hs, by1, by2, bx1, bx2, yrad)

	return x, y, hs, vs
end

