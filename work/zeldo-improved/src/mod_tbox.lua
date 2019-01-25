-- tbox

-- tbox api

-- "|" speaker, must go first!
-- "@" id,      must go in between!
-- ":" line,    must go last!

-- example usage:
-- tbox("speaker:line:line@id:line|newspeaker:line...")

-- vars:
g_tbox_messages, g_tbox_anim, g_tbox_max_len = {}, 0, 24
-- listen to 'g_tbox_active', to listen if tbox is active.

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
function tbox_interact(sound)
	if g_tbox_active then
		g_tbox_anim += .5

		if g_tbox_anim < #g_tbox_active.l1+#g_tbox_active.l2 and sound then
			sfx(sound)
		end

		if btnp(4) and g_tbox_anim > .5 and g_tbox_active.continue then
         printh("ttbox anim: "..g_tbox_anim)
			if g_tbox_anim < #g_tbox_active.l1+#g_tbox_active.l2 then
				g_tbox_anim = #g_tbox_active.l1+#g_tbox_active.l2
			else
				del(g_tbox_messages, g_tbox_active)
				g_tbox_active, g_tbox_anim = g_tbox_messages[1], 0
			end
		end
	end
end

-- add a new text box, id is optional, it is the id of the event. you can check
-- if an event is done with a unique id.
function tbox(str)
	local acc, id, speaker, mode, l_str = "", "", "", "|", str.."|"
   local cont = true

	for i=1, #l_str do
		local x = sub(l_str, i, i)

      if x == "^" then
         cont = false
      elseif x == ":" or x == "|" or x == "@" or x == "%" then
			if mode == ":" then
				local lines = str_to_word_lines(acc, g_tbox_max_len)

				for i=1,#lines do
					local l = lines[i]
					if i % 2 == 1 then
						add(g_tbox_messages, {speaker=speaker, id=id, continue=cont, l1=l, l2=""})
						id = ""
					else
						g_tbox_messages[#g_tbox_messages].l2 = l
					end
				end

			elseif mode == "|" then speaker, id = acc, ""
			elseif mode == "@" then id = acc end
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
      rectfill(0, 108, 19, 127, 7)

		-- draw speaker
		if #g_tbox_active.speaker>0 then
			local x2 = #g_tbox_active.speaker*4+6
			rectfill(18, 101, 18+x2, 108, fg_col)
			rectfill(20, 103, 18+x2-2, 109, bg_col)
			print(g_tbox_active.speaker, 22, 105, fg_col)

			-- rectfill(127-x2, 101, 127, 108, fg_col)
			-- rectfill(127-x2+2,   103, 127-2, 109, bg_col)
			-- print(g_tbox_active.speaker, 127-x2+4, 105, fg_col)
		end

		-- print the message
		print( sub(g_tbox_active.l1, 1, g_tbox_anim),                 22, 112, fg_col)
		print( sub(g_tbox_active.l2, 0, max(g_tbox_anim - #g_tbox_active.l1, 0)), 22, 119, fg_col)

		-- draw / animate arrow
      if g_tbox_active.continue then
         tbox_draw_arrow(119, 120+(g_tbox_anim%20)/10, fg_col, false)
      end
	end
end

function tbox_clear()
   g_tbox_messages, g_tbox_anim, g_tbox_active = {}, 0, false
end

function tbox_stash_push()
   g_tbox_active_backup, g_tbox_messages_backup = g_tbox_active, g_tbox_messages
   tbox_clear()
end

function tbox_stash_pop()
   tbox_clear()
   g_tbox_messages, g_tbox_active = g_tbox_messages_backup, g_tbox_active_backup
end
