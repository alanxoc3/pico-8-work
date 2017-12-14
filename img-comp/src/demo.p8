function _init()
	gen_cipher()

	-- edit this line with your
	-- sprite parameters
	-- index, width, height, alt col
	g_str, g_w, g_h = img_c(2,12,7, 14)

	-- this is printed to cli.
	printh("str = img_x(\""..g_str.."\")")
	extracted = img_x(g_str, g_w, g_h)
end

function _draw()
	cls()
	rectfill(0, 0, 128, 12, 13)
	print('import a spritesheet,', 1, 1, 7)
	print('edit line #10, then view cli.', 1, 7, 7)

	-- you would do something like this line in your game.
	cspr(extracted, 0, 14, g_w)

	rectfill(0, 115, 128, 128, 13)
	print('cmp: '..#g_str.."/"..#extracted.." or "..(#g_str/#extracted*100).."%", 1, 116, 7)

	print('cpu: '..stat(1), 1, 122, 7)
	print('mem: '..stat(0), 64, 122, 7)
end
