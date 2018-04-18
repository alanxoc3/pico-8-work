--- tokens: 57
-- todo, remove this for final game.
function debug_actor_box(a, col)
	local x1 = (a.x-.5) * 8
	local x2 = (a.x+.5)*8 - 1
	local y1 = (a.y-.5)*8
	local y2 = (a.y+.5)*8 - 1
	rect(x1, y1, x2, y2, col)
end
