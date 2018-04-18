-- returns a list of all actors hit. will return nil if none were hit.
-- or if this is out of bounds.
-- bounds. won't check for actors that are out of bounds.
-- also does not work with overlapping actors.
function acts_coll(a, actors, dx, dy)
	local retlist = {}

	if not a.is_outside then
		for a2 in all(actors) do
			if not a2.is_outside and a != a2 then
				local x=(a.x+dx) - a2.x
				local y=(a.y+dy) - a2.y
				if ((abs(x) < (a.w+a2.w)) and
					(abs(y) < (a.h+a2.h)))
				then 
					-- check if moving together
					if (dx != 0 and abs(x) <
							abs(a.x-a2.x)) then
						if a.touchable and a2.touchable then
							v=a.dx + a2.dx
							if not a.static then a.dx = v/2 end
							if not a2.static then a2.dx = v/2 end
						end
						add(retlist, a2)
					elseif (dy != 0 and abs(y) <
									abs(a.y-a2.y)) then
						if a.touchable and a2.touchable then
							v=a.dy + a2.dy
							if not a.static then a.dy = v/2 end
							if not a2.static then a2.dy = v/2 end
						end
						add(retlist, a2)
					end
				end
			end
		end
	end

	return retlist
end
