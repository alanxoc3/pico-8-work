function tl_update()
	-- switch the state
	if g_tl_tim == 0 then
		g_tl_cur = (g_tl_cur % #g_tl) + 1
		g_tl_tim = g_tl[g_tl_cur][3]

		tl_func(4) -- init func
	end

	tl_func(1) -- update func

	-- inc timer if enabled
	if g_tl_tim > 0 then
		g_tl_tim = max(0, g_tl_tim - 1/60)
	end
end

