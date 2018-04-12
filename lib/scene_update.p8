

function scene_update()
	if not tbox_active() then
		map_update()
		trigger_update()
	else
		tbox_interact()
	end
end

