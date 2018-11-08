power_orb_count = 0

function control_player(pl)
	-- how fast to accelerate
	local accel = pl.spd
	-- move if no bomb/shield or sword.
	if not btn(4) and not btn(5) then
		if btn(0) then pl.dx -= accel end
		if btn(1) then pl.dx += accel end
		if btn(2) then pl.dy -= accel end
		if btn(3) then pl.dy += accel end
	elseif btn(4) then
		if pl.sword == nil and pl.has_sword then
			local dir = -1
			if btn(0) then     dir = 0
			elseif btn(1) then dir = 1
			elseif btn(2) then dir = 2
			elseif btn(3) then dir = 3 end

			if dir != -1 then pl.sword=gen_sword(pl.x, pl.y, dir, pl.has_master) end
		end
	elseif btn(5) then
		if pl.boomerang == nil and pl.has_boomerang then
			local dir = -1

			if btn(0) and btn(2)     then dir = 4
			elseif btn(1) and btn(2) then dir = 5
			elseif btn(1) and btn(3) then dir = 6
			elseif btn(0) and btn(3) then dir = 7
			elseif btn(0) then dir = 0
			elseif btn(1) then dir = 1
			elseif btn(2) then dir = 2
			elseif btn(3) then dir = 3 end

			if dir != -1 then pl.boomerang=gen_boomerang(pl.x, pl.y, dir) end
		end
	end

	-- play a sound if moving
	-- (every 4 ticks)
	if pl.regenerate > 0 then pl.regenerate -= 1 end
	
	if (abs(pl.dx)+abs(pl.dy) > 0.1
					and (pl.t%4) == 0) then
		-- sfx(1)
	end
	
	if pl.regenerate > 0 then
		shake()
	end
end

function gen_link(x, y)
	local pl = make_actor(x,y)
	pl.spr = 104
	pl.frames = 3
	pl.bounce = .1
	pl.spd = .1
	pl.move = control_player
	pl.has_fairy = 0
	pl.draw =
		function(self)
			if pl.regenerate > 0 then
				if pl.t % 10 < 3 then return end
			end
			draw_actor(self)
		end
	
	pl.hearts = 3
	pl.max_hearts = 3

	pl.heal =
		function()
			if pl.hearts < pl.max_hearts then
				pl.hearts += 1
			end
		end

	-- unload the player, boomerang, and sword.
	pl.unload =
		function()
			del(actors, pl)
			if pl.boomerang != nil then
				del(actors, pl.boomerang)
				pl.boomerang = nil
			end

			if pl.sword != nil then
				del(actors, pl.sword)
				pl.sword = nil
			end
		end

	pl.good=false
	pl.has_sword=false  -- if false, then link can't use his sword.
	pl.has_master=false
	pl.sword=nil       -- used to regulate only one sword.
	pl.regenerate=0

	pl.has_boomerang=false -- if false, then link can't use his boomerang.
	pl.boomerang=nil      -- used to regulate only one boomerang.

	pl.hit=function(other)
		if other.bad and other.stun == 0 then
			if pl.hearts > 0 and pl.regenerate == 0 then
				pl.hearts = pl.hearts - 1
				pl.regenerate = 30
			end
	
			if pl.hearts == 0 then
				if pl.has_fairy > 0 then
					pl.has_fairy -= 1
					pl.hearts = pl.max_hearts
				else
					pl.alive = false
				end
			end
		end
	end

	pl.destroy=function(self)
		music(-1)
		if canon.killed then
			music(43)
		else
			music(41)
		end
	end

	return pl
end
