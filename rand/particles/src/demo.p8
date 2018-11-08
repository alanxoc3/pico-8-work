-- particle demo
g_x, g_y = 64, 64
g_cps= 1

function _init()
	init_particles( {
		g_firework,
		g_rain,
		g_brimstone,
		g_smoke,
		g_lightning,
		g_void,
		g_steam
	} )

end

function _update60()
	assert(g_cps > 0)

	if btnp(4) then
		g_cps = (g_cps) % #g_ps + 1
	end

	if btn(5) then
		spawn_particles(g_cps, g_x, g_y, 20, 4)
	end

	if g_cps != 6 then
		if btn(0) then g_x-=1.1 end
		if btn(1) then g_x+=1.1 end
	else
		if btn(0) then g_void_x-=1.1 end
		if btn(1) then g_void_x+=1.1 end
	end

	if btn(2) then g_y-=1.1 end
	if btn(3) then g_y+=1.1 end

	update_particles()
end

function _draw()
	cls(14)
	circ(g_x, g_y, 3, 4)

	rectfill(0, 0, g_void_x, 127, 0)

	draw_particles()

	print('cur state: '..g_cps, 0, 0, 7)
	print('cpu: '..stat(1), 60, 0, 7)
end
