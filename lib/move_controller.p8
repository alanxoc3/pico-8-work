
function move_controller(a, spd)
	if btn(0) then a.dx -= spd end
	if btn(1) then a.dx += spd end
	if btn(2) then a.dy -= spd end
	if btn(3) then a.dy += spd end
end
