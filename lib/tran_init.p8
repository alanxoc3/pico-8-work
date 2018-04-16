--- tokens: 46
-- con_tran()

function tran_init(tran_func, max_time, d1, d2, init_func)
	g_tran, g_tran_inc,
	g_tran_d1, g_tran_d2,
	g_tran_init, g_tran_func =

	0xffff, 2 / (max_time * 60), -- 60 is for FPS
	d1 or function() end, d2 or function() end,
	init_func, tran_func
end
