--- tokens: 29
function get_lyric_init(verse, music_num)
	return function()
		lyrics(verse, music_num, .265, 1, 1)
	end
end

function lyric_updater()
	if lyrics_update() then
		g_tl_next()
	end
end

