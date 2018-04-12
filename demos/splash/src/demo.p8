function _init()
	gen_cipher()
	tl_init({
		-- { update_logo, draw_logo_test, 3, init_logo },
		{ update_logo, draw_logo, 3, init_logo }
	})

	g_color = 0
end

function _update60()
	tl_update()
	if btnp(0) then
		g_color = (g_color - 1) % 15
	end

	if btnp(1) then
		g_color = (g_color + 1) % 15
	end
end

function _draw()
	cls(g_color)

	tl_draw()
end

function draw_logo_test()
	palt(0, false)
	palt(14, true)
	clip(0, l_y, 127, 8 + l_p)   -- 7 is the height of the top text
	spr(0, l_x, l_y+1, 5, 2)
	clip(0, 0, 127, 127)

	spr(5, l_x+13, l_y+l_o)
end
