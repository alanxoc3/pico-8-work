pico-8 cartridge // http://www.pico-8.com
version 41
__lua__
-- pIXL
-- bY: aMORG gAMES | xOC3.iO/pICO8
#include .code.lua
__gfx__
66666666666666666666666666666666dddddddddddddddddddddddddddddddd0000000000000000000000000000000000000000000000000000000000000000
60000000000000000000000000000006d000000000000000000000000000000d0000000000000000000000000000000000000000000000000000000000000000
60000000000000000000000000000006d000000000000000000000000000000d0000000000000000000000000000000000000000000000000000000000000000
60000000000000000000000000000006d000000000000000000000000000000d0000000000000000000000000000000000000000000000000000000000000000
60000000000000000000000000000006d000000000000000000000000000000d0000000000000000000000000000000000000000000000000000000000000000
60000000000000000000000000000006d000000000000000000000000000000d0000000000000000000000000000000000000000000000000000000000000000
60000000000000000000900000000006d000000000000000000000000000000d0000000000000000000000000000000000000000000000000000000000000000
60000000000000000000000000000006d000000000050000000000000000000d0000000000000000000000000000000000000000000000000000000000000000
60000000800000000000000000000006d000000000050000000555000000000d0000000000000000000000000000000000000000000000000000000000000000
60000000000000000000000000000006d000000000000000000555000000000d0000000000000000000000000000000000000000000000000000000000000000
60000000009000000000000000000006d000000000000000000000000000000d0000000000000000000000000000000000000000000000000000000000000000
60000000009000000000000000000006d000000000000000000000000000000d0000000000000000000000000000000000000000000000000000000000000000
60000000009000000000000000000006d000000000000000000000000000000d0000000000000000000000000000000000000000000000000000000000000000
60000000009000000000000000000006d000000000000000000000000000000d0000000000000000000000000000000000000000000000000000000000000000
60009999999000000000990000000006d000000000000000000000000000000d0000000000000000000000000000000000000000000000000000000000000000
60009000009000000000990000000006d000000000005555555555550000000d0000000000000000000000000000000000000000000000000000000000000000
60009999999000000000990000000006d000000000005000000000050000000d0000000000000000000000000000000000000000000000000000000000000000
60000000000000000000990000000006d000000000005000000000050000000d0000000000000000000000000000000000000000000000000000000000000000
6000000000000000ccccc90000000006d000000000005000000000050000000d0000000000000000000000000000000000000000000000000000000000000000
6000000000000000c0ccc90000000006d000000000005555555555550000000d0000000000000000000000000000000000000000000000000000000000000000
6000000000000000ccccc90000000006d000000000000000000000000000000d0000000000000000000000000000000000000000000000000000000000000000
6000000000000000c0cc990000000006d000000000000000000000000000000d0000000000000000000000000000000000000000000000000000000000000000
6000006666600000c000990000000006d000000000000000000000000000000d0000000000000000000000000000000000000000000000000000000000000000
6000066000660000ccccccc000000006d000000000000000000000000000000d0000000000000000000000000000000000000000000000000000000000000000
60000600000660000000990000000006d000000000000000000000000000000d0000000000000000000000000000000000000000000000000000000000000000
60000600000060000000000000000006d000000000000000000000000000000d0000000000000000000000000000000000000000000000000000000000000000
60000600000060000000000000000006d000000000000000000000000000000d0000000000000000000000000000000000000000000000000000000000000000
60000666600066000000000000000006d000000000000000000000000000000d0000000000000000000000000000000000000000000000000000000000000000
60000000000006600000000000000006d000000000000000000000000000000d0000000000000000000000000000000000000000000000000000000000000000
60000000000000666600000000000006d000000000000000000000000000000d0000000000000000000000000000000000000000000000000000000000000000
60000000000000000066600000000006d000000000000000000000000000000d0000000000000000000000000000000000000000000000000000000000000000
66666666666666666666666666666666dddddddddddddddddddddddddddddddd0000000000000000000000000000000000000000000000000000000000000000
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
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001111110000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000011111111111111777711111111111110
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000017777177177117511571177771777710
000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000175571777771171dc171175571755511
000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000177771757571171dd171177711711771
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000017557171517115511551175571777751
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000015115151115111555511151151555511
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000011111111111111111111111111111111
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000011aa11aaa11a1111a11aaa111aa100
000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001a4411a4a11aaaaaa11a4411a44100
000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001a1111aaa11a4aa4a11aa111aaa100
000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001a1a11a4a11a1aa1a11a411144a100
000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001aaa11a1a11a1441a11aaa11aa4100
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000144411414114111141144411441100
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000111111111111111111111111111000
__sfx__
010c00001305013050130500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
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
990d0000000020000000000000000c0320c035180321803524032280322b032290322f0322f03517032170350b0320b0210b01523005100002300511000170002800000000000000000000000000000000000000
