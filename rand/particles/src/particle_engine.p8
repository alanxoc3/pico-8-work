-- input is the particle states
function init_particles(_ps)
	g_ps = _ps
	g_pt=0

	-- clears, but also creates the cont field.
	clear_particles()
end

-- draws all the particles that are alive!
function draw_particles()
	for s in all(g_ps) do
		for p in all(s.cont) do
			s.draw(p)
		end
	end
end

-- this should only be called once a frame.
-- updates all the particles
function update_particles()
	for s in all(g_ps) do
		for p in all(s.cont) do
			if not s.update(p) then
				del(s.cont, p)
			end
		end
	end

	g_pt += 1
end

-- type, x, y, number of particles, rate
function spawn_particles(_t, _x, _y, _n, _r)
	if g_pt % _r == 0 then
		local s = g_ps[_t]
		for i=1, _n do
			add(s.cont, s.create(_x, _y))
		end
	end
end

-- clear all the particles from the buffer!
function clear_particles()
	-- clear the existing particles.
	for s in all(g_ps) do s.cont = {} end
end
