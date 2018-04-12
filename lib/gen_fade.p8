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

