t_tim = 0
function game_logic()
	-- possible states: death | game over | respawning | moving

	-- for development
	-- speed_cheat()

	g_rsp = g_countdown != 0
	assert(g_lif >= 0)

	local fall_off_plk = g_plk == 0 and not g_rsp

	local death      = fall_off_plk and g_lif > 1
	local game_over  = fall_off_plk and g_lif == 1
	local respawning = gf_pl_mov
	local moving     = not g_rsp_mov

	-- buffer switch no matter what the state.
	local switched = next_level_switcher(g_nxt_lvl + 1)
	if switched then g_nxt_lvl += 1 end

	-- execute states
	if death then
		g_lif -= 1
		g_rsp = true

		g_rsp_mov_x, g_rsp_mov_y = calc_respawn_pos(l, buffer_solid_func)

		gf_pl_mov=cocreate(mov_to_pos)
		g_timer=cocreate(countdown)
	end

	if game_over then
		reset_duck()
		reset_respawn()
		reset_title()
		return
	end

	if respawning then
		g_rsp_mov = coresume(gf_pl_mov, l, g_rsp_mov_x, g_rsp_mov_y, 30)
		if not g_rsp_mov then gf_gl_mov = nil end
	end

	if moving then
		update_pl(
		l, buffer_solid_func,
		.55, .7, 2,
		.07, .3,
		g_wlk_spd, run_spd,
		1, 16
		)
	end

	-- no matter the state, countdown and update the lift
	coresume(g_timer, 3)

	if g_rsp then
		update_lif(g_plk_rsp)
	else
		update_lif(l.hs)
	end
end

function _update()
	-- logo logic
	if not l_end then return end

	-- title logic
	if not g_tit_end then title_logic() end

	-- game logic
	if g_tit_end then game_logic() end
end

-- updates the plank
function update_lif(hs)
	assert(hs >= 0)

	if hs == 0 then
		g_plk = max(g_plk - g_plk_dec, 0)
	else
		g_plk = min(g_plk + hs, g_plk_max)
	end
end

function _draw()
	cls(14)
	if not l_end then
		draw_logo()
		return
	end

	if g_rsp and g_rsp_mov then coresume(gf_shake) end

	draw_buffers()

	if g_tit_end then
		local blink = g_rsp and not g_rsp_mov
		if blink then coresume(gf_blink, draw_pl)
		else draw_pl() end

		draw_status()

		if g_countdown > 0 then print(g_countdown, 62, 60, 10) end
	else
		draw_title()
	end
end

function draw_status()
	camera(0,0)
	local x = g_plk_off*8 - 1
	line(x, 0, x, 127, 8)

	print('lvl '..(g_nxt_lvl - 1), 5, 5, 12)

	for i=1, g_lif do
		local r, w, b, c = 126, 8, 4, 7
		local x1 = r-(b+w) * i + b 
		local x2 = r-(b+w) * i + b + w - 1
		rectfill(x1, 2, x2, 9, c)
	end

	line(0, 15*8, 127, 15*8, 8)
end

run_spd = .3
function speed_cheat()
	if btnp(2) then
		if run_spd == .3 then
			run_spd = 8
		else
			run_spd = .3
		end
	end
end

-- cloud and wind examples. from cart no. #39947 :)
-- d_c=function(x,y)
	-- circfill(x+4,y+4,4,6)
	-- circfill(x-4,y+2,5,6)
	-- circfill(x,y,6,7)
	-- circfill(x+6,y+2,6,7)
-- end
-- d_w=function(y,l,to)
	-- nx=128-(((tick*(l/64))+to)%(128+l))
	-- line(nx,y,nx+l,y,c[2])
-- end
