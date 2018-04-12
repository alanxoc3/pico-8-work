-- con_tbox()

-- add a new text box, id is optional, it is the id of the event. you can check
-- if an event is done with a unique id.
function tbox(str)
	local acc, id, speaker, mode, options = "", "", "", "|", {}
	str=str.."|"

	for i=1, #str do
		local x = sub(str, i, i)

		if x == ":" or x == "|" or x == "@" or x == "%" then
			if mode == ":" then
				-- adding the message
				local add_mes = function(l)
					add(tbox_messages, {options=options, speaker=speaker, id=id, line=l})
				end

				if #tbox_messages%2==1 then
					add_mes("")
				end

				for l in all(
					words_to_lines(
						str_to_words(acc, g_tbox_max_len),
						g_tbox_max_len
					)
				) do
					add_mes(l)
					options = {} -- reset after the very first
					id = "" -- reset that too
				end
				-- end
				-- options={} -- this should be optional

			elseif mode == "|" then speaker, id = acc, ""
			elseif mode == "@" then id = acc
			elseif mode == "%" then add(options, acc) end
			mode, acc = x, ""
		else
			acc=acc..x
		end
	end
end

function str_to_words(str, line_len)
	local words, c = {}, ""
	str=str.." "
	for i=1, #str do
		local x = sub(str, i, i)

		if #c > 0 and x == " " then
			add(words, c)
			c = ""
		else
			c = c..x
		end
	end

	return words
end

function words_to_lines(words, line_len)
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

