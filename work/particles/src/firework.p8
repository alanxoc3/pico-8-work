-- global declaration must be after the function declaration.

function create_firework_p(_x,_y)
	local angle = rnd()
	local speed = 0.5+rnd(1)
	return {
		x=_x,
		y=_y,
		dx=sin(angle)*speed,
		dy=cos(angle)*speed,
		age=flr(rnd(25))
	}
end

function update_firework_p(_p)
	if _p.age > 40 or _p.x < 0 or _p.y < 0 or _p.x > 128 or _p.y > 128 then
		return false
	else
		_p.x   += _p.dx
		_p.y   += _p.dy
		_p.age += 1
		_p.dy += .075
	end

	return true
end

function draw_firework_p(_p)
	local col
	if _p.age > 60 then col=8
	elseif _p.age > 40 then col=9
	elseif _p.age > 20 then col=10
	else col=7 end
	line(_p.x,_p.y,_p.x+_p.dx,_p.y+_p.dy,col)
end

g_firework = {
	create = create_firework_p,
	update = update_firework_p,
	draw   = draw_firework_p,
}
