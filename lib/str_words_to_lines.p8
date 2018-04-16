function str_words_to_lines(words, line_len)
	local lines, l = {}, ""
	add(words, "")

	for x in all(words) do
		if #(l..x) > line_len or x == "" then
			add(lines, l)
			l = ""
		end

		l = l..x.." "
	end

	return lines
end

