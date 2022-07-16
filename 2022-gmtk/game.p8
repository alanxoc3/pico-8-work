pico-8 cartridge // http://www.pico-8.com
version 36
__lua__
-- game
-- amorg

-- unobfuscated code at:
-- git.io/amorg-pico8

#include .code.lua

__gfx__
0000000011111111111111111111111111111111111111111111111100d00d05000000000d00d050000000000000000000000000000000000000000000000000
000000001d666666666666d11d666666666666d11d666666666666d100d01d5500d00d050d01d550000000000000000000000000000000000000000000000000
0070070016677777777776611661177777777661166117777777766100d1d95900d11d550d1d9590000000000000000000000000000000000000000000000000
000770001677777777777761161111777777776116111177777777610155dd550155d959001dd550000000000000000000000000000000000000000000000000
0007700016777777777777611611117777777761161111777777776115ddd51015dddd550155dd10000000000000000000000000000444444444400000000000
0070070016777777777777611671177777777761167117777777776115dd515015dd551015ddd51500000000000000000000000000049aaaaaa9400000000000
00000000167777711777776116777777777777611677777117777761015515050155115015dd5105000000000000000000000000000499999999400000000000
000000001677771111777761167777777777776116777711117777610d1105000d11505001551500000000000000000000000000055555555555555000000000
5666666516777711117777611677777777777761167777111177776100000000000000000d00d050000000000000000000000000000000000000000000000000
d566665d16777771177777611677777777777761167777711777776100d00d05000000000d01d550000000000000000000000000000000000000000000000000
dd5665dd16777777777777611677777777711761167777777771176100d01d5500d00d050d1d9590000000000000000000000000000000000000000000000000
ddd55ddd16777777777777611677777777111161167777777711116100d1d95900d11d55001dd550000000000000000000000000006666000088880000dddd00
ddd55ddd1677777777777761167777777711116116777777771111610155dd550155d9590155dd100000000000000000000000000d6667600288868005ddd7d0
dd5665dd16677777777776611667777777711661166777777771166115ddd51015dddd5515ddd5150000000000000000000000000d6666600288888005ddddd0
d566665d1d666666666666d11d666666666666d11d666666666666d115dd515015dd551015dd51050000000000000000000000000dd6666002288880055dddd0
5666666511111111111111111111111111111111111111111111111101551505015511500155150000000000000000000000000000dd6600002288000055dd00
0000000011111111111111111111111111111111111111111111111100000000000000000000000000000000000000000000000000dddd000022220000555500
000000001d666666666666d11d666666666666d11d611666666116d10000000000000000000000000000000000000000000000000dd666d002288820055ddd50
000000001661177777711661166117777771166116111177771111610000000000000000000000000000000000000000000000000d6666600288888005ddddd0
000000001611117777111161161111777711116116111177771111610000000000000000000000000000000000000000000000000d6666600288888005ddddd0
000000001611117777111161161111777711116116711777777117610000000000000000000000000000000000000000000000000d6666600288888005ddddd0
00000000167117777771176116711777777117611677777777777761000000000000000000000000000000000000000000000000d6666666288888885ddddddd
00000000167777777777776116777771177777611671177777711761000000000000000000000000000000000000000000000000d666666d288888825dddddd5
00000000167777777777776116777711117777611611117777111161000000000000000000000000000000000000000000000000dd6666dd2288882255dddd55
00000000167777777777776116777711117777611611117777111161000000000000000000000000000000000000000000000000000000000000000000000000
00000000167777777777776116777771177777611671177777711761000000000000000000000000000000000000000000000000000000000000000000000000
00000000167117777771176116711777777117611677777777777761000000000000000000000000000000000000000000000000000000000000000000000000
00000000161111777711116116111177771111611671177777711761000000000000000000000000000000000000000000000000000000000000000000000000
00000000161111777711116116111177771111611611117777111161000000000000000000000000000000000000000000000000000000000000000000000000
00000000166117777771166116611777777116611611117777111161000000000000000000000000000000000000000000000000000000000000000000000000
000000001d666666666666d11d666666666666d11d611666666116d1000000000000000000000000000000000000000000000000000000000000000000000000
00000000111111111111111111111111111111111111111111111111000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000022222222222222002222222222222200000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000024992499429942002444244442444200000000000000000000000000000000000000000000000000000000000000000
006666000088880000dddd0000000000029294992929292002424244242424200000000000000000000000000000000000000000000000000000000000000000
0d6667600288868005ddd7d000000000029994999949992002444244442444200000000000000000000000000000000000000000000000000000000000000000
0d6666600288888005ddddd000000000029994999949992002444244442444200000000000000000000000000000000000000000000000000000000000000000
0dd6666002288880055dddd000000000029994999949992002444244442444200000000000000000000000000000000000000000000000000000000000000000
00dd6600002288000055dd0000000000029994999949992002444244442444200000000000000000000000000000000000000000000000000000000000000000
00dddd00002222000055550000000000029994999949992002444244442444200000000000000000000000000000000000000000000000000000000000000000
0dd666d002288820055ddd5000000000029994999949992002444244442444200000000000000000000000000000000000000000000000000000000000000000
0d6666600288888005ddddd000000000029994999949992002444244442444200000000000000000000000000000000000000000000000000000000000000000
0d6666600288888005ddddd000000000029994999949992002444244442444200000000000000000000000000000000000000000000000000000000000000000
0d6666600288888005ddddd000000000029294929949292002424242442424200000000000000000000000000000000000000000000000000000000000000000
d6666666288888885ddddddd00000000024992499429942002444244442444200000000000000000000000000000000000000000000000000000000000000000
d666666d288888825dddddd500000000022222222222222002222222222222200000000000000000000000000000000000000000000000000000000000000000
dd6666dd2288882255dddd5500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
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
000444444444400000000000000000000000000000000000000000000000000000000000000000000000000000000000001aaa11a1a11a1441a11aaa11aa4100
00049aaaaaa940000000000000000000000000000000000000000000000000000000000000000000000000000000000000144411414114111141144411441100
00049999999940000004444444444000000000000000000000000000000000000000000000000000000000000000000000111111111111111111111111111000
05555555555555500555555555555550000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
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
990d0000000020000000000000000c0320c035180321803524032280322b032290322f0322f03517032170350b0320b0210b01523005100002300511000170002800000000000000000000000000000000000000
