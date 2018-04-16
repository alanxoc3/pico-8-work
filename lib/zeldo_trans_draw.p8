--- tokens: 14
-- returns true if it is at least halfway done.
function zeldo_trans_draw(time, func)
	if trans_active then
		func(time, trans_timer)
	end
end
