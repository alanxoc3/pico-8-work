-- con_acts_spr.p8
function acts_spr_draw()
	local acts = filter_val(g_actors, "spr")
	-- set speed
	foreach(acts,
		function(a)
			if a.sind >= 0 then
				spr(a.sind,
					scr_x(a.x-a.sw/2),
					scr_y(a.y-a.sh/2),
					a.sw, a.sh, a.xf, a.yf)
			end
		end)
end
