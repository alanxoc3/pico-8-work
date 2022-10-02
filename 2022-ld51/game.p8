pico-8 cartridge // http://www.pico-8.com
version 38
__lua__
-- game
-- amorg

-- unobfuscated code at:
-- git.io/amorg-pico8

#include .code.lua

__gfx__
000000000000000000000000000000000000000000000000000000000000d00d0000000000000000000dd0500000d005d6666ddd0098880000000000000000b3
0000000001771101000000000177110100000000000000000000000000110d050000d00d0011d05000d0d95900110d05d76666dd09988820000000000000003b
007007001777177d017711011777177d00000000000000000000000001550d5500110d0501550d550011dd5501550d550d766dd089a9888200000000000000bb
00077000d77671711777177dd776717100000000000000000000000015dd59590155055515dd59590155dd5015dd5d550d666dd08a99988200000000000000bb
00077000dd661171d7767171dd66117100000000000000000000000015dd5d5515dd595915dd5d5515dd551015dd59590d76ddd088999982000000000000007b
007007001dd1e66edd6611711dd1e66e0000000000000000000000000155151015dd5d550155151015dd51500155d5100d666d002889994400000000000000bb
0000000011511dd01dd1e66e11511dd00000000000000000000000000d11d150015515100d11510001551d055011d15000d6dd0002889440b3b7bb3b0000003b
000000001101100011511dd0011011000000000000000000000000000d00d0500d11d150d005000005110000000d005000d66d00002222003bbbbbb3000000b3
0000000000000000000000000000110101771101000000000000000000000000000000055666666550000000051d11d000d6dd00008884003b00000028888882
0111111001771101000000000177177d1777177d1777700000000000000000000000005dd566665dd50000000151551000d6d00008888940b300000088888888
017777101777177d0177110117777171d7767171777711d10177110100000000000005dddd5665dddd50000055d5dd51000dd00088e89992bb00000088155188
01771710d77671711777177dd7761171dd661171d776177d1777177d0000000000005dddddd55dddddd500002125dd51000dd0008e899992bb000000885cc588
01717710dd661171d7767171dd66e66e1dd1e66edd667171d77671710000000000055dddddd55dddddd5500011105510000d000088999982b7000000885cc588
016777101dd1e66edd6611711dd1ddd01151ddd01ddd1171dd66117100000000005665dddd5665dddd56650050d01100000d000099999882bb00000088155188
0111111011511dd01dd1e66e11551100000000001151e66e1dd1e66e000000000566665dd566665dd5666650d0d000000000000009998820b300000088888888
000000001101100011511dd0110000000000000000011dd011511dd0000000005666666556666665566666650000000000000000002222003b00000028888882
00000000000000000000000000000000000000000010110000bbb0000000000077000000000007700000000000a7a000007aaa0011111111111111111cccccc1
000000000000000000000000000000000000000000d771d003333300000700777700000000007770777000000a7a490007a449a0100000011cccccc1cccccccc
000d0500017711010000000000000000000000000017176003bbb300007707777677700000707767777770000aa494000a499490100000011cccccc1cc1551cc
001d55001777177d000000000000000000000000001711d103bbb300007766dd666777000076766dd66600000aa494000a499490100000011cccccc1cc5885cc
00d959007776d1d100000000000000000000000000e66e1103bbb3000076dddd6dd600000776dd6dddd777000aa494000a499490100000011cccccc1cc5885cc
00dd5500ddd511510000000000000000000000000077776503bbb3007766ddddddd670000776ddddddd677700a9949000a944990100000011cccccc1cc1551cc
0000000015d1dddd000000000000000000000000001776d103bbb30077666d505ddd7700077ddd505d6667700049900000499900100000011cccccc1cccccccc
00000000115115500000000000000000000000000001dd1103333300077ddd000ddd7700007ddd000ddd7000000000000000000011111111111111111cccccc1
00000000000000000000000000000000000000000000000000000000077ddd505d66777077666d505ddd7700000aa000000aa900299999922222222222222222
001101000000000000000000000000000000000000000000000000000076ddddddd667707776ddddddd677000007a00000a4aa90429999242000000228888882
00177d000000000000000000000000000000000000000000000000000006dd6dddd670000777dddd6dd67700000aa00000494a90442992442000000228888882
007171000000000000000000000000000000000000000000000000000777666dd6677000000666dd66767000000aa00000494a90444224442000000228888882
0011710000000000000000000000000000000000000000000000000000777667770770000077777767707000000aa00000494a90444224442000000228888882
00e66e0000000000000000000000000000000000000000000000000000000777700700000000777077700000000a900000a49940442992442000000228888882
00000000000000000000000000000000000000000000000000000000000007700000000000000000770000000004400000099400429999242000000228888882
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000299999922222222222222222
0000000000eeee00000000006d0d1d0000000000000000000000000000000000999999993333333300000000111111110000000001100000dd0dd0dd56666665
000000000e8228e00eeeeee0d60dd101022222222222222002444244442444209999999933333333000000001d6666d10000000011d10000dd0dd0ddd566665d
00000000e8288288e82222880000000002444244442444200444424444244440944444490000000000000000161771610000000116661000d101101d00000000
00666600e2888828e28888280ddd0d10024294992929242004429499292924400000000000000000000000001617716100000011617661000000000000000000
0d667760e2888828e822228806dd011002999499994999200499949999499940400000040000000000000000167777610000011671776d101000000100000000
0d66776088288288888888880000000002999499994999200499949999499940000000000000000000000000161771610000116177716d100000000000000000
0dd666600882288008888880dd0dd101029994999949992004999499994999400000000000000000000000001617716100011671777161000000000000000000
00dd660000888800000000006d0d1d00029994999949992004999499994999400000000000000000000000001677776100116757717610000000000000000000
00dddd000000000000000000d6000000029994999949992004999499994999400000000333333333300000001655556101161775716100001111111111111111
0dd666d00eeeeee000000000000dd011029994999949992004999499994999400000003333333333330000001677776111671777561000001d666666666666d1
0d667760e8888888eeeeeeee6d0d10110299949999499920049994999949994000000333bbbbbbbb33300000161777611d677777610000001667117571171161
0d667770e8222288e8888888dd0d1010029994999949992004999499994999400000333bbbbbbbbbb33300001617776116677176100000001677777577777761
0d667770e2888828888888880000000002429492994924200442949299492440000333bbbbbbbbbbbb3330001677716101667161000000001677777577777761
d66677768822228800000000d6d0d1010244422444244420044442444424444000333bbbb9bb9bb9bbb333001667716100166610000000001611777571171161
dd66776d08888880000000006dd01d00022222222222222002444244442444200333bb999999999999bb33301d6666d10001d100000000001d666666666666d1
ddd666dd00000000000000000000000000000000000000000000000000000000333b9999999999999999b3331111111100001000000000001111111111111111
3bbbbbb30000000000000000000000004a9400000000009009000000008880005dd5ddd5ddd0dddddd000ddd0000000000000000000001111110000000000000
3333333300000000000000000ddddd104a94000000009009900900000888e800d665666dd6d0d66ddd000dd00000000011111111111111777711111111111110
0060060000000000001dd10001ddddd04a940000000009944990000002888800d665666dddd0d6d000000d000000000017777177177117511571177771777710
000660003bbbbbb300d6dd0001dd66d04a940000000000f99f000000028888005555d65d00005d000000000000000000175571777771171dc171175571755511
000dd0003333333300dddd000ddddd104a940000000f00099000f00002228200d66555ddddd0000d0000000000000000177771757571171dd171177711711771
00d00d0000d00d00001dd100000dd1004a9400000000f940049f000000282000d666566dd6dd0ddddd00000d0000000017557171517115511551175571777751
3bbbbbb33bbbbbb3000000000dddddd04a940000000009944990000000060000d666566dd66d0d6dddd000dd0000000015115151115111555511151151555511
333333333333333300000000011111104a940000000000f99f000000000600005ddd5dd5dddd0dddddd000dd0000000011111111111111111111111111111111
000000000000000000000000000000004a940000000000000000000000060000000000002244442222444422000000000011aa11aaa11a1111a11aaa111aa100
000000000000000000000000000000004a940000000000000000000000006000000000002441114224444442000a9400001a4411a4a11aaaaaa11a4411a44100
000000000000000000000000000000004444000000000000000000000000600000000000244141422444444200090400001a1111aaa11a4aa4a11aa111aaa100
000000000000000000000000000000000000000000070070000700700000600000000000244111422444444200099400001a1a11a4a11a1aa1a11a411144a100
000444444444400000000000000000000000000007070060070700600006000000000000244414422444444200009000001aaa11a1a11a1441a11aaa11aa4100
00049aaaaaa94000000000000000000000000000060670670606706700060000000000002441144224444442000a900000144411414114111141144411441100
00049999999940000004444444444000000000006506606565066065000600000000000024411442244444420009400000111111111111111111111111111000
05555555555555500555555555555550000000005605605656056056000000000000000022444422224444220000000000000000000000000000000000000000
95000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
95000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
95000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
95000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
95000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
95000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
95000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
95000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
95000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
95000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
95000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
95000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
95000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
95000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
95000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
95959595959595959595959595959595959595959595959595959595959595959595959595959595959595959595959595959595959595959595959595959595
95959595959595959595959595959595959595959595959595959595959595959595959595959595959595959595959595959595959595959595959595959595
95000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
95000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
95000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
95000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
95000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
95000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
95000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
95000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
95000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
95000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
95000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
95000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
95000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
95000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
95000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
95959595959595959595959595959595959595959595959595959595959595959595959595959595959595959595959595959595959595959595959595959595
95959595959595959595959595959595959595959595959595959595959595959595959595959595959595959595959595959595959595959595959595959595
__gff__
0000000000000100000000000000000000000000000000010181010000000000000000010000810000000000000000000000000101000100000000000081000000000000010101018882000000000082000000000101010182818400000000000000000001000000010101000000000000000000010000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__map__
5900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000002600000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000190000000059010203040506
5900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000002600000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000190000000059111213141516
5900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000002600000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000190000000059212223242526
5900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000002600000000000000000000000000000000000000000000000000000000000000000000000027280000000000000027280000000000000000000000000000000000000000190000000059313233343536
5900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000002600000000000000000000000000000000000000000000000000000000000000000000000037380000000000000037380000000000000000000000000000000000000000190000000059000000000059
5900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000002600000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000190000000059000000000059
5900000000000000000000000000000000000000000000000000000000000000000000000000000000000000007b00002600000000000000000000000000000000000000000000000000000000000000000000000000000000272800000000000000000000000000400000000000000000000000190000000059000000000059
5900000000000000000000000000000000000000000000000000000000264848264848000000484848000000484848002600000000000000000000000000000000000000000000000000000000000000000000000000000000373800000000000000004100000000500000000000000000000000190000000059000000000059
5900000000000000000000000000000000000000000000000000000000260000260000000000000000000000000000002600000000000000000000000000000000000000000000000000000000000000000000001919191919191919191919191919191919191919191919191919191948484848190000000059000000000059
59000000000000000000000000000000000000000000000000000000002600002600000000000000000000000000000026000000000000000000000000000000000000000000000000000000000000000000000000000c0000000c0000000c00000000000000000000000c0c0c0c0c0c00000000190000000059000000000059
5900000000000000000000000000000000000000000000000000000000260000260000000000000000000000000000007a000000000000000000000000000000000000000000002600000000000000000000000000001c0000001c0000001c00000000000000000000001c1c1c1c1c1c00000000190000000059000000000059
5900300000000000000000000000004848594826000000000000000000260000260000000000000000000000000000007a00000000000000000000000000000000000000000000260000000000000000000000000000000000000000000000000000000000000000000000000000000000000000190000000000000000000059
5900000010000000000000000000000000000026000000000000000000260000260000000000000000000000000000007900000000000000000000000000000000000000000000260000000000000000000000000000000000000000000000000000000000000000000000000000000000000000190000000000000000000059
59595959595a0000000000000000000000005926000046470000000000640000260000000000000000000000000000007a000000000000000000000000000000000000000000002600000000004b0000000000000000000000000000000000000000000000000000000000000000000000000000190000000000000000000059
5959595959595a00000000000000000000595926707156570000000000640000260000000000757575000000000000007a000000000000007676000000000075750000000d00002600000000005b0000000000000000000000000000000000000000000000000000000000000000000000600000190000000059000000000059
5959595959595959595959595959595959595959595959595959595959595959595959595959595959595959595959595959595959595959595959595959595959595959595959595959595959595959595959595959595959595959595959595959595959595959595959595959595959595959595959595959595959595959
5959595959595959595959595959595959595959595959595959595959595959595959595959595959595959595959595900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
5959595959595959595959595959595959595959595959595959595959595959595959595959595959595959595959595900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
5959595959595959595959595959595959595959595959595959595959595959595959595959595959595959595959595900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
5959595959595959595959595959595959595959595959595959595959595959595959595959595959595959595959595900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
5900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
5900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
5900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
5900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
5900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
5900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
5900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
5900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000980000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
5900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
5900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
5900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
5959595959595959595959595959595959595959595959595959595959595959595959595959595959595959595959595959595959595959595959595959595959595959595959595959595959595959595959595959595959595959595959595959595959595959595959595959595959595959595959595959595959595959
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
