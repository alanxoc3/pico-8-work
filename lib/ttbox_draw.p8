--- tokens: 599
-- con_tbox()

-- draw the text boxes (if any)
-- foreground color, background color, border width
function ttbox_draw(fg_col, bg_col, top)
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
