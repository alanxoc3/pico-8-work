c_pokemon = zobj[[
    -- missingno has 0 base defence, but this becomes 1 in a battle based on the logic in getstat.
    -- evol says how many numbers going up is the previous evolution. 0 means no previous evolution.
    -- every pokemon is either 0 or 1, except for eevee's evolved forms.
    -- evol "name"         w     h   t1          t2           hp   att  def  spd  spc  move levels
   0;, 0,   "missingno",   10,   10, T_BIRD,     T_NORMAL,    33,  136, 0,   29,  6,   1,1                             -- 0
   ;;, 0,   "bulbasaur",   69,   7,  T_GRASS,    T_POISON,    45,  49,  49,  45,  65,  1,1,7,13,20,27,34,41,48         -- 1
   ;;, 1,   "ivysaur",     130,  10, T_GRASS,    T_POISON,    60,  62,  63,  60,  80,  1,1,7,13,22,30,38,46,54         -- 2
   ;;, 1,   "venusaur",    1000, 20, T_GRASS,    T_POISON,    80,  82,  83,  80,  100, 1,1,7,13,22,30,43,55,65         -- 3
   ;;, 0,   "charmander",  85,   6,  T_FIRE,     T_NONE,      39,  52,  43,  65,  50,  1,1,9,15,22,30,38,46            -- 4
   ;;, 1,   "charmeleon",  190,  11, T_FIRE,     T_NONE,      58,  64,  58,  80,  65,  1,1,9,15,24,33,42,56            -- 5
   ;;, 1,   "charizard",   905,  17, T_FIRE,     T_FLYING,    78,  84,  78,  100, 85,  1,1,9,15,24,36,46,55            -- 6
   ;;, 0,   "squirtle",    90,   5,  T_WATER,    T_NONE,      44,  48,  65,  43,  50,  1,1,8,15,22,28,35,42            -- 7
   ;;, 1,   "wartortle",   225,  10, T_WATER,    T_NONE,      59,  63,  80,  58,  65,  1,1,8,15,24,31,39,47            -- 8
   ;;, 1,   "blastoise",   855,  16, T_WATER,    T_NONE,      79,  83,  100, 78,  85,  1,1,8,15,24,31,42,52            -- 9
   ;;, 0,   "caterpie",    29,   3,  T_BUG,      T_NONE,      45,  30,  35,  45,  20,  1,1                             -- 10
   ;;, 1,   "metapod",     99,   7,  T_BUG,      T_NONE,      50,  20,  55,  30,  25,  1                               -- 11
   ;;, 1,   "butterfree",  320,  11, T_BUG,      T_FLYING,    60,  45,  50,  70,  80,  1,15,16,17,21,26,28,34          -- 12
   ;;, 0,   "weedle",      32,   3,  T_BUG,      T_POISON,    40,  35,  30,  50,  20,  1,1                             -- 13
   ;;, 1,   "kakuna",      100,  6,  T_BUG,      T_POISON,    45,  25,  50,  35,  25,  1                               -- 14
   ;;, 1,   "beedrill",    295,  10, T_BUG,      T_POISON,    65,  80,  40,  75,  45,  1,16,20,25,30,35                -- 15
   ;;, 0,   "pidgey",      18,   3,  T_NORMAL,   T_FLYING,    40,  45,  40,  56,  35,  1,5,12,19,28,36,44              -- 16
   ;;, 1,   "pidgeotto",   300,  11, T_NORMAL,   T_FLYING,    63,  60,  55,  71,  50,  1,5,12,21,31,40,49              -- 17
   ;;, 1,   "pidgeot",     395,  15, T_NORMAL,   T_FLYING,    83,  80,  75,  91,  70,  1,5,12,21,31,44,54              -- 18
   ;;, 0,   "rattata",     35,   3,  T_NORMAL,   T_NONE,      30,  56,  35,  72,  25,  1,1,7,14,23,34                  -- 19
   ;;, 1,   "raticate",    185,  7,  T_NORMAL,   T_NONE,      55,  81,  60,  97,  50,  1,1,7,14,27,41                  -- 20
   ;;, 0,   "spearow",     20,   3,  T_NORMAL,   T_FLYING,    40,  60,  30,  70,  31,  1,1,9,15,22,29,36               -- 21
   ;;, 1,   "fearow",      380,  12, T_NORMAL,   T_FLYING,    65,  90,  65,  100, 61,  1,1,9,15,25,34,43               -- 22
   ;;, 0,   "ekans",       69,   20, T_POISON,   T_NONE,      35,  60,  44,  55,  40,  1,1,10,17,24,31,38              -- 23
   ;;, 1,   "arbok",       650,  35, T_POISON,   T_NONE,      60,  85,  69,  80,  65,  1,1,10,17,27,36,47              -- 24
   ;;, 0,   "pikachu",     60,   4,  T_ELECTRIC, T_NONE,      35,  55,  30,  90,  50,  1,1,6,9,15,16,20,26,26,33,43,50 -- 25
   ;;, 1,   "raichu",      300,  8,  T_ELECTRIC, T_NONE,      60,  90,  55,  100, 90,  1,1,1                           -- 26
   ;;, 0,   "sandshrew",   120,  6,  T_GROUND,   T_NONE,      50,  75,  85,  40,  30,  1,10,17,24,31,38                -- 27
   ;;, 1,   "sandslash",   295,  10, T_GROUND,   T_NONE,      75,  100, 110, 65,  55,  1,10,17,27,36,47                -- 28
   ;;, 0,   "nidoran?",    70,   4,  T_POISON,   T_NONE,      55,  47,  52,  41,  40,  1,1,8,17,23,30,38,43            -- 29
   ;;, 1,   "nidorina",    200,  8,  T_POISON,   T_NONE,      70,  62,  67,  56,  55,  1,1,8,19,27,36,46,50            -- 30
   ;;, 1,   "nidoqueen",   600,  13, T_POISON,   T_GROUND,    90,  82,  87,  76,  75,  1,1,8,12,14,23                  -- 31
   ;;, 0,   "nidoran!",    90,   5,  T_POISON,   T_NONE,      46,  57,  40,  50,  40,  1,1,8,17,23,30,38,43            -- 32
   ;;, 1,   "nidorino",    195,  9,  T_POISON,   T_NONE,      61,  72,  57,  65,  55,  1,1,8,19,27,36,46,50            -- 33
   ;;, 1,   "nidoking",    620,  14, T_POISON,   T_GROUND,    81,  92,  77,  85,  75,  1,8,12,14,23                    -- 34
   ;;, 0,   "clefairy",    75,   6,  T_NORMAL,   T_NONE,      70,  45,  48,  35,  60,  1,1,13,18,24,31,39,48           -- 35
   ;;, 1,   "clefable",    400,  13, T_NORMAL,   T_NONE,      95,  70,  73,  60,  85,  1,1,1,1                         -- 36
   ;;, 0,   "vulpix",      99,   6,  T_FIRE,     T_NONE,      38,  41,  40,  65,  65,  1,1,16,21,28,35,42              -- 37
   ;;, 1,   "ninetales",   199,  11, T_FIRE,     T_NONE,      73,  76,  75,  100, 100, 1,1,1,1                         -- 38
   ;;, 0,   "jigglypuff",  55,   5,  T_NORMAL,   T_NONE,      115, 45,  20,  20,  25,  1,9,14,19,24,29,34,39           -- 39
   ;;, 1,   "wigglytuff",  120,  10, T_NORMAL,   T_NONE,      140, 70,  45,  45,  50,  1,1,1,1                         -- 40
   ;;, 0,   "zubat",       75,   8,  T_POISON,   T_FLYING,    40,  45,  35,  55,  40,  1,10,15,21,28,36                -- 41
   ;;, 1,   "golbat",      550,  16, T_POISON,   T_FLYING,    75,  80,  70,  90,  75,  1,1,10,15,21,32,43              -- 42
   ;;, 0,   "oddish",      54,   5,  T_GRASS,    T_POISON,    45,  50,  55,  30,  75,  1,15,17,19,24,33,46             -- 43
   ;;, 1,   "gloom",       86,   8,  T_GRASS,    T_POISON,    60,  65,  70,  40,  85,  1,15,17,19,28,38,52             -- 44
   ;;, 1,   "vileplume",   186,  12, T_GRASS,    T_POISON,    75,  80,  85,  50,  100, 1,1,15,17,19                    -- 45
   ;;, 0,   "paras",       54,   3,  T_BUG,      T_GRASS,     35,  70,  55,  25,  55,  1,13,20,27,34,41                -- 46
   ;;, 1,   "parasect",    295,  10, T_BUG,      T_GRASS,     60,  95,  80,  30,  80,  1,13,20,30,39,48                -- 47
   ;;, 0,   "venonat",     300,  10, T_BUG,      T_POISON,    60,  55,  50,  45,  40,  1,1,11,19,24,27,30,35,38,43     -- 48
   ;;, 1,   "venomoth",    125,  15, T_BUG,      T_POISON,    70,  65,  60,  90,  90,  1,1,1,1,24,27,30,38,43,50       -- 49
   ;;, 0,   "diglett",     8,    2,  T_GROUND,   T_NONE,      10,  55,  25,  95,  45,  1,15,19,24,31,40                -- 50
   ;;, 1,   "dugtrio",     333,  7,  T_GROUND,   T_NONE,      35,  80,  50,  120, 70,  1,15,19,24,35,47                -- 51
   ;;, 0,   "meowth",      42,   4,  T_NORMAL,   T_NONE,      40,  45,  35,  90,  40,  1,1,12,17,24,33,44              -- 52
   ;;, 1,   "persian",     320,  10, T_NORMAL,   T_NONE,      65,  70,  60,  115, 65,  1,1,12,17,24,37,51              -- 53
   ;;, 0,   "psyduck",     196,  8,  T_WATER,    T_NONE,      50,  52,  48,  55,  50,  1,28,31,36,43,52                -- 54
   ;;, 1,   "golduck",     766,  17, T_WATER,    T_NONE,      80,  82,  78,  85,  80,  1,28,31,39,48,59                -- 55
   ;;, 0,   "mankey",      280,  5,  T_FIGHTING, T_NONE,      40,  80,  35,  70,  35,  1,1,9,15,21,27,33,39,45         -- 56
   ;;, 1,   "primeape",    320,  10, T_FIGHTING, T_NONE,      65,  105, 60,  95,  60,  1,1,9,15,21,27,28,37,45,46      -- 57
   ;;, 0,   "growlithe",   190,  7,  T_FIRE,     T_NONE,      55,  70,  45,  60,  50,  1,1,18,23,30,39,50              -- 58
   ;;, 1,   "arcanine",    1550, 19, T_FIRE,     T_NONE,      90,  110, 80,  95,  80,  1,1,1,1                         -- 59
   ;;, 0,   "poliwag",     124,  6,  T_WATER,    T_NONE,      40,  50,  40,  90,  40,  1,16,19,25,31,38,45             -- 60
   ;;, 1,   "poliwhirl",   200,  10, T_WATER,    T_NONE,      65,  65,  65,  90,  50,  1,16,19,26,33,41,49             -- 61
   ;;, 1,   "poliwrath",   540,  13, T_WATER,    T_FIGHTING,  90,  85,  95,  70,  70,  1,1,16,19                       -- 62
   ;;, 0,   "abra",        195,  9,  T_PSYCHIC,  T_NONE,      25,  20,  15,  90,  105, 1                               -- 63
   ;;, 1,   "kadabra",     565,  13, T_PSYCHIC,  T_NONE,      40,  35,  30,  105, 120, 1,1,16,20,27,31,38,42           -- 64
   ;;, 1,   "alakazam",    480,  15, T_PSYCHIC,  T_NONE,      55,  50,  45,  120, 135, 1,1,16,20,27,31,38,42           -- 65
   ;;, 0,   "machop",      195,  8,  T_FIGHTING, T_NONE,      70,  80,  50,  35,  35,  1,20,25,32,39,46                -- 66
   ;;, 1,   "machoke",     705,  15, T_FIGHTING, T_NONE,      80,  100, 70,  45,  50,  1,20,25,36,44,52                -- 67
   ;;, 1,   "machamp",     1300, 16, T_FIGHTING, T_NONE,      90,  130, 80,  55,  65,  1,20,25,36,44,52                -- 68
   ;;, 0,   "bellsprout",  40,   7,  T_GRASS,    T_POISON,    50,  75,  35,  40,  70,  1,1,13,15,18,21,26,33,42        -- 69
   ;;, 1,   "weepinbell",  64,   10, T_GRASS,    T_POISON,    65,  90,  50,  55,  85,  1,1,13,15,18,23,29,38,49        -- 70
   ;;, 1,   "victreebel",  155,  17, T_GRASS,    T_POISON,    80,  105, 65,  70,  100, 1,1,1,13,15,18                  -- 71
   ;;, 0,   "tentacool",   455,  9,  T_WATER,    T_POISON,    40,  40,  35,  70,  100, 1,7,13,18,22,27,33,40,48        -- 72
   ;;, 1,   "tentacruel",  550,  16, T_WATER,    T_POISON,    80,  70,  65,  100, 120, 1,7,13,18,22,27,35,43,50        -- 73
   ;;, 0,   "geodude",     200,  4,  T_ROCK,     T_GROUND,    40,  80,  100, 20,  30,  1,11,16,21,26,31,36             -- 74
   ;;, 1,   "graveler",    1050, 10, T_ROCK,     T_GROUND,    55,  95,  115, 35,  45,  1,11,16,21,29,36,43             -- 75
   ;;, 1,   "golem",       3000, 14, T_ROCK,     T_GROUND,    80,  110, 130, 45,  55,  1,11,16,21,29,36,43             -- 76
   ;;, 0,   "ponyta",      300,  10, T_FIRE,     T_NONE,      50,  85,  55,  90,  65,  1,30,32,35,39,43,48             -- 77
   ;;, 1,   "rapidash",    950,  17, T_FIRE,     T_NONE,      65,  100, 70,  105, 80,  1,30,32,35,39,47,55             -- 78
   ;;, 0,   "slowpoke",    360,  12, T_WATER,    T_PSYCHIC,   90,  65,  65,  15,  40,  1,18,22,27,33,40,48             -- 79
   ;;, 1,   "slowbro",     785,  16, T_WATER,    T_PSYCHIC,   95,  75,  110, 30,  80,  1,18,22,27,33,37,44,55          -- 80
   ;;, 0,   "magnemite",   60,   3,  T_ELECTRIC, T_NONE,      25,  35,  70,  45,  95,  1,21,25,29,35,41,47             -- 81
   ;;, 1,   "magneton",    600,  10, T_ELECTRIC, T_NONE,      50,  60,  95,  70,  120, 1,21,25,29,38,46,54             -- 82
   ;;, 0,   "farfetch'd",  150,  8,  T_NORMAL,   T_FLYING,    52,  65,  55,  60,  58,  1,1,7,15,23,31,39               -- 83
   ;;, 0,   "doduo",       392,  14, T_NORMAL,   T_FLYING,    35,  85,  45,  75,  35,  1,20,24,30,36,40,44             -- 84
   ;;, 1,   "dodrio",      852,  18, T_NORMAL,   T_FLYING,    60,  110, 70,  100, 60,  1,20,24,30,39,45,51             -- 85
   ;;, 0,   "seel",        900,  11, T_WATER,    T_NONE,      65,  45,  55,  45,  70,  1,30,35,40,45,50                -- 86
   ;;, 1,   "dewgong",     1200, 17, T_WATER,    T_ICE,       90,  70,  80,  70,  95,  1,30,35,44,50,56                -- 87
   ;;, 0,   "grimer",      300,  9,  T_POISON,   T_NONE,      80,  80,  50,  25,  40,  1,1,30,33,37,42,48,55           -- 88
   ;;, 1,   "muk",         300,  12, T_POISON,   T_NONE,      105, 105, 75,  50,  65,  1,1,30,33,37,45,53,60           -- 89
   ;;, 0,   "shellder",    40,   3,  T_WATER,    T_NONE,      30,  65,  100, 40,  45,  1,1,18,23,30,39,50              -- 90
   ;;, 1,   "cloyster",    1325, 15, T_WATER,    T_ICE,       50,  95,  180, 70,  85,  1,1,1,1,50                      -- 91
   ;;, 0,   "gastly",      1,    13, T_GHOST,    T_POISON,    30,  35,  30,  80,  100, 1,1,1,27,35                     -- 92
   ;;, 1,   "haunter",     1,    16, T_GHOST,    T_POISON,    45,  50,  45,  95,  115, 1,1,1,29,38                     -- 93
   ;;, 1,   "gengar",      405,  15, T_GHOST,    T_POISON,    60,  65,  60,  110, 130, 1,1,1,29,38                     -- 94
   ;;, 0,   "onix",        2100, 88, T_ROCK,     T_GROUND,    35,  45,  160, 70,  30,  1,1,15,19,25,33,43              -- 95
   ;;, 0,   "drowzee",     324,  10, T_PSYCHIC,  T_NONE,      60,  48,  45,  42,  90,  1,1,12,17,24,29,32,37           -- 96
   ;;, 1,   "hypno",       756,  16, T_PSYCHIC,  T_NONE,      85,  73,  70,  67,  115, 1,1,12,17,24,33,37,43           -- 97
   ;;, 0,   "krabby",      65,   4,  T_WATER,    T_NONE,      30,  105, 90,  50,  25,  1,1,20,25,30,35,40              -- 98
   ;;, 1,   "kingler",     600,  13, T_WATER,    T_NONE,      55,  130, 115, 75,  50,  1,1,20,25,34,42,49              -- 99
   ;;, 0,   "voltorb",     104,  5,  T_ELECTRIC, T_NONE,      40,  30,  50,  100, 55,  1,1,17,22,29,36,43              -- 100
   ;;, 1,   "electrode",   666,  12, T_ELECTRIC, T_NONE,      60,  50,  70,  140, 80,  1,1,17,22,29,40,50              -- 101
   ;;, 0,   "exeggcute",   25,   4,  T_GRASS,    T_PSYCHIC,   60,  40,  80,  40,  60,  1,1,25,28,32,37,42,48           -- 102
   ;;, 1,   "exeggutor",   1200, 20, T_GRASS,    T_PSYCHIC,   95,  95,  85,  55,  125, 1,1,28                          -- 103
   ;;, 0,   "cubone",      65,   4,  T_GROUND,   T_NONE,      50,  50,  95,  35,  40,  1,10,13,18,25,31,38,43,46       -- 104
   ;;, 1,   "marowak",     450,  10, T_GROUND,   T_NONE,      60,  80,  110, 45,  50,  1,10,13,18,25,33,41,48,55       -- 105
   ;;, 0,   "hitmonlee",   498,  15, T_FIGHTING, T_NONE,      50,  120, 53,  87,  35,  1,1,33,38,43,48,53              -- 106
   ;;, 0,   "hitmonchan",  502,  14, T_FIGHTING, T_NONE,      50,  105, 79,  76,  35,  1,1,33,38,43,48,53              -- 107
   ;;, 0,   "lickitung",   655,  12, T_NORMAL,   T_NONE,      90,  55,  75,  30,  60,  1,1,7,15,23,31,39               -- 108
   ;;, 0,   "koffing",     10,   6,  T_POISON,   T_NONE,      40,  65,  95,  35,  60,  1,1,32,37,40,45,48              -- 109
   ;;, 1,   "weezing",     95,   12, T_POISON,   T_NONE,      65,  90,  120, 60,  85,  1,1,32,39,43,49,53              -- 110
   ;;, 0,   "rhyhorn",     1150, 10, T_GROUND,   T_ROCK,      80,  85,  95,  25,  30,  1,30,35,40,45,50,55             -- 111
   ;;, 1,   "rhydon",      1200, 19, T_GROUND,   T_ROCK,      105, 130, 120, 40,  45,  1,30,35,40,48,55,64             -- 112
   ;;, 0,   "chansey",     346,  11, T_NORMAL,   T_NONE,      250, 5,   5,   50,  105, 1,1,12,24,30,38,44,48,54        -- 113
   ;;, 0,   "tangela",     350,  10, T_GRASS,    T_NONE,      65,  55,  115, 60,  100, 1,24,29,29,32,36,39,45,49       -- 114
   ;;, 0,   "kangaskhan",  800,  22, T_NORMAL,   T_NONE,      105, 95,  80,  90,  40,  1,1,26,31,36,41,46              -- 115
   ;;, 0,   "horsea",      80,   4,  T_WATER,    T_NONE,      30,  40,  70,  60,  70,  1,19,24,30,37,45                -- 116
   ;;, 1,   "seadra",      250,  12, T_WATER,    T_NONE,      55,  65,  95,  85,  95,  1,19,24,30,41,52                -- 117
   ;;, 0,   "goldeen",     150,  6,  T_WATER,    T_NONE,      45,  67,  60,  63,  50,  1,1,19,24,30,37,45,54           -- 118
   ;;, 1,   "seaking",     390,  13, T_WATER,    T_NONE,      80,  92,  65,  68,  80,  1,1,19,24,30,39,48,54           -- 119
   ;;, 0,   "staryu",      345,  8,  T_WATER,    T_NONE,      30,  45,  55,  85,  70,  1,17,22,27,32,37,42,47          -- 120
   ;;, 1,   "starmie",     800,  11, T_WATER,    T_PSYCHIC,   60,  75,  85,  115, 100, 1,1,1                           -- 121
   ;;, 0,   "mr mime",     545,  13, T_PSYCHIC,  T_NONE,      40,  45,  65,  90,  100, 1,15,23,31,39,47                -- 122
   ;;, 0,   "scyther",     560,  15, T_BUG,      T_FLYING,    70,  110, 80,  105, 55,  1,17,20,24,29,35,42,50          -- 123
   ;;, 0,   "jynx",        406,  14, T_ICE,      T_PSYCHIC,   65,  50,  35,  95,  95,  1,1,18,23,31,39,47,58           -- 124
   ;;, 0,   "electabuzz",  300,  11, T_ELECTRIC, T_NONE,      65,  83,  57,  105, 85,  1,1,34,37,42,49,54              -- 125
   ;;, 0,   "magmar",      445,  13, T_FIRE,     T_NONE,      65,  95,  57,  93,  85,  1,36,39,43,48,52,55             -- 126
   ;;, 0,   "pinsir",      550,  15, T_BUG,      T_NONE,      65,  125, 100, 85,  55,  1,21,25,30,36,43,49,54          -- 127
   ;;, 0,   "tauros",      884,  14, T_NORMAL,   T_NONE,      75,  100, 95,  110, 70,  1,21,28,35,44,51                -- 128
   ;;, 0,   "magikarp",    100,  9,  T_WATER,    T_NONE,      20,  10,  55,  80,  20,  1,15                            -- 129
   ;;, 1,   "gyarados",    2350, 65, T_WATER,    T_FLYING,    95,  125, 79,  81,  100, 1,20,25,32,41,52                -- 130
   ;;, 0,   "lapras",      2200, 25, T_WATER,    T_ICE,       130, 85,  80,  60,  95,  1,1,16,20,25,31,38,46           -- 131
   ;;, 0,   "ditto",       40,   3,  T_NORMAL,   T_NONE,      48,  48,  48,  48,  48,  1                               -- 132
   ;;, 0,   "eevee",       65,   3,  T_NORMAL,   T_NONE,      55,  55,  50,  55,  65,  1,8,16,27,31,36,37,45           -- 133
   ;;, 1,   "vaporeon",    290,  10, T_WATER,    T_NONE,      130, 65,  60,  65,  110, 1,8,27,31,36,37,40,44,47,48,54  -- 134
   ;;, 2,   "jolteon",     245,  8,  T_ELECTRIC, T_NONE,      65,  65,  60,  130, 110, 1,8,27,31,37,42,42,47,48,54     -- 135
   ;;, 3,   "flareon",     250,  9,  T_FIRE,     T_NONE,      65,  130, 60,  65,  110, 1,8,27,31,37,40,42,44,47,48,54  -- 136
   ;;, 0,   "porygon",     365,  8,  T_NORMAL,   T_NONE,      65,  60,  70,  40,  75,  1,1,1,23,28,35,42               -- 137
   ;;, 0,   "omanyte",     75,   4,  T_ROCK,     T_WATER,     35,  40,  100, 35,  90,  1,1,34,39,46,53                 -- 138
   ;;, 1,   "omastar",     350,  10, T_ROCK,     T_WATER,     70,  60,  125, 55,  115, 1,1,34,39,44,49                 -- 139
   ;;, 0,   "kabuto",      115,  5,  T_ROCK,     T_WATER,     30,  80,  90,  55,  45,  1,1,34,39,44,49                 -- 140
   ;;, 1,   "kabutops",    405,  13, T_ROCK,     T_WATER,     60,  115, 105, 80,  70,  1,1,34,39,46,53                 -- 141
   ;;, 0,   "aerodactyl",  590,  18, T_ROCK,     T_FLYING,    80,  105, 65,  130, 60,  1,1,33,38,45,54                 -- 142
   ;;, 0,   "snorlax",     4600, 21, T_NORMAL,   T_NONE,      160, 110, 65,  30,  65,  1,1,1,35,41,48,56               -- 143
   ;;, 0,   "articuno",    554,  17, T_ICE,      T_FLYING,    90,  85,  100, 85,  125, 1,1,51,55,60                    -- 144
   ;;, 0,   "zapdos",      526,  16, T_ELECTRIC, T_FLYING,    90,  90,  85,  100, 125, 1,1,51,55,60                    -- 145
   ;;, 0,   "moltres",     600,  20, T_FIRE,     T_FLYING,    90,  100, 90,  90,  125, 1,1,51,55,60                    -- 146
   ;;, 0,   "dratini",     33,   18, T_DRAGON,   T_NONE,      41,  64,  45,  50,  50,  1,1,10,20,30,40,50              -- 147
   ;;, 1,   "dragonair",   165,  40, T_DRAGON,   T_NONE,      61,  84,  65,  70,  70,  1,1,10,20,35,45,55              -- 148
   ;;, 1,   "dragonite",   2100, 22, T_DRAGON,   T_FLYING,    91,  134, 95,  80,  100, 1,1,10,20,35,45,60              -- 149
   ;;, 0,   "mewtwo",      1220, 20, T_PSYCHIC,  T_NONE,      106, 110, 90,  130, 154, 1,1,1,63,66,70,75,81            -- 150
   ;;, 0,   "mew",         40,   4,  T_PSYCHIC,  T_NONE,      100, 100, 100, 100, 100, 1,10,20,30,40                   -- 151
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

c_moves = zobj[[
   -- "name",      type        pp  dmg  acc
   0;, "struggle",  T_NORMAL,   ,   50,

    -- tms
   ;;, "megapunch", T_NORMAL,   20, 80,  .85 -- 1
   ;;, "razorwind", T_NORMAL,   10, 80,  1   -- 2
   ;;, "swordance", T_NORMAL,   20, ,        -- 3
   ;;, "whirlwind", T_NORMAL,   20, ,        -- 4
   ;;, "megakick",  T_NORMAL,   5,  120, .75 -- 5
   ;;, "toxic",     T_POISON,   10, ,    .9  -- 6
   ;;, "horndrill", T_NORMAL,   5,  ,    .3  -- 7
   ;;, "bodyslam",  T_NORMAL,   15, 85,  1   -- 8
   ;;, "takedown",  T_NORMAL,   20, 90,  .85 -- 9
   ;;, "doubledge", T_NORMAL,   15, 120, 1   -- 10
   ;;, "bublebeam", T_WATER,    20, 65,  1   -- 11
   ;;, "watergun",  T_WATER,    25, 40,  1   -- 12
   ;;, "icebeam",   T_ICE,      10, 90,  1   -- 13
   ;;, "blizzard",  T_ICE,      5,  110, .7  -- 14
   ;;, "hyperbeam", T_NORMAL,   5,  150, .9  -- 15
   ;;, "payday",    T_NORMAL,   20, 40,  1   -- 16
   ;;, "submision", T_FIGHTING, 20, 80,  .8  -- 17
   ;;, "counter",   T_FIGHTING, 20, ,    1   -- 18
   ;;, "seismctss", T_FIGHTING, 20, ,    1   -- 19
   ;;, "rage",      T_NORMAL,   20, 20,  1   -- 20
   ;;, "megadrain", T_GRASS,    15, 40,  1   -- 21
   ;;, "solarbeam", T_GRASS,    10, 120, 1   -- 22
   ;;, "drgonrage", T_DRAGON,   10, ,    1   -- 23
   ;;, "thndrbolt", T_ELECTRIC, 15, 90,  1   -- 24
   ;;, "thunder",   T_ELECTRIC, 10, 110, .7  -- 25
   ;;, "eartquake", T_GROUND,   10, 100, 1   -- 26
   ;;, "fissure",   T_GROUND,   5,  ,    .3  -- 27
   ;;, "dig",       T_GROUND,   10, 80,  1   -- 28
   ;;, "psychic",   T_PSYCHIC,  10, 90,  1   -- 29
   ;;, "teleport",  T_PSYCHIC,  20, ,        -- 30
   ;;, "mimic",     T_NORMAL,   10, ,        -- 31
   ;;, "dubleteam", T_NORMAL,   15, ,        -- 32
   ;;, "reflect",   T_PSYCHIC,  20, ,        -- 33
   ;;, "bide",      T_NORMAL,   10, ,        -- 34
   ;;, "metronome", T_NORMAL,   10, ,        -- 35
   ;;, "slfdstrct", T_NORMAL,   5,  200, 1   -- 36
   ;;, "eggbomb",   T_NORMAL,   10, 100, .75 -- 37
   ;;, "fireblast", T_FIRE,     5,  110, .85 -- 38
   ;;, "swift",     T_NORMAL,   20, 60,      -- 39
   ;;, "skullbash", T_NORMAL,   10, 130, 1   -- 40
   ;;, "softboild", T_NORMAL,   5,  ,        -- 41
   ;;, "dreameatr", T_PSYCHIC,  15, 100, 1   -- 42
   ;;, "skyattack", T_FLYING,   5,  140, .9  -- 43
   ;;, "rest",      T_PSYCHIC,  5,  ,        -- 44
   ;;, "thndrwave", T_ELECTRIC, 20, ,    .9  -- 45
   ;;, "psywave",   T_PSYCHIC,  15, ,    1   -- 46
   ;;, "explosion", T_NORMAL,   5,  250, 1   -- 47
   ;;, "rockslide", T_ROCK,     10, 75,  .9  -- 48
   ;;, "triattack", T_NORMAL,   10, 80,  1   -- 49
   ;;, "sbstitute", T_NORMAL,   10, ,        -- 50

    -- hms
   ;;, "cut",       T_NORMAL,   30, 50,  .95 -- 51
   ;;, "fly",       T_FLYING,   15, 90,  .95 -- 52
   ;;, "surf",      T_WATER,    15, 90,  1   -- 53
   ;;, "strength",  T_NORMAL,   15, 80,  1   -- 54
   ;;, "flash",     T_NORMAL,   20, ,    1   -- 55

    -- remaining moves (besides struggle)
   ;;, "pound",     T_NORMAL,   35, 40,  1   -- 56
   ;;, "karatechp", T_FIGHTING, 25, 50,  1   -- 57
   ;;, "dubleslap", T_NORMAL,   10, 15,  .85 -- 58
   ;;, "cometpnch", T_NORMAL,   15, 18,  .85 -- 59
   ;;, "firepunch", T_FIRE,     15, 75,  1   -- 60
   ;;, "icepunch",  T_ICE,      15, 75,  1   -- 61
   ;;, "thndrpnch", T_ELECTRIC, 15, 75,  1   -- 62
   ;;, "scratch",   T_NORMAL,   35, 40,  1   -- 63
   ;;, "vicegrip",  T_NORMAL,   30, 55,  1   -- 64
   ;;, "guilotine", T_NORMAL,   5,  ,    .3  -- 65
   ;;, "gust",      T_FLYING,   35, 40,  1   -- 66
   ;;, "wingattck", T_FLYING,   35, 60,  1   -- 67
   ;;, "bind",      T_NORMAL,   20, 15,  .85 -- 68
   ;;, "slam",      T_NORMAL,   20, 80,  .75 -- 69
   ;;, "vinewhip",  T_GRASS,    25, 45,  1   -- 70
   ;;, "stomp",     T_NORMAL,   20, 65,  1   -- 71
   ;;, "dublekick", T_FIGHTING, 30, 30,  1   -- 72
   ;;, "jumpkick",  T_FIGHTING, 10, 100, .95 -- 73
   ;;, "rolingkck", T_FIGHTING, 15, 60,  .85 -- 74
   ;;, "sandattck", T_GROUND,   15, ,    1   -- 75
   ;;, "headbutt",  T_NORMAL,   15, 70,  1   -- 76
   ;;, "hornattck", T_NORMAL,   25, 65,  1   -- 77
   ;;, "furyattck", T_NORMAL,   20, 15,  .85 -- 78
   ;;, "tackle",    T_NORMAL,   35, 40,  1   -- 79
   ;;, "wrap",      T_NORMAL,   20, 15,  .9  -- 80
   ;;, "thrash",    T_NORMAL,   10, 120, 1   -- 81
   ;;, "tailwhip",  T_NORMAL,   30, ,    1   -- 82
   ;;, "psnsting",  T_POISON,   35, 15,  1   -- 83
   ;;, "twineedle", T_BUG,      20, 25,  1   -- 84
   ;;, "pinmisile", T_BUG,      20, 25,  .95 -- 85
   ;;, "leer",      T_NORMAL,   30, ,    1   -- 86
   ;;, "bite",      T_NORMAL,   25, 60,  1   -- 87
   ;;, "growl",     T_NORMAL,   40, ,    1   -- 88
   ;;, "roar",      T_NORMAL,   20, ,        -- 89
   ;;, "sing",      T_NORMAL,   15, ,    .55 -- 90
   ;;, "suprsonic", T_NORMAL,   20, ,    .55 -- 91
   ;;, "sonicboom", T_NORMAL,   20, ,    .9  -- 92
   ;;, "disable",   T_NORMAL,   20, ,    1   -- 93
   ;;, "acid",      T_POISON,   30, 40,  1   -- 94
   ;;, "ember",     T_FIRE,     25, 40,  1   -- 95
   ;;, "flmethrwr", T_FIRE,     15, 90,  1   -- 96
   ;;, "mist",      T_ICE,      30, ,        -- 97
   ;;, "hydropump", T_WATER,    5,  110, .8  -- 98
   ;;, "psybeam",   T_PSYCHIC,  20, 65,  1   -- 99
   ;;, "aurorbeam", T_ICE,      20, 65,  1   -- 100
   ;;, "peck",      T_FLYING,   35, 35,  1   -- 101
   ;;, "drillpeck", T_FLYING,   20, 80,  1   -- 102
   ;;, "lowkick",   T_FIGHTING, 20, ,    1   -- 103
   ;;, "absorb",    T_GRASS,    25, 20,  1   -- 104
   ;;, "leechseed", T_GRASS,    10, ,    .9  -- 105
   ;;, "growth",    T_NORMAL,   20, ,        -- 106
   ;;, "razorleaf", T_GRASS,    25, 55,  .95 -- 107
   ;;, "psnpowder", T_POISON,   35, ,    .75 -- 108
   ;;, "stunspore", T_GRASS,    30, ,    .75 -- 109
   ;;, "slppowder", T_GRASS,    15, ,    .75 -- 110
   ;;, "petldance", T_GRASS,    10, 120, 1   -- 111
   ;;, "stringsht", T_BUG,      40, ,    .95 -- 112
   ;;, "firespin",  T_FIRE,     15, 35,  .85 -- 113
   ;;, "thndrshck", T_ELECTRIC, 30, 40,  1   -- 114
   ;;, "rockthrow", T_ROCK,     15, 50,  .9  -- 115
   ;;, "confusion", T_PSYCHIC,  25, 50,  1   -- 116
   ;;, "hypnosis",  T_PSYCHIC,  20, ,    .6  -- 117
   ;;, "meditate",  T_PSYCHIC,  40, ,        -- 118
   ;;, "agility",   T_PSYCHIC,  30, ,        -- 119
   ;;, "quickatck", T_NORMAL,   30, 40,  1   -- 120
   ;;, "niteshade", T_GHOST,    15, ,    1   -- 121
   ;;, "screech",   T_NORMAL,   40, ,    .85 -- 122
   ;;, "recover",   T_NORMAL,   5,  ,        -- 123
   ;;, "harden",    T_NORMAL,   30, ,        -- 124
   ;;, "minimize",  T_NORMAL,   10, ,        -- 125
   ;;, "smokescrn", T_NORMAL,   20, ,    1   -- 126
   ;;, "confusray", T_GHOST,    10, ,    1   -- 127
   ;;, "withdraw",  T_WATER,    40, ,        -- 128
   ;;, "defenscrl", T_NORMAL,   40, ,        -- 129
   ;;, "barrier",   T_PSYCHIC,  20, ,        -- 130
   ;;, "lightscrn", T_PSYCHIC,  30, ,        -- 131
   ;;, "haze",      T_ICE,      30, ,        -- 132
   ;;, "focusnrgy", T_NORMAL,   30, ,        -- 133
   ;;, "mirormove", T_FLYING,   20, ,        -- 134
   ;;, "lick",      T_GHOST,    30, 30,  1   -- 135
   ;;, "smog",      T_POISON,   20, 30,  .7  -- 136
   ;;, "sludge",    T_POISON,   20, 65,  1   -- 137
   ;;, "boneclub",  T_GROUND,   20, 65,  .85 -- 138
   ;;, "waterfall", T_WATER,    15, 80,  1   -- 139
   ;;, "clamp",     T_WATER,    15, 35,  .85 -- 140
   ;;, "spikcanon", T_NORMAL,   15, 20,  1   -- 141
   ;;, "constrict", T_NORMAL,   35, 10,  1   -- 142
   ;;, "amnesia",   T_PSYCHIC,  20, ,        -- 143
   ;;, "kinesis",   T_PSYCHIC,  15, ,    .8  -- 144
   ;;, "hghjmpkck", T_FIGHTING, 10, 130, .9  -- 145
   ;;, "glare",     T_NORMAL,   30, ,    1   -- 146
   ;;, "poisongas", T_POISON,   40, ,    .9  -- 147
   ;;, "barrage",   T_NORMAL,   20, 15,  .85 -- 148
   ;;, "leechlife", T_BUG,      10, 80,  1   -- 149
   ;;, "lovelykss", T_NORMAL,   10, ,    .75 -- 150
   ;;, "transform", T_NORMAL,   10, ,        -- 151
   ;;, "bubble",    T_WATER,    30, 40,  1   -- 152
   ;;, "dizypunch", T_NORMAL,   10, 70,  1   -- 153
   ;;, "spore",     T_GRASS,    15, ,    1   -- 154
   ;;, "splash",    T_NORMAL,   40, ,        -- 155
   ;;, "acidarmor", T_POISON,   20, ,        -- 156
   ;;, "crbhammer", T_WATER,    10, 100, .9  -- 157
   ;;, "furyswipe", T_NORMAL,   15, 18,  .8  -- 158
   ;;, "bonemrang", T_GROUND,   10, 50,  .9  -- 159
   ;;, "hyperfang", T_NORMAL,   15, 80,  .9  -- 160
   ;;, "sharpen",   T_NORMAL,   30, ,        -- 161
   ;;, "convrsion", T_NORMAL,   30, ,        -- 162
   ;;, "superfang", T_NORMAL,   10, ,    .9  -- 163
   ;;, "slash",     T_NORMAL,   20, 70,  1   -- 164
]]
