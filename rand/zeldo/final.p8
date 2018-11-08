pico-8 cartridge // http://www.pico-8.com
version 8
__lua__
-- zeldo 1.0 - by alan morgan

-- comments were removed because i was running into the character limit.
-- to see all the comments and the code in separate files go to:
-- https://github.com/alanxoc3/pico-work/tree/master/zeldo

-- also put an issue on github if you notice any bugs.
-- there isn't much token space to deal with bugs, but I'll try to fix it.

scene_actors = {}
draw_map_funcs = {}
triggers = {}
marker = "title"  
prev_marker = marker
global_time=0 

sleep = false 

actors = {} 
offh = 64
offw = 96

viewx = 0
viewy = 0

function _init()
	color(0)
	palt(0,false)
	srand(time())

	init_game()
	make_scenes()
	make_triggers()

	scene_init()
end

function _update()
	shake(true) 

	if prev_marker == marker and not sleep then
		prev_marker = marker

		if marker == "title" then
			title_update()
		else
			scene_update()
		end

		if prev_marker != marker then
			scene_init()
			prev_marker = marker
		end
	end

	global_time=global_time+1 
end

function is_pl_in_box(box)
	return pl.x > box.x1 and pl.x < box.x2 and pl.y > box.y1 and pl.y < box.y2
end

function is_pl_in_box_rel(a, x1, y1, x2, y2)
	local box = {x1=a.x+x1, y1=a.y+y1, x2=a.x+x2, y2=a.y+y2}
	return is_pl_in_box(box)
end

function make_actor(x, y)
	local a={}

	a.static=false

	a.solid=true

	a.touchable=true

	a.good = false
	a.bad  = false

	a.stun  = 0

	a.visible=true

	a.x = x
	a.y = y
	a.dx = 0.0
	a.dy = 0.0

	a.spr = 16

	a.sw = 8
	a.sh = 8

	a.frame = 0
	a.frames=1

	a.t = 0

	a.inertia = 0.6

	a.bounce  = .3

	a.alive = true

	a.is_outside = false

	a.w = 0.4
	a.h = 0.4

	a.draw = draw_actor

	a.move = function(self) end

	a.hit = function(other) end

	a.unload = function() end

	a.load = function() end

	a.outside = function(self) end

	a.destroy = function(self) end

	add(actors,a)

	return a
end

function solid_on_map(x, y)
	local val=mget(x, y)
	return fget(val, 1)
end

function solid_area(x,y,w,h)
	return 
		solid_on_map(x-w,y-h) or
		solid_on_map(x+w,y-h) or
		solid_on_map(x-w,y+h) or
		solid_on_map(x+w,y+h)
end

function is_in_bounds(a)
	local left = pl.x - 16
	local right = pl.x + 16
	local top = pl.y - 16
	local bottom = pl.y + 16
	return a.x > left and a.x < right and a.y > top and a.y < bottom
end

function update_outside()
	for a in all(actors) do
		a.is_outside = not is_in_bounds(a)
		if a.is_outside then
			a.outside(a)
		end
	end
end

function actor_collision(a, dx, dy)
	local retlist = {}

	if not a.is_outside then
		for a2 in all(actors) do
			if not a2.is_outside and a != a2 then
				local x=(a.x+dx) - a2.x
				local y=(a.y+dy) - a2.y
				if ((abs(x) < (a.w+a2.w)) and
					(abs(y) < (a.h+a2.h)))
				then 

					if (dx != 0 and abs(x) <
							abs(a.x-a2.x)) then
						if a.touchable and a2.touchable then
							v=a.dx + a2.dx
							if not a.static then a.dx = v/2 end
							if not a2.static then a2.dx = v/2 end
						end
						add(retlist, a2)
					elseif (dy != 0 and abs(y) <
									abs(a.y-a2.y)) then
						if a.touchable and a2.touchable then
							v=a.dy + a2.dy
							if not a.static then a.dy = v/2 end
							if not a2.static then a2.dy = v/2 end
						end
						add(retlist, a2)
					end
				end
			end
		end
	end

	return retlist
end

function touching_wall(a, dx, dy)
	return a.solid and solid_area(a.x+dx,a.y+dy, a.w,a.h)
end

function hit_actors(a,alist)

	for other in all(alist) do
		a.hit(other)
		other.hit(a)
	end
end

function has_touchable(actor_list)
	for a in all(actor_list) do
		if a.touchable then
			return true
		end
	end
	return false
end

function move_actor_check(a, dx, dy)
	if not touching_wall(a, dx, dy) then
		local other_list = actor_collision(a, dx, dy) 

		if #other_list != 0 then
			hit_actors(a,other_list)

			if a.touchable and has_touchable(other_list) then
				dx *= -a.bounce
				dy *= -a.bounce

			end
		end

	else   

		dx *= -a.bounce
		dy *= -a.bounce

	end

	return dx + dy
end

function move_actors()

	foreach(actors, set_actor_speed)

	foreach(actors, set_actor_pos)
end

function set_actor_speed(a)
	if a.is_outside then
		return
	end

	if a.move != nil then
		if a.stun <= 0 then
			a.move(a)
		else
			a.stun -= 1
		end

	a.dx = move_actor_check(a, a.dx, 0)
	a.dy = move_actor_check(a, 0, a.dy)
	end
end

function set_actor_pos(a)
	if a.is_outside then
		return
	end

	a.x += a.dx
	a.y += a.dy

	a.dx *= a.inertia
	a.dy *= a.inertia

	a.frame += abs(a.dx) * 4
	a.frame += abs(a.dy) * 4
	a.frame %= a.frames

	a.t += 1
end

function offset_x()
	return -viewx * 8 + 64
end

function offset_y()
	return -viewy * 8 + 64
end

function scene_update()
	if not tbox_active() then
		map_update()
		trigger_update()
		view_update()
	else
		tbox_interact()
	end
end

function make_trigger(name, x1, y1, x2, y2, pos, mark, mus, snd)
	local func=nil
	if mark != nil then
		func = function() transition(mark, mus, snd) end
	end

	triggers[name] = {box={x1=x1, y1=y1, x2=x2, y2=y2}, active=true, pos=pos, func=func}
end

function trigger_update()
	for k, v in pairs(triggers) do
		if v.active and is_pl_in_box(v.box) then
			v.func()
			if v.pos != nil then
				pl.x = v.pos.x
				pl.y = v.pos.y
			end
		end
	end
end

function view_update()
	viewx = pl.x
	viewy = pl.y
end

function title_update()
	if btnp(4) then
		transition("hut", 63, 63)
	end
end

function get_alt(id)
	if id == 43 or
	   id == 44 or
	   id == 56 or
	   id == 57 then
		return 15
	elseif id == 16 or
	       id == 27 or
	       id == 28 or
	       id == 32 or
	       id == 48 or
	       id == 112 or
	       id == 119 or
	       id == 113 then
		return 0
	end

	return 7
end

function del_if_enemy(enemy)

	if enemy.bad then
		del(actors, enemy)
	end
end

function clean_enemies()
	foreach(actors, del_if_enemy)
end

function save_scene()

	for a in all(actors) do
		a.unload()
	end
	actors = {}
end

function load_scene(scene_name)
	save_scene()
	actors = scene_actors[scene_name]

	add(actors, pl)

	for a in all(actors) do
		a.load()
	end

	view_update()

end

function draw_wrap(x,y,w,h, off)
	if off == nil then
		off = 2
	end

	local count= flr((8-off)/off)

	local offx = -pl.x*8+64
	local offy = -pl.y*8+64

	for i=1, count, 1 do

		map(x, y, x*8 + -i*8*off + offx, y*8 + offy, off, h)

		map(x, y, x*8 + offx, y*8 + -i*8*off + offy, w, off)
	end

	for i=0, count-1, 1 do

		map(x+w - off, y, (x+w)*8 + i*8*off + offx, y*8 + offy, off, h)

		map(x, y+h - off, x*8 + offx, (y+h)*8 + i*8*off + offy, w, off)
	end

	for i=0, count-1, 1 do
		for j=0, count-1, 1 do

			map(x, (y+h)-off, x*8 + i*8*off - count*8*off + offx, j*8*off + (y+h)*8 + offy, off, off)

			map((x+w)-off, (y+h)-off, i*8*off + (x+w)*8 + offx, j*8*off + (y+h)*8 + offy, off, off)

			map((x+w)-off, y, i*8*off + (x+w)*8 + offx, y*8 + j*8*off - count*8*off + offy, off, off)

			map(x, y, x*8 + i*8*off - count*8*off + offx, y*8 + j*8*off - count*8*off + offy, off, off)
		end
	end
end

function garbage_collection()
	foreach(actors,
		function(a)
			if a.alive == false then
				a.destroy()
				del(actors, a)
			end
		end)
end

function map_update()
	if pl.alive then
		move_actors()
	end

	update_outside()
	garbage_collection()
end

function dice_roll(sides)
	return flr(rnd(sides)) == 1
end

function gen_boss(x, y)
	local bad = gen_enemy(x, y)
	bad.killed = false
	bad.cur_stage = 1
	bad.defeated = function() end
	bad.stages = {}

	bad.hit =
	function(other)
		local stage = bad.stages[bad.cur_stage]
		local state = stage.states[stage.cur_state]

		if stage.vulnerable then
			stage.hurt_func(other, stage, state)
		else
			stage.hit_func(other, stage, state)
		end
	end

	bad.move =
	function(self)
		if not bad.started then
			return
		end

		local stage = bad.stages[bad.cur_stage]
		local state = stage.states[stage.cur_state]

		if stage != nil then
			state.func(bad, stage, state.timer)
			state.timer += 1
			stage.timer += 1

			if stage.lives <= 0 then
				bad.cur_stage += 1

				if bad.stages[bad.cur_stage] == nil then

					bad.killed = true
					bad.move = function() end
					bad.hit  = function() end

					bad.defeated()
				end
			end
		end
	end

	return bad
end

function make_state(func)
	local state = {}
	state.timer = 0
	if func != nil then
		state.func = func
	else
		state.func = function(actor, stage, timer) end
	end

	return state
end

function make_stage()
	local stage = {}
	stage.states = {}
	stage.cur_state = "begin"
	stage.lives = 1
	stage.vulnerable = false
	stage.timer = 0
	stage.hit_func  = function(self, other, stage, state) end
	stage.hurt_func = function(self, other, stage, state) end

	stage.move_to_state =
	function(state)

		stage.states[state].timer = 0
		stage.cur_state = state
	end

	return stage
end
function gen_canondwarf(x, y)
	local bad = gen_boss(x, y)

	bad.defeated =
	function()
		canon_kill(bad)
	end

	bad.reset =
		function()
			bad.spr = 109
			bad.dx = 0
			bad.static = true
			bad.touchable = true
			bad.dy = 0
			bad.x = x
			bad.y = y
			bad.solid = false
			bad.started = false
			bad.stages = {}
			add(bad.stages, make_canon_stage1())
			add(bad.stages, make_canon_stage2())
			add(bad.stages, make_canon_stage3())
		end

	bad.unload =
		function()
			if not bad.killed then
				clean_enemies()
				add(actors, bad)
				canon.reset()
			end

			if triggers["canon_intro"].active == false then
				triggers["canon_resume"].active = true
			end

			if bad.killed then
				triggers["canon_resume"].active = false
			end
		end

	bad.load =
		function()
			if bad.killed then
				music(-1)
			end
		end

	bad.tres_text = "intruder."
	bad.reset()

	return bad
end

function make_canon_stage1()
	local stage = make_stage()
	stage.lives = 3
	stage.hit_func = canondwarf_hit

	stage.hurt_func =
	function(other, stage, state)
		if other == pl.sword and pl.has_master then
			stage.lives -= 1
			stage.vulnerable = false
		end
	end

	stage.states["topl"] = make_state(
	function(actor, stage, timer)
		move_to_player(actor, .05)
		if timer > 120 then
			stage.move_to_state("shootpl")
		end
	end)

	stage.states["shootpl"] = make_state(
	function(actor, stage, timer)
		if timer >= 120 then
			stage.move_to_state("topl")
		elseif timer % 30 == 0 then
			shoot_ball_to_pl(actor)
		end
	end)

	stage.states["begin"] = make_state(
	function(actor, stage, timer)
		if timer == 0 then
			music(55) 
			actor.spr = 108
		elseif timer >= 30 then
			stage.move_to_state("shootpl")
		else
			actor.dy = -.05
		end
	end)

	stage.states["stunned"] = make_state(
	function(actor, stage, timer)
		if timer == 0 then
			gen_poe(actor.x, actor.y)
			gen_skellies_in_corners()
			stage.vulnerable = true
		elseif timer >= 60 then
			stage.move_to_state("topl")
			stage.vulnerable = false
		else

			if not stage.vulnerable then
				shake()
			end
		end
	end)

	return stage
end

function make_canon_stage2()
	local stage = make_stage()
	stage.lives = 3
	stage.hit_func = canondwarf_hit

	stage.hurt_func =
	function(other, stage, state)
		if other == pl.sword and pl.has_master then
			stage.lives -= 1
			stage.vulnerable = false
		end
	end

	stage.states["begin"] = make_state(
	function(actor, stage, timer)
		if timer == 0 then

			actor.touchable=false
			stage.move_to_state("tocenter")
		end
	end)

	stage.states["stunned"] = make_state(
	function(actor, stage, timer)
		if timer == 0 then
			gen_skellies_in_corners()
			stage.vulnerable = true
		elseif timer >= 60 then
			stage.move_to_state("tocenter")
			stage.vulnerable = false
		else

			if not stage.vulnerable then
				shake()
			end
		end
	end)

	stage.states["tocenter"] = make_state(
	function(actor, stage, timer)
		shake()
		local mid_x = 104
		local mid_y = 8
		move_to_point(actor, .05, 104, 10)

		if actor.x < mid_x + 2 and actor.x > mid_x - 2 and actor.y < mid_y + 2 and actor.y > mid_y - 2 then
			stage.move_to_state("circle")
		end
	end)

	stage.states["circle"] = make_state(
	function(actor, stage, timer)
		if timer == 0 then

			stage.clock = dice_roll(2)
		else
			if stage.clock then
				move_clockwise(actor, 3, 7, 7, timer)
			else
				move_counter(actor, 3, 7, 7, timer)
			end

			if timer % 60 == 0 then
				shoot_ball_to_pl(actor)
			end

			if timer % 180 == 0 then
				gen_skellies_in_corners()
			end
		end
	end)

	return stage
end

function make_canon_stage3()
	local stage = make_stage()
	stage.lives = 1

	stage.states["begin"] = make_state(
	function(actor, stage, timer)
		shake()
		if timer == 0 then

			actor.touchable=true
			music(-1)
			sfx(22)
		elseif timer > 90 then
			stage.lives = 0
		end
	end)

	return stage
end

function canondwarf_hit(other, stage, state)
	if other.id == "ball" and other.good then
		stage.move_to_state("stunned")
	end
end

function gen_skellies_in_corners()
	gen_skelly(98.5, 17.5)
	gen_skelly(109.5, 17.5)
	gen_skelly(109.5, 2.5)
	gen_skelly(98.5, 2.5)
end

function shoot_ball_to_pl(actor)
	local ball = gen_energy_ball(actor.x,actor.y, 0, 0)
	move_to_player(ball, .3)
end

function canon_kill(bad)
	music(-1)

	bad.bad = false

	clean_enemies()

	mset(101, 2, 98)
	mset(102, 2, 99)

	bad.x = 104
	bad.y = 3.5
	pl.x = 103
	pl.y = 4.5

	gen_zeldo(102, 3.5)

	transition(marker)

	tbox("canondwarf", "you beat me. that hurt.")
	tbox("zeldo", "lank, why did you beat up canondwarf?")
	tbox("zeldo", "we were just about to have a tea party.")
	tbox("canondwarf", "yeah, and he messed up my organ playing.")
	tbox("zeldo", "you know what lank, i don't like you any more.")
	tbox("zeldo", "so... die!")
end

function draw_power_orbs(x, y)

	draw_to_screen(55, x-1, y-1)
	print(power_orb_count, x+8, y+1, 7)
end

function draw_items(x, y)
	local stats = {}

	if pl.has_sword then
		if pl.has_master then
			add(stats, 43)
		else
			add(stats, 56)
		end
	end

	if pl.has_boomerang then
		add(stats, 54)
	end

	for i=0, pl.has_fairy-1, 1 do
		add(stats, 117)
	end

	local i = 0
	for id in all(stats) do
		draw_to_screen(id, i*10 + x, y)
		i += 1
	end
end

function draw_text(text, x, y, col)
	local sx = (x * 8) + offset_x()
	local sy = (y * 8) + offset_y()

	print(text, sx, sy, col)
end

function draw_actor(a, w, h, flip_x, flip_y)
	if a.alive then
		local sx = (a.x * 8) + offset_x() - a.sw/2
		local sy = (a.y * 8) + offset_y() - a.sh/2

		if w == nil then w = 1 end
		if h == nil then h = 1 end
		if flip_x == nil then flip_x = false end
		if flip_y == nil then flip_y = false end

		local alt = get_alt(a.spr)
		palt(alt,true)
		spr(a.spr + a.frame, sx, sy, w, h, flip_x, flip_y)
		palt(alt,false)
	end
end

local rnd_x = 0
local rnd_y = 1
function draw_title()
	cls(0)
	local col = 10 
	if global_time % 120 == 0 then
		rnd_x = flr(rnd(6))
		rnd_y = flr(rnd(4))
	end

	viewx = 16 * rnd_x + 8
	viewy = 16 * rnd_y + 8

	map(viewx - 8, viewy - 8, 0,0,16,16)

	draw_things()

	for i=0,7,1 do
		draw_to_screen(72+i,4*8+i*8,7*8)
		draw_to_screen(88+i,4*8+i*8,8*8)
	end

	print("the story of", 41, 50, col)
	if global_time % 30 < 20 then
		print("press z to start", 32, 72, 7)
	end
end

function draw_things()
	for a in all(actors) do
		if a.visible then
			a.draw(a)
		end
	end
end

function draw_to_screen(id, x, y)
	local alt = get_alt(id)
	palt(alt,true)
	spr(id, x, y)
	palt(alt,false)
end

fairy_counter=0
fairy_clockwise=false
function draw_fairy()
	local x = 64 + 8 * cos(fairy_counter) - 4
	local y = 64 + 8 * sin(fairy_counter) - 4
	draw_to_screen(107, x, y)

	if time() % 20 == 0 then
		fairy_clockwise=not fairy_clockwise
	end

	if fairy_clockwise then
		fairy_counter -= rnd(.01)
	else
		fairy_counter += rnd(.01)
	end

	if fairy_counter > 1 then
		fairy_counter -= 1
	elseif fairy_counter < 0 then
		fairy_counter += 1
	end
end

death_link_counter=0
function draw_link_death()
	local yoff = sin(time() / 4 + .2)
	local ind = 104

	death_link_counter += 1
		if death_link_counter > 7*30 then
			ind = 102
		elseif death_link_counter > 5*30 then
			ind = 103
		end

	draw_to_screen(ind, 128/2 - 4, yoff + 128/2 - 4)
end

game_over_timer = 5
game_over_fadein = 3
function draw_game_over()

	local yoff = sin(time() / 8)
	local fade_ind=58
	if game_over_timer > 0 then
		if time() % 1 == 0 then
			game_over_timer -= 1
		end
	elseif game_over_timer == 0 and game_over_fadein > 0 then
		if time() % 1 == 0 then
			game_over_fadein -= 1
		end
	end

	for i=0,120,8 do
		for j=0,120,8 do
			draw_to_screen(fade_ind+game_over_timer, i, j)
		end
	end

	if game_over_fadein <= 2 then
		print("game over", 46, 47+yoff, 7 - game_over_fadein)
		print("reset cart to play again", 16, 77+yoff, 7 - game_over_fadein)
	end

end

function draw_hearts(x, y)

	for i=0, pl.hearts-1, 1 do
		draw_to_screen(35, x-8*(i+1), y-1)
	end
end

function scene_draw()

	local mark = ""
	if trans_after_peak then
		mark = marker
	else
		mark = prev_marker
	end

	if mark == "title" then
		draw_title()
		return
	end

	if mark == "hut" then
		draw_map(96, 32, 5, 5)
	elseif mark == "boss" then
		draw_map(96, 0, 16, 20)
	elseif mark == "overworld" then
		draw_map(0, 0, offw, offh)
		draw_wrap(0, 0, offw, offh)
	elseif mark == "old" then
		draw_map(96, 38, 5, 5)
	elseif mark == "sacred" then
		draw_map (113, 33, 10, 22)
		draw_wrap(113, 33, 10, 22)
	elseif mark == "shop" then
		draw_map(101, 33, 11, 10)
	else 
		draw_map (97, 45, 10, 10)
		draw_wrap(97, 45, 10, 10, 1)
	end

	draw_things()
	draw_hearts(126, 2)
	draw_items(2, 118)
	draw_power_orbs(2, 2)

	if pl.alive == false then
		draw_game_over()
		draw_link_death()
	end

	draw_fairy()
	tbox_draw()
end

function _draw()
	if not trans_active or trans_after_peak then
		scene_draw()

	end

	local prev_trans_active = trans_active
	trans_after_peak = transition_draw(30, screen_swipe)

	if prev_trans_active != trans_active and trans_song != nil then
		music(trans_song)
	end

	sleep = trans_active
end

function draw_map(x, y, w, h)
	cls(0)
	local offx = -pl.x*8+64
	local offy = -pl.y*8+64
	map(x, y, x * 8 + offx, y * 8 + offy, w, h)
end

trans_active = false
trans_after_peak = false
trans_timer = 0
trans_song = -1

function transition(mark, music_when_done, sound_effect)
	if not trans_active then
		if mark != nil then
			marker = mark
		end

		trans_active = true
		trans_timer = 0
		trans_after_peak = false
		sleep = true

		trans_song = music_when_done

		if sound_effect != nil then
			music(-1)
			sfx(sound_effect)
		end
	end
end

function transition_draw(time, func)
	local after_peak = false
	if trans_active then
		after_peak = func(time, trans_timer)
		trans_timer += 1
		if trans_timer >= time then
			trans_active = false
		end
	end
	return after_peak
end

function screen_swipe(length, timer)

	local pos = 128 * sin(timer / length / 2 + .5)

	if timer > length / 2 then
		rectfill(128-pos,-1,129,129,0)
	else
		rectfill(-1,-1,pos,129,0)
	end

	return timer >= flr(length / 2)
end
function gen_deku(x, y)
	local bad = gen_enemy(x, y)
	bad.spr = 70
	bad.shoot_spd = 60

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

	return bad
end

function gen_spear(x,y,dy)
	local bad = gen_bullet(x,y,0,dy)
	bad.spr = 85

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

			if dice_roll(5) then
				col = gen_heart(bad.x, bad.y)
			else
				col = gen_power_orb(bad.x, bad.y)
			end

			col.dx = bad.dx*3
			col.dy = bad.dy*3
		end

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

	bad.outside=
		function(a)
			a.alive = false
		end

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

	update_collection = function()
		foreach(boom.collection,
			function(item)
				item.dx = boom.dx
				item.dy = boom.dy
			end)
		end

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
function make_lost_woods(path_len)
	actors = {}
	gen_sign(100.5,46.5, "don't get lost!")

	scene_actors[get_lost_name(1)] = actors
	actors = {}

	for i=2, path_len do
		gen_lost_actors(i, path_len)
	end

	local path = make_lost_path(path_len)
	lost_woods_triggers(path)
end

function gen_lost_actors(path_num, path_len)
	actors = {}

	gen_skelly(98.5,46.5)
	gen_skelly(105.5,46.5)
	gen_skelly(102,50)

	gen_skelly(98.5,53.5)
	gen_skelly(105.5,53.5)

	scene_actors[get_lost_name(path_num)] = actors
	actors = {}
end

function make_lost_path(path_len)

	local lost_woods_path = {}
	local prev_num = 1

	for i=1, path_len-1 do
		local new_num = 1

		if prev_num == 0 then
			new_num = flr(rnd(2))
		elseif prev_num == 1 then
			new_num = flr(rnd(3))
		else 
			new_num = flr(rnd(2)) + 1
		end

		add(lost_woods_path, new_num)
		prev_num = new_num
	end

	add(lost_woods_path, 1)
	return lost_woods_path
end

function make_lost_dir_trigger(str, dir)
	if dir == 0 then
		make_trigger(str, 96, 48, 97, 52, {x=106.5, y=50})
	elseif dir == 1 then
		make_trigger(str, 100, 44, 104, 45, {x=102, y=54.5})
	else 
		make_trigger(str, 107, 48, 108, 52, {x=97.5, y=50})
	end
	triggers[str].active = false
end

function get_lost_name(room_num)
	return "lost_woods_"..room_num
end

function get_lost_right_name(room_num)
	return "lost_woods_"..room_num.."_right"
end

function get_lost_wrong1_name(room_num)
	return "lost_woods_"..room_num.."_wrong_1"
end

function get_lost_wrong2_name(room_num)
	return "lost_woods_"..room_num.."_wrong_2"
end

function toggle_lost_room_str(room_name, active)
	local str1 = room_name.."_wrong_1"
	local str2 = room_name.."_wrong_2"
	local str3 = room_name.."_right"

	triggers[str1].active = active
	triggers[str2].active = active
	triggers[str3].active = active
end

function toggle_lost_room(room_num, active)
	local str1 = get_lost_wrong1_name(room_num)
	local str2 = get_lost_wrong2_name(room_num)
	local str3 = get_lost_right_name(room_num)

	if room_num > 0 then
		triggers[str1].active = active
		triggers[str2].active = active
		triggers[str3].active = active
	end
end

function switch_lost_room(cur_num, nxt_num)
	toggle_lost_room(cur_num, false)
	toggle_lost_room(nxt_num, true)
	marker = get_lost_name(nxt_num)
end

function make_wrong_exits(path_num, dir1, dir2)
	local str1 = get_lost_wrong1_name(path_num)
	local str2 = get_lost_wrong2_name(path_num)

	make_lost_dir_trigger(str1, dir1)
	make_lost_dir_trigger(str2, dir2)

	local reset_func=
		function()

			switch_lost_room(path_num, 1)
		end

	triggers[str1].func = reset_func
	triggers[str2].func = reset_func
end

function make_right_exit(path_num, dir)
	local str = get_lost_right_name(path_num)
	local nxt = get_lost_name(path_num+1)
	make_lost_dir_trigger(str, dir)

	triggers[str].func =
		function()

			switch_lost_room(path_num, path_num+1)
		end
end

function make_final_exit(path_num, dir)
	local str = get_lost_right_name(path_num)
	make_lost_dir_trigger(str, dir)
	triggers[str].pos = {x=118,y=54.5}

	triggers[str].func =
		function()

			toggle_lost_room(path_num, false)
			toggle_lost_room(1, true)
			transition("sacred")
			sfx(63)
		end
end

function lost_woods_triggers(lost_woods_path)
	local str_exit = "lost_woods_exit"
	make_trigger(str_exit, 100,  55, 104,  56, {x=32, y=1.5})
	triggers[str_exit].func =
		function()
			toggle_lost_room_str(marker, false)
			toggle_lost_room(1, true)
			transition("overworld", 14, -1) 
		end

	for k,v in pairs(lost_woods_path) do
		if k == #lost_woods_path then
			make_final_exit(k, v)
		else
			make_right_exit(k, v)
		end

		make_wrong_exits(k, (v+1)%3, (v+2)%3)
	end

	toggle_lost_room(1, true) 
end
function make_map()
	actors = {}

	gen_sign(34.5, 17.5, "the square force has protected the land of hiroll for ages.")
	gen_chest(11.5, 24.5, 
		function()
			tbox("", "you found 70 power orbs! nice job!")
			power_orb_count += 70
		end)

	gen_chest(40.5, 7.5, 
		function()
			heart_container()
		end)

	gen_sign(9.5,5.5, "lank's house")

	gen_sign(14.5,48.5, "old man's house")
	gen_grave(17.5,48.5, "here lies an even older man. i love you dad. :)")
	gen_grave(68.5,2.5, "take my heart, i don't need it since i'm dead.")
	gen_chest(67.5, 2.5, 
		function()
			heart_container()
		end)

	gen_oldman(31.5, 2.5,
		function(self)
			if self.state == 0 then
				if pl.has_sword and power_orb_count >= 10 then
					tbox("old man", "oh, you have a sword.....")
					tbox("old man", "and power orbs. i'll take those. hehe.")
					power_orb_count -= 10
					mset(32,2,3) 
					self.state = 1
				else
					tbox("old man", "a powerful sword along with powerful enemies lie beyond here.")
					tbox("old man", "come back when you've have something to fight with and 10 power orbs.")
				end
			else
				tbox("old man", "thanks for the orbs.")
			end
		end)

	scene_actors["overworld"] = actors
	actors = {}
end

function make_hut()
	actors = {}
	gen_chest(97.5, 33.5,
		function()
			tbox("", "you got a fairy in a bottle.")
			tbox("", "it will heal you if you've lost all your hearts.")
			pl.has_fairy += 1
		end)

	scene_actors["hut"] = actors
	actors = {}
end

function make_sacred()
	actors = {}

	gen_chest(119.5, 36.5,
		function()
			heart_container()
		end)

	gen_sign(116.5, 36.5, "only the hero of hiroll can wield this sword.")
	gen_sword_stand(118, 36.5)

	scene_actors["sacred"] = actors
	actors = {}
end

function make_old()
	actors = {}

	gen_sign(97.5, 39.5, "that chest holds all that is left of my father. please don't open the it.")
	gen_chest(99.5, 39.5,
		function()
			pl.has_boomerang = true
			tbox("", "you found a boomerang!")
			tbox("", "hold x then press an arrow key to use it.")
		end)

	scene_actors["old"] = actors
	actors = {}
end

function make_boss()
	actors = {}

	canon = gen_canondwarf(104,3.5)
	gen_chest(100.5, 2.5,
		function()
			power_orb_count += 49
			canon.tres_text = "thief."
			thief_trig = true

			tbox("", "you found 49 power orbs. canondwarf doesn't deserve these anyway.")
			tbox("canondwarf", "oh now you steal from me. i'll never forgive you for this.")
		end)
	gen_sign(107.5, 2.5, "cages are reserved for special guests.")

	make_trigger("canon_intro",  100,  1,     108,  9)
	make_trigger("canon_resume", 100,  1,     108,  9)

	make_trigger("boss_enter",   87,   3,     89,   4.5,  {x=104,  y=19.5}, "boss", 53, -1)
	make_trigger("boss_exit",    101,  20,    107,  21,   {x=88, y=4.5},  "overworld", 14, -1)

	triggers["canon_resume"].active = false

	triggers["canon_resume"].func =
		function()
			music(-1)
			tbox("canondwarf", "mwahahahahahahahahahaha.")
			tbox("canondwarf", "i see you're back. you'll pay you little "..canon.tres_text)
			sfx(59)
			canon.started = true
			canon.spr = 108
			triggers["canon_resume"].active=false
		end

	triggers["canon_intro"].func =
		function()
			music(-1)
			tbox("canondwarf", "mwahahahahahahahahahaha.")
			tbox("canondwarf", "who are you?")
			tbox("lank", "i'm lank.")
			tbox("zeldo", "lank you're here! don't-")
			tbox("canondwarf", "be quiet princess! i'll take care of this loser.")
			tbox("zeldo", "but-")
			sfx(59)
			canon.started = true
			canon.spr = 108
			triggers["canon_intro"].active=false
		end

	scene_actors["boss"] = actors
	actors = {}
end

function make_shop()
	actors = {}

	gen_oldman(106.5, 35.5,
		function(self)
			if self.state == 0 then
				tbox("shopkeeper", "i love selling things.")
				tbox("shopkeeper", "press z below one of the items to buy it.")
			end
		end)

	gen_item(103.5, 38.5, 99, 117,
		function(item)
			tbox("", "you got a fairy in a bottle.")
			tbox("", "it will heal you if you've lost all your hearts.")
			pl.has_fairy += 1
		end)

	gen_item(106.5, 38.5, 49, 56,
		function(item)
			tbox("", "you got a sword.")
			tbox("", "hold z then press an arrow key to use it.")
			pl.has_sword = true
		end)

	gen_item(109.5, 38.5, 99, 118,
		function(item)
			heart_container()
		end)

	scene_actors["shop"] = actors
	actors = {}
end

function make_scenes()
	make_map()
	make_hut()
	make_shop()
	make_boss()
	make_old()
	make_lost_woods(5) 
	make_sacred()
end

function gen_enemies(easy)
	for i=0, 95, 1 do
		for j=0, 63, 1 do
			local id = fget(mget(i,j))
			local x = i + .5
			local y = j + .5
			if id == 128 then
				gen_deku(x, y)
			elseif id == 64 and not easy then
				gen_pig(x, y)
			elseif id == 32 and not easy then
				gen_skelly(x, y)
			elseif id == 16 then
				gen_poe(x, y)
			elseif id == 8 then
				gen_octorok(x, y)
			end
		end
	end
end

function variety_tile(tile)
	if tile > 0 and tile < 10 then
		if tile % 3 == 0 then
			return tile - 1
		elseif tile + 1 % 3 == 0 then
			return tile + 1
		end
	end

	return tile
end

function gen_grass()

	for i=1, offw - 2, 1 do
		for j=1, offh - 2, 1 do
			local tile = mget(i,j)
			local new_tile = variety_tile(tile)
			if new_tile != tile and dice_roll(10) then
				mset(i,j,new_tile)
			end
		end
	end
end

function move_clockwise(a, spd, radx, rady, timer)
	local ang = -timer / 30 / spd
	a.dx = radx * cos(ang) / 30
	a.dy = rady * sin(ang) / 30
end

function move_counter(a, spd, radx, rady, timer)
	local ang = timer / 30 / spd + .5
	a.dx = radx * cos(ang) / 30
	a.dy = rady * sin(ang) / 30
end

function move_to_point(a, spd, x, y)
	local ang = atan2(x - a.x, y - a.y)
	a.dx = spd * cos(ang)
	a.dy = spd * sin(ang)
end

function move_to_player(a, spd)
	move_to_point(a, spd, pl.x, pl.y)
end

function gen_chest(x,y, func)
	local chest = gen_interactable(x, y)
	chest.spr=114
	chest.interact=
		function()
			if chest.spr != 115 then
				chest.spr = 115
				sfx(62)
				func()
			end
		end
	return chest
end

function gen_grave(x,y, str)
	local grave = gen_sign(x, y, str)
	grave.spr=4
	return grave
end

function gen_sign(x,y, str)
	local sign = gen_interactable(x, y)
	sign.spr = 19
	sign.interact = function() tbox("", str) end
	return sign
end

function gen_oldman(x,y, func)
	local oldie = gen_interactable(x, y)
	oldie.interact = function() func(oldie) end
	oldie.spr=97
	oldie.state=0
	return oldie
end

function gen_item(x,y, price, spr_ind, func)
	local item = gen_interactable(x, y)
	item.spr = spr_ind
	item.static = true
	item.price = price
	item.draw=
		function(self)
			draw_text(self.price, item.x-.5, item.y-1.3, 1)
			draw_actor(self)
		end

	item.interact =
		function()
			if power_orb_count >= item.price then
				func(item)
				power_orb_count -= item.price
				item.alive = false
			else
				tbox("shopkeeper", "hey, you don't have enough power orbs to buy that!")
			end
		end

	return item
end

function gen_interactable(x, y, func)
	local thing = make_actor(x,y)
	thing.static=true
	if func != nil then
		thing.interact=func
	else
		thing.interact=function() end
	end

	thing.move=actor_interact

	return thing
end

function actor_interact(self)
	local x1 = -self.w
	local x2 =  self.w
	local y1 =  self.h
	local y2 =  2.5*self.h

	if is_pl_in_box_rel(self, x1, x2, y1, y2)
	and btnp(4) then
		self.interact()
	end
end

function heart_container()
	tbox("", "you got a heart container.")
	tbox("", "your max health is now increased by one.")
	pl.max_hearts += 1
	pl.hearts = pl.max_hearts

end

function gen_collectable(x, y)
	local collectable = make_actor(x, y)
	collectable.hit_boom = false
	collectable.inertia = 0
	collectable.touchable = false
	collectable.solid = false

	collectable.hit=
		function(other)

			if other == pl and not collectable.hit_boom then
				collectable.alive = false
			elseif other == pl.boomerang and not collectable.hit_boom then
				collectable.hit_boom = true
				other.collect(collectable)
			end
		end

	return collectable
end

function gen_heart(x,y)
	local heart = gen_collectable(x,y)
	heart.spr = 35

	heart.destroy =
		function(self)
			pl.heal()
		end
	return heart
end

function gen_power_orb(x, y)
	local orb = gen_collectable(x,y)
	orb.spr = 55

	orb.destroy =
		function(self)
			power_orb_count += 1
		end
	return orb
end

function gen_sword_stand(x, y)

	local sword = make_actor(x, y-1)
	sword.spr = 16
	sword.static = false
	sword.touchable = false
	sword.h = .4
	sword.draw=
		function(a)
			draw_actor(a, 1, 2, nil, nil)
		end

	local stand = gen_interactable(x, y)
	stand.spr = 27
	stand.static = true
	stand.w = .5
	stand.interact = 
		function()
			if sword.alive then
				sfx(62)
				tbox("", "you got the master sword. you can now deflect bullets.")
				tbox("voice", "hero of hiroll, we entrust this sword with you.")
				tbox("voice", "beware of your friends.")
				tbox("lank", "that was creepy.")
				tbox("ivan", "hey, listen! you shouldn't listen to spontaneous voices like that.")
				tbox("lank", "okay.")
				sword.alive=false
				pl.has_sword = true
				pl.has_master = true
			end
		end

	stand.sw = 16
	stand.draw=
		function(a)
			draw_actor(a, 2, 1, nil, nil)
		end
end
function gen_zeldo(x, y)
	local girl = gen_interactable(x, y)
	girl.spr = 120

	girl.move =
		function()
			if is_tbox_done() then
				pl.alive = false
			end
		end

	return girl
end
power_orb_count = 0

function control_player(pl)

	local accel = pl.spd

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

	if pl.regenerate > 0 then pl.regenerate -= 1 end

	if (abs(pl.dx)+abs(pl.dy) > 0.1
					and (pl.t%4) == 0) then

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
	pl.has_sword=false  
	pl.has_master=false
	pl.sword=nil       
	pl.regenerate=0

	pl.has_boomerang=false 
	pl.boomerang=nil      

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

function shake(reset) 
	camera(0,0) 

	if not reset then 
		camera(flr(rnd(2)-1),flr(rnd(2)-1)) 
	end
end
thief_trig = false
monster_near = false
more_monster = false

function make_triggers()

	make_trigger("no_sword",     7,    10,    9,    12)
	make_trigger("steal"   ,     97,   39,    100,  42)
	make_trigger("hut_start",    97,   33,    100,  36)
	make_trigger("mast_intro",   115,  37,    121,  41)

	make_trigger("hut_enter",    7,    4.5,   9,    5.5,  {x=98.5,    y=36.5}, "hut",  63, -1)
	make_trigger("old_enter",    15,   47.5,  17,   48.5, {x=98.5,    y=42.5}, "old",  63, -1)
	make_trigger("shop_enter",   29,   55.5,  31,   56.5, {x=106.5,   y=42.5}, "shop", 63, -1)
	make_trigger("lost_enter",   31,   0,     33,   1,    {x=102,     y=54.5}, get_lost_name(1), 0, -1)

	make_trigger("hut_exit",    97,   37,    100,  38,   {x=8,    y=5.5},  "overworld", 14, -1)
	make_trigger("old_exit",    97,   43,    100,  44,   {x=16,   y=48.5}, "overworld", 14, -1)
	make_trigger("shop_exit",   104,  43,    109,  44,   {x=29.5, y=56.5}, "overworld", 14, -1)
	make_trigger("sacred_exit", 116,  55,    120,  56,   {x=32.5, y=1.5},  "overworld", 14, -1)

	make_trigger("enemies_spawn",    86,  5,    90,  9)
	triggers["enemies_spawn"].func =
		function()
			if thief_trig then
				if not monster_near then
					tbox("ivan", "hey, listen! i think monsters are near.", "spawn")
					monster_near = true
				end

				if monster_near and is_tbox_done("spawn") then
					mset(22, 56, 3)
					gen_enemies(true)
					transition()
					triggers["enemies_spawn"].active=false
				end
			end
		end

	make_trigger("more_spawn",    29,  3,    35,  6)
	triggers["more_spawn"].func =
		function()
			if pl.has_master then
				if not more_monster then
					tbox("ivan", "watch out! your sword is attracting more monsters.", "moresp")
					more_monster = true
				end

				if more_monster and is_tbox_done("moresp") then
					mset(11, 25, 3)
					clean_enemies()
					gen_enemies(false)
					transition()
					triggers["more_spawn"].active=false
				end
			end
		end

	triggers["mast_intro"].func =
		function()
			tbox("ivan", "yes. lank, once you wield this, you can finally defeat canondwarf. haha!")
			tbox("lank", "wow, i think i can do this.")
			triggers["mast_intro"].active=false
		end

	triggers["hut_start"].func =
		function()
			tbox("ivan", "hey! listen!")
			tbox("ivan", "wake up lank.")
			tbox("lank", "...")
			tbox("ivan", "lank, princess zeldo is being held captive by canondwarf! you gotta rescue her!")
			tbox("lank", "who are you?")
			tbox("ivan", "i'm your fairy.")
			tbox("lank", "oh, okay.")
			triggers["hut_start"].active=false
		end

	triggers["steal"].func =
		function()
			tbox("ivan", "look! it's a chest.  try pressing z near it.")
			tbox("lank", "but it's not mine..")
			tbox("ivan", "nevermind that. you're just borrowing it.")
			tbox("lank", "well, i guess i could give it back later.")

			triggers["steal"].active=false
		end

	triggers["no_sword"].func =
		function()
			tbox("ivan", "hey, listen! you don't have a sword yet! how can you save zeldo like this?")
			triggers["no_sword"].active=false
		end
end

function init_game()
	actors = {}
	pl = gen_link(8, 8)
	gen_grass()
end

function scene_init()
	local x = 0
	local y = 0

	if marker == "hut" then
		if prev_marker == "title" then
			pl.visible = true
			pl.x = 98.5
			pl.y = 34
		end
	elseif marker == "title" then
		music(-1)
		music(0)
		pl.visible = false
	end

	load_scene(marker)
end

tbox_messages={} 

function break_up_long_word(word_list, word, max_len)
	local ind = 0

	local substr = ""
	while ind < #word do
		if #word <= ind + max_len then
			substr = sub(word, ind, ind+max_len)
		else
			substr = sub(word, ind, ind+max_len - 1).."-"
		end

		add(word_list, substr)
		ind += max_len
	end

	return word_list
end

function words_to_list(str, line_len)

	local collect_word = ""
	local words = {}
	for i=0, #str, 1 do
		local cur_char = sub(str, i, i)

		if cur_char == " " and #collect_word > 0 then
			words = break_up_long_word(words, collect_word, line_len)
			collect_word = ""

		elseif cur_char != " " then
			collect_word = collect_word..cur_char
		end
	end

	if #collect_word > 0 then
		words = break_up_long_word(words, collect_word, line_len)
	end

	return words
end

function words_to_lines(words, line_len)

	local cur_line = ""
	local first = 0
	local line_list = {}
	for word in all(words) do

		if #cur_line + #word + first > line_len then
			add(line_list, cur_line)
			cur_line = ""
			first = 0
		end

		if first == 1 then cur_line = cur_line.." " end
		cur_line = cur_line..word

		if first == 0 then
			first = 1
		end
	end

	if #cur_line > 0 then
		add(line_list, cur_line)
	end

	return line_list
end

function is_tbox_done(id)
	for l in all(tbox_messages) do
		if l.id == id then
			return false
		end
	end
	return true
end

function tbox(speaker, message, id)
	local line_len=26

	if #tbox_messages%2==1 then 
		tbox_line(speaker, "")
	end

	local words = words_to_list(message, line_len)
	local lines = words_to_lines(words, line_len)

	for l in all(lines) do
		tbox_line(speaker, l, id)
	end
end

function tbox_line(speaker, l, id)
	local line={speaker=speaker, line=l, animation=0, id=id}
	add(tbox_messages, line)
end

function tbox_interact()
	if btnp(4) and #tbox_messages>0 then
		sfx(61) 

		if #tbox_messages>1 then
			del(tbox_messages, tbox_messages[1])
		end

		del(tbox_messages, tbox_messages[1])
	end
end

function tbox_active()
	if #tbox_messages>0 then
		return true
	else
		return false
	end
end

function tbox_draw()
	if #tbox_messages>0 then 
		rectfill(3, 103, 124, 123, 7) 
		rectfill(5, 106, 122, 121, 1) 
		line(5, 105, 122, 105, 6) 
		line(3, 124, 124, 124, 6) 

		if #tbox_messages[1].speaker>0 then
			local speaker_width=#tbox_messages[1].speaker*4

			if speaker_width>115 then
				speaker_width=115
			end

			rectfill(3, 96, speaker_width+9, 102, 7) 
			rectfill(5, 99, speaker_width+7, 105, 1) 
			line(5, 98, speaker_width+7, 98, 6) 

			print(sub(tbox_messages[1].speaker, 0, 28), 7, 101, 7)
		end

		if tbox_messages[1] != nil and tbox_messages[1].animation<#tbox_messages[1].line then
			sfx(23)
			tbox_messages[1].animation+=1
		elseif tbox_messages[2] != nil and tbox_messages[2].animation<#tbox_messages[2].line then
			sfx(23)
			tbox_messages[2].animation+=1
		end

		print(sub(tbox_messages[1].line, 0, tbox_messages[1].animation), 7, 108, 7) 
		if #tbox_messages>1 then 
			print(sub(tbox_messages[2].line, 0, tbox_messages[2].animation), 7, 115, 7) 
		end

		palt(0,true)
		if global_time%10<5 then
			spr(48, 116, 116)
		else
			spr(48, 116, 117)
		end
		palt(0,false)
	end
end

__gfx__
00000000330000333333333333333333555555555d55555555555555400004445445455444444444000000000221022102110211444422222222444422442422
000000003053350333b3bb333333333355666655d555555d55555555006660044454445444444444052222500022000202220222444444444444444422442422
00700700053333503b3b3b3333333333566666655555555555555555066555044445444444444444022d22200000000000000000222444444444422222442422
00077000033333303333333333333333565555655555555555555555066654504445544544444444022ddd202102210221021102222222222222222222442422
0007700003333330333333333333333356666665d5d555d55555555506555550544444444444444402ddd2202200220022022202222222222222222222442422
0070070003333330b33bb3b3333333335655656555d55555555555550565454045444454444444440222d2200000000000000000222444444444422222442422
00000000053333503b3b3b3b33333333566666655555555d55555555005554404554455444444444052222500021002102110221444444444444444422442422
00000000300440033333333333333333555555555555d55d55555555400000004454544444444444000000000000000000000000444422222222444422442422
00055000222266622266622200000000551cccccccccccc155555555555555553333333355555555500550050000000000000000300000000000000340000004
00045000288877788877788206666660551cccccccccccc135353535454545453333333355555555500550050000000000000000001111111111110000666600
00045000288877788877788206056560511cccccccccccc155555555555555553333333355555555000000000000555dd5550000011111111111111006666660
0001100028887778887778820666666011cccccccccccc1153535353545454543333333355555555055000550005dd6776dd5000044444111144444006666660
011991102822677888766282065605601ccccccccccccc1535353535454545453333333355555555055000550555555555555550044444444444444008666680
1dd19dd1222dd662226dd222066666601ccccccccccccc153333333344444444333333335555555500000000566766d99d667665033994444449933008888880
d006700d53dddddddddddd350000000011cccccccccccc1153535353545454543333333355555555550055005d666d9119d666d5039999999999993008888880
0006700053dddddddddddd357704407751ccccccccccccc133333333444444443333333355555555000000005dd6d9a99a9d6dd5039999999999993008888880
0006700053ddd555555ddd3577777777331cccccccccccc1cccccccc54454454444444444444444400000000ffff6fffffffffff039990000009993008888880
0006700053ddd555555ddd3572277227331cccccccccccc1cccccccc54454454444444444444444404444440fff676fff11fffff039990000009993008888880
0006700053dd55555555dd3528800882311cccccccccccc1cccccccc54454454444444444444444404499990fff676fffdffffff039900000000993008888880
0006700053dd55555555dd350888888011cccccccccccc11cccccccc54454454444444444444444404499440fff676ff4d66666f039900000000993008888880
0006700053dd55555555dd35708888071ccccccccccccc14cccccccc54454454444444444444444404499440fff676ff09777776039900000000993008888880
0006700053dd55555555dd35770880771ccccccccccccc14cccccccc54454454444444444444444409999440f1f676f14d66666f039900000000993040000004
0006700053355555555553357770077711cccccccccccc11cccccccc54454454444444444444444404444440f1dd9dd1fdffffff033300000000333044444444
0000700055555555555555557777777731ccccccccccccc1cccccccc54454454444444444444444400000000fff404fff11fffff000000000000000044444444
7777700055555555cccccccc2888e9aaaaaaaaaaaa9e8882aeaaaaaa77777777ffff5fffffffffff000000000005000050575005757775077777770777777757
0777000055555555cccccccc228e99eaaaaaaaaaae99e822eee9995577000077fff575fff11fffff000000000000000550505007757075077770775777757777
0070000055555555cccccccc2888e9aaaaaaaaaaaa9e8882ae555577705cc507fff575fffdffffff000000000000500055507500777077507775777077777775
0000000055555555cccccccc228e99eaaaaaaaaaae99e822a957777770c66c07fff575ff2d55555f000000005050000075700500777507507777077577775777
0000000055555555cccccccc2888e9aaaaaaaaaaaa9e8882a957777770c66c07fff575ff0d777775000000000000000005000550070507750707577757577777
0000000055555555cccccccc228e99eaaaaaaaaaae99e822a9577777705cc507f1f575f12d55555f000000000500050007050750070757755757777777777777
0000000055555555cccccccc2888e9aaaaaaaaaaaa9e8882a577777777000077f1ddddd1fdffffff000000000000000000050055505750777077707775777577
0000000055555555cccccccc228e99eaaaaaaaaaae99e822a577777777777777fff202fff11fffff000000000000005000055075505770777577757777777777
005777755777750000000000000000006655557777944977773b3b37777777770000000000000000000000000000777777770000000000777777700000007777
05475574470674500606060606060600650660577744447773b3b3b3777707770eeeeeeeeeeeee0eeeeeeee00ee0777777770eeeeeeee00777770eeeeeee0777
0547777447777450065656565656565065666657722222277b35353b7700407700888888888888088888888e0880777777770888888888007770888888888077
05475074475574500656565656565650675665777288882704559553704455077000000088208008800008880880777007770880000088800708880000088807
00566664466665000656565656565650075555777222222704445547705544077777770882080708807770000880770990770880777708880008800777008807
555555555555555506d656d656d656d0055065507755554777744447770400777777708820807708800077770880770aa0770880777770888088807777708880
544444444444444506d6d6d6d6d6d6d0770650777755554777544457777077777777088208077708888007770880700550070880777770888088807777708880
454545454545454406d6d6d6d6d6d6d07440644777077047e82e82e877777777777088208077770888880077088009a55a900880777770888088807777708880
457575757575757406d6d6dadad6d6d0a8aaa8a87777775777722227333333337708820807777708822880770880099009900880777770888088807777708880
46767676767676740656d95ada56d650888a88a8777777577728e882333333337088208077777708800000770880000000000880777770882028807777708820
467676767676767406565acf5c5656508988898877777757772988e2333333330882080777777708807777770880777777770880777708820002800777008207
444444444444444406565a5f5f56565088999a98777777572e888882333333330820800000000708800000070880000000000880000088200702880000088207
45454545454545440656595e5e565650899aaa98777776d62888e882333333330288888888882008888888800888888888820888888882007770288888882077
45656565656565640656565e5e56565089aaaa9877777767777882e2333333330222222222222202222222220222222222200222222220077777022222220777
4767676767676764060606090906060088999988777777677e822887333333330000000000000000000000000000000000000000000000777777700000007777
47676767676767640000000000000000a888888a7777777782272e78333333337777777777777777777777777777777777777777777777777777777777777777
7000600777ffff7706d6d6d6d6d6d6d000000000000000007773b77773bb337773bb337773bb337773bb33777777777777288277772882770000000000000000
076676707ffffff70656d656d656d650060606060606060077733bb7333333773333335733333357333333577777777778822887788228870000000000000000
066070607f4ff4f706565656565656500656565656565650773333333533335735cffc7735cffc7735cffc77777dd77772655627722222270000000000000000
600670067f6ff6f706565656565656500656565656565650773fc33357cffc7757ffff7757ffff7757ffff7777dccd7770555507408228040000000000000000
6777766678f66f870656565656565650065656565656565074b4ff3777ffff774b3345b44b334547743345b4771cc17742000024420000240000000000000000
0600706078866887065656565656565006d656d656d656d07433ffc74b4453b47744537777445377774453777771177770222207702222070000000000000000
076076707f8868f7060606060606060006d6d6d6d6d6d6d0743334f7774334777753337777533377775333777777777777000077770000770000000000000000
7066600777d77d77000000000000000006d6d6d6d6d6d6d077777777777777777747747777777477774777777777777777077077770770770000000000000000
0000000000000000700000077777777777666677774444777557755709999990779aaa7744444444444444440000000075665577756655777566557700000000
0000000000000000004444000000000075000057755665575555555599aaaa9979aa9aa744444444444444440000000055555507555555075555550700000000
0000555dd5550000044444400555555070c00c07756dd657566556659aa77aa97acffca744444444444444440000000050266277502662775026627700000000
0005dd6776dd5000000aa000000000007000000755dccd55566666659a7777a97affffa744444444444444440000000007666677076666770766667700000000
055555555555555004499440044994407705507756dccd65556666559a7777a99eeeeee9444444444444444400000000d655d06dd655d0d77d55d06d00000000
566766d99d6676650e4444e00e4444e000000000566dd665755665579aa77aa9779ee97744444444444444440000000077dd057777dd057777dd057700000000
5d666d9119d666d502eeee2002eeee20aa000d77566666657755557799aaaa9977eeee7744444444444444440000000077055577770555777705557700000000
5dd6d9a99a9d6dd50000000000000000aad0ddd77555555777755777099999907622226744444444444444440000000077d77d7777777d7777d7777700000000
10103030301010101010303042511010101010101010101010303030303030101030303030303010101030303030101010103030303030303030303030304262
6252909090909090909090909090d0d0d0d0707070707090909090907090e0e0a2a2a2a2a2000000000000000000000000000000000000000000000000000000
10103030301010101010303042511010101010101010101030303030303010101010101010103010103030303010101010101075303030303030303030304262
6252909090909090909090909090d0d0d0d0707070707090907070707092e0e0a290f190a2a2a2a2a2a2a2a2a2a2a2a200101010101010101010100000000000
10103030301010101010303042511010101010101010103030303030301010101030303030308110103030303010101010101010303030303030303030304262
2352909090707070707070909090d0d0d0d0707070707090907070707070e0e0a290f290a2a2334353303030334353a200101010101010101010100000000000
10103030303010101010303042511010101010101010303030303030101010101030101010101010103030303010101010101010101010303030303030304262
6252909070707070707070709090d0d0d0d0707090909090909090907070e0e0a2909090a2a2334553303030334553a200101010103030101010100000000000
10101030303030101010303042511010101010101030303030303010101010101030303030303010103030303010101010101010101010103030303030304262
6252909070707070977070709090d0d0d0d0709090909090909090909070e0e0a2a290a2a2a2334353303030334353a200101010303030301010100000000000
10101010303030101010303042511010101010103030303030301010103030301010101010103010101030303030101010101010101010103030303030304262
6252909070707070707070709090d0d0d0d0909090909070709090909090e0e00000000000a2334353303030334353a200101030303030303010100000000000
10101010303030101010303042511010101010303030303030101010303030301030303030303010101030303030101010101010101010103030303030304262
6252909070707090909090909090d0d0d0d0909090907070707090909090e0e0a2a2a2a2a2a2334353303030334353a200101030303030303010100000000000
10101010303030101010303042511010101030303030303010101030303010301030101010101010101030303030101010101010101010103030303030304262
6252909070827090909090909090d0d0d0d0909090707070707070909090e0e0a2606060a2a2334353303030334353a200101030303030303010100000000000
10101010303030101010303042511010101030303030301010101030301010301081303030303010101030303030101010101010101010103030303030304262
6252909070707070707070709090d0d0d0d0909070707070707070709090e0e0a2606060a2a2334353303030334353a200101030303030303010100000000000
10101010303030101010303042511010101030303030301010101030303010301010101010103010103030303010101010101010101010103030303030304262
6252909070707097707070709090d0d0d0d0909070707070707070709090e0e0a2606060a2a2a2a2a2303030a2a2a2a200101030303030303010100000000000
10101010303030101010303042511010101010303030303010101010303010301030303030308110103030303010101010101010101010101030303030304223
6252909070707070707070709090d0d0d0d0909090707070707070909090e0e0a2a260a2a2000000a2303030a200000000101030303030303010100000000000
10101010303030101010303042511010101010103030303030101010303010301030101010101010103030303010101010101010101010101010303030304262
6252909090707070707070909090d0d0d0d0909090907070707090909090e0e00000000000000000000000000000000000101030303030303010100000000000
10101010303030101010303042511010101010101030303030301010303010301081303030303010103030303010101010101010101010101010103030304262
625290909090909090909090907070d0d0d0909090909070709090909090e0e00000000000000000000000000000000000101030303030303010100000000000
10101010303030101010303042511010101010101030303030301010303010301010101010103010101030303030101010101010101010101010103030304262
625270909090909090909090907070d0d0d0709090909090909090909070e0e00010101010303010101010000000000000101030303030303010100000000000
10101010303030101010303042511010101010103030303030101010303010303030303030303010101030303030101010101010101010101010303030304262
62527070909090909090909070707070d0d0707090909090909090907070e0e00010303030303030303010000000000000101030303030303010100000000000
101010303030301010103030425110d1e11010303030303010101010303010101010101010101010101030303030101010101030303030303030303030304262
625270707070709090707070707070707070707070707090907070707070e0e00010303030303030303010000000000000101030303030303010100000000000
101030303030101010103030425130d2e23030303030301010101030303010101010101010101010101030303030101010103030303030303030303030304262
625270707070709090707070707070707070707070707090907070707070e0e00010303030303030303010000000000000101030303030303010100000000000
10103030301010101010303042513030303030303030101010103030301010101010101010101010103030303010101010307530303030303030303030304262
625270707070709090707092709270707070927092707090907070707070e0e00030303030303030303030000000000000101030303030303010100000000000
10103030301010101010303042513030303030303010101010303030101010101010101010101010103030303010101030303030101010101030303030304262
235270709090909090907090709070909070907090709090909090907070e0e00030303030303030303030000000000000101030303030303010100000000000
10103030301010101010303042513030303030301010101030303010101010101010101010101010103030303010101030303010101010101010303030304262
625270909090909090909090909090909090909090909090909090909070e0e00010303030303030303010000000000000101010303030301010100000000000
10103030301010101010303042513030303030101010103030301010101010101010101010101010103030303010101030303010101010101010303030304262
6252709090909090a79090909090909090909090909090a7909090909070e0e00010303030303030303010000000000000101010303030301010100000000000
10103030301010101010303042513030303030101010303030101010101010101010101010101010101030303030101030303010101010101010303030304262
625270909090909090909090909090909090909090909090909090909070e0e00010303030303030303010000000000000101010103030101010100000000000
10103030301010101010303042513030303030101010303010101010101010101010101010101010101030303030101030303010101010101010303030304262
625270909090909040909090909090909090909090909040909090909070e0e00010101010303010101010000000000000101010103030101010100000000000
10103030301010101010303042513030303030301010303010101010101121101010101010101010101030303030101030303010101010101010303030304262
625270909090909090909090909090909090909090909090909090909070e0e00000000000000000000000000000000000000000000000000000000000000000
10103030301010101010303042513030303030303010a21010101010101222101010101010101010101030303030101030303030101010101030303030104262
625270909090909090909090909090909090909090909090909090909070e0e00000000000000000000000000000000000000000000000000000000000000000
10103030301010101010303042513030303030303030303030303030303030303010101010101010103030303030101010303030303030303030303010104262
625270909090909070707070707070707070707070707070909090909070e0e00000000000000000000000000000000000000000000000000000000000000000
10103030303010101030303042513030303030303030303030303030303030303030303030303030303030303030301010103030303030303030301010104262
625270909090909070927092709770707070977092709270909090909070e0e00000000000000000000000000000000000000000000000000000000000000000
10103030303030303030303042513030303030303030303030303030303030303030303030303030303030303030303010101030303030303030101010104262
235270909090909070907090707070909070707090709070909090909070e0e00000000000000000000000000000000000000000000000000000000000000000
10101030303030303030303072723030303030303030303030303030303030303030303030303030303030303030303030303030303030303010101010104262
625270909090909070909090909090909090909090909070909090909070e0e00000000000000000000000000000000000000000000000000000000000000000
10101010303030303030303072723030303030303030303030303030303030303010101010101010103030303030303030303030303030301010101010104262
625270709090909090909090909090909090909090909090909090907070e0e00000000000000000000000000000000000000000000000000000000000000000
10101010101010101010101042511010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010104262
625270707070707070707070707070707070707070707070707070707070e0e00000000000000000000000000000000000000000000000000000000000000000
10101010101010101010101042511010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010104262
625270707070707070707070707070707070707070707070707070707070e0e00000000000000000000000000000000000000000000000000000000000000000
__label__
88888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888
88888888888888888888888888888888888888888888888888888888888888888888888888888888888228228888228822888222822888888822888888ff8888
88888888888888888888888888888888888888888888888888888888888888888888888888888888882288822888222222888222822888882282888888fff888
88888888888888888888888888888888888888888888888888888888888888888888888888888888882288822888282282888222888888228882888888f88888
888888888888888888888888888888888888888888888888888888888888888888888888888888888822888228882222228888882228882288828888fff88888
88888888888888888888888888888888888888888888888888888888888888888888888888888888882288822888822228888228222888882282888ffff88888
88888888888888888888888888888888888888888888888888888888888888888888888888888888888228228888828828888228222888888822888fff888888
88888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888188888888888888888
55555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555551715555555555555555
55555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555551771555555555555555
5555555555555555555555555555555555555555505a5b505555e5050505555f5050505555e5850505555f505850555555555555555551777155555555555555
55555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555551777715555555555555
55555555555555555555555555555555555555556666666665577777777755666666666556666666665566666666655555555555555551771155555555555555
555566656665666566656665666566555555e55565556555655755575757556555655565565556566655655565556555e555555555c555117155555555555555
55556565656556555655655565656565555ee55566656665655777575757556665656665566656566655666566656555ee55555555cc55555155155511115555
5555666566655655565566556655656555eee55565556655655755575557556555655565565556555655655566656555eee5555cccccc5551155155511115555
55556555656556555655655565656565555ee55565666665655757777757556566666565565666565655656666656555ee55555c00cc05511111155511115555
555565556565565556556665656565655555e55565556555655755577757556555655565565556555655655566656555e555555c55c055501100055511115555
55555555555555555555555555555555555555556666666665577777777755666666666556666666665566666666655555555550550555550155555500005555
55555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555055555555555555
55555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555
55555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555
55555555555500000000055555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555
55555666665506660606055555555555555566666555555555555555555555555556666655555555555555555555555555666665555555555555555555555555
55555655565506000606055555555555555565556555555555555555555555555556555655555555555555555555555555655565555555555555555555555555
55555657565506660666055555555555555565556555555555555555555555555556555655555555555555555555555555655565555555555555555555555555
55555655565500060006055555555555555565556555555555555555555555555556555655555555555555555555555555655565555555555555555555555555
55555666665506660006055555555555555566666555555555555555555555555556666655555555555555555555555555666665555555555555555555555555
55555555555500000000055555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555
55555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555
55500000000000000000000000000000550000000000000000000000000000055000000000000000000000000000005500000000000000000000000000000555
55500000000000000000000000000000550555555555555555555555555555055055555555555555555555555555505505555555555555555555555555550555
55507770707066600ee000ccc0000000550555555555555555555555555555055055555555555555555555555555505505555555555555555555555555550555
555070707770006000e000c000000000550555555555555555555555555555055055555555555555555555555555505505555555555555555555555555550555
555077707070666000e000ccc0000000550555555555555555555555555555055055555555555555555555555555505505555555555555555555555555550555
555070707770600000e00000c0000000550555555555555555555555555555055055555555555555555555555555505505555555555555555555555555550555
55507070707066600eee00ccc0002000550555555555555555555555555555055055555555555555555555555555505505555555555555555555555555550555
55500000000000000000000000000000550555555555555555555555555555055055555555555555555555555555505505555555555555555555555555550555
55500000000000000000000000000000550555555555555555555555555555055055555555555555555555555555505505555555555555555555555555550555
55500000000000000000000000000000550555555555555555555555555555055055555555555555555555555555505505555555555555555555555555550555
55507770707066600ee000ccc0000000550555555555555555555555555555055055555555555555555555555555505505555555555555555555555555550555
555070707770006000e000c000000000550555555555555555555555555555055055555555555555555555555555505505555555555555555555555555550555
555077707070666000e000ccc0000000550555555555555555555555555555055055555555555555555555555555505505555555555555555555555555550555
555070707770600000e00000c0000000550555555555555555555555555555055055555555555555555555555555505505555555555555555555555555550555
55507070707066600eee00ccc0002000550555555555555555555555555555055055555555555555555555555555505505555555555555555555555555550555
55500000000000000000000000000000550555555555555555555555555555055055555555555555555555555555505505555555555555555555555555550555
55500000000000000000000000000000550555555555555555555555555555055055555555555555555555555555505505555555555555555555555555550555
55500000000000000000000000000000550555555555555555555555555555055055555555555555555555555555505505555555555555555555555555550555
55507770707066600ee000ccc0000000550555555555555555555555555555055055555555555555555555555555505505555555555555555555555555550555
555070707770006000e000c000000000550555555555555555555555555555055055555555555555555555555555505505555555555555555555555555550555
555077707070666000e000ccc0000000550555555555555555555555555555055055555555555555555555555555505505555555555555555555555555550555
555070707770600000e00000c0000000550555555555555555555555555555055055555555555555555555555555505505555555555555555555555555550555
55507070707066600eee00ccc0002000550555555555555555555555555555055055555555555555555555555555505505555555555555555555555555550555
55500000000000000000000000000000550555555555555555555555555555055055555555555555555555555555505505555555555555555555555555550555
55500000000000000000000000000000550555555555555555555555555555055055555555555555555555555555505505555555555555555555555555550555
55500000000000000000000000000000550555555555555555555555555555055055555555555555555555555555505505555555555555555555555555550555
55507770000066600ee000ccc0000000550555555555555555555555555555055055555555555555555555555555505505555555555555555555555555550555
555070700000006000e000c000000000550555555555555555555555555555055055555555555555555555555555505505555555555555555555555555550555
555077700000666000e000ccc0000000550555555555555555555555555555055055555555555555555555555555505505555555555555555555555555550555
555070700000600000e00000c0000000550555555555555555555555555555055055555555555555555555555555505505555555555555555555555555550555
55507070000066600eee00ccc0002000550555555555555555555555555555055055555555555555555555555555505505555555555555555555555555550555
55500000000000000000000000000000550555555555555555555555555555055055555555555555555555555555505505555555555555555555555555550555
55500000000000000000000000000000550555555555555555555555555555055055555555555555555555555555505505555555555555555555555555550555
55500000000000000000000000000000550555555555555555555555555555055055555555555555555555555555505505555555555555555555555555550555
55507770000066600ee000ccc0000000550555555555555555555555555555055055555555555555555555555555505505555555555555555555555555550555
555070700000006000e000c000000000550555555555555555555555555555055055555555555555555555555555505505555555555555555555555555550555
555077000000666000e000ccc0000000550555555555555555555555555555055055555555555555555555555555505505555555555555555555555555550555
555070700000600000e00000c0000000550555555555555555555555555555055055555555555555555555555555505505555555555555555555555555550555
55507770000066600eee00ccc0002000550555555555555555555555555555055055555555555555555555555555505505555555555555555555555555550555
55500000000000000000000000000000550555555555555555555555555555055055555555555555555555555555505505555555555555555555555555550555
55500000000000000000000000000000550555555555555555555555555555055055555555555555555555555555505505555555555555555555555555550555
55500000000000000000000000000000550555555555555555555555555555055055555555555555555555555555505505555555555555555555555555550555
55507770000066600ee000ccc0000000550555555555555555555555555555055055555555555555555555555555505505555555555555555555555555550555
555070700000006000e000c000000000550555555555555555555555555555055055555555555555555555555555505505555555555555555555555555550555
555077000000666000e000ccc0000000550555555555555555555555555555055055555555555555555555555555505505555555555555555555555555550555
555070700000600000e00000c0000000550555555555555555555555555555055055555555555555555555555555505505555555555555555555555555550555
55507770000066600eee00ccc0002000550555555555555555555555555555055055555555555555555555555555505505555555555555555555555555550555
55500000000000000000000000000000550555555555555555555555555555055055555555555555555555555555505505555555555555555555555555550555
55500000000000000000000000000000550555555555555555555555555555055055555555555555555555555555505505555555555555555555555555550555
55500000000000000000000000000000550555555555555555555555555555055055555555555555555555555555505505555555555555555555555555550555
55507770000066600ee000ccc0000000550555555555555555555555555555055055555555555555555555555555505505555555555555555555555555550555
555070700000006000e000c000000000550555555555555555555555555555055055555555555555555555555555505505555555555555555555555555550555
555077000000666000e000ccc0000000550555555555555555555555555555055055555555555555555555555555505505555555555555555555555555550555
555070700000600000e00000c0000000550555555555555555555555555555055055555555555555555555555555505505555555555555555555555555550555
55507770000066600eee00ccc0002000550555555555555555555555555555055055555555555555555555555555505505555555555555555555555555550555
55500000000000000000000000000000550555555555555555555555555555055055555555555555555555555555505505555555555555555555555555550555
55500000000000000000000000000000550555555555555555555555555555055055555555555555555555555555505505555555555555555555555555550555
55500000000000000000000000000000550555555555555555555555555555055055555555555555555555555555505505555555555555555555555555550555
55507770707066600ee000ccc0000000550555555555555555555555555555055055555555555555555555555555505505555555555555555555555555550555
555070707770006000e000c000000000550555555555555555555555555555055055555555555555555555555555505505555555555555555555555555550555
555077707070666000e000ccc0000000550555555555555555555555555555055055555555555555555555555555505505555555555555555555555555550555
555070707770600000e00000c0000000550555555555555555555555555555055055555555555555555555555555505505555555555555555555555555550555
55507070707066600eee00ccc0002000550555555555555555555555555555055055555555555555555555555555505505555555555555555555555555550555
55500000000000000000000000000000550555555555555555555555555555055055555555555555555555555555505505555555555555555555555555550555
55505050505050505050505050505050550555555555555555555555555555055055555555555555555555555555505505555555555555555555555555550555
55500000000000000000000000000000550555555555555555555555555555055055555555555555555555555555505505555555555555555555555555550555
55507700000066600ee000ccc0000000550555555555555555555555555555055055555555555555555555555555505505555555555555555555555555550555
555070700000006000e000c000000000550555555555555555555555555555055055555555555555555555555555505505555555555555555555555555550555
555070700000066000e000ccc0000000550555555555555555555555555555055055555555555555555555555555505505555555555555555555555555550555
555070700000006000e00000c0000000550555555555555555555555555555055055555555555555555555555555505505555555555555555555555555550555
55507770000066600eee00ccc0002000550555555555555555555555555555055055555555555555555555555555505505555555555555555555555555550555
55500000000000000000000000000000550555555555555555555555555555055055555555555555555555555555505505555555555555555555555555550555
55500000000000000000000000000000550555555555555555555555555555055055555555555555555555555555505505555555555555555555555555550555
55500000000000000000000000000000550555555555555555555555555555055055555555555555555555555555505505555555555555555555555555550555
55507700000066600ee000ccc0000000550555555555555555555555555555055055555555555555555555555555505505555555555555555555555555550555
555070700000006000e000c000000000550555555555555555555555555555055055555555555555555555555555505505555555555555555555555555550555
555070700000066000e000ccc0000000550555555555555555555555555555055055555555555555555555555555505505555555555555555555555555550555
555070700000006000e00000c0000000550555555555555555555555555555055055555555555555555555555555505505555555555555555555555555550555
55507770000066600eee00ccc0002000550555555555555555555555555555055055555555555555555555555555505505555555555555555555555555550555
55500000000000000000000000000000550555555555555555555555555555055055555555555555555555555555505505555555555555555555555555550555
55500000000000000000000000000000550555555555555555555555555555055055555555555555555555555555505505555555555555555555555555550555
55500000000000000000000000000000550555555555555555555555555555055055555555555555555555555555505505555555555555555555555555550555
55507700000066600ee000ccc0000000550555555555555555555555555555055055555555555555555555555555505505555555555555555555555555550555
555070700000006000e000c000000000550555555555555555555555555555055055555555555555555555555555505505555555555555555555555555550555
555070700000066000e000ccc0000000550555555555555555555555555555055055555555555555555555555555505505555555555555555555555555550555
555070700000006000e00000c0000000550555555555555555555555555555055055555555555555555555555555505505555555555555555555555555550555
55507770000066600eee00ccc0002000550555555555555555555555555555055055555555555555555555555555505505555555555555555555555555550555
55500000000000000000000000000000550000000000000000000000000000055000000000000000000000000000005500000000000000000000000000000555
55555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555
55555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555
55555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555
88888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888
88888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888
88888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888
88888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888
88888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888
88888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888
88888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888

__gff__
0002000002000002000002020202020202020202020200008040000000020200020000000202020080200200000000000010080000000000000000000000000002020202000000000000000000000000020202020000002000000000000000000200020202020000000000000000000000000000000000000040100000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__map__
0101010101010101010101012415010101010101010101010101010101010103030101010101010101010101010101010101010104040404040404040404142626150101010101010101010707070d0d0d0d0c0c0c0c0c0c0c0c0c0c0c0c0e0e0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a2a2a2a2a2a2a2a2a2a2a2a2a2a2a2a2a
0101010101010101010101012415010101010101010101010101010101010103030101010101010101010101010101010101010104040404040404040404142626150101010101010101010707070d0d0d0d0c0b0c0c0c0c0c0c0c0c0c0c0e0e0a601a1a1a4243404142431a1a1a600a2a541a1a1a1a1a1a1a1a1a1a1a1a542a
01010101010101010101010124150101010101010101010101010101010101032a0101010101010101010101010101010101010606060606060606060606142626150106063106310631063106070d0d0d0d0c0c0c0c0c0c0c0c0c0b0c0c0e0e0a1a1a1a1a5253505162631a1a1a1a0a2a1a1a1a1a1a1a1a1a1a1a1a1a1a1a2a
0101010101010101010101012415010101010101030303030303030303030303030303030303030303030303010101010101060606060606060606060606142626150606060606060606060606060d0d0d0d0c0c0c0c0c00000c0c0c0c0c0e0e0a1a1a1a1a3334343434351a1a1a1a0a2a1a1a1a1a1a1a1a1a1a1a1a1a1a1a2a
010101010101011d1e0101012415010101010103030303030303030303030303030303030303030303030303030101010101060604040631060604040606142626150606060606060606060606060d0d0d0d0c0c0b0c0c00000c0c0c0b0c0e0e0a1a1a1a1a3334343434351a1a1a1a0a2a1a1a1a1a1a1a1a1a1a1a1a1a1a1a2a
010101010101012d2e0301012415010101010303035703030303030303030303030303030303030303030357030301010101060604040606060604040606142626151919040404040404060606060d0d0d0d0a0a0a0a090909090a0a0a0a0e0e0a1a1a1a1a3334343434351a1a1a1a0a2a1a1a1a1a1a1a1a1a1a1a1a1a1a1a2a
0101010303030303030303032415010101010303030303030101010101010101010101010101010101010303030301010101060606060606060606060606142626150404040419190404040406060d0d0d0d0a0a0a0909090909090a0a0a0e0e0a1a1a1a1a3334343434351a1a1a1a0a2a1a1a1a1a1a1a1a1a1a1a1a1a1a1a2a
0101030303030303030303032415010101010303030303010101010101010101010101010101010103010103030301010101060606060606060606060606272727270606040406060404060606060d0d0d0d0a0a0a0a090909090a0a0a0a0e0e0a1a1a1a1a3334343434351a1a1a1a0a2a1a1a1a1a1a1a1a1a1a1a1a1a1a1a2a
0101030303030303030303032415010101010303030301010103030303030303030303030303030303010103030301010101060604040606310604040606272727270606040606060604060606060d0d0d0d0a0a280a090909090a280a0a0e0e0a1a1a1a1a3334343434351a1a1a1a0a2a1a1a1a1a1a1a1a1a1a1a1a1a1a1a2a
0101010303030303030303032415010101010303030301011803030101010101010101010101010101010303030101010101060604040606060604040606272727270606040406060404060604040d0d0d0d070a0a0a070909070a0a0a070e0e0a1a1a1a1a3334343434351a1a1a1a0a2a1a1a1a1a1a1a1a1a1a1a1a1a1a1a2a
0101010101010303030301012415010101010303030301010103010101010101012a2a2a0101010101010303030101010101060606060606060606060606142626150606040606060604060604040d0d0d0d0707070707090907070707070e0e0a1a1a1a1a3334343434351a1a1a1a0a2a1a1a1a1a1a1a1a1a1a1a1a1a1a1a2a
0101010101010103030101012415010101010303030301010103010101010101012a2a2a0101010101010357030101010101060606060606060606060606142626150606040406060404060606060d0d0d0d2807090909090909090909090e0e0a1a1a1a1a3334343434351a1a1a1a0a2a1a1a1a1a1a1a1a1a1a1a1a1a1a1a2a
0101010101010103030101012415010101010303030301010103010101010101012a2a2a0101010101010303030101010101060604040631060604040606142626150606040606060604060606060d0d0d0d0707090707090909090909090e0e0a1a1a1a1a3334343434351a1a1a1a0a2a1a1a1a1a1a1a1a1a1a1a1a1a1a1a2a
0101010101010103030101012415010101010303030301011803010101010101010101010101010101010103030301010101060604040606060604040606142626150606040406060404040404060d0d0d0d2909090707070707070709090e0e0a1a1a1a1a3334343434351a1a1a1a0a2a1a1a1a1a1a1a1a1a1a1a1a1a1a1a2a
010101010101010303010101241501010101030303030101180301010101012a2a2a012a2a2a010101010103030301010101060606060606060606060606142626150606040606060604040404060d0d0d0d0707070707070707070909090e0e0a1a1a1a1a3334343434351a1a1a1a0a2a541a1a1a1a1a1a1a1a1a1a1a1a542a
010101010101010303010101241501010101030303030101010301010101012a2a2a012a2a2a010101010103570301010101060606060606060606060606142626150606040406060404060606060d0d0d0d2807090909090909090909090e0e0a1a1a1a1a3334343434351a1a1a1a0a2a2a2a2a2a2a2a2a2a2a2a2a2a2a2a2a
010101010101010303010101241501010101030303030101010301010101012a2a2a012a2a2a010101010103030301010101060604040606310604040606142626150606040606060604060606060d0d0d0d0707090707090909090907090e0e0a1a1a1a1a3334343434351a1a1a1a0a00000000000000000000000000000000
0101010101010103030101012415010101010303030301010103030101010101010103010101010101010303030101010101060604040606060604040606142626150606040406060404060604040d0d0d0d2909090707090907070707290e0e0a1a1a1a1a3334343434351a1a1a1a0a00000000000000000000000000000000
0101010101010103030101012415010101010303030301011803030301010303030103030303030303030303030101010101060606060606060606060606142626150606040606060604060604040d0d0d0d0707070707090907070707070e0e0a601a1a1a3334343434351a1a1a600a00000000000000000000000000000000
0101010101010103030101012415010101010303030301010103030303010301030101010101010101010303030101010101060606060606060606060606142626150606040406060404060606060d0d0d0d2807090909090909090909090e0e0a0a0a0a0a0a343434340a0a0a0a0a0a00000000000000000000000000000000
0101010101010303030101012415010101010303030301010103030303030301180303030303030101010303030101010101060604040631060604040606142626150606040606060604060606060d0d0d0d0707090707090909090909090e0e0000000000000000000000000000000000000000000000000000000000000000
0101010101030303030101012415010101010357030301010101030303010101010101010101030101010303030301010101060604040606060604040606142626150606040406060404040404060d0d0d0d2909090707070707070709090e0e0000000000000000000000000000000000000000000000000000000000000000
0101010103030303010101012415010101010303030303010101010303030101010303030303180101010303030301010101060606060606060606060606142626150606040606060604040404060d0d0d0d0707070707070707070909090e0e0000000000000000000000000000000000000000000000000000000000000000
0101010303030301010101012415010101010303030303030101010103030301010301010101010101010303030301010101060606060606060606060606142626150606040406060404060606060d0d0d0d2807090909090909090909090e0e0000000000000000000000000000000000000000000000000000000000000000
0101030303030101010101032415010101010103030303030301010101030303010303030303030101010303030301010101060604040606310604040606142626150606040606060604060606060d0d0d0d0707090707090909090907090e0e0000000000000000000000000000000000000000000000000000000000000000
01010303030101010101012a2415010101010101030303030303010101010357010101010101030101030303030101010101060604040606060604040606142626150606040406060404060604040d0d0d0d2909090707090907070707290e0e0000000000000000000000000000000000000000000000000000000000000000
0101030303010101010103032415010101010101010303030303030101010103010303030303030101030303030101010101060606060606060606060606142626150606040606060604060604040d0d0d0d0707070707090907070707070e0e0000000000000000000000000000000000000000000000000000000000000000
0101030303010101010103032415010101010101010103030303030301010101010301010101010101030303030101010101060606060606060606060606142626150606040406060404060606060d0d0d0d2807090909090909090909090e0e0000000000000000000000000000000000000000000000000000000000000000
0101030303010101010103032415010101010101010101030303030303010101011803030303030101030303030101010101060604040631060604040606142626150606040606060404060606060d0d0d0d0707090909090909090909090e0e0000000000000000000000000000000000000000000000000000000000000000
0101030303010101010103032415010101010101010101010303030303030101010101010101030101010303030301010101060604040606060604040606143226150606040406060404040406060d0d0d0d2909090707070707070709090e0e0000000000000000000000000000000000000000000000000000000000000000
0101030303010101010103032415010101010101010101010103030303030301010303030303030101010303030301010101060606060606060606060606142626150606040606060604040406060d0d0d0d0707070707070707070909090e0e0000000000000000000000000000000000000000000000000000000000000000
0101030303010101010103032415010101010101010101010103030303030301010301010101010101010303030301010101161616161616161616161616142626151717171717171717171717170d0d0d0d0707070707090909090909090e0e0000000000000000000000000000000000000000000000000000000000000000
__sfx__
012000002e0302e0302e0302e0302e03029045290452e0302c0302a0302c0302c0302c0302c0302c0302c0302e0302e0302e0302e0302e0302a0452a0452e0302d0302b0302d0302d0302d0302d0302d0302d030
0120000016050160501d0501d0502205022050220502205014050140501b0501b05020050200502005020050120501205019050190501e0501e0501e0501e050110501105018050180501d0501d0501d0501d050
011000001d0501d0001d050160501d0501d0001d050160501d0501d0001d050160501d050160501d050160501d0501d0001d050160501d0501d0001d050160501d0501d0001d050160501d050160501d05016050
01100000160551d0051605516055160551d0051605516055160551d000160551605516055160551605516055160551d0001605516055160551d0051605516055160551d005160551605516055160551605516055
01100000220502205022050220501d0501d0501d0501d0501d0501d00022070220002207024070260702707029050290502905029050220502405026050270502905029050290502905029050290502905029050
011000001d0501d0001d050160501d0501d0001d050160501d0501d0001d050160501d050160501d050160501b0501d0001407514075140751d0051407514075140751d0001b050140501b050140501b05014050
01100000190501d0001905012050190501d0001905012050190501d000190501205019050120501905012050180501d0001107511075110751d0051107511075110751d000180501105018050110501805011050
011000001605000000160751607516075000001607516075160750000016075160751607500000160751607514050000001407514075140750000014075140751407500005140751407514075000001407514075
011000001205012000120751207512075000001207512075120750000012075120751207500000120751207519050000001907519075190750000019075190751907500005190751907519075000001907519075
011000001705012000170751707517075000001707517075170750000017075170751707500000170751707516050000001607516075160750000016075160751607500005160751607516075000001607516075
01100000180501200018075180751807500000180751807518075000001807518075180750000018075180751d050000001107511075110750000011075110751107500005110751107511075000001307515075
011000001205012000120751207512075000001207512075120750000012075120751207500000120751207511050000001107511075110750000011075110751107500005110751107511075000001107511075
011000001005012000100751007510075000001007510075100750000010075100751007500000100751007511050000001107511075110750000011075110751107500005110751107511075000001107511075
01100000220502205022050220501d0501d0501d0501d0501d0501d000220701d0002207024070260702707029050290502905029050220502405026050270502905029050290502900029050290502a0502c050
011000002e0502e0502e0502e0502e0502e0502e0502e0502e0002e0002e0702e0002e0702e0702c0702a0702c0502c0502c0502a050290502905029050290502905029050290002900029050290502905029050
01100000270502700027050290502a0502a0502a0502a0502a0502a0502a0002a0002905029050270502705025050250002505027050290502905029050290502905029050290002900027050270502505025050
01100000240502400024050260502805028050280502805028050280502a0002a0002b0502b0502b0502b05029050190001d0751d0751d0751d0001d0751d0751d0751d0001d0751d0751d0751d0001d0501d050
011000002e0502e0502e0502e0502e0502e0502e0502e0502e0502e0502e0502e05031050310503105031050300503005030050300502c0502c0502c0502c0502c0502c0502c0502c05029050290502905029050
01100000100501005016050190501c0501c0502205025050280502805028050280502e0502e0502e0502e0502d0502d0502d0502d050290502905029050290502905029050290002900029050290502905029050
011000002705027050270502705027050270502705027050270502705027050270502a0502a0502a0502a05029050290502905029050250502505025050250502505025050250502505022050220502205022050
011000002e0002e0002e0002e0002e0002e0002e0002e0002e0002e0002e0002e000310003100031000310001d0701d0001d0751d070210701500021070240701800024070210701500021075210702105021030
011000002e0002e0002c0002c0002e0002e00029000290002e0002e000300003000031000310003000030000002430a600006302c600306352e6000024329600002430a600006302c600306352e6000024329600
010c00001865318667186771865718665186771865718667186771865518667186771865718667186751865718667186771865718665186771865718667186771865518667186771865718647186371862718617
010300003072316203132000f200082051d4000a2032c0000a203080000a600080002e305080000a2032c000082030700008600070002c305080000820307000082030700008600070002c305080000820307000
011000002e0302e0302e0302e0302905029050290502905035030350303503035030290502905029050290502c0302c0302c0302c030270502705027050270503303033030330303303027050270502705027050
0110000022030220302203022030190501905019050190501d0301d0301d0301d03022050220502205022050210302103021030210301d0501d0501d0501d050290302903029030290301d0501d0501d0501d050
01100000002430a600006302c600306352e6000024329600002430a600006302c600306352e6000024329600002430a600006302c600306352e6000024329600002430a600006302c600306352e6000024329600
011000001c0501c05028060280601c0501c05028050280501c0501c05028060280601c0501c05028050280501d0501d05029060290601d0501d05029050290501d0501d05029060290601d0501d0502905029050
01100000280501c0002805034000280501c0002805034000340301c0002805034000280501c000280503400029050350002905035000290503500029050350003503035000290503500029050350002905035000
01100000330303303033030330302e0302e0302e0302e030360303603036030360303603036030360203601019070190701907019070160701607016070160701d0701d0701d0701d0701d0501d0401d0301d020
011000002405024050240502405024050240502405024050210402104021040210402104021030210202101027005270052b005270052b0052b00527005270051b00526005240052500526005200052300524005
01100000002430a600006302c600306352e6000024329600002430a600006302c600306352e6000024329600002030a600006002c600306052e6000020329600002030a600006002c600306052e6000020329600
01100000220502205022050220501d0002200022050220501d0501d0501d0501d0501d0001d0001d0501d0501e0501e0501e0501e0501d0001d0001e0501e0501d0501d0501d0501d0501d0001d0001d0501d050
01100000220502205022050220501d0501d0501d0501d0501e0501e0501e0501e0501e0001e0001d0501d050220502205522050220501e0001e0001d0501d0501e0501e0501e0501e0501d0501d0501d0501d050
011000002205022050220502205024050240502405024050250502505025050250502705027050270502705029050290552905029050250002500027050270502a0502a0502a0502a05029050290502905029050
011000000a1400a1400a1400a1400a1400a1400a1400a1400d1400d1400d1400d1400d1400d1400d1400d14011140111401114011140111401114011140111400514005140051400514005140051400514005140
011000002212022120221202212024120241202412024120251202512025120251202712027120271202712029120291252912029120251002510027120271202a1202a1202a1202a12029120291202912029120
01100000221302213022130221301d1002210022130221301d1301d1301d1301d1301d1001d1001d1301d1301e1301e1301e1301e1301d1001d1001e1301e1301d1301d1301d1301d1301d1001d1001d1301d130
012000001b0551b0051f05521055210052305523005210551f0551a0551a0051f0552105522055210551f05527055270052b0552d0552d0052f0552f0052d0552b0553205532005320552f055300553000532055
012000001b0751b0051f0051b0751f0051f0051b0051b0751b0050e07518005190050e07520005230052400527075270052b005270752b0052b00527005270751b00526075240052500526075200052300524005
01200000221402214022140211402314023140231402214026140261402614025140281402814028140281402514025140251402414026140261402614025140291402914029140281402b1402b1402b1402b140
01200000271402714027140271402614026140261402614029140291402914029140281402814028140281402b1402b1402a1402a1402d1402d1402c1402c1402f1402f1402f1402f1402f1402f1402f1402f140
012000000063000330073400734000630003300734007340006300033007340073400033000330073400734000630003300734007340006300033007340073400063000330073400734000330003300734007340
012000003313033130331303313032130321303213032130351303513035130351303413034130341303413037130371303613036130391303913038130381303b1303b1303b1303b1303b1303b1303b1303b130
0120000016040190401d0402204025040220401d0401904016040190401d0402204025040220401d04019040190401d04022040250402904025040220401d04025040290402e0403104035040310402e04029040
012000002b1751f1452414528145271451f1452f145231452d17524145281452d1452b1452414526145281452d17524145291452d1452c145241452614529145281751f145241452814526145211452314526145
01200000183551f335133351f335173351f335133351f335183551f335133351f33518335183351a3351c3351d3552433518335243351d3352433518335243351c35524335133351f33517335133351533517335
012000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000133551535517355
012000002b1512b1502b1502815027150271532f1502f1502d1502d1502d1502d1502b1502b1502b1502b1502d1502d1502d1502f150321503215030150301502b1502b1522b1502815026150261502615026150
012000000c6250c6050c6250c605186450c6050c6250c6050c6250c6050c6250c605186450c6050c6250c6050c6250c6050c62518605186450c6050c6250c6050c6250c6050c6250c605186450c6050c6250c605
012000003735037350373003425633350333502f2503b2503935039350393002d3503725037250372502b2503935039350393003b2503e3503e3503c250302503735037350373003425032350323503235037200
01200000182551f250132551f250172551f250132551f250183551f350133551f35018355183501a3551c3501d2552425018255242501d2552425018255242501c45524450134551f45017455134501545517450
012000002b3502b35037300282562735027350232502f2502d3502d35039300213502b2502b2502b2501f2502d3502d350393002f250323503235030250323503425034250342503425034300343002817528175
012000002615026150241502415024150241502f1502d1502b1502b1502b150281502d1502d15028150281502615028150291502a1502b1502b1503415034150301503015030150301003c35037350393503b350
01200000183551f350133551f350173551f350133551f350183551f350133551f35018355183501a3551c3501d3552435018355243501c3552435018355243501c3552835023355283501c355283502335528350
012000001c3552433518335243351c335243351c3351a335183551f335133351f335193351333515335133351a3551c3351d3351e3351f335133351533517335183301833018330180003c30037300393003b300
012000002615026150241502415024150241502f1502d1502b1502b1502b150281502d1502d15028150281502615028150291502a1502b1502b150281502815024150241502415018000241451f1452114523145
010c000027150261502515024150261502515024150231502515024150231502215024150231502215021150231502215021150201501f1501e1501d1501d1501d1501d1501d1501d1501d1501d1501d10011000
012000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000010350103500c65500000
000400000000004450064500845008450034500145004400044000140001400014000445006450084500845003450000000000000000044500745006450024500000000000054500745005450024500000000000
010100002517125171221711d17119151161511517114171141711517116151171511717116171151710f17109151061510417102171011710117101151011510115101151001010010100101001000010000100
01050000245402c0002c0000210000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
010800002415224162241722410524175241002417524100221552410024150241502415024150241502415124150241402413024125181001810000100001000010000000000000000000000000000000000000
011000002b1502a150271502115020154281502c15030150007040070100002000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__music__
01 00014344
00 03024344
00 04054344
00 04064344
00 0d074344
00 0e084344
00 0f094344
00 100a1415
00 0d07181a
00 110b191a
00 120c1b1a
00 120c1c1a
00 13091d1a
02 100a1e1f
01 205f4347
00 21615a0b
00 2265620c
00 20656244
00 04056245
00 04066246
00 0d076247
00 0e086248
00 0f215856
00 2223634b
00 04054344
00 04064344
00 0d075d56
00 0e084344
00 0f094956
00 10240a64
00 2523445f
00 0d07651a
00 0e08431a
00 0f09491a
00 100a141f
00 0d07435a
00 110b435a
00 120c4344
00 120c1a54
00 13091a20
02 100a4323
00 39424344
03 2d6f4344
00 396e4344
01 2d2f4344
00 2d2e4344
00 302e3144
00 33323144
00 36343144
00 3735313a
00 3332317a
00 3634317a
02 3837717a
01 28785444
02 29787954
01 282a4344
00 29792a44
00 28312a44
00 2b312a44
00 28312a2c
00 28292a2b
00 28312c6b
02 28296c6b
03 26274344

