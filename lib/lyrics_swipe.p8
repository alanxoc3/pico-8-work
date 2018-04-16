--- tokens: 20
function lyrics_swipe()
	for x in all(g_lyrics_parts) do
		if x.t == 6 then
			x.dy -= g_lyrics_swipe_speed
		end
	end
end
