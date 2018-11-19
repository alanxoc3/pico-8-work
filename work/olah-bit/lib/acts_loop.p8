-- allows you to pass in parameters too.
function acts_loop(list, func_name, ...)
	for a in all(list) do
		if a[func_name] then
			a[func_name](...)
		end
	end
end
