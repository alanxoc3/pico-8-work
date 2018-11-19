function amov_to_actor(a1, a2, spd)
	amov_to_point(a1, spd, a2.x, a2.y)
end

function amov_to_point(a, spd, x, y)
	local ang = atan2(x - a.x, y - a.y)
	a.ax, a.ay = spd*cos(ang), spd*sin(ang)
end

function dim_collide(a, b)
   return axis_collide("x", a, b) and axis_collide("y", a, b)
end

function axis_collide(axis, a, b)
   local ap, bp, ar, br = a[axis], b[axis], a["r"..axis], b["r"..axis]
   return ap > bp - br - ar and ap < bp + br + ar
end
