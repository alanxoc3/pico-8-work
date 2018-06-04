-- con_actors()
function acts_vec_update()
	local acts = filter_val(g_actors, "vec")
	foreach(acts, function(a)
		a.x += a.dx
		a.y += a.dy
	end)
end
