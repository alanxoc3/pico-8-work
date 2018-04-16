--- tokens: 599
-- con_tbox()

-- draw the text boxes (if any)
-- foreground color, background color, border width
-- function tbox_draw(top?, fg_col, bg_col)
function tbox_draw(fg_col, bg_col, bw, top)
	local x, y = 0, 0
	g_tbox_bw=bw

	if not top then
		y = 128-g_tbox_bw*2-2*3-5*2
	end

	local ybot = y+g_tbox_bw*2+2*3+5*2-1

	if g_tbox_active then -- only draw if there are messages
		local sy = ybot-g_tbox_bw+1
		local g_tbox_active = g_tbox_messages[1]

		draw_rect_with_border(x, y, 127, ybot, fg_col, bg_col, g_tbox_bw)

		-- draw speaker
		if #g_tbox_active.speaker>0 then
			if not top then
				sy = y-5-2
			end

			tbox_draw_speaker(x, sy, fg_col, bg_col, g_tbox_active.speaker, top)
		end

		-- print the message
		print( sub(g_tbox_active.l1, 1, g_tbox_anim),                 x+g_tbox_bw+2, y+g_tbox_bw+2,   fg_col)
		print( sub(g_tbox_active.l2, 0, max(g_tbox_anim - #g_tbox_active.l1, 0)), x+g_tbox_bw+2, y+g_tbox_bw+2+7, fg_col)

		-- draw / animate arrow
		local ypos = y+g_tbox_bw+2+7+1
		tbox_draw_arrow(127-g_tbox_bw-6, ypos+(g_tbox_anim%20)/10, fg_col)

		if g_tbox_options_open then
			tbox_draw_options(y, fg_col, bg_col, g_tbox_active.options)
		end
	end
end

function tbox_draw_speaker(x1, y1, bor_col, bkg_col, txt, top)
	local txt_w = #txt*4
	local x2, y2 = g_tbox_bw*2+2+txt_w+x1, y1+6+g_tbox_bw

	rectfill(x1, y1, x2, y2, bor_col)

	if top then
		rectfill(x1+g_tbox_bw, y1, x2-g_tbox_bw, y2-g_tbox_bw, bkg_col)
		print(txt, x1+g_tbox_bw+2, y1, bor_col)
	else
		rectfill(x1+g_tbox_bw, y1+g_tbox_bw, x2-g_tbox_bw, y2, bkg_col)
		print(txt, x1+g_tbox_bw+2, y1+g_tbox_bw+2, bor_col)
	end
end

function tbox_draw_options(y0, fg_col, bg_col, options)
	local height = #options * 7
	local y1 = y0-g_tbox_bw*2-height - 1
	local y2 = y0

	local opt_width = 0
	for opt in all(options) do
		if #opt * 4 > opt_width then
			opt_width = #opt * 4
		end
	end

	local box_x = 127 - opt_width - g_tbox_bw*6
	local text_x = 127 - opt_width - g_tbox_bw
	local arrow_x = text_x - 6

	draw_rect_with_border(box_x, y1, 127, y2, fg_col, bg_col, g_tbox_bw)

	local text_y = y1+g_tbox_bw*2
	local arrow_y = text_y
	for opt in all(options) do
		print(opt, text_x, text_y, fg_col)
		text_y+=5+g_tbox_bw
	end

	tbox_draw_arrow(arrow_x+(g_tbox_anim%20)/10, arrow_y + (g_tbox_select-1)*(5+g_tbox_bw), fg_col, true)
end
