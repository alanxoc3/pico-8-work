--- tokens: 286
-- con_tbox()

-- add a new text box, id is optional, it is the id of the event. you can check
-- if an event is done with a unique id.
function tbox(str)
	local acc, id, speaker, mode, options, l_str = "", "", "", "|", {}, str.."|"

	for i=1, #l_str do
		local x = sub(l_str, i, i)

		if x == ":" or x == "|" or x == "@" or x == "%" then
			if mode == ":" then
				local lines = str_to_word_lines(acc, g_tbox_max_len)

				for i=1,#lines do
					local l = lines[i]
					if i % 2 == 1 then
						add(g_tbox_messages, {options=options, speaker=speaker, id=id, l1=l, l2=""})
						options, id = {}, ""
					else
						g_tbox_messages[#g_tbox_messages].l2 = l
					end
				end

			elseif mode == "|" then speaker, id = acc, ""
			elseif mode == "@" then id = acc
			elseif mode == "%" then add(options, acc) end
			mode, acc = x, ""
		else
			acc=acc..x
		end
	end

	g_tbox_active = g_tbox_messages[1]
end

