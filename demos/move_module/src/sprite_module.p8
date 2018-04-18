g_acts_spr_lst = {}

-- params are: sind, sw, sh, xf, yf, pre_draw, post_draw
-- sind = -1 -- not visible
function acts_spr_attach(a, ...)
	return acts_attach(g_acts_spr_lst, a,
	{"sind", "sw", "sh", "xf", "yf", "pre_draw", "post_draw"},
	{...}, {0, 1, 1, false, false, nothing_func, nothing_func},
	acts_act_attach)
end

function acts_spr_draw()
	-- set speed
	foreach(g_acts_spr_lst,
		function(a)
			if a.sind >= 0 then
				spr(a.sind,
					scr_x(a.x-a.sw/2),
					scr_y(a.y-a.sh/2),
					a.sw, a.sh, a.xf, a.yf)
			end
		end)
end
