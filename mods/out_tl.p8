pico-8 cartridge // http://www.pico-8.com
version 16
__lua__
-- mod test
-- by alan morgan
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
-->8
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
__sfx__
010f0000212502325029250262502623026220262102620026200262002b0702b0502b0302b0202b0100000000000000000000000000000000000000000000000000000000000000000000000000000000000000
