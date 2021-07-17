pico-8 cartridge // http://www.pico-8.com
version 32
__lua__
-- pendae
-- amorg

-- unobfuscated code at:
-- git.io/amorg-pico8

#include .code.lua

__gfx__
0000000000005d0000055d0000055d00000000000000000000000000000000000000000000000000000000000000000000000000009400000000000000000000
00000000220222200002222022022220000000000000000000000000000000000000000000000000000000000000000000000000000020000000000000000000
00700700022272702222722002222720000000000000000000000000000000000000000000000000000000000000000000000000000d76000000000000000000
000770002005d9902005599020055d990000000000000000000000000000000000000000000000000000000000000000000000000005dd000600006000000000
000770000055d7d00055d7700055dd70000000000000000000000000000000000000000000000000000000000000000000000000005dd6d00700607000000000
00700700005d777d005dd770005dd770000000000000000000000000000000000000000000000000000000000000000000000000005dddd07706707700000000
00000000005d677d005d66700055d6700000000000000000000000000000000000000000000000000000000000000000000000000015dd506767767600000000
000000000009969900099669000d996000000000000000000000000000000000000000000000000000000000000000000000000000015500dddddddd00000000
00000000000000000200000000055d0000055d000000000000000000000000000000000000055d00000000000000000000000000000000000000000000000000
00000000002005500022055022022220000222200000000000000000000000000000000022022220000000000000000000000000000000000000000000000000
000000000222225d0202225d02222720222227200000000000000000000000000000000002222720700000000000000000060000000060000006000000006000
000000000055222d0055222d20055d9920055d99000000000000000000000000000000002005ed997600000000000000000d66000066d0000006d60000666000
00000000055dd272055dd2720055dd700055dd70000000000000000000000000000000000055dd7077d77000000000000066d0000006d600006d6000000dd600
0000000005d5792005d57920005dd770005dd77000000000000000000000000000000000005dd55577676d000000000000006000000600000000600000060000
0000000005677900056779000055d6700055d6700000000000000000000000000000000000556770677794900000000000000000000000000000000000000000
000000000199600001996000000d9960000d996000000000000000000000000000000000000dd6990d7699440000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000200000000055d00000000000000000000d494999000000000000000000000000000000000000000
00000000000000000000000000000000000000000dd2000000220550220222200000000000000000005004494400000000000000000000000000000000000000
0000000000000000000000000000000000000000552720000202225d022227200000000000000000dddddddddd00000000000000000000000000000000000000
0000000000000000000000000000000000000000522299000055222d20055d990000000000000000d777777666d0000000000000000000000000000000000000
0000000000000000000000000000000000000000022d7760055dd2720055dd700000000000000000d7666676777d000000000000000000000000000000000000
0000000000000000000000000000000000000000225d579005d57920005dd7700000000000000000d767767d6777000000000000000000000000000000000000
00000000000000000000000000000000000000002055d690056779000055d6700000000000000000d7dddd7d6677500000000000000000000000000000000000
00000000000000000000000000000000000000000205555101996000000d99600000000000000000d7777777d666222000000000000000000000000000000000
000111110001111100000000000000000111110000011110001111000011111000000000000000002eeeeeeeeeeeeaa200000000000000000000000000000000
0000d6000000d600000000000000000000d600000000d60000d60000000d6000000000000000000027221133777779a200000000000000000000000000000000
00051150000511500000000000000000051150000005115005115000005115000000000000000000879955cc7777777200000000000000000000000000000000
0055d05500550d550000000000000000550d55000055d05555d05500055d055000000000000000008eeeeeeeeeeeeee200000000000000000000000000000000
0050d6d5005d6d0500000000000000005d6d05000050d6d550d6d500050d6d5000000000000000002ee11eeeeeee11e200000000000000000000000000000000
005d6d050050d6d5000000000000000050d6d500005d6d055d6d050005d6d0500000000000000000221551222221551200000000000000000000000000000000
00550d550055d055000000000000000055d0550000550d55550d55000550d5500000000000000000001551000001551000000000000000000000000000000000
00055550000555500000000000000000055550000005555005555000005555000000000000000000000110000000110000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000008000000000000000800000820000008200000082000000008000000000000000000000000000000000000000000000000000000000000000000
00000000000088200000000000008820000820000008200000082000000088200000000000000000000000000000000000000000000000000000000000000000
00000000000772000000000000077200000760000007600000076000000772000000000000000000000000000000000000000000000000000000000000000000
00000000007760000000000000776000000760000007600000076000007760000000000000000000000000000000000000000000000000000000000000000000
000000005c760000000000005c7600000007600000076000000760005c7600000000000000000000000000000000000000000000000000000000000000000000
00000009ccd0000000000004ccd00000000cd000000cd000000cd000ccd000000000000000000000000000000000000000000000000000000000000000000000
00000049ad50000000000049ad500000005cd500005cd500005cd5000d5000000000000000000000000000000000000000000000000000000000000000000000
0000000a94000000000000aa94000000004aa400004aa40000555500000000000000000000000000000000000000000000000000000000000000000000000000
0000094a0000000000000940400000000009a000000a940000dd7d00000000000000000000000000000000000000000000000000000000000000000000000000
0000a0a000000000000000a000000000009a49000094a90000dd7d00000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000000a0000000000004a04000040a40000dddd00000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000490000009400000dddd00000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000000000000000000009400000049000005dd500000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000400000000400000155100000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000001111110000000000000000000000000000000000000000000000000000000000000000000000000
33333333333333330000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001111110000000000000
44444444444444440000000000000000000000000000000000000000000000000000000000000000000000000000000011111111111111777711111111111110
99999999999999990000000000000000000000000000000000000000000000000000000000000000000000000000000017777177177117511571177771777710
999499999994999900000000000000000000000000000000000000000000000000000000000000000000000000000000175571777771171dc171175571755511
994999999949999900000000000000000000000000000000000000000000000000000000000000000000000000000000177771757571171dd171177711711771
99999999999999990000000000000000000000000000000000000000000000000000000000000000000000000000000017557171517115511551175571777751
99999999999999990000000000000000000000000000000000000000000000000000000000000000000000000000000015115151115111555511151151555511
99999999999999990000000000000000000000000000000000000000000000000000000000000000000000000000000011111111111111111111111111111111
9999999999999999000000000000000000000000000000000000000000000000000000000000000000000000000000000011aa11aaa11a1111a11aaa111aa100
999999999999999900000000000000000000000000000000000000000000000000000000000000000000000000000000001a4411a4a11aaaaaa11a4411a44100
999999999999999900000000000000000000000000000000000000000000000000000000000000000000000000000000001a1111aaa11a4aa4a11aa111aaa100
999499999994999900000000000000000000000000000000000000000000000000000000000000000000000000000000001a1a11a4a11a1aa1a11a411144a100
994999999949999900000000000000000000000000000000000000000000000000000000000000000000000000000000001aaa11a1a11a1441a11aaa11aa4100
99999999999999990000000000000000000000000000000000000000000000000000000000000000000000000000000000144411414114111141144411441100
99999999999999990000000000000000000000000000000000000000000000000000000000000000000000000000000000111111111111111111111111111000
22222222222222220000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__sfx__
010100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
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
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
991300001c0141c0121c0121c0121c012210112101021010210102101009011090120901209012090120901509000090001500000000000000000000000000000000000000000000000000000000000000000000
