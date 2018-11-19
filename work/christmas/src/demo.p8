--- tokens: 640
function gen_tran_for_timeline_half(fade_func, len, d1)
	return gen_tran_for_timeline(fade_func, len, d1, nil, nil, len / 2)
end

function g_tl_next(num)
	tl_next(g_tl, num)
end

-- game demo!
function _init()
	palt(0, false)
	palt(14, true)

	-- for testing
	init_church()
	g_sleep_x, g_sleep_y, g_sleep_vx, g_sleep_vy = 8, 8, 0, 0

	init_particles({ g_snow, g_rain })
	gen_cipher()

	g_title_string = img_x(">x>x>x>x>x>x>x>x>x>x>xhxk8>x>xxm8>x.xm82>x<xh8g2h821>x<xh8g1h81>x<xh82gxh8>x.xn8>x.xq8hxk8>x[x2m8g2q8>x(x1k2821s8>x(xk121k8j2i8>x?x1j8g2j1i8>x?xj82g1jx2h8>x}xi8g21lx1h8>x{xj8g1nxg82hxg8>x&xj82pxg21xj8>x^xj81pxg1xj82pxh8>xpxj82sxi8g21pxh8>xpxj81sxh82g1qxg82px8<xk8txj8jx8gxh8gxg21hxg8jxh8,xj82sxl8hxm8xg8hxi8hxi8ixg8gxh8gxg8ixk8ixi8mxj81sxm8gxp8gxk8xk8xi8xi8xi8gxm8gxk8lxj8txh8g2h8gxj8h2h8gxh8282x2i82x2q82xm82xk82lxj8sxi81i8gxh8g2g1i8gxi821x1h821xn82h81h8g2h821xi8g21lxj8sxh82xh82gxh8g1gxh82gx2i8gxh821gxi82h82i8xh8g1h81gx2i81mxk8rxh81xh81xi8hxi81gx12i8xh81hxh821h81h82h82gxh8hx12i8mx2j8oxk8xi8xi82hxh82m82i8xk81i8xh81h81xi8hxl8lx1k8mxl8xj82h81gxj8g2j821j8g2i8xh82x@82mx2k8jxi8g2g82xg28g21g82hx2h82g12h821x2h82g12g82xg821xh8g2h8g2g8g2k8g21mx12r82g1g21xg12g1xg21hx1h21gx1h21gx1h21gx1g21xg21gxh2g1h2g1g2g1k2g1ox12p821gxg1ix1hxg1jxh1ixh1ixh1ixg1gxi8xh1gxh1gxg1gxk1rx1g2l8g21,xn8}xg1l2g1,xp8vxh8txl1.x2j82i8vxh8>x!x1i821i8ox8kxh8>x!xj81xi8nxg8gxm8>xyxj82xj8xh8jxg8gx2l8>xyxj81j82j8hxh8gx12h8h2>xwxp82k8hxh8hx1h8h1>xwxo82h82h8gxi8hxi8>xzxo821k82gxi8hxh82>xyxm8h21l81xj8gxi81>xyxi82i8g1xk82xk8gxh82x8>xwxi812i8gxi8g21h82h8xi81g8>xwxi8x1i8gx2r8xi8xg8>xwxh82gx2h8gx1w8x82>xwx2g81gx12g8hx2i8i2i82j821>xwx1g2ix1g2hx1i2i1i21j21>xzxg1jxg1ixi1ixi1xj1>x>x>x>x#x")

	-- black fade
	g_fade0 = gen_fade("000000000000000011111111100000002222221111000000333333311110000044442222111100005555551111110000666dddddd5511100776666dddd55111088888222522110009999444454551000aaa999ddd5555100bbbb333dddd11100ccccccddd1111100dddd555551111000eeeed44455111100fff6ddddd5551110")

	-- white fade
	g_fade7 = gen_fade("0011555ddd6666771155ddddd666667722255ddd666667773333dddd6666677744449999fffff7775555ddd666666777666666667777777777777777777777778888eeeeeefff777999aaafffffff777aaaaafffffff7777bbbbbb6666666777cccccc6666667777dddd666666667777eeeeeffffff77777fffffff777777777")

	-- some helpers.
	fade_func_0 = gen_tran_fade(g_fade0)
	fade_func_7 = gen_tran_fade(g_fade7)

	c_trans_len = 1.3

	g_tl = tl_init( {
		{ update_logo, draw_logo, 3, init_logo }, -- 1

		gen_tran_for_timeline(fade_func_0, c_trans_len, draw_logo, draw_title, init_title),
		{ nil,         draw_title, 4 }, -- 3

		gen_tran_for_timeline(fade_func_0, c_trans_len, draw_title, draw_dedication, nil),
		{ nil, draw_dedication, 2 },

		gen_tran_for_timeline(fade_func_0, c_trans_len, draw_dedication, draw_city, init_city),
		{ update_city, draw_city,  nil,   city_tbox                                                      }, -- 5

		gen_tran_for_timeline(fade_func_7, c_trans_len, draw_city, draw_church, init_church),
		{ update_church, draw_church }, -- 7 cut scene jumps to 10

		gen_tran_for_timeline(fade_func_0, c_trans_len, draw_church, draw_city, init_city_2) ,
		{ update_city, draw_city }, -- 9 this one jumps to 6

		{ scene_sleep,    draw_church,         nil,    scene_sleep_init },
		{ sleep_tbox_end, draw_church,         nil,    scene_sleep_tbox },

		gen_tran_for_timeline_half(fade_func_0, c_trans_len, draw_church),
		{ lyric_updater, draw_tran,  nil,   get_lyric_init(g_verse_1, 0)                  }, ---- !!!!!!!!!!!

		------------ sky below -----------------
		gen_tran_for_timeline(fade_func_0, c_trans_len, draw_church, draw_sky, init_sky),
		{ update_sky,      draw_sky,         nil,   sky_tbox},
		{ sky_tran_1,      draw_sky,         },
		{ sky_tran_2,      draw_sky,         },
		{ sky_tran_3,      draw_sky,         },

		gen_tran_for_timeline_half(fade_func_0, c_trans_len, draw_sky),
		{ lyric_updater,   draw_tran,  nil,   get_lyric_init(g_verse_2, 0)               }, ---- !!!!!!!!!!!

		{ sky_tran_4,      draw_sky,         },

		-------------- field below ----------------
		gen_tran_for_timeline(fade_func_0, c_trans_len, draw_sky, draw_field, init_field),
		{ update_field,  draw_field,          nil,               field_tbox},

		gen_tran_for_timeline_half(fade_func_0, c_trans_len, draw_field),
		{ lyric_updater,   draw_tran,  nil,   get_lyric_init(g_verse_3, 0)               }, ---- !!!!!!!!!!!

		------------------------- intermission
		gen_tran_for_timeline(fade_func_0, c_trans_len, draw_field, nil, clear_particles),
		{ tbox_active_next, nil, nil, giveup_tbox },

		-------------- manger below --------------
		gen_tran_for_timeline(fade_func_7, c_trans_len, nil, draw_manger, init_manger),
		{ nil,  draw_manger,         1,                     }, -- 9 cut scene jumps to 13

		gen_tran_for_timeline_half(fade_func_0, c_trans_len, draw_manger),
		{ lyric_updater,   draw_tran,  nil,   get_lyric_init(g_verse_4, 0)               }, ---- !!!!!!!!!!!

		------------ back to church ---------
		gen_tran_for_timeline(fade_func_7, c_trans_len, draw_manger, draw_church, init_church_fam),
		{ tbox_active_next,  draw_church,         nil,  }, -- 9 cut scene jumps to 13

		gen_tran_for_timeline(fade_func_0, c_trans_len, draw_church, draw_church, init_church_fam2),
		{ nil,  draw_church,         1,                     }, -- 9 cut scene jumps to 13

		gen_tran_for_timeline_half(fade_func_0, c_trans_len, draw_church),
		{ lyric_updater, draw_tran,  nil,   get_lyric_init(g_verse_5, 6)                  }, ---- !!!!!!!!!!!

		gen_tran_for_timeline(fade_func_0, c_trans_len, draw_church, nil, nil),
		gen_tran_for_timeline(fade_func_0, 3, nil, draw_ending_1, nil),
		{ nil, draw_ending_1, 3 },

		gen_tran_for_timeline(fade_func_0, c_trans_len, draw_ending_1, draw_ending_2, nil),
		{ nil, draw_ending_2, 3 },

		gen_tran_for_timeline(fade_func_0, c_trans_len, draw_ending_2, draw_ending_3, nil),
		{ nil, draw_ending_3, 3 },

		gen_tran_for_timeline(fade_func_0, c_trans_len, draw_ending_3, draw_ending_4, nil),
		{ nil, draw_ending_4, 3 },

		gen_tran_for_timeline(fade_func_0, c_trans_len, draw_ending_4, draw_ending_5, nil),
		{ nil, draw_ending_5, 3 },

		gen_tran_for_timeline(fade_func_0, c_trans_len, draw_ending_5, draw_ending_6, nil),
		{ nil, draw_ending_6 },

	} )
end

function _update60()
	tl_update(g_tl)

	tbox_interact(9)
end

function _draw()
	cls()

	tl_draw(g_tl)
	draw_particles()

	clear_fade() -- no fade for text boxes and stuff.
	lyrics_draw()

	if g_pl then -- maybe a bit messy, but whatever
		tbox_draw(7, 0, 2, g_pl.y - g_y > 8)
	end

	--print("x: "..g_x.." | y: "..g_y, 0, 0, 10)
end
