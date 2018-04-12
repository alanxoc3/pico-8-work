-- used for debugging purposes.
function debug_triggers()
	for k,v in pairs(triggers) do
		scr_rect(v.box.x1, v.box.y1, v.box.x2, v.box.y2, 10)
	end
end

