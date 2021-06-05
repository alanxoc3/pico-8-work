--- tokens: 173
function draw_angel()
	local flip, ind = false, 146

	if g_pl.face == 1 then ind += 2 flip = true end
	if g_pl.face == 0 then ind += 2 end

	scr_spr(ind, g_pl.x - 1, g_pl.y - 1, 2, 2, flip, false)
end

function draw_boy()
	local flip, ind = false, 102

	if g_pl.face == 0 then flip = true end
	if g_pl.hs != 0 then ind += 2 end

	scr_spr(ind, g_pl.x - 1, g_pl.y - 1, 2, 2, flip, false)
end

-- for tophat player.
function draw_pl()
	local ind, flip = 3, false

	if     g_pl.face == 0 then flip = true
	elseif g_pl.face == 2 then ind = 5
	elseif g_pl.face == 3 then ind = 1
	end

	if g_pl.hs != 0 or g_pl.vs != 0 then
		ind += 32
	end

	scr_spr(ind, g_pl.x - 1, g_pl.y - 1, 2, 2, flip, false)
end

