function acts_attach(list, a, attrs, params, vals, super_func)
	a = super_func(a)

	for i=1,#attrs do
		local ind = attrs[i]
		a[ind] = params[i] or a[ind] or vals[i]
	end

	return add_not_exists(list, a)
end
