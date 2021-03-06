g_tran = 0
g_tran_inc = 0

-- nils, i'm saving tokens
-- g_tran_d1 = nil
-- g_tran_d2 = nil
-- g_tran_init = nil
-- g_tran_func = nil

-- tran_func: the type of transition to draw, takes val and drawn function.
-- max_time: time for entire transition. measured in seconds.
-- d1: draw function 1 (for first phase of transition)
-- d2: draw function 2 (for first phase of transition)
-- init_func: the function to call in the middle of the two functions.
function init_tran(tran_func, max_time, d1, d2, init_func)
	g_tran, g_tran_inc,
	g_tran_d1, g_tran_d2,
	g_tran_init, g_tran_func =

	0xffff, 2 / (max_time * 60), -- 60 is for FPS
	d1 or function() end, d2 or function() end,
	init_func, tran_func
end

function update_tran()
	local prev_tran = g_tran
	g_tran = min(g_tran+g_tran_inc, 1)

	if prev_tran < 0 and g_tran >= 0 then
		if g_tran_init then g_tran_init() end
	end
end

function draw_tran()
	if g_tran_func then
		g_tran_func(g_tran, g_tran < 0 and g_tran_d1 or g_tran_d2)
	end
end
