--- tokens: 26
-- tl array fields:
--    update: callback for every frame.
--    draw:   callback for every frame.
--    timer:  t > 0: measured in seconds. t == 0: done. t < 0: disabled.
--    reset:  optional reset callback. called right before the first update.

-- pass the array into this function.
function tl_init(tl_master)
	assert(#tl_master > 0)

	local tl = {
		master=tl_master,
		current=1,
		next=(1 % #tl_master)+1,
		time = tl_master[1][3]
	}

	-- init function
	tl_func(tl, 4)

	return tl
end
