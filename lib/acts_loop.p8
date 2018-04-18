-- allows you to pass in parameters too.
function acts_loop(list, func_name, ...)
	for a in all(list) do a[func_name](...) end
end
