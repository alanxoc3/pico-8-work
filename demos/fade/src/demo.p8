function _init()
	gen_cipher()
	tl_init({
		{ u_fade, d_fade,    5 },
		{ nil,   draw_rects, 1, switchdir },
		{ u_fade, d_fade,    5 },
		{ nil,   draw_rects, 1, switchfade },
	})

	palt(0, false)
	g_ft = -1

	fade_strs = {}
	add(fade_strs, gen_fade_str(0,  0, 16))
	add(fade_strs, gen_fade_str(16, 0, 16))
	add(fade_strs, gen_fade_str(32, 0, 16))

	for k,v in pairs(fade_strs) do
		printh('-- fade #'..k..'\ngen_fade("'..v..'")\n')
	end

	fade_tabs = {}
	for x in all(fade_strs) do
		add(fade_tabs, gen_fade(x, 16))
	end
end

function _update60()
	tl_update()
end

function _draw()
	cls()

	tl_draw()
	if g_ft then print(g_ft, 0, 0, 7) end

	print('console output has fades', 0, 6, 7)
end

function draw_rects()
	for i=0,3 do
		for j=0,3 do
			rectfill(j*32, i*32, j*32+32, i*32+32, i*4 + j)
		end
	end
end

function u_fade() g_ft += g_fade_spd end 
function d_fade() fade(fade_tabs[g_cur_fade], g_ft, 16) draw_rects() end 

g_fade_spd = .3/60
function switchdir()
	g_fade_spd = -g_fade_spd
end

g_cur_fade = 1
function switchfade()
	g_cur_fade = g_cur_fade % #fade_tabs + 1
	switchdir()
end
