pico-8 cartridge // http://www.pico-8.com
version 32
__lua__
-- cat game
-- amorg

-- unobfuscated code at:
-- git.io/amorg-pico8

#include code.lua

__gfx__
00000000000000044444444440000000999aaaaaaaaaa99900000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000049999999999400000099a9aaaaaaaa9a9900000000000000000000000000000000000000000000000000000000000000000000000000000000
007007000000049999999999994000009aaaaaaaaaaaaaa900000000000000000000000000000000000001000000000000000000001100000000000000000000
00077000000049999aa99aaa99940000aaaaaaa99aaaaaaa0000000000000000000000000000000000001e110011000000000101014410000000000000000000
000770000004999aaaaaaaaaa9994000aaaaaaaaaaaaaaaa000000000000000000000000000000000001e2e41144100000001e14144441000000000000000000
00700700004999aaaaaaaa9aaa999400a9aaaaaaaaaaaa9a0000000000000000000000000000000000199eee444441000001e2ee444121000000000000000000
0000000004999aaaaaaaaaaaaaa99940aaaaaaaaaaaaaaaa00000000000000000000000000000000000111144441210000199e14424110000000000000000000
000000004999aaaaaa9aaaaaaaaa9994aaaaa9aaaa9aaaaa00000000000000000000000000000000000000014241100000011101412100000000000000000000
00000000499aaaaaaaaaaaaaaaaaa994000000000000000000000000000000000000000000000000000000191121000000000019101000000000000000000000
00000000499aaaaaaaaa9aaaaaaaa994000000000000000000000000000000000000000000000000000000010010000000000001000000000000000000000000
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
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001111110000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000011111111111111777711111111111110
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000017777177177117511571177771777710
000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000175571777771171dc171175571755511
000000001010000000000000000000000000000000000000000000000000000000000000000000000000000000000000177771757571171dd171177711711771
00000001d15100000000000000000000000000000000000000000000000000000000000000000000000000000000000017557171517115511551175571777751
00001001dd5510000000000000000000000000000000000000000000000000000000000000000000000000000000000015115151115111555511151151555511
0001d115da5910000000000000000000000000000000000000000000000000000000000000000000000000000000000011111111111111111111111111111111
001d15dddd551000000000000000000000000000000000000000000000000000000000000000000000000000000000000011aa11aaa11a1111a11aaa111aa100
001d55dd5d51000000000000000000000000000000000000000000000000000000000000000000000000000000000000001a4411a4a11aaaaaa11a4411a44100
000115115151000000000000000000000000000000000000000000000000000000000000000000000000000000000000001a1111aaa11a4aa4a11aa111aaa100
000001001010000000000000000000000000000000000000000000000000000000000000000000000000000000000000001a1a11a4a11a1aa1a11a411144a100
000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001aaa11a1a11a1441a11aaa11aa4100
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000144411414114111141144411441100
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000111111111111111111111111111000
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
0cccccccccccccccccccccccccccccccccccccccc000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0cccccccccccccccccccccccccccccccccccccccc000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0cccccccccccccccccccccccccccccccccccccccc000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0cccccccccccccccccccccccccccccccccccccccc000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0cccccccccccccccccccccccccccccccccccccccc000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0cccccccccccccccccccccccccccccccccccccccc000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0cccccccccccccccccccccccccccccccccccccccc000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
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
0040404040400000000000000000000000404040000000000000000000000000000000000000000000000000000000000000000000000000000000000000000040404040404040404040404040400000404040404040404040404040404000004040000000000000000000000000000040400000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__map__
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000242500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000343500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0001020202020202020202020202030000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0104121212121212121212121212050300000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1112121212121212121212121212121300000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00001617080916170a0b00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000060716170607000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000e0f06072e2f0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000060716171e1f00003e3f0c0d000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__sfx__
0103000031540305412e5512c5512b5512c5512e5412f5352e500325013450035500325002e5002c5000050000500005000050000500005000050000500005000050000500000000000000000000000000000000
0102000007530085310a5410b5410e55113551185411c5312053524500255001f5000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
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
