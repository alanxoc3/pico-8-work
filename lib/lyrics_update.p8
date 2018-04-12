-- returns true if everything is complete, including the display is done.
function lyrics_update()
	if not g_lyrics_enabled then return true end

	if g_lyrics_rad < 9 and not g_lyrics_done then
		g_lyrics_rad += .3
	end

	if g_lyrics_done then
		g_lyrics_rad = max(g_lyrics_rad - .3, 0)
	end

	if g_lyrics_timer >= g_lyric_delay then
		if #g_lyrics_parts == 0 then
			g_lyrics_done = true
		end

		if not g_lyrics_playing then
			music(g_lyrics_music_num)
			g_lyrics_playing = true
		end

		for p in all(g_lyrics_parts) do
			local prev_t = p.t
			p.t = min(6, p.t + 1)

			p.y += p.dy

			if prev_t != 6 and p.t == 6 then
				p.death_func()
			end
		end

		-- garbage collection.
		for p in all(g_lyrics_parts) do
			if p.y < 30 then
				del(g_lyrics_parts, p)
			end
		end
	else
		g_lyrics_timer += 1/60
	end

	if g_lyrics_rad == 0 then
		g_lyrics_enabled = false
	end

	return not g_lyrics_enabled
end

