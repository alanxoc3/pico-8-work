-- difference between bosses and enemies are stages. bosses use stages to
-- manage complexity.

-- make sure to add stages, states, and defeated function
function gen_boss(x, y)
	local bad = gen_enemy(x, y)
	bad.killed = false
	bad.cur_stage = 1
	bad.defeated = function() end
	bad.stages = {}

	-- hit based on
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

			-- move to next stage when this stage is defeated.
			if stage.lives <= 0 then
				bad.cur_stage += 1

				-- die when out of stages.
				if bad.stages[bad.cur_stage] == nil then
					-- don't call this function again and kill boss.
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

-- be sure to set the lives, hit func, and hurt func.
function make_stage()
	local stage = {}
	stage.states = {}
	stage.cur_state = "begin"
	stage.lives = 1
	stage.vulnerable = false
	stage.timer = 0
	stage.hit_func  = function(self, other, stage, state) end
	stage.hurt_func = function(self, other, stage, state) end

	-- use this function to move to different states, instead of manually
	-- setting cur_state.
	stage.move_to_state =
	function(state)
		-- need to reset the timer if being reused.
		stage.states[state].timer = 0
		stage.cur_state = state
	end

	return stage
end
