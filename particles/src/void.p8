g_void_x = 10

function create_void_p()
	-- create void
	return {
		x  = rnd(4)-2,
		y  = rnd(128),
		dx = rnd(.15) + .005,
		t  = rnd(40)
	}
end

function update_void_p(_p)
	if _p.t > 40 then
		return false
	end

	_p.x += _p.dx
	_p.t += 1

	return true
end

function draw_void_p(_p)
	local col = 0
	if _p.t > 20 then col = 5 end
	if _p.t > 28 then col = 2 end
	pset(g_void_x+_p.x, _p.y, col)
end

g_void = {
	create = create_void_p,
	update = update_void_p,
	draw   = draw_void_p,
}
