--- tokens: 51
function draw_logo()
	clip(0, l_y, 127, 8 + l_p)   -- 7 is the height of the top text (plus 1)
	cspr(logo_text, l_x, l_y+1, 34) -- 34 is the width of the logo
	clip(0, 0, 127, 127)

	logo_cspr("x000000x0077770007500570070cc070070cc0700750057000777700x000000x", l_x+13, l_y+l_o, 8, l_y+6)
end

