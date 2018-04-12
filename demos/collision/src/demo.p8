-- 269 tokens
function _init()
	a = {}
	a.x = 8
	a.y = 8
	a.hs = 0
	a.vs = 0
	a.rad = .4

	e = {}
	e.x = 2
	e.y = 14
	e.hs = .05
	e.vs = 0
	e.rad = .4
end

function is_solid(ind)
	return fget(ind, 0)
end

function _update60()
	local spd = .3

	-- collide walls
	a.hs = btn_helper(0, 1, spd)

	if btn(2) then
		a.vs = -.7
	end
	a.vs += .1

	-- collide walls
	a.x, a.hs = tile_collide_helper(a.x, a.y, a.hs, a.rad, a.rad,
		function(pos, per)
			return is_solid(mget(pos, per))  
		end)

	a.y, a.vs = tile_collide_helper(a.y, a.x, a.vs, a.rad, a.rad,
		function(pos, per)
			return is_solid(mget(per, pos))  
		end)

	a.x, a.hs = update_in_box(a.x, a.hs, a.rad, 0, 16)
	a.y, a.vs = update_in_box(a.y, a.vs, a.rad, 0, 16)

	a.x, a.y, a.hs, a.vs = update_out_box(a.x, a.y, a.hs, a.vs, a.rad, a.rad, 12, 15, 16, 16)

	e.x += e.hs
	e.y += e.vs
	a.x, a.y, a.hs, a.vs = update_out_box(a.x, a.y, a.hs, a.vs, a.rad, a.rad, e.x, e.y, e.x+1, e.y+1)

	-- flip dirs
	if e.x > 14 and e.hs > 0 or e.x < 2 and e.hs < 0 then
		e.hs = -e.hs
	end

	a.x += a.hs
	a.y += a.vs
end

function _draw()
	cls(0)
	map(0,0,0,0,128,32)
	circfill(a.x*8, a.y*8, a.rad * 8, 10)
	rect(0, 0, 16*8 - 1, 16*8 - 1, 10)
	rect(12*8, 15*8, 16*8 - 1, 16*8 - 1, 8)
	rect(e.x*8, e.y*8, (e.x + 1) * 8 - 1, (e.y + 1) * 8 - 1, 8)
end

function btn_helper(dir1, dir2, spd)
	if btn(dir1)     then return -spd
	elseif btn(dir2) then return spd
	else return 0 end
end

