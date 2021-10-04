-- global var table
_g = {}

-- emotion colors
_g.c_color_normal   = 13
_g.c_color_insane_1 = 3
_g.c_color_insane_2 = 9
_g.c_color_insane_3 = 12
_g.c_color_angry    = 8

-- other colors
_g.c_color_blood = 8

-- config stuff
_g.c_is_patient = false
_g.c_pl_health = 1
_g.c_enemy_health = 1
_g.c_enable_procgen_map = false
_g.c_when_to_show_tip = 1

function get_normal_map_enemies()
    return {
        {8 ,6,"nurse"},
        {10,6,"nurse"},
	{4,28,"nurse"},
	{14,26,"nurse"},
	{45,28,"nurse"},
	{53,9,"nurse"},
	{70,13,"nurse"},
	{60,15,"nurse"},
	{48,3,"nurse"},
	{81,4,"nurse"},
	{81,15,"nurse"},
	{18,13,"nurse"},

        {12,6,"pl_monster_cpu"}
    }
end
