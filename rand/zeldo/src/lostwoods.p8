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

-- returns the list of path directions.
function make_lost_path(path_len)
	-- can't have a path that allows you to go right then left.
	-- if 0 then 0 or 1. if 2 then 1 or 2.
	local lost_woods_path = {}
	local prev_num = 1

	for i=1, path_len-1 do
		local new_num = 1

		if prev_num == 0 then
			new_num = flr(rnd(2))
		elseif prev_num == 1 then
			new_num = flr(rnd(3))
		else -- must be 2
			new_num = flr(rnd(2)) + 1
		end
			
		add(lost_woods_path, new_num)
		prev_num = new_num
	end

	add(lost_woods_path, 1)
	return lost_woods_path
end

-- a utility function to make a trigger in one of the three lost woods directions
-- used in make_wrong_exit, make_right_exit, and make_final_exit.
-- 0 = left, 1 = up, 2 = right
function make_lost_dir_trigger(str, dir)
	if dir == 0 then
		make_trigger(str, 96, 48, 97, 52, {x=106.5, y=50})
	elseif dir == 1 then
		make_trigger(str, 100, 44, 104, 45, {x=102, y=54.5})
	else -- dir is 2
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

-- pass in true to make the room active, or false to make it inactive.
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

-- switches the triggers. if either are 0, then nothing happens for that one.
function switch_lost_room(cur_num, nxt_num)
	toggle_lost_room(cur_num, false)
	toggle_lost_room(nxt_num, true)
	marker = get_lost_name(nxt_num)
end

-- there are only two wrongs. 1 and 2.
function make_wrong_exits(path_num, dir1, dir2)
	local str1 = get_lost_wrong1_name(path_num)
	local str2 = get_lost_wrong2_name(path_num)

	make_lost_dir_trigger(str1, dir1)
	make_lost_dir_trigger(str2, dir2)

	local reset_func=
		function()
			-- go to the first lost room.
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
			-- go to next room
			switch_lost_room(path_num, path_num+1)
		end
end

function make_final_exit(path_num, dir)
	local str = get_lost_right_name(path_num)
	make_lost_dir_trigger(str, dir)
	triggers[str].pos = {x=118,y=54.5}

	triggers[str].func =
		function()
			-- get rid of last one and enable first one.
			toggle_lost_room(path_num, false)
			toggle_lost_room(1, true)
			transition("sacred")
			sfx(63)
		end
end

-- assumes the items in lost woods path are a 0, 1, or 2
function lost_woods_triggers(lost_woods_path)
	local str_exit = "lost_woods_exit"
	make_trigger(str_exit, 100,  55, 104,  56, {x=32, y=1.5})
	triggers[str_exit].func =
		function()
			toggle_lost_room_str(marker, false)
			toggle_lost_room(1, true)
			transition("overworld", 14, -1) -- -1 will play no sound.
		end

	-- the keys are indexes like an array
	for k,v in pairs(lost_woods_path) do
		if k == #lost_woods_path then
			make_final_exit(k, v)
		else
			make_right_exit(k, v)
		end

		make_wrong_exits(k, (v+1)%3, (v+2)%3)
	end

	toggle_lost_room(1, true) -- make the first lost room enabled at the start.
end
