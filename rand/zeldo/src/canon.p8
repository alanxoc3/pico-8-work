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
			music(55) -- play actual canon music!
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
			-- canon was hit
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
			-- go through cannon for second stage.
			actor.touchable=false
			stage.move_to_state("tocenter")
		end
	end)

	-- slightly different from other stage's stun.
	stage.states["stunned"] = make_state(
	function(actor, stage, timer)
		if timer == 0 then
			gen_skellies_in_corners()
			stage.vulnerable = true
		elseif timer >= 60 then
			stage.move_to_state("tocenter")
			stage.vulnerable = false
		else
			-- canon was hit.
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

		-- if reached the center
		if actor.x < mid_x + 2 and actor.x > mid_x - 2 and actor.y < mid_y + 2 and actor.y > mid_y - 2 then
			stage.move_to_state("circle")
		end
	end)

	stage.states["circle"] = make_state(
	function(actor, stage, timer)
		if timer == 0 then
			-- either move clockwise or counter.
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

-- this is the stage that he is defeated.
function make_canon_stage3()
	local stage = make_stage()
	stage.lives = 1
	-- no hit nor hurt functions.

	stage.states["begin"] = make_state(
	function(actor, stage, timer)
		shake()
		if timer == 0 then
			-- be able to touch our friend.
			actor.touchable=true
			music(-1)
			sfx(22)
		elseif timer > 90 then
			stage.lives = 0
		end
	end)

	return stage
end

-- a utility function, canondwarf's hit function
function canondwarf_hit(other, stage, state)
	if other.id == "ball" and other.good then
		stage.move_to_state("stunned")
	end
end

-- a utility function that generates four skeletons in the boss room.
function gen_skellies_in_corners()
	gen_skelly(98.5, 17.5)
	gen_skelly(109.5, 17.5)
	gen_skelly(109.5, 2.5)
	gen_skelly(98.5, 2.5)
end

-- utility function. parameter is the actor to shoot from.
function shoot_ball_to_pl(actor)
	local ball = gen_energy_ball(actor.x,actor.y, 0, 0)
	move_to_player(ball, .3)
end

--- TEMPORARY THINGS THAT determine canon being killed.
function canon_kill(bad)
	music(-1)

	bad.bad = false

	-- canon isn't bad now, no need to re-add him after enemies are cleaned.
	clean_enemies()

	-- get rid of the cage.
	mset(101, 2, 98)
	mset(102, 2, 99)

	-- set locations
	bad.x = 104
	bad.y = 3.5
	pl.x = 103
	pl.y = 4.5

	-- make zelda
	gen_zeldo(102, 3.5)

	-- make it look like they didn't just teleport. heh.
	transition(marker)

	tbox("canondwarf:you beat me. that hurt.|zeldo:lank, why did you beat up canondwarf?:we were just about to have a tea party.|canondwarf:yeah, and he messed up my organ playing.|zeldo:you know what lank, i don't like you any more.:so... die!")
end
