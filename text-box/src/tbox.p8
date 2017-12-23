-- 537 tokens

-- api
-- speaker:line:line@id:line|newspeaker:line...

-- "|" speaker
-- ":" line
-- "@" id

tbox_messages={} -- the array for keeping track of text box overflows
g_tbox_anim=0
g_tbox_max_len=26

function break_up_long_word(words, w, max_len)
	for i=1, #w, max_len-1 do
		if i+max_len <= #w then
			add(words, sub(w, i, i+max_len-2).."-")
		else
			add(words, sub(w, i, #w))
			return
		end
	end
end

function str_to_words(str, line_len)
	local words, c = {}, ""
	str=str.." "
	for i=1, #str do
		local x = sub(str, i, i)

		if #c > 0 and x == " " then
			break_up_long_word(words, c, line_len)
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

function is_tbox_done(id)
	for l in all(tbox_messages) do
		if l.id == id then
			return false
		end
	end
	return true
end

-- add a new text box, id is optional, it is the id of the event. You can check
-- if an event is done with a unique id.
function tbox(str)
	local acc, id, speaker, mode = "", "", "", "|"
	str=str.."|"

	for i=1, #str do
		local x = sub(str, i, i)

		if x == ":" or x == "|" or x == "@" then
			if     mode == ":" then
				-- adding the message
				local add_mes = function(l)
					add(tbox_messages, {speaker=speaker, id=id, line=l})
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
				end
				-- end

			elseif mode == "|" then speaker, id = acc, ""
			elseif mode == "@" then id = acc end
			mode, acc = x, ""
		else
			acc=acc..x
		end
	end
end

-- check for button presses so we can clear text box messages
function tbox_interact()
	if tbox_active() then
		g_tbox_anim += 1
		if btnp(4) then
			sfx(61)
			if #tbox_messages>1 then
				del(tbox_messages, tbox_messages[1])
			end
			del(tbox_messages, tbox_messages[1])
			g_tbox_anim = 0
		end
	end
end

-- check if a text box is currently visible (useful if the dialogue clear
-- button is used for other actions as well)
function tbox_active()
	return #tbox_messages>0
end

-- draw the text boxes (if any)
-- foreground color, background color, border width
function tbox_draw(fg_col, bg_col, b_w)
	if tbox_active() then -- only draw if there are messages
		rectfill(3, 103, 124, 123, fg_col) -- draw border rectangle
		rectfill(5, 106, 122, 121, bg_col) -- draw fill rectangle
		line(5, 105, 122, 105, 6) -- draw top border shadow 
		line(3, 124, 124, 124, 6) -- draw bottom border shadow 

		-- draw speaker
		if #tbox_messages[1].speaker>0 then
			local speaker_width = min(#tbox_messages[1].speaker*4, 115)

			rectfill(3, 96, speaker_width+9, 102, fg_col) -- draw border rectangle
			rectfill(5, 99, speaker_width+7, 105, bg_col) -- draw fill rectangle

			print(sub(tbox_messages[1].speaker, 0, 28), 7, 101, fg_col)
		end

		-- print the message
		local str1, str2 = "", ""

		if tbox_messages[1] then
			str1 = tbox_messages[1].line
		end

		if tbox_messages[2] then
			str2 = tbox_messages[2].line
		end

		print( sub(str1, 1, g_tbox_anim),                 7, 108, 7) 
		print( sub(str2, 0, max(g_tbox_anim - #str1, 0)), 7, 115, 7) 

		-- draw / animate arrow
		for i=0, 2 do
			local y = 116+i
			if g_tbox_anim%10<5 then
				y+=1
			end

			line(116+i, y, 120-i, y, 7)
		end
	end
end
