function create_smoke_p(_x, _y)
	-- ang point down.
	local ang = rnd(.5)
	local spd = .25+rnd(.5)
	return {
		x=_x,
		y=_y,
		r=rnd(5)+4,
		dx=cos(ang)*spd,
		dy=sin(ang)*spd,
		age=flr(rnd(25))
	}
end

function update_smoke_p(_p)
	if _p.age > 200 or _p.x < -10 or _p.y < -10 or _p.x > 138 or _p.y > 128 then
		return false
	else
		_p.x   += _p.dx
		_p.y   += _p.dy
		_p.age += 1
		_p.dy  -= .005
		_p.r   -= .05
	end

	return true
end

function draw_steam_p(_p)
	if _p.age > 130 then col=g_col_3
	elseif _p.age > 60 then col=g_col_2
	else col=g_col_1 end
	circfill(_p.x, _p.y, _p.r, col)
end

function draw_smoke_p(_p)
	local col
	if _p.age > 70 then col=g_col_2
	elseif _p.age > 60 then col=g_col_3
	else col=g_col_1 end
	circfill(_p.x, _p.y, _p.r, col)
end

g_smoke = {
	create = create_smoke_p,
	update = update_smoke_p,
	draw   = draw_smoke_p,
	cont   = {},
	num    = 20
}

g_steam = {
	create = create_smoke_p,
	update = update_smoke_p,
	draw   = draw_steam_p,
	cont   = {},
	num    = 20
}
