-- returns a if it exists, nil otherwise
function add_not_exists(list, a)
	for x in all(list) do
		if a == x then return a end
	end
	return add(list, a)
end
