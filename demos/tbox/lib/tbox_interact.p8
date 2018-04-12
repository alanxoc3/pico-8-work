-- con_tbox()

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
