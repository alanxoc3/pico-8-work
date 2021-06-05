--- tokens: 380
function game_load_view(w1, h1, w2, h2)
	load_view(w1, h1, w2, h2, 4, 10)
	center_view(g_pl.x, g_pl.y)
end

function game_update_view()
	update_view(g_pl.x, g_pl.y)
end

function field_tbox()
	tbox(":now what?:where am i?")
end

function sky_tbox()
	tbox(":hmmm... odd.:i must be dreaming.")
end

function giveup_tbox()
	tbox(":i give up.:what's the point of trying?:why am i alone?:even in my dreams, i'm alone.:i can't take it anymore!!!:when will this dream end?:how can i rest when there are so many things wrong with this world?:can i do anything to feel peace this christmas?")
	g_pl.y = 0
end

function tbox_active_next()
	if not tbox_active() then
		g_tl_next()
	end
end

function init_church_fam()
	g_family = true
	init_pl(g_sleep_x, g_sleep_y, g_sleep_vx, g_sleep_vy, 2)
	tbox(":...:......:mom?:dad?:brother?:other brother?:other other brother?:sister???????:you're all here!!")
	game_load_view(0, 0, 16, 16*2)
end

function init_church_fam2()
	init_pl(8, 8, 0, 0, 3)
end

function scene_sleep_init()
	tbox(":i'll take a seat.:i'm feeling a bit sleepy.")

	g_sleep_dir = 1
	if g_pl.x > 4.5 and g_pl.x < 8 then
		g_sleep_dir = -1
	elseif g_pl.x > 11.5 then
		g_sleep_dir = -1
	end
end

function scene_sleep_input()
	pl_input(g_sleep_dir == -1, g_sleep_dir == 1, false, false)
end

function scene_sleep()
	-- go to 4.5 or 11.5 to sleep.
	update_pl(scene_sleep_input, scene_sleep_collision)
	game_update_view()
end

function scene_sleep_collision()
	local x, y, hs, vs = g_pl.x, g_pl.y, g_pl.hs, g_pl.vs

	if is_containing(x, y, 0, 0, 4.25, 10, 4.75, 14) or
		is_containing(x, y, 0, 0, 11.25, 10, 11.75, 14)
		then
		g_pl.face = 2
		g_tl_next()
	end

	return x, y, hs, vs
end

function scene_sleep_tbox()
	tbox(":...:......:zzzzzzz...")
	g_sleep_x = g_pl.x
	g_sleep_y = g_pl.y

	g_sleep_vx = g_x
	g_sleep_vy = g_y
end

function sleep_tbox_end()
	if not tbox_active() then
		g_tl_next()
	end
end

-- move view, then beam, then angel, then hill
function sky_tran_1()
	g_y += .05
	if g_y > 54 then
		g_y = 54
		g_tl_next()
	end
end

function sky_tran_2()
	g_pillar_w += .05
	if g_pillar_w > 4 then
		g_pillar_w = 4
		g_tl_next()
	end
end

function sky_tran_3()
	g_angel_y += .05
	if g_angel_y > 64 then
		g_angel_y = 64
		g_angel_spr = 144
		g_tl_next()
	end
end

function sky_tran_4()
	g_pillar_w -= .2
	if g_pillar_w < 0 then
		g_pillar_w = 0
	end

	g_angel_y -= .5
	if g_angel_y < 52 then
		g_angel_y = 52
	end

	g_moon_y -= .01
	g_hill_y -= .02

	if g_hill_y < 64 and g_moon_y < 56.5 then
		g_hill_y = 64
		g_moon_y = 56.5
		g_tl_next()
	end
end
