function str_to_word_lines(str, line_len)
	-- word, line, loop_string, lines
	local l, w, l_str, lines = "", "", str.." ", {}
	for i=1, #l_str do
		local c = sub(l_str, i, i)

		if #w > 0 and c == " " then
			-- str_words_to_lines
			if #(l..w) > line_len then
				add(lines, l)
				l = ""
			end

			l, w = l..w.." ", ""
			-- end str_words_to_lines
		else
			w = w..c
		end
	end
	add(lines, l)

	return lines
end
