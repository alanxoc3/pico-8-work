function str_to_words(str, line_len)
	local words, c, l_str = {}, "", str.." "
	for i=1, #l_str do
		local x = sub(l_str, i, i)

		if #c > 0 and x == " " then
			add(words, c)
			c = ""
		else
			c = c..x
		end
	end

	return words
end

