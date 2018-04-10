function _init()
end

function _update60()
end

function _draw()
	cls()
	print('pico project!', 20, 20, 7)
end

function make_triggers()
	-- trigger positions
	--           name             x1    y1     x2    y2
	local trigs = {
		{"no_sword","7,11,9,13"},
		{"steal","97,39,100,42"},
		{"hut_start","97,33,100,36"},
		{"mast_intro","115,37,121,41"},
		{"hut_enter","7,4.5,9,5.5","hut","98.5,36.5,63,-1"},
		{"old_enter","15,47.5,17,48.5","old","98.5,42.5,63,-1"},
		{"shop_enter","29,55.5,31,56.5","shop","106.5,42.5,63,-1"},
		{"hut_exit","97,37,100,38","overworld","8,5.5,14,-1"},
		{"old_exit","97,43,100,44","overworld","16,48.5,14,-1"},
		{"shop_exit","104,43,109,44","overworld","29.5,56.5,14,-1"},
		{"sacred_exit","116,55,120,56","overworld","32.5,1.5,14,-1"},
		{"enemies_spawn","86,5,90,9"},
		{"more_spawn","29,3,35,6"},
		{"canon_intro","97,1,111,8"},
		{"canon_resume","97,1,111,8"},
		{"boss_enter","87,3,89,4.5","boss","104,19.5,53,-1"},
		{"boss_exit","101,20,107,21","overworld","88,4.5,14,-1"}

	}

	foreach(trigs, make_trigger)
end


