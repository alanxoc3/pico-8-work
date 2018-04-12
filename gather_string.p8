function gather_string(str, check_char)
	local acc, tmp = {}, ""
	str=str..check_char

	for i=1, #str do
		local c = sub(str, i, i)

		if c == check_char then
			add(acc, tmp)
			tmp = ""
		else
			tmp = tmp..c
		end
	end

	return acc
end
