c_pokemon = zobj[[
    -- missingno has 0 base defence, but this becomes 1 in a battle based on the logic in getstat.
    -- evol says how many numbers going up is the previous evolution. 0 means no previous evolution.
    -- every pokemon is either 0 or 1, except for eevee's evolved forms.
    -- evol "name"         t1          t2           hp   att  def  spd  spc  move levels
   0;, 0,   "missingno",   T_BIRD,     T_NORMAL,    33,  136, 0,   29,  6,   1,1                             -- 0
   ;;, 0,   "bulbasaur",   T_GRASS,    T_POISON,    45,  49,  49,  45,  65,  1,1,7,13,20,27,34,41,48         -- 1
   ;;, 1,   "ivysaur",     T_GRASS,    T_POISON,    60,  62,  63,  60,  80,  1,1,7,13,22,30,38,46,54         -- 2
   ;;, 1,   "venusaur",    T_GRASS,    T_POISON,    80,  82,  83,  80,  100, 1,1,7,13,22,30,43,55,65         -- 3
   ;;, 0,   "charmander",  T_FIRE,     T_NONE,      39,  52,  43,  65,  50,  1,1,9,15,22,30,38,46            -- 4
   ;;, 1,   "charmeleon",  T_FIRE,     T_NONE,      58,  64,  58,  80,  65,  1,1,9,15,24,33,42,56            -- 5
   ;;, 1,   "charizard",   T_FIRE,     T_FLYING,    78,  84,  78,  100, 85,  1,1,9,15,24,36,46,55            -- 6
   ;;, 0,   "squirtle",    T_WATER,    T_NONE,      44,  48,  65,  43,  50,  1,1,8,15,22,28,35,42            -- 7
   ;;, 1,   "wartortle",   T_WATER,    T_NONE,      59,  63,  80,  58,  65,  1,1,8,15,24,31,39,47            -- 8
   ;;, 1,   "blastoise",   T_WATER,    T_NONE,      79,  83,  100, 78,  85,  1,1,8,15,24,31,42,52            -- 9
   ;;, 0,   "caterpie",    T_BUG,      T_NONE,      45,  30,  35,  45,  20,  1,1                             -- 10
   ;;, 1,   "metapod",     T_BUG,      T_NONE,      50,  20,  55,  30,  25,  1                               -- 11
   ;;, 1,   "butterfree",  T_BUG,      T_FLYING,    60,  45,  50,  70,  80,  1,15,16,17,21,26,28,34          -- 12
   ;;, 0,   "weedle",      T_BUG,      T_POISON,    40,  35,  30,  50,  20,  1,1                             -- 13
   ;;, 1,   "kakuna",      T_BUG,      T_POISON,    45,  25,  50,  35,  25,  1                               -- 14
   ;;, 1,   "beedrill",    T_BUG,      T_POISON,    65,  80,  40,  75,  45,  1,16,20,25,30,35                -- 15
   ;;, 0,   "pidgey",      T_NORMAL,   T_FLYING,    40,  45,  40,  56,  35,  1,5,12,19,28,36,44              -- 16
   ;;, 1,   "pidgeotto",   T_NORMAL,   T_FLYING,    63,  60,  55,  71,  50,  1,5,12,21,31,40,49              -- 17
   ;;, 1,   "pidgeot",     T_NORMAL,   T_FLYING,    83,  80,  75,  91,  70,  1,5,12,21,31,44,54              -- 18
   ;;, 0,   "rattata",     T_NORMAL,   T_NONE,      30,  56,  35,  72,  25,  1,1,7,14,23,34                  -- 19
   ;;, 1,   "raticate",    T_NORMAL,   T_NONE,      55,  81,  60,  97,  50,  1,1,7,14,27,41                  -- 20
   ;;, 0,   "spearow",     T_NORMAL,   T_FLYING,    40,  60,  30,  70,  31,  1,1,9,15,22,29,36               -- 21
   ;;, 1,   "fearow",      T_NORMAL,   T_FLYING,    65,  90,  65,  100, 61,  1,1,9,15,25,34,43               -- 22
   ;;, 0,   "ekans",       T_POISON,   T_NONE,      35,  60,  44,  55,  40,  1,1,10,17,24,31,38              -- 23
   ;;, 1,   "arbok",       T_POISON,   T_NONE,      60,  85,  69,  80,  65,  1,1,10,17,27,36,47              -- 24
   ;;, 0,   "pikachu",     T_ELECTRIC, T_NONE,      35,  55,  30,  90,  50,  1,1,6,9,15,16,20,26,26,33,43,50 -- 25
   ;;, 1,   "raichu",      T_ELECTRIC, T_NONE,      60,  90,  55,  100, 90,  1,1,1                           -- 26
   ;;, 0,   "sandshrew",   T_GROUND,   T_NONE,      50,  75,  85,  40,  30,  1,10,17,24,31,38                -- 27
   ;;, 1,   "sandslash",   T_GROUND,   T_NONE,      75,  100, 110, 65,  55,  1,10,17,27,36,47                -- 28
   ;;, 0,   "nidoran?",    T_POISON,   T_NONE,      55,  47,  52,  41,  40,  1,1,8,17,23,30,38,43            -- 29
   ;;, 1,   "nidorina",    T_POISON,   T_NONE,      70,  62,  67,  56,  55,  1,1,8,19,27,36,46,50            -- 30
   ;;, 1,   "nidoqueen",   T_POISON,   T_GROUND,    90,  82,  87,  76,  75,  1,1,8,12,14,23                  -- 31
   ;;, 0,   "nidoran!",    T_POISON,   T_NONE,      46,  57,  40,  50,  40,  1,1,8,17,23,30,38,43            -- 32
   ;;, 1,   "nidorino",    T_POISON,   T_NONE,      61,  72,  57,  65,  55,  1,1,8,19,27,36,46,50            -- 33
   ;;, 1,   "nidoking",    T_POISON,   T_GROUND,    81,  92,  77,  85,  75,  1,8,12,14,23                    -- 34
   ;;, 0,   "clefairy",    T_NORMAL,   T_NONE,      70,  45,  48,  35,  60,  1,1,13,18,24,31,39,48           -- 35
   ;;, 1,   "clefable",    T_NORMAL,   T_NONE,      95,  70,  73,  60,  85,  1,1,1,1                         -- 36
   ;;, 0,   "vulpix",      T_FIRE,     T_NONE,      38,  41,  40,  65,  65,  1,1,16,21,28,35,42              -- 37
   ;;, 1,   "ninetales",   T_FIRE,     T_NONE,      73,  76,  75,  100, 100, 1,1,1,1                         -- 38
   ;;, 0,   "jigglypuff",  T_NORMAL,   T_NONE,      115, 45,  20,  20,  25,  1,9,14,19,24,29,34,39           -- 39
   ;;, 1,   "wigglytuff",  T_NORMAL,   T_NONE,      140, 70,  45,  45,  50,  1,1,1,1                         -- 40
   ;;, 0,   "zubat",       T_POISON,   T_FLYING,    40,  45,  35,  55,  40,  1,10,15,21,28,36                -- 41
   ;;, 1,   "golbat",      T_POISON,   T_FLYING,    75,  80,  70,  90,  75,  1,1,10,15,21,32,43              -- 42
   ;;, 0,   "oddish",      T_GRASS,    T_POISON,    45,  50,  55,  30,  75,  1,15,17,19,24,33,46             -- 43
   ;;, 1,   "gloom",       T_GRASS,    T_POISON,    60,  65,  70,  40,  85,  1,15,17,19,28,38,52             -- 44
   ;;, 1,   "vileplume",   T_GRASS,    T_POISON,    75,  80,  85,  50,  100, 1,1,15,17,19                    -- 45
   ;;, 0,   "paras",       T_BUG,      T_GRASS,     35,  70,  55,  25,  55,  1,13,20,27,34,41                -- 46
   ;;, 1,   "parasect",    T_BUG,      T_GRASS,     60,  95,  80,  30,  80,  1,13,20,30,39,48                -- 47
   ;;, 0,   "venonat",     T_BUG,      T_POISON,    60,  55,  50,  45,  40,  1,1,11,19,24,27,30,35,38,43     -- 48
   ;;, 1,   "venomoth",    T_BUG,      T_POISON,    70,  65,  60,  90,  90,  1,1,1,1,24,27,30,38,43,50       -- 49
   ;;, 0,   "diglett",     T_GROUND,   T_NONE,      10,  55,  25,  95,  45,  1,15,19,24,31,40                -- 50
   ;;, 1,   "dugtrio",     T_GROUND,   T_NONE,      35,  80,  50,  120, 70,  1,15,19,24,35,47                -- 51
   ;;, 0,   "meowth",      T_NORMAL,   T_NONE,      40,  45,  35,  90,  40,  1,1,12,17,24,33,44              -- 52
   ;;, 1,   "persian",     T_NORMAL,   T_NONE,      65,  70,  60,  115, 65,  1,1,12,17,24,37,51              -- 53
   ;;, 0,   "psyduck",     T_WATER,    T_NONE,      50,  52,  48,  55,  50,  1,28,31,36,43,52                -- 54
   ;;, 1,   "golduck",     T_WATER,    T_NONE,      80,  82,  78,  85,  80,  1,28,31,39,48,59                -- 55
   ;;, 0,   "mankey",      T_FIGHTING, T_NONE,      40,  80,  35,  70,  35,  1,1,9,15,21,27,33,39,45         -- 56
   ;;, 1,   "primeape",    T_FIGHTING, T_NONE,      65,  105, 60,  95,  60,  1,1,9,15,21,27,28,37,45,46      -- 57
   ;;, 0,   "growlithe",   T_FIRE,     T_NONE,      55,  70,  45,  60,  50,  1,1,18,23,30,39,50              -- 58
   ;;, 1,   "arcanine",    T_FIRE,     T_NONE,      90,  110, 80,  95,  80,  1,1,1,1                         -- 59
   ;;, 0,   "poliwag",     T_WATER,    T_NONE,      40,  50,  40,  90,  40,  1,16,19,25,31,38,45             -- 60
   ;;, 1,   "poliwhirl",   T_WATER,    T_NONE,      65,  65,  65,  90,  50,  1,16,19,26,33,41,49             -- 61
   ;;, 1,   "poliwrath",   T_WATER,    T_FIGHTING,  90,  85,  95,  70,  70,  1,1,16,19                       -- 62
   ;;, 0,   "abra",        T_PSYCHIC,  T_NONE,      25,  20,  15,  90,  105, 1                               -- 63
   ;;, 1,   "kadabra",     T_PSYCHIC,  T_NONE,      40,  35,  30,  105, 120, 1,1,16,20,27,31,38,42           -- 64
   ;;, 1,   "alakazam",    T_PSYCHIC,  T_NONE,      55,  50,  45,  120, 135, 1,1,16,20,27,31,38,42           -- 65
   ;;, 0,   "machop",      T_FIGHTING, T_NONE,      70,  80,  50,  35,  35,  1,20,25,32,39,46                -- 66
   ;;, 1,   "machoke",     T_FIGHTING, T_NONE,      80,  100, 70,  45,  50,  1,20,25,36,44,52                -- 67
   ;;, 1,   "machamp",     T_FIGHTING, T_NONE,      90,  130, 80,  55,  65,  1,20,25,36,44,52                -- 68
   ;;, 0,   "bellsprout",  T_GRASS,    T_POISON,    50,  75,  35,  40,  70,  1,1,13,15,18,21,26,33,42        -- 69
   ;;, 1,   "weepinbell",  T_GRASS,    T_POISON,    65,  90,  50,  55,  85,  1,1,13,15,18,23,29,38,49        -- 70
   ;;, 1,   "victreebel",  T_GRASS,    T_POISON,    80,  105, 65,  70,  100, 1,1,1,13,15,18                  -- 71
   ;;, 0,   "tentacool",   T_WATER,    T_POISON,    40,  40,  35,  70,  100, 1,7,13,18,22,27,33,40,48        -- 72
   ;;, 1,   "tentacruel",  T_WATER,    T_POISON,    80,  70,  65,  100, 120, 1,7,13,18,22,27,35,43,50        -- 73
   ;;, 0,   "geodude",     T_ROCK,     T_GROUND,    40,  80,  100, 20,  30,  1,11,16,21,26,31,36             -- 74
   ;;, 1,   "graveler",    T_ROCK,     T_GROUND,    55,  95,  115, 35,  45,  1,11,16,21,29,36,43             -- 75
   ;;, 1,   "golem",       T_ROCK,     T_GROUND,    80,  110, 130, 45,  55,  1,11,16,21,29,36,43             -- 76
   ;;, 0,   "ponyta",      T_FIRE,     T_NONE,      50,  85,  55,  90,  65,  1,30,32,35,39,43,48             -- 77
   ;;, 1,   "rapidash",    T_FIRE,     T_NONE,      65,  100, 70,  105, 80,  1,30,32,35,39,47,55             -- 78
   ;;, 0,   "slowpoke",    T_WATER,    T_PSYCHIC,   90,  65,  65,  15,  40,  1,18,22,27,33,40,48             -- 79
   ;;, 1,   "slowbro",     T_WATER,    T_PSYCHIC,   95,  75,  110, 30,  80,  1,18,22,27,33,37,44,55          -- 80
   ;;, 0,   "magnemite",   T_ELECTRIC, T_NONE,      25,  35,  70,  45,  95,  1,21,25,29,35,41,47             -- 81
   ;;, 1,   "magneton",    T_ELECTRIC, T_NONE,      50,  60,  95,  70,  120, 1,21,25,29,38,46,54             -- 82
   ;;, 0,   "farfetch'd",  T_NORMAL,   T_FLYING,    52,  65,  55,  60,  58,  1,1,7,15,23,31,39               -- 83
   ;;, 0,   "doduo",       T_NORMAL,   T_FLYING,    35,  85,  45,  75,  35,  1,20,24,30,36,40,44             -- 84
   ;;, 1,   "dodrio",      T_NORMAL,   T_FLYING,    60,  110, 70,  100, 60,  1,20,24,30,39,45,51             -- 85
   ;;, 0,   "seel",        T_WATER,    T_NONE,      65,  45,  55,  45,  70,  1,30,35,40,45,50                -- 86
   ;;, 1,   "dewgong",     T_WATER,    T_ICE,       90,  70,  80,  70,  95,  1,30,35,44,50,56                -- 87
   ;;, 0,   "grimer",      T_POISON,   T_NONE,      80,  80,  50,  25,  40,  1,1,30,33,37,42,48,55           -- 88
   ;;, 1,   "muk",         T_POISON,   T_NONE,      105, 105, 75,  50,  65,  1,1,30,33,37,45,53,60           -- 89
   ;;, 0,   "shellder",    T_WATER,    T_NONE,      30,  65,  100, 40,  45,  1,1,18,23,30,39,50              -- 90
   ;;, 1,   "cloyster",    T_WATER,    T_ICE,       50,  95,  180, 70,  85,  1,1,1,1,50                      -- 91
   ;;, 0,   "gastly",      T_GHOST,    T_POISON,    30,  35,  30,  80,  100, 1,1,1,27,35                     -- 92
   ;;, 1,   "haunter",     T_GHOST,    T_POISON,    45,  50,  45,  95,  115, 1,1,1,29,38                     -- 93
   ;;, 1,   "gengar",      T_GHOST,    T_POISON,    60,  65,  60,  110, 130, 1,1,1,29,38                     -- 94
   ;;, 0,   "onix",        T_ROCK,     T_GROUND,    35,  45,  160, 70,  30,  1,1,15,19,25,33,43              -- 95
   ;;, 0,   "drowzee",     T_PSYCHIC,  T_NONE,      60,  48,  45,  42,  90,  1,1,12,17,24,29,32,37           -- 96
   ;;, 1,   "hypno",       T_PSYCHIC,  T_NONE,      85,  73,  70,  67,  115, 1,1,12,17,24,33,37,43           -- 97
   ;;, 0,   "krabby",      T_WATER,    T_NONE,      30,  105, 90,  50,  25,  1,1,20,25,30,35,40              -- 98
   ;;, 1,   "kingler",     T_WATER,    T_NONE,      55,  130, 115, 75,  50,  1,1,20,25,34,42,49              -- 99
   ;;, 0,   "voltorb",     T_ELECTRIC, T_NONE,      40,  30,  50,  100, 55,  1,1,17,22,29,36,43              -- 100
   ;;, 1,   "electrode",   T_ELECTRIC, T_NONE,      60,  50,  70,  140, 80,  1,1,17,22,29,40,50              -- 101
   ;;, 0,   "exeggcute",   T_GRASS,    T_PSYCHIC,   60,  40,  80,  40,  60,  1,1,25,28,32,37,42,48           -- 102
   ;;, 1,   "exeggutor",   T_GRASS,    T_PSYCHIC,   95,  95,  85,  55,  125, 1,1,28                          -- 103
   ;;, 0,   "cubone",      T_GROUND,   T_NONE,      50,  50,  95,  35,  40,  1,10,13,18,25,31,38,43,46       -- 104
   ;;, 1,   "marowak",     T_GROUND,   T_NONE,      60,  80,  110, 45,  50,  1,10,13,18,25,33,41,48,55       -- 105
   ;;, 0,   "hitmonlee",   T_FIGHTING, T_NONE,      50,  120, 53,  87,  35,  1,1,33,38,43,48,53              -- 106
   ;;, 0,   "hitmonchan",  T_FIGHTING, T_NONE,      50,  105, 79,  76,  35,  1,1,33,38,43,48,53              -- 107
   ;;, 0,   "lickitung",   T_NORMAL,   T_NONE,      90,  55,  75,  30,  60,  1,1,7,15,23,31,39               -- 108
   ;;, 0,   "koffing",     T_POISON,   T_NONE,      40,  65,  95,  35,  60,  1,1,32,37,40,45,48              -- 109
   ;;, 1,   "weezing",     T_POISON,   T_NONE,      65,  90,  120, 60,  85,  1,1,32,39,43,49,53              -- 110
   ;;, 0,   "rhyhorn",     T_GROUND,   T_ROCK,      80,  85,  95,  25,  30,  1,30,35,40,45,50,55             -- 111
   ;;, 1,   "rhydon",      T_GROUND,   T_ROCK,      105, 130, 120, 40,  45,  1,30,35,40,48,55,64             -- 112
   ;;, 0,   "chansey",     T_NORMAL,   T_NONE,      250, 5,   5,   50,  105, 1,1,12,24,30,38,44,48,54        -- 113
   ;;, 0,   "tangela",     T_GRASS,    T_NONE,      65,  55,  115, 60,  100, 1,24,29,29,32,36,39,45,49       -- 114
   ;;, 0,   "kangaskhan",  T_NORMAL,   T_NONE,      105, 95,  80,  90,  40,  1,1,26,31,36,41,46              -- 115
   ;;, 0,   "horsea",      T_WATER,    T_NONE,      30,  40,  70,  60,  70,  1,19,24,30,37,45                -- 116
   ;;, 1,   "seadra",      T_WATER,    T_NONE,      55,  65,  95,  85,  95,  1,19,24,30,41,52                -- 117
   ;;, 0,   "goldeen",     T_WATER,    T_NONE,      45,  67,  60,  63,  50,  1,1,19,24,30,37,45,54           -- 118
   ;;, 1,   "seaking",     T_WATER,    T_NONE,      80,  92,  65,  68,  80,  1,1,19,24,30,39,48,54           -- 119
   ;;, 0,   "staryu",      T_WATER,    T_NONE,      30,  45,  55,  85,  70,  1,17,22,27,32,37,42,47          -- 120
   ;;, 1,   "starmie",     T_WATER,    T_PSYCHIC,   60,  75,  85,  115, 100, 1,1,1                           -- 121
   ;;, 0,   "mr mime",     T_PSYCHIC,  T_NONE,      40,  45,  65,  90,  100, 1,15,23,31,39,47                -- 122
   ;;, 0,   "scyther",     T_BUG,      T_FLYING,    70,  110, 80,  105, 55,  1,17,20,24,29,35,42,50          -- 123
   ;;, 0,   "jynx",        T_ICE,      T_PSYCHIC,   65,  50,  35,  95,  95,  1,1,18,23,31,39,47,58           -- 124
   ;;, 0,   "electabuzz",  T_ELECTRIC, T_NONE,      65,  83,  57,  105, 85,  1,1,34,37,42,49,54              -- 125
   ;;, 0,   "magmar",      T_FIRE,     T_NONE,      65,  95,  57,  93,  85,  1,36,39,43,48,52,55             -- 126
   ;;, 0,   "pinsir",      T_BUG,      T_NONE,      65,  125, 100, 85,  55,  1,21,25,30,36,43,49,54          -- 127
   ;;, 0,   "tauros",      T_NORMAL,   T_NONE,      75,  100, 95,  110, 70,  1,21,28,35,44,51                -- 128
   ;;, 0,   "magikarp",    T_WATER,    T_NONE,      20,  10,  55,  80,  20,  1,15                            -- 129
   ;;, 1,   "gyarados",    T_WATER,    T_FLYING,    95,  125, 79,  81,  100, 1,20,25,32,41,52                -- 130
   ;;, 0,   "lapras",      T_WATER,    T_ICE,       130, 85,  80,  60,  95,  1,1,16,20,25,31,38,46           -- 131
   ;;, 0,   "ditto",       T_NORMAL,   T_NONE,      48,  48,  48,  48,  48,  1                               -- 132
   ;;, 0,   "eevee",       T_NORMAL,   T_NONE,      55,  55,  50,  55,  65,  1,8,16,27,31,36,37,45           -- 133
   ;;, 1,   "vaporeon",    T_WATER,    T_NONE,      130, 65,  60,  65,  110, 1,8,27,31,36,37,40,44,47,48,54  -- 134
   ;;, 2,   "jolteon",     T_ELECTRIC, T_NONE,      65,  65,  60,  130, 110, 1,8,27,31,37,42,42,47,48,54     -- 135
   ;;, 3,   "flareon",     T_FIRE,     T_NONE,      65,  130, 60,  65,  110, 1,8,27,31,37,40,42,44,47,48,54  -- 136
   ;;, 0,   "porygon",     T_NORMAL,   T_NONE,      65,  60,  70,  40,  75,  1,1,1,23,28,35,42               -- 137
   ;;, 0,   "omanyte",     T_ROCK,     T_WATER,     35,  40,  100, 35,  90,  1,1,34,39,46,53                 -- 138
   ;;, 1,   "omastar",     T_ROCK,     T_WATER,     70,  60,  125, 55,  115, 1,1,34,39,44,49                 -- 139
   ;;, 0,   "kabuto",      T_ROCK,     T_WATER,     30,  80,  90,  55,  45,  1,1,34,39,44,49                 -- 140
   ;;, 1,   "kabutops",    T_ROCK,     T_WATER,     60,  115, 105, 80,  70,  1,1,34,39,46,53                 -- 141
   ;;, 0,   "aerodactyl",  T_ROCK,     T_FLYING,    80,  105, 65,  130, 60,  1,1,33,38,45,54                 -- 142
   ;;, 0,   "snorlax",     T_NORMAL,   T_NONE,      160, 110, 65,  30,  65,  1,1,1,35,41,48,56               -- 143
   ;;, 0,   "articuno",    T_ICE,      T_FLYING,    90,  85,  100, 85,  125, 1,1,51,55,60                    -- 144
   ;;, 0,   "zapdos",      T_ELECTRIC, T_FLYING,    90,  90,  85,  100, 125, 1,1,51,55,60                    -- 145
   ;;, 0,   "moltres",     T_FIRE,     T_FLYING,    90,  100, 90,  90,  125, 1,1,51,55,60                    -- 146
   ;;, 0,   "dratini",     T_DRAGON,   T_NONE,      41,  64,  45,  50,  50,  1,1,10,20,30,40,50              -- 147
   ;;, 1,   "dragonair",   T_DRAGON,   T_NONE,      61,  84,  65,  70,  70,  1,1,10,20,35,45,55              -- 148
   ;;, 1,   "dragonite",   T_DRAGON,   T_FLYING,    91,  134, 95,  80,  100, 1,1,10,20,35,45,60              -- 149
   ;;, 0,   "mewtwo",      T_PSYCHIC,  T_NONE,      106, 110, 90,  130, 154, 1,1,1,63,66,70,75,81            -- 150
   ;;, 0,   "mew",         T_PSYCHIC,  T_NONE,      100, 100, 100, 100, 100, 1,10,20,30,40                   -- 151
]]

-- pokemon moves can be physical or special. the order here is specific. odd numbers are physical. even numbers are special.
-- includes type effectiveness chart. according to the gen 1 games, which had bugs. i'm keeping the bugs :).
c_types = zobj[[
    T_BIRD;     bg,0, name,"bird";     T_BIRD;     good;,;                                  T_BIRD;     null;,;                   T_BIRD;     weak;,;
    T_NORMAL;   bg,0, name,"normal";   T_NORMAL;   good;,;                                  T_NORMAL;   null;,T_GHOST;            T_NORMAL;   weak;,T_ROCK;
    T_FIRE;     bg,5, name,"fire";     T_FIRE;     good;,T_GRASS,T_ICE,T_BUG;               T_FIRE;     null;,;                   T_FIRE;     weak;,T_FIRE,T_WATER,T_ROCK,T_DRAGON;
    T_FIGHTING; bg,2, name,"fighting"; T_FIGHTING; good;,T_ICE,T_NORMAL,T_ROCK;             T_FIGHTING; null;,T_GHOST;            T_FIGHTING; weak;,T_BUG,T_FLYING,T_POISON,T_PSYCHIC;
    T_WATER;    bg,4, name,"water";    T_WATER;    good;,T_FIRE,T_GROUND,T_ROCK;            T_WATER;    null;,;                   T_WATER;    weak;,T_DRAGON,T_GRASS,T_WATER;
    T_POISON;   bg,1, name,"poison";   T_POISON;   good;,T_BUG,T_GRASS;                     T_POISON;   null;,;                   T_POISON;   weak;,T_GHOST,T_GROUND,T_POISON,T_ROCK;
    T_ELECTRIC; bg,6, name,"electric"; T_ELECTRIC; good;,T_FLYING,T_WATER;                  T_ELECTRIC; null;,T_GROUND;           T_ELECTRIC; weak;,T_DRAGON,T_ELECTRIC,T_GRASS;
    T_GROUND;   bg,2, name,"ground";   T_GROUND;   good;,T_ELECTRIC,T_FIRE,T_POISON,T_ROCK; T_GROUND;   null;,T_FLYING;           T_GROUND;   weak;,T_BUG,T_GRASS;
    T_GRASS;    bg,3, name,"grass";    T_GRASS;    good;,T_GROUND,T_ROCK,T_WATER;           T_GRASS;    null;,;                   T_GRASS;    weak;,T_BUG,T_DRAGON,T_FIRE,T_FLYING,T_GRASS,T_POISON;
    T_FLYING;   bg,0, name,"flying";   T_FLYING;   good;,T_BUG,T_FIGHTING,T_GRASS;          T_FLYING;   null;,;                   T_FLYING;   weak;,T_ELECTRIC,T_ROCK;
    T_ICE;      bg,4, name,"ice";      T_ICE;      good;,T_DRAGON,T_FLYING,T_GRASS;         T_ICE;      null;,;                   T_ICE;      weak;,T_FIRE,T_ICE,T_WATER;
    T_BUG;      bg,3, name,"bug";      T_BUG;      good;,T_GRASS,T_PSYCHIC;                 T_BUG;      null;,;                   T_BUG;      weak;,T_FIGHTING,T_FIRE,T_FLYING,T_GHOST,T_POISON;
    T_PSYCHIC;  bg,1, name,"psychic";  T_PSYCHIC;  good;,T_FIGHTING,T_POISON;               T_PSYCHIC;  null;,;                   T_PSYCHIC;  weak;,T_PSYCHIC;
    T_ROCK;     bg,0, name,"rock";     T_ROCK;     good;,T_BUG,T_FIRE,T_FLYING,T_ICE;       T_ROCK;     null;,;                   T_ROCK;     weak;,T_FIGHTING,T_GROUND;
    T_DRAGON;   bg,0, name,"dragon";   T_DRAGON;   good;,T_DRAGON;                          T_DRAGON;   null;,;                   T_DRAGON;   weak;,;
    T_GHOST;    bg,1, name,"ghost";    T_GHOST;    good;,T_GHOST;                           T_GHOST;    null;,T_NORMAL,T_PSYCHIC; T_GHOST;    weak;,
]]

-- 5 bg styles
c_bg_styles = zobj[[
    0;bg,6,  aa,13 -- normal
   ;; bg,13, aa,5  -- darker/psychic/poison/ghost
   ;; bg,9,  aa,4  -- electric/ground
   ;; bg,11, aa,3  -- grass
   ;; bg,12, aa,5  -- water
   ;; bg,8,  aa,2  -- fire
   ;; bg,10, aa,4  -- electric/ground
]]

c_zmovetype = zobj[[
    0;name,"status";
    ; name,"physical";
    ; name,"special";
]]

-- accuracy 2 means it can't miss.
-- accuracy 0 means it affects the user.
-- pp 0 means it is struggle
-- dmg 0 means it likely changes status or has an effect.
c_moves = zobj[[
   --  "name",     type        pp  dmg  acc
   0;, "struggle", T_NORMAL,   0,  50, 1

    -- tms
   ;;, "megapnch", T_NORMAL,   20, 80,  .85 -- 1
   ;;, "razrwind", T_NORMAL,   10, 80,  1   -- 2
   ;;, "swordanc", T_NORMAL,   20, 0,   0   -- 3
   ;;, "whrlwind", T_NORMAL,   20, 0,   0   -- 4
   ;;, "megakick", T_NORMAL,   5,  120, .75 -- 5
   ;;, "toxic",    T_POISON,   10, 0,   .9  -- 6
   ;;, "horndril", T_NORMAL,   5,  0,   .3  -- 7
   ;;, "bodyslam", T_NORMAL,   15, 85,  1   -- 8
   ;;, "takedown", T_NORMAL,   20, 90,  .85 -- 9
   ;;, "doubledg", T_NORMAL,   15, 120, 1   -- 10
   ;;, "bublbeam", T_WATER,    20, 65,  1   -- 11
   ;;, "watergun", T_WATER,    25, 40,  1   -- 12
   ;;, "icebeam",  T_ICE,      10, 90,  1   -- 13
   ;;, "blizzard", T_ICE,      5,  110, .7  -- 14
   ;;, "hyprbeam", T_NORMAL,   5,  150, .9  -- 15
   ;;, "payday",   T_NORMAL,   20, 40,  1   -- 16
   ;;, "submsion", T_FIGHTING, 20, 80,  .8  -- 17
   ;;, "counter",  T_FIGHTING, 20, 0,   1   -- 18
   ;;, "siestoss", T_FIGHTING, 20, 0,   1   -- 19
   ;;, "rage",     T_NORMAL,   20, 20,  1   -- 20
   ;;, "megdrain", T_GRASS,    15, 40,  1   -- 21
   ;;, "solrbeam", T_GRASS,    10, 120, 1   -- 22
   ;;, "drgnrage", T_DRAGON,   10, 0,   1   -- 23
   ;;, "thndrblt", T_ELECTRIC, 15, 90,  1   -- 24
   ;;, "thunder",  T_ELECTRIC, 10, 110, .7  -- 25
   ;;, "earthqke", T_GROUND,   10, 100, 1   -- 26
   ;;, "fissure",  T_GROUND,   5,  0,   .3  -- 27
   ;;, "dig",      T_GROUND,   10, 80,  1   -- 28
   ;;, "psychic",  T_PSYCHIC,  10, 90,  1   -- 29
   ;;, "teleport", T_PSYCHIC,  20, 0,   0   -- 30
   ;;, "mimic",    T_NORMAL,   10, 0,   0   -- 31
   ;;, "doubteam", T_NORMAL,   15, 0,   0   -- 32
   ;;, "reflect",  T_PSYCHIC,  20, 0,   0   -- 33
   ;;, "bide",     T_NORMAL,   10, 0,   0   -- 34
   ;;, "metronom", T_NORMAL,   10, 0,   0   -- 35
   ;;, "selfdstr", T_NORMAL,   5,  200, 1   -- 36
   ;;, "eggbomb",  T_NORMAL,   10, 100, .75 -- 37
   ;;, "fireblst", T_FIRE,     5,  110, .85 -- 38
   ;;, "swift",    T_NORMAL,   20, 60,  2   -- 39
   ;;, "skulbash", T_NORMAL,   10, 130, 1   -- 40
   ;;, "softboil", T_NORMAL,   5,  0,   0   -- 41
   ;;, "dreameat", T_PSYCHIC,  15, 100, 1   -- 42
   ;;, "skyattck", T_FLYING,   5,  140, .9  -- 43
   ;;, "rest",     T_PSYCHIC,  5,  0,   0   -- 44
   ;;, "thndrwav", T_ELECTRIC, 20, 0,   .9  -- 45
   ;;, "psywave",  T_PSYCHIC,  15, 0,   1   -- 46
   ;;, "explsion", T_NORMAL,   5,  250, 1   -- 47
   ;;, "rockslid", T_ROCK,     10, 75,  .9  -- 48
   ;;, "triattck", T_NORMAL,   10, 80,  1   -- 49
   ;;, "substute", T_NORMAL,   10, 0,   0   -- 50

    -- hms
   ;;, "cut",      T_NORMAL,   30, 50,  .95 -- 51
   ;;, "fly",      T_FLYING,   15, 90,  .95 -- 52
   ;;, "surf",     T_WATER,    15, 90,  1   -- 53
   ;;, "strength", T_NORMAL,   15, 80,  1   -- 54
   ;;, "flash",    T_NORMAL,   20, 0,   1   -- 55

    -- remaining moves (besides struggle)
   ;;, "pound",    T_NORMAL,   35, 40,  1   -- 56
   ;;, "karatchp", T_FIGHTING, 25, 50,  1   -- 57
   ;;, "doublslp", T_NORMAL,   10, 15,  .85 -- 58
   ;;, "comtpnch", T_NORMAL,   15, 18,  .85 -- 59
   ;;, "firepnch", T_FIRE,     15, 75,  1   -- 60
   ;;, "icepnch",  T_ICE,      15, 75,  1   -- 61
   ;;, "thndpnch", T_ELECTRIC, 15, 75,  1   -- 62
   ;;, "scratch",  T_NORMAL,   35, 40,  1   -- 63
   ;;, "vicegrip", T_NORMAL,   30, 55,  1   -- 64
   ;;, "guilotin", T_NORMAL,   5,  0,   .3  -- 65
   ;;, "gust",     T_FLYING,   35, 40,  1   -- 66
   ;;, "wingatck", T_FLYING,   35, 60,  1   -- 67
   ;;, "bind",     T_NORMAL,   20, 15,  .85 -- 68
   ;;, "slam",     T_NORMAL,   20, 80,  .75 -- 69
   ;;, "vinewhip", T_GRASS,    25, 45,  1   -- 70
   ;;, "stomp",    T_NORMAL,   20, 65,  1   -- 71
   ;;, "doublkck", T_FIGHTING, 30, 30,  1   -- 72
   ;;, "jumpkck",  T_FIGHTING, 10, 100, .95 -- 73
   ;;, "rllngkck", T_FIGHTING, 15, 60,  .85 -- 74
   ;;, "sandatck", T_GROUND,   15, 0,   1   -- 75
   ;;, "headbutt", T_NORMAL,   15, 70,  1   -- 76
   ;;, "hornatck", T_NORMAL,   25, 65,  1   -- 77
   ;;, "furyatck", T_NORMAL,   20, 15,  .85 -- 78
   ;;, "tackle",   T_NORMAL,   35, 40,  1   -- 79
   ;;, "wrap",     T_NORMAL,   20, 15,  .9  -- 80
   ;;, "thrash",   T_NORMAL,   10, 120, 1   -- 81
   ;;, "tailwhip", T_NORMAL,   30, 0,   1   -- 82
   ;;, "psnsting", T_POISON,   35, 15,  1   -- 83
   ;;, "twineedl", T_BUG,      20, 25,  1   -- 84
   ;;, "pinmisil", T_BUG,      20, 25,  .95 -- 85
   ;;, "leer",     T_NORMAL,   30, 0,   1   -- 86
   ;;, "bite",     T_NORMAL,   25, 60,  1   -- 87
   ;;, "growl",    T_NORMAL,   40, 0,   1   -- 88
   ;;, "roar",     T_NORMAL,   20, 0,   1   -- 89
   ;;, "sing",     T_NORMAL,   15, 0,   .55 -- 90
   ;;, "supersnc", T_NORMAL,   20, 0,   .55 -- 91
   ;;, "sonicbm",  T_NORMAL,   20, 0,   .9  -- 92
   ;;, "disable",  T_NORMAL,   20, 0,   1   -- 93
   ;;, "acid",     T_POISON,   30, 40,  1   -- 94
   ;;, "ember",    T_FIRE,     25, 40,  1   -- 95
   ;;, "flamthwr", T_FIRE,     15, 90,  1   -- 96
   ;;, "mist",     T_ICE,      30, 0,   0   -- 97
   ;;, "hydropmp", T_WATER,    5,  110, .8  -- 98
   ;;, "psybeam",  T_PSYCHIC,  20, 65,  1   -- 99
   ;;, "aurorabm", T_ICE,      20, 65,  1   -- 100
   ;;, "peck",     T_FLYING,   35, 35,  1   -- 101
   ;;, "drillpck", T_FLYING,   20, 80,  1   -- 102
   ;;, "lowkick",  T_FIGHTING, 20, 0,   1   -- 103
   ;;, "absorb",   T_GRASS,    25, 20,  1   -- 104
   ;;, "leechsed", T_GRASS,    10, 0,   .9  -- 105
   ;;, "growth",   T_NORMAL,   20, 0,   0   -- 106
   ;;, "razrleaf", T_GRASS,    25, 55,  .95 -- 107
   ;;, "psnpowdr", T_POISON,   35, 0,   .75 -- 108
   ;;, "stunspor", T_GRASS,    30, 0,   .75 -- 109
   ;;, "slppowdr", T_GRASS,    15, 0,   .75 -- 110
   ;;, "petldanc", T_GRASS,    10, 120, 1   -- 111
   ;;, "strngsht", T_BUG,      40, 0,   .95 -- 112
   ;;, "firespin", T_FIRE,     15, 35,  .85 -- 113
   ;;, "thndshck", T_ELECTRIC, 30, 40,  1   -- 114
   ;;, "rockthrw", T_ROCK,     15, 50,  .9  -- 115
   ;;, "cnfusion", T_PSYCHIC,  25, 50,  1   -- 116
   ;;, "hypnosis", T_PSYCHIC,  20, 0,   .6  -- 117
   ;;, "meditate", T_PSYCHIC,  40, 0,   0   -- 118
   ;;, "agility",  T_PSYCHIC,  30, 0,   0   -- 119
   ;;, "quickatk", T_NORMAL,   30, 40,  1   -- 120
   ;;, "nghtshde", T_GHOST,    15, 0,   1   -- 121
   ;;, "screech",  T_NORMAL,   40, 0,   .85 -- 122
   ;;, "recover",  T_NORMAL,   5,  0,   0   -- 123
   ;;, "harden",   T_NORMAL,   30, 0,   0   -- 124
   ;;, "minimize", T_NORMAL,   10, 0,   0   -- 125
   ;;, "smokscrn", T_NORMAL,   20, 0,   1   -- 126
   ;;, "cnfusray", T_GHOST,    10, 0,   1   -- 127
   ;;, "withdraw", T_WATER,    40, 0,   0   -- 128
   ;;, "dfnscurl", T_NORMAL,   40, 0,   0   -- 129
   ;;, "barrier",  T_PSYCHIC,  20, 0,   0   -- 130
   ;;, "lghtscrn", T_PSYCHIC,  30, 0,   0   -- 131
   ;;, "haze",     T_ICE,      30, 0,   0   -- 132
   ;;, "fcsenrgy", T_NORMAL,   30, 0,   0   -- 133
   ;;, "mirrmove", T_FLYING,   20, 0,   0   -- 134
   ;;, "lick",     T_GHOST,    30, 30,  1   -- 135
   ;;, "smog",     T_POISON,   20, 30,  .7  -- 136
   ;;, "sludge",   T_POISON,   20, 65,  1   -- 137
   ;;, "boneclub", T_GROUND,   20, 65,  .85 -- 138
   ;;, "waterfal", T_WATER,    15, 80,  1   -- 139
   ;;, "clamp",    T_WATER,    15, 35,  .85 -- 140
   ;;, "spikcann", T_NORMAL,   15, 20,  1   -- 141
   ;;, "constrct", T_NORMAL,   35, 10,  1   -- 142
   ;;, "amnesia",  T_PSYCHIC,  20, 0,   0   -- 143
   ;;, "kinesis",  T_PSYCHIC,  15, 0,   .8  -- 144
   ;;, "hijmpkck", T_FIGHTING, 10, 130, .9  -- 145
   ;;, "glare",    T_NORMAL,   30, 0,   1   -- 146
   ;;, "psngas",   T_POISON,   40, 0,   .9  -- 147
   ;;, "barrage",  T_NORMAL,   20, 15,  .85 -- 148
   ;;, "leechlif", T_BUG,      10, 80,  1   -- 149
   ;;, "lovekiss", T_NORMAL,   10, 0,   .75 -- 150
   ;;, "tranform", T_NORMAL,   10, 0,   0   -- 151
   ;;, "bubble",   T_WATER,    30, 40,  1   -- 152
   ;;, "dizypnch", T_NORMAL,   10, 70,  1   -- 153
   ;;, "spore",    T_GRASS,    15, 0,   1   -- 154
   ;;, "splash",   T_NORMAL,   40, 0,   0   -- 155
   ;;, "acidarmr", T_POISON,   20, 0,   0   -- 156
   ;;, "crabhamr", T_WATER,    10, 100, .9  -- 157
   ;;, "furyswps", T_NORMAL,   15, 18,  .8  -- 158
   ;;, "bonerang", T_GROUND,   10, 50,  .9  -- 159
   ;;, "hyprfang", T_NORMAL,   15, 80,  .9  -- 160
   ;;, "sharpen",  T_NORMAL,   30, 0,   0   -- 161
   ;;, "convrson", T_NORMAL,   30, 0,   0   -- 162
   ;;, "suprfang", T_NORMAL,   10, 0,   .9  -- 163
   ;;, "slash",    T_NORMAL,   20, 70,  1   -- 164
]]
