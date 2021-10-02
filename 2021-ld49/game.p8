pico-8 cartridge // http://www.pico-8.com
version 33
__lua__
-- game
-- amorg

-- unobfuscated code at:
-- git.io/amorg-pico8

#include .code.lua

__gfx__
00000000066666666666666666666660000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000d6666666666666666666666d000000000010110000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700d6666666666666666666666d000000000001111100101001000000000000000000000000000000000000000000000000000000000000000000000000
00077000d6666666666666666666666d000000000011111000011110000000000000000000000000000000000000000000000000000000000000000000000000
00077000d666666dddddddddd666666d000000000111d1d101111110000000000000000000000000000000000000000000000000000000000000000000000000
00700700d666666ddd5ddd5dd666666d000000000011dd300011d1d1000000000000000000000000000000000000000000000000000000000000000000000000
00000000d666666d55555555d666666d000000000001dff00011ddb0000000000000000000000000000000000000000000000000000000000000000000000000
00000000d666666d5ddd5dddd666666d000000000000df000001dff0000000000000000000000000000000000000000000000000000000000000000000000000
00000000d666666d44444444d666666d00000000000dd6700000df00000000000000000000000000000000000000000000000000000000000000000000000000
00000000d666666d44444444d666666d0000000000d61d60000dd670000000000000000000000000000000000000000000000000000000000000000000000000
00000000d666666d44444444d666666d00000000002d16d000d61d60000000000000000000000000000000000000000000000000000000000000000000000000
00000000d666666d44444444d666666d0000000000021440002d111f000000000000000000000000000000000000000000000000000000000000000000000000
00000000d666666d44444444d666666d000000000001f11000022240000000000000000000000000000000000000000000000000000000000000000000000000
00000000d666666d44444444d666666d000000000000110000011110000000000000000000000000000000000000000000000000000000000000000000000000
00000000d666666d44444444d666666d000000000000110000010010000000000000000000000000000000000000000000000000000000000000000000000000
00000000d666666d44444444d666666d000000000000220000020020000000000000000000000000000000000000000000000000000000000000000000000000
00000000d6666666666666666666666d000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000d6666666666666666666666d000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000d6666666666666666666666d000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000d6666666666666666666666d000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000dddddddddddddddddddddddd000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000d5ddd5dddd5ddd5ddd5ddd5d000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000d5555555555555555555555d000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000dd5ddd55ddd5ddd5ddd5dd0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000151500005d5d00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00111150005555d00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001121250055e5ed0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001122a00055ee100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00012ee00005eff00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00002e000000ef000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0005dd50000677600000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00051dd00006d7700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000515d00006d6700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0015155000d6d6600000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0011251000dde6d00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
011111000ddddd000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
011111000ddddd000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
010022000d0022000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001111110000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000011111111111111777711111111111110
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000017777177177117511571177771777710
000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000175571777771171dc171175571755511
000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000177771757571171dd171177711711771
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000017557171517115511551175571777751
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000015115151115111555511151151555511
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000011111111111111111111111111111111
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000777770000011aa11aaa11a1111a11aaa111aa100
000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007770000001a4411a4a11aaaaaa11a4411a44100
000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000700000001a1111aaa11a4aa4a11aa111aaa100
000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001a1a11a4a11a1aa1a11a411144a100
000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001aaa11a1a11a1441a11aaa11aa4100
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000144411414114111141144411441100
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000111111111111111111111111111000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00100100000000000111101000010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00011111000000001111111101011010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0011111000011100111d11f101111100001001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0011d1d10111111011ddb11111111101000111100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0111dd300011111001dff011011d1d01011111100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0001dff001111d1110df1011011ddb010011d1d10000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000df000111ddb00d6dd011001dff010011ddb00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000dd6700001dff0161f0110000df0110001dff00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00d61d600000df0011d6011000d6dd110000df000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
002d16d0000d6dd00d210100011d61110001d6700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0002144000161f60021110000211d1f100d11d610000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0001f1100011d6d001020000002f4410002df6d10000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00001100000d241120000000001111000002d44f0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00001100000211110000000000100100000011100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00002200021102100000000002000200002100120000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__map__
0102020202020202020202020202030000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1112121212121212121212121212130000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1112121212121212121212121212130000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1112121212121212121212121212130000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1112121212121212121212121212130000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1112121212121212121212121212130000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1112121212121212121212121212130000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1112121212121212121212121212130000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1112121212121212121212121212130000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1112121212121212121212121212130000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1112121212121212121212121212130000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2122222222222222222222222222230000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
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
991300001c0441c0421c0421c0421c042210412104021040210402104009051090520905209052090520905509000090001500000000000000000000000000000000000000000000000000000000000000000000
