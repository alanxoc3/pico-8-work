function filter(list, pred)
	local ret = {}
	for a in all(list) do
		if pred(a) then add(ret, a) end
	end
	return ret
end

