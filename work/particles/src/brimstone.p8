function create_brimstone_p()
	-- ang point down.
	local ang = rnd(.05) + .7
	local spd = 2.5+rnd(1)
	return {
		x=rnd(160),
		y=-5,
		dx=cos(ang)*spd,
		dy=sin(ang)*spd,
		age=flr(rnd(25))
	}
end

function update_brimstone_p(_p)
	if _p.age > 80 or _p.x < 0 or _p.y < -10 or _p.x > 160 or _p.y > 128 then
		return false
	else
		_p.x   += _p.dx
		_p.y   += _p.dy
		_p.age += 1
	end

	return true
end

function draw_brimstone_p(_p)
	local col = 5
	if _p.age > 60 then col=2
	elseif _p.age > 30 then col=8
	elseif _p.age > 20 then col=9
	elseif _p.age > 10 then col=4
	end
	circfill(_p.x, _p.y, 1, col)
end

g_brimstone = {
	create = create_brimstone_p,
	update = update_brimstone_p,
	draw   = draw_brimstone_p,
}
