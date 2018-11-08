thief_trig = false
monster_near = false
more_monster = false

function make_triggers()
	-- trigger positions
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
					tbox("ivan@spawn:hey, listen! i think monsters are near.")
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
					tbox("ivan@moresp:watch out! your sword is attracting more monsters.")
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
			tbox("ivan:yes. lank, once you wield this, you can finally defeat canondwarf. haha!|lank:wow, i think i can do this.")
			triggers["mast_intro"].active=false
		end

	triggers["hut_start"].func =
		function()
			tbox("ivan:hey! listen!:wake up lank.|lank:...|ivan:lank, princess zeldo is being held captive by canondwarf! you gotta rescue her!|lank:who are you?|ivan:i'm your fairy.|lank:oh, okay.")
			triggers["hut_start"].active=false
		end

	triggers["steal"].func =
		function()
			tbox("ivan:look! it's a chest. try pressing z near it.|lank:but it's not mine..|ivan:nevermind that. you're just borrowing it.|lank:well, i guess i could give it back later.")
			triggers["steal"].active=false
		end

	triggers["no_sword"].func =
		function()
			tbox("ivan:hey, listen! you don't have a sword yet! how can you save zeldo like this?")
			triggers["no_sword"].active=false
		end
end

-- sets up the game and player, but not the various objects that are scene
-- specific.
function init_game()
	actors = {}
	pl = gen_link(8, 8)
	gen_grass()
end

-- gets called whenever the scene switches.
function scene_init()
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

