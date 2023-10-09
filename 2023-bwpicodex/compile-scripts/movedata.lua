function init() -- entry point for this compile script
  local movestat_data = datastr_to_arr(move_stats)
  local moveid_to_stat = {}

  for stats in all(movestat_data) do
    moveid_to_stat[stats[1]] = {stats[2], stats[3]} -- stats[4], stats[5]
  end

  for i=0,251 do
    for x in all(moveid_to_stat[i]) do
      offsetpoke(x)
    end
  end

  log("Wrote Move Data")
end

-- accuracy and pp can be put together
-- there are only 12 possible different accuracies: 0 30 50 55 60 70 75 80 85 90 95 100
-- there are only 10 possible different pps: 1 5 10 15 20 25 30 33 35 40
-- there are only 27 possible different pow
-- there are only 18 possible types
-- there are only 10 pow differences: 0 1 2 3 4 5 9 10 20 50

-- taken from crystal decompiled. according to that, there are 135 different categorizable move effects...
-- some accuracies don't make sense, for moves that don't have an accuracy
-- move id        pow  move type       acc  pp  fin    decompiled effect
move_stats = [[
  M_EXPLOSION     250  T_NORMAL        100   5    0 -- EFFECT_SELFDESTRUCT
  M_SELFDESTRUCT  200  T_NORMAL        100   5    0 -- EFFECT_SELFDESTRUCT
  M_HYPERBEAM     150  T_NORMAL         90   5    0 -- EFFECT_HYPER_BEAM
  M_SKYATTACK     140  T_FLYING         90   5    0 -- EFFECT_SKY_ATTACK
  M_THUNDER       120  T_ELECTRIC       70  10   30 -- EFFECT_THUNDER
  M_SOLARBEAM     120  T_GRASS         100  10    0 -- EFFECT_SOLARBEAM
  M_MEGAKICK      120  T_NORMAL         75   5    0 -- EFFECT_NORMAL_HIT
  M_MEGAHORN      120  T_BUG            85  10    0 -- EFFECT_NORMAL_HIT
  M_HYDROPUMP     120  T_WATER          80   5    0 -- EFFECT_NORMAL_HIT
  M_FIREBLAST     120  T_FIRE           85   5   10 -- EFFECT_BURN_HIT
  M_DOUBLEEDGE    120  T_NORMAL        100  15    0 -- EFFECT_RECOIL_HIT
  M_BLIZZARD      120  T_ICE            70   5   10 -- EFFECT_FREEZE_HIT
  M_ZAPCANNON     100  T_ELECTRIC       50   5  100 -- EFFECT_PARALYZE_HIT
  M_SKULLBASH     100  T_NORMAL        100  15    0 -- EFFECT_SKULL_BASH
  M_SACREDFIRE    100  T_FIRE           95   5   50 -- EFFECT_SACRED_FIRE
  M_IRONTAIL      100  T_STEEL          75  15   30 -- EFFECT_DEFENSE_DOWN_HIT
  M_EGGBOMB       100  T_NORMAL         75  10    0 -- EFFECT_NORMAL_HIT
  M_EARTHQUAKE    100  T_GROUND        100  10    0 -- EFFECT_EARTHQUAKE
  M_DYNAMICPUNCH  100  T_FIGHTING       50   5  100 -- EFFECT_CONFUSE_HIT
  M_DREAMEATER    100  T_PSYCHIC       100  15    0 -- EFFECT_DREAM_EATER
  M_CROSSCHOP     100  T_FIGHTING       80   5    0 -- EFFECT_NORMAL_HIT
  M_AEROBLAST     100  T_FLYING         95   5    0 -- EFFECT_NORMAL_HIT
  M_THUNDERBOLT    95  T_ELECTRIC      100  15   10 -- EFFECT_PARALYZE_HIT
  M_SURF           95  T_WATER         100  15    0 -- EFFECT_NORMAL_HIT
  M_ICEBEAM        95  T_ICE           100  10   10 -- EFFECT_FREEZE_HIT
  M_FLAMETHROWER   95  T_FIRE          100  15   10 -- EFFECT_BURN_HIT
  M_THRASH         90  T_NORMAL        100  20    0 -- EFFECT_RAMPAGE
  M_TAKEDOWN       90  T_NORMAL         85  20    0 -- EFFECT_RECOIL_HIT
  M_SLUDGEBOMB     90  T_POISON        100  10   30 -- EFFECT_POISON_HIT
  M_PSYCHIC        90  T_PSYCHIC       100  10   10 -- EFFECT_SP_DEF_DOWN_HIT
  M_OUTRAGE        90  T_DRAGON        100  15    0 -- EFFECT_RAMPAGE
  M_CRABHAMMER     90  T_WATER          85  10    0 -- EFFECT_NORMAL_HIT
  M_HIJUMPKICK     85  T_FIGHTING       90  20    0 -- EFFECT_JUMP_KICK
  M_BODYSLAM       85  T_NORMAL        100  15   30 -- EFFECT_PARALYZE_HIT
  M_WATERFALL      80  T_WATER         100  15    0 -- EFFECT_NORMAL_HIT
  M_TRIATTACK      80  T_NORMAL        100  10   20 -- EFFECT_TRI_ATTACK
  M_SUBMISSION     80  T_FIGHTING       80  25    0 -- EFFECT_RECOIL_HIT
  M_STRENGTH       80  T_NORMAL        100  15    0 -- EFFECT_NORMAL_HIT
  M_SLAM           80  T_NORMAL         75  20    0 -- EFFECT_NORMAL_HIT
  M_SHADOWBALL     80  T_GHOST         100  15   20 -- EFFECT_SP_DEF_DOWN_HIT
  M_RAZORWIND      80  T_NORMAL         75  10    0 -- EFFECT_RAZOR_WIND
  M_MEGAPUNCH      80  T_NORMAL         85  20    0 -- EFFECT_NORMAL_HIT
  M_HYPERFANG      80  T_NORMAL         90  15   10 -- EFFECT_FLINCH_HIT
  M_FUTURESIGHT    80  T_PSYCHIC        90  15    0 -- EFFECT_FUTURE_SIGHT
  M_EXTREMESPEED   80  T_NORMAL        100   5    0 -- EFFECT_PRIORITY_HIT
  M_DRILLPECK      80  T_FLYING        100  20    0 -- EFFECT_NORMAL_HIT
  M_CRUNCH         80  T_DARK          100  15   20 -- EFFECT_SP_DEF_DOWN_HIT
  M_THUNDERPUNCH   75  T_ELECTRIC      100  15   10 -- EFFECT_PARALYZE_HIT
  M_ROCKSLIDE      75  T_ROCK           90  10   30 -- EFFECT_FLINCH_HIT
  M_ICEPUNCH       75  T_ICE           100  15   10 -- EFFECT_FREEZE_HIT
  M_FIREPUNCH      75  T_FIRE          100  15   10 -- EFFECT_BURN_HIT
  M_VITALTHROW     70  T_FIGHTING      100  10    0 -- EFFECT_ALWAYS_HIT
  M_STEELWING      70  T_STEEL          90  25   10 -- EFFECT_DEFENSE_UP_HIT
  M_SLASH          70  T_NORMAL        100  20    0 -- EFFECT_NORMAL_HIT
  M_PETALDANCE     70  T_GRASS         100  20    0 -- EFFECT_RAMPAGE
  M_JUMPKICK       70  T_FIGHTING       95  25    0 -- EFFECT_JUMP_KICK
  M_HEADBUTT       70  T_NORMAL        100  15   30 -- EFFECT_FLINCH_HIT
  M_FLY            70  T_FLYING         95  15    0 -- EFFECT_FLY
  M_DIZZYPUNCH     70  T_NORMAL        100  10   20 -- EFFECT_CONFUSE_HIT
  M_STOMP          65  T_NORMAL        100  20   30 -- EFFECT_STOMP
  M_SPARK          65  T_ELECTRIC      100  20   30 -- EFFECT_PARALYZE_HIT
  M_SLUDGE         65  T_POISON        100  20   30 -- EFFECT_POISON_HIT
  M_PSYBEAM        65  T_PSYCHIC       100  20   10 -- EFFECT_CONFUSE_HIT
  M_OCTAZOOKA      65  T_WATER          85  10   50 -- EFFECT_ACCURACY_DOWN_HIT
  M_HORNATTACK     65  T_NORMAL        100  25    0 -- EFFECT_NORMAL_HIT
  M_BUBBLEBEAM     65  T_WATER         100  20   10 -- EFFECT_SPEED_DOWN_HIT
  M_BONECLUB       65  T_GROUND         85  20   10 -- EFFECT_FLINCH_HIT
  M_AURORABEAM     65  T_ICE           100  20   10 -- EFFECT_ATTACK_DOWN_HIT
  M_WINGATTACK     60  T_FLYING        100  35    0 -- EFFECT_NORMAL_HIT
  M_SWIFT          60  T_NORMAL        100  20    0 -- EFFECT_ALWAYS_HIT
  M_ROLLINGKICK    60  T_FIGHTING       85  15   30 -- EFFECT_FLINCH_HIT
  M_GIGADRAIN      60  T_GRASS         100   5    0 -- EFFECT_LEECH_HIT
  M_FLAMEWHEEL     60  T_FIRE          100  25   10 -- EFFECT_FLAME_WHEEL
  M_FAINTATTACK    60  T_DARK          100  20    0 -- EFFECT_ALWAYS_HIT
  M_DRAGONBREATH   60  T_DRAGON        100  20   30 -- EFFECT_PARALYZE_HIT
  M_DIG            60  T_GROUND        100  10    0 -- EFFECT_FLY
  M_BITE           60  T_DARK          100  25   30 -- EFFECT_FLINCH_HIT
  M_ANCIENTPOWER   60  T_ROCK          100   5   10 -- EFFECT_ALL_UP_HIT
  M_VICEGRIP       55  T_NORMAL        100  30    0 -- EFFECT_NORMAL_HIT
  M_RAZORLEAF      55  T_GRASS          95  25    0 -- EFFECT_NORMAL_HIT
  M_ICYWIND        55  T_ICE            95  15  100 -- EFFECT_SPEED_DOWN_HIT
  M_STRUGGLE       50  T_NORMAL        100   1    0 -- EFFECT_RECOIL_HIT
  M_ROCKTHROW      50  T_ROCK           90  15    0 -- EFFECT_NORMAL_HIT
  M_METALCLAW      50  T_STEEL          95  35   10 -- EFFECT_ATTACK_UP_HIT
  M_LOWKICK        50  T_FIGHTING       90  20   30 -- EFFECT_FLINCH_HIT
  M_KARATECHOP     50  T_FIGHTING      100  25    0 -- EFFECT_NORMAL_HIT
  M_CUT            50  T_NORMAL         95  30    0 -- EFFECT_NORMAL_HIT
  M_CONFUSION      50  T_PSYCHIC       100  25   10 -- EFFECT_CONFUSE_HIT
  M_BONEMERANG     50  T_GROUND         90  10    0 -- EFFECT_DOUBLE_HIT
  M_WATERGUN       40  T_WATER         100  25    0 -- EFFECT_NORMAL_HIT
  M_TWISTER        40  T_DRAGON        100  20   20 -- EFFECT_TWISTER
  M_THUNDERSHOCK   40  T_ELECTRIC      100  30   10 -- EFFECT_PARALYZE_HIT
  M_THIEF          40  T_DARK          100  10  100 -- EFFECT_THIEF
  M_SNORE          40  T_NORMAL        100  15   30 -- EFFECT_SNORE
  M_SCRATCH        40  T_NORMAL        100  35    0 -- EFFECT_NORMAL_HIT
  M_QUICKATTACK    40  T_NORMAL        100  30    0 -- EFFECT_PRIORITY_HIT
  M_PURSUIT        40  T_DARK          100  20    0 -- EFFECT_PURSUIT
  M_POWDERSNOW     40  T_ICE           100  25   10 -- EFFECT_FREEZE_HIT
  M_POUND          40  T_NORMAL        100  35    0 -- EFFECT_NORMAL_HIT
  M_PAYDAY         40  T_NORMAL        100  20    0 -- EFFECT_PAY_DAY
  M_MEGADRAIN      40  T_GRASS         100  10    0 -- EFFECT_LEECH_HIT
  M_MACHPUNCH      40  T_FIGHTING      100  30    0 -- EFFECT_PRIORITY_HIT
  M_GUST           40  T_FLYING        100  35    0 -- EFFECT_GUST
  M_FALSESWIPE     40  T_NORMAL        100  40    0 -- EFFECT_FALSE_SWIPE
  M_EMBER          40  T_FIRE          100  25   10 -- EFFECT_BURN_HIT
  M_DRAGONRAGE     40  T_DRAGON        100  10    0 -- EFFECT_STATIC_DAMAGE
  M_ACID           40  T_POISON        100  30   10 -- EFFECT_DEFENSE_DOWN_HIT
  M_VINEWHIP       35  T_GRASS         100  10    0 -- EFFECT_NORMAL_HIT
  M_TACKLE         35  T_NORMAL         95  35    0 -- EFFECT_NORMAL_HIT
  M_PECK           35  T_FLYING        100  35    0 -- EFFECT_NORMAL_HIT
  M_CLAMP          35  T_WATER          75  10    0 -- EFFECT_TRAP_TARGET
  M_ROLLOUT        30  T_ROCK           90  20    0 -- EFFECT_ROLLOUT
  M_DOUBLEKICK     30  T_FIGHTING      100  30    0 -- EFFECT_DOUBLE_HIT
  M_TWINEEDLE      25  T_BUG           100  20   20 -- EFFECT_POISON_MULTI_HIT
  M_BONERUSH       25  T_GROUND         80  10    0 -- EFFECT_MULTI_HIT
  M_SPIKECANNON    20  T_NORMAL        100  15    0 -- EFFECT_MULTI_HIT
  M_SONICBOOM      20  T_NORMAL         90  20    0 -- EFFECT_STATIC_DAMAGE
  M_SMOG           20  T_POISON         70  20   40 -- EFFECT_POISON_HIT
  M_ROCKSMASH      20  T_FIGHTING      100  15   50 -- EFFECT_DEFENSE_DOWN_HIT
  M_RAPIDSPIN      20  T_NORMAL        100  40    0 -- EFFECT_RAPID_SPIN
  M_RAGE           20  T_NORMAL        100  20    0 -- EFFECT_RAGE
  M_MUDSLAP        20  T_GROUND        100  10  100 -- EFFECT_ACCURACY_DOWN_HIT
  M_LICK           20  T_GHOST         100  30   30 -- EFFECT_PARALYZE_HIT
  M_LEECHLIFE      20  T_BUG           100  15    0 -- EFFECT_LEECH_HIT
  M_BUBBLE         20  T_WATER         100  30   10 -- EFFECT_SPEED_DOWN_HIT
  M_ABSORB         20  T_GRASS         100  20    0 -- EFFECT_LEECH_HIT
  M_FURYSWIPES     18  T_NORMAL         80  15    0 -- EFFECT_MULTI_HIT
  M_COMETPUNCH     18  T_NORMAL         85  15    0 -- EFFECT_MULTI_HIT
  M_WRAP           15  T_NORMAL         85  20    0 -- EFFECT_TRAP_TARGET
  M_WHIRLPOOL      15  T_WATER          70  15    0 -- EFFECT_TRAP_TARGET
  M_POISONSTING    15  T_POISON        100  35   30 -- EFFECT_POISON_HIT
  M_FURYATTACK     15  T_NORMAL         85  20    0 -- EFFECT_MULTI_HIT
  M_FIRESPIN       15  T_FIRE           70  15    0 -- EFFECT_TRAP_TARGET
  M_DOUBLESLAP     15  T_NORMAL         85  10    0 -- EFFECT_MULTI_HIT
  M_BIND           15  T_NORMAL         75  20    0 -- EFFECT_TRAP_TARGET
  M_BARRAGE        15  T_NORMAL         85  20    0 -- EFFECT_MULTI_HIT
  M_PINMISSILE     14  T_BUG            85  20    0 -- EFFECT_MULTI_HIT
  M_TRIPLEKICK     10  T_FIGHTING       90  10    0 -- EFFECT_TRIPLE_KICK
  M_FURYCUTTER     10  T_BUG            95  20    0 -- EFFECT_FURY_CUTTER
  M_CONSTRICT      10  T_NORMAL        100  35   10 -- EFFECT_SPEED_DOWN_HIT
  M_BEATUP         10  T_DARK          100  10    0 -- EFFECT_BEAT_UP

  -- damage, but it depends how much
  M_SUPERFANG       1  T_NORMAL         90  10    0 -- EFFECT_SUPER_FANG
  M_SEISMICTOSS     1  T_FIGHTING      100  20    0 -- EFFECT_LEVEL_DAMAGE
  M_REVERSAL        1  T_FIGHTING      100  15    0 -- EFFECT_REVERSAL
  M_RETURN          1  T_NORMAL        100  20    0 -- EFFECT_RETURN
  M_PSYWAVE         1  T_PSYCHIC        80  15    0 -- EFFECT_PSYWAVE
  M_PRESENT         1  T_NORMAL         90  15    0 -- EFFECT_PRESENT
  M_NIGHTSHADE      1  T_GHOST         100  15    0 -- EFFECT_LEVEL_DAMAGE
  M_MIRRORCOAT      1  T_PSYCHIC       100  20    0 -- EFFECT_MIRROR_COAT
  M_MAGNITUDE       1  T_GROUND        100  30    0 -- EFFECT_MAGNITUDE
  M_HORNDRILL       1  T_NORMAL         30   5    0 -- EFFECT_OHKO
  M_HIDDENPOWER     1  T_NORMAL        100  15    0 -- EFFECT_HIDDEN_POWER
  M_FRUSTRATION     1  T_NORMAL        100  20    0 -- EFFECT_FRUSTRATION
  M_FLAIL           1  T_NORMAL        100  15    0 -- EFFECT_REVERSAL
  M_FISSURE         1  T_GROUND         30   5    0 -- EFFECT_OHKO
  M_COUNTER         1  T_FIGHTING      100  20    0 -- EFFECT_COUNTER

  -- no power no accuracy
  M_TM05            0  T_QUESTION        0  33    0 -- EFFECT_EVASION_UP (up by 2)
  M_GUILLOTINE      0  T_NORMAL         30   5    0 -- EFFECT_OHKO
  M_WHIRLWIND       0  T_NORMAL        100  20    0 -- EFFECT_FORCE_SWITCH
  M_SANDATTACK      0  T_GROUND        100  15    0 -- EFFECT_ACCURACY_DOWN
  M_TAILWHIP        0  T_NORMAL        100  30    0 -- EFFECT_DEFENSE_DOWN
  M_LEER            0  T_NORMAL        100  30    0 -- EFFECT_DEFENSE_DOWN
  M_GROWL           0  T_NORMAL        100  40    0 -- EFFECT_ATTACK_DOWN
  M_ROAR            0  T_NORMAL        100  20    0 -- EFFECT_FORCE_SWITCH
  M_SING            0  T_NORMAL         55  15    0 -- EFFECT_SLEEP
  M_SUPERSONIC      0  T_NORMAL         55  20    0 -- EFFECT_CONFUSE
  M_DISABLE         0  T_NORMAL         55  20    0 -- EFFECT_DISABLE
  M_LEECHSEED       0  T_GRASS          90  10    0 -- EFFECT_LEECH_SEED
  M_POISONPOWDER    0  T_POISON         75  35    0 -- EFFECT_POISON
  M_STUNSPORE       0  T_GRASS          75  30    0 -- EFFECT_PARALYZE
  M_SLEEPPOWDER     0  T_GRASS          75  15    0 -- EFFECT_SLEEP
  M_STRINGSHOT      0  T_BUG            95  40    0 -- EFFECT_SPEED_DOWN
  M_THUNDERWAVE     0  T_ELECTRIC      100  20    0 -- EFFECT_PARALYZE
  M_TOXIC           0  T_POISON         85  10    0 -- EFFECT_TOXIC
  M_HYPNOSIS        0  T_PSYCHIC        60  20    0 -- EFFECT_SLEEP
  M_MIMIC           0  T_NORMAL        100  10    0 -- EFFECT_MIMIC
  M_SCREECH         0  T_NORMAL         85  40    0 -- EFFECT_DEFENSE_DOWN_2
  M_SMOKESCREEN     0  T_NORMAL        100  20    0 -- EFFECT_ACCURACY_DOWN
  M_CONFUSERAY      0  T_GHOST         100  10    0 -- EFFECT_CONFUSE
  M_BIDE            0  T_NORMAL        100  10    0 -- EFFECT_BIDE
  M_KINESIS         0  T_PSYCHIC        80  15    0 -- EFFECT_ACCURACY_DOWN
  M_GLARE           0  T_NORMAL         75  30    0 -- EFFECT_PARALYZE
  M_POISONGAS       0  T_POISON         55  40    0 -- EFFECT_POISON
  M_LOVELYKISS      0  T_NORMAL         75  10    0 -- EFFECT_SLEEP
  M_SPORE           0  T_GRASS         100  15    0 -- EFFECT_SLEEP
  M_FLASH           0  T_NORMAL         70  20    0 -- EFFECT_ACCURACY_DOWN
  M_SKETCH          0  T_NORMAL        100   1    0 -- EFFECT_SKETCH
  M_MINDREADER      0  T_NORMAL        100   5    0 -- EFFECT_LOCK_ON
  M_NIGHTMARE       0  T_GHOST         100  15    0 -- EFFECT_NIGHTMARE
  M_CONVERSION2     0  T_NORMAL        100  30    0 -- EFFECT_CONVERSION2
  M_COTTONSPORE     0  T_GRASS          85  40    0 -- EFFECT_SPEED_DOWN_2
  M_SPITE           0  T_GHOST         100  10    0 -- EFFECT_SPITE
  M_SCARYFACE       0  T_NORMAL         90  10    0 -- EFFECT_SPEED_DOWN_2
  M_SWEETKISS       0  T_NORMAL         75  10    0 -- EFFECT_CONFUSE
  M_SPIKES          0  T_GROUND        100  20    0 -- EFFECT_SPIKES
  M_FORESIGHT       0  T_NORMAL        100  40    0 -- EFFECT_FORESIGHT
  M_LOCKON          0  T_NORMAL        100   5    0 -- EFFECT_LOCK_ON
  M_CHARM           0  T_NORMAL        100  20    0 -- EFFECT_ATTACK_DOWN_2
  M_SWAGGER         0  T_NORMAL         90  15  100 -- EFFECT_SWAGGER
  M_ATTRACT         0  T_NORMAL        100  15    0 -- EFFECT_ATTRACT
  M_PAINSPLIT       0  T_NORMAL        100  20    0 -- EFFECT_PAIN_SPLIT
  M_ENCORE          0  T_NORMAL        100   5    0 -- EFFECT_ENCORE
  M_SWEETSCENT      0  T_NORMAL        100  20    0 -- EFFECT_EVASION_DOWN
  M_PSYCHUP         0  T_NORMAL        100  10    0 -- EFFECT_PSYCH_UP

  -- no accuracy
  M_SWORDSDANCE     0  T_NORMAL        100  30    0 -- EFFECT_ATTACK_UP_2
  M_MIST            0  T_ICE           100  30    0 -- EFFECT_MIST
  M_GROWTH          0  T_NORMAL        100  40    0 -- EFFECT_SP_ATK_UP
  M_MEDITATE        0  T_PSYCHIC       100  40    0 -- EFFECT_ATTACK_UP
  M_AGILITY         0  T_PSYCHIC       100  30    0 -- EFFECT_SPEED_UP_2
  M_TELEPORT        0  T_PSYCHIC       100  20    0 -- EFFECT_TELEPORT
  M_DOUBLETEAM      0  T_NORMAL        100  15    0 -- EFFECT_EVASION_UP
  M_RECOVER         0  T_NORMAL        100  20    0 -- EFFECT_HEAL
  M_HARDEN          0  T_NORMAL        100  30    0 -- EFFECT_DEFENSE_UP
  M_MINIMIZE        0  T_NORMAL        100  20    0 -- EFFECT_EVASION_UP
  M_WITHDRAW        0  T_WATER         100  40    0 -- EFFECT_DEFENSE_UP
  M_DEFENSECURL     0  T_NORMAL        100  40    0 -- EFFECT_DEFENSE_CURL
  M_BARRIER         0  T_PSYCHIC       100  30    0 -- EFFECT_DEFENSE_UP_2
  M_LIGHTSCREEN     0  T_PSYCHIC       100  30    0 -- EFFECT_LIGHT_SCREEN
  M_HAZE            0  T_ICE           100  30    0 -- EFFECT_RESET_STATS
  M_REFLECT         0  T_PSYCHIC       100  20    0 -- EFFECT_REFLECT
  M_FOCUSENERGY     0  T_NORMAL        100  30    0 -- EFFECT_FOCUS_ENERGY
  M_METRONOME       0  T_NORMAL        100  10    0 -- EFFECT_METRONOME
  M_MIRRORMOVE      0  T_FLYING        100  20    0 -- EFFECT_MIRROR_MOVE
  M_AMNESIA         0  T_PSYCHIC       100  20    0 -- EFFECT_SP_DEF_UP_2
  M_SOFTBOILED      0  T_NORMAL        100  10    0 -- EFFECT_HEAL
  M_TRANSFORM       0  T_NORMAL        100  10    0 -- EFFECT_TRANSFORM
  M_SPLASH          0  T_NORMAL        100  40    0 -- EFFECT_SPLASH
  M_ACIDARMOR       0  T_POISON        100  40    0 -- EFFECT_DEFENSE_UP_2
  M_REST            0  T_PSYCHIC       100  10    0 -- EFFECT_HEAL
  M_SHARPEN         0  T_NORMAL        100  30    0 -- EFFECT_ATTACK_UP
  M_CONVERSION      0  T_NORMAL        100  30    0 -- EFFECT_CONVERSION
  M_SUBSTITUTE      0  T_NORMAL        100  10    0 -- EFFECT_SUBSTITUTE
  M_SPIDERWEB       0  T_BUG           100  10    0 -- EFFECT_MEAN_LOOK
  M_CURSE           0  T_QUESTION      100  10    0 -- EFFECT_CURSE
  M_PROTECT         0  T_NORMAL        100  10    0 -- EFFECT_PROTECT
  M_BELLYDRUM       0  T_NORMAL        100  10    0 -- EFFECT_BELLY_DRUM
  M_DESTINYBOND     0  T_GHOST         100   5    0 -- EFFECT_DESTINY_BOND
  M_PERISHSONG      0  T_NORMAL        100   5    0 -- EFFECT_PERISH_SONG
  M_DETECT          0  T_FIGHTING      100   5    0 -- EFFECT_PROTECT
  M_SANDSTORM       0  T_ROCK          100  10    0 -- EFFECT_SANDSTORM
  M_ENDURE          0  T_NORMAL        100  10    0 -- EFFECT_ENDURE
  M_MILKDRINK       0  T_NORMAL        100  10    0 -- EFFECT_HEAL
  M_MEANLOOK        0  T_NORMAL        100   5    0 -- EFFECT_MEAN_LOOK
  M_SLEEPTALK       0  T_NORMAL        100  10    0 -- EFFECT_SLEEP_TALK
  M_HEALBELL        0  T_NORMAL        100   5    0 -- EFFECT_HEAL_BELL
  M_SAFEGUARD       0  T_NORMAL        100  25    0 -- EFFECT_SAFEGUARD
  M_BATONPASS       0  T_NORMAL        100  40    0 -- EFFECT_BATON_PASS
  M_MORNINGSUN      0  T_NORMAL        100   5    0 -- EFFECT_MORNING_SUN
  M_SYNTHESIS       0  T_GRASS         100   5    0 -- EFFECT_SYNTHESIS
  M_MOONLIGHT       0  T_NORMAL        100   5    0 -- EFFECT_MOONLIGHT
  M_RAINDANCE       0  T_WATER          90   5    0 -- EFFECT_RAIN_DANCE
  M_SUNNYDAY        0  T_FIRE           90   5    0 -- EFFECT_SUNNY_DAY
]]




