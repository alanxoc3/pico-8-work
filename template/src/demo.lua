function _init()
	g_tl = tl_init( {
		{ update_logo, draw_logo, 2.5, init_logo },
		-- { title_update, title_draw, 1, title_init },
		{ game_update, game_draw, nil, game_init },
	} )
end

function _update60()
	tl_update(g_tl)
end

function _draw()
	cls()
	tl_draw(g_tl)
end

function game_update()
end

function game_draw()
	cls()
	print('pico project!', 1, 1, 7)
end

function game_init()
end
