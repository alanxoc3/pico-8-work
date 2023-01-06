pico-8 cartridge // http://www.pico-8.com
version 39
__lua__
#include src/95-picodex-test-shared.lua

function _draw()
    cls()
    -- draw the pokedex, use camera to change position
    camera(0,-20)
    draw_back_panel()
    draw_right_flap()
    draw_left_flap()
    draw_closed_flap()
    camera()
end
__gfx__
0000000a0a000000000000070000100000000000000cc0c000000000000000000000000000000004000000010000000000000000000000000000090000000000
00000a0aaa000000000007070c1c10100000000000ccccc000000000000000000044000000000044000000010000000000000000000000000000999000000000
80000aaa28880000000007777cc111000000000000cccccc00000000000000000004400000000044000001111100111100000000000000000009999000000000
78000888288888800000077cccc78c8000000000000c07cc0000000000000000000444000000044411111cc1cc11fff000000000aa0000000999999900900000
778088828888888e00000ccc9ccccff000000000000cfff0000000000000000000004440000004400fffff7ccc7fff0000000000aaa000000999999900999900
77788882887778ee00001cffcccc722700000670067cf000000000ffe0fe00000700004044440400000fff0ccc0f00000000aaaaaaaa00009999999000099900
07788782887178e200701cca9cccf22f00070677767cf000000fe0eeeeeee0000ff44004444440000000ffccecf0000000000a11aaaaaa009999444400009980
07788772887778e2707001cff1cf882f001677777776f000000eeee0eee0eee00f4444047447400000000fcccf000000000000a111a17aa19994444449987887
07788777788888e27771ccca991f88f001c667777776f0000000eeeeeeeeeee00244222414414000000000fff0c10000000000077aaa11a09994444499988888
77787777788998ee01ccccfff90078701c7766777766c0000000ee222222eee00242447444444700000ccc00ccc100000a0a077779aaaa000994484499999888
778077778898888e0ccf9f9af900fff0cc6766666666cc0000000eee222eee00002244774444770000cc00ccccc100010aaaaa77779970000994844499999990
220077788988882a1ca000999000000001056655665cccc000000eeeeeeee000000244f777777f000cc0ccccc0c1011c0aaaa777777777000008804499999990
000077888988220a1c9100000000000011cc551c55c1cccc0000eeeeeeeeee000002444f7f7ff0000cc1110011111ccc9aaaaaa7977a70000008800888999800
000002a9922200a01c771100000000001ccc111cccc111cc000eeeeeeeeee2200002440024f240000ccccc11cccccc0009a99990097a00000008800880008880
00000090aaa000a01717700000000000ccc11111cc011111000222eee222220000024000240240000ccccccccccc0ccc00aa000009aa00000000880888000888
00000000a0a00a00177100000000000001111000c10000000000022220022000000000000000000001ccccccc000000c009aa00009a990000000880088800000
0000c00000000000000000000000000000000000000000000000000444440000000044000540000000000000000000000000003003000000c00000000000000d
000cc0000000000000000000ff00000000000ff000000000000004414444440000004454445400000000000000ddd0000000003333300000cc0000dd0d0000dd
000cc0000eee00000000ffffffff000000ffffffff0000000000444444441440000004455544000000000dddddd220d00000003fffff0000ccc0000ddd000ddd
000ccc00eeeee000000ffffffffff0000ffffff5ffff0000000444411114444000660444444400002200000d1d220020000003311f1100000ccc0ddccc000dd0
00cccc00ee77ee0000ff244ffffff0000f55ff5fffff000000444411e11114400666604f144006600222d000d88802220000333fffff30000ccc00cc1c90dddd
00cccc000e717ee000424444ffffff00ff5fffff555ff0000044411ee1ee11400660d2044402666602222200dd888220000333f44444f300cccc00cccc00ddd0
00ccc8882ee7eee004244224ffffff00f5ff5ffffffff0000049911e11e11140660004266624d06602222222ddd2820200333fffffffff300cccc00cc7dddd00
00cd888882eeeee004242424ffffff00f5f5ff555555f000044999111111999066000006660000660222022266d220000333fffffffffff300cccc0c777dd0d0
000ccc8882eeeccc04242424ffffff00f55fcffffffff000044419911199994066000006600000660220000d666000000333fffffffffff300c0cccc7770d000
00ccccc8882ecccc04242424ffffff00ffffccf44f44f0c004441111111114406600000dd000000620000006666000003333fffffffffff00000c0cc77700000
00ccccc88882ccc004244424ffffff00ddffcc47747740c004491111111144000600044664400006000000d66666000003033ffffffffff00000000cc7700000
000ccccc888822d004422c4ccffccc0c0ddfccc71c71cccd0499911111199400006044466444000605d000d66666000000033ffffffffff000dcccc0c74f0000
000ccccc8888ddd000444cc77ccc77cc0fdddcccccccccdd004999111999400000004406004440000555dddd666d0000000033ffffffff3000ccd00040044000
0000cccc88000dd0000440c71ccc17c00000ddcff1ffcdd000004411114400000000440000044000000055dd66dd00000000033ffffff3000cd0004400040000
0000ccc0000000000000004cccccccc0000ccccc111ccccc0000000000000000000044000004400000000ddd5dd0000000044333333333400ccdccc4dc000000
0000000000000000000004cc0cc0c00000000ccff1ffccc000000000000000000000400000004000000000d00d0000000000444000004440000cccd000000000
0000000000000000000000000000000000000000000000000000000000066000000040440090545000000600d00000000000000000000000000000077d7d0000
900000090000000a000000000000200000000000000005000000066000060000000054594999404400000660dd0000000002222200e0000000000007d7d70000
0940000900900049088000000002020000000006600dd5000000006dddd660000000009999999000000066d66d00000000220eeeeee000000000000d77dd0000
00909909090004a088808000002224200000000066dddd5000000666ddd5000000400094919910000000666d66000000022202edeed2000000000007d7d70000
01a4009aa9a00a908aa88000000244200000000066d1ddd000000066d1dd600004340094999990000000662662000000222000eeeee022000000000ff11f0000
011929a191992a1108aa8800828442000000000666ddd77000000005ddd0000043340094999920000600d6666600000022200022ee2000200000000d7d7d0000
9aaa2aa98992aa10888aa80888842000000000006ddd77770000000d5dd000d0433340994443320005000d566000000002000eee22ee00200000000ddddd0000
09aa42aa88249aaa0008aa9028888000d000000000ddd7700000000dd5000dcd433334999ff4920065560055000000600002222eee2222000000dddd1f1f0000
0019942aa8824a9000009aa9948880005d00000000dddd000000000ddcc000d5403009999fff99000dddd666655505d00020000eee0000000000777d7dd70000
0111a94292249a11000099999ff2800005d0000000ddd60005555550dcc00055000099999ddd99900000d66d6dddd500002000eeeee0000000007777d77d0000
101a9009990009a00202209904f1f00000dd000000dd6600d5555555d655555590079994ffff999700005dddd0000060000222eeeee000000000dd7d77d70000
00a900dd9dd0000a0024044000ff4420005dd0000ddd6000dd500055d6655550f9004949dddd04940022566dd2222000000002e202e0000000007777dddd0000
0000002d0d2000000200420000000244000dddddddd66000dd00000dd66000000f997499ffff00700220666ddd22000000000ee00ee000000000f1f1ffd70000
0000004000940000000400000000000000006ddddd6600006dddddddd666000000ff9999944422202200d62ddd00000000000ee00ee000000000dd7dd7770000
00009890000890000000000000000000000006666660000066dddddd66660000000ff49999999222022dd222d550000000000e200e200000000077d7d7d70000
000009000009000000000000000000000000000000000000006666666660000000000f499999922200dd2220005500000000000000000000000077ddd7770000
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
82a28888822288888888888888888888888888880000000000000000000000001100000000000000827777288827728882777728842222222222222222222248
82aa2888829228888888888888888888888888880000000000000000000000002110000000000000277667728277772827677672426666666666666666666624
82aaa288829922888888888888888888888888880000000000000000000000004210000000000000276776722777777227766772266666666666666666666662
82aaa288829992888888888888888888888888880000000000000000000000008210000000000000276776722777777227766772266666666666666666666662
82aa4288829992888888888888888888888888880000000000000000000000008210000000000000277667722777777227677672266665111111111111566662
82a422888299228842222222222222222222222800000000000000000000000082100000000000002d7777d2277777722d7777d2266651000000000000156662
8242288882922888228888888888888888888822000000000000000000000000821000000000000022dddd222dddddd222dddd22266610000000000000016662
82228888822288884222222222222222222222280000000000000000000000008210000000000000822222282222222282222228266610000000000000016662
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
000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000091a0a0929090909391a0a092909090939490909095a0a096a46666666666669798
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000a4666666666666a3a48d8e8e8e8e8fa3a4606161616162a3a4666666666666a7a8
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000a4666666666666a3a49d000000009fa3a4707171717172a3a4666666666666a7a8
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000a4666666666666a3a49d000000009fa3a4666666666666a3a4666666666666a7a8
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000a4666666666666a3a49d000000009fa3a4666666666666a3a4666666666666a7a8
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000a4806666666666a3a49d000000009fa3a4666666666666a3a4666666666666a7a8
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000a4666666666666a3a4adaeaeaeaeafa3a4666666666666a3a4666666666666a7a8
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000a4666666666666a3a4bdbebebebebfa3a4606161610062a3a4666666666666a7a8
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000a4666666666666a3a4666666666666a3a4730000000074a3a4666666666666a7a8
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000a4668283838466a3a4666666666666a3a4707171710072a3a4666666666666a7a8
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000a1b0b0b0b0b0b0a2a1b0b0b0b0b0b0a2a5b0b0b0b0b0b0a6a1b0b0b0b0b0b0b7b8
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
