-- alan morgan

g_scenes, g_scene, g_actors = {}, {}, {}

-- use when switching to a new scene.
-- x and y are the player's new coordinates.
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

function scene_update()
	if not tbox_active() then
		map_update()
		trigger_update()
	else
		tbox_interact()
	end
end

function scene_draw()
	-- the marker variable is for the transitions.
	local mark = ""
	if trans_after_peak then
		mark = marker
	else
		mark = prev_marker
	end

	g_scene.draw()
end
