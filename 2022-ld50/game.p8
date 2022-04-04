pico-8 cartridge // http://www.pico-8.com
version 35
__lua__
-- ld50 - space regen game
-- amorg, davery, tigerwolf181

-- unobfuscated code at:
-- git.io/amorg-pico8

#include .code.lua
#include constants.lua
__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
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
cb14000000000000002f6042f6012f6012f605000000b6002f7142f7112f7212f7112f7212f7112f7112f715000000000035604356013560135605000000b6003b7143b7113b7213b7113b7213b7113b71100000
cb14000000000000003b6043b6013b6013b605000000b60034714347113472134711347213471134711347153b7003b700296042960129601296053b7003b7003671436711367213671136721367113671136715
cb14000000000000002f6042f6012f6012f605000000b6002f7142f7112f7212f7112f7212f7112f7112f715000000000033604336013360133605000000b6002a7142a7112a7212a7112a7212a7112a7112a715
cb14000000000000003b6043b6013b6013b605000000b6002671426711267212671126721267112671126715000000000033604336013360133605000000b6003171431711317213171131721317113171131715
01140000172151721517215172152323517215172151721517215172151721517215232351721517215172151721517215172151721525235192151921519215192151921519215192151a235172151721517215
0114000000000000002f0042f0012f0012f005000000b0000b0150b0150b0150b015170350b0050b0050b005000000000035004350013500135005000000b0000d0350d0350d0350d035190350b0050b0050b005
011400000b2150b2150b2150b215172350b2150b2150b2150d2250e2250d2250b225112300e2210d2250d2050d2150d2150d2150d2150e2350b2150b2150b2151122512225112250f22511230122210d2250c205
011400001122512225112250f22511231112250c2210d2150b2150b2150b2150b215172350b2150b2150b2150d2250e2250d2250b225112310e2250c2210d2150d2150d2150d2150d2150e2350b2150b2150b215
cb14000000000000002f6142f6112f6112f615000000b6002f7042f7012f7012f7012f7012f7012f7012f705000000000035614356113561135615000000b6003b7043b7013b7013b7013b7013b7013b70100000
cb14000000000000003b6143b6113b6113b615000000b60034704347013470134701347013470134701347053b7003b700296142961129611296153b7003b7003670436701367013670136701367013670136705
cb14000000000000002f6142f6112f6112f615000000b6002f7042f7012f7012f7012f7012f7012f7012f705000000000033614336113361133615000000b6002a7042a7012a7012a7012a7012a7012a7012a705
cb14000000000000003b6143b6113b6113b615000000b6002670426701267012670126701267012670126705000000000033614336113361133615000000b6003170431701317013170131701317013170131705
01140000112251222500000000000000000000112251222500000000000000000000112251222500000132251222500000112251222500000000001e22511205112251d22511225000001d225112251d22500000
01140000112251222500000000000000000000112251222500000000000000000000112251222500000112250e22500000112251222500000000001e225112050e225112250e225000000d2250e2250d22500000
011400000b2250e2250d23511225002000020011205122050b2250e2250d2350a225112051220500205112050b2250e2250d23511225002050020511205122050b2250e2250d2351622511205122050020511205
011400000b2250e2250d23511225172052f22517205122050b2250e2250d2350a225112053b22500205112050b2250e2250d23511225002053522511205122050b2250e2250d2351622511205362250020511205
011400000b2250e2250d23511225172052f22517205122050b2250e2250d2350a225112052a22500205112050b2250e2250d23511225002052922511205122050b2250e2250d23516225112052a2250020511205
011400000b225172051222517235002000020012225172251922517225162351722500205002051a22519235162251722516235132250c0002a20512225112250e22511225122251120000205292051120512205
011400000b225172051222517235002000020012225172251922517225162351722500205002051a2251923516225172251623513225000001500011225122251522516225192251120000205292051120512205
011400000b225172051222517235002000020012225172251922517225162351722523235172051a22519235162251722516235132251e2352a20512225112250e2251122512225112002a235292051120512205
011400000b225172051222517235002000020012225172251922517225162351722523235002051a22519235162251722516235132251e2351500011225122251522516225192251120025225292051120512205
011400000b225172051222517235002000020012225172251922517225162351722523235002051a22519235162251722516235132251e2351500011225122251522516225192251120036235292051120512205
011400001772417751177211772523724237512372123725127241275112721127252a7242a7512a7212a72500000000000000000000000000000000000000000000000000000000000000000000000000000000
910400002f7102f715007000070000700007000070000700007000070000700007000070000700007000070000700007000070000700007000070000700007000070000700007000070000700007000070000700
011400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
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
01 00084344
00 01094344
00 020a4344
02 030b4344
00 41424344
00 41424344
00 41424344
00 41424344
01 06054044
00 06004144
00 06054244
02 06014344
00 41424344
00 41424344
00 41424344
00 41424344
01 080c4244
00 090d4344
00 0a0c0244
02 0b0d0344
00 41424344
00 41424344
00 41424344
00 41424344
01 040e4344
00 040e4344
00 040f4344
02 04104344
00 41424344
00 41424344
00 41424344
00 41424344
01 13084c44
02 14094944
00 130a4c44
02 150b4944

