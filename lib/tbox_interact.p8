--- tokens: 163
-- con_tbox()

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
				end

				-- tbox end
				del(g_tbox_messages, g_tbox_active)
				g_tbox_active, g_tbox_anim = g_tbox_messages[1], 0
			end
		end
	end
end
