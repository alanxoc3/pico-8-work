--- tokens: 1128
-- original tbox was 537, modified was 805
-- options added 323

-- if we preparse the text, then we could limit on code space.

-- api
-- speaker:line:line%option1%option2@id:line|newspeaker:line...
-- speaker must go first! line must go last! options and id are in between!

-- "|" speaker
-- "@" id
-- "%" option
-- ":" line

tbox_messages={} -- the array for keeping track of text box overflows
g_tbox_anim=0
g_tbox_max_len=28
g_tbox_options_open=false
g_tbox_select=0

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

-- if you press the button while text is still being displayed, then the text
-- finishes its display.
function tbox_interact(option_interact, sound)
	if tbox_active() then
		g_tbox_anim += .5

		local str1, str2 = get_tbox_strs()

		if g_tbox_anim < #str1+#str2 and sound then
			sfx(sound)
		end

		-- this must go above the button checks.
		if #tbox_messages[1].options > 0 and g_tbox_anim >= #str1+#str2 then
			g_tbox_options_open = true
		end

		if g_tbox_options_open then
			if btnp(2) then
				g_tbox_select = max(g_tbox_select-1, 0)
			elseif btnp(3) then
				g_tbox_select = min(g_tbox_select+1, #tbox_messages[1].options-1)
			end
		end

		if btnp(4) then
			if g_tbox_anim < #str1+#str2 then
				g_tbox_anim = #str1+#str2
			else
				-- tbox options
				if g_tbox_options_open then
					option_interact(tbox_messages[1].id, tbox_messages[1].options[g_tbox_select+1], g_tbox_select+1)
					g_tbox_select = 0
					g_tbox_options_open = false
				end

				-- tbox end
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
		local sy = ybot-b_w+1

		draw_rect_with_border(x, y, 127, ybot, fg_col, bg_col, b_w)

		-- draw speaker
		if #tbox_messages[1].speaker>0 then
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
		draw_arrow(127-b_w-6, y+b_w+2+7+1, fg_col, false)

		if g_tbox_options_open then
			draw_options(y, b_w, fg_col, bg_col, tbox_messages[1].options)
		end
	end
end

function draw_arrow(x, y, col, horizontal)
	for i=0, 2 do
		local pos = y+i
		if horizontal then pos = x+i end

		if g_tbox_anim%20<10 then
			pos+=1
		end

		if horizontal then
			line(pos, y+i, pos, y+4-i, col)
		else
			line(x+i, pos, x+4-i, pos, col)
		end
	end
end

function draw_options(y0, b_w, fg_col, bg_col, options)
	local height = #options * 7
	local y1 = y0-b_w*2-height - 1
	local y2 = y0

	local opt_width = 0
	for opt in all(options) do
		if #opt * 4 > opt_width then
			opt_width = #opt * 4
		end
	end

	local box_x = 127 - opt_width - b_w*6
	local text_x = 127 - opt_width - b_w
	local arrow_x = text_x - 6

	draw_rect_with_border(box_x, y1, 127, y2, fg_col, bg_col, b_w)

	local text_y = y1+b_w*2
	local arrow_y = text_y
	for opt in all(options) do
		print(opt, text_x, text_y, 7)
		text_y+=5+b_w
	end

	draw_arrow(arrow_x, arrow_y + g_tbox_select*(5+b_w), fg_col, true)
end
