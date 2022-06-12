pico-8 cartridge // http://www.pico-8.com
version 35
__lua__
-- game
-- amorg

-- unobfuscated code at:
-- git.io/amorg-pico8

#include .code.lua

__gfx__
00000000000000000000000000000000000000000001011100100000000000000000000000000000000000000000000000000000000000001000000000000000
00000000000000000000000000000000100010000012166611211000000001111000000000001100000000000000010000000000000000112100000000000000
0070070000000000000000000000000121018110001d6661666161000010128810000000000188100010000000001211111100000000018dd110000000000000
00077000000000001100000000000012121ddd21018d667d67661000016128810000000000188100018110000001888222210000000001dd6661000000000000
0007700000000001881000000000012111d66610001d677d777d21000116dd181000000000188810128e81000001e88111210000001111d66661000000000000
0070070000000018e881000000001881bd6766610001d677d76d8210126676d1000000000122ddd11188821000188811b1211100001222d7771d110000000000
000000000000001288821000000188818d77766100121ddd2dd18810016777d101100000111d76d2b118810000012118ddddd810001211d67d66621000000000
00000000011010011111210000018e818d7dd16101211b88b118181001667d2b12810000161677d2d8112100000011bdd676dd1000121bdd7d77661000000000
000700000181811b88b1121000001821b2d766100012111110010110161dd7d818e81000016677d7ddb121000000012277766d210012118d2d77616100000000
0077700001881dd2ddd12100000001101d7776100001288821000000166777d818881000012666d76d11210000101ddddd7661100018811b2d67d11100000000
077777000128d67d776d1000000000001d6766210000188e81000000166676db188100000011d1777d22210001818d6776166100012888111ddd221000000000
007770000012d777d776d1000000000181dd6110000001881000000001666d1112100000000016666d11110001888d7776d110000018e8210188810000000000
0077700000016676d766d8100000000018821610000000110000000012ddd1212100000000001666dd100000001882d666100000000118100018810000000000
00777000001616661666d1000000000188210100000000000000000001181012100000000000011dd81000000001121162100000000001000188100000000000
00777000000112116661210000000001111000000000000000000000000100010000000000000012110000000000011611000000000000000011000000000000
00777000000001001110100000000000000000000000000000000000000000000000000000000001000000000000001100000000000000000000000000000000
000000000000000000000000000000000000000000000000f0000000000090000000000000000000000000000000000000000000000000001100000000000000
000000000000000000000000000000000000000000fffffffff00000009999999990000000000000000000000000000000000000000000116110000000000000
00000000000000000000000000000000000000000ffff9ffffff0000099999999999000000000000000000000000000000000000000001261121100000000000
00000000000000000000000000000000000000000fffffffffff0000099999499999000000000000000000000000000000000000000001666d28810000000000
0000000000000000000000000000000000000000ffffffffff9f000000999999999990000000000000000000000000000000000000011d6777d8881000000000
00000000000000000000000000000000000000000ff9ffffffff00000999999999990000000000000000000000000000000000000016616776d8181000000000
00000000000000000000000000000000000000000fffff9fffff0000099999999999000000000000000000000000000000000000011667ddddd1010000000000
00000000000000000000000000000000000000000fffffffffff000009949999999900000000000000000000000000000000000012d667772210000000000000
00000000000000000000000000000000000000000fffffffff9ff00099999999949000000000000000000000000000000000000001dd676ddb11000000000000
00000000000000000000000000000000000000000ff9ffffffff0000099999999999000000000000000000000000000000000000018ddddd8112100000000000
00000000000000000000000000000000000000000ffffff9ffff00000999999999990000000000000000000000000000000000000011121b1188810000000000
000000000000000000000000000000000000000000fffffffff0000000999999999000000000000000000000000000000000000000001211188e100000000000
00000000000000000000000000000000000000000000f00000000000000000009000000000000000000000000000000000000000000012222888100000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000011111121000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000010000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00888888888880000088888888888000008888888888800000bbbbbbbbbbb00000bbbbbbbbbbb000000000000000000000000000000000000000000000000000
0887777777772200088777777777220008877777777722000bb77777777733000bb7777777773300000000000000000000000000000000000000000000000000
0877777777777200087777778277720008777777777772000b777777777773000b77777777777300000000000000000000000000000000000000000000000000
0877788888777200087777777827720008777777777772000b777777777773000b7777777b777300000000000000000000000000000000000000000000000000
0877888888877200087777777887720008777777777772000b777777777773000b7777777bb77300000000000000000000000000000000000000000000000000
0878888888887200087777778882720008777777777772000b7777777b7773000b77bbbbbbbb7300000000000000000000000000000000000000000000000000
08788822288872000877768888827200087666566d8872000b7777777bb773000b7733333bb37300000000000000000000000000000000000000000000000000
08788277788872000877566888827200087665666d8882000b77bbbbbbbb73000b7777777b377300000000000000000000000000000000000000000000000000
0878877288887200087665668882720008755666d88872000b7733333bb373000b77777773b77300000000000000000000000000000000000000000000070000
0878877728887200087d6655582772000876666d887772000b7777777b3773000b77bbbbbbbb7300000000000000000000000000000000000000000000777000
08728877728272000877d666666d7200087dddd8877772000b777777737773000b7733333bb37300000000000000000000000000000000000000000007777700
087728887727720008777d6666d7720008777777777772000b777777777773000b7777777b377300000000000000000000000000000000000000000000777000
0876722277776200086777dddd77620008677777777762000b677777777763000b67777773776300000000000000000000000000000000000000000000777000
0826666666662200082666666666220008266666666622000b366666666633000b36666666663300000000000000000000000000000000000000000000777000
00222222222220000022222222222000002222222222200000333333333330000033333333333000000000000000000000000000000000000000000000777000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000777000
00999999999990000099999999999000009999999999900000bbbbbbbbbbb0000777777777777700000000000000000000000000000001111110000000000000
0997777777774400099777777777440009977777777744000bb77777777733007777777777777770000000000000000011111111111111777711111111111110
0977777777777400097777777777740009777777777774000b777777777773007777777777777770000000000000000017777177177117511571177771777710
0977999977777400097777777777740009777777777774000b7777777777730077777777777777700000000000000000175571777771171dc171175571755511
0977749979777400097779999977740009777777777774000b7777777777730077777777777777700000000000000000177771757571171dd171177711711771
0977794974977400097799444997740009777997997774000b777bbbb77b73007777777777777770000000000000000017557171517115511551175571777751
0977947477977400097794777497740009777997997774000b77b3333b3b73007777777777777770000000000000000015115151115111555511151151555511
0977977777977400097797779497740009777997997774000b7b377773bb73007777777777777770000000000000000011111111111111111111111111111111
0977977777977400097797779947740009777997997774000b737777bbbb7300777777777777777000000000000000000011aa11aaa11a1111a11aaa111aa100
0977977949477400097799779999740009777997997774000b7777773333730077777777777777700000000000000000001a4411a4a11aaaaaa11a4411a44100
0977497994777400097749974447740009777447447774000b7777777777730077777777777777700000000000000000001a1111aaa11a4aa4a11aa111aaa100
0977747999977400097774477777740009777777777774000b7777777777730077777777777777700000000000000000001a1a11a4a11a1aa1a11a411144a100
0967777444776400096777777777640009677777777764000b6777777777630077777777777777700000000000000000001aaa11a1a11a1441a11aaa11aa4100
0946666666664400094666666666440009466666666644000b366666666633007777777777777770000000000000000000144411414114111141144411441100
00444444444440000044444444444000004444444444400000333333333330007777777777777770000000000000000000111111111111111111111111111000
00000000000000000000000000000000000000000000000000000000000000000777777777777700000000000000000000000000000000000000000000000000
00000000000000000000000000000000777707777000000011110111100000000000000000000000000000000000000007777777077000770770007700000000
000000000000000000000000000000007887778870000000122111221000000000000000000000000000000000d666d077333337788707887887078800000000
00000000000000000000000000000000788878887000000012221222100000000000000000000000000000000d66666d733bbb33788878887888788800000000
00000000000000000000000000000000778e8e877000000011282821100000000000000000000000000000000667776673baaab3078e8e870788888700000000
000000000000000000000000000000000778e8770000000001128211000000000000000000000000000000000667776673bbaab30078e8700078887000000000
00000000000000000000000000000000778e8e877000000011282821100000000000000000000000000000000667776673babab3078e8e870788888700000000
00000000000000000000000000000000788878887000000012221222100000000000000000000000000000000d66666d733bbb33788878887888788800000000
000000000000000000000000000000007887778870000000122111221000000000000000000000000000000000d666d077333337788707887887078800000000
00000000000000000000000000000000777707777000000011110111100000000000000000000000000000000000000000000000000000000000000000000000
00000010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000171000000000000000000000000000000000000000000000000000000000000000000000001000000000000000000000000000000000000000000000000
00001777100000000000000000000000000000000000000000000000000000000000000000000011000000000000000000000000000000000000000000000000
00017777710000000000000000000000000000000000000000000000000000000000000000000171000000000000000000000000000000000000000000000000
00176777d61000000000000000000000000000000000000000000000000000000000000000001671000000000000000000000000000000000000000000000000
0017767d661000000000000000000000000000000000000000000000000000000000000000001671000000000000000000000000000000000000000000000000
001777d6661000000000000000000000000000000000000000000000000000000000000000001671000000000000000000000000000000000000000000000000
001677d6661000000000000000000000077777770000000001111111000000000000000000001671000000000000000000000000000000000111111100000000
000177d6610000000000000000000000773bbb377000000011d666d1100000000000000000001671000000000000000000000010000000001128882100111110
0001774661000000000000000000000073bbbbb3700000001d66666d100000000000000000001671000000000000000000000171000000001288888201188811
000174946100000000000000000000007bbbbbbb7000000016677766100000000000000000014674000000000000000000001777100000001887778801828281
001479b96410000000000000000000007bbbbbbb7000000016677766100000000000000000014444000000000000000000017777710000001887778801882881
01499b7b9941000000000000000000007bbbbbbb7000000016677766100000000000000000019999000000000000000000016777d10000001887778801828281
0144988294410000000000000000000073bbbbb3700000001d66666d10000000000000000001188200000000000000000001767d610000001288888201188811
01118e88111100000000000000000000773bbb377000000011d666d11000000000000000000128e80000000000000000000177d6610000001128882000111110
000000000000000000000000000000000777777700000000011111110000000000000000000000000000000000000000000177d6610000000000000000000000
000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000177d6610000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000167746661000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000017494610000000000000000000000
000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001479b9641000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001499b7b994100000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001449882944100000000000000000000
000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001128e8211000000000000000000000
0001100000000000000011000000000000001000000000000000000800000000000000000000000000000000000000000000111188e811100000000000000000
00166100000000000001dd1000010000000181000000000000000008000000000000001000000000000000000000000000001449288944101110000000000000
015d61000010000000015dd11114100000018100000000000000003b300000000000017100000000000000000000000000001499b7b994101441000111100000
00166d1111410000000166d1349910000013b310000000000000005b5000000000001777100000000000000000000000000001469b9741001494111677710000
01677613499100000015d66d679100000019b91000000000000003bbb30000000001777771000000000000000000011100000016494710008997777777671000
15d676d6791000000001677777310000013bbb3100000000000000bb3000000000176777d610000000000111100014410000001664771000e8b9477776777100
011d777773100000000146777d1100000013bb11000000000000bbb3000000000017767d661000000000166661114941000000166d771000887b94ddd7777710
00146777d11000000001177776dd100000113bbb10000000000bb30033000000001777d66610000000017d6666666991000001666d77610082b946666d777100
0011777776d11000001d6666766dd100013b113bb10000000003b0bbb3300000001677d666100000001777d666649b28000001666d7771001996666666d71000
01d66667776661000001d614dd65d10013bbbb1b310000000003bb33bb300000000177d6610000000177777ddd49b78800000166d76771001494111666610000
001d614d676d61000001dd11151110001bb13bbb310000000000330bb330000000017746610000000017776777749b8e0000016d777671001441000111100000
001dd111d6151000000011000100000013bb113310000000000000b3300000000001749461000000000176777777799800000017777710001110000000000000
000110015101000000000000000000000133b111000000000000033000000000001479b964100000000017776111494100000001777100000000000000000000
000000001000000000000000000000000011331000000000000000000000000001499b7b99410000000001111000144100000000171000000000000000000000
00000000000000000000000000000000000011000000000000000000000000000144988294410000000000000000011100000000010000000000000000000000
000000000000000000000000000000000000000000000000000000000000000001118e8811110000000000000000000000000000000000000000000000000000
000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000114112118ddb11011000000000
000000000000000000000000000000000000000000000000000000000000000000000000000000000011111100000000000000149418811b8112114110000000
00000000000000000000000000000000000000000000000000000000000000000000000001111110001777d61000000000000014992888111188849410000000
00000000000000000000000000000000000000000000000000000000000000000000000017677710001777d6610000000000000169b8e821188e999410000000
00000000000000000000000000000000000000000000000000000000000000000000000177677710001777d66610000000000016697b98102888b97100000000
00000000000000000000000000000000000000000000000000000000000000000000001777677710001666d6661000000000116649999411112b797710000000
00000000000000000000000000000000000000000000000000000000000000000000001777dddd100017777d6661011100016666447799411499994771100000
0000000000000000000000000000000000000000000000000000000000000000011101777d66661000017777d66614410016666d777144104996644777710000
000000000000000000000000000000000000000000000000000000000000000001441777d66661000000177774466994016666d7771011101441666d77771000
00888800055555500099990000cccc00000800000000000000067000000000001499774466661000000001177499994101dddd777100000011101666d7777100
0888888005dddd50022992200cccccc0000800000000040000067000000000001149999466110000000000017797b2110177767771000000000001666d666100
2878878205dddd50092222900cccccc0003b30000034990000067000000000000189b7966100000000000000179b88820177767710000000000001666d777100
0888888005dddd50092992900cccccc0005b5000066790000099990000c0ccc0128e8b9610000000000000014999e8810177767100000000000000166d777100
0882828005dddd50099999900cccccc003bbb300067730000004400000ccccc0118882994100000000000001494888110111111000000000000000016d777100
00882800055555500092290001cccc1000bb3000006600000004400000cccc00b118814941000000000000011411211800000000000000000000000011111100
0000000000000000000000000011110000000000000000000000000000000000d81121141100000000000000011011bd00000000000000000000000000000000
__gff__
0000000000000000000000000000000000002300230023002300000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__map__
7f7f0000000000007f000000000000007f000000000000007f000000000000007f000000000000007f000000000000007f000000000000007f000000000000007f000000000000007f000000000000007f000000000000007f000000000000007f000000000000007f000000000000007f000000000000007f00000000000000
7ff67f7f7f7f7f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00f000f1007f0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000f200007f0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000007f0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000007f7f7f0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000007f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
7f000000000000007f000000000000007f000000000000007f000000000000007f000000000000007f000000000000007f000000000000007f000000000000007f000000000000007f000000000000007f000000000000007f000000000000007f000000000000007f000000000000007f000000000000007f00000000000000
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
