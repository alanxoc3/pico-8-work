function create_lightning_p()
	local num_of_angs = flr(rnd(4) + 4)

	local x = rnd(108)+10

	local x_offs = {}
	local y_offs = {}
	local face = flr(rnd(2)+1)

	local y_sum = 0
	add(y_offs, 0)

	for i=1, num_of_angs do
		face = (face + 1) % 2

		local off = (rnd(20) + 4)
		if face == 0 then off = -off end

		add(x_offs, x + off)

		local y = rnd(40)+20
		if i == num_of_angs - 1 then y = 128 - y_sum end

		if i ~= num_of_angs then
			y_sum += y
			add(y_offs, y_sum)
		end
	end

	return {
		x_offs = x_offs,
		y_offs = y_offs,
		age = rnd(5)
	}
end

function update_lightning_p(_p)
	if _p.age > 10 then
		return false
	end

	_p.age += 1
	return true
end

function draw_lightning_p(_p)
	assert(#_p.y_offs > 1)
	assert(#_p.x_offs == #_p.y_offs)

	for i = 1, #_p.x_offs-1 do
		local x1 = _p.x_offs[i]
		local x2 = _p.x_offs[i+1]

		local y1 = _p.y_offs[i]
		local y2 = _p.y_offs[i+1]

		local col = 6
		if _p.age > 9 then col = 1
		elseif _p.age > 5 then col = 10
		end

		line(x1, y1, x2, y2, col)
		line(x1+1, y1, x2+1, y2, col)
		line(x1-1, y1, x2-1, y2, col)
	end
end

g_lightning = {
	create = create_lightning_p,
	update = update_lightning_p,
	draw   = draw_lightning_p,
	cont   = {},
	num    = 1
}
