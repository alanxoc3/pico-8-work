-- con_actors()
function acts_act_update()
	acts_loop(g_actors, "update")
	foreach(g_actors, function(a) a.t += 1 end)
end
