pico-8 cartridge // http://www.pico-8.com
version 16
__lua__
-- mod test
-- by alan morgan
--- tokens: 49
function _init()
	tbox("sidney@idnum%23%199%3%10%293%19%0%-1:how old are you.:that's nice to know you are that old.|simon:wait what did you say?")
	tbox("|bob:hi")
end

function _update60()
	tbox_interact(function() end)
end

function _draw()
	cls()
	print("cpu: "..stat(1), 2, 64, 7)
	ttbox_draw(6, 1)
end
-->8
-- tbox

-- tbox api

-- "|" speaker, must go first!
-- "@" id,      must go in between!
-- "%" option   must go in between!
-- ":" line,    must go last!

-- example usage:
-- tbox("speaker:line:line%option1%option2@id:line|newspeaker:line...")

-- listen to 'g_tbox_active', to listen if tbox is active.
-- example usage:
-- if not g_tbox_active then do_some_func() end

-- vars:
g_tbox_messages, g_tbox_anim, g_tbox_max_len, g_tbox_select = {}, 0, 28, 0
-- g_tbox_options_open, g_tbox_active = nil, nil

function draw_rect_with_border(x1, y1, x2, y2, bor_col, bkg_col, b_w)
	rectfill(x1, y1, x2, y2, bor_col)
	rectfill(x1+b_w, y1+b_w, x2-b_w, y2-b_w, bkg_col)
end

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
function tbox_draw_arrow(x, y, col, hor)
	for i=0, 2 do
		local p1, p2 = x+4-i, y+i
		if hor then p1, p2 = x+i, y+4-i end
		line(x+i, y+i, p1, p2, col)
	end
end

-- if you press the button while text is still being displayed, then the text
-- finishes its display.
function tbox_interact(option_interact, sound)
	if g_tbox_active then
		g_tbox_anim += .5

		if g_tbox_anim < #g_tbox_active.l1+#g_tbox_active.l2 and sound then
			sfx(sound)
		end

		-- this must go above the button checks.
		if #g_tbox_active.options > 0 and g_tbox_anim >= #g_tbox_active.l1+#g_tbox_active.l2 then
			g_tbox_options_open = true
		end

		if g_tbox_options_open then
			if btnp(2) then
				g_tbox_select = max(g_tbox_select-1, 0)
			elseif btnp(3) then
				g_tbox_select = min(g_tbox_select+1, #g_tbox_active.options-1)
			end
		end

		if btnp(4) then
			if g_tbox_anim < #g_tbox_active.l1+#g_tbox_active.l2 then
				g_tbox_anim = #g_tbox_active.l1+#g_tbox_active.l2
			else
				-- tbox options
				if g_tbox_options_open then
					option_interact(g_tbox_active.id, g_tbox_active.options[g_tbox_select+1], g_tbox_select+1)
					g_tbox_select = 0
					g_tbox_options_open = false
				else
					option_interact(g_tbox_active.id)
				end

				-- tbox end
				del(g_tbox_messages, g_tbox_active)
				g_tbox_active, g_tbox_anim = g_tbox_messages[1], 0
			end
		end
	end
end

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

-- draw the text boxes (if any)
-- foreground color, background color, border width
function ttbox_draw(fg_col, bg_col)
	if g_tbox_active then -- only draw if there are messages
		draw_rect_with_border(0, 108, 127, 127, fg_col, bg_col, 2)

		-- draw speaker
		if #g_tbox_active.speaker>0 then
			local x2 = #g_tbox_active.speaker*4+6
			rectfill(0, 101, x2, 108, fg_col)
			rectfill(2, 103, x2-2, 109, bg_col)
			print(g_tbox_active.speaker, 4, 105, fg_col)
		end

		-- print the message
		print( sub(g_tbox_active.l1, 1, g_tbox_anim),                 4, 112, fg_col)
		print( sub(g_tbox_active.l2, 0, max(g_tbox_anim - #g_tbox_active.l1, 0)), 4, 119, fg_col)

		-- draw / animate arrow
		tbox_draw_arrow(119, 120+(g_tbox_anim%20)/10, fg_col, false)

		-- options
		if g_tbox_options_open then
			local options = g_tbox_active.options
			local height = #options*7
			local y1 = 103-height

			local opt_width = 0
			for opt in all(options) do
				if #opt * 4 > opt_width then
					opt_width = #opt*4
				end
			end

			draw_rect_with_border(115-opt_width, y1, 127, 108, fg_col, bg_col, 2)

			local text_y = y1+4
			tbox_draw_arrow(119-opt_width+(g_tbox_anim%20)/10, text_y + g_tbox_select*7, fg_col, true)
			for opt in all(options) do
				print(opt, 125-opt_width, text_y, fg_col)
				text_y+=7
			end
		end
	end
end
__sfx__
010f0000212502325029250262502623026220262102620026200262002b0702b0502b0302b0202b0100000000000000000000000000000000000000000000000000000000000000000000000000000000000000
