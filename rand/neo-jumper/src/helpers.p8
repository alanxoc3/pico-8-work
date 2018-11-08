function min_and_max_lvl(lvl, mi1, ma1, mi2, ma2)
	return num_from_lvl(lvl, mi1,  mi2), num_from_lvl(lvl, ma1, ma2)
end

function num_from_lvl(lvl, num1, num2)
	if num1 - num2 > 0 then
		-- descending numbers
		lvl = 30 - lvl + 1

		local tmp = num1
		num1 = num2
		num2 = tmp
	end

	return gen_range(lvl, 1, 30, num1, num2)
end

-- first and last
function gen_range(lvl, first_lvl, last_lvl, first_num, last_num)
	return (last_num - first_num) / (last_lvl - first_lvl) * (lvl - first_lvl) + first_num
end

function flrrnd(num, off)
	if not off then off = 0 end
	return flr(rnd(num) + off)
end

function irnd(_min, _max)
	return flrrnd(1 + _max - _min, _min)
end

function gen_patch(x1, x2, gap_wid_func, gen_func)
	local acc, w = 0, x2 - x1 + 1

	while true do
		local gap, wid = gap_wid_func(acc, w)
		acc += gap + wid

		if acc < w then
			gen_func(acc + x1 - wid, acc + x1 - 1)
		else break end
	end
end

function collision_above(x, xr, y, yr, vs, solid_func)
	local min_x, max_x = flr(x - xr), -flr(-(x + xr)) - 1

	for i=min_x, max_x do
		if solid_func(i, y + yr + vs + .5) then return true end
	end

	return false
end

function blink_coroutine()
	while true do
		for i=1, 16 do
			local cb = yield(true)
			cb()
		end
		for i=1, 6 do yield(false) end
	end
end

-- my math aint the best. these functions were taken from.
-- https://www.lexaloffle.com/bbs/?tid=3142
function acos(x)
 return atan2(x,-sqrt(1-x*x))
end

function asin(y)
 return atan2(sqrt(1-y*y),-y)
end
