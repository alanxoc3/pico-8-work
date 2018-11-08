function create_rain_p()
	-- ang point down.
	local ang = rnd(.1) + .625
	local spd = 2.5+rnd(1)
	return {
		x=rnd(160),
		y=-5,
		dx=cos(ang)*spd,
		dy=sin(ang)*spd,
		age=flr(rnd(25))
	}
end

function update_rain_p(_p)
	if _p.age > 80 or _p.x < 0 or _p.y < -10 or _p.x > 160 or _p.y > 128 then
		return false
	else
		_p.x   += _p.dx
		_p.y   += _p.dy
		_p.age += 1
	end

	return true
end

function draw_rain_p(_p)
	local col
	if _p.age > 75 then col=1
	elseif _p.age > 40 then col=13
	else col=12 end
	line(_p.x,_p.y,_p.x+_p.dx,_p.y+_p.dy,col)
end

g_rain = {
	create = create_rain_p,
	update = update_rain_p,
	draw   = draw_rain_p,
	cont   = {},
	num    = 20
}
