-- draws how many power orbs have been collected.
function draw_power_orbs(x, y)
	-- hearts on right of screen
	draw_to_screen(55, x-1, y-1)
	print(power_orb_count, x+8, y+1, 7)
end

-- draws the various items that have been collected so far.
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

	-- may have multiple fairies.
	for i=0, pl.has_fairy-1, 1 do
		add(stats, 117)
	end

	-- draw items to the screen
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

-- a utility function for drawing actors to the screen. auto offsets and
-- assumes white is the default background color.
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
	local col = 10 --global_time / 60 % 16
	if global_time % 120 == 0 then
		rnd_x = flr(rnd(6))
		rnd_y = flr(rnd(4))
	end

	viewx = 16 * rnd_x + 8
	viewy = 16 * rnd_y + 8

	map(viewx - 8, viewy - 8, 0,0,16,16)

	draw_things()

	-- draw the title
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


-- fades the game to black then prints game over.
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


-- draws the hearts, but from the right.
function draw_hearts(x, y)
	-- hearts on right of screen
	for i=0, pl.hearts-1, 1 do
		draw_to_screen(35, x-8*(i+1), y-1)
	end
end

function scene_draw()
	-- the marker variable is for the transitions.
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
	else -- assume lost woods
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
		--draw_triggers() -- debugging
		--print(marker, 50, 2, 7)
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

-- call to start a transition.
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

-- returns true if it is at least halfway done.
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

-- a transition effect. returns true if it is at least halfway done.
function screen_swipe(length, timer)
	-- only want to go in a half circle.
	local pos = 128 * sin(timer / length / 2 + .5)

	if timer > length / 2 then
		rectfill(128-pos,-1,129,129,0)
	else
		rectfill(-1,-1,pos,129,0)
	end

	return timer >= flr(length / 2)
end
