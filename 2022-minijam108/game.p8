pico-8 cartridge // http://www.pico-8.com
version 35
__lua__
-- game
-- amorg

-- unobfuscated code at:
-- git.io/amorg-pico8

#include .code.lua

__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000555000000000000000600000000000000000000000000000
00000000000000088800000000000000000000000000000000000000000000000000000000000000566500000000000066600000000000000666666000000000
007007000000008888e8200000000000000000000000000000000000000000000000000000000000566650000000006666d00000000000006666666000000000
00077000088800288e8e8000000000000000000000000000000000000002220000000000000000005d66650000000666dd6000000000000666ddd66000000000
000770008e800002888880000000000000000000000000000000000000288820000000000000000056d666500000066d66600000000000666d66660000000000
00700700e82080000008800000000000000000000000000000000000028882000000000000000000566d66500000066d6660000000000666d666600000000000
000000008888200b22b0020000000000000000000000000000000000028822072270000000000000566d66500000066d666000000000666d6666000000000000
0000000028840dd2dd2200800000000000000000000000000000000002888dd2dd22000000000000566d66500000066d66600000000666d66660000000000000
000700000242dd7d77dd2008000000000000000000000000000000000022dd7d77d8200000000000566d66500000066d6660000000446d666600000000000000
007770000000d777d77d4882000000000000000000000000000000000000d777d77d220000000000566d66500000066d66600000004446666000000000000000
0777770000007776d776d420000000000000000000000000000000000002d777d77d820000000000566966500000066d66600000000444660000000000000000
00777000000d6666d766d00000000000000000000000000000000000000d7666d67d200000000004969c96940000066d66600000000044400000000000000000
007770000006d66dd6665400000000000000000000000000000000000005d6dd6665000000000004988889940000444888440000000004400000000000000000
007770000000055d6655280000000000000000000000000000000000000005566658200000000002228888200000448888840000000000000000000000000000
00777000000082055500020000000000000000000000000000000000000002855502000000000000288888200000008888000000000000000000000000000000
00777000000008000000000000000000000000000000000000000000000000200000000000000000222222000000000888800000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100000000000000
000000000000000000000000000000000000000000feefffeef00000009ff999ff90000000022200000000000000000000000000000000001d10000000000000
00000000000000000000000000000000000000000fffffffffff000009fffffffff9000000288820000000000000000000000000000000001d10000000000000
00022200000000000000000000000000000000000efffffffffe00000fffffffffff00000288820000000000000000000000000000000001dd10000000000000
00288820000000000000000000000000000000000efffffffffe00000fffffffffff00000288820000000000000000000000000000000001ddd1000000000000
02888200000000000000000000000000000000000fffffffffff000009fffffffff90000028820000000000000000000000000000000000015dd100000000000
02882207227000000000000000000000000000000fffffffffff000009fffffffff900000028200122100000000000000000000000000001d5dd100000000000
02888dd2dd2200000000000000000000000000000fffffffffff000009fffffffff9000000028dd88882000000000000000000000000001d5dd1000000000000
0022dd7d77d820000000000000000000000000000efffffffffe00000fffffffffff00000002d66d5588200000000000000000000000001d5d10000000000000
0000d777d77d22000000000000000000000000000efffffffffe00000fffffffffff00000000d666d6d8200000000000000000000000001dd5d1000000000000
0002d777d77d82000000000000000000000000000fffffffffff000009fffffffff900000000d666d66d200000000000000000000000000122dd100000000000
000d7666d67d200000000000000000000000000000feefffeef00000009ff999ff900000000d6666d66520000000000000000000000000122222210000000000
0005d6dd66650000000000000000000000000000000000000000000000000000000000000005d6dd666520000000000000000000000001222888210000000000
00000556665820000000000000000000000000000000000000000000000000000000000000028566665882000000000000000000000001128888200000000000
00000285550200000000000000000000000000000000000000000000000000000000000000002255550220000000000000000000000000028882000000000000
00000020000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000002888200000000000
00888888888880000088888888888000008888888888800000bbbbbbbbbbb00000bbbbbbbbbbb000000000005550000000000000000000000000000000000000
0887777777772200088777777777220008877777777722000bb77777777733000bb7777777773300000000005665000000000000000000000000000000000000
0877777777777200087777778277720008777777777772000b777777777773000b77777777777300000000005666500000000000000000000000000000000000
0877788888777200087777777827720008777777777772000b777777777773000b7777777b777300000000005d66650000000000000000000000000000000000
0877888888877200087777777887720008777777777772000b777777777773000b7777777bb773000000000056d6665000000000000000000000000000000000
0878888888887200087777778882720008777777777772000b7777777b7773000b77bbbbbbbb730000000000566d665000000000000000000000000000000000
08788822288872000877768888827200087666566d8872000b7777777bb773000b7733333bb3730000000000566d665000000000000000000000000000000000
08788277788872000877566888827200087665666d8882000b77bbbbbbbb73000b7777777b37730000000000566d665000000000000000000000000000000000
0878877288887200087665668882720008755666d88872000b7733333bb373000b77777773b7730000000000566d665000000000000000000000000000000000
0878877728887200087d6655582772000876666d887772000b7777777b3773000b77bbbbbbbb730000000000566d665000000000000000000000000000000000
08728877728272000877d666666d7200087dddd8877772000b777777737773000b7733333bb37300000000005669665000000000000000000000000000000000
087728887727720008777d6666d7720008777777777772000b777777777773000b7777777b37730000000004969c969400000000000000000000000000000000
0877722277777200087777dddd77720008777777777772000b777777777773000b77777773777300000000049888899400000000000000000000000000000000
0826666666662200082777777777220008277777777722000b377777777733000b37777777773300000000022288882000000000000000000000000000000000
00222222222220000022222222222000002222222222200000333333333330000033333333333000000000002888882000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000002222220000000000000000000000000000000000
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
0977777444777400097777777777740009777777777774000b7777777777730077777777777777700000000000000000001aaa11a1a11a1441a11aaa11aa4100
0947777777774400094777777777440009477777777744000b377777777733007777777777777770000000000000000000144411414114111141144411441100
00444444444440000044444444444000004444444444400000333333333330007777777777777770000000000000000000111111111111111111111111111000
00000000000000000000000000000000000000000000000000000000000000000777777777777700000000000000000000000000000000000000000000000000
00000060000000000000000000000000000000000000000000000000000000066d60000000000000000000000000000000000000000000000000000000000000
0000067d00000000000000000000066d0000000000000000000000000000066777d0000000000000000000000000000000ccc000008880000099900000000000
00006777d0000000000000000006677d0000000000000000000000000066677777d000000000000000000000000000000ccccc00088888000999990000000000
00006777d0000000000000000666777d0000000000000000000000000667677777d000000000000000000000000000000ccccc00088888000999990000000000
000677777d000000000000006677777d000000000000000000000000667767777d0000000000000000000000000000000ccccc00088888000999990000000000
000677777d000000000000067677777d000000000000000000000006677767777d00000000000000000000000000000001ccc100028882000499940000000000
00676777d6d00000000000067767777d0000000000000000000000067777ddddd000000000000000000000000000000000111000002220000044400000000000
0067767d66d000000000006777677ddd000000000000000000000006777d6666d000000000000000000000000000000000000000000000000000000000000000
006777d666d000000000006777ddd66d00000000000000000000906777d6666dd000000000000000000000009999999900000000000000000000000000000000
006777d666d000000000006777d666d00000000000000000094a96777d6666dd000000000000000000000000999999990066600000eee0000000000000000000
006777d666d00000000000677d6666d00000000000000000499a6777d6666dd000000000000000000000000099999999066666000eeeee000000000000000000
000677d66d000000000006777d666d000000000000000000099a7a79666ddd0000000000000000000000000099999999066666000eeeee000000000000000000
000677d66d00000000000677d6666d000000000000000000049aaa9666d0000000000000000000000000000099999999066666000eeeee000000000000000000
000677d66d00000000996677d66d000000000000000000000849c9996d000000000000000000000000000000999999990d666d0002eee2000000000000000000
000677d66d000000009a677d66dd0000000000000000000028887c96644000000000000000000000000000009999999900ddd000002220000000000000000000
009677966d40000099a7677966d00000000000000000000028888969990000000000000000000000000000009999999900000000000000000000000000000000
09a67a9966940000449a7a996dd00000000000000000000008eee499940000000000000000000000000000009999999900000000000000000000000000000000
09a77a996694000004999c9966400000000000000000000000888249990000000000000000000000000000009999999900000000000000000000000000000000
999a7ac9699990000499c7c666940000000000000000000000082000490000000000000000000000000000009999999900000000000000000000000000000000
44999c7c9994400008848c9999400000000000000000000000000000000000000000000000000000000000009999999900000000000000000000000000000000
00494888494000000288884999900000000000000000000000000000000000000000000000000000000000009999999900000000000000000000000000000000
00008888e82000000228ee8944400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000288e8e80000000088e2400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000288888000000000882000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000060000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000067d000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000006777d00000
0066000000000000000dd00000000000000800000000000000000008000000000000000000000000000000000000000000000000000000000000006777d00000
05d60000000000000005dd00004000000008000000000000000000080000000000000000000000000000000000000000000000000000000000000677777d0000
0066d0000400000000066d0349900000003b3000000000000000003b3000000000000000000000000000000000000000000000000000000000000677777d0000
0677603499000000005d66d679000000001b1000000000000000005b500000000000000000000000000000000000000000000000000000000000676777d6d000
5d676d6790000000000677777300000003bbb30000000000000003bbb3000000000000000000000000000000000000000000000000000000000067767d66d000
00d777773000000000046777d0000000003bb00000000000000000bb3000000000000000000000000000000000000000000000000000000000006777d666d000
0046777d00000000000077776dd000000003bbb0000000000000bbb30000000000000000000000000000000000000000000000000000000000006777d666d000
000777776d00000000d6666766dd000003b003bb00000000000bb3003300000000000000000000000000000000000000000000000000000000006777d666d000
0d66667776660000000d604dd65d00003bbbb0b3000000000003b0bbb330000000000000000000000000000000000000000000000000000000000677d66d0000
00d604d676d60000000dd00050000000bb03bbb3000000000003bb33bb30000000000000000000000000000000000000000000000000000000000677d66d0000
00dd000d6050000000000000000000003bb00330000000000000330bb330000000000000000000000000000000000000000000000000000000000677d66d0000
00000005000000000000000000000000033b000000000000000000b33000000000000000000000000000000000000000000000000000000000000677d66d0000
000000000000000000000000000000000003300000000000000003300000000000000000000000000000000000000000000000000000000000009677966d4000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000009a67a99669400
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000009a77a99669400
000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000999a7ac9699990
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000044999c7c999440
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000494888494000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000008888e82000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000088800288e8e8000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000008e80000288888000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000e820800000088000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000008888200b22b00200
000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000028840dd2dd220080
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000242dd7d77dd2008
00888800055555500099990000cccc00000800000000000000067000000000000000000000000000000000000000000000000000000000000000d777d77d4882
0888888005dddd50022992200cccccc00008000000000400000670000000000000000000000000000000000000000000000000000000000000007776d776d420
2878878205dddd50092222900cccccc0003b3000003499000006700000000000000000000000000000000000000000000000000000000000000d6666d766d000
0888888005dddd50092992900cccccc0005b5000066790000099990000c0ccc00000000000000000000000000000000000000000000000000006d66dd6665400
0882828005dddd50099999900cccccc003bbb300067730000004400000ccccc00000000000000000000000000000000000000000000000000000055d66552800
00882800055555500092290001cccc1000bb3000006600000004400000cccc000000000000000000000000000000000000000000000000000000820555000200
00000000000000000000000000111100000000000000000000000000000000000000000000000000000000000000000000000000000000000000080000000000
__gff__
0000000000000000000000000000000000002300000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000023
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
