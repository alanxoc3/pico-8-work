function draw_tran()
	if g_tran_func then
		g_tran_func(g_tran, g_tran < 0 and g_tran_d1 or g_tran_d2)
	end
end
