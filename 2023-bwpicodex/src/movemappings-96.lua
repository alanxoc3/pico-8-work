                        -- this has to go after all the moves, so that the move functions are available in the global scope
|[c_move_funcs]| f_zobj[[  -- for some reason, the ~tilde syntax doesn't work here. TODO: spend more time figuring out why.
0;,f_move_splash       ,0  -- M_STRUGGLE
;;,f_move_splash       ,0  -- M_ACID
;;,f_move_splash       ,0  -- M_ACIDARMOR
;;,f_move_splash       ,0  -- M_BARRAGE
;;,f_move_splash       ,0  -- M_BONECLUB
;;,f_move_splash       ,0  -- M_BIND
;;,f_move_splash       ,0  -- M_CLAMP
;;,f_move_splash       ,0  -- M_MOONLIGHT
;;,f_move_splash       ,0  -- M_LEECHSEED
;;,f_move_splash       ,0  -- M_EXTREMESPEED
;;,f_move_seismictoss  ,20 -- M_SONICBOOM
;;,f_move_splash       ,0  -- M_TWINEEDLE
;;,f_move_splash       ,0  -- M_THUNDERSHOCK
;;,f_move_splash       ,0  -- M_GLARE
;;,f_move_splash       ,0  -- M_GUILLOTINE
;;,f_move_splash       ,0  -- M_HYPERFANG
;;,f_move_splash       ,0  -- M_JUMPKICK
;;,f_move_splash       ,0  -- M_KINESIS
;;,f_move_splash       ,0  -- M_LOCKON
;;,f_move_splash       ,0  -- M_LOVELYKISS
;;,f_move_splash       ,0  -- M_MACHPUNCH
;;,f_move_tackle       ,0  -- M_VICEGRIP
;;,f_move_splash       ,0  -- M_SPIKECANNON
;;,f_move_splash       ,0  -- M_SPIKES
;;,f_move_splash       ,0  -- M_SPORE
;;,f_move_splash       ,0  -- M_COTTONSPORE
;;,f_move_splash       ,0  -- M_PRESENT
;;,f_move_splash       ,0  -- M_VITALTHROW
;;,f_move_splash       ,0  -- M_COMETPUNCH
;;,f_move_tackle       ,0  -- M_DRILLPECK
;;,f_move_splash       ,0  -- M_SANDATTACK
;;,f_move_splash       ,0  -- M_AGILITY
;;,f_move_splash       ,0  -- M_FURYATTACK
;;,f_move_splash       ,0  -- M_QUICKATTACK
;;,f_move_falseswipe   ,0  -- M_FALSESWIPE
;;,f_move_splash       ,0  -- M_GROWL
;;,f_move_splash       ,0  -- M_HEALBELL
;;,f_move_splash       ,0  -- M_SING
;;,f_move_tackle       ,0  -- M_POUND
;;,f_move_splash       ,0  -- M_MINIMIZE
;;,f_move_splash       ,0  -- M_TAILWHIP
;;,f_move_splash       ,0  -- M_DOUBLESLAP
;;,f_move_tackle       ,0  -- M_MEGAHORN
;;,f_move_splash       ,0  -- M_BONEMERANG
;;,f_move_splash       ,0  -- M_CONVERSION
;;,f_move_splash       ,0  -- M_CONVERSION2
;;,f_move_splash       ,0  -- M_SPARK
;;,f_move_recover      ,0  -- M_MILKDRINK
;;,f_move_splash       ,0  -- M_MORNINGSUN
;;,f_move_seismictoss  ,50 -- M_NIGHTSHADE
;;,f_move_splash       ,0  -- M_OCTAZOOKA
;;,f_move_splash       ,0  -- M_PINMISSILE
;;,f_move_splash       ,0  -- M_POWDERSNOW
;;,f_move_superfang    ,0  -- M_SUPERFANG
;;,f_move_splash       ,0  -- M_FIRESPIN
;;,f_move_splash       ,0  -- M_POISONGAS
;;,f_move_splash       ,0  -- M_BARRIER
;;,f_move_splash       ,0  -- M_MEDITATE
;;,f_move_splash       ,0  -- M_FUTURESIGHT
;;,f_move_splash       ,0  -- M_HYPNOSIS
;;,f_move_splash       ,0  -- M_PSYBEAM
;;,f_move_splash       ,0  -- M_LIGHTSCREEN
;;,f_move_splash       ,0  -- M_SAFEGUARD
;;,f_move_splash       ,0  -- M_PETALDANCE
;;,f_move_splash       ,0  -- M_CHARM
;;,f_move_splash       ,0  -- M_SYNTHESIS
;;,f_move_splash       ,0  -- M_SWEETSCENT
;;,f_move_splash       ,0  -- M_RAZORLEAF
;;,f_move_splash       ,0  -- M_POISONPOWDER
;;,f_move_splash       ,0  -- M_SLEEPPOWDER
;;,f_move_splash       ,0  -- M_ABSORB
;;,f_move_splash       ,0  -- M_STUNSPORE
;;,f_move_splash       ,0  -- M_FLAIL
;;,f_move_splash       ,0  -- M_CONFUSION
;;,f_move_tackle       ,0  -- M_SLAM
;;,f_move_splash       ,0  -- M_CONSTRICT
;;,f_move_splash       ,0  -- M_AMNESIA
;;,f_move_splash       ,0  -- M_BUBBLE
;;,f_move_splash       ,0  -- M_SPLASH
;;,f_move_tackle       ,0  -- M_HYDROPUMP
;;,f_move_splash       ,0  -- M_MINDREADER
;;,f_move_splash       ,0  -- M_MIST
;;,f_move_tackle       ,0  -- M_HORNATTACK
;;,f_move_splash       ,0  -- M_SPIDERWEB
;;,f_move_splash       ,0  -- M_DOUBLEKICK
;;,f_move_splash       ,0  -- M_SWEETKISS
;;,f_move_splash       ,0  -- M_METALCLAW
;;,f_move_splash       ,0  -- M_TRANSFORM
;;,f_move_splash       ,0  -- M_TRIPLEKICK
;;,f_move_splash       ,0  -- M_GUST
;;,f_move_splash       ,0  -- M_TWISTER
;;,f_move_splash       ,0  -- M_CRABHAMMER
;;,f_move_splash       ,0  -- M_DIZZYPUNCH
;;,f_move_splash       ,0  -- M_SLUDGE
;;,f_move_splash       ,0  -- M_PAINSPLIT
;;,f_move_splash       ,0  -- M_DESTINYBOND
;;,f_move_splash       ,0  -- M_HAZE
;;,f_move_splash       ,0  -- M_LICK
;;,f_move_splash       ,0  -- M_PERISHSONG
;;,f_move_splash       ,0  -- M_MEANLOOK
;;,f_move_splash       ,0  -- M_CONFUSERAY
;;,f_move_splash       ,0  -- M_CROSSCHOP
;;,f_move_splash       ,0  -- M_SMOG
;;,f_move_splash       ,0  -- M_KARATECHOP
;;,f_move_splash       ,0  -- M_EMBER
;;,f_move_splash       ,0  -- M_SMOKESCREEN
;;,f_move_splash       ,0  -- M_BELLYDRUM
;;,f_move_splash       ,0  -- M_BEATUP
;;,f_move_tackle       ,0  -- M_SCRATCH
;;,f_move_splash       ,0  -- M_SLASH
;;,f_move_splash       ,0  -- M_ANCIENTPOWER
;;,f_move_splash       ,0  -- M_LEER
;;,f_move_splash       ,0  -- M_BITE
;;,f_move_splash       ,0  -- M_OUTRAGE
;;,f_move_splash       ,0  -- M_SCARYFACE
;;,f_move_splash       ,0  -- M_THRASH
;;,f_move_splash       ,0  -- M_STOMP
;;,f_move_splash       ,0  -- M_ROCKSLIDE
;;,f_move_splash       ,0  -- M_MAGNITUDE
;;,f_move_tackle       ,0  -- M_ROCKTHROW
;;,f_move_splash       ,0  -- M_HARDEN
;;,f_move_splash       ,0  -- M_BONERUSH
;;,f_move_splash       ,0  -- M_HIJUMPKICK
;;,f_move_recover      ,0  -- M_RECOVER
;;,f_move_splash       ,0  -- M_AEROBLAST
;;,f_move_splash       ,0  -- M_HORNDRILL
;;,f_move_seismictoss  ,40 -- M_DRAGONRAGE
;;,f_move_recover      ,0  -- M_SOFTBOILED
;;,f_move_splash       ,0  -- M_DRAGONBREATH
;;,f_move_tackle       ,0  -- M_SELFDESTRUCT
;;,f_move_tackle       ,0  -- M_EXPLOSION
;;,f_move_tackle       ,0  -- M_EGGBOMB
;;,f_move_splash       ,0  -- M_SLUDGEBOMB
;;,f_move_splash       ,0  -- M_GIGADRAIN
;;,f_move_splash       ,0  -- M_MEGADRAIN
;;,f_move_splash       ,0  -- M_SWORDSDANCE
;;,f_move_tackle       ,0  -- M_CUT
;;,f_move_splash       ,0  -- M_FURYCUTTER
;;,f_move_splash       ,0  -- M_THIEF
;;,f_move_splash       ,0  -- M_DIG
;;,f_move_splash       ,0  -- M_ROLLOUT
;;,f_move_splash       ,0  -- M_DEFENSECURL
;;,f_move_splash       ,0  -- M_DETECT
;;,f_move_splash       ,0  -- M_SOLARBEAM
;;,f_move_splash       ,0  -- M_RAINDANCE
;;,f_move_splash       ,0  -- M_FLASH
;;,f_move_splash       ,0  -- M_PSYCHIC
;;,f_move_splash       ,0  -- M_PSYCHUP
;;,f_move_splash       ,0  -- M_DREAMEATER
;;,f_move_splash       ,0  -- M_NIGHTMARE
;;,f_move_splash       ,0  -- M_SHADOWBALL
;;,f_move_splash       ,0  -- M_ZAPCANNON
;;,f_move_splash       ,0  -- M_THUNDER
;;,f_move_splash       ,0  -- M_THUNDERBOLT
;;,f_move_splash       ,0  -- M_IRONTAIL
;;,f_move_tackle       ,0  -- M_STRENGTH
;;,f_move_splash       ,0  -- M_ROCKSMASH
;;,f_move_splash       ,0  -- M_HEADBUTT
;;,f_move_splash       ,0  -- M_MUDSLAP
;;,f_move_splash       ,0  -- M_SUNNYDAY
;;,f_move_splash       ,0  -- M_PROTECT
;;,f_move_splash       ,0  -- M_DOUBLETEAM
;;,f_move_splash       ,0  -- M_SLEEPTALK
;;,f_move_splash       ,0  -- M_CURSE
;;,f_move_splash       ,0  -- M_HIDDENPOWER
;;,f_move_splash       ,0  -- M_SWAGGER
;;,f_move_splash       ,0  -- M_FRUSTRATION
;;,f_move_splash       ,0  -- M_RETURN
;;,f_move_splash       ,0  -- M_TOXIC
;;,f_move_splash       ,0  -- M_SNORE
;;,f_move_splash       ,0  -- M_REST
;;,f_move_splash       ,0  -- M_ENDURE
;;,f_move_splash       ,0  -- M_ATTRACT
;;,f_move_splash       ,0  -- M_BIDE
;;,f_move_splash       ,0  -- M_MIMIC
;;,f_move_splash       ,0  -- M_SUBSTITUTE
;;,f_move_splash       ,0  -- M_RAGE
;;,f_move_submission   ,0  -- M_DOUBLEEDGE
;;,f_move_submission   ,0  -- M_TAKEDOWN
;;,f_move_splash       ,0  -- M_SKULLBASH
;;,f_move_splash       ,0  -- M_BODYSLAM
;;,f_move_tackle       ,0  -- M_WATERGUN
;;,f_move_splash       ,0  -- M_BUBBLEBEAM
;;,f_move_splash       ,0  -- M_ICEBEAM
;;,f_move_splash       ,0  -- M_BLIZZARD
;;,f_move_splash       ,0  -- M_ICYWIND
;;,f_move_tackle       ,0  -- M_SURF
;;,f_move_splash       ,0  -- M_WHIRLPOOL
;;,f_move_tackle       ,0  -- M_WATERFALL
;;,f_move_splash       ,0  -- M_SWIFT
;;,f_move_tackle       ,0  -- M_PAYDAY
;;,f_move_splash       ,0  -- M_TRIATTACK
;;,f_move_splash       ,0  -- M_REFLECT
;;,f_move_splash       ,0  -- M_THUNDERWAVE
;;,f_move_splash       ,0  -- M_TELEPORT
;;,f_move_psywave      ,0  -- M_PSYWAVE
;;,f_move_splash       ,0  -- M_METRONOME
;;,f_move_splash       ,0  -- M_COUNTER
;;,f_move_tackle       ,0  -- M_MEGAPUNCH
;;,f_move_seismictoss  ,999 -- M_SEISMICTOSS -- TODO: revert to correct number
;;,f_move_submission   ,0  -- M_SUBMISSION
;;,f_move_tackle       ,0  -- M_MEGAKICK
;;,f_move_splash       ,0  -- M_DYNAMICPUNCH
;;,f_move_splash       ,0  -- M_FIREPUNCH
;;,f_move_splash       ,0  -- M_THUNDERPUNCH
;;,f_move_splash       ,0  -- M_ICEPUNCH
;;,f_move_splash       ,0  -- M_FIREBLAST
;;,f_move_splash       ,0  -- M_FLAMETHROWER
;;,f_move_splash       ,0  -- M_FISSURE
;;,f_move_splash       ,0  -- M_EARTHQUAKE
;;,f_move_splash       ,0  -- M_SANDSTORM
;;,f_move_splash       ,0  -- M_HYPERBEAM
;;,f_move_splash       ,0  -- M_ROAR
;;,f_move_splash       ,0  -- M_STEELWING
;;,f_move_splash       ,0  -- M_FLY
;;,f_move_splash       ,0  -- M_RAZORWIND
;;,f_move_splash       ,0  -- M_WHIRLWIND
;;,f_move_splash       ,0  -- M_SKYATTACK
;;,f_move_tackle       ,0  -- M_WINGATTACK
;;,f_move_tackle       ,0  -- M_PECK
;;,f_move_splash       ,0  -- M_MIRRORMOVE
;;,f_move_splash       ,0  -- M_FAINTATTACK
;;,f_move_splash       ,0  -- M_WITHDRAW
;;,f_move_splash       ,0  -- M_RAPIDSPIN
;;,f_move_splash       ,0  -- M_SUPERSONIC
;;,f_move_splash       ,0  -- M_AURORABEAM
;;,f_move_splash       ,0  -- M_MIRRORCOAT
;;,f_move_splash       ,0  -- M_POISONSTING
;;,f_move_splash       ,0  -- M_SPITE
;;,f_move_splash       ,0  -- M_CRUNCH
;;,f_move_tackle       ,0  -- M_PURSUIT
;;,f_move_splash       ,0  -- M_STRINGSHOT
;;,f_move_splash       ,0  -- M_LEECHLIFE
;;,f_move_splash       ,0  -- M_BATONPASS
;;,f_move_splash       ,0  -- M_DISABLE
;;,f_move_splash       ,0  -- M_SCREECH
;;,f_move_tackle       ,0  -- M_TACKLE
;;,f_move_splash       ,0  -- M_FLAMEWHEEL
;;,f_move_splash       ,0  -- M_REVERSAL
;;,f_move_splash       ,0  -- M_FURYSWIPES
;;,f_move_splash       ,0  -- M_FOCUSENERGY
;;,f_move_splash       ,0  -- M_FORESIGHT
;;,f_move_splash       ,0  -- M_LOWKICK
;;,f_move_splash       ,0  -- M_ROLLINGKICK
;;,f_move_splash       ,0  -- M_ENCORE
;;,f_move_splash       ,0  -- M_WRAP
;;,f_move_splash       ,0  -- M_GROWTH
;;,f_move_tackle       ,0  -- M_VINEWHIP
;;,f_move_splash       ,0  -- M_SACREDFIRE
;;,f_move_splash       ,0  -- M_SHARPEN
;;,f_move_splash       ,0  -- M_SKETCH
;;,f_move_splash       ,0  -- M_TM05
;;,f_move_splash       ,0  -- M_NONE
]] $$
