--- tokens: 100
-- pl w is 8 and h is 8
function init_pl(_x, _y, _vx, _vy, face)
	g_x = _vx
	g_y = _vy

	g_pl = {}
	g_pl.x, g_pl.y, g_pl.spd = _x, _y, .1
	g_pl.hs, g_pl.vs = 0, 0
	g_pl.face = face
end

function update_pl(input_func, coll_func)
	if tbox_active() then return end

	input_func(btn(0), btn(1), btn(2), btn(3))

	g_pl.x, g_pl.y, g_pl.hs, g_pl.vs = coll_func()

	g_pl.x += g_pl.hs
	g_pl.y += g_pl.vs
end
