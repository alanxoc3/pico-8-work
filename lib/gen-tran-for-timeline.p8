-- alan morgan

-- used in conjunction with the timeline.
function gen_tran_for_timeline(tran_func, tran_time, d1, d2, init_func, time)
	return { update_tran, draw_tran, time or tran_time, function() init_tran(tran_func, tran_time, d1, d2, init_func) end }
end
