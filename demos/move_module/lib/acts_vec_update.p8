-- con_acts_vec()
function acts_vec_update()
	foreach(g_acts_vec_lst, function(a)
		a.x += a.dx
		a.y += a.dy
	end)
end
