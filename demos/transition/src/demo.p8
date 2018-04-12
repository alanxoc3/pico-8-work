function _init()
	gen_cipher()
	g_fade0 = gen_fade("000000000000000011111111100000002222221111000000333333311110000044442222111100005555551111110000666dddddd5511100776666dddd55111088888222522110009999444454551000aaa999ddd5555100bbbb333dddd11100ccccccddd1111100dddd555551111000eeeed44455111100fff6ddddd5551110")

	tran_init(gen_tran_fade(g_fade0), 5, draw_one, draw_two, nil)
end

function draw_one()
	print("hello, bet you wonder\nwhat i do", 2, 10, 7)
end

function draw_two()
	print("that's what!", 2, 10, 8)
end

function _update60()
	tran_update()
end

function _draw()
	cls(0)
	tran_draw()
end
