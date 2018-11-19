-- this function compresses an image.
function img_c(ind, w, h, alt)
	-- step 1, convert the sprite to an uncompressed string.
	local str = ""

	local x, y = (ind % 16) * 8, flr(ind / 16) * 8

	for i=y,y+h-1 do
		for j=x,x+w-1 do
			str = str..x2s[sget(j, i)]
		end
	end

	-- step 2  compress dat string!
	local cnt, max_cnt, p_char, c_char, ret = 0, #c_str - 16, sub(str, 1, 1), "", ""

	for i=1,#str+1 do
		c_char = sub(str, i, i)
		if c_char != p_char or cnt == max_cnt or i == #str+1 then
			local meta = x2s[15+cnt]
			if cnt == 1 then meta = "" end
			if x2s[alt] == p_char then p_char = x2s[16] end
			ret = ret..meta..p_char
			cnt = 0
		end

		p_char = c_char
		cnt += 1
	end

	return ret, w, h
end
