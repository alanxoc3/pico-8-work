--- tokens: 276
-- for angel boy
function angel_input(l, r, u, d)
	local spd = g_pl.spd

	-- which direction to face?
	if g_pl.hs < 0 then
		g_pl.face = 0
	elseif g_pl.hs > 0 then
		g_pl.face = 1
	else
		g_pl.face = 2
	end

	g_pl.hs, g_pl.vs = 0, spd/2
	if l then g_pl.hs -= spd end
	if r then g_pl.hs += spd end
	if u then g_pl.vs = spd/4 end
	if d then g_pl.vs = spd end
end

-- for shepherd boy
function boy_input(l, r, u, d)
	local spd = g_pl.spd

	-- which direction to face?
	if g_pl.hs < 0 then
		g_pl.face = 0
	elseif g_pl.hs > 0 then
		g_pl.face = 1
	end

	g_pl.hs, g_pl.vs = 0, 0
	if l then g_pl.hs -= spd end
	if r then g_pl.hs += spd end

	if u then g_pl.vs -= spd/2 end
	if d then g_pl.vs += spd/2 end
end

-- for top hat person
function pl_input(l, r, u, d)
	local spd = g_pl.spd

	-- which direction to face?
	if g_pl.vs == 0 and not (l and r) then
		if l then
			g_pl.face = 0
		elseif r then
			g_pl.face = 1
		end
	end

	if g_pl.hs == 0 and not (u and d) then
		if u then
			g_pl.face = 2
		elseif d then
			g_pl.face = 3
		end
	end

	-- speed
	if (l or r) and (u or d) then
		spd = spd * cos(.125)
	end

	g_pl.hs, g_pl.vs = 0, 0
	if l then g_pl.hs -= spd end
	if r then g_pl.hs += spd end

	if u then g_pl.vs -= spd end
	if d then g_pl.vs += spd end
end
