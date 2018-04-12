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
