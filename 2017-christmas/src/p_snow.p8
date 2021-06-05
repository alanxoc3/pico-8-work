--- tokens: 141
function create_snow_p()
	-- ang point down.
	local ang = .73+rnd(.04)
	local spd = .75+rnd(1)
	return {
		x=rnd(128),
		y=-5,
		dx=cos(ang)*spd,
		dy=sin(ang)*spd,
		rad=rnd(.7) + .5,
		age=0
	}
end

function update_snow_p(_p)
	if _p.x < -2 or _p.y < -10 or _p.x > 130 or _p.y > 128 then
		return false
	else
		_p.x   += _p.dx
		_p.y   += _p.dy
		_p.age += 1
	end

	return true
end

function draw_snow_p(_p)
	local col = 7
	circfill(_p.x, _p.y, _p.rad, col)
end

g_snow = {
	create = create_snow_p,
	update = update_snow_p,
	draw   = draw_snow_p,
	cont   = {},
}
