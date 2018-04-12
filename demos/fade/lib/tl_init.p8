-- alan morgan

-- tl array fields:
--    update: callback for every frame.
--    draw:   callback for every frame.
--    timer:  t > 0: measured in seconds. t == 0: done. t < 0: disabled.
--    reset:  optional reset callback. called right before the first update.

-- pass the array into this function.
function tl_init(tl)
	assert(#tl > 0)
	g_tl = tl

	g_tl_cur = 1
	g_tl_tim = tl[g_tl_cur][3]

	tl_func(4)
end

