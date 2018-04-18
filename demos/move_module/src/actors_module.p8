g_acts_act_lst = {}

-- to generate an actor.
function acts_act_attach(a, ...)
	return acts_attach(g_acts_act_lst, a, {"alive", "update", "t"}, {...}, {true, nothing_func, 0}, function() return a or {} end)
end

function acts_act_update()
	acts_loop(g_acts_mov_lst, "update")
	foreach(g_acts_act_lst, function(a) a.t += 1 end)
end

function acts_clean(...)
	for list in all({...}) do
		for a in all(list) do
			if not a.alive then
				del(list, a)
			end
		end
	end
end

-- returns a if it exists, nil otherwise
function add_not_exists(list, a)
	for x in all(list) do
		if a == x then return a end
	end
	return add(list, a)
end

function acts_attach(list, a, attrs, params, vals, super_func)
	a = super_func(a)

	for i=1,#attrs do
		local ind = attrs[i]
		a[ind] = params[i] or a[ind] or vals[i]
	end

	return add_not_exists(list, a)
end

function nothing_func() end

-- allows you to pass in parameters too.
function acts_loop(list, func_name, ...)
	for a in all(list) do a[func_name](...) end
end
