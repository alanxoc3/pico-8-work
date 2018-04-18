-- con_acts_act.p8
-- to generate an actor.
function acts_act_attach(a, ...)
	return acts_attach(g_acts_act_lst, a, {"alive", "update", "t"}, {...}, {true, nothing_func, 0}, function() return a or {} end)
end

