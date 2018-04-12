function move_actors(actors, tile_func)
	-- speed/collision, speed/walls, then position
	foreach(actors, function (a) set_actor_speed(a, actors) end)
	foreach(actors, function(a) tile_col(a, tile_func) end)
	foreach(actors, set_actor_pos)
end
