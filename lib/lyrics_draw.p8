function lyrics_draw()
	if not g_lyrics_enabled then return end
	rectfill(0, 64-g_lyrics_rad, 127, 64+g_lyrics_rad, 0)

	clip(0, 64-g_lyrics_rad, 127, g_lyrics_rad*2)
	for p in all(g_lyrics_parts) do
		lyrics_part_print(p)
	end
	clip()
end
