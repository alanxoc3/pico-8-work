function gen_zeldo(x, y)
	local girl = gen_interactable(x, y)
	girl.spr = 120

	girl.move =
		function()
			if is_tbox_done() then
				pl.alive = false
			end
		end

	return girl
end
