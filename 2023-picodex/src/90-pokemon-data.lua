c_pokemon = zobj[[
    --    name           w     h   t1          t2           hp   att  def  spd  special
    0;,   "missingno",   10,   10, T_BIRD,     T_NORMAL,    33,  136, 0,   29,  6;
    1;,   "bulbasaur",   69,   7,  T_GRASS,    T_POISON,    45,  49,  49,  45,  65;
    2;,   "ivysaur",     130,  10, T_GRASS,    T_POISON,    60,  62,  63,  60,  80;
    3;,   "venusaur",    1000, 20, T_GRASS,    T_POISON,    80,  82,  83,  80,  100;
    4;,   "charmander",  85,   6,  T_FIRE,     T_NONE,      39,  52,  43,  65,  50;
    5;,   "charmeleon",  190,  11, T_FIRE,     T_NONE,      58,  64,  58,  80,  65;
    6;,   "charizard",   905,  17, T_FIRE,     T_FLYING,    78,  84,  78,  100, 85;
    7;,   "squirtle",    90,   5,  T_WATER,    T_NONE,      44,  48,  65,  43,  50;
    8;,   "wartortle",   225,  10, T_WATER,    T_NONE,      59,  63,  80,  58,  65;
    9;,   "blastoise",   855,  16, T_WATER,    T_NONE,      79,  83,  100, 78,  85;
    10;,  "caterpie",    29,   3,  T_BUG,      T_NONE,      45,  30,  35,  45,  20;
    11;,  "metapod",     99,   7,  T_BUG,      T_NONE,      50,  20,  55,  30,  25;
    12;,  "butterfree",  320,  11, T_BUG,      T_FLYING,    60,  45,  50,  70,  80;
    13;,  "weedle",      32,   3,  T_BUG,      T_POISON,    40,  35,  30,  50,  20;
    14;,  "kakuna",      100,  6,  T_BUG,      T_POISON,    45,  25,  50,  35,  25;
    15;,  "beedrill",    295,  10, T_BUG,      T_POISON,    65,  80,  40,  75,  45;
    16;,  "pidgey",      18,   3,  T_NORMAL,   T_FLYING,    40,  45,  40,  56,  35;
    17;,  "pidgeotto",   300,  11, T_NORMAL,   T_FLYING,    63,  60,  55,  71,  50;
    18;,  "pidgeot",     395,  15, T_NORMAL,   T_FLYING,    83,  80,  75,  91,  70;
    19;,  "rattata",     35,   3,  T_NORMAL,   T_NONE,      30,  56,  35,  72,  25;
    20;,  "raticate",    185,  7,  T_NORMAL,   T_NONE,      55,  81,  60,  97,  50;
    21;,  "spearow",     20,   3,  T_NORMAL,   T_FLYING,    40,  60,  30,  70,  31;
    22;,  "fearow",      380,  12, T_NORMAL,   T_FLYING,    65,  90,  65,  100, 61;
    23;,  "ekans",       69,   20, T_POISON,   T_NONE,      35,  60,  44,  55,  40;
    24;,  "arbok",       650,  35, T_POISON,   T_NONE,      60,  85,  69,  80,  65;
    25;,  "pikachu",     60,   4,  T_ELECTRIC, T_NONE,      35,  55,  30,  90,  50;
    26;,  "raichu",      300,  8,  T_ELECTRIC, T_NONE,      60,  90,  55,  100, 90;
    27;,  "sandshrew",   120,  6,  T_GROUND,   T_NONE,      50,  75,  85,  40,  30;
    28;,  "sandslash",   295,  10, T_GROUND,   T_NONE,      75,  100, 110, 65,  55;
    29;,  "nidoran?",    70,   4,  T_POISON,   T_NONE,      55,  47,  52,  41,  40;
    30;,  "nidorina",    200,  8,  T_POISON,   T_NONE,      70,  62,  67,  56,  55;
    31;,  "nidoqueen",   600,  13, T_POISON,   T_GROUND,    90,  82,  87,  76,  75;
    32;,  "nidoran!",    90,   5,  T_POISON,   T_NONE,      46,  57,  40,  50,  40;
    33;,  "nidorino",    195,  9,  T_POISON,   T_NONE,      61,  72,  57,  65,  55;
    34;,  "nidoking",    620,  14, T_POISON,   T_GROUND,    81,  92,  77,  85,  75;
    35;,  "clefairy",    75,   6,  T_NORMAL,   T_NONE,      70,  45,  48,  35,  60;
    36;,  "clefable",    400,  13, T_NORMAL,   T_NONE,      95,  70,  73,  60,  85;
    37;,  "vulpix",      99,   6,  T_FIRE,     T_NONE,      38,  41,  40,  65,  65;
    38;,  "ninetales",   199,  11, T_FIRE,     T_NONE,      73,  76,  75,  100, 100;
    39;,  "jigglypuff",  55,   5,  T_NORMAL,   T_NONE,      115, 45,  20,  20,  25;
    40;,  "wigglytuff",  120,  10, T_NORMAL,   T_NONE,      140, 70,  45,  45,  50;
    41;,  "zubat",       75,   8,  T_POISON,   T_FLYING,    40,  45,  35,  55,  40;
    42;,  "golbat",      550,  16, T_POISON,   T_FLYING,    75,  80,  70,  90,  75;
    43;,  "oddish",      54,   5,  T_GRASS,    T_POISON,    45,  50,  55,  30,  75;
    44;,  "gloom",       86,   8,  T_GRASS,    T_POISON,    60,  65,  70,  40,  85;
    45;,  "vileplume",   186,  12, T_GRASS,    T_POISON,    75,  80,  85,  50,  100;
    46;,  "paras",       54,   3,  T_BUG,      T_GRASS,     35,  70,  55,  25,  55;
    47;,  "parasect",    295,  10, T_BUG,      T_GRASS,     60,  95,  80,  30,  80;
    48;,  "venonat",     300,  10, T_BUG,      T_POISON,    60,  55,  50,  45,  40;
    49;,  "venomoth",    125,  15, T_BUG,      T_POISON,    70,  65,  60,  90,  90;
    50;,  "diglett",     8,    2,  T_GROUND,   T_NONE,      10,  55,  25,  95,  45;
    51;,  "dugtrio",     333,  7,  T_GROUND,   T_NONE,      35,  80,  50,  120, 70;
    52;,  "meowth",      42,   4,  T_NORMAL,   T_NONE,      40,  45,  35,  90,  40;
    53;,  "persian",     320,  10, T_NORMAL,   T_NONE,      65,  70,  60,  115, 65;
    54;,  "psyduck",     196,  8,  T_WATER,    T_NONE,      50,  52,  48,  55,  50;
    55;,  "golduck",     766,  17, T_WATER,    T_NONE,      80,  82,  78,  85,  80;
    56;,  "mankey",      280,  5,  T_FIGHTING, T_NONE,      40,  80,  35,  70,  35;
    57;,  "primeape",    320,  10, T_FIGHTING, T_NONE,      65,  105, 60,  95,  60;
    58;,  "growlithe",   190,  7,  T_FIRE,     T_NONE,      55,  70,  45,  60,  50;
    59;,  "arcanine",    1550, 19, T_FIRE,     T_NONE,      90,  110, 80,  95,  80;
    60;,  "poliwag",     124,  6,  T_WATER,    T_NONE,      40,  50,  40,  90,  40;
    61;,  "poliwhirl",   200,  10, T_WATER,    T_NONE,      65,  65,  65,  90,  50;
    62;,  "poliwrath",   540,  13, T_WATER,    T_FIGHTING,  90,  85,  95,  70,  70;
    63;,  "abra",        195,  9,  T_PSYCHIC,  T_NONE,      25,  20,  15,  90,  105;
    64;,  "kadabra",     565,  13, T_PSYCHIC,  T_NONE,      40,  35,  30,  105, 120;
    65;,  "alakazam",    480,  15, T_PSYCHIC,  T_NONE,      55,  50,  45,  120, 135;
    66;,  "machop",      195,  8,  T_FIGHTING, T_NONE,      70,  80,  50,  35,  35;
    67;,  "machoke",     705,  15, T_FIGHTING, T_NONE,      80,  100, 70,  45,  50;
    68;,  "machamp",     1300, 16, T_FIGHTING, T_NONE,      90,  130, 80,  55,  65;
    69;,  "bellsprout",  40,   7,  T_GRASS,    T_POISON,    50,  75,  35,  40,  70;
    70;,  "weepinbell",  64,   10, T_GRASS,    T_POISON,    65,  90,  50,  55,  85;
    71;,  "victreebel",  155,  17, T_GRASS,    T_POISON,    80,  105, 65,  70,  100;
    72;,  "tentacool",   455,  9,  T_WATER,    T_POISON,    40,  40,  35,  70,  100;
    73;,  "tentacruel",  550,  16, T_WATER,    T_POISON,    80,  70,  65,  100, 120;
    74;,  "geodude",     200,  4,  T_ROCK,     T_GROUND,    40,  80,  100, 20,  30;
    75;,  "graveler",    1050, 10, T_ROCK,     T_GROUND,    55,  95,  115, 35,  45;
    76;,  "golem",       3000, 14, T_ROCK,     T_GROUND,    80,  110, 130, 45,  55;
    77;,  "ponyta",      300,  10, T_FIRE,     T_NONE,      50,  85,  55,  90,  65;
    78;,  "rapidash",    950,  17, T_FIRE,     T_NONE,      65,  100, 70,  105, 80;
    79;,  "slowpoke",    360,  12, T_WATER,    T_PSYCHIC,   90,  65,  65,  15,  40;
    80;,  "slowbro",     785,  16, T_WATER,    T_PSYCHIC,   95,  75,  110, 30,  80;
    81;,  "magnemite",   60,   3,  T_ELECTRIC, T_NONE,      25,  35,  70,  45,  95;
    82;,  "magneton",    600,  10, T_ELECTRIC, T_NONE,      50,  60,  95,  70,  120;
    83;,  "farfetch'd",  150,  8,  T_NORMAL,   T_FLYING,    52,  65,  55,  60,  58;
    84;,  "doduo",       392,  14, T_NORMAL,   T_FLYING,    35,  85,  45,  75,  35;
    85;,  "dodrio",      852,  18, T_NORMAL,   T_FLYING,    60,  110, 70,  100, 60;
    86;,  "seel",        900,  11, T_WATER,    T_NONE,      65,  45,  55,  45,  70;
    87;,  "dewgong",     1200, 17, T_WATER,    T_ICE,       90,  70,  80,  70,  95;
    88;,  "grimer",      300,  9,  T_POISON,   T_NONE,      80,  80,  50,  25,  40;
    89;,  "muk",         300,  12, T_POISON,   T_NONE,      105, 105, 75,  50,  65;
    90;,  "shellder",    40,   3,  T_WATER,    T_NONE,      30,  65,  100, 40,  45;
    91;,  "cloyster",    1325, 15, T_WATER,    T_ICE,       50,  95,  180, 70,  85;
    92;,  "gastly",      1,    13, T_GHOST,    T_POISON,    30,  35,  30,  80,  100;
    93;,  "haunter",     1,    16, T_GHOST,    T_POISON,    45,  50,  45,  95,  115;
    94;,  "gengar",      405,  15, T_GHOST,    T_POISON,    60,  65,  60,  110, 130;
    95;,  "onix",        2100, 88, T_ROCK,     T_GROUND,    35,  45,  160, 70,  30;
    96;,  "drowzee",     324,  10, T_PSYCHIC,  T_NONE,      60,  48,  45,  42,  90;
    97;,  "hypno",       756,  16, T_PSYCHIC,  T_NONE,      85,  73,  70,  67,  115;
    98;,  "krabby",      65,   4,  T_WATER,    T_NONE,      30,  105, 90,  50,  25;
    99;,  "kingler",     600,  13, T_WATER,    T_NONE,      55,  130, 115, 75,  50;
    100;, "voltorb",     104,  5,  T_ELECTRIC, T_NONE,      40,  30,  50,  100, 55;
    101;, "electrode",   666,  12, T_ELECTRIC, T_NONE,      60,  50,  70,  140, 80;
    102;, "exeggcute",   25,   4,  T_GRASS,    T_PSYCHIC,   60,  40,  80,  40,  60;
    103;, "exeggutor",   1200, 20, T_GRASS,    T_PSYCHIC,   95,  95,  85,  55,  125;
    104;, "cubone",      65,   4,  T_GROUND,   T_NONE,      50,  50,  95,  35,  40;
    105;, "marowak",     450,  10, T_GROUND,   T_NONE,      60,  80,  110, 45,  50;
    106;, "hitmonlee",   498,  15, T_FIGHTING, T_NONE,      50,  120, 53,  87,  35;
    107;, "hitmonchan",  502,  14, T_FIGHTING, T_NONE,      50,  105, 79,  76,  35;
    108;, "lickitung",   655,  12, T_NORMAL,   T_NONE,      90,  55,  75,  30,  60;
    109;, "koffing",     10,   6,  T_POISON,   T_NONE,      40,  65,  95,  35,  60;
    110;, "weezing",     95,   12, T_POISON,   T_NONE,      65,  90,  120, 60,  85;
    111;, "rhyhorn",     1150, 10, T_GROUND,   T_ROCK,      80,  85,  95,  25,  30;
    112;, "rhydon",      1200, 19, T_GROUND,   T_ROCK,      105, 130, 120, 40,  45;
    113;, "chansey",     346,  11, T_NORMAL,   T_NONE,      250, 5,   5,   50,  105;
    114;, "tangela",     350,  10, T_GRASS,    T_NONE,      65,  55,  115, 60,  100;
    115;, "kangaskhan",  800,  22, T_NORMAL,   T_NONE,      105, 95,  80,  90,  40;
    116;, "horsea",      80,   4,  T_WATER,    T_NONE,      30,  40,  70,  60,  70;
    117;, "seadra",      250,  12, T_WATER,    T_NONE,      55,  65,  95,  85,  95;
    118;, "goldeen",     150,  6,  T_WATER,    T_NONE,      45,  67,  60,  63,  50;
    119;, "seaking",     390,  13, T_WATER,    T_NONE,      80,  92,  65,  68,  80;
    120;, "staryu",      345,  8,  T_WATER,    T_NONE,      30,  45,  55,  85,  70;
    121;, "starmie",     800,  11, T_WATER,    T_PSYCHIC,   60,  75,  85,  115, 100;
    122;, "mr mime",     545,  13, T_PSYCHIC,  T_NONE,      40,  45,  65,  90,  100;
    123;, "scyther",     560,  15, T_BUG,      T_FLYING,    70,  110, 80,  105, 55;
    124;, "jynx",        406,  14, T_ICE,      T_PSYCHIC,   65,  50,  35,  95,  95;
    125;, "electabuzz",  300,  11, T_ELECTRIC, T_NONE,      65,  83,  57,  105, 85;
    126;, "magmar",      445,  13, T_FIRE,     T_NONE,      65,  95,  57,  93,  85;
    127;, "pinsir",      550,  15, T_BUG,      T_NONE,      65,  125, 100, 85,  55;
    128;, "tauros",      884,  14, T_NORMAL,   T_NONE,      75,  100, 95,  110, 70;
    129;, "magikarp",    100,  9,  T_WATER,    T_NONE,      20,  10,  55,  80,  20;
    130;, "gyarados",    2350, 65, T_WATER,    T_FLYING,    95,  125, 79,  81,  100;
    131;, "lapras",      2200, 25, T_WATER,    T_ICE,       130, 85,  80,  60,  95;
    132;, "ditto",       40,   3,  T_NORMAL,   T_NONE,      48,  48,  48,  48,  48;
    133;, "eevee",       65,   3,  T_NORMAL,   T_NONE,      55,  55,  50,  55,  65;
    134;, "vaporeon",    290,  10, T_WATER,    T_NONE,      130, 65,  60,  65,  110;
    135;, "jolteon",     245,  8,  T_ELECTRIC, T_NONE,      65,  65,  60,  130, 110;
    136;, "flareon",     250,  9,  T_FIRE,     T_NONE,      65,  130, 60,  65,  110;
    137;, "porygon",     365,  8,  T_NORMAL,   T_NONE,      65,  60,  70,  40,  75;
    138;, "omanyte",     75,   4,  T_ROCK,     T_WATER,     35,  40,  100, 35,  90;
    139;, "omastar",     350,  10, T_ROCK,     T_WATER,     70,  60,  125, 55,  115;
    140;, "kabuto",      115,  5,  T_ROCK,     T_WATER,     30,  80,  90,  55,  45;
    141;, "kabutops",    405,  13, T_ROCK,     T_WATER,     60,  115, 105, 80,  70;
    142;, "aerodactyl",  590,  18, T_ROCK,     T_FLYING,    80,  105, 65,  130, 60;
    143;, "snorlax",     4600, 21, T_NORMAL,   T_NONE,      160, 110, 65,  30,  65;
    144;, "articuno",    554,  17, T_ICE,      T_FLYING,    90,  85,  100, 85,  125;
    145;, "zapdos",      526,  16, T_ELECTRIC, T_FLYING,    90,  90,  85,  100, 125;
    146;, "moltres",     600,  20, T_FIRE,     T_FLYING,    90,  100, 90,  90,  125;
    147;, "dratini",     33,   18, T_DRAGON,   T_NONE,      41,  64,  45,  50,  50;
    148;, "dragonair",   165,  40, T_DRAGON,   T_NONE,      61,  84,  65,  70,  70;
    149;, "dragonite",   2100, 22, T_DRAGON,   T_FLYING,    91,  134, 95,  80,  100;
    150;, "mewtwo",      1220, 20, T_PSYCHIC,  T_NONE,      106, 110, 90,  130, 154;
    151;, "mew",         40,   4,  T_PSYCHIC,  T_NONE,      100, 100, 100, 100, 100;
]]

for i=0,151 do
    c_pokemon[i] = {
        name       = c_pokemon[i][1],
        width      = c_pokemon[i][2],
        height     = c_pokemon[i][3],
        type1      = c_pokemon[i][4],
        type2      = c_pokemon[i][5],
        hp         = c_pokemon[i][6],
        attack     = c_pokemon[i][7],
        defence    = c_pokemon[i][8],
        speed      = c_pokemon[i][9],
        special    = c_pokemon[i][10]
    }
end

-- includes type effectiveness chart. according to the gen 1 games, which had bugs. i'm keeping the bugs :).
c_types = zobj[[
    T_NORMAL;   bg,0, name,"normal",   T_NORMAL;   good;,;                                  T_NORMAL;   null;,T_GHOST;            T_NORMAL;   weak;,T_ROCK;
    T_FIRE;     bg,5, name,"fire",     T_FIRE;     good;,T_GRASS,T_ICE,T_BUG;               T_FIRE;     null;,;                   T_FIRE;     weak;,T_FIRE,T_WATER,T_ROCK,T_DRAGON;
    T_WATER;    bg,4, name,"water",    T_WATER;    good;,T_FIRE,T_GROUND,T_ROCK;            T_WATER;    null;,;                   T_WATER;    weak;,T_DRAGON,T_GRASS,T_WATER;
    T_ELECTRIC; bg,6, name,"electric", T_ELECTRIC; good;,T_FLYING,T_WATER;                  T_ELECTRIC; null;,T_GROUND;           T_ELECTRIC; weak;,T_DRAGON,T_ELECTRIC,T_GRASS;
    T_GRASS;    bg,3, name,"grass",    T_GRASS;    good;,T_GROUND,T_ROCK,T_WATER;           T_GRASS;    null;,;                   T_GRASS;    weak;,T_BUG,T_DRAGON,T_FIRE,T_FLYING,T_GRASS,T_POISON;
    T_ICE;      bg,4, name,"ice",      T_ICE;      good;,T_DRAGON,T_FLYING,T_GRASS;         T_ICE;      null;,;                   T_ICE;      weak;,T_FIRE,T_ICE,T_WATER;
    T_FIGHTING; bg,2, name,"fighting", T_FIGHTING; good;,T_ICE,T_NORMAL,T_ROCK;             T_FIGHTING; null;,T_GHOST;            T_FIGHTING; weak;,T_BUG,T_FLYING,T_POISON,T_PSYCHIC;
    T_POISON;   bg,1, name,"poison",   T_POISON;   good;,T_BUG,T_GRASS;                     T_POISON;   null;,;                   T_POISON;   weak;,T_GHOST,T_GROUND,T_POISON,T_ROCK;
    T_GROUND;   bg,2, name,"ground",   T_GROUND;   good;,T_ELECTRIC,T_FIRE,T_POISON,T_ROCK; T_GROUND;   null;,T_FLYING;           T_GROUND;   weak;,T_BUG,T_GRASS;
    T_FLYING;   bg,0, name,"flying",   T_FLYING;   good;,T_BUG,T_FIGHTING,T_GRASS;          T_FLYING;   null;,;                   T_FLYING;   weak;,T_ELECTRIC,T_ROCK;
    T_PSYCHIC;  bg,1, name,"psychic",  T_PSYCHIC;  good;,T_FIGHTING,T_POISON;               T_PSYCHIC;  null;,;                   T_PSYCHIC;  weak;,T_PSYCHIC;
    T_BUG;      bg,3, name,"bug",      T_BUG;      good;,T_GRASS,T_PSYCHIC;                 T_BUG;      null;,;                   T_BUG;      weak;,T_FIGHTING,T_FIRE,T_FLYING,T_GHOST,T_POISON;
    T_ROCK;     bg,0, name,"rock",     T_ROCK;     good;,T_BUG,T_FIRE,T_FLYING,T_ICE;       T_ROCK;     null;,;                   T_ROCK;     weak;,T_FIGHTING,T_GROUND;
    T_GHOST;    bg,1, name,"ghost",    T_GHOST;    good;,T_GHOST;                           T_GHOST;    null;,T_NORMAL,T_PSYCHIC; T_GHOST;    weak;,;
    T_DRAGON;   bg,0, name,"dragon",   T_DRAGON;   good;,T_DRAGON;                          T_DRAGON;   null;,;                   T_DRAGON;   weak;,;
    T_BIRD;     bg,0, name,"bird",     T_BIRD;     good;,;                                  T_BIRD;     null;,;                   T_BIRD;     weak;,;
]]

-- 5 bg styles
c_bg_styles = zobj[[
    0;bg,6,  aa,13; -- normal
    1;bg,13, aa,5;  -- darker/psychic/poison/ghost
    2;bg,9,  aa,4;  -- electric/ground
    3;bg,11, aa,3;  -- grass
    4;bg,12, aa,5;  -- water
    5;bg,8,  aa,2;  -- fire
    6;bg,10, aa,4;  -- electric/ground
]]

c_zmovetype = zobj[[
    0; name,"status";
    1; name,"physical";
    2; name,"special";
]]

c_moves = zobj[[
    0;   name,"struggle",       t,T_NORMAL,     z,Z_PHYSICAL,  p,-,     d,50,   a,—   ;
    1;   name,"pound",          t,T_NORMAL,     z,Z_PHYSICAL,  p,35,    d,40,   a,1   ;
    2;   name,"karate-chop",    t,T_FIGHTING,   z,Z_PHYSICAL,  p,25,    d,50,   a,1   ;
    3;   name,"double-slap",    t,T_NORMAL,     z,Z_PHYSICAL,  p,10,    d,15,   a,.85 ;
    4;   name,"comet-punch",    t,T_NORMAL,     z,Z_PHYSICAL,  p,15,    d,18,   a,.85 ;
    5;   name,"mega-punch",     t,T_NORMAL,     z,Z_PHYSICAL,  p,20,    d,80,   a,.85 ;
    6;   name,"pay-day",        t,T_NORMAL,     z,Z_PHYSICAL,  p,20,    d,40,   a,1   ;
    7;   name,"fire-punch",     t,T_FIRE,       z,Z_PHYSICAL,  p,15,    d,75,   a,1   ;
    8;   name,"ice-punch",      t,T_ICE,        z,Z_PHYSICAL,  p,15,    d,75,   a,1   ;
    9;   name,"thunder-punch",  t,T_ELECTRIC,   z,Z_PHYSICAL,  p,15,    d,75,   a,1   ;
    10;  name,"scratch",        t,T_NORMAL,     z,Z_PHYSICAL,  p,35,    d,40,   a,1   ;
    11;  name,"vice-grip",      t,T_NORMAL,     z,Z_PHYSICAL,  p,30,    d,55,   a,1   ;
    12;  name,"guillotine",     t,T_NORMAL,     z,Z_PHYSICAL,  p,5,     d,—,    a,.3  ;
    13;  name,"razor-wind",     t,T_NORMAL,     z,Z_SPECIAL,   p,10,    d,80,   a,1   ;
    14;  name,"swords-dance",   t,T_NORMAL,     z,Z_STATUS,    p,20,    d,—,    a,—   ;
    15;  name,"cut",            t,T_NORMAL,     z,Z_PHYSICAL,  p,30,    d,50,   a,.95 ;
    16;  name,"gust",           t,T_FLYING,     z,Z_SPECIAL,   p,35,    d,40,   a,1   ;
    17;  name,"wing-attack",    t,T_FLYING,     z,Z_PHYSICAL,  p,35,    d,60,   a,1   ;
    18;  name,"whirlwind",      t,T_NORMAL,     z,Z_STATUS,    p,20,    d,—,    a,—   ;
    19;  name,"fly",            t,T_FLYING,     z,Z_PHYSICAL,  p,15,    d,90,   a,.95 ;
    20;  name,"bind",           t,T_NORMAL,     z,Z_PHYSICAL,  p,20,    d,15,   a,.85 ;
    21;  name,"slam",           t,T_NORMAL,     z,Z_PHYSICAL,  p,20,    d,80,   a,.75 ;
    22;  name,"vine-whip",      t,T_GRASS,      z,Z_PHYSICAL,  p,25,    d,45,   a,1   ;
    23;  name,"stomp",          t,T_NORMAL,     z,Z_PHYSICAL,  p,20,    d,65,   a,1   ;
    24;  name,"double-kick",    t,T_FIGHTING,   z,Z_PHYSICAL,  p,30,    d,30,   a,1   ;
    25;  name,"mega-kick",      t,T_NORMAL,     z,Z_PHYSICAL,  p,5,     d,120,  a,.75 ;
    26;  name,"jump-kick",      t,T_FIGHTING,   z,Z_PHYSICAL,  p,10,    d,100,  a,.95 ;
    27;  name,"rolling-kick",   t,T_FIGHTING,   z,Z_PHYSICAL,  p,15,    d,60,   a,.85 ;
    28;  name,"sand-attack",    t,T_GROUND,     z,Z_STATUS,    p,15,    d,—,    a,1   ;
    29;  name,"headbutt",       t,T_NORMAL,     z,Z_PHYSICAL,  p,15,    d,70,   a,1   ;
    30;  name,"horn-attack",    t,T_NORMAL,     z,Z_PHYSICAL,  p,25,    d,65,   a,1   ;
    31;  name,"fury-attack",    t,T_NORMAL,     z,Z_PHYSICAL,  p,20,    d,15,   a,.85 ;
    32;  name,"horn-drill",     t,T_NORMAL,     z,Z_PHYSICAL,  p,5,     d,—,    a,.3  ;
    33;  name,"tackle",         t,T_NORMAL,     z,Z_PHYSICAL,  p,35,    d,40,   a,1   ;
    34;  name,"body-slam",      t,T_NORMAL,     z,Z_PHYSICAL,  p,15,    d,85,   a,1   ;
    35;  name,"wrap",           t,T_NORMAL,     z,Z_PHYSICAL,  p,20,    d,15,   a,.9  ;
    36;  name,"take-down",      t,T_NORMAL,     z,Z_PHYSICAL,  p,20,    d,90,   a,.85 ;
    37;  name,"thrash",         t,T_NORMAL,     z,Z_PHYSICAL,  p,10,    d,120,  a,1   ;
    38;  name,"double-edge",    t,T_NORMAL,     z,Z_PHYSICAL,  p,15,    d,120,  a,1   ;
    39;  name,"tail-whip",      t,T_NORMAL,     z,Z_STATUS,    p,30,    d,—,    a,1   ;
    40;  name,"poison-sting",   t,T_POISON,     z,Z_PHYSICAL,  p,35,    d,15,   a,1   ;
    41;  name,"twineedle",      t,T_BUG,        z,Z_PHYSICAL,  p,20,    d,25,   a,1   ;
    42;  name,"pin-missile",    t,T_BUG,        z,Z_PHYSICAL,  p,20,    d,25,   a,.95 ;
    43;  name,"leer",           t,T_NORMAL,     z,Z_STATUS,    p,30,    d,—,    a,1   ;
    44;  name,"bite",           t,T_NORMAL,     z,Z_PHYSICAL,  p,25,    d,60,   a,1   ;
    45;  name,"growl",          t,T_NORMAL,     z,Z_STATUS,    p,40,    d,—,    a,1   ;
    46;  name,"roar",           t,T_NORMAL,     z,Z_STATUS,    p,20,    d,—,    a,—   ;
    47;  name,"sing",           t,T_NORMAL,     z,Z_STATUS,    p,15,    d,—,    a,.55 ;
    48;  name,"supersonic",     t,T_NORMAL,     z,Z_STATUS,    p,20,    d,—,    a,.55 ;
    49;  name,"sonic-boom",     t,T_NORMAL,     z,Z_SPECIAL,   p,20,    d,—,    a,.9  ;
    50;  name,"disable",        t,T_NORMAL,     z,Z_STATUS,    p,20,    d,—,    a,1   ;
    51;  name,"acid",           t,T_POISON,     z,Z_SPECIAL,   p,30,    d,40,   a,1   ;
    52;  name,"ember",          t,T_FIRE,       z,Z_SPECIAL,   p,25,    d,40,   a,1   ;
    53;  name,"flamethrower",   t,T_FIRE,       z,Z_SPECIAL,   p,15,    d,90,   a,1   ;
    54;  name,"mist",           t,T_ICE,        z,Z_STATUS,    p,30,    d,—,    a,—   ;
    55;  name,"water-gun",      t,T_WATER,      z,Z_SPECIAL,   p,25,    d,40,   a,1   ;
    56;  name,"hydro-pump",     t,T_WATER,      z,Z_SPECIAL,   p,5,     d,110,  a,.8  ;
    57;  name,"surf",           t,T_WATER,      z,Z_SPECIAL,   p,15,    d,90,   a,1   ;
    58;  name,"ice-beam",       t,T_ICE,        z,Z_SPECIAL,   p,10,    d,90,   a,1   ;
    59;  name,"blizzard",       t,T_ICE,        z,Z_SPECIAL,   p,5,     d,110,  a,.7  ;
    60;  name,"psybeam",        t,T_PSYCHIC,    z,Z_SPECIAL,   p,20,    d,65,   a,1   ;
    61;  name,"bubble-beam",    t,T_WATER,      z,Z_SPECIAL,   p,20,    d,65,   a,1   ;
    62;  name,"aurora-beam",    t,T_ICE,        z,Z_SPECIAL,   p,20,    d,65,   a,1   ;
    63;  name,"hyper-beam",     t,T_NORMAL,     z,Z_SPECIAL,   p,5,     d,150,  a,.9  ;
    64;  name,"peck",           t,T_FLYING,     z,Z_PHYSICAL,  p,35,    d,35,   a,1   ;
    65;  name,"drill-peck",     t,T_FLYING,     z,Z_PHYSICAL,  p,20,    d,80,   a,1   ;
    66;  name,"submission",     t,T_FIGHTING,   z,Z_PHYSICAL,  p,20,    d,80,   a,.8  ;
    67;  name,"low-kick",       t,T_FIGHTING,   z,Z_PHYSICAL,  p,20,    d,—,    a,1   ;
    68;  name,"counter",        t,T_FIGHTING,   z,Z_PHYSICAL,  p,20,    d,—,    a,1   ;
    69;  name,"seismic-toss",   t,T_FIGHTING,   z,Z_PHYSICAL,  p,20,    d,—,    a,1   ;
    70;  name,"strength",       t,T_NORMAL,     z,Z_PHYSICAL,  p,15,    d,80,   a,1   ;
    71;  name,"absorb",         t,T_GRASS,      z,Z_SPECIAL,   p,25,    d,20,   a,1   ;
    72;  name,"mega-drain",     t,T_GRASS,      z,Z_SPECIAL,   p,15,    d,40,   a,1   ;
    73;  name,"leech-seed",     t,T_GRASS,      z,Z_STATUS,    p,10,    d,—,    a,.9  ;
    74;  name,"growth",         t,T_NORMAL,     z,Z_STATUS,    p,20,    d,—,    a,—   ;
    75;  name,"razor-leaf",     t,T_GRASS,      z,Z_PHYSICAL,  p,25,    d,55,   a,.95 ;
    76;  name,"solar-beam",     t,T_GRASS,      z,Z_SPECIAL,   p,10,    d,120,  a,1   ;
    77;  name,"poison-powder",  t,T_POISON,     z,Z_STATUS,    p,35,    d,—,    a,.75 ;
    78;  name,"stun-spore",     t,T_GRASS,      z,Z_STATUS,    p,30,    d,—,    a,.75 ;
    79;  name,"sleep-powder",   t,T_GRASS,      z,Z_STATUS,    p,15,    d,—,    a,.75 ;
    80;  name,"petal-dance",    t,T_GRASS,      z,Z_SPECIAL,   p,10,    d,120,  a,1   ;
    81;  name,"string-shot",    t,T_BUG,        z,Z_STATUS,    p,40,    d,—,    a,.95 ;
    82;  name,"dragon-rage",    t,T_DRAGON,     z,Z_SPECIAL,   p,10,    d,—,    a,1   ;
    83;  name,"fire-spin",      t,T_FIRE,       z,Z_SPECIAL,   p,15,    d,35,   a,.85 ;
    84;  name,"thunder-shock",  t,T_ELECTRIC,   z,Z_SPECIAL,   p,30,    d,40,   a,1   ;
    85;  name,"thunderbolt",    t,T_ELECTRIC,   z,Z_SPECIAL,   p,15,    d,90,   a,1   ;
    86;  name,"thunder-wave",   t,T_ELECTRIC,   z,Z_STATUS,    p,20,    d,—,    a,.9  ;
    87;  name,"thunder",        t,T_ELECTRIC,   z,Z_SPECIAL,   p,10,    d,110,  a,.7  ;
    88;  name,"rock-throw",     t,T_ROCK,       z,Z_PHYSICAL,  p,15,    d,50,   a,.9  ;
    89;  name,"earthquake",     t,T_GROUND,     z,Z_PHYSICAL,  p,10,    d,100,  a,1   ;
    90;  name,"fissure",        t,T_GROUND,     z,Z_PHYSICAL,  p,5,     d,—,    a,.3  ;
    91;  name,"dig",            t,T_GROUND,     z,Z_PHYSICAL,  p,10,    d,80,   a,1   ;
    92;  name,"toxic",          t,T_POISON,     z,Z_STATUS,    p,10,    d,—,    a,.9  ;
    93;  name,"confusion",      t,T_PSYCHIC,    z,Z_SPECIAL,   p,25,    d,50,   a,1   ;
    94;  name,"psychic",        t,T_PSYCHIC,    z,Z_SPECIAL,   p,10,    d,90,   a,1   ;
    95;  name,"hypnosis",       t,T_PSYCHIC,    z,Z_STATUS,    p,20,    d,—,    a,.6  ;
    96;  name,"meditate",       t,T_PSYCHIC,    z,Z_STATUS,    p,40,    d,—,    a,—   ;
    97;  name,"agility",        t,T_PSYCHIC,    z,Z_STATUS,    p,30,    d,—,    a,—   ;
    98;  name,"quick-attack",   t,T_NORMAL,     z,Z_PHYSICAL,  p,30,    d,40,   a,1   ;
    99;  name,"rage",           t,T_NORMAL,     z,Z_PHYSICAL,  p,20,    d,20,   a,1   ;
    100; name,"teleport",       t,T_PSYCHIC,    z,Z_STATUS,    p,20,    d,—,    a,—   ;
    101; name,"night-shade",    t,T_GHOST,      z,Z_SPECIAL,   p,15,    d,—,    a,1   ;
    102; name,"mimic",          t,T_NORMAL,     z,Z_STATUS,    p,10,    d,—,    a,—   ;
    103; name,"screech",        t,T_NORMAL,     z,Z_STATUS,    p,40,    d,—,    a,.85 ;
    104; name,"double-team",    t,T_NORMAL,     z,Z_STATUS,    p,15,    d,—,    a,—   ;
    105; name,"recover",        t,T_NORMAL,     z,Z_STATUS,    p,5,     d,—,    a,—   ;
    106; name,"harden",         t,T_NORMAL,     z,Z_STATUS,    p,30,    d,—,    a,—   ;
    107; name,"minimize",       t,T_NORMAL,     z,Z_STATUS,    p,10,    d,—,    a,—   ;
    108; name,"smokescreen",    t,T_NORMAL,     z,Z_STATUS,    p,20,    d,—,    a,1   ;
    109; name,"confuse-ray",    t,T_GHOST,      z,Z_STATUS,    p,10,    d,—,    a,1   ;
    110; name,"withdraw",       t,T_WATER,      z,Z_STATUS,    p,40,    d,—,    a,—   ;
    111; name,"defense-curl",   t,T_NORMAL,     z,Z_STATUS,    p,40,    d,—,    a,—   ;
    112; name,"barrier",        t,T_PSYCHIC,    z,Z_STATUS,    p,20,    d,—,    a,—   ;
    113; name,"light-screen",   t,T_PSYCHIC,    z,Z_STATUS,    p,30,    d,—,    a,—   ;
    114; name,"haze",           t,T_ICE,        z,Z_STATUS,    p,30,    d,—,    a,—   ;
    115; name,"reflect",        t,T_PSYCHIC,    z,Z_STATUS,    p,20,    d,—,    a,—   ;
    116; name,"focus-energy",   t,T_NORMAL,     z,Z_STATUS,    p,30,    d,—,    a,—   ;
    117; name,"bide",           t,T_NORMAL,     z,Z_PHYSICAL,  p,10,    d,—,    a,—   ;
    118; name,"metronome",      t,T_NORMAL,     z,Z_STATUS,    p,10,    d,—,    a,—   ;
    119; name,"mirror-move",    t,T_FLYING,     z,Z_STATUS,    p,20,    d,—,    a,—   ;
    120; name,"self-destruct",  t,T_NORMAL,     z,Z_PHYSICAL,  p,5,     d,200,  a,1   ;
    121; name,"egg-bomb",       t,T_NORMAL,     z,Z_PHYSICAL,  p,10,    d,100,  a,.75 ;
    122; name,"lick",           t,T_GHOST,      z,Z_PHYSICAL,  p,30,    d,30,   a,1   ;
    123; name,"smog",           t,T_POISON,     z,Z_SPECIAL,   p,20,    d,30,   a,.7  ;
    124; name,"sludge",         t,T_POISON,     z,Z_SPECIAL,   p,20,    d,65,   a,1   ;
    125; name,"bone-club",      t,T_GROUND,     z,Z_PHYSICAL,  p,20,    d,65,   a,.85 ;
    126; name,"fire-blast",     t,T_FIRE,       z,Z_SPECIAL,   p,5,     d,110,  a,.85 ;
    127; name,"waterfall",      t,T_WATER,      z,Z_PHYSICAL,  p,15,    d,80,   a,1   ;
    128; name,"clamp",          t,T_WATER,      z,Z_PHYSICAL,  p,15,    d,35,   a,.85 ;
    129; name,"swift",          t,T_NORMAL,     z,Z_SPECIAL,   p,20,    d,60,   a,—   ;
    130; name,"skull-bash",     t,T_NORMAL,     z,Z_PHYSICAL,  p,10,    d,130,  a,1   ;
    131; name,"spike-cannon",   t,T_NORMAL,     z,Z_PHYSICAL,  p,15,    d,20,   a,1   ;
    132; name,"constrict",      t,T_NORMAL,     z,Z_PHYSICAL,  p,35,    d,10,   a,1   ;
    133; name,"amnesia",        t,T_PSYCHIC,    z,Z_STATUS,    p,20,    d,—,    a,—   ;
    134; name,"kinesis",        t,T_PSYCHIC,    z,Z_STATUS,    p,15,    d,—,    a,.8  ;
    135; name,"soft-boiled",    t,T_NORMAL,     z,Z_STATUS,    p,5,     d,—,    a,—   ;
    136; name,"high-jump-kick", t,T_FIGHTING,   z,Z_PHYSICAL,  p,10,    d,130,  a,.9  ;
    137; name,"glare",          t,T_NORMAL,     z,Z_STATUS,    p,30,    d,—,    a,1   ;
    138; name,"dream-eater",    t,T_PSYCHIC,    z,Z_SPECIAL,   p,15,    d,100,  a,1   ;
    139; name,"poison-gas",     t,T_POISON,     z,Z_STATUS,    p,40,    d,—,    a,.9  ;
    140; name,"barrage",        t,T_NORMAL,     z,Z_PHYSICAL,  p,20,    d,15,   a,.85 ;
    141; name,"leech-life",     t,T_BUG,        z,Z_PHYSICAL,  p,10,    d,80,   a,1   ;
    142; name,"lovely-kiss",    t,T_NORMAL,     z,Z_STATUS,    p,10,    d,—,    a,.75 ;
    143; name,"sky-attack",     t,T_FLYING,     z,Z_PHYSICAL,  p,5,     d,140,  a,.9  ;
    144; name,"transform",      t,T_NORMAL,     z,Z_STATUS,    p,10,    d,—,    a,—   ;
    145; name,"bubble",         t,T_WATER,      z,Z_SPECIAL,   p,30,    d,40,   a,1   ;
    146; name,"dizzy-punch",    t,T_NORMAL,     z,Z_PHYSICAL,  p,10,    d,70,   a,1   ;
    147; name,"spore",          t,T_GRASS,      z,Z_STATUS,    p,15,    d,—,    a,1   ;
    148; name,"flash",          t,T_NORMAL,     z,Z_STATUS,    p,20,    d,—,    a,1   ;
    149; name,"psywave",        t,T_PSYCHIC,    z,Z_SPECIAL,   p,15,    d,—,    a,1   ;
    150; name,"splash",         t,T_NORMAL,     z,Z_STATUS,    p,40,    d,—,    a,—   ;
    151; name,"acid-armor",     t,T_POISON,     z,Z_STATUS,    p,20,    d,—,    a,—   ;
    152; name,"crabhammer",     t,T_WATER,      z,Z_PHYSICAL,  p,10,    d,100,  a,.9  ;
    153; name,"explosion",      t,T_NORMAL,     z,Z_PHYSICAL,  p,5,     d,250,  a,1   ;
    154; name,"fury-swipes",    t,T_NORMAL,     z,Z_PHYSICAL,  p,15,    d,18,   a,.8  ;
    155; name,"bonemerang",     t,T_GROUND,     z,Z_PHYSICAL,  p,10,    d,50,   a,.9  ;
    156; name,"rest",           t,T_PSYCHIC,    z,Z_STATUS,    p,5,     d,—,    a,—   ;
    157; name,"rock-slide",     t,T_ROCK,       z,Z_PHYSICAL,  p,10,    d,75,   a,.9  ;
    158; name,"hyper-fang",     t,T_NORMAL,     z,Z_PHYSICAL,  p,15,    d,80,   a,.9  ;
    159; name,"sharpen",        t,T_NORMAL,     z,Z_STATUS,    p,30,    d,—,    a,—   ;
    160; name,"conversion",     t,T_NORMAL,     z,Z_STATUS,    p,30,    d,—,    a,—   ;
    161; name,"tri-attack",     t,T_NORMAL,     z,Z_SPECIAL,   p,10,    d,80,   a,1   ;
    162; name,"super-fang",     t,T_NORMAL,     z,Z_PHYSICAL,  p,10,    d,—,    a,.9  ;
    163; name,"slash",          t,T_NORMAL,     z,Z_PHYSICAL,  p,20,    d,70,   a,1   ;
    164; name,"substitute",     t,T_NORMAL,     z,Z_STATUS,    p,10,    d,—,    a,—   ;
]]
