function gen_boomerang(x, y, dir)
	local time = 15
	local spd = .4
	local hs = 0
	local vs = 0

	local boom = make_actor(x, y)

	boom.spr = 54
	boom.solid = false
	boom.touchable = false
	boom.inertia = 0
	boom.collection = {}

	-- updates the position of the things the boomerang collected.
	update_collection = function()
		foreach(boom.collection,
			function(item)
				item.dx = boom.dx
				item.dy = boom.dy
			end)
		end

	-- when the boomerang collects a power orb.
	boom.collect=
		function(other)
			other.x = boom.x
			other.y = boom.y
			other.dx = boom.dx
			other.dy = boom.dy
			add(boom.collection, other)
		end

	if dir == 0 or dir == 4 or dir == 7 then
		hs = -spd
	elseif dir == 1 or dir == 5 or dir == 6 then
		hs = spd
	end

	if dir == 2 or dir == 4 or dir == 5 then
		vs = -spd
	elseif dir == 3 or dir == 6 or dir == 7 then
		vs = spd
	end

	boom.dx = hs
	boom.dy = vs
	
	boom.move=
		function(self)
			if self.t >= time then
				move_to_player(boom, spd)
			else
				boom.dx = hs
				boom.dy = vs
			end

			update_collection()
		end

	boom.draw=
		function(self)
			local num = flr(self.t / 4) % 4
			local fx = false
			local fy = false
			if num == 0 then
				fx = true
				fy = true
			elseif num == 1 then
				fx = true
				fy = false
			elseif num == 2 then
				fx = false
				fy = false
			elseif num == 3 then
				fx = false
				fy = true
			end
			draw_actor(self, nil, nil, fx, fy)
		end

	boom.hit=
		function(other)
			if other == pl then
				if boom.t >= time then
					boom.alive = false
					for a in all(boom.collection) do
						a.alive = false
					end
				end
			elseif other.bad and other.solid and other.touchable then
				boom.t = time
			end

		end

	boom.destroy =
		function(self)
			pl.boomerang = nil
		end

	return boom
end

function gen_sword(x, y, dir, master)
	local time = 7
	local spd = .3
	local off = .3

	local dx = 0.0
	local dy = 0.0

	if dir == 0 then
		x -= off
		dx = -spd
	elseif dir == 1 then
		x += off
		dx = spd
	elseif dir == 2 then
		y -= off
		dy = -spd
	elseif dir == 3 then
		y += off
		dy = spd
	end

	local sword = make_actor(x, y)
	if dir == 0 or dir == 1 then
		sword.spr = 1
	else
		sword.spr = 0
	end

	if master == true then
		sword.spr+=43
	else
		sword.spr+=56
	end

	sword.dx = dx
	sword.dy = dy
	sword.w  = .4
	sword.h  = .4

	sword.solid = false
	sword.touchable = false
	sword.good = true
	sword.dir = dir
	sword.destroy =
		function(self)
			pl.sword = nil
		end

	sword.move =
		function(self)
			if self.t >= time then
				self.alive = false
			end
		end

	sword.draw =
		function(self)
			local fx = (self.dir == 0)
			local fy = (self.dir == 3)
			draw_actor(self, nil, nil, fx, fy)
		end

	return sword
end
