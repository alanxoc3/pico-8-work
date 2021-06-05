-- amorg logo demo - 148 tokens

function cspr(txt, x, y, w, y_div)
	for i=1, #txt do
		local col
		local char = sub(txt, i, i)

		if     char == "0" then col = 0
		elseif char == "5" then col = 5
		elseif char == "7" then col = 7
			if y >= y_div then
				col = 5
			end
		elseif char == "c" then col = 12 end

		if col then pset(x,y,col) end

		if i % w == 0 then x -= w y += 1 end
		x+=1
	end
end

l_o = 67
l_p = 0
l_end = false
function draw_logo()
	clip(0, 60, 127, l_p)
	print("presents", 49, 69, 10)
	clip(0, 0, 127, 127)

	cspr("x0000000000xxxxxxxx000000000xx077770770770xxxxxx07777077770x070070777770xxxxxx07007070000x077770707070xxxxxx077700700770070070700070xxxxxx07007077770xx0000000000xxxxxxxx000000000xx", 50, 61, 30, 128)
	cspr("x000000x0077770007500570070cc070070cc0700750057000777700x000000x", 61, l_o, 8, 66)

	if l_o <= 60 then
		l_p += .5
		l_end = l_p > 27
	else
		l_o -= .5
	end
end
