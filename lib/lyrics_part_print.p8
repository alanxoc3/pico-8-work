--- tokens: 192
function lyrics_part_print(p)
	local txt, x, y, fg, bg, t = p.txt, p.x, p.y, p.fg, p.bg, p.t

	local w = ((#txt)*4-2) / 2
	local h = 2
	local wt, ht = w*t/6, h*t/6

	local x1, y1, x2, y2 = x+w-wt, y+h-ht, x+w+wt, y+h+ht
	
	if t > 0 and #txt > 0 then
		if p.middle then x1 -= 1 x2 += 1 end
		rectfill(x1, y1, x2, y2, bg)

		if t == 6 then
			for o in all({-1, 1}) do
				print(txt, x+o, y, bg)
				print(txt, x, y+o, bg)
			end

			print(txt, x, y, fg)
		else
			rectfill(x1+1, y1+1, x2-1, y2-1, fg)
		end
	end
end

