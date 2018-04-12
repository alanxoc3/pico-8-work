
-- a transition effect. returns true if it is at least halfway done.
function zeldo_screen_swipe(length, timer)
	-- only want to go in a half circle.
	local pos = 128 * sin(timer / length / 2 + .5)

	if timer > length / 2 then
		rectfill(128-pos,-1,129,129,0)
	else
		rectfill(-1,-1,pos,129,0)
	end
end
