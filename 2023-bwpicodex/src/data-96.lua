-- The data file should be executed after all other files, because the c_move_funcs mappings need to be after all moves are defined.
|[c_move_names]|        f_zobj[["0,strugl;,acid,acidar,barage,bonclb,bind,clamp,moonlt,lechsd,extrsp,sncbom,twindl,thnshk,glare,gilotn,hypfng,jmpkck,kinsis,lockon,lovkis,macpnc,vicgrp,spican,spikes,spore,cotspr,presnt,vithrw,cmtpnc,drlpck,sndatk,agilty,fryatk,qikatk,falswp,growl,healbl,sing,pound,minmiz,tailwp,dblslp,meghrn,bonrng,convr1,convr2,spark,mlkdrk,morsun,ngtshd,octzok,pinmis,pwdsnw,supfng,firspn,psngas,barier,medtat,ftrsgt,hypnos,psybem,litscr,safgrd,petdnc,charm,synths,swtscn,razlef,psnpwd,slppwd,absorb,stnspr,flail,confsn,slam,constr,amnesa,bubble,splash,hydpmp,mindrd,mist,hrnatk,spiweb,dblkck,swtkis,mtlclw,trform,trikck,gust,twistr,crbham,dizpnc,sludge,painsp,dstbnd,haze,lick,persng,meanlk,cnfray,crschp,smog,karchp,ember,smkscr,beldrm,beatup,scrtch,slash,ancpwr,leer,bite,outrge,scryfc,thrash,stomp,roksld,magtud,rocthr,harden,bonrsh,hijkck,recovr,aerbls,hrndrl,drgrag,sfboil,drgbre,slfdes,explsn,eggbmb,slgbmb,gigdrn,megdrn,swrdnc,cut,fryctr,thief,dig,rolout,dfncrl,detect,solbem,raidnc,flash,psycic,psycup,drmeat,ngtmar,shdbal,zapcan,thundr,thnblt,irntal,streng,rocsms,hedbut,mudslp,sunday,protct,dbltem,slptlk,curse,hidpwr,swager,frustr,return,toxic,snore,rest,endure,atract,bide,mimic,substu,rage,dbledg,takdwn,sklbas,bodslm,wtrgun,bblbem,icebem,blizrd,icywnd,surf,wrlpol,wtrfal,swift,payday,triatk,rflect,thnwav,telprt,psywav,metrnm,countr,megpnc,seitos,submis,megkck,dynpnc,firpnc,thnpnc,icepnc,firbls,flmthr,fisure,eartqk,sndstr,hypbem,roar,stlwng,fly,razwnd,wrlwnd,skyatk,wngatk,peck,mirmov,fntatk,witdrw,rapspn,supsnc,aurbem,mircot,psnstg,spite,crunch,pursut,strsht,lechlf,btnpas,disabl,screch,tackle,flmwel,revrsl,fryswp,fcseng,forsgt,lowkck,rolkck,encore,wrap,growth,vinwip,sacfir,sharpn,sketch,tm05,______"]] $$

-- TODO: should this trainer names be a split? or zobj invocation
|[c_trnr_names]|        split"youngs,sage,falknr,grunt,bugctr,bugsy,pkmfan,beauty,witney,kimono,medium,morty,police,karate,chuck,gentle,sailor,jasmin,rocket,skier,pryce,scient,twins,clair,nerd,camper,brock,school,swimer,misty,jugler,guitar,ltsurg,hiker,lass,erika,biker,picnik,janine,maniac,psycic,sabrin,fisher,breath,blaine,birdkp,cooltr,blue,legend,silver,will,koga,bruno,karen,lance,red,gold,horde" $$
|[c_type_names]|        f_zobj[["0,none;,normal,fire,fightng,water,poison,electrc,ground,grass,flying,ice,bug,psychic,rock,dragon,ghost,dark,steel,bird"]] $$
|[c_item_names]|        f_zobj[["0,none;,pnkbow,chrcol,blkblt,myswtr,psnbrb,magnet,sosand,mirasd,shbeak,nvrice,slvpwd,twspon,hrdstn,dragsc,speltg,blkgls,mtlcot,plkbow,bripwd,focbnd,kingrk,leftov,qikclw,scopln,amcoin,litbal,lukpnc,mtlpwd,stick,thkclb,bersrk,berry,gldbry,btrbry,mntbry,brnbry,icebry,parbry,psnbry,mirbry,mysbry"]] $$
|[c_team_names]|        f_zobj[["0,boy;,girl,cpu-boy,cpu-girl"]] $$
|[c_stages]| f_zobj[[
  attack,         "attack",
  defense,        "defens",
  specialattack,  "spcatk",
  specialdefense, "spcdef",
  speed,          "speed",
  crit,           "crit",
  evasion,        "evason",
  accuracy,       "accury"
]] $$

|[c_pkmn_names]| f_zobj[[
 0,"misingno"
 ;,"bulbsaur" ,"ivysaur"  ,"venusaur" ,"charmand" ,"charmeln" ,"charzard" ,"squirtle" ,"wartortl" ,"blastois" ,"caterpie" ,"metapod"  ,"butrfree" ,"weedle"   ,"kakuna"   ,"beedrill"
  ,"pidgey"   ,"pidgeoto" ,"pidgeot"  ,"rattata"  ,"raticate" ,"spearow"  ,"fearow"   ,"ekans"    ,"arbok"    ,"pikachu"  ,"raichu"   ,"sndshrew" ,"sndslash" ,"nidoranf" ,"nidorina"
  ,"nidoquen" ,"nidoranm" ,"nidorino" ,"nidoking" ,"clefairy" ,"clefable" ,"vulpix"   ,"ninetale" ,"jiglypuf" ,"wiglytuf" ,"zubat"    ,"golbat"   ,"oddish"   ,"gloom"    ,"vileplum"
  ,"paras"    ,"parasect" ,"venonat"  ,"venomoth" ,"diglett"  ,"dugtrio"  ,"meowth"   ,"persian"  ,"psyduck"  ,"golduck"  ,"mankey"   ,"primeape" ,"growlith" ,"arcanine" ,"poliwag"
  ,"polwhirl" ,"polwrath" ,"abra"     ,"kadabra"  ,"alakazam" ,"machop"   ,"machoke"  ,"machamp"  ,"belsprot" ,"weepnbel" ,"victrbel" ,"tntacool" ,"tntcruel" ,"geodude"  ,"graveler"
  ,"golem"    ,"ponyta"   ,"rapidash" ,"slowpoke" ,"slowbro"  ,"magnemit" ,"magneton" ,"fafetchd" ,"doduo"    ,"dodrio"   ,"seel"     ,"dewgong"  ,"grimer"   ,"muk"      ,"shellder"
  ,"cloyster" ,"gastly"   ,"haunter"  ,"gengar"   ,"onix"     ,"drowzee"  ,"hypno"    ,"krabby"   ,"kingler"  ,"voltorb"  ,"electrod" ,"exegcute" ,"exegutor" ,"cubone"   ,"marowak"
  ,"hitmnlee" ,"hitmnchn" ,"licktung" ,"koffing"  ,"weezing"  ,"rhyhorn"  ,"rhydon"   ,"chansey"  ,"tangela"  ,"kangakan" ,"horsea"   ,"seadra"   ,"goldeen"  ,"seaking"  ,"staryu"
  ,"starmie"  ,"mrmime"   ,"scyther"  ,"jynx"     ,"elecabuz" ,"magmar"   ,"pinsir"   ,"tauros"   ,"magikarp" ,"gyarados" ,"lapras"   ,"ditto"    ,"eevee"    ,"vaporeon" ,"jolteon"
  ,"flareon"  ,"porygon"  ,"omanyte"  ,"omastar"  ,"kabuto"   ,"kabutops" ,"aerodact" ,"snorlax"  ,"articuno" ,"zapdos"   ,"moltres"  ,"dratini"  ,"dragnair" ,"dragnite" ,"mewtwo"
  ,"mew"      ,"chikrita" ,"bayleef"  ,"meganium" ,"cyndquil" ,"quilava"  ,"typhlosn" ,"totodile" ,"croconaw" ,"fralgatr" ,"sentret"  ,"furret"   ,"hoothoot" ,"noctowl"  ,"ledyba"
  ,"ledian"   ,"spinarak" ,"ariados"  ,"crobat"   ,"chinchou" ,"lanturn"  ,"pichu"    ,"cleffa"   ,"igglybuf" ,"togepi"   ,"togetic"  ,"natu"     ,"xatu"     ,"mareep"   ,"flaaffy"
  ,"ampharos" ,"belossom" ,"marill"   ,"azumaril" ,"sudwoodo" ,"politoed" ,"hoppip"   ,"skiploom" ,"jumpluff" ,"aipom"    ,"sunkern"  ,"sunflora" ,"yanma"    ,"wooper"   ,"quagsire"
  ,"espeon"   ,"umbreon"  ,"murkrow"  ,"slowking" ,"misdrvus" ,"unown"    ,"wobbufet" ,"girafrig" ,"pineco"   ,"foretres" ,"dunsparc" ,"gligar"   ,"steelix"  ,"snubbull" ,"granbull"
  ,"qwilfish" ,"scizor"   ,"shuckle"  ,"heracros" ,"sneasel"  ,"tediursa" ,"ursaring" ,"slugma"   ,"magcargo" ,"swinub"   ,"piloswin" ,"corsola"  ,"remoraid" ,"octilery" ,"delibird"
  ,"mantine"  ,"skarmory" ,"houndour" ,"houndoom" ,"kingdra"  ,"phanpy"   ,"donphan"  ,"porygon2" ,"stantler" ,"smeargle" ,"tyrogue"  ,"hitmntop" ,"smoochum" ,"elekid"   ,"magby"
  ,"miltank"  ,"blissey"  ,"raikou"   ,"entei"    ,"suicune"  ,"larvitar" ,"pupitar"  ,"tyrnitar" ,"lugia"    ,"hooh"     ,"celebi"

  ,"________" ,"none" ,"___" ,"___" -- TODO: are all these ending ones used? Document what each one does
]] $$

|[c_gender_names]|      f_zobj[["0,neuter;,male,female,mal/fem"]] $$
|[c_major_names_long]|  f_zobj[["0,none;,fainted,burned,frozen,paralyzed,poisoned,sleeping"]] $$
|[c_major_names_short]| f_zobj[["0,___;,fnt,brn,fzn,par,psn,slp"]] $$
|[c_movemethod_names]|  split"learn,teach,cheat" $$
|[c_statmod_names]|     f_zobj[[attack,"atack", defense,"defns", specialattack,"spatk", specialdefense,"spdfn", speed,"speed", evasion,"evasn", accuracy,"acury", crit,"critl"]] $$
|[c_weather_names]|     f_zobj[["0, ;,rainy,sunny,sandy"]] $$ -- TODO: could this be a split?

-- todo: can this go in cartridge data? maybe i dont want that though (uses more tokens)
|[c_palettes]| f_zobj[[
  -- bg   mg   fg
  0;,129 ,13  ,6   -- gen2
  ;;,0   ,5   ,6   -- pong
  ;;,131 ,3   ,138 -- gboy
  ;;,0   ,8   ,10  -- hdog
  ;;,141  ,12  ,7  -- cga
  ;;,1   ,140   ,8 -- rb
  ;;,5   ,9  ,10   -- gs
]] $$

|[c_palette_names]| f_zobj[["0,dual;,pong,gboy,hdog,cga,rebl,gosi"]] $$

|[c_types]| f_zobj[[ -- 0 to 18 are all tables
  0;, ;;, ;;, ;;, ;;, ;;, ;;, ;;, ;;,
  ;;, ;;, ;;, ;;, ;;, ;;, ;;, ;;, ;;,
  ;;,
]] $$

-- this has to go after all the moves, so that the move functions are available in the global scope
-- also this cannot be a part of zobj so it can actually access all the things.
|[c_move_funcs]| f_zobj[[
  0;,~f_move_struggle     ,0                                                            -- M_STRUGGLE
  ;;,~f_move_default      ,10 ,~f_move_stat ,~c_no ,defense ,-1                         -- M_ACID
  ;;,~f_move_stat         ,~c_yes ,defense ,2                                           -- M_ACIDARMOR
  ;;,~f_move_barrage      ,0                                                            -- M_BARRAGE
  ;;,~f_move_default      ,10 ,~f_move_flinch                                           -- M_BONECLUB
  ;;,~f_move_default      ,100 ,~f_move_trap                                            -- M_BIND
  ;;,~f_move_default      ,100 ,~f_move_trap                                            -- M_CLAMP
  ;;,~f_move_moonlight                                                                  -- M_MOONLIGHT
  ;;,~f_move_splash       ,0                                                            -- M_LEECHSEED
  ;;,~f_move_default                                                                    -- M_EXTREMESPEED
  ;;,~f_move_seismictoss  ,20                                                           -- M_SONICBOOM
  ;;,~f_move_splash       ,0                                                            -- M_TWINEEDLE
  ;;,~f_move_default      ,10 ,~f_move_major_other ,C_MAJOR_PARALYZED                   -- M_THUNDERSHOCK
  ;;,~f_move_major_other  ,C_MAJOR_PARALYZED                                            -- M_GLARE
  ;;,~f_move_splash       ,0                                                            -- M_GUILLOTINE
  ;;,~f_move_default      ,10 ,~f_move_flinch                                           -- M_HYPERFANG
  ;;,~f_move_splash       ,0                                                            -- M_JUMPKICK
  ;;,~f_move_stat ,~c_no ,accuracy ,-1                                                  -- M_KINESIS
  ;;,~f_move_splash       ,0                                                            -- M_LOCKON
  ;;,~f_move_major_other  ,C_MAJOR_SLEEPING                                             -- M_LOVELYKISS
  ;;,~f_move_default                                                                    -- M_MACHPUNCH
  ;;,~f_move_default                                                                    -- M_VICEGRIP
  ;;,~f_move_barrage      ,0                                                            -- M_SPIKECANNON
  ;;,~f_move_splash       ,0                                                            -- M_SPIKES
  ;;,~f_move_major_other  ,C_MAJOR_SLEEPING                                             -- M_SPORE
  ;;,~f_move_stat ,~c_no ,speed ,-2                                                     -- M_COTTONSPORE
  ;;,~f_move_present      ,0                                                            -- M_PRESENT
  ;;,~f_move_splash       ,0                                                            -- M_VITALTHROW
  ;;,~f_move_barrage      ,0                                                            -- M_COMETPUNCH
  ;;,~f_move_default                                                                    -- M_DRILLPECK
  ;;,~f_move_stat ,~c_no ,accuracy ,-1                                                  -- M_SANDATTACK
  ;;,~f_move_stat         ,~c_yes ,speed ,2                                             -- M_AGILITY
  ;;,~f_move_barrage      ,0                                                            -- M_FURYATTACK
  ;;,~f_move_default                                                                    -- M_QUICKATTACK
  ;;,~f_move_falseswipe   ,0                                                            -- M_FALSESWIPE
  ;;,~f_move_stat ,~c_no ,attack ,-1                                                    -- M_GROWL
  ;;,~f_move_splash       ,0                                                            -- M_HEALBELL
  ;;,~f_move_major_other  ,C_MAJOR_SLEEPING                                             -- M_SING
  ;;,~f_move_default                                                                    -- M_POUND
  ;;,~f_move_stat         ,~c_yes ,evasion ,1                                           -- M_MINIMIZE -- TODO: add a func to this that sets some minimize variable (used for stomp and sprite change)
  ;;,~f_move_stat ,~c_no ,defense ,-1                                                   -- M_TAILWHIP
  ;;,~f_move_barrage      ,0                                                            -- M_DOUBLESLAP
  ;;,~f_move_default                                                                    -- M_MEGAHORN
  ;;,~f_move_doublekick   ,2                                                            -- M_BONEMERANG
  ;;,~f_move_splash       ,0                                                            -- M_CONVERSION
  ;;,~f_move_splash       ,0                                                            -- M_CONVERSION2
  ;;,~f_move_default      ,30 ,~f_move_major_other ,C_MAJOR_PARALYZED                   -- M_SPARK
  ;;,~f_move_recover                                                                    -- M_MILKDRINK
  ;;,~f_move_moonlight                                                                  -- M_MORNINGSUN
  ;;,~f_move_seismictoss  ,50                                                           -- M_NIGHTSHADE
  ;;,~f_move_default      ,50 ,~f_move_stat ,~c_no ,accuracy ,-1                        -- M_OCTAZOOKA
  ;;,~f_move_barrage      ,0                                                            -- M_PINMISSILE
  ;;,~f_move_default      ,10 ,~f_move_major_other ,C_MAJOR_FROZEN                      -- M_POWDERSNOW
  ;;,~f_move_superfang    ,0                                                            -- M_SUPERFANG
  ;;,~f_move_default      ,100 ,~f_move_trap                                            -- M_FIRESPIN
  ;;,~f_move_major_other  ,C_MAJOR_POISONED                                             -- M_POISONGAS
  ;;,~f_move_stat         ,~c_yes ,defense ,2                                           -- M_BARRIER
  ;;,~f_move_stat         ,~c_yes ,attack ,1                                            -- M_MEDITATE
  ;;,~f_move_splash       ,0                                                            -- M_FUTURESIGHT
  ;;,~f_move_major_other  ,C_MAJOR_SLEEPING                                             -- M_HYPNOSIS
  ;;,~f_move_default      ,10 ,~f_move_confuse                                          -- M_PSYBEAM
  ;;,~f_move_splash       ,0                                                            -- M_LIGHTSCREEN
  ;;,~f_move_splash       ,0                                                            -- M_SAFEGUARD
  ;;,~f_move_splash       ,0                                                            -- M_PETALDANCE
  ;;,~f_move_stat ,~c_no ,attack ,-2                                                    -- M_CHARM
  ;;,~f_move_moonlight                                                                  -- M_SYNTHESIS
  ;;,~f_move_stat         ,~c_no ,evasion ,-1                                           -- M_SWEETSCENT
  ;;,~f_move_default                                                                    -- M_RAZORLEAF
  ;;,~f_move_major_other  ,C_MAJOR_POISONED                                             -- M_POISONPOWDER
  ;;,~f_move_major_other  ,C_MAJOR_SLEEPING                                             -- M_SLEEPPOWDER
  ;;,~f_move_drain                                                                      -- M_ABSORB
  ;;,~f_move_major_other  ,C_MAJOR_PARALYZED                                            -- M_STUNSPORE
  ;;,~f_move_flail        ,0                                                            -- M_FLAIL
  ;;,~f_move_default      ,10 ,~f_move_confuse                                          -- M_CONFUSION
  ;;,~f_move_default                                                                    -- M_SLAM
  ;;,~f_move_default      ,10 ,~f_move_stat ,~c_no ,speed ,-1                           -- M_CONSTRICT
  ;;,~f_move_stat         ,~c_yes ,specialdefense ,2                                    -- M_AMNESIA
  ;;,~f_move_default      ,10 ,~f_move_stat ,~c_no ,speed ,-1                           -- M_BUBBLE
  ;;,~f_move_splash       ,0                                                            -- M_SPLASH
  ;;,~f_move_default                                                                    -- M_HYDROPUMP
  ;;,~f_move_splash       ,0                                                            -- M_MINDREADER
  ;;,~f_move_splash       ,0                                                            -- M_MIST
  ;;,~f_move_default                                                                    -- M_HORNATTACK
  ;;,~f_move_meanlook                                                                   -- M_SPIDERWEB
  ;;,~f_move_doublekick   ,2                                                            -- M_DOUBLEKICK
  ;;,~f_move_confuse                                                                    -- M_SWEETKISS
  ;;,~f_move_default      ,10 ,~f_move_stat ,~c_yes ,attack ,1                          -- M_METALCLAW
  ;;,~f_move_splash       ,0                                                            -- M_TRANSFORM
  ;;,~f_move_doublekick   ,3                                                            -- M_TRIPLEKICK
  ;;,~f_move_default                                                                    -- M_GUST
  ;;,~f_move_splash       ,0                                                            -- M_TWISTER
  ;;,~f_move_default                                                                    -- M_CRABHAMMER
  ;;,~f_move_default      ,20 ,~f_move_confuse                                          -- M_DIZZYPUNCH
  ;;,~f_move_default      ,30 ,~f_move_major_other ,C_MAJOR_POISONED                    -- M_SLUDGE
  ;;,~f_move_splash       ,0                                                            -- M_PAINSPLIT
  ;;,~f_move_splash       ,0                                                            -- M_DESTINYBOND
  ;;,~f_move_splash       ,0                                                            -- M_HAZE
  ;;,~f_move_default      ,30 ,~f_move_major_other ,C_MAJOR_PARALYZED                   -- M_LICK
  ;;,~f_move_splash       ,0                                                            -- M_PERISHSONG
  ;;,~f_move_meanlook                                                                   -- M_MEANLOOK
  ;;,~f_move_confuse                                                                    -- M_CONFUSERAY
  ;;,~f_move_default                                                                    -- M_CROSSCHOP
  ;;,~f_move_default      ,40 ,~f_move_major_other ,C_MAJOR_POISONED                    -- M_SMOG
  ;;,~f_move_default                                                                    -- M_KARATECHOP
  ;;,~f_move_default      ,10 ,~f_move_major_other ,C_MAJOR_BURNED                      -- M_EMBER
  ;;,~f_move_stat ,~c_no ,accuracy ,-1                                                  -- M_SMOKESCREEN
  ;;,~f_move_splash       ,0                                                            -- M_BELLYDRUM -- this might be possible with a self recoil func?
  ;;,~f_move_splash       ,0                                                            -- M_BEATUP
  ;;,~f_move_default                                                                    -- M_SCRATCH
  ;;,~f_move_default                                                                    -- M_SLASH
  ;;,~f_move_splash       ,0                                                            -- M_ANCIENTPOWER
  ;;,~f_move_stat ,~c_no ,defense ,-1                                                   -- M_LEER
  ;;,~f_move_default      ,30 ,~f_move_flinch                                           -- M_BITE
  ;;,~f_move_splash       ,0                                                            -- M_OUTRAGE
  ;;,~f_move_stat ,~c_no ,speed ,-2                                                     -- M_SCARYFACE
  ;;,~f_move_splash       ,0                                                            -- M_THRASH
  ;;,~f_move_splash       ,0                                                            -- M_STOMP
  ;;,~f_move_default      ,30 ,~f_move_flinch                                           -- M_ROCKSLIDE
  ;;,~f_move_magnitude    ,0                                                            -- M_MAGNITUDE
  ;;,~f_move_default                                                                    -- M_ROCKTHROW
  ;;,~f_move_stat         ,~c_yes ,defense ,1                                           -- M_HARDEN
  ;;,~f_move_barrage      ,0                                                            -- M_BONERUSH
  ;;,~f_move_splash       ,0                                                            -- M_HIJUMPKICK
  ;;,~f_move_recover                                                                    -- M_RECOVER
  ;;,~f_move_default                                                                    -- M_AEROBLAST
  ;;,~f_move_splash       ,0                                                            -- M_HORNDRILL
  ;;,~f_move_seismictoss  ,40                                                           -- M_DRAGONRAGE
  ;;,~f_move_recover                                                                    -- M_SOFTBOILED
  ;;,~f_move_default      ,30 ,~f_move_major_other ,C_MAJOR_PARALYZED                   -- M_DRAGONBREATH
  ;;,~f_move_default                                                                    -- M_SELFDESTRUCT
  ;;,~f_move_default                                                                    -- M_EXPLOSION
  ;;,~f_move_default                                                                    -- M_EGGBOMB
  ;;,~f_move_default      ,30 ,~f_move_major_other ,C_MAJOR_POISONED                    -- M_SLUDGEBOMB
  ;;,~f_move_drain                                                                      -- M_GIGADRAIN
  ;;,~f_move_drain                                                                      -- M_MEGADRAIN
  ;;,~f_move_stat         ,~c_yes ,attack ,2                                            -- M_SWORDSDANCE
  ;;,~f_move_default                                                                    -- M_CUT
  ;;,~f_move_splash       ,0                                                            -- M_FURYCUTTER
  ;;,~f_move_splash       ,0                                                            -- M_THIEF
  ;;,~f_move_splash       ,0                                                            -- M_DIG
  ;;,~f_move_splash       ,0                                                            -- M_ROLLOUT
  ;;,~f_move_splash       ,0                                                            -- M_DEFENSECURL
  ;;,~f_move_splash       ,0                                                            -- M_DETECT
  ;;,~f_move_splash       ,0                                                            -- M_SOLARBEAM
  ;;,~f_move_weather ,C_WEATHER_RAIN                                                    -- M_RAINDANCE
  ;;,~f_move_stat ,~c_no ,accuracy ,-1                                                  -- M_FLASH
  ;;,~f_move_default      ,10 ,~f_move_stat ,~c_no ,specialdefense ,-1                  -- M_PSYCHIC
  ;;,~f_move_splash       ,0                                                            -- M_PSYCHUP
  ;;,~f_move_splash       ,0                                                            -- M_DREAMEATER
  ;;,~f_move_splash       ,0                                                            -- M_NIGHTMARE
  ;;,~f_move_default      ,20 ,~f_move_stat ,~c_no ,specialdefense ,-1                  -- M_SHADOWBALL
  ;;,~f_move_default      ,100, ~f_move_major_other  ,C_MAJOR_PARALYZED                 -- M_ZAPCANNON
  ;;,~f_move_default      ,30 ,~f_move_major_other ,C_MAJOR_PARALYZED                   -- M_THUNDER
  ;;,~f_move_default      ,10 ,~f_move_major_other ,C_MAJOR_PARALYZED                   -- M_THUNDERBOLT
  ;;,~f_move_default      ,30 ,~f_move_stat ,~c_no ,defense ,-1                         -- M_IRONTAIL
  ;;,~f_move_default                                                                    -- M_STRENGTH
  ;;,~f_move_default      ,50 ,~f_move_stat ,~c_no ,defense ,-1                         -- M_ROCKSMASH
  ;;,~f_move_default      ,30 ,~f_move_flinch                                           -- M_HEADBUTT
  ;;,~f_move_default      ,100 ,~f_move_stat ,~c_no ,accuracy ,-1                       -- M_MUDSLAP
  ;;,~f_move_weather ,C_WEATHER_SUN                                                     -- M_SUNNYDAY
  ;;,~f_move_splash       ,0                                                            -- M_PROTECT
  ;;,~f_move_stat         ,~c_yes ,evasion ,1                                           -- M_DOUBLETEAM
  ;;,~f_move_splash       ,0                                                            -- M_SLEEPTALK
  ;;,~f_move_splash       ,0                                                            -- M_CURSE
  ;;,~f_move_hiddenpower  ,0                                                            -- M_HIDDENPOWER
  ;;,~f_move_splash       ,0                                                            -- M_SWAGGER
  ;;,~f_move_frustration  ,0                                                            -- M_FRUSTRATION
  ;;,~f_move_return       ,0                                                            -- M_RETURN
  ;;,~f_move_splash       ,0                                                            -- M_TOXIC
  ;;,~f_move_splash       ,0                                                            -- M_SNORE
  ;;,~f_move_splash       ,0                                                            -- M_REST
  ;;,~f_move_splash       ,0                                                            -- M_ENDURE
  ;;,~f_move_splash       ,0                                                            -- M_ATTRACT
  ;;,~f_move_splash       ,0                                                            -- M_BIDE
  ;;,~f_move_splash       ,0                                                            -- M_MIMIC
  ;;,~f_move_splash       ,0                                                            -- M_SUBSTITUTE
  ;;,~f_move_splash       ,0                                                            -- M_RAGE
  ;;,~f_move_submission   ,0                                                            -- M_DOUBLEEDGE
  ;;,~f_move_submission   ,0                                                            -- M_TAKEDOWN
  ;;,~f_move_splash       ,0                                                            -- M_SKULLBASH
  ;;,~f_move_default      ,30 ,~f_move_major_other ,C_MAJOR_PARALYZED                   -- M_BODYSLAM
  ;;,~f_move_default                                                                    -- M_WATERGUN
  ;;,~f_move_default      ,10  ,~f_move_stat ,~c_no ,speed ,-1                          -- M_BUBBLEBEAM
  ;;,~f_move_default      ,10  ,~f_move_major_other ,C_MAJOR_FROZEN                     -- M_ICEBEAM
  ;;,~f_move_default      ,10  ,~f_move_major_other ,C_MAJOR_FROZEN                     -- M_BLIZZARD
  ;;,~f_move_default      ,100 ,~f_move_stat ,~c_no ,speed ,-1                          -- M_ICYWIND
  ;;,~f_move_default                                                                    -- M_SURF
  ;;,~f_move_default      ,100 ,~f_move_trap                                            -- M_WHIRLPOOL
  ;;,~f_move_default                                                                    -- M_WATERFALL
  ;;,~f_move_splash       ,0                                                            -- M_SWIFT
  ;;,~f_move_default                                                                    -- M_PAYDAY
  ;;,~f_move_splash       ,0                                                            -- M_TRIATTACK
  ;;,~f_move_splash       ,0                                                            -- M_REFLECT
  ;;,~f_move_major_other  ,C_MAJOR_PARALYZED                                            -- M_THUNDERWAVE
  ;;,~f_move_switch ,~c_yes                                                             -- M_TELEPORT
  ;;,~f_move_psywave      ,0                                                            -- M_PSYWAVE
  ;;,~f_move_splash       ,0                                                            -- M_METRONOME
  ;;,~f_move_splash       ,0                                                            -- M_COUNTER
  ;;,~f_move_default                                                                    -- M_MEGAPUNCH
  ;;,~f_move_seismictoss  ,50                                                           -- M_SEISMICTOSS -- TODO: revert to correct number was here jost fur tastieng
  ;;,~f_move_submission   ,0                                                            -- M_SUBMISSION
  ;;,~f_move_default                                                                    -- M_MEGAKICK
  ;;,~f_move_default      ,100 ,~f_move_confuse                                         -- M_DYNAMICPUNCH
  ;;,~f_move_default      ,10 ,~f_move_major_other ,C_MAJOR_BURNED                      -- M_FIREPUNCH
  ;;,~f_move_default      ,10 ,~f_move_major_other ,C_MAJOR_PARALYZED                   -- M_THUNDERPUNCH
  ;;,~f_move_default      ,10 ,~f_move_major_other ,C_MAJOR_FROZEN                      -- M_ICEPUNCH
  ;;,~f_move_default      ,10 ,~f_move_major_other ,C_MAJOR_BURNED                      -- M_FIREBLAST
  ;;,~f_move_default      ,10 ,~f_move_major_other ,C_MAJOR_BURNED                      -- M_FLAMETHROWER
  ;;,~f_move_splash       ,0                                                            -- M_FISSURE
  ;;,~f_move_default                                                                    -- M_EARTHQUAKE
  ;;,~f_move_weather ,C_WEATHER_SAND                                                    -- M_SANDSTORM
  ;;,~f_move_splash       ,0                                                            -- M_HYPERBEAM
  ;;,~f_move_switch ,~c_no                                                              -- M_ROAR
  ;;,~f_move_default      ,10 ,~f_move_stat ,~c_yes ,defense ,1                         -- M_STEELWING
  ;;,~f_move_splash       ,0                                                            -- M_FLY
  ;;,~f_move_splash       ,0                                                            -- M_RAZORWIND
  ;;,~f_move_switch ,~c_no                                                              -- M_WHIRLWIND
  ;;,~f_move_splash       ,0                                                            -- M_SKYATTACK
  ;;,~f_move_default                                                                    -- M_WINGATTACK
  ;;,~f_move_default                                                                    -- M_PECK
  ;;,~f_move_splash       ,0                                                            -- M_MIRRORMOVE
  ;;,~f_move_splash       ,0                                                            -- M_FAINTATTACK
  ;;,~f_move_stat         ,~c_yes ,defense ,1                                           -- M_WITHDRAW
  ;;,~f_move_splash       ,0                                                            -- M_RAPIDSPIN
  ;;,~f_move_confuse                                                                    -- M_SUPERSONIC
  ;;,~f_move_default      ,10 ,~f_move_stat ,~c_no ,attack ,-1                          -- M_AURORABEAM
  ;;,~f_move_splash       ,0                                                            -- M_MIRRORCOAT
  ;;,~f_move_default      ,30 ,~f_move_major_other ,C_MAJOR_POISONED                    -- M_POISONSTING
  ;;,~f_move_splash       ,0                                                            -- M_SPITE
  ;;,~f_move_default      ,20 ,~f_move_stat ,~c_no ,specialdefense ,-1                  -- M_CRUNCH
  ;;,~f_move_default                                                                    -- M_PURSUIT
  ;;,~f_move_stat ,~c_no ,speed ,-1                                                     -- M_STRINGSHOT
  ;;,~f_move_drain                                                                      -- M_LEECHLIFE
  ;;,~f_move_splash       ,0                                                            -- M_BATONPASS
  ;;,~f_move_splash       ,0                                                            -- M_DISABLE
  ;;,~f_move_stat ,~c_no ,defense ,-2                                                   -- M_SCREECH
  ;;,~f_move_default                                                                    -- M_TACKLE
  ;;,~f_move_default      ,10 ,~f_move_major_other ,C_MAJOR_BURNED                      -- M_FLAMEWHEEL
  ;;,~f_move_flail        ,0                                                            -- M_REVERSAL
  ;;,~f_move_barrage      ,0                                                            -- M_FURYSWIPES
  ;;,~f_move_stat         ,~c_yes ,crit ,1                                              -- M_FOCUSENERGY
  ;;,~f_move_splash       ,0                                                            -- M_FORESIGHT
  ;;,~f_move_default      ,30 ,~f_move_flinch                                           -- M_LOWKICK
  ;;,~f_move_default      ,30 ,~f_move_flinch                                           -- M_ROLLINGKICK
  ;;,~f_move_splash       ,0                                                            -- M_ENCORE
  ;;,~f_move_default      ,100 ,~f_move_trap                                            -- M_WRAP
  ;;,~f_move_stat         ,~c_yes ,specialattack ,1                                     -- M_GROWTH
  ;;,~f_move_default                                                                    -- M_VINEWHIP
  ;;,~f_move_default      ,50 ,~f_move_major_other ,C_MAJOR_BURNED                      -- M_SACREDFIRE
  ;;,~f_move_stat         ,~c_yes ,attack ,1                                            -- M_SHARPEN
  ;;,~f_move_splash       ,0                                                            -- M_SKETCH
  ;;,~f_move_stat         ,~c_yes ,evasion ,2                                           -- M_TM05
  ;;,~f_move_splash       ,0                                                            -- M_NONE
]] $$
