function _init()
	gen_cipher()

	-- optional, edit this line to import data from another cart.
	-- reload(0x0000, 0x0000, 0x1000, "_tests.p8")

	-- sprite parameters go here
	-- index, width, height, alt col
	g_str, g_w, g_h = img_c(0,16,16, nil)

	-- this is printed to cli.
	printh("str = img_x(\""..g_str.."\")", "out.p8l", true)
	printh("str = img_x(\""..g_str.."\")", "@clip")
	extracted = img_x(g_str, g_w, g_h)

	-- uncompressed version
	printh("\n-- str val is: \""..extracted.."\"", "out.p8l", false)
end

function _draw()
	cls()
	rectfill(0, 0, 128, 12, 13)
	print('edit lines #8 & #12, then see', 1, 1, 7)
	print('out.p8l or @clip', 1, 7, 7)

	-- you would do something like this line in your game.
	cspr(extracted, 0, 14, g_w)

	rectfill(0, 115, 128, 128, 13)
	print('cmp: '..#g_str.."/"..#extracted.." or "..(#g_str/#extracted*100).."%", 1, 116, 7)

	print('cpu: '..stat(1), 1, 122, 7)
	print('mem: '..stat(0), 64, 122, 7)
end
