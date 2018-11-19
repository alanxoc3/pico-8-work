function acts_clean()
	for a in all(g_actors) do
		if not a.alive then
			del(g_actors, a)
			del(g_all_actors, a)
		end
	end
end

