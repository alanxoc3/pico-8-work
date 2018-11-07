function _init()
   g_x, g_y = 0, 0
	pl_x = 4
	pl_y = 4
	load_view(0, 0, 30, 18, 4, 10)
	center_view(pl_x, pl_y)
end

function _update60()
	local dx = 0
	local dy = 0

	if btn(0) then dx = -.1 end
	if btn(1) then dx = .1 end
	if btn(2) then dy = -.1 end
	if btn(3) then dy = .1 end

	pl_x += dx
	pl_y += dy

	update_view(pl_x, pl_y)
end

function _draw()
	cls()
	print('pico project!', 20, 20, 7)
	scr_map(0, 0, 0, 0, 32, 32)

	scr_rect(pl_x, pl_y, pl_x+1, pl_y+1, 8)
end
