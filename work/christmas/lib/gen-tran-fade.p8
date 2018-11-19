-- used in conjunction with the fade.
function gen_tran_fade(fade_tab)
	return function(val, draw_func)
		fade(fade_tab, val)
		draw_func()
	end
end

