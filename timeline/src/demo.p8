-- 328 tokens

function _init()
	g_tl = tl_init( {
		{ nil, nil, 1.5 },
		{ s1u, s1d, nil },
		{ s2u, s2d, 3, function() s2u_x = 0 end },
		{ s3u, s3d, 5, function() s3u_y = 20 end },
	} )
end

function _update60()
	tl_update(g_tl)

	-- test jumping to states.
	if btnp(0) then tl_next(g_tl, 1) end
	if btnp(1) then tl_next(g_tl, 2) end
	if btnp(2) then tl_next(g_tl, 3) end
	if btnp(3) then tl_next(g_tl, 4) end
end

function _draw()
	cls()
	tl_draw(g_tl)

	print("fps: "..stat(7), 0,0,7)
	print("state: "..g_tl.current, 64,0,7)
end

-- state 1 test
function s1u()
	if btnp(4) or btnp(5) then
		tl_next(g_tl)
	end
end

function s1d()
	print('timeline demo!', 20, 20, 7)
end

-- state 2 test
function s2u()
	s2u_x += 40 / stat(7)
end

function s2d()
	print('moving!', s2u_x, 60, 6)
end

-- state 3 test
function s3u()
	if btnp(4) or btnp(5) then
		tl_next()
	end
	s3u_y += 20 / stat(7)
end

function s3d()
	rectfill(0,s3u_y,30,30,8)
end
