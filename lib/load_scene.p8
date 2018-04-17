--- tokens: 74
-- use when switching to a new scene.
-- x and y are the player's new coordinates.
-- con_scene()
function load_scene(name)
	-- unload the actors.
	for a in all(g_actors) do a.unload() end

	-- load the new scene.
	g_scene = g_scenes[name]

	-- if, because of title for now.
	if g_scene then
		g_actors = g_scene.actors

		-- load the new actors.
		for a in all(g_actors) do a.load() end

		if g_scene.bounds then
			-- 7818
			local dat = gun_nums(g_scene.bounds)
			load_view(dat[1], dat[2], dat[3], dat[4], 4, 10)
			center_view(pl.x, pl.y)
		end
	end 
end
