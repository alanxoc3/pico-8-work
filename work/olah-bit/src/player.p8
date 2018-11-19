function gen_player(x, y, points, num)
	local pl

	if num == 0 then pl = gen_body(x, y, 100, 20, 64, 65, 66, 67, 68)
	else pl = gen_body(x, y, 100, 20, 80, 81, 82, 83, 84) end

	pl.touch_group = "pl"
	pl.points = points
	pl.pl = true
	pl.good = true
	pl.bullet_timeout = 10

	acts_vec_attach(pl, x, y)
	acts_mov_attach(pl)

	pl.cam_x, pl.cam_y = 0, 0
	pl.anim_len = 1
	pl.w = .37
	pl.ix = .645
	pl.anim_spd = 5
	pl.bounce = 0
	pl.touchable = true
	pl.solid = true
	pl.portal_timer = 0
	pl.dy = -.3

	pl.hit = function(other, dir)
		if other.bad then
			pl.cam_x, pl.cam_y = rnd(2)-1, rnd(2)-1
		elseif other.body and btn(3, num) then
			if other.resurrect() then
				pl.cam_x, pl.cam_y = rnd(2)-1, rnd(2)-1
				pl.points += other.score
			end
		elseif other.touch_group == pl.touch_group and dir == 3 then
			pl.on_ground = true
		end
	end

	pl.tile_hit = function(dir)
		pl.on_ground = dir == 3 or pl.on_ground
	end

	pl.move = function()
		-- reset the camera shake.
		pl.cam_x, pl.cam_y = 0, 0

		if pl.portal_timer > 0 then
			pl.portal_timer += 1
			pl.points += 2
			pl.cam_x, pl.cam_y = rnd(2)-1, rnd(2)-1
			return
		end

		local spd = .05
		pl.ax = btn(0, num) and btn(1, num) and 0 or btn(0, num) and -spd or btn(1, num) and spd or 0
		pl.ay = gravity

		if btnp(2, num) and pl.on_ground then
			pl.ay = -.4
		end

		if pl.ax < 0 then
			pl.xf = true
		elseif pl.ax > 0 then
			pl.xf = false
		end
		pl.on_ground = false

		if (btnp(4, num) or btnp(5, num)) and pl.bullet_timeout == 0 then
			gen_pl_bullet(pl)
			pl.bullet_timeout = 10
		end

		if pl.health <= 0 then
			pl.die()
		end
	end

	pl.update = function()
		pl.anim_loc = 1
		if pl.on_ground and pl.ax != 0 then
			pl.anim_len = 4
			pl.anim_spd = 5
		elseif not pl.on_ground then
			pl.anim_loc = 3
			pl.anim_len = 1
			pl.anim_spd = 1
		else
			pl.anim_len = 1
			pl.anim_spd = 1
		end

		if not pl.alive then
			create_body(pl)
		end

		pl.bullet_timeout = max(pl.bullet_timeout - 1, 0)
	end

	return pl
end

function calc_close_mag(a)
	local x_mag1 = pl1.x - a.x
	local x_mag2 = pl2.x - a.x
	local x_mag = min(abs(x_mag1), abs(x_mag2))
	x_mag = (x_mag == abs(x_mag1) and x_mag1 or x_mag2)
	return x_mag, x_mag == x_mag1 and pl1 or pl2
end

function gen_pl_bullet(pl)
	local a = gen_bullet(pl.x, pl.y, pl.xf and -.3 or .3, 69, 70, 71, 72)
	a.owner = pl
	a.good = true

	a.hit = function(other)
		if other.bad and a.t < 85 then
			if other.enemy then
				local prev_health = other.health
				other.health -= 4
				a.owner.points += 1
				if prev_health > 0 and other.health <= 0 then
					a.owner.points += other.score
				end
			end

			a.t = 85
		end
	end

	a.post_draw = function()
		outline_sprite(0, a.sind,
		scr_x(a.x-a.sw/2),
		scr_y(a.y-a.sh/2),
		a.sw, a.sh, a.xf, a.yf)
	end
end
