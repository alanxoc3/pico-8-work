-- con_actors()
function acts_attach(id, a, attrs, params, vals, super_func)
	a = super_func(a)
	a[id] = true

	for i=1,#attrs do
		local ind = attrs[i]
		a[ind] = params[i] or a[ind] or vals[i]
	end

	add_not_exists(g_actors, a)
	return add_not_exists(g_all_actors, a)
end
