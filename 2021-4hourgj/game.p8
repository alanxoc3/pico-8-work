pico-8 cartridge // http://www.pico-8.com
version 32
__lua__
-- cat game
-- amorg

-- unobfuscated code at:
-- git.io/amorg-pico8

#include code.lua
__gfx__
00000000000004444444444444400000999aaaaaaaaaa99900000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000004999999999999994000099a9aaaaaaaa9a9900000000000000000000000000000000000000000000000000000000000000000000000000000000
007007000004999999999999999940009aaaaaaaaaaaaaa900000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000004999aa9aa99aaaaa999400aaaaaaa99aaaaaaa00000000000000000000000000000000000000000000000000000000000000000000000000000000
0007700004999aaaaaaaaaaaaaa99940aaaaaaaaaaaaaaaa00000000000000000000000000000000000000000000000000000000000000000000000000000000
007007000499aaaaaaaaaa9aaaaa9940a9aaaaaaaaaaaa9a00000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000499aaaaaaaaaaaaaaaa9940aaaaaaaaaaaaaaaa00000000000000000000000000000000000000000000000000000000000000000000000000000000
000000004999aaaaaa9aaaaaaaaa9994aaaaa9aaaa9aaaaa00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000499aaaaaaaaaaaaaaaaaa994000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000499aaaaaaaaa9aaaaaaaa994000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000499aaaa9aaaaaaaa9aaaa994000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000499aaaaa9aaaaaaaaaaaa994000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000499aaaaaaaaaaaaaaaaaa994000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000499aaaaaaaaaaa9aaaaaa994000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000499aa9aaaaaaaaaaaa9aa994000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000499aaaaaaa9aaaaaaaaaa994000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000011001100000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000114114110000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000110011000000000142112410000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000001140141100000000114444110000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000001421124100000000141441410000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000001110110000000001144441100000000144224410000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000011411411000000001414414100000000144444410000000000000000000000000000000000000000000000000000
00000000000000000004944994494000000494499449400000049449944940000004944994494000000000000000000000000000000000000000000000000000
00049449944940000044929999294400004492999929440000449299992944000044929999294400000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000100000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000001010000000000000010100000000001510000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000101d1510000000001001d1510000000015100000000000000000000000000000000000000000
0000000010100000000000001010000000000000101000000001511dd55100000001d101dd55100000001d100000000000000000000000000000000000000000
00001001d151000000001001d151000000001001d1510000001d101da5910000001d1115da591000000015510100000000000000101000000000000000000000
0001d101dd5510000001d101dd5510000001d101dd5510000015115dd5510000001d15dddd551000000155d51510000000001001d15100000000000000000000
001d1115da591000001d1115da591000001d1115da591000001515ddd5100000000155dd5d51000000015dddd55100000001d101dd5510000000000000000000
001d15dddd551000001d15dddd551000001d15dddd551000000155d5151000000000151151510000000151dda5910000001d1115da5910000000000000000000
000155dd5d510000000155dd5d510000000155dd5d5100000000151511000000000001001010000000001015d5510000001d15dddd5510000000000000000000
0000151151510000000015111151000000001511511000000000151100000000000000000000000000000015151000000001555d5d5100000000000000000000
00000100101000000000010000100000000001001000000000000110000000000000000000000000000000010100000000001111111100000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000009999999999999999999999999999999999999999999999999999999999999999999999999999999900000000000001111110000000000000
00000000000000009999999999999999999999999999999999999999999999999999999999999999999999999999999911111111111111777711111111111110
00000000000000009999999999999999999999999999999999999999999999999999999999999999999999999999999917777177177117511571177771777710
00000000101000009999999999999aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa9999999999999999999999999999999175571777771171dc171175571755511
00000001d151000099999aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa9999999999999999999177771757571171dd171177711711771
00001001dd551000aaaaaaaaaaaaaa9999999999999999999999999999999999aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa17557171517115511551175571777751
0001d115da591000aaaaaa999999999999999999999999999999999999999999999999999999aaaaaaaaaaaaaaaaaaaa15115151115111555511151151555511
001d15dddd5510009999999999999999999999999999999999999999999999999999999999999999999999999999999911111111111111111111111111111111
001d55dd5d510000000000000000000000000000000000000000000000000000000000000000000000000000000000000011aa11aaa11a1111a11aaa111aa100
000115115151000000000000000000000000000000000000000000000000000000000000000000000000000000000000001a4411a4a11aaaaaa11a4411a44100
000001001010000000000000000000000000000000000000000000000000000000000000000000000000000000000000001a1111aaa11a4aa4a11aa111aaa100
000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001a1a11a4a11a1aa1a11a411144a100
000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001aaa11a1a11a1441a11aaa11aa4100
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000144411414114111141144411441100
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000111111111111111111111111111000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000009999999999999999999999999999999999999999999999999999999999999999999999999999999999999999
00000000000000000000000000000000000000009999999999999999999999999999999999999999999999999999999999999999999999999999999999999999
00000100000000000000000000110000000000009999999999999999999aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa99999999999999999999999999999999
00001e1000110000000001010144100000000000999999999999aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa9999999999999999999
0001e3e11144100000001e14144441000000000099999999aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
00199eee444441000001e3ee444121000000000099999999aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
000111144441210000199e144241100000000000999999992aaaaaaaaaaaaa99999999999999999999999999999999999aaaaaaaaaaaaaaaaaaaaaaaaaaaaa22
00000001424110000001110141210000000000009999999922aaaa999999999999999999999999999999999999999999999999999999aaaaaaaaaaaaaaaaa222
00000019112100000000001910100000000000000000000022299999999999999999999999999999999999999999999999999999999999999999999999992222
00000001001000000000000100000000000000000000000022299999999999999999999999999999999999999999999999999999999999999999999999992222
000000000000000000000000000000000000000000000000222299999999999aaaaaaaaaaaaaaaaaaaaaaaaaaaaaa99999999999999999999999999999922222
00000000000000000000000000000000000000000000000022222aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa99999999999222222
000000000000000000000000000000000000000000000000222222aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa222222
000000000000000000000000000000000000000000000000222222aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa2222222
0000000000000000000000000000000000000000000000002222222aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa2222222
0000000000000000000000000000000000000000000000002222222aa22aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa22222222
000000000000000000000000000000000000000000000000222222222222aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa222222222
0000000000000000000000000000000000000000000000002222222222222aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa222222222
0000000000000000000000000000000000000000000000002222222222222aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa2222222222
0000000000000000000000000000000000000000000000002222222222222aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa22222222222
0000000000000000000000000000000000000000000000002222222222222aaa2222aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa22222222222
0000000000000000000000000000000000000000000000002222222222222aa2222222aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa222222222222
000000000000000000000000000000000000000000000000222222222222222222222222aaaaaaaaaaaaaaa2222aaaaaaaaaaaaaaaaaaaaaaaaa222222222222
0000000000000000000000000000000000000000000000002222222222222222222222222aaaaaaaaaaaaa222222aaaaaaaaaaaaaaaaaaaaaaa2222222222222
00000000000000000000000000000000000000000000000022222222222222222222222222aaaaaaaaaaa22222222aaaaaaaaaaaaaaaaaaaaaa2222222222222
0cccccccccccccccccccccccccccccccccccccccc0000000222222222222222222222222222aaaaaaaaa2222222222aaaaaaaaaaaaaaaaaaaaa2222222222222
0cccccccccccccccccccccccccccccccccccccccc000000022222222222222222222222222222aaaaaaa22222222222aaaaaaaaaaaaaaaaaaa22222222222222
0cccccccccccccccccccccccccccccccccccccccc0000000222222222222222222222222222222aaaa2222222222222222aaaaaaaaaaaaaaaa22222222222222
0cccccccccccccccccccccccccccccccccccccccc00000002222222222222222222222222222222aa22222222222222222222aaaaaaaaaaaa222222222222222
0cccccccccccccccccccccccccccccccccccccccc00000002222222222222222222222222222222222222222222222222222222aaaaaaaa22222222222222222
0cccccccccccccccccccccccccccccccccccccccc000000022222222222222222222222222222222222222222222222222222222222aaa222222222222222222
0cccccccccccccccccccccccccccccccccccccccc000000022222222222222222222222222222222222222222222222222222222222222222222222222222222
00000000000000777600007777660000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000007777766077777766000000000000000000000000000000777777600000000000000000000000000000000000000000000000000000000000000
00000000000077777776677777776600000000000000000000000000677777777760000000000000000000000000000000000000000000000000000000000000
00000000000077777777777777776600000000000000000000000006777777777766000000000000000000000000000000000000000000000000000000000000
00000000000777755777775577776600000000000000000077777006777777777766066600000000000000000000000000000000000000000000000000000000
00000000000777777777777777776666000000000000000777777767777775777766666600000000000000000000000000000000000000000000000000000000
00000007766777757777777577666666600000000000007777777775777777777766666660000000000000000000000000000000000000000000000000000000
00000077776777777777777777666666660000000000077777777777777777777666666666660000000000000000000000000000000000000000000000000000
00000777777777777575757777666666660000000006777777777777575757776666666666666000000000000000000000000000000000000000000000000000
00000777777777777557557776666666666660000067777777777777557557766666666666666000000000000000000000000000000000000000000000000000
00766777777777777777776666666666666666000067777777777777777777766666666666660000000000000000000000000000000000000000000000000000
07776777777777777777776666666666666666600006777777777777777777666666666660000000000000000000000000000000000000000000000000000000
07777777777777777776666666666666666666600000067777777677777666666600666600000000000000000000000000000000000000000000000000000000
07777777777777777666666666666666666666000000000000666777777666660000000000000000000000000000000000000000000000000000000000000000
00777777777777666600066666600066666660000000000000006666666000000000000000000000000000000000000000000000000000000000000000000000
00000006666666000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000007777700077770000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000077777760777777000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000007776000000000000000007777777776777777076600000000000000000000000000000000000000000000000000000000000000000000000000000
00000000677777600000000000000077777777777777777677660000000000000000000000000000000000000000000000000000000000000000000000000000
00000766777777760000000000000677777575777757577777666000000000000000000000000000000000000000000000000000000000000000000000000000
00007776777577776600000007660777777757777775777777666066000000000000000000000000000000000000000000000000000000000000000000000000
00077777577777777660000077766777777777777777777777666666600000000000000000000000000000000000000000000000000000000000000000000000
07677777775777777666000077776777777775757577777776666666660000000000000000000000000000000000000000000000000000000000000000000000
77777777757577776666000077777777777775575577776666666666660000000000000000000000000000000000000000000000000000000000000000000000
77777777776666666660000007777777777777777777776666666666600000000000000000000000000000000000000000000000000000000000000000000000
07777777660006666600000000777776777777777777776666666660000000000000000000000000000000000000000000000000000000000000000000000000
00000666000000000000000000066666777776666667766666660000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000666660000666666000000000000000000000000000000000000000000000000000000000000000000000000000000000
__gff__
0040404040400000000000000000000000404040000000000000000000000000000000000000000040400000000000000000000000000000404000000000000040404040404040404040404040400000404040404040404040404040404000004040000000000000000000000000000040400000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__map__
0000000000000000000000000000000000000000000000000000000000000000000000000000000000008585858585858585858585858585858585858585858585858585858585858585858585858585858585858585858585858585858585858585858585858585858585858585858585858585858585858585858585858585
0000000000000000000000000000000000000000000000000000000000000000000000000000000000008585858585858585858585858585858585858585858585858585858585858585858585858585858585858585858585858585858585858585858585858585858585858585858585858585858585858585858585858585
0000000000000000000000000000000000000000000000000000000000000000000000000000000000008585858585858585858585858585858585858585858585858585858585858585858585858585858585858585858585858585858585858585858585858585858585858585858585858585858585858585858585858585
0000000000000000000000000000000000000000000000000000000000000000000000000000000000008585858585858585858585858585858585858585858585858585858585858585858585858585858585858585858585858585858585858585858585858585858585858585858585858585858585858585858585858585
0000000000000000000000000000000000000000000000000000000000000000000000000000000000008585858585858585858585858585858585858585858585858585858585858585858585858585858585858585858585858585858585858585858585858585858585858585858585858585858585858585858585858585
00000000000000000000000000000000000000000000000000000000000000000000000000000000000068696a6b6b62636465666768696a6a62636465666768696a6b62636465666768696a6a626364656668696a6b6b62636465666768696a6a62636465666768696a6b62636465666768696a6b62636465666768696a6b62
0000000000000000000000000000000000000000000000000000000000000000000000000000000000008b8c8d8e8f868788898a8b8c8d8e8f868788898a8b8c8d8e8f868788898a8b8c8d8e8f868788898a8b8c8d8e8f868788898a8b8c8d8e8f868788898a8b8c8d8e8f868788898a8b8c8d8e8f868788898a8b8c8d8e8f86
0000000000000000000000000000000000000000000000000000000000000000000000000000000000009b9c9d9e9f969798999a9b9c9d9e9f969798999a9b9c9d9e9f969798999a9b9c9d9e9f969798999a9b9c9d9e9f969798999a9b9c9d9e9f969798999a9b9c9d9e9f969798999a9b9c9d9e9f969798999a9b9c9d9e9f96
000000000000000000000000000000000000000000000000000000000000000000000000000000000000abacadaeafa6a7a8a9aaabacadaeafa6a7a8a9aaabacadaeafa6a7a8a9aaabacadaeafa6a7a8a9aaabacadaeafa6a7a8a9aaabacadaeafa6a7a8a9aaabacadaeafa6a7a8a9aaabacadaeafa6a7a8a9aaabacadaeafa6
000000000000000000000000000000000000000000000000000000000000000000000000000000000000bbbcbdbebfb6b7b8b9babbbcbdbebfb6b7b8b9babbbcbdbebfb6b7b8b9babbbcbdbebfb6b7b8b9babbbcbdbebfb6b7b8b9babbbcbdbebfb6b7b8b9babbbcbdbebfb6b7b8b9babbbcbdbebfb6b7b8b9babbbcbdbebfb6
000000000000000000000000000000000000000000000000000000000000000000000000000000000000b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6
000000000028290000000028290000000000000000000000000000000000000000000000000000000000b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6
000000000038390000000038390000000000000000000000000000000000000000000000000000000000b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6
000102020202020202020202020203000000000000000000000000000000000000000000000000000000b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6
001112121212121212121212121213000000000000000000000000000000000000000000000000000000b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6
001112121212121212121212121213000000000000000000000000000000000000000000000000000000b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6
000000000000000000000000000000000000000000000000000000000000000000000000000000000000b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6
000000000000000000000000000000000000000000000000000000000000000000000000000000000000b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6
000000000000000000000000000000000000000000000000000000000000000000000000000000000000b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6
000000000000000000000000000000000000000000000000000000000000000000000000000000000000b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6b6
__sfx__
0103000031540305412e5512c5512b5512c5512e5412f5352e500325013450035500325002e5002c5000050000500005000050000500005000050000500005000050000500000000000000000000000000000000
0102000007530085310a5410b5410e55113551185411c5312053524500255001f5000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
012000001305000000170501805000000000000000000000130500000017050180500000000000170500000013050000001705018050000000000000000000001305000000170501805000000000001a05000000
012000000714500100131450010000100001000010000100071450010013145001000010000100001000010007145001001314500100001000010000100001000714500100131450010000100001000214500100
012000001305000000170501805000000000000000000000130500000017050180500000000000170500000013050000001705018050000000000000000000001305000000170501805000000000001305000000
012000001f240002001c2400020000200002001e240002001f240002001c24000200000001e2401a240002001f240002001c2400020000200002001e240002001f240002001c24000200000001e2402124000200
012000002b24024200282402420024200242002a240242002b240242002824024200000002a24026240242002b24024200282402420024200242002a240242002b240242002824024200000002a2402d24024200
012000002b24013200282002420024200242002a200242002b2002420028200242002a2002420026200242002b20024200282002420024200242002a200242002b2002420028200242002a200242002d20024200
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
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
__music__
00 05064344
01 07064344
00 05060844
00 07060944
02 05060a44

