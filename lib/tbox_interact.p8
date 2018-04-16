--- tokens: 163
-- con_tbox()

-- if you press the button while text is still being displayed, then the text
-- finishes its display.
function tbox_interact(tbox_id_funcs, sound)
	if g_tbox_active then
		g_tbox_anim += .5

		local line_lens, opt_len = #g_tbox_active.l1+#g_tbox_active.l2, #g_tbox_active.options

		if g_tbox_anim < line_lens and sound then
			sfx(sound)
		end

		-- this must go above the button checks.
		g_tbox_options_open = (opt_len > 0 and g_tbox_anim >= line_lens)

		if g_tbox_options_open then
			if btnp(2) then
				g_tbox_select-=1
			elseif btnp(3) then
				g_tbox_select+=1
			end
			g_tbox_select = min(max(g_tbox_select, 1), opt_len)
		end

		if btnp(4) then
			if g_tbox_anim < line_lens then
				g_tbox_anim = line_lens
			else
				-- tbox options
				if tbox_id_funcs[g_tbox_active.id] then
					tbox_id_funcs[g_tbox_active.id](g_tbox_select, g_tbox_active.options[g_tbox_select])
				end

				if g_tbox_options_open then
					g_tbox_select, g_tbox_options_open = 1 -- auto equals nil.
				end

				-- tbox end
				del(g_tbox_messages, g_tbox_active)
				g_tbox_active, g_tbox_anim = g_tbox_messages[1], 0
			end
		end
	end
end
