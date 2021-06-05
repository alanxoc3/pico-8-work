function gen_obstruction(b, x, y_ground, max_height)
	local loc = flrrnd(max_height, 1)

	if loc > 1 and flrrnd(max_height) == 0 then
		y_ground += 1
		loc -= 1
	end

	gen_bar(b, y_ground + 1, y_ground + loc, x)
end

-- horizontal line
function gen_platform(b, x1, x2, y)
	assert(x1 >= 1)
	assert(x2 <= b.w)
	assert(x1 <= x2)

	for x=x1, x2 do
		b[x][y] = 1
	end

	gen_bar(b, 1, y, x1)
end

-- vertical line
function gen_bar(b, y1, y2, x, delete)
	assert(y1 >= 1)
	assert(y2 <= b.h)
	assert(y1 <= y2)

	for y=y1, y2 do
		if delete then
			b[x][y] = 0
		else
			b[x][y] = 1
		end
	end
end

function gen_mtn(b, x1, x2, h, gorge)
	if not gorge then gorge = 0 end

	-- because of 1 indexing, there are 1s everywhere.
	local w = flr(x2 - x1 + 1)

	if gorge >= w then return end

	local half = flr(w / 2) - 1
	local half_gorge = flr( (gorge - 1) / 2 )

	gen_half_mtn(b, x1,        x1 + half, h, true, nil)
	gen_half_mtn(b, x2 - half, x2,        h, false, nil)

	local start = x1 + half - half_gorge
	local final = x2 - half + half_gorge

	if w % 2 != 0 and gorge % 2 != 0 then
		final -= 1
	end

	if (w % 2 != 0 and gorge > 0) or gorge % 2 != 0 then
		start += 1
	end

	local middle = flr(final - start) + start

	for i= start, final do
		if i != middle or gorge > 0 then
			gen_bar(b, 1, h, i, true)
		elseif w % 2 != 0 then
			gen_bar(b, 1, h, i)
		end
	end
end

-- buffer, x1, x2, height, type, ascending?, steepness
-- steep can be nil, 1, 2, or 3. if nil, then the mtn will increase according
-- to its own will.
function gen_half_mtn(b, x1, x2, h, ascend, spacing)
	if not spacing then spacing = 1 end
	local w = (x2 - x1 + 1) / spacing

	-- calc steep and contour
	local steep = min(-flr(-h / w), 3)
	local contour = max(1, flr(w / h))

	-- order matters here. don't put above width.
	if not ascend then
		x1, x2 = x2, x1
		spacing *= -1
	end

	local cur_h = 0
	for x=x1, x2, spacing do
		if (ascend and (x - x1) % contour == 0) or
		(not ascend and (x2 - x - 1) % contour == 0) then
			cur_h = min(cur_h + steep, h, b.h)
		end

		gen_bar(b, 1, max(cur_h, 1), x)
	end
end
