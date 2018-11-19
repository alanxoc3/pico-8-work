-- nothing_func()
-- to generate an actor.
function acts_act_attach(a, ...)
	return acts_attach("act", a, {"alive", "update", "t"}, {...}, {true, nothing_func, 0}, function() return a or {} end)
end

