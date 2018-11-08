function _init()
	ls = lyrics_to_lines("hello:my:name:is:alan")
end

function line_pixel_length(str)
	local len = 0

	for i=1, #str do
		if sub(str,i,i) != "." then
			len+=1
		end
	end

	return len*4+1
end

function lyrics_to_lines(str)
	str = str..":"

	local lines = {}
	local l = ""
	for i=1, #str do
		local char = sub(str, i, i)
		if char == ":" then
			add(lines, l)
			l = ""
		else
			l = l..char
		end
	end
	
	return lines
end

function _update()
end

function _draw()
	cls()
	for i, x in pairs(ls) do
		print(x, 3, i*10+3, 7)
		print(line_pixel_length(x), 50, i*10+3, 7)
	end
end
