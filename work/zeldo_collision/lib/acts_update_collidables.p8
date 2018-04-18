-- acts_set_pos()
function acts_update_collidables(actors, tile_func)
	-- speed/collision, speed/walls, then position
	foreach(actors, function(a) acts_set_spd(a, actors) end)
	foreach(actors, function(a) acts_tile_col(a, tile_func) end)
	foreach(actors, acts_set_pos)
end
