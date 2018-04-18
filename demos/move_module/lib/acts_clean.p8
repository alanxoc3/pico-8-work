function acts_clean(...)
	for list in all({...}) do
		for a in all(list) do
			if not a.alive then
				del(list, a)
			end
		end
	end
end

