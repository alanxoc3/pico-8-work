-- 537 tokens

-- api
-- speaker:line:line@id:line|newspeaker:line...

-- "|" speaker
-- ":" line
-- "@" id

tbox_messages={} -- the array for keeping track of text box overflows
g_tbox_anim=0
g_tbox_max_len=28

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

function is_tbox_done(id)
	for l in all(tbox_messages) do
		if l.id == id then
			return false
		end
	end
	return true
end

-- add a new text box, id is optional, it is the id of the event. you can check
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

-- if you press the button while text is still being displayed, then the text
-- finishes its display.
function tbox_interact()
	if tbox_active() then
		g_tbox_anim += .5
		if btnp(4) then
			local str1, str2 = get_tbox_strs()

			if g_tbox_anim < #str1+#str2 then
				g_tbox_anim = #str1+#str2
			else
				if #tbox_messages>1 then
					del(tbox_messages, tbox_messages[1])
				end
				del(tbox_messages, tbox_messages[1])
				g_tbox_anim = 0
			end
		end
	end
end

-- check if a text box is currently visible (useful if the dialogue clear
-- button is used for other actions as well)
function tbox_active()
	return #tbox_messages>0
end

function draw_rect_with_border(x1, y1, x2, y2, bor_col, bkg_col, b_w)
	rectfill(x1, y1, x2, y2, bor_col)
	rectfill(x1+b_w, y1+b_w, x2-b_w, y2-b_w, bkg_col)
end

function draw_tbox_speaker(x1, y1, bor_col, bkg_col, b_w, txt, top)
	local txt_w = #txt*4
	local x2, y2 = b_w*2+2+txt_w+x1, y1+6+b_w

	rectfill(x1, y1, x2, y2, bor_col)

	if top then
		rectfill(x1+b_w, y1, x2-b_w, y2-b_w, bkg_col)
		print(txt, x1+b_w+2, y1, bor_col)
	else
		rectfill(x1+b_w, y1+b_w, x2-b_w, y2, bkg_col)
		print(txt, x1+b_w+2, y1+b_w+2, bor_col)
	end
end

function get_tbox_strs()
	local str1, str2 = "", ""

	if tbox_messages[1] then
		str1 = tbox_messages[1].line
	end

	if tbox_messages[2] then
		str2 = tbox_messages[2].line
	end

	return str1, str2
end

-- draw the text boxes (if any)
-- foreground color, background color, border width
-- function tbox_draw(top?, b_w, fg_col, bg_col)
function tbox_draw(fg_col, bg_col, b_w, top)
	local x, y = 0, 0

	if not top then
		y = 128-b_w*2-2*3-5*2
	end

	local ybot = y+b_w*2+2*3+5*2-1

	if tbox_active() then -- only draw if there are messages
		draw_rect_with_border(x, y, 127, ybot, fg_col, bg_col, b_w)

		-- draw speaker
		if #tbox_messages[1].speaker>0 then

			local sy = ybot-b_w+1

			if not top then
				sy = y-5-2
			end

			draw_tbox_speaker(x, sy, fg_col, bg_col, b_w, tbox_messages[1].speaker, top)
		end

		-- print the message
		local str1, str2 = get_tbox_strs()

		print( sub(str1, 1, g_tbox_anim),                 x+b_w+2, y+b_w+2,   fg_col)
		print( sub(str2, 0, max(g_tbox_anim - #str1, 0)), x+b_w+2, y+b_w+2+7, fg_col)

		-- draw / animate arrow
		for i=0, 2 do
			local ypos = y+i+b_w+2+7+1
			if g_tbox_anim%20<10 then
				ypos+=1
			end

			line(127-b_w-6+i, ypos, 127-b_w-2-i, ypos, fg_col)
		end
	end
end
