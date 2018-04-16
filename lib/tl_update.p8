--- tokens: 46
function tl_update(tl)
	-- switch the state
	if tl.time == 0 then
		tl.current = tl.next
		tl.next = (tl.current % #tl.master) + 1
		tl.time = tl.master[tl.current][3]
		tl_func(tl, 4) -- init func
	end

	tl_func(tl, 1) -- update func

	-- inc timer if enabled
	if tl.time then
		tl.time = max(0, tl.time - 1/60)
	end
end

