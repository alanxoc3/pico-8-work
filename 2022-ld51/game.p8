pico-8 cartridge // http://www.pico-8.com
version 38
__lua__
-- game
-- amorg

-- unobfuscated code at:
-- git.io/amorg-pico8

#include .code.lua

__gfx__
000000000000000000000000000000000000110100000000000000000000d00d0000000000000000000dd0500000d005d6666ddd009888000000000000000000
000000000177110100000000017711010177177d017711010177700000110d050000d00d0011d05000d0d95900110d05d76666dd0998882001aa110100000000
007007001777177d017711011777177d177771711777177d177711d101550d5500110d0501550d550011dd5501550d550d766dd089a988821aaa1aa401aa1101
00077000d77671711777177dd7767171d7761171d7767171d776177d15dd59590155055515dd59590155dd5015dd5d550d666dd08a9998824aa9a1a11aaa1aa4
00077000dd661171d7767171dd661171dd66e66edd661171dd66717115dd5d5515dd595915dd5d5515dd551015dd59590d76ddd088999982449911a14aa9a1a1
007007001dd1e66edd6611711dd1e66e1dd1ddd01dd1e66e1ddd11710155151015dd5d550155151015dd51500155d5100d666d00288999441441e99e449911a1
0000000011511dd01dd1e66e11511dd0115511001151ddd01151e66e0d11d150015515100d11510001551d055011d15000d6dd0002889440115114401441e99e
000000001101100011511dd001101100110000000000000000011dd00d00d0500d11d150d005000005110000000d005000d66d00002222001101100011511440
0000000000000000000000000000000000000000000000000000000000000000000000055666666550000000051d11d000d6dd00008884000000000000001101
01111110000000000000000000000000000717700000000000000000000000000000005dd566665dd50000000151551000d6d0000888894001aa110101aa1aa4
0177771007771770000011000000000007777170077717700077100000000000000005dddd5665dddd50000055d5dd51000dd00088e899921aaa1aa41aaaa1a1
017717100776717007771770077671700776117007767170077617700000000000005dddddd55dddddd500002125dd51000dd0008e8999924aa9a1a14aa911a1
017177100d661770077671700d6611700d66e6600d6611700d6671700000000000055dddddd55dddddd5500011105510000d000088999982449911a14499e99e
016777100dd1e0000d6611700dd1e6600dd1d0000dd1e660066d117000000000005665dddd5665dddd56650050d01100000d0000999998821441e99e14414440
0111111001511d000dd1e66001511d0001000000000000000001e000000000000566665dd566665dd5666650d0d0000000000000099988201151144011551100
00000000000000000000000000000000000000000000000000000000000000005666666556666665566666650000000000000000002222000110110011000000
00000000000000000000000333333333300000000010110000bbb0000000000077000000000007700000000000a7a000007aaa00000000000000000000000000
000000000000000000000033333333333300000000d771d003333300000700777700000000007770777000000a7a490007a449a00000000001aa110101aaa000
017711010000000000000333bbbbbbbb333000000017176003bbb300007707777677700000707767777770000aa494000a499490000000001aaa1aa41aaa1141
1777177d000000000000333bbbbbbbbbb3330000001711d103bbb300007766dd666777000076766dd66600000aa494000a499490000000004aa9a1a14aa91aa4
7776d1d100000000000333bbbbbbbbbbbb33300000e66e1103bbb3000076dddd6dd600000776dd6dddd777000aa494000a49949000000000449911a14499a1a1
ddd511510000000000333bbbb9bb9bb9bbb333000077776503bbb3007766ddddddd670000776ddddddd677700a9949000a944990000000001441e99e144411a1
15d1dddd000000000333bbb9999999999bbb3330001776d103bbb30077666d505ddd7700077ddd505d666770004990000049990000000000115144401151e99e
1151155000000000333bbb999999999999bbb3330001dd1103333300077ddd000ddd7700007ddd000ddd70000000000000000000000000000000000000011440
000000000000000033bbb99999999999999bbb330000000000000000077ddd505d66777077666d505ddd7700000aa000000aa900299999920000000000101100
00000000000000003bbb9999999999499999bbb3000071d0000000000076ddddddd667707776ddddddd677000007a00000a4aa904299992400000000004aa140
0000000000000000bbb999999999999999999bbb00071760000000000006dd6dddd670000777dddd6dd67700000aa00000494a904429924401aa1101001a1a90
0000000000000000bb99999999999999999999bb000711d1000000000777666dd6677000000666dd66767000000aa00000494a90444224441aaa1aa4001a1141
0000000000000000b9999999999999999999999b00066e110000000000777667770770000077777767707000000aa00000494a9044422444aaa9414100e99e11
0000000000000000999994999499999999499999000777650000000000000777700700000000777077700000000a900000a49940442992444445115100aaaa95
0000000000000000999999999999999999999999000776d1000000000000077000000000000000007700000000044000000994004299992415414444001aa941
00000000000000009999999999999999999999990000000000000000000000000000000000000000000000000000000000000000299999921151155000014411
0000000000eeee00000000006d1d5d1100000000000000000000000000000000999999999999999900000000000000000000000000000000dd0dd0dd56666665
000000000e8228e00eeeeee0d61dd5150222222222222220024442444424442099999999999999490000000001ee11010000000001ee1101dd0dd0ddd566665d
00000000e8288288e822228811111111024442444424442004444244442444409444444999999999000000001eee1ee201ee11011eee1ee2d101101d00000000
00666600e2888828e28888281ddd1d51024294992929242004429499292924400000000099999999000000002ee8e1e11eee1ee22ee8e1e10000000000000000
0d667760e2888828e822228816dd155102999499994999200499949999499940400000049999999900000000228811e12ee8e1e1228811e11000000100000000
0d667760882882888888888811111111029994999949992004999499994999400000000094999999000000001221e88e228811e11221e88e0000000000000000
0dd666600882288008888880dd1dd51502999499994999200499949999499940000000009999999900000000115112201221e88e115112200000000000000000
00dd660000888800000000006d1d5d11029994999949992004999499994999400000000099999999000000001101100011511220011011000000000000000000
00dddd000000000000000000d6111111029994999949992004999499994999400000000333333333300000000000110100000000000000000000000000101100
0dd666d00eeeeee000000000111dd1550299949999499920049994999949994000000033333333333300000001ee1ee201ee110101eee00000000000002ee120
0d667760e8888888eeeeeeee6d1d51550299949999499920049994999949994000000333bbbbbbbb333000001eeee1e11eee1ee21eee112101ee1101001e1e80
0d667770e8222288e8888888dd1d5151029994999949992004999499994999400000333bbbbbbbbbb33300002ee811e12ee8e1e12ee81ee21eee1ee2001e1121
0d667770e2888828888888881111111102429492994924200442949299492440000333bbbbbbbbbbbb3330002288e88e228811e12288e1e1eee8212100e88e11
d66677768822228800000000d6d1d5150244422444244420044442444424444000333bbbb9bb9bb9bbb33300122122201221e88e122211e12225115100eeee85
dd66776d08888880000000006dd15d11022222222222222002444244442444200333bb999999999999bb333011551100115122201151e88e15212222001ee821
ddd666dd00000000000000001111111100000000000000000000000000000000333b9999999999999999b3331100000000000000000112201151155000012211
3bbbbbb30000000000000000000000004a9400000000006006000000008880005dd5ddd5dd000ddd000000000000000000000000000001111110000000000000
3333333300000000000000000ddddd104a94000000006006600600000888e800d665666ddd000dd0000000000000000011111111111111777711111111111110
0060060000000000001dd10001ddddd04a940000000006655660000002888800d665666d00000d00000000000000000017777177177117511571177771777710
000660003bbbbbb300d6dd0001dd66d04a9400000000007667000000028888005555d65d000000000000000000000000175571777771171dc171175571755511
000dd0003333333300dddd000ddddd104a940000000700066000700002228200d66555dd000000000000000000000000177771757571171dd171177711711771
00d00d0000d00d00001dd100000dd1004a940000000076500567000000282000d666566ddd00000d000000000000000017557171517115511551175571777751
3bbbbbb33bbbbbb3000000000dddddd04a940000000006655660000000060000d666566dddd000dd000000000000000015115151115111555511151151555511
333333333333333300000000011111104a9400000000007667000000000600005ddd5dd5ddd000dd000000000000000011111111111111111111111111111111
000000000000000000000000000000004a940000000000000000000000060000000000002244442222444422000000000011aa11aaa11a1111a11aaa111aa100
000000000000000000000000000000004a940000000000000000000000006000000000002441114224444442000a9400001a4411a4a11aaaaaa11a4411a44100
000000000000000000000000000000004444000000000000000000000000600000000000244141422444444200090400001a1111aaa11a4aa4a11aa111aaa100
000000000000000000000000000000000000000000070070000000000000600000000000244111422444444200099400001a1a11a4a11a1aa1a11a411144a100
000444444444400000000000000000000000000007070060000000000006000000000000244414422444444200009000001aaa11a1a11a1441a11aaa11aa4100
00049aaaaaa94000000000000000000000000000060670670000000000060000000000002441144224444442000a900000144411414114111141144411441100
00049999999940000004444444444000000000006506606500000000000600000000000024411442244444420009400000111111111111111111111111111000
05555555555555500555555555555550000000005605605600000000000000000000000022444422224444220000000000000000000000000000000000000000
00000000000000000000000000003500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000003500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000003500d20000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000000000000034e4e4e435353535353535353535353535353535353535000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000350000000000000000c000000000000000c00000000062000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000350000000000000000c100000000000000c10000000062000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000003500000000000000000000000000000000000000000062000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000620000003406060000000000000000000000000000000000000062000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000628686863435350000728200002600007282000000000000000062000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000760000620000000000000000738300e4e4e400738300e4e4e4e462000062000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00010000000000770000620000000000000000000000000000000000000000000062000062000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00260000007600000000620000000000000000000000000000000000000000000062000062000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
95959500007700000000620000000000000000000000000000000000000000000062000062000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
3333330000000000000062000000000026d200000000000000000000000000000000000062000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
33333300000000000000625757575757959595950000d00000000000140000000000000062000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
33333395959595953232329595959595949494949595959595959595959595959595959595959595959595959595959595959595959595959595959595959595
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
0000000000000000000000000000000000000000000000010181010000000000000084818400910000000000000000000100848184000100000000000081000000000081010101018881000000008888000000810101010182818400000000000000000001000081810100000000000000000000010000010000000000000000
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
5900000000000000000000000000000000000026000000000000000000260000260000000000000000000000000000007900000000000000000000000000000000000000000000260000000000000000000000000000000000000000000000000000000000000000000000000000000000000000190000000000000000000059
59595959595a0000000000000000000000005926000046470000000000640000260000000000000000000000000000007a000000000000000000000000000000000000000000002600000000004b0000000000000000000000000000000000000000000000000000000000000000000000000000190000000000000000000059
4949494949345a00000000000000000000595926707156570000000000640000260000000000757575000000000000007a000000000000007676000000000075750000000d00002600000000005b0000000000000000000000000000000000000000000000000000000000000000000000600000190000000059000000000059
4949494949493459595959595959595959595959595959595959595959595959595959595959595959595959595959595959595959595959595959595959595959595959595959595959595959595959595959595959595959595959595959595959595959595959595959595959595959595959595959595959595959595959
4949494949494949494949494949494949494949494949494949494949494949494949494949494949494949494949494949494949494949494949494949494949494949494949494949494949494949494949494949494949494949494949494949494949494949494949494949494949494949494949494949494949494949
4949494949494949494949494949494949494949494949494949494949494949494949494949494949494949494949494949494949494949494949494949494949494949494949494949494949494949494949494949494949494949494949494949494949494949494949494949494949494949494949494949494949494949
4949494949494949494949494949494949494949494949494949494949494949494949494949494949494949494949494949494949494949494949494949494949494949494949494949494949494949494949494949494949494949494949494949494949494949494949494949494949494949494949494949494949494949
4949494949494949494949494949494949494949494949494949494949494949494949494949494949494949494949494949494949494949494949494949494949494949494949494949494949494949494949494949494949494949494949494949494949494949494949494949494949494949494949494949494949494949
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