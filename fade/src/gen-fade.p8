-- generates a fade string from the coordinates in pixels on the sprite sheet.
-- a 16x16 pixel image is assumed.
function gen_fade_str(x, y)
	local ret = ""
	for i=y,y+15 do
		for j=x,x+15 do
			ret=ret..x2s[sget(j, i)]
		end
	end
	return ret
end

