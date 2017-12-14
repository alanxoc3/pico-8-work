-- particle demo
g_x, g_y = 64, 64
g_cps= 1

function _init()
	g_ps = { g_firework, g_rain, g_brimstone, g_smoke, g_lightning, g_void, g_steam }
end

g_pt=0
function _update60()
	assert(g_cps > 0)

	if btnp(4) then
		g_ps[g_cps].spawn = false
		g_cps = (g_cps) % #g_ps + 1
	else
		g_ps[g_cps].spawn = btn(5)
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

	for s in all(g_ps) do
		update_particles(s)
	end

	if g_pt == 0 then
		for s in all(g_ps) do
			if s.spawn then
				create_particles(s, g_x, g_y)
			end
		end
	end
	g_pt = (g_pt+1) % 20
end

function _draw()
	cls(14)
	circ(g_x, g_y, 3, 4)

	rectfill(0, 0, g_void_x, 127, 0)

	for s in all(g_ps) do
		draw_particles(s)
	end

	print('cur state: '..g_cps, 0, 0, 7)
end
