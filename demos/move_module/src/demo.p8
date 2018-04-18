function _init()
	gravity = .05
	air_resistance = .99

	init_pl()
	init_enemy()
	acts_vec_attach(enemy, 8, 8)
	acts_mov_attach(enemy)
	acts_spr_attach(enemy, 1)
end

function _update60()
	acts_loop(g_acts_mov_lst, "move")
	acts_mov_update()
	acts_col_update(function(x, y) return fget(mget(x, y), 0) end)
	acts_vec_update()
	acts_act_update()
	acts_anim_update()
	acts_clean(g_acts_anim_lst, g_acts_spr_lst, g_acts_col_lst, g_acts_mas_lst, g_acts_mov_lst, g_acts_vec_lst, g_acts_act_lst)
end

function _draw()
	cls()
	circfill(pl.x, pl.y, 3, 7)
	circfill(enemy.x, enemy.y, 3, 7)

	map(0, 0, 0, 0, 16, 16)
	acts_loop(g_acts_spr_lst, "pre_draw")
	acts_spr_draw()
	acts_loop(g_acts_spr_lst, "post_draw")

	print("cpu: "..stat(1))
end

function init_enemy()
	enemy = acts_col_attach()
	enemy.move = function()
		enemy.ay = gravity
		enemy.iy = air_resistance
	end

	enemy.hit = function(other, dir)
		printh("hit enem: "..dir)
	end
end

function init_pl()
	pl = acts_col_attach(pl)
	acts_mov_attach(pl)
	acts_anim_attach(pl, 1, 20)
	pl.anim_loc, pl.anim_spd = 1, 15
	pl.x, pl.y = 2, 2
	pl.iy = air_resistance

	pl.hit = function(other, dir)
		pl.on_ground = dir == 3 or pl.on_ground
	end

	pl.tile_hit = function(dir)
		pl.on_ground = dir == 3 or pl.on_ground
	end

	pl.move = function()
		pl.ax = btn(0) and btn(1) and 0 or btn(0) and -.02 or btn(1) and .02 or 0
		pl.ay = gravity
		if btn(2) and pl.on_ground then
			pl.ay = -.5
		end

		pl.on_ground = false
	end

	pl.update = function()
		if btn(4) then pl.alive = false end

		if pl.ax != 0 or not pl.on_ground and pl.ay != 0 then
			pl.anim_len = 2
		else
			pl.anim_len = 1
		end
	end
end
