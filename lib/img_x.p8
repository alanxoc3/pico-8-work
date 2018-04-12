-- alan morgan

-- embed this function in your game
-- returns an uncompressed version of your image
function img_x(str)
	local ret = ""
	local rep = false
	local cnt = 0

	for i=1, #str do
		local char = sub(str,i,i)
		if cnt > 16 then
			for i=16,cnt do
				ret = ret..char
			end
			cnt = 0
		else
			cnt = s2x[char]

			if cnt <= 16 then
				ret = ret..char
			end
		end
	end

	return ret
end
