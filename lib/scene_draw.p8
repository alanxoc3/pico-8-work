--- tokens: 19
function scene_draw()
	-- the marker variable is for the transitions.
	local mark = ""
	if trans_after_peak then
		mark = marker
	else
		mark = prev_marker
	end

	g_scene.draw()
end
