--- tokens: 33
function line_char_len(l)
	local len = 0

	-- characters
	for w in all(l) do
		for p in all(w) do
			len += #p
		end
	end

	-- spaces
	len += #l - 1

	return len
end
