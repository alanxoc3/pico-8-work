pico-8 cartridge // http://www.pico-8.com
version 41
__lua__
-- pIXL
-- bY: aMORG gAMES | xOC3.iO/pICO8
#include .code.lua
__gfx__
70000007000060000000000000000007999999999999999779999999999999999999999999999999999999999999999977777777777777777777777777777777
70000007000666000000000000000007900000b000000007700000000b0000099000000000000000000000000000000970000000000000000000000000000007
77000007000060000000000000000007900000000000000770000000000000099077700000000000000000000000000970070707770000000000000000000007
70000007000c6c000000000000000007900000000000000770000000000000099070700777007070070000770000000970070707070000000000000000000007
70000007000666000000000000000007900000000000000770000000000000099077700070000700070000707000000970070707700000000000000000000007
70000077000000000000000000700007900000000000000770000a00000000099070000070000700070000770000000970077707000000000000000000000007
70000000000000000000000000000007900000000000000770000a00000000099070000777007070007700707000000970000000000000000000000000000007
70000000000000000000000000000007900000008800000770000a00000000099000000000000000000000000000000970000000000000000000000000000007
70000000000000000000000000000007900000088000000770000a00000000099000000000000000000000000000000970000000000000000000000000000007
66000000000006666666666666666666000000000000000770000000000000099007000070000700007000090000000970000000000000000000000000000007
76000000000006c60000000000000007900000000000000770000000000000099000000000000000000000000000000970000b00000000000000000000070007
70000000000006660000000000000007900000000000000770000000000000099000000000000000000000000000000977777777777777777777777777790007
70000007700000000000000000000007900009000000000770000000000000099000000000000000000000000000000970000000000000000000000000070007
70000000000000000000000000000007900099900000000770000000000000099055500000000000000000000000000970000000000000000000000000000007
70000000000000000000000000000007900000000000000770000000000000099050500505000000000000000000000970000000000000000000000000000007
70077000000000000000000000000007900000000000000770000000088000099055000555000000000000000000000970000000000000000000000000000007
70077000000000000000000000000007900000000000000770000000088000099050500005000000000000000000000970000000000000000000000000000007
7c077700000000000000000000000007900000000000000770000000000000099055500550000000000000000000000970000000000000000000000000000007
7c077777777777777777700077777777900000000000000770000000000000099000000000000000000000000000000970000000000000000000000000000007
777700000000000000760000067000079000000000000007700000000000000990ddd0000000000000000000000c000970000000000000000000000000000007
700000000000000000070000070000079000000000000007700000000000000990d0d00ddd000dd00dd0000d00c0c00970000000000000000000000000000007
700000000000000000000000000000079000000000000007700000000000000990ddd00ddd00d0d00d0d00d0000c000970000000000000000000000000000007
700000000000000000000000000003079000000002200007700000000000000990d0d00d0d00d0d00dd000d00000000970000000000000000000000000000007
700000000000000000000000000033379000000002000007700000000000000990d0d00d0d00dd000d0d000d000c000970000000000000000000000000000007
70060000000000000000000000000307900000000200000770000000000000099000000000000000000000000000000970000000000000000000000000000007
77777000000000000000000000000007900000000000000770000000000000099006600000000000000000000000000970000000000000000000000000000007
77666000000000000000000000007007900000000000000770000000000000099060000066006660066600066000000970000000000000000000000000000007
7000000000000000000000000000070790000000000000077000e000000000099060000606006660066000600000000970000000000000000000000000000007
700000000000000000000000066c660790000000000000077000e000000000099060600666006060060000006000000970000000000000000000000000009007
7000000000000000000000000666660790000000000000077000ee00000000099066600606006060006600660000000970000000000000000000000000009907
700000c70000000000000000000000779c00000000000007700c0000000000099000000000000000000000000000000970c00000000000000000000009000007
76666677777777777777777777777777999999999999999779999999999999999999999999999999999999999999999977777777777777777777777777779997
ccccccccccccccc00ccccccccccccccc000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000c000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000c000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000c000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000090000000c000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000c000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000c000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000c000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000c000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000090000000000000000000c000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000c000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000c000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000c000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000c000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000c000000000000000000000000000000000000000000000000000000000000000000000000000001111110000000000000
0000000000000000000700000000000c000000000000000000000000000000000000000000000000000000000000000011111111111111777711111111111110
0000000000000000000000000000000c000000000000000000000000000000000000000000000000000000000000000017777177177117511571177771777710
0000000000000000000000000000000c0000000000000000000000000000000000000000000000000000000000000000175571777771171dc171175571755511
0000000000000000000000000000000c0000000000000000000000000000000000000000000000000000000000000000177771757571171dd171177711711771
0000000000000000000000000000000c000000000000000000000000000000000000000000000000000000000000000017557171517115511551175571777751
0000000000000000000000000000000c000000000000000000000000000000000000000000000000000000000000000015115151115111555511151151555511
0000000070000000000000000000000c000000000000000000000000000000000000000000000000000000000000000011111111111111111111111111111111
0000000000000000000000000000000c00000000000000000000000000000000000000000000000000000000000000000011aa11aaa11a1111a11aaa111aa100
0000000000000000000000000000000c0000000000000000000000000000000000000000000000000000000000000000001a4411a4a11aaaaaa11a4411a44100
0000000000000000000000000000000c0000000000000000000000000000000000000000000000000000000000000000001a1111aaa11a4aa4a11aa111aaa100
0000000000000000000000000000000c0000000000000000000000000000000000000000000000000000000000000000001a1a11a4a11a1aa1a11a411144a100
0000000000000000000000000000000c0000000000000000000000000000000000000000000000000000000000000000001aaa11a1a11a1441a11aaa11aa4100
0000000000000000000000000000000c000000000000000000000000000000000000000000000000000000000000000000144411414114111141144411441100
0000000000000000000000000000000c000000000000000000000000000000000000000000000000000000000000000000111111111111111111111111111000
0000000000000000000000000000000c000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__sfx__
010c00001505013050130500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
491100001815000100001001a1501f15000100001001f1551f155001001f1550010000100001001f150001001d1500010000100001001f150001001a150001000010000100001000010000100001000010000100
491100001d1500010000100001001f150001001a150001000010000100181501a15018150001001615018150001001a150001001f15018150001001f105001000c1500c1500c1500c1500c1000c1500c1000c150
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
011a00001800000000000001a0001f00000000000001f0001f000000001f0000000000000000001f000000001d0000000000000000001f000000001a000000001a000180001a0001800022000240001a0001f000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
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
__music__
01 01424344
02 02424344

