-- alan morgan

-- sorry, this library is so messy internally. it could probably be a lot
-- shorter too.

-- i'll save that for another day :)

g_lyrics_enabled = false
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

function gather_string(str, check_char)
	local acc, tmp = {}, ""
	str=str..check_char

	for i=1, #str do
		local c = sub(str, i, i)

		if c == check_char then
			add(acc, tmp)
			tmp = ""
		else
			tmp = tmp..c
		end
	end

	return acc
end

function line_char_len(l)
	local len = 0

	-- characters
	for w in all(l) do
		for p in all(w) do
			len += #p
		end
	end

	-- spaces
	len += #l - 1

	return len
end

-- returns the offset
function lyrics_add_line(l, x, y, fg, bg, tim_off, tim_int)
	local off, beat = 0, tim_off

	for w in all(l) do
		for p in all(w) do
			if #p > 0 then
				lyrics_add_part(p, x+off*4, y, fg, bg, beat, false, 0)
				off += #p
			end
			beat -= tim_int
		end
		
		off += 1
	end

	lyrics_add_part("", (x+off)*4, y, fg, bg, beat+tim_int, false, 0, lyrics_swipe)

	return beat
end

function lyrics_add_part(txt, x, y, fg, bg, t, middle, dy, death_func)
	death_func = death_func or function() end

	-- time is measured in seconds
	add(g_lyrics_parts, {txt=txt, x=x, y=y, fg=fg, bg=bg, t=t*60, middle=middle, dy=dy, death_func=death_func})
end

function lyrics_swipe()
	for x in all(g_lyrics_parts) do
		if x.t == 6 then
			x.dy -= g_lyrics_swipe_speed
		end
	end
end

