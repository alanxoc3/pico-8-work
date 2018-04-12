-- call a function if not nil
function tl_func(num)
	if g_tl[g_tl_cur][num] then
		g_tl[g_tl_cur][num]()
	end
end

