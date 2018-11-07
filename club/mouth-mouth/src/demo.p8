-- mouth mouth
-- by alan and anne

function _init()
	mouth_x = 64
	mouth_y = 64
	mouth_hs = 0
	mouth_vs = 0
	mouth = create_mouth()
	mouth_to_open(mouth, 1)
	--mouth_to_close(mouth)

	taco = {
		x=rnd(128-8), y=rnd(128-8),
		r=8, dx=rnd(1)+1, dy=rnd(1)+1,
	}

	texts = {}
	add(texts, "you want the taco")
	add(texts, "yes, you do")
	add(texts, "just eat it.")
	add(texts, "cmon!!!!!!")
	add(texts, "I <3 tacos")
	tind = 1
	g_t = 0
end

function mouth_to_open(mouth, t)
	for point in all(mouth.arr) do
		point.dx, point.dy = set_point_speed(point.x, point.y, point.ox, point.oy, t)
		point.t = 0
		point.end_t = t*60
	end
end

function mouth_to_close(mouth, t)
	for point in all(mouth.arr) do
		point.dx, point.dy = set_point_speed(point.x, point.y, point.cx, point.cy, t)
		point.t = 0
		point.end_t = t*60
	end
end

-- starts out closed
function mouth_point(cx, cy, ox, oy)
	return {
		cx = cx, cy = cy,
		ox = ox, oy = oy,
		x = cx, y = cy,
		dx = cx, dy = cy,
	}
end

function draw_mouth(m, mx, my, lip_col, teeth_col)
	local th = 4
	local toff = 1
	local hs, vs = -mouth_hs, -mouth_vs

	rectfill(mx+m.p8.x+hs, my+m.p8.y+toff+vs, mx+m.p2.x+hs, my+m.p2.y+th+toff+vs, teeth_col)

	toff = 2
	local txoff = 2

	for i=-4,-1-vs do
		line(mx+txoff+m.p6.x+hs, my+m.p6.y+i+toff+vs, mx-txoff+m.p4.x+hs, my+m.p4.y+i+toff+vs, teeth_col)
	end

	for point in all(m.arr) do
		for i=-2,2 do
			line(mx+point.x, my+point.y+i, mx+point.np.x, my+point.np.y+i, lip_col)
		end
	end
end

function set_point_speed(x1, y1, x2, y2, t)
	local dx = (x2 - x1) / (t*60)
	local dy = (y2 - y1) / (t*60)
	return dx, dy
end

function update_mouth(m)
	for point in all(m.arr) do
		point.x += point.dx
		point.y += point.dy

		if point.t > point.end_t then
			point.dx = 0
			point.dy = 0
			point.t = point.end_t
		end
		point.t+=1
	end
end

function _update60()
	local spd = 1

	mouth_hs, mouth_vs = 0, 0

	if btn(4) or btn(5) then
		mouth_to_close(mouth, .1)
	else
		mouth_to_open(mouth, .2)
	end

	if btn(0) then
		mouth_hs = -spd
	end

	if btn(1) then
		mouth_hs = spd
	end

	if btn(2) then
		mouth_vs = -spd
	end

	if btn(3) then
		mouth_vs = spd
	end

	update_mouth(mouth)
	mouth_x += mouth_hs
	mouth_y += mouth_vs

	taco.x+=taco.dx
	taco.y+=taco.dy

	if mouth_x < 0   then mouth_x = 0 end
	if mouth_x > 128 then mouth_x = 128 end
	if mouth_y < 0   then mouth_y = 0 end
	if mouth_y > 128 then mouth_y = 128 end

	if taco.x-taco.r < 0 or taco.x+taco.r > 128 then
		taco.dx = -taco.dx
	end

	if taco.y-taco.r < 0 or taco.y+taco.r > 128 then
		taco.dy = -taco.dy
	end

	if g_t % (60*2) == 0 then
		tind = flr(rnd(5)) + 1
	end

	g_t += 1
end

function _draw()
	cls(tind)

	draw_mouth(mouth, mouth_x, mouth_y, 8, 7)
	print(texts[tind], mouth_x-14, mouth_y - 15, 7)
	spr(1, taco.x, taco.y, 2, 1)
end

function create_mouth()
	local m = {}

	m.p1 = mouth_point(0, -2,  0,  -6) -- top
	m.p2 = mouth_point(12,-4,  12,  -8) -- top right
	m.p3 = mouth_point(19, 0,  19,  -2) -- right
	m.p4 = mouth_point(4,  3,  13,   5) -- bot right
	m.p5 = mouth_point(0,  4,  0,   9) -- bot
	m.p6 = mouth_point(-4, 3,  -13,  5) -- bot left
	m.p7 = mouth_point(-19,0,  -19, -2) -- left
	m.p8 = mouth_point(-12,-4, -12, -8) -- top left

	m.p1.np = m.p2
	m.p2.np = m.p3
	m.p3.np = m.p4
	m.p4.np = m.p5
	m.p5.np = m.p6
	m.p6.np = m.p7
	m.p7.np = m.p8
	m.p8.np = m.p1

	m.arr = {}
	add(m.arr, m.p1)
	add(m.arr, m.p2)
	add(m.arr, m.p3)
	add(m.arr, m.p4)
	add(m.arr, m.p5)
	add(m.arr, m.p6)
	add(m.arr, m.p7)
	add(m.arr, m.p8)

	return m
end

