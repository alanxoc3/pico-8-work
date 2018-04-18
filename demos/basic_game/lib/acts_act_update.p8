-- con_acts_act()
function acts_act_update()
	acts_loop(g_acts_act_lst, "update")
	foreach(g_acts_act_lst, function(a) a.t += 1 end)
end
