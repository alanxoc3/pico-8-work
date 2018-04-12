-- returns the new position for the player.
function trigger_update()
	for k, v in pairs(triggers) do
		if v.active and is_pl_in_box(v.box) then
			v.func()
			if v.posx and v.posy then
				pl.x, pl.y = v.posx, v.posy
			end
		end
	end
end

