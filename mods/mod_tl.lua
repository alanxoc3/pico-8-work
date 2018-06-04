-- tl

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

-- optional number of which state should be loaded next.
function tl_next(tl, num)
	tl.time=0
	if num then tl.next=num end
end

-- call a function if not nil
-- call a function if not nil
function tl_func(tl, num)
	if tl.master[tl.current][num] then
		tl.master[tl.current][num]()
	end
end

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

function tl_draw(tl)
	tl_func(tl,2) -- draw func
end
