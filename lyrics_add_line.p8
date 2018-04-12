-- returns the offset
function lyrics_add_line(l, x, y, fg, bg, tim_off, tim_int)
	local off, beat = 0, tim_off

	for w in all(l) do
		for p in all(w) do
			if #p > 0 then
				lyrics_add_part(p, x+off*4, y, fg, bg, beat, false, 0)
				off += #p
			end
			beat -= tim_int
		end
		
		off += 1
	end

	lyrics_add_part("", (x+off)*4, y, fg, bg, beat+tim_int, false, 0, lyrics_swipe)

	return beat
end
