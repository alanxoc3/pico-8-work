--- tokens: 127
-- con_lyrics()

function lyrics(verse, music_num, beat_len, delay, swipe_speed)
	g_lyrics_enabled = true
	g_lyrics_rad = 0
	g_lyrics_parts = {}
	g_lyrics_music_num = music_num
	g_lyrics_timer = 0
	g_lyrics_playing = false
	g_lyrics_swipe_speed = swipe_speed or .5
	g_lyrics_done = false

	g_lyric_delay = delay or .5

	-- populate the lines.
	lines = {}
	for l in all(gather_string(verse, ":")) do
		local words = {}

		for w in all(gather_string(l, " ")) do
			local parts = gather_string(w, ".")
			add(words, parts)
		end

		add(lines, words)
	end

	local off = 0
	for l in all(lines) do
		-- center it :)
		local xoff = (128 - line_char_len(l)*4) / 2
		off = lyrics_add_line(l, xoff, 61, 7, 1, off, beat_len)
	end
end
