pico-8 cartridge // http://www.pico-8.com
version 35
__lua__
-- game
-- amorg

-- unobfuscated code at:
-- git.io/amorg-pico8

#include .code.lua

__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000100000000000000000000000000000000000011100100010000000000000110000000000000000000011000000000010000000000000000001000000
00000001710000000000000000000000000001111000144101210181100000000001661000000000000000000166100000010151001100000000010015101000
00000017771000000000000000000000000016666111494112121ddd210000000015d6100001000000001100016d5100001516d111dd100000011d111d615100
0000017777710000000000000000000000017d66666669912111d66610000000000166d111141000000149111d661000016d676d416d1000001dd614d676d610
0000176777d610000000000000000000001777d666649b2881bd67666100000000167761349910000000199316776100016667776666d100001d667677766610
000017767d66100000010111001000000177777ddd49b788818d777661000000015d676d6791000000001477d776d5100011d6777771100000011677766d1100
00001777d666100000121666112110000017776777749b8e818d7dd1610000000011d7777731000000001367777d1100000011d777641000000146777d110000
00001677d6661000001d666166616100000176777777799821b2d76610000000000146777d110000000011d77764100000001377777d11000011d77776310000
00000177d6610000018d667d676610000000177761114941101d77761000000000011777776d11000011d6677761100000001976d676d510015d677d77410000
0000017746610000001d677d777d21000000011110001441001d676621000000001d666677766610016667776766d10000019943167761000016776139910000
00000174946100000001d677d76d821000000000000001110181dd61100000000001d614d676d610016d676d416dd100000141111d661000000166d111941000
00001479b964100000121ddd2dd18810000000000000000000188216100000000001dd111d615100001516d111d1100000001000016d51000015d61000110000
0001499b7b99410001211b88b1181810000000000000000001882101000000000000110015101000000101510010000000000000016610000001661000000000
00014498829441000012111110010110000000000000000001111000000000000000000001000000000000100000000000000000001100000000110000000000
0001118e881111000001288821000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000128882100000111188e81110000000000000000000000000000000000000000000100000000000000000000000000000011000000000000000000000000
11010011111210000144928894410000000000000001111000000000000000000000001810000000000000000000000000001133100000000000000000000000
181811b88b11210001499b7b994100000000000010128810000000000000000000000018100000000000000000000000000133b1110000000000111000000000
1881dd2ddd121000001469b974100000000000016128810000000000000000000000013b3100000000000000011100000013bb1133100000000133b100000000
128d67d776d1000000016494710000000000000116dd18101110000000000000000001aba10000000000010013b31000001bb13bbb3100000013bbbb11000000
012d777d776d10000001664771000000000000126676d1001441000111100000000013bbb3100000000113113bbb31000013bbbb1b3100000113b13b13110000
0016676d766d8100000166d771000000000000016777d1011494111677710000000011bb310000000113ab31bb1b310000013b113bb100001311bb1bbba31100
01616661666d1000001666d77610000000000001667d2b1289977777776710000001bbb311000000188bbbb31b31b3100000113bbb10000013b13b13bbbb8810
0011211666121000001666d777100000000000161dd7d818e8b9477776777100001bb311b31000000113abbb1bb11310000013bb11000000013b1bb13ba31100
000010011101000000166d7677100000000000166777d818887b94ddd77777100013b1bbbb3100000001131b31b3110000013bbb31000000013bbb3113110000
00000000000000000016d77767100000000000166676db1882b946666d7771000013bbb31bb100000000011bbbb3100000001aba100000000013b31001000000
0000000000000000000177777100000000000001666d11121996666666d7100000013311bb31000000000001b3310000000013b3100000000001110000000000
0000000000000000000017771000000000000012ddd1212114941116666100000000111b33100000000000001110000000000181000000000000000000000000
00000000000000000000017100000000000000011810121014410001111000000000013311000000000000000000000000000181000000000000000000000000
00000000000000000000001000000000000000000100010011100000000000000000001100000000000000000000000000000010000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000110000000000000000000000000000001000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000011611000000000000000000000000000112100000000111111000000000000000000000000000000000000000000000000
000000000000000001111110000001261121100000000000000000000000018dd1100000001777d6100000000000000000000000000000000000000000000000
000000000000000017677710000001666d2881000000000000000000000001dd66610000001777d6610000000000000000001100000000000000001101100000
00000000000000017767771000011d6777d888100000000000000000001111d666610000001777d6661000000000000000001b11111000000000012a1a210000
0000000000000017776777100016616776d818100000000000000000001222d7771d1100001666d66610000000000000000013b133110000000011a333a11000
000000000000001777dddd10011667ddddd101000000000000000000001211d67d6662100017777d666101110000000000013b3333a2100000001333bb3b1000
00000000011101777d66661012d6677722100000000000000000000000121bdd7d77661000017777d666144100000000000013b3b33a10000000133bbbb31000
0000000001441777d666610001dd676ddb11011000000000000000114112118d2d776161000017777446699400000000000013bbbb31000000001133bb311000
000011001499774466661000018ddddd8112114110000000000000149418811b2d67d111000001177499994100000000000013bbbb3a100000001b3bbb3b1000
0001881011499994661100000011121b118884941000000000000014992888111ddd2210000000017797b2111111000000013b33b3a210000001b3b333b33100
001881000189b7966100000000001211188e9994100000000000000169b8e8210188810000000000179b888222210000000013b13b1100000001113111311100
00188810128e8b9610000000000012222888b9710000000000000016697b981000188100000000014999e8811121000000001311111000000000001000100000
0122ddd1118882994100000000001111112b7977100000000000116649999411018810000000000149488811b121110000001100000000000000000000000000
111d76d2b1188149410000000000000014999947711000000001666644779941001100000000000114112118ddddd81000000000000000000000000000000000
161677d2d8112114110000000000000049966447777100000016666d777144100000000000000000011011bdd676dd1000000000000000000000000000000000
016677d7ddb1210000000000000000001441666d77771000016666d77710111000000000000000000000012277766d2100000000000001111110000000000000
012666d76d112100000000000000000011101666d777710001dddd7771000000000000000000000000101ddddd76611011111111111111777711111111111110
0011d1777d2221000000000000000000000001666d6661000177767771000000000000000000000001818d677616610017777177177117511571177771777710
000016666d1111000000000000000000000001666d7771000177767710000000000000000000000001888d7776d11000175571777771171dc171175571755511
00001666dd1000000000000000000000000000166d77710001777671000000000000000000000000001882d666100000177771757571171dd171177711711771
0000011dd81000000000000000000000000000016d77710001111110000000000000000000000000000112116210000017557171517115511551175571777751
00000012110000000000000000000000000000001111110000000000000000000000000000000000000001161100000015115151115111555511151151555511
00000001000000000000000000000000000000000000000000000000000000000000000000000000000000110000000011111111111111111111111111111111
0000000000000000000000000000000000000000000000000000000000777777700000007744999447700000110000000011aa11aaa11a1111a11aaa111aa100
008888000006700000cccc00000800000000000000055000000000000774444477000000077444447700000076100000001a4411a4a11aaaaaa11a4411a44100
08888880000670000cccccc000080000000004000002500002a0a200774499944770000000777777700000007d100000001a1111aaa11a4aa4a11aa111aaa100
28788782000670000cccccc0003b30000034990000b495500a333a007449999944700000000000000000000011000000001a1a11a4a11a1aa1a11a411144a100
08888880009999000cccccc0005b50000667900000499250033bb30074999a9994700000000000000000000000000000001aaa11a1a11a1441a11aaa11aa4100
08828280000440000cccccc003bbb300067730000049b20000bbb0007499a9a99470000000000000000000000000000000144411414114111141144411441100
008828000004400001cccc1000bb300000660000005000000000000074999a999470000000000000000000000000000000111111111111111111111111111000
00000000000000000011110000000000000000000000000000000000744999994470000000000000000000000000000000000000000000000000000000000000
0111111111111100011111111111110001111111111111000111111111111100011111111111110000000000f000000001100011000700002222222003333300
11888888888881101188888888888110118888888888811011bbbbbbbbbbb11011bbbbbbbbbbb11000fffffffff0000016711117007770002882882033bbb330
1887777777778210188777777777821018877777777728101bb777777777b3101bb777777777b3100ffff9ffffff0000177711770777770028e8e8203bbabb30
1877788888777210187777788277721018777777777772101b777777777773101b777777b77773100fffffffffff00001167777600777000228e82203babab30
1877888888877210187777777827721018777777777772101b777777777773101b777777bb777310ffffffffff9f0000001736310077700028e8e8203bbabb30
1878888888887210187777778882721018777777777772101b777777b77773101b77bbbbbbb773100ff9ffffffff000000116991007770002882882033bbb330
18788822288872101877768888827210187666566d8872101b777777bb7773101b773333bb3773100fffff9fffff000000001191007770002222222003333300
18788277788872101877566888827210187665666d8882101b77bbbbbbb773101b777777b37773100fffffffffff000000000011007770000000000000000000
1878877288887210187665668882721018755666d88872101b77bbbbbbb373101b7777773b7773100fffffffff9ff00077777777777000000077777770000000
1878877728887210187d6655582772101876666d887772101b773333bb3773101b77bbbbbbb773100ff9ffffffff000072222722227000000773333377000000
18728877728272101877d666666d7210187dddd8877772101b777777b37773101b773333bb3773100ffffff9ffff000072882228827000007733bbb337700000
187728887727721018777d6666d7721018777777777772101b777777377773101b777777b377731000fffffffff000007288828882700000733bbbbb33700000
1877722277777210187777dddd77721018777777777772101b777777777773101b777777377773100000f000000000007228e8e82270000073bbbabbb3700000
12277777777722101227777777772210122777777777221013377777777733101337777777773310000000000000000077228e822770000073bbababb3700000
1122222222222110112222222222211011222222222221101133333333333110113333333333311000000000000000007228e8e82270000073bbbabbb3700000
0111111111111100011111111111110001111111111111000111111111111100011111111111110000000000000000007288828882700000733bbbbb33700000
01111111111111000111111111111100011111111111110001111111111111000000007770000000000090000000000072882228827000007733bbb337700000
11999999999991101199999999999110119999999999911011bbbbbbbbbbb1100077777c77700000009999999990000072222722227000000773333377000000
1997777777779410199777777777941019977777777794101bb777777777b310077ccccccc770000099999999999000077777777777000000077777770000000
1977999977777410197777777777741019777777777774101b7777777777731077ccccccccc70000099999499999000000000000000000000000000000000000
1977749979777410197779999977741019777777777774101b777777777773107cccccccccc70000009999999999900000000000000000000000000000000000
1977794974977410197799444997741019777997997774101b7777777777731077ccccccccc70000099999999999000000000000000000000000000000000000
1977947477977410197794777497741019777997997774101b777bbbb77b731007ccccccccc70000099999999999000000000000000000000000000000000000
1977977777977410197797779497741019777997997774101b77b3333b3b731007ccccccccc77000099499999999000000000000000000000000000000000000
1977977777977410197797779947741019777997997774101b7b377773bb731007cccccccccc7000999999999490000004444400000000000000000000000000
1977977949477410197799779999741019777997997774101b737777bbbb731007ccccccccc77000099999999999000044999440022022000033300000444000
1977497994777410197749974447741019777447447774101b77777733337310077ccccccc7700000999999999990000499a99400282820003bbb30004999400
1977747999977410197774477777741019777777777774101b777777777773100077c77777700000009999999990000049a9a9400028200003bab300049a9400
1977777444777410197777777777741019777777777774101b7777777777731000077700000000000000000090000000499a99400282820003bbb30004999400
14477777777744101447777777774410144777777777441013377777777733100000000000000000000000000000000044999440022022000033300000444000
11444444444441101144444444444110114444444444411011333333333331100000000000000000000000000000000004444400000000000000000000000000
01111111111111000111111111111100011111111111110001111111111111000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000011000111100000000000000000000000002222000222222
00000001000000000000000000000000000000011110000000000000000000000000000000000000167111177610000000000000000000000022222022222222
0000001d100000000000000000000000000000146771100000000000000000000000000000001100177711777d10000000000000000000000022022022022000
00000019410000000000000000000000000001294677100000110000000000000000000001115100116777761100000000000000000000000022200000022000
000001b99b1000000000001101100000000001499411000000171000110000000000000112b94100001736310000000000000000010000000002220000022000
00000129421000000000115115111000000011494110000001771110151100000000000152994100001169910000000000000000161000000220220000022200
00001554455100000001b25249442100000015941510000001764151252b1100000000015594b100000011910000000000000001677100000222220000022200
0000112242110000001494442499941000000142210000000164941224999d100110001524521000000000110000000000000016777610000022220000002200
000000122410000001d9994221494610000011242211000001499942444941000171111222551000000000000000000000000167777761000002220002222200
00000151495100000011b25215146710000015544551000000124494252b10000177649942151000000000000000000000001677777776100022220002222222
00000114941100000000115101117710000001249210000000011151151100000017499495110000000000000000000000016567777765610022220002200022
00001149941000000000001100017100000001b99b10000000000110110000000001644211000000000000000000000000017756777656610222022002200222
00017764921000000000000000001100000000149100000000000000000000000000111100000000000000001000000000017775676566610220022002202200
0001177641000000000000000000000000000001d100000000000000000000000000000000000000000000017101111111017777565666610222222002200220
000001111000000000000000000000000000000010000000000000000000000000000000000000000000001d711667776d117777756666612220002202222220
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000d76777777776d16777756666512200002200222220
00000000000000000000000000000000000000000000000000000000000000000000000000000000000001d67767777766dd1777756666100000000000000000
000000000000000000000000000000000000001110000000000000000000000000000000000000000000011d66ddddddd66d1777646666100220022200222220
001111100000000000000000000000000000017710000000000000000011000000000000000000000110111ddd7777777dd61677494666100222022202222220
001544b1110000000000000011110000000017710000000000000111113100000000010001000000188011ddd6777776767d51769b9665000022222002220000
000199425510000000000011244610000001646100000000000011b31b3100000011131113111000881181d56777777766661164b7b461100002220002200000
0001b995511000000000115949947100000149410000000000012a3b33b3100000133b333b3b10008881815d56dd7776d66514999b9994100002200002220000
0001225422510000000151249946771000014991100000000001a3bb3b3100000001b3bbb3b100008e888155dd22dddd22514991111199410002200002222220
000015522491000000015522211117100001249251110000000013bbbb3100000001133b331100002888821552bb2552bb251911888819100002200000222220
0000111529421000000125425100011000001942255100000001a33b3b31000000013bbbb33100001228221122bb2222bb8111888e8881100022200000000000
0000000119941000001b495510000000000015224522100000012a3333b310000001b3bb33310000012221221ee888888ee21228888821000222220000000000
0000000014941000001499251000000000000115599b1000000011331b31000000011a333a110000001111111128288282111188888810000220222000000000
000000001646100000149b211000000000000155249910000000011111b10000000012a1a2100000000000011211822811121111288210000220222000000000
00000000177100000015111000000000000000111b44510000000000001100000000011011000000000000182212111121882100111100000222200000000000
00000001771000000011000000000000000000000111110000000000000000000000000000000000000000188111211210181000000000000222220000000000
00000001110000000000000000000000000000000000000000000000000000000000000000000000000000011100101110110000000000000220222000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000220022000000000
__gff__
0000000000000000000000000000000000000000000023000000000000000000000000230000000000000000000000000000000000002300000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__map__
727272727272727f727272727272727f727200007300727f727272727272727f727200007272727f727200710072727f727271007372727f000000000000007f000000000000007f000000000000007f000000000000007f000000000071707f000000000075007f747200000072747f727200710072727f000000727274727f
720000000000727f720000000072727f000000720000727f727200730072727f727472000072727f720000700000727f727000000000727f747200000072747f007300007300007f007200000075007f000000750072007f000074000000007f007300727400757f720000000000727f720000700000727f000072720074727f
000000000000007f007071000000727f007270000000727f727300000073727f007200000073007f007200000072007f720000000074727f000000700000007f000000000000007f000000007200007f007200000000007f000000000000007f000000007274007f000000720000007f000000000000007f007200737372727f
007071000073007f000000007300007f007100000000727f000072007200007f000000007200007f000072007200007f720000720000727f000000710000007f000000700000007f000000007100007f000000000000007f007400000000007f000000000072007f000072747200007f000000000000747f007200710072007f
000000000000727f000072000000007f000000007273727f000000000000007f720000700000007f740000000000747f727273000072727f007200000072007f730071000073007f720000700000007f000071700000007f000000720000007f000071000000007f000000720000007f000000007472727f007270000072007f
720000000072727f720000730000727f727200000000727f720000700000727f720000727100727f720000730000727f727472000000727f007472727274007f000000000000007f000000000072007f000000007200007f000075000000737f007000000073007f720000710000727f000074727272727f000072727200007f
727272727272727f727200000072727f727272727272727f727200710072727f727200000000727f727200000072727f727272727272727f000000000000007f000000730000007f000000000000007f000000000073007f000000000000007f000000000000007f747200700072747f747272727272727f000000000000007f
7f7f7f7f7f7f7f7f7f7f7f7f7f7f7f7f7f7f7f7f7f7f7f7f7f7f7f7f7f7f7f7f7f7f7f7f7f7f7f7f7f7f7f7f7f7f7f7f7f7f7f7f7f7f7f7f7f7f7f7f7f7f7f7f7f7f7f7f7f7f7f7f7f7f7f7f7f7f7f7f7f7f7f7f7f7f7f7f7f7f7f7f7f7f7f7f7f7f7f7f7f7f7f7f7f7f7f7f7f7f7f7f7f7f7f7f7f7f7f7f7f7f7f7f7f7f7f7f
000000000000007f000000000000007f000000000000007f000000000000007f000000000000007f000000000000007f000000000000007f000000000000007f000000000000007f000000000000007f000000000000007f000000000000007f000000000000007f000000000000007f000000000000007f000000000000007f
000000000000007f000000000000007f000000000000007f000000000000007f000000000000007f000000000000007f000000000000007f000000000000007f000000000000007f000000000000007f000000000000007f000000000000007f000000000000007f000000000000007f000000000000007f000000000000007f
000000000000007f000000000000007f000000000000007f000000000000007f000000000000007f000000000000007f000000000000007f000000000000007f000000000000007f000000000000007f000000000000007f000000000000007f000000000000007f000000000000007f000000000000007f000000000000007f
000000000000007f000000000000007f000000000000007f000000000000007f000000000000007f000000000000007f000000000000007f000000000000007f000000000000007f000000000000007f000000000000007f000000000000007f000000000000007f000000000000007f000000000000007f000000000000007f
000000000000007f000000000000007f000000000000007f000000000000007f000000000000007f000000000000007f000000000000007f000000000000007f000000000000007f000000000000007f000000000000007f000000000000007f000000000000007f000000000000007f000000000000007f000000000000007f
000000000000007f000000000000007f000000000000007f000000000000007f000000000000007f000000000000007f000000000000007f000000000000007f000000000000007f000000000000007f000000000000007f000000000000007f000000000000007f000000000000007f000000000000007f000000000000007f
000000000000007f000000000000007f000000000000007f0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
7f7f7f7f7f7f7f7f7f7f7f7f7f7f7f7f7f7f7f7f7f7f7f7f0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
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
