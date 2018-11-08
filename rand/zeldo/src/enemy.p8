function gen_deku(x, y)
	local bad = gen_enemy(x, y)
	bad.spr = 70
	bad.shoot_spd = 60

	-- deku shoots every so often.
	bad.move =
		function(a)
			if a.t % bad.shoot_spd == 0 then
				local dx = -.4
				if a.x < pl.x then
					dx = .4
				end
				gen_deku_bullet(a.x,a.y,dx)
			end
		end

	return bad
end

function gen_pig(x, y)
	local bad = gen_enemy(x, y)
	bad.spr = 69

	-- deku shoots every so often.
	bad.move =
		function(a)
			if a.t % 120 == 0 then
				local dy = -.4
				if a.y < pl.y then
					dy = .5
				end
				gen_spear(a.x,a.y,dy)
			end
		end

	return bad
end

function gen_octorok(x, y)
	local bad = gen_deku(x, y)
	bad.spr = 86
	bad.shoot_spd = 100

	return bad
end

function gen_skelly(x, y)
	local bad = gen_enemy(x, y)
	bad.spr = 68
	bad.move = function(self) move_to_player(self, .1) end
	bad.inertia = 0
	return bad
end

function gen_deku_bullet(x,y,dx)
	local bad = gen_bullet(x,y,dx,0)
	bad.spr = 71
	-- rotate the bullet
	--bad.draw=
		--function(a)
			--if a.t % 40 < 10 then
				--draw_actor(a, nil, nil, false, false)
			--elseif a.t % 30 < 10 then
				--draw_actor(a, nil, nil, false, true)
			--elseif a.t % 20 < 10 then
				--draw_actor(a, nil, nil, true, true)
			--elseif a.t % 10 < 10 then
				--draw_actor(a, nil, nil, true, false)
			--end
		--end

	return bad
end

function gen_spear(x,y,dy)
	local bad = gen_bullet(x,y,0,dy)
	bad.spr = 85
	-- rotate the bullet
	bad.draw=
		function(a)
			if dy > 0 then
				draw_actor(a, nil, nil, false, false)
			else
				draw_actor(a, nil, nil, false, true)
			end
		end

	return bad
end

function gen_poe(x, y)
	local bad = gen_enemy(x, y)
	bad.spr = 116
	bad.solid = false
	bad.touchable = false
	bad.move = function(self) move_counter(self, 4, 5, 5, self.t) end
	bad.draw =
		function(a)
			draw_actor(a, nil, nil, a.dx > 0, nil)
		end
	return bad
end

function gen_enemy(x, y)
	local bad = make_actor(x, y)
	bad.spr = 1
	bad.dx=0
	bad.dy=0
	bad.inertia=.5
	bad.bad=true
	bad.hearts=0
	bad.solid=true
	bad.move = function(self) end
	bad.hit=
		function(other)
			if other == pl.boomerang then
				bad.stun = 30
			end

			if other.good then
				bad.alive = false
			end
		end

	bad.destroy =
		function(self)
			local col = nil
			-- smaller chance you get a heart.
			if dice_roll(5) then
				col = gen_heart(bad.x, bad.y)
			else
				col = gen_power_orb(bad.x, bad.y)
			end
			
			col.dx = bad.dx*3
			col.dy = bad.dy*3
		end

	-- enemy faces player, assumes sprite is facing left
	bad.draw =
		function(a)
			draw_actor(a, nil, nil, a.x < pl.x, nil)
		end

	return bad
end

function gen_bullet(x,y,dx,dy)
	local bad = gen_enemy(x,y)
	if dx == nil then dx = 0 end
	if dy == nil then dy = 0 end
	bad.dx = dx
	bad.dy = dy
	bad.inertia=1
	bad.solid=false
	bad.touchable=false
	bad.deflect = false
	bad.destroy=function(self) end
	-- die if the bullet is out of bounds.
	bad.outside=
		function(a)
			a.alive = false
		end

	-- for reflecting the bullet
	bad.hit=
		function(other)
			if other == pl.sword and pl.has_master and bad.good == false then
				bad.deflect = true
				bad.good = true
			elseif other.bad and bad.good and other.touchable then
				bad.alive = false
			end
		end

	bad.move=function(self)
		if bad.deflect then 
			bad.deflect = false
			bad.dx *= -1
			bad.dy *= -1
		end
	end

	return bad
end

function gen_energy_ball(x,y,dx,dy)
	local ball = gen_bullet(x,y,dx,dy)
	ball.spr = 119
	ball.id = "ball"
	return ball
end
