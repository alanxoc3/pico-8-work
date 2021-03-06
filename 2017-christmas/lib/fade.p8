-- fade should be a table (generated by gen_fade)
-- val is between -1 and 1
function fade(f, val)
	wid = #f[1] - 1
	val = min(max(flr(wid - abs(val) * wid), 0), wid) + 1

	for c=0,15 do
		pal(c,f[c+1][val])
	end
end

-- returns an expanded fade table from a string
-- you probably want to call this at the start of your program.
-- assumes the str has a string length of a multiple of 16.
function gen_fade(str)
	local ret, wid = {}, #str / 16
	for i=1, #str do
		local col, row = (i-1)%wid+1, flr((i-1)/wid)+1
		if i % wid == 1 then ret[row] = {} end
		ret[row][col] = s2x[ sub(str, i, i) ]
	end
	return ret
end

-- can't just do pal(), because that gets rid of transparency color. >:0
function clear_fade()
	for c=0,15 do
		pal(c,c)
	end
end
