-- generates a fade string from the coordinates in pixels on the sprite sheet.
-- a ?x16 pixel image is assumed.
function gen_fade_str(x, y, wid)
	local ret = ""
	for i=y,y+15 do
		for j=x,x+ (wid or 16) -1 do
			ret=ret..x2s[sget(j, i)]
		end
	end
	return ret
end

