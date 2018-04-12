function lyrics_add_part(txt, x, y, fg, bg, t, middle, dy, death_func)
	death_func = death_func or function() end

	-- time is measured in seconds
	add(g_lyrics_parts, {txt=txt, x=x, y=y, fg=fg, bg=bg, t=t*60, middle=middle, dy=dy, death_func=death_func})
end
