function _init()
	g_tl = tl_init( {
		{ title_update, title_draw, nil, title_init },
	} )
end

function _update60()
	tl_update(g_tl)
end

function _draw()
	cls()
	tl_draw(g_tl)
end

function title_update()
end

function title_draw()
	rect(3, 3, 48, 48, 7)
end

function title_init()
end
