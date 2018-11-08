function _init()
	c_str = "0123456789abcdefxghijklmnopqrstuvwyz!@#$%^&*()[]{}?+/=-_,<.>"
	s2x, x2s = {}, {}
	for i=1,#c_str do
		s2x[ sub(c_str,i,i) ]=i-1
		x2s[i-1] = sub(c_str,i,i)
	end

	-- edit this line with your
	-- sprite parameters
	-- index, width, height, alt col
	g_str, g_w, g_h = img_c(2,12,7, 14)

	-- this is printed to cli.
	printh("str = img_x(\""..g_str.."\")")
	extracted = img_x(g_str, g_w, g_h)
end

-- spr index, width, height, alt color
-- returns a string
function img_c(ind, w, h, alt)
	-- step 1, convert the sprite to an uncompressed string.
	w *= 8
	h *= 8
	local str = ""

	local x, y = (ind % 16) * 8, flr(ind / 16) * 8

	for i=y,y+h-1 do
		for j=x,x+w-1 do
			str = str..x2s[sget(j, i)]
		end
	end

	-- step 2  compress!
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

-- returns an uncompressed string.
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

function cspr(txt, x, y, w)
	for i=1, #txt do
		local col = s2x[ sub(txt, i, i) ]
		if col != 16 then pset(x,y,col) end
		if i % w == 0 then x -= w y += 1 end
		x+=1
	end
end

function _draw()
	cls()
	rectfill(0, 0, 128, 12, 13)
	print('import a spritesheet,', 1, 1, 7)
	print('edit line #15, then view cli.', 1, 7, 7)

	cspr(extracted, 0, 14, g_w)

	rectfill(0, 115, 128, 128, 13)
	print('cmp: '..#g_str.."/"..#extracted.." or "..(#g_str/#extracted*100).."%", 1, 116, 7)

	print('cpu: '..stat(1), 1, 122, 7)
	print('mem: '..stat(0), 64, 122, 7)
end
