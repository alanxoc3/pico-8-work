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

-- call a function if not nil
function tl_func(num)
	if g_tl[g_tl_cur][num] then
		g_tl[g_tl_cur][num]()
	end
end

function tl_next()
	g_tl_tim = 0
end

function tl_update()
	-- switch the state
	if g_tl_tim == 0 then
		g_tl_cur = (g_tl_cur % #g_tl) + 1
		g_tl_tim = g_tl[g_tl_cur][3]

		tl_func(4)
	end

	tl_func(1) -- update func

	-- inc timer if enabled
	if g_tl_tim > 0 then
		-- stat 7 is the framerate
		g_tl_tim = max(0, g_tl_tim - 1/stat(7))
	end
end

function tl_draw()
	tl_func(2) -- draw func
end
