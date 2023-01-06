pico-8 cartridge // http://www.pico-8.com
version 39
__lua__
#include picodextest.lua
__gfx__
000000a0a000000000010000700000000c0cc0000000000000000000000000004000000000000000000000010000000000000000000000000000000000900000
000000aaa0a000000101c1c0707000000ccccc000000000000000000000000004400000000004400000000010000000000000000000000000000000009990000
00008882aaa0000800111cc777700000cccccc000000000000000000000000004400000000044000000001111100111100000000000000000000000009999000
088888828880008708c87cccc7700000cc70c000000000000000000000000000444000000044400011111cc1cc11fff0000000aa000000000000090099999990
e8888888288808770ffcccc9ccc000000fffc00000000000000000000000000004400000044400000fffff7ccc7fff0000000aaa000000000099990099999990
ee877788288887777227ccccffc10000000fc76007600000000000ffe0fe00000040444404000070000fff0ccc0f00000000aaaaaaaa00000099900009999999
2e87178828788770f22fccc9acc10700000fc76777607000000fe0eeeeeee0000004444440044ff00000ffccecf0000000aaaaaa11a000000899000044449999
2e87778827788770f288fc1ffc100707000f677777776100000eeee0eee0eee000047447404444f000000fcccf0000001aa71a111a0000008888899444444999
2e888887777887700f88f199accc1777000f677777766c100000eeeeeeeeeee00004144142224420000000fff0c100000a11aaa7700000008888899944444999
ee899887777787770787009fffcccc10000c6677776677c10000ee222222eee00074444447442420000ccc00ccc1000000aaaa977770a0a00888999944844990
e8888988777708770fff009fa9f9fcc000cc6666666676cc00000eee222eee00007744447744220000cc00ccccc100010007997777aaaaa00999999944484990
a2888898877700220000000999000ac10cccc5665566501000000eeeeeeee00000f777777f4420000cc0ccccc0c1011c00777777777aaaa00999999944088000
a02288988877000000000000000019c1cccc1c55c155cc110000eeeeeeeeee00000ff7f7f44420000cc1110011111ccc0007a7797aaaaaa90089998880088000
0a0022299a20000000000000001177c1cc111cccc111ccc1000eeeeeeeeee22000042f42004420000ccccc11cccccc000000a79009999a900888000880088000
0a000aaa090000000000000000077171111110cc11111ccc000222eee222220000042042000420000ccccccccccc0ccc0000aa900000aa008880008880880000
00a00a0a0000000000000000000017710000001c000111100000022220022000000000000000000001ccccccc000000c00099a90000aa9000000088800880000
00000000000c0000000000000000000000000000000000000000044444440000000004500044000000000000000000000000003003000000d00000000000000c
00000000000cc00000000000ff000000000000000ff0000000004441444444000000454445440000000ddd00000000000000003333300000dd0000d0dd0000cc
0000eee0000cc0000000ffffffff0000000000ffffffff00000444444444144000004455544000000d022dddddd000000000003fffff0000ddd000ddd0000ccc
000eeeee00ccc000000ffffffffff0000000ffff5ffffff000444441111444400000444444406600020022d1d0000022000003311f1100000dd000cccdd0ccc0
00ee77ee00cccc0000ff244ffffff0000000fffff5ff55f004444411e111144406600441f40666602220888d000d22200000333fffff3000dddd09c1cc00ccc0
0ee717e000cccc0000424444ffffff00000ff555fffff5ff0444411ee1ee114466662044402d0660022888dd00222220000333f44444f3000ddd00cccc00cccc
0eee7ee2888ccc0004244224ffffff00000ffffffff5ff5f0449911e11e11144660d42666240006620282ddd2222222000333fffffffff3000dddd7cc00cccc0
0eeeee288888dc0004242424ffffff00000f555555ff5f5f0449991111119994660000666000006600022d66222022200333fffffffffff30d0dd777c0cccc00
ccceee2888ccc00004242424ffffff00000ffffffffcf55f0444199111999944660000066000006600000666d00002200333fffffffffff3000d0777cccc0c00
cccce2888ccccc0004242424ffffff000c0f44f44fccffff04441111111114446000000dd000006600000666600000023333fffffffffff000000777cc0c0000
0ccc28888ccccc0004244424ffffff000c04774774ccffdd04491111111144406000044664400060000066666d00000003033ffffffffff00000077cc0000000
0d228888ccccc00004422c4ccffccc0cdccc17c17cccfdd004999111111994006000444664440600000066666d000d5000033ffffffffff00000f47c0ccccd00
0ddd8888ccccc00000444cc77ccc77ccddcccccccccdddf0004999111999400000044400604400000000d666dddd5550000033ffffffff3000044004000dcc00
0dd00088cccc0000000440c71ccc17c00ddcff1ffcdd0000000044111144000000044000004400000000dd66dd5500000000033ffffff3000000400044000dc0
000000000ccc00000000004cccccccc0ccccc111ccccc0000000000000000000000440000044000000000dd5ddd000000004433333333340000000cd4cccdcc0
0000000000000000000004cc0cc0c0000cccff1ffcc0000000000000000000000004000000040000000000d00d0000000000444000004440000000000dccc000
0000000000000000000000000000000000000000000000000006600000000000054509004404000000000600d000000000000000000000000033333300000cc0
a000000090000009000000000000200000000000000005000000600006600000440499949545000000000660dd0000000002222200e00000033334330ccccccc
9400090090000490088000000002020000000006600dd50000066dddd60000000009999999000000000066d66d00000000220eeeeee0000033333433cccccc00
0a4000909099090088808000002224200000000066dddd5000005ddd6660000000019919490004000000666d66000000022202edeed2000033333443ccccccc0
09a00a9aa9004a108aa88000000244200000000066d1ddd00006dd1d6600000000099999490043400000662662000000222000eeeee0220003333433cccccccc
11a299191a92911008aa8800828442000000000666ddd77000000ddd5000000000029999490043340600d6666600000022200022ee200020034433330ccccccc
01aa29989aa2aaa9888aa80888842000000000006ddd77770d000dd5d0000000002334449904333405000d566000000002000eee22ee002004433333cccccccc
aaa94288aa24aa900008aa9028888000d000000000ddd770dcd0005dd000000000294ff99943333465560055000000600002222eee22220044000330cc000cc0
09a4288aa249910000009aa9948880005d00000000dddd005d000ccdd00000000099fff9999003040dddd666655505d00020000eee0000000000000000000000
11a94229249a1110000099999ff2800005d0000000ddd60055000ccd055555500999ddd9999900000000d66d6dddd500002000eeeee000000000000000000000
0a9000999009a1010202209904f1f00000dd000000dd66005555556d5555555d7999ffff4999700900005dddd0000060000222eeeee000000000000000000000
a0000dd9dd009a000024044000ff4420005dd0000ddd60000555566d550005dd4940dddd9494009f0022566dd2222000000002e202e000000000000000000000
000002d0d20000000200420000000244000dddddddd660000000066dd00000dd0700ffff994799f00220666ddd22000000000ee00ee000000000000000000000
0000490004000000000400000000000000006ddddd6600000000666dddddddd6022244499999ff002200d62ddd00000000000ee00ee000000000000000000000
00098000098900000000000000000000000006666660000000006666dddddd6622299999994ff000022dd222d550000000000e200e2000000000000000000000
00009000009000000000000000000000000000000000000000000666666666002229999994f0000000dd22200055000000000000000000000000000000000000
8511111111111111111111582cccccc2222222220000000088888888000000000000000000000000000000000000000000000000000001111110000000000000
5100000000000000000000152cccccc22cccccc20000000088888888007777000000077700000007777000000077077011111111111111777711111111111110
1000000000000000000000012cccccc22cccccc20000000088888888077077077770770000777707707700777007770017777177177117511571177771777710
1000000000000000000000012cccccc22cccccc200000000888888880777770077007700077077077077077000077700175571777771171dc171175571755511
1000000000000000000000012cccccc22cccccc200000000888888880770000077007700077077077077077700077700177771757571171dd171177711711771
1000000000000000000000012cccccc22cccccc20000000088888888077000007700777707707707777007700077077017557171517115511551175571777751
1000000000000000000000012dddddd22cccccc20000000088888888000000077770000007777000000007777000000015115151115111555511151151555511
10000000000000000000000122222222222222220000000088888888000000000000000000000000000000000000000011111111111111111111111111111111
1000000000000000000000011000000000000001000000000000000000000000000000000000000000000000000000000011aa11aaa11a1111a11aaa111aa100
100000000000000000000001100000000000000100000000000000000000000000000000000000000042240000422400001a4411a4a11aaaaaa11a4411a44100
1000000000000000000000011000000000000001000000000002200000022000000220000002200004298240042dd240001a1111aaa11a4aa4a11aa111aaa100
1000000000000000000000011000000000000001000000000028e2000029a200002b7200002dd20002a77f2002d55d20001a1a11a4a11a1aa1a11a411144a100
1000000000000000000000011000000000000001000000000028820000299200002bb200002dd20002b77e2002d55d20001aaa11a1a11a1441a11aaa11aa4100
10000000000000000000000110000000000000010000000000022000000220000002200000022000042cd240042dd24000144411414114111141144411441100
51000000000000000000001510000000000000010000000000000000000000000000000000000000004224000042240000111111111111111111111111111000
85111111111111111111115810000000000000010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000001100000000000000827777288827728882777728842222222222222222222248
00000000000000000000000000000000000000000000000000000000000000002110000000000000277667728277772827677672426666666666666666666624
00000000000000000000000000000000000000000000000000000000000000004210000000000000276776722777777227766772266666666666666666666662
00000000000000000000000000000000000000000000000000000000000000008210000000000000276776722777777227766772266666666666666666666662
00000000000000000000000000000000000000000000000000000000000000008210000000000000277667722777777227677672266665111111111111566662
000000000000000000000000000000000000000000000000000000000000000082100000000000002d7777d2277777722d7777d2266651000000000000156662
0000000000000000000000000000000000000000000000000000000000000000821000000000000022dddd222dddddd222dddd22266610000000000000016662
00000000000000000000000000000000000000000000000000000000000000008210000000000000822222282222222282222228266610000000000000016662
11111111000000000000111111111000000111111111000000000000888888888210000000000000882777722777777227777288266610000000000000016662
22222222000000000001122222221100001122222221100000000000888888888210000000000000827777722777777227777728266610000000000000016662
88888888000111111111248888842100001248888842111111111000888888888210000000000000277777722777777227777772266610000000000000016662
88888888001122222222488888882100001288888884222222221100888888811111000000000000277777722777777227777772266610000000000000016662
888888880012488888888888888821000012888888888888888421008888881222211000000000002d7777722d7777d2277777d2266610000000000000016662
8888888800128888888888888888210000128888888888888888210088888124884210000000000022d7777222d77d2227777d22266610000000000000016662
88888888001288888888888888882100001288888888888888882100888881288882100000000000822dddd2822dd2282dddd228266610000000000000016662
88888888001288888888888888882100001288888888888888882100888881288882100000000000882222228822228822222288266610000000000000016662
00000000001288888888210088882100001288880012888888882100888881288882100000000000822222288822228882222228266610000000000000016662
00000000001248888888210088882100001288880012888888842100888881288882100000000000226666228226622822666622266610000000000000016662
11111111001124888888210088882100001288880012888888421100888881288882100000000000266dd6622266662226d66d62266651000000000000156662
2222222200011248888421008888210000128888001248888421100088888128888210000000000026d66d6226666662266dd662266665111111111111566662
8888888800001122222211008888210000128888001122222211000088888128888210000000000026d66d6226666662266dd662266666666666666666666662
88888888000001111111100088882100001288880001111111100000888881288882100000000000266dd6622666666226d66d6226666666666666666ddd6662
88888888000000000000000088882100001288880000000000000000888881288882100000000000226666222666666222666622266666666666666666666662
888888880000000000000000888821000012888800000000000000008888812888821000000000008222222822222222822222282666666666666666556dd662
88888888000000000000000000000000000000000000000000000000888881288882100000000000882222222222222222222288426666666666666666666662
88888888000000000000000000000000000000000000000000000000888881288882100000000000822666622666666226666228842666666666666665556662
88888888000000000000000000000000000000000000000000000000888881288882100000000000226666622666666226666622884266666666666666666624
88888888000000000000000000000000000000000000000000000000888881288882100000000000266666622666666226666662888422222222222222222248
22222222000000000000000000000000000000000000000000000000222221248842100000000000266666622666666226666662888888888888888888888888
11111111000000000000000000000000000000000000000000000000111111122221100000000000226666622266662226666622888888888888888888888888
00000000000000000000000000000000000000000000000000000000000000111111000000000000822666628226622826666228888888888888888888888888
00000000000000000000000000000000000000000000000000000000000000000000000000000000882222228822228822222288888888888888888888888888
__map__
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000949090909090909088
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000091a0a092909090939490909095a0a096a46666666666669798
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000a48d8e8e8e8e8fa3a4606161616162a3a4666666666666a7a8
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000a49d000000009fa3a4707171717172a3a4666666666666a7a8
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000a49d000000009fa3a4666666666666a3a4666666666666a7a8
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000a49d000000009fa3a4666666666666a3a4666666666666a7a8
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000a49d000000009fa3a4666666666666a3a4666666666666a7a8
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000a4adaeaeaeaeafa3a4666666666666a3a4666666666666a7a8
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000a4bdbebebebebfa3a4606161610062a3a4666666666666a7a8
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000a4666666666666a3a4730000000074a3a4666666666666a7a8
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000a4666666666666a3a4707171710072a3a4666666666666a7a8
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000a1b0b0b0b0b0b0a2a5b0b0b0b0b0b0a6a1b0b0b0b0b0b0b7b8
__sfx__
3d060800184503045018456244561345607456134550740604400004000e4000c4000c4000c400004000040000400004000040000400004000040000400004000040000400004000040000400004000040000400
0d060800132501f256132561f256022500e256022560e215002000020000200002000020000200002000020000200002000020000200002000020000200002000020000200002000020000200002000020000200
490507000e2500e2500e2501725017250172501725500200002000020000200002000020000200002000020000200002000020000200002000020000200002000020000200002000020000200002000020000200
0d0b080018252182510b2510b25208252082500725107255072050020000200002000020000200002000020000200002000020000200002000020000200002000020000200002000020000200002000020000200
150808001825018252182501325413250122561325213256002000020000200002000020000200002000020000200002000020000200002000020000200002000020000200002000020000200002000020000200
050708001342314450144501345013450134551345513455004000040000400004000040000400004000040000400004000040000400004000040000400004000040000400004000040000400004000040000400
0d0e000007250072500b2500b25007250082500725007255072050020000200002000020000200002000020000200002000020000200002000020000200002000020000200002000020000200002000020000200
050900001b4521b4521b4521b4511b4511a4521a4511a4550f4000040000400004000040000400004000040000400004000040000400004000040000400004000040000400004000040000400004000040000400
010b00000f4520f4500e4500e45007450074500745007450000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
990d0000000020000000000000000c0320c035180321803524032280322b032290322f0322f03517032170350b0320b0210b01523005100002300511000170002800000000000000000000000000000000000000
