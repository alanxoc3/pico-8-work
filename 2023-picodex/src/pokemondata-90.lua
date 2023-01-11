c_pokemon = zobj[[
    -- name           w     h   t1          t2           hp   att  def  spd  spc  movenums/levels string
    0;,"missingno",   10,   10, T_BIRD,     T_NORMAL,    33,  136, 0,   29,  6,   43|12,1|1;
    ;, "bulbasaur",   69,   7,  T_GRASS,    T_POISON,    45,  49,  49,  45,  65,  88|79|105|70|108|107|106|110|22,1|1|7|13|20|27|34|41|48;
    ;, "ivysaur",     130,  10, T_GRASS,    T_POISON,    60,  62,  63,  60,  80,  88|105|79|70|108|107|106|110|22,1|1|1|13|22|30|38|46|54;
    ;, "venusaur",    1000, 20, T_GRASS,    T_POISON,    80,  82,  83,  80,  100, 88|105|79|70|108|107|106|110|22,1|1|1|1|22|30|43|55|65;
    ;, "charmander",  85,   6,  T_FIRE,     T_NONE,      39,  52,  43,  65,  50,  88|63|95|86|20|164|96|113,1|1|9|15|22|30|38|46;
    ;, "charmeleon",  190,  11, T_FIRE,     T_NONE,      58,  64,  58,  80,  65,  95|88|63|86|20|164|96|113,1|1|1|15|24|33|42|56;
    ;, "charizard",   905,  17, T_FIRE,     T_FLYING,    78,  84,  78,  100, 85,  95|88|86|63|20|164|96|113,1|1|1|1|24|36|46|55;
    ;, "squirtle",    90,   5,  T_WATER,    T_NONE,      44,  48,  65,  43,  50,  79|82|152|12|87|128|40|98,1|1|8|15|22|28|35|42;
    ;, "wartortle",   225,  10, T_WATER,    T_NONE,      59,  63,  80,  58,  65,  152|79|82|12|87|128|40|98,1|1|1|15|24|31|39|47;
    ;, "blastoise",   855,  16, T_WATER,    T_NONE,      79,  83,  100, 78,  85,  152|79|82|12|87|128|40|98,1|1|1|1|24|31|42|52;
    ;, "caterpie",    29,   3,  T_BUG,      T_NONE,      45,  30,  35,  45,  20,  112|79,1|1;
    ;, "metapod",     99,   7,  T_BUG,      T_NONE,      50,  20,  55,  30,  25,  124,1;
    ;, "butterfree",  320,  11, T_BUG,      T_FLYING,    60,  45,  50,  70,  80,  116|108|109|110|91|4|99,1|15|16|17|21|26|32;
    ;, "weedle",      32,   3,  T_BUG,      T_POISON,    40,  35,  30,  50,  20,  83|112,1|1;
    ;, "kakuna",      100,  6,  T_BUG,      T_POISON,    45,  25,  50,  35,  25,  124,1;
    ;, "beedrill",    295,  10, T_BUG,      T_POISON,    65,  80,  40,  75,  45,  78|133|84|20|85|119,1|16|20|25|30|35;
    ;, "pidgey",      18,   3,  T_NORMAL,   T_FLYING,    40,  45,  40,  56,  35,  66|75|120|4|67|119|134,1|5|12|19|28|36|44;
    ;, "pidgeotto",   300,  11, T_NORMAL,   T_FLYING,    63,  60,  55,  71,  50,  66|75|120|4|67|119|134,1|1|12|21|31|40|49;
    ;, "pidgeot",     395,  15, T_NORMAL,   T_FLYING,    83,  80,  75,  91,  70,  66|120|75|4|67|119|134,1|1|1|21|31|44|54;
    ;, "rattata",     35,   3,  T_NORMAL,   T_NONE,      30,  56,  35,  72,  25,  79|82|120|160|133|163,1|1|7|14|23|34;
    ;, "raticate",    185,  7,  T_NORMAL,   T_NONE,      55,  81,  60,  97,  50,  120|79|82|160|133|163,1|1|1|14|27|41;
    ;, "spearow",     20,   3,  T_NORMAL,   T_FLYING,    40,  60,  30,  70,  31,  88|101|86|78|134|102|119,1|1|9|15|22|29|36;
    ;, "fearow",      380,  12, T_NORMAL,   T_FLYING,    65,  90,  65,  100, 61,  88|86|101|78|134|102|119,1|1|1|15|25|34|43;
    ;, "ekans",       69,   20, T_POISON,   T_NONE,      35,  60,  44,  55,  40,  86|80|83|87|146|122|94,1|1|10|17|24|31|38;
    ;, "arbok",       650,  35, T_POISON,   T_NONE,      60,  85,  69,  80,  65,  86|83|80|87|146|122|94,1|1|1|17|27|36|47;
    ;, "pikachu",     60,   4,  T_ELECTRIC, T_NONE,      35,  55,  30,  90,  50,  88|114|45|120|39|119|25,1|1|9|16|26|33|43;
    ;, "raichu",      300,  8,  T_ELECTRIC, T_NONE,      60,  90,  55,  100, 90,  88|114|45,1|1|1;
    ;, "sandshrew",   120,  6,  T_GROUND,   T_NONE,      50,  75,  85,  40,  30,  63|75|164|83|39|158,1|10|17|24|31|38;
    ;, "sandslash",   295,  10, T_GROUND,   T_NONE,      75,  100, 110, 65,  55,  75|63|164|83|39|158,1|1|17|27|36|47;
    ;, "nidoran?",    70,   4,  T_POISON,   T_NONE,      55,  47,  52,  41,  40,  88|79|63|83|82|87|158|72,1|1|8|14|21|29|36|43;
    ;, "nidorina",    200,  8,  T_POISON,   T_NONE,      70,  62,  67,  56,  55,  88|79|63|83|82|87|158|72,1|1|8|14|23|32|41|50;
    ;, "nidoqueen",   600,  13, T_POISON,   T_GROUND,    90,  82,  87,  76,  75,  8|63|79|82|83,1|1|1|1|14;
    ;, "nidoran!",    90,   5,  T_POISON,   T_NONE,      46,  57,  40,  50,  40,  86|79|77|83|133|78|7|72,1|1|8|14|21|29|36|43;
    ;, "nidorino",    195,  9,  T_POISON,   T_NONE,      61,  72,  57,  65,  55,  77|86|79|83|133|78|7|72,1|1|1|14|23|32|41|50;
    ;, "nidoking",    620,  14, T_POISON,   T_GROUND,    81,  92,  77,  85,  75,  77|83|79|81,1|1|1|1;
    ;, "clefairy",    75,   6,  T_NORMAL,   T_NONE,      70,  45,  48,  35,  60,  88|56|90|58|125|35|129|131,1|1|13|18|24|31|39|48;
    ;, "clefable",    400,  13, T_NORMAL,   T_NONE,      95,  70,  73,  60,  85,  58|35|125|90,1|1|1|1;
    ;, "vulpix",      99,   6,  T_FIRE,     T_NONE,      38,  41,  40,  65,  65,  95|82|120|89|127|96|113,1|1|16|21|28|35|42;
    ;, "ninetales",   199,  11, T_FIRE,     T_NONE,      73,  76,  75,  100, 100, 95|120|89|82,1|1|1|1;
    ;, "jigglypuff",  55,   5,  T_NORMAL,   T_NONE,      115, 45,  20,  20,  25,  90|56|93|129|58|44|8|10,1|9|14|19|24|29|34|39;
    ;, "wigglytuff",  120,  10, T_NORMAL,   T_NONE,      140, 70,  45,  45,  50,  129|93|58|90,1|1|1|1;
    ;, "zubat",       75,   8,  T_POISON,   T_FLYING,    40,  45,  35,  55,  40,  149|91|87|127|67|132,1|10|15|21|28|36;
    ;, "golbat",      550,  16, T_POISON,   T_FLYING,    75,  80,  70,  90,  75,  87|149|122|91|127|67|132,1|1|1|10|21|32|43;
    ;, "oddish",      54,   5,  T_GRASS,    T_POISON,    45,  50,  55,  30,  75,  104|108|109|110|94|111|22,1|15|17|19|24|33|46;
    ;, "gloom",       86,   8,  T_GRASS,    T_POISON,    60,  65,  70,  40,  85,  104|108|109|110|94|111|22,1|1|1|19|28|38|52;
    ;, "vileplume",   186,  12, T_GRASS,    T_POISON,    75,  80,  85,  50,  100, 94|111|110|109|108,1|1|1|1|15;
    ;, "paras",       54,   3,  T_BUG,      T_GRASS,     35,  70,  55,  25,  55,  63|109|149|154|164|106,1|13|20|27|34|41;
    ;, "parasect",    295,  10, T_BUG,      T_GRASS,     60,  95,  80,  30,  80,  149|63|109|154|164|106,1|1|1|30|39|48;
    ;, "venonat",     300,  10, T_BUG,      T_POISON,    60,  55,  50,  45,  40,  93|79|108|149|109|99|110|29,1|1|24|27|30|35|38|43;
    ;, "venomoth",    125,  15, T_BUG,      T_POISON,    70,  65,  60,  90,  90,  93|149|108|79|109|99|110|29,1|1|1|1|30|38|43|50;
    ;, "diglett",     8,    2,  T_GROUND,   T_NONE,      10,  55,  25,  95,  45,  63|88|28|75|164|26,1|15|19|24|31|40;
    ;, "dugtrio",     333,  7,  T_GROUND,   T_NONE,      35,  80,  50,  120, 70,  28|88|63|75|164|26,1|1|1|24|35|47;
    ;, "meowth",      42,   4,  T_NORMAL,   T_NONE,      40,  45,  35,  90,  40,  88|63|87|16|122|158|164,1|1|12|17|24|33|44;
    ;, "persian",     320,  10, T_NORMAL,   T_NONE,      65,  70,  60,  115, 65,  87|88|63|122|16|158|164,1|1|1|1|17|37|51;
    ;, "psyduck",     196,  8,  T_WATER,    T_NONE,      50,  52,  48,  55,  50,  63|82|93|116|158|98,1|28|31|36|43|52;
    ;, "golduck",     766,  17, T_WATER,    T_NONE,      80,  82,  78,  85,  80,  93|63|82|116|158|98,1|1|1|39|48|59;
    ;, "mankey",      280,  5,  T_FIGHTING, T_NONE,      40,  80,  35,  70,  35,  86|63|57|158|133|19|81,1|1|15|21|27|33|39;
    ;, "primeape",    320,  10, T_FIGHTING, T_NONE,      65,  105, 60,  95,  60,  158|57|86|63|133|19|81,1|1|1|1|27|37|46;
    ;, "growlithe",   190,  7,  T_FIRE,     T_NONE,      55,  70,  45,  60,  50,  87|89|95|86|9|119|96,1|1|18|23|30|39|50;
    ;, "arcanine",    1550, 19, T_FIRE,     T_NONE,      90,  110, 80,  95,  80,  95|86|89|9,1|1|1|1;
    ;, "poliwag",     124,  6,  T_WATER,    T_NONE,      40,  50,  40,  90,  40,  152|117|12|58|8|143|98,1|16|19|25|31|38|45;
    ;, "poliwhirl",   200,  10, T_WATER,    T_NONE,      65,  65,  65,  90,  50,  152|117|12|58|8|143|98,1|1|1|26|33|41|49;
    ;, "poliwrath",   540,  13, T_WATER,    T_FIGHTING,  90,  85,  95,  70,  70,  8|58|117|12,1|1|1|1;
    ;, "abra",        195,  9,  T_PSYCHIC,  T_NONE,      25,  20,  15,  90,  105, 30,1;
    ;, "kadabra",     565,  13, T_PSYCHIC,  T_NONE,      40,  35,  30,  105, 120, 116|93|30|99|123|29|33,1|1|1|27|31|38|42;
    ;, "alakazam",    480,  15, T_PSYCHIC,  T_NONE,      55,  50,  45,  120, 135, 116|93|30|99|123|29|33,1|1|1|27|31|38|42;
    ;, "machop",      195,  8,  T_FIGHTING, T_NONE,      70,  80,  50,  35,  35,  57|103|86|133|19|17,1|20|25|32|39|46;
    ;, "machoke",     705,  15, T_FIGHTING, T_NONE,      80,  100, 70,  45,  50,  57|86|103|133|19|17,1|1|1|36|44|52;
    ;, "machamp",     1300, 16, T_FIGHTING, T_NONE,      90,  130, 80,  55,  65,  57|86|103|133|19|17,1|1|1|36|44|52;
    ;, "bellsprout",  40,   7,  T_GRASS,    T_POISON,    50,  75,  35,  40,  70,  106|70|80|108|110|109|94|107|69,1|1|13|15|18|21|26|33|42;
    ;, "weepinbell",  64,   10, T_GRASS,    T_POISON,    65,  90,  50,  55,  85,  106|70|80|108|110|109|94|107|69,1|1|1|15|18|23|29|38|49;
    ;, "victreebel",  155,  17, T_GRASS,    T_POISON,    80,  105, 65,  70,  100, 94|107|110|109|80|108,1|1|1|1|13|15;
    ;, "tentacool",   455,  9,  T_WATER,    T_POISON,    40,  40,  35,  70,  100, 94|91|80|83|12|142|130|122|98,1|7|13|18|22|27|33|40|48;
    ;, "tentacruel",  550,  16, T_WATER,    T_POISON,    80,  70,  65,  100, 120, 94|91|80|83|12|142|130|122|98,1|1|1|18|22|27|35|43|50;
    ;, "geodude",     200,  4,  T_ROCK,     T_GROUND,    40,  80,  100, 20,  30,  79|129|115|36|124|26|47,1|11|16|21|26|31|36;
    ;, "graveler",    1050, 10, T_ROCK,     T_GROUND,    55,  95,  115, 35,  45,  129|79|115|36|124|26|47,1|1|16|21|29|36|43;
    ;, "golem",       3000, 14, T_ROCK,     T_GROUND,    80,  110, 130, 45,  55,  129|79|115|36|124|26|47,1|1|16|21|29|36|43;
    ;, "ponyta",      300,  10, T_FIRE,     T_NONE,      50,  85,  55,  90,  65,  95|82|71|88|113|9|119,1|30|32|35|39|43|48;
    ;, "rapidash",    950,  17, T_FIRE,     T_NONE,      65,  100, 70,  105, 80,  95|88|71|82|113|9|119,1|1|1|1|39|47|55;
    ;, "slowpoke",    360,  12, T_WATER,    T_PSYCHIC,   90,  65,  65,  15,  40,  116|93|76|88|12|143|29,1|18|22|27|33|40|48;
    ;, "slowbro",     785,  16, T_WATER,    T_PSYCHIC,   95,  75,  110, 30,  80,  116|93|76|88|12|128|143|29,1|1|1|27|33|37|44|55;
    ;, "magnemite",   60,   3,  T_ELECTRIC, T_NONE,      25,  35,  70,  45,  95,  79|92|114|91|45|39|122,1|21|25|29|35|41|47;
    ;, "magneton",    600,  10, T_ELECTRIC, T_NONE,      50,  60,  95,  70,  120, 92|79|114|91|45|39|122,1|1|1|29|38|46|54;
    ;, "farfetch'd",  150,  8,  T_NORMAL,   T_FLYING,    52,  65,  55,  60,  58,  101|75|86|78|3|119|164,1|1|7|15|23|31|39;
    ;, "doduo",       392,  14, T_NORMAL,   T_FLYING,    35,  85,  45,  75,  35,  101|88|78|102|20|49|119,1|20|24|30|36|40|44;
    ;, "dodrio",      852,  18, T_NORMAL,   T_FLYING,    60,  110, 70,  100, 60,  78|88|101|102|20|49|119,1|1|1|30|39|45|51;
    ;, "seel",        900,  11, T_WATER,    T_NONE,      65,  45,  55,  45,  70,  76|88|100|44|9|13,1|30|35|40|45|50;
    ;, "dewgong",     1200, 17, T_WATER,    T_ICE,       90,  70,  80,  70,  95,  100|88|76|44|9|13,1|1|1|44|50|56;
    ;, "grimer",      300,  9,  T_POISON,   T_NONE,      80,  80,  50,  25,  40,  93|56|147|125|137|124|122|156,1|1|30|33|37|42|48|55;
    ;, "muk",         300,  12, T_POISON,   T_NONE,      105, 105, 75,  50,  65,  93|147|56|125|137|124|122|156,1|1|1|33|37|45|53|60;
    ;, "shellder",    40,   3,  T_WATER,    T_NONE,      30,  65,  100, 40,  45,  79|128|91|140|100|86|13,1|1|18|23|30|39|50;
    ;, "cloyster",    1325, 15, T_WATER,    T_ICE,       50,  95,  180, 70,  85,  100|140|91|128|141,1|1|1|1|50;
    ;, "gastly",      1,    13, T_GHOST,    T_POISON,    30,  35,  30,  80,  100, 127|135|121|117|42,1|1|1|27|35;
    ;, "haunter",     1,    16, T_GHOST,    T_POISON,    45,  50,  45,  95,  115, 127|135|121|117|42,1|1|1|29|38;
    ;, "gengar",      405,  15, T_GHOST,    T_POISON,    60,  65,  60,  110, 130, 127|135|121|117|42,1|1|1|29|38;
    ;, "onix",        2100, 88, T_ROCK,     T_GROUND,    35,  45,  160, 70,  30,  122|79|68|115|20|69|124,1|1|15|19|25|33|43;
    ;, "drowzee",     324,  10, T_PSYCHIC,  T_NONE,      60,  48,  45,  42,  90,  117|56|93|116|76|147|29|118,1|1|12|17|24|29|32|37;
    ;, "hypno",       756,  16, T_PSYCHIC,  T_NONE,      85,  73,  70,  67,  115, 116|93|117|56|76|147|29|118,1|1|1|1|24|33|37|43;
    ;, "krabby",      65,   4,  T_WATER,    T_NONE,      30,  105, 90,  50,  25,  152|86|64|65|71|157|124,1|1|20|25|30|35|40;
    ;, "kingler",     600,  13, T_WATER,    T_NONE,      55,  130, 115, 75,  50,  152|86|64|65|71|157|124,1|1|1|25|34|42|49;
    ;, "voltorb",     104,  5,  T_ELECTRIC, T_NONE,      40,  30,  50,  100, 55,  122|79|92|36|131|39|47,1|1|17|22|29|36|43;
    ;, "electrode",   666,  12, T_ELECTRIC, T_NONE,      60,  50,  70,  140, 80,  122|92|79|36|131|39|47,1|1|1|22|29|40|50;
    ;, "exeggcute",   25,   4,  T_GRASS,    T_PSYCHIC,   60,  40,  80,  40,  60,  148|117|33|105|109|108|22|110,1|1|25|28|32|37|42|48;
    ;, "exeggutor",   1200, 20, T_GRASS,    T_PSYCHIC,   95,  95,  85,  55,  125, 148|117|71,1|1|28;
    ;, "cubone",      65,   4,  T_GROUND,   T_NONE,      50,  50,  95,  35,  40,  138|88|86|133|81|159|20,1|1|25|31|38|43|46;
    ;, "marowak",     450,  10, T_GROUND,   T_NONE,      60,  80,  110, 45,  50,  138|133|88|86|81|159|20,1|1|1|1|41|48|55;
    ;, "hitmonlee",   498,  15, T_FIGHTING, T_NONE,      50,  120, 53,  87,  35,  72|118|74|73|133|145|5,1|1|33|38|43|48|53;
    ;, "hitmonchan",  502,  14, T_FIGHTING, T_NONE,      50,  105, 79,  76,  35,  119|59|60|61|62|1|18,1|1|33|38|43|48|53;
    ;, "lickitung",   655,  12, T_NORMAL,   T_NONE,      90,  55,  75,  30,  60,  91|80|71|93|129|69|122,1|1|7|15|23|31|39;
    ;, "koffing",     10,   6,  T_POISON,   T_NONE,      40,  65,  95,  35,  60,  136|79|137|126|36|132|47,1|1|32|37|40|45|48;
    ;, "weezing",     95,   12, T_POISON,   T_NONE,      65,  90,  120, 60,  85,  137|136|79|126|36|132|47,1|1|1|39|43|49|53;
    ;, "rhyhorn",     1150, 10, T_GROUND,   T_ROCK,      80,  85,  95,  25,  30,  77|71|82|78|7|86|9,1|30|35|40|45|50|55;
    ;, "rhydon",      1200, 19, T_GROUND,   T_ROCK,      105, 130, 120, 40,  45,  78|77|71|82|7|86|9,1|1|1|1|48|55|64;
    ;, "chansey",     346,  11, T_NORMAL,   T_NONE,      250, 5,   5,   50,  105, 58|56|90|88|125|129|131|10,1|1|24|30|38|44|48|54;
    ;, "tangela",     350,  10, T_GRASS,    T_NONE,      65,  55,  115, 60,  100, 68|142|104|108|109|110|69|106,1|1|29|32|36|39|45|49;
    ;, "kangaskhan",  800,  22, T_NORMAL,   T_NONE,      105, 95,  80,  90,  40,  59|20|87|82|1|86|153,1|1|26|31|36|41|46;
    ;, "horsea",      80,   4,  T_WATER,    T_NONE,      30,  40,  70,  60,  70,  152|126|86|12|119|98,1|19|24|30|37|45;
    ;, "seadra",      250,  12, T_WATER,    T_NONE,      55,  65,  95,  85,  95,  152|126|86|12|119|98,1|1|24|30|41|52;
    ;, "goldeen",     150,  6,  T_WATER,    T_NONE,      45,  67,  60,  63,  50,  101|82|91|77|78|139|7|119,1|1|19|24|30|37|45|54;
    ;, "seaking",     390,  13, T_WATER,    T_NONE,      80,  92,  65,  68,  80,  101|91|82|77|78|139|7|119,1|1|1|24|30|39|48|54;
    ;, "staryu",      345,  8,  T_WATER,    T_NONE,      30,  45,  55,  85,  70,  79|12|124|123|39|125|131|98,1|17|22|27|32|37|42|47;
    ;, "starmie",     800,  11, T_WATER,    T_PSYCHIC,   60,  75,  85,  115, 100, 124|79|12,1|1|1;
    ;, "mr mime",     545,  13, T_PSYCHIC,  T_NONE,      40,  45,  65,  90,  100, 130|116|131|58|118|50,1|1|23|31|39|47;
    ;, "scyther",     560,  15, T_BUG,      T_FLYING,    70,  110, 80,  105, 55,  120|86|133|32|164|3|119,1|17|20|24|29|35|42;
    ;, "jynx",        406,  14, T_ICE,      T_PSYCHIC,   65,  50,  35,  95,  95,  150|56|135|58|61|8|81|14,1|1|18|23|31|39|47|58;
    ;, "electabuzz",  300,  11, T_ELECTRIC, T_NONE,      65,  83,  57,  105, 85,  86|120|114|122|62|131|25,1|1|34|37|42|49|54;
    ;, "magmar",      445,  13, T_FIRE,     T_NONE,      65,  95,  57,  93,  85,  95|86|127|60|126|136|96,1|36|39|43|48|52|55;
    ;, "pinsir",      550,  15, T_BUG,      T_NONE,      65,  125, 100, 85,  55,  64|19|65|133|124|164|3,1|25|30|36|43|49|54;
    ;, "tauros",      884,  14, T_NORMAL,   T_NONE,      75,  100, 95,  110, 70,  79|71|82|86|20|9,1|21|28|35|44|51;
    ;, "magikarp",    100,  9,  T_WATER,    T_NONE,      20,  10,  55,  80,  20,  155|79,1|15;
    ;, "gyarados",    2350, 65, T_WATER,    T_FLYING,    95,  125, 79,  81,  100, 87|23|98|86|15,1|1|1|1|52;
    ;, "lapras",      2200, 25, T_WATER,    T_ICE,       130, 85,  80,  60,  95,  88|12|90|97|8|127|13|98,1|1|16|20|25|31|38|46;
    ;, "ditto",       40,   3,  T_NORMAL,   T_NONE,      48,  48,  48,  48,  48,  151,1;
    ;, "eevee",       65,   3,  T_NORMAL,   T_NONE,      55,  55,  50,  55,  65,  75|79|120|82|87|9,1|1|27|31|37|45;
    ;, "vaporeon",    290,  10, T_WATER,    T_NONE,      130, 65,  60,  65,  110, 120|75|79|12|82|87|156|132|97|98,1|1|1|1|37|40|42|44|48|54;
    ;, "jolteon",     245,  8,  T_ELECTRIC, T_NONE,      65,  65,  60,  130, 110, 120|75|79|114|82|45|72|119|85|25,1|1|1|1|37|40|42|44|48|54;
    ;, "flareon",     250,  9,  T_FIRE,     T_NONE,      65,  130, 60,  65,  110, 95|120|75|79|82|87|86|113|20|96,1|1|1|1|37|40|42|44|48|54;
    ;, "porygon",     365,  8,  T_NORMAL,   T_NONE,      65,  60,  70,  40,  75,  162|161|79|99|123|119|49,1|1|1|23|28|35|42;
    ;, "omanyte",     75,   4,  T_ROCK,     T_WATER,     35,  40,  100, 35,  90,  12|128|77|86|141|98,1|1|34|39|46|53;
    ;, "omastar",     350,  10, T_ROCK,     T_WATER,     70,  60,  125, 55,  115, 77|12|128|86|141|98,1|1|1|39|44|49;
    ;, "kabuto",      115,  5,  T_ROCK,     T_WATER,     30,  80,  90,  55,  45,  124|63|104|164|86|98,1|1|34|39|44|49;
    ;, "kabutops",    405,  13, T_ROCK,     T_WATER,     60,  115, 105, 80,  70,  104|124|63|164|86|98,1|1|1|39|46|53;
    ;, "aerodactyl",  590,  18, T_ROCK,     T_FLYING,    80,  105, 65,  130, 60,  119|67|91|87|9|15,1|1|33|38|45|54;
    ;, "snorlax",     4600, 21, T_NORMAL,   T_NONE,      160, 110, 65,  30,  65,  143|76|44|8|124|10|15,1|1|1|35|41|48|56;
    ;, "articuno",    554,  17, T_ICE,      T_FLYING,    90,  85,  100, 85,  125, 13|101|14|119|97,1|1|51|55|60;
    ;, "zapdos",      526,  16, T_ELECTRIC, T_FLYING,    90,  90,  85,  100, 125, 102|114|25|119|131,1|1|51|55|60;
    ;, "moltres",     600,  20, T_FIRE,     T_FLYING,    90,  100, 90,  90,  125, 113|101|86|119|43,1|1|51|55|60;
    ;, "dratini",     33,   18, T_DRAGON,   T_NONE,      41,  64,  45,  50,  50,  86|80|45|119|69|23|15,1|1|10|20|30|40|50;
    ;, "dragonair",   165,  40, T_DRAGON,   T_NONE,      61,  84,  65,  70,  70,  86|45|80|119|69|23|15,1|1|1|20|35|45|55;
    ;, "dragonite",   2100, 22, T_DRAGON,   T_FLYING,    91,  134, 95,  80,  100, 119|86|45|80|69|23|15,1|1|1|1|35|45|60;
    ;, "mewtwo",      1220, 20, T_PSYCHIC,  T_NONE,      106, 110, 90,  130, 154, 116|93|29|39|130|123|97|143,1|1|1|1|63|70|75|81;
    ;, "mew",         40,   4,  T_PSYCHIC,  T_NONE,      100, 100, 100, 100, 100, 56|151|1|35|29,1|10|20|30|40;
]]

-- includes type effectiveness chart. according to the gen 1 games, which had bugs. i'm keeping the bugs :).
c_types = zobj[[
    0;bg,0, name,"bird",     T_BIRD;     good;,;                                  T_BIRD;     null;,;                   T_BIRD;     weak;,;
    ; bg,0, name,"normal",   T_NORMAL;   good;,;                                  T_NORMAL;   null;,T_GHOST;            T_NORMAL;   weak;,T_ROCK;
    ; bg,5, name,"fire",     T_FIRE;     good;,T_GRASS,T_ICE,T_BUG;               T_FIRE;     null;,;                   T_FIRE;     weak;,T_FIRE,T_WATER,T_ROCK,T_DRAGON;
    ; bg,4, name,"water",    T_WATER;    good;,T_FIRE,T_GROUND,T_ROCK;            T_WATER;    null;,;                   T_WATER;    weak;,T_DRAGON,T_GRASS,T_WATER;
    ; bg,6, name,"electric", T_ELECTRIC; good;,T_FLYING,T_WATER;                  T_ELECTRIC; null;,T_GROUND;           T_ELECTRIC; weak;,T_DRAGON,T_ELECTRIC,T_GRASS;
    ; bg,3, name,"grass",    T_GRASS;    good;,T_GROUND,T_ROCK,T_WATER;           T_GRASS;    null;,;                   T_GRASS;    weak;,T_BUG,T_DRAGON,T_FIRE,T_FLYING,T_GRASS,T_POISON;
    ; bg,4, name,"ice",      T_ICE;      good;,T_DRAGON,T_FLYING,T_GRASS;         T_ICE;      null;,;                   T_ICE;      weak;,T_FIRE,T_ICE,T_WATER;
    ; bg,2, name,"fighting", T_FIGHTING; good;,T_ICE,T_NORMAL,T_ROCK;             T_FIGHTING; null;,T_GHOST;            T_FIGHTING; weak;,T_BUG,T_FLYING,T_POISON,T_PSYCHIC;
    ; bg,1, name,"poison",   T_POISON;   good;,T_BUG,T_GRASS;                     T_POISON;   null;,;                   T_POISON;   weak;,T_GHOST,T_GROUND,T_POISON,T_ROCK;
    ; bg,2, name,"ground",   T_GROUND;   good;,T_ELECTRIC,T_FIRE,T_POISON,T_ROCK; T_GROUND;   null;,T_FLYING;           T_GROUND;   weak;,T_BUG,T_GRASS;
    ; bg,0, name,"flying",   T_FLYING;   good;,T_BUG,T_FIGHTING,T_GRASS;          T_FLYING;   null;,;                   T_FLYING;   weak;,T_ELECTRIC,T_ROCK;
    ; bg,1, name,"psychic",  T_PSYCHIC;  good;,T_FIGHTING,T_POISON;               T_PSYCHIC;  null;,;                   T_PSYCHIC;  weak;,T_PSYCHIC;
    ; bg,3, name,"bug",      T_BUG;      good;,T_GRASS,T_PSYCHIC;                 T_BUG;      null;,;                   T_BUG;      weak;,T_FIGHTING,T_FIRE,T_FLYING,T_GHOST,T_POISON;
    ; bg,0, name,"rock",     T_ROCK;     good;,T_BUG,T_FIRE,T_FLYING,T_ICE;       T_ROCK;     null;,;                   T_ROCK;     weak;,T_FIGHTING,T_GROUND;
    ; bg,1, name,"ghost",    T_GHOST;    good;,T_GHOST;                           T_GHOST;    null;,T_NORMAL,T_PSYCHIC; T_GHOST;    weak;,;
    ; bg,0, name,"dragon",   T_DRAGON;   good;,T_DRAGON;                          T_DRAGON;   null;,;                   T_DRAGON;   weak;,;
]]

-- 5 bg styles
c_bg_styles = zobj[[
    0;bg,6,  aa,13; -- normal
    ; bg,13, aa,5;  -- darker/psychic/poison/ghost
    ; bg,9,  aa,4;  -- electric/ground
    ; bg,11, aa,3;  -- grass
    ; bg,12, aa,5;  -- water
    ; bg,8,  aa,2;  -- fire
    ; bg,10, aa,4;  -- electric/ground
]]

c_zmovetype = zobj[[
    0;name,"status";
    ; name,"physical";
    ; name,"special";
]]

c_moves = zobj[[
    0;name,"struggle",       t,T_NORMAL,     z,Z_PHYSICAL,  p,-,  d,50,  a,—   ;

    -- tms
    ; name,"mega-punch",     t,T_NORMAL,   z,Z_PHYSICAL,  p,20, d,80,  a,.85 ; -- 1
    ; name,"razor-wind",     t,T_NORMAL,   z,Z_SPECIAL,   p,10, d,80,  a,1   ; -- 2
    ; name,"swords-dance",   t,T_NORMAL,   z,Z_STATUS,    p,20,              ; -- 3
    ; name,"whirlwind",      t,T_NORMAL,   z,Z_STATUS,    p,20,              ; -- 4
    ; name,"mega-kick",      t,T_NORMAL,   z,Z_PHYSICAL,  p,5,  d,120, a,.75 ; -- 5
    ; name,"toxic",          t,T_POISON,   z,Z_STATUS,    p,10,        a,.9  ; -- 6
    ; name,"horn-drill",     t,T_NORMAL,   z,Z_PHYSICAL,  p,5,         a,.3  ; -- 7
    ; name,"body-slam",      t,T_NORMAL,   z,Z_PHYSICAL,  p,15, d,85,  a,1   ; -- 8
    ; name,"take-down",      t,T_NORMAL,   z,Z_PHYSICAL,  p,20, d,90,  a,.85 ; -- 9
    ; name,"double-edge",    t,T_NORMAL,   z,Z_PHYSICAL,  p,15, d,120, a,1   ; -- 10
    ; name,"bubble-beam",    t,T_WATER,    z,Z_SPECIAL,   p,20, d,65,  a,1   ; -- 11
    ; name,"water-gun",      t,T_WATER,    z,Z_SPECIAL,   p,25, d,40,  a,1   ; -- 12
    ; name,"ice-beam",       t,T_ICE,      z,Z_SPECIAL,   p,10, d,90,  a,1   ; -- 13
    ; name,"blizzard",       t,T_ICE,      z,Z_SPECIAL,   p,5,  d,110, a,.7  ; -- 14
    ; name,"hyper-beam",     t,T_NORMAL,   z,Z_SPECIAL,   p,5,  d,150, a,.9  ; -- 15
    ; name,"pay-day",        t,T_NORMAL,   z,Z_PHYSICAL,  p,20, d,40,  a,1   ; -- 16
    ; name,"submission",     t,T_FIGHTING, z,Z_PHYSICAL,  p,20, d,80,  a,.8  ; -- 17
    ; name,"counter",        t,T_FIGHTING, z,Z_PHYSICAL,  p,20,        a,1   ; -- 18
    ; name,"seismic-toss",   t,T_FIGHTING, z,Z_PHYSICAL,  p,20,        a,1   ; -- 19
    ; name,"rage",           t,T_NORMAL,   z,Z_PHYSICAL,  p,20, d,20,  a,1   ; -- 20
    ; name,"mega-drain",     t,T_GRASS,    z,Z_SPECIAL,   p,15, d,40,  a,1   ; -- 21
    ; name,"solar-beam",     t,T_GRASS,    z,Z_SPECIAL,   p,10, d,120, a,1   ; -- 22
    ; name,"dragon-rage",    t,T_DRAGON,   z,Z_SPECIAL,   p,10,        a,1   ; -- 23
    ; name,"thunderbolt",    t,T_ELECTRIC, z,Z_SPECIAL,   p,15, d,90,  a,1   ; -- 24
    ; name,"thunder",        t,T_ELECTRIC, z,Z_SPECIAL,   p,10, d,110, a,.7  ; -- 25
    ; name,"earthquake",     t,T_GROUND,   z,Z_PHYSICAL,  p,10, d,100, a,1   ; -- 26
    ; name,"fissure",        t,T_GROUND,   z,Z_PHYSICAL,  p,5,         a,.3  ; -- 27
    ; name,"dig",            t,T_GROUND,   z,Z_PHYSICAL,  p,10, d,80,  a,1   ; -- 28
    ; name,"psychic",        t,T_PSYCHIC,  z,Z_SPECIAL,   p,10, d,90,  a,1   ; -- 29
    ; name,"teleport",       t,T_PSYCHIC,  z,Z_STATUS,    p,20,              ; -- 30
    ; name,"mimic",          t,T_NORMAL,   z,Z_STATUS,    p,10,              ; -- 31
    ; name,"double-team",    t,T_NORMAL,   z,Z_STATUS,    p,15,              ; -- 32
    ; name,"reflect",        t,T_PSYCHIC,  z,Z_STATUS,    p,20,              ; -- 33
    ; name,"bide",           t,T_NORMAL,   z,Z_PHYSICAL,  p,10,              ; -- 34
    ; name,"metronome",      t,T_NORMAL,   z,Z_STATUS,    p,10,              ; -- 35
    ; name,"self-destruct",  t,T_NORMAL,   z,Z_PHYSICAL,  p,5,  d,200, a,1   ; -- 36
    ; name,"egg-bomb",       t,T_NORMAL,   z,Z_PHYSICAL,  p,10, d,100, a,.75 ; -- 37
    ; name,"fire-blast",     t,T_FIRE,     z,Z_SPECIAL,   p,5,  d,110, a,.85 ; -- 38
    ; name,"swift",          t,T_NORMAL,   z,Z_SPECIAL,   p,20, d,60,        ; -- 39
    ; name,"skull-bash",     t,T_NORMAL,   z,Z_PHYSICAL,  p,10, d,130, a,1   ; -- 40
    ; name,"soft-boiled",    t,T_NORMAL,   z,Z_STATUS,    p,5,               ; -- 41
    ; name,"dream-eater",    t,T_PSYCHIC,  z,Z_SPECIAL,   p,15, d,100, a,1   ; -- 42
    ; name,"sky-attack",     t,T_FLYING,   z,Z_PHYSICAL,  p,5,  d,140, a,.9  ; -- 43
    ; name,"rest",           t,T_PSYCHIC,  z,Z_STATUS,    p,5,               ; -- 44
    ; name,"thunder-wave",   t,T_ELECTRIC, z,Z_STATUS,    p,20,        a,.9  ; -- 45
    ; name,"psywave",        t,T_PSYCHIC,  z,Z_SPECIAL,   p,15,        a,1   ; -- 46
    ; name,"explosion",      t,T_NORMAL,   z,Z_PHYSICAL,  p,5,  d,250, a,1   ; -- 47
    ; name,"rock-slide",     t,T_ROCK,     z,Z_PHYSICAL,  p,10, d,75,  a,.9  ; -- 48
    ; name,"tri-attack",     t,T_NORMAL,   z,Z_SPECIAL,   p,10, d,80,  a,1   ; -- 49
    ; name,"substitute",     t,T_NORMAL,   z,Z_STATUS,    p,10,              ; -- 50

    -- hms
    ; name,"cut",            t,T_NORMAL,   z,Z_PHYSICAL,  p,30, d,50,  a,.95 ; -- 51
    ; name,"fly",            t,T_FLYING,   z,Z_PHYSICAL,  p,15, d,90,  a,.95 ; -- 52
    ; name,"surf",           t,T_WATER,    z,Z_SPECIAL,   p,15, d,90,  a,1   ; -- 53
    ; name,"strength",       t,T_NORMAL,   z,Z_PHYSICAL,  p,15, d,80,  a,1   ; -- 54
    ; name,"flash",          t,T_NORMAL,   z,Z_STATUS,    p,20,        a,1   ; -- 55

    -- remaining moves (besides struggle)
    ; name,"pound",          t,T_NORMAL,   z,Z_PHYSICAL,  p,35, d,40,  a,1   ; -- 56
    ; name,"karate-chop",    t,T_FIGHTING, z,Z_PHYSICAL,  p,25, d,50,  a,1   ; -- 57
    ; name,"double-slap",    t,T_NORMAL,   z,Z_PHYSICAL,  p,10, d,15,  a,.85 ; -- 58
    ; name,"comet-punch",    t,T_NORMAL,   z,Z_PHYSICAL,  p,15, d,18,  a,.85 ; -- 59
    ; name,"fire-punch",     t,T_FIRE,     z,Z_PHYSICAL,  p,15, d,75,  a,1   ; -- 60
    ; name,"ice-punch",      t,T_ICE,      z,Z_PHYSICAL,  p,15, d,75,  a,1   ; -- 61
    ; name,"thunder-punch",  t,T_ELECTRIC, z,Z_PHYSICAL,  p,15, d,75,  a,1   ; -- 62
    ; name,"scratch",        t,T_NORMAL,   z,Z_PHYSICAL,  p,35, d,40,  a,1   ; -- 63
    ; name,"vice-grip",      t,T_NORMAL,   z,Z_PHYSICAL,  p,30, d,55,  a,1   ; -- 64
    ; name,"guillotine",     t,T_NORMAL,   z,Z_PHYSICAL,  p,5,         a,.3  ; -- 65
    ; name,"gust",           t,T_FLYING,   z,Z_SPECIAL,   p,35, d,40,  a,1   ; -- 66
    ; name,"wing-attack",    t,T_FLYING,   z,Z_PHYSICAL,  p,35, d,60,  a,1   ; -- 67
    ; name,"bind",           t,T_NORMAL,   z,Z_PHYSICAL,  p,20, d,15,  a,.85 ; -- 68
    ; name,"slam",           t,T_NORMAL,   z,Z_PHYSICAL,  p,20, d,80,  a,.75 ; -- 69
    ; name,"vine-whip",      t,T_GRASS,    z,Z_PHYSICAL,  p,25, d,45,  a,1   ; -- 70
    ; name,"stomp",          t,T_NORMAL,   z,Z_PHYSICAL,  p,20, d,65,  a,1   ; -- 71
    ; name,"double-kick",    t,T_FIGHTING, z,Z_PHYSICAL,  p,30, d,30,  a,1   ; -- 72
    ; name,"jump-kick",      t,T_FIGHTING, z,Z_PHYSICAL,  p,10, d,100, a,.95 ; -- 73
    ; name,"rolling-kick",   t,T_FIGHTING, z,Z_PHYSICAL,  p,15, d,60,  a,.85 ; -- 74
    ; name,"sand-attack",    t,T_GROUND,   z,Z_STATUS,    p,15,        a,1   ; -- 75
    ; name,"headbutt",       t,T_NORMAL,   z,Z_PHYSICAL,  p,15, d,70,  a,1   ; -- 76
    ; name,"horn-attack",    t,T_NORMAL,   z,Z_PHYSICAL,  p,25, d,65,  a,1   ; -- 77
    ; name,"fury-attack",    t,T_NORMAL,   z,Z_PHYSICAL,  p,20, d,15,  a,.85 ; -- 78
    ; name,"tackle",         t,T_NORMAL,   z,Z_PHYSICAL,  p,35, d,40,  a,1   ; -- 79
    ; name,"wrap",           t,T_NORMAL,   z,Z_PHYSICAL,  p,20, d,15,  a,.9  ; -- 80
    ; name,"thrash",         t,T_NORMAL,   z,Z_PHYSICAL,  p,10, d,120, a,1   ; -- 81
    ; name,"tail-whip",      t,T_NORMAL,   z,Z_STATUS,    p,30,        a,1   ; -- 82
    ; name,"poison-sting",   t,T_POISON,   z,Z_PHYSICAL,  p,35, d,15,  a,1   ; -- 83
    ; name,"twineedle",      t,T_BUG,      z,Z_PHYSICAL,  p,20, d,25,  a,1   ; -- 84
    ; name,"pin-missile",    t,T_BUG,      z,Z_PHYSICAL,  p,20, d,25,  a,.95 ; -- 85
    ; name,"leer",           t,T_NORMAL,   z,Z_STATUS,    p,30,        a,1   ; -- 86
    ; name,"bite",           t,T_NORMAL,   z,Z_PHYSICAL,  p,25, d,60,  a,1   ; -- 87
    ; name,"growl",          t,T_NORMAL,   z,Z_STATUS,    p,40,        a,1   ; -- 88
    ; name,"roar",           t,T_NORMAL,   z,Z_STATUS,    p,20,              ; -- 89
    ; name,"sing",           t,T_NORMAL,   z,Z_STATUS,    p,15,        a,.55 ; -- 90
    ; name,"supersonic",     t,T_NORMAL,   z,Z_STATUS,    p,20,        a,.55 ; -- 91
    ; name,"sonic-boom",     t,T_NORMAL,   z,Z_SPECIAL,   p,20,        a,.9  ; -- 92
    ; name,"disable",        t,T_NORMAL,   z,Z_STATUS,    p,20,        a,1   ; -- 93
    ; name,"acid",           t,T_POISON,   z,Z_SPECIAL,   p,30, d,40,  a,1   ; -- 94
    ; name,"ember",          t,T_FIRE,     z,Z_SPECIAL,   p,25, d,40,  a,1   ; -- 95
    ; name,"flamethrower",   t,T_FIRE,     z,Z_SPECIAL,   p,15, d,90,  a,1   ; -- 96
    ; name,"mist",           t,T_ICE,      z,Z_STATUS,    p,30,              ; -- 97
    ; name,"hydro-pump",     t,T_WATER,    z,Z_SPECIAL,   p,5,  d,110, a,.8  ; -- 98
    ; name,"psybeam",        t,T_PSYCHIC,  z,Z_SPECIAL,   p,20, d,65,  a,1   ; -- 99
    ; name,"aurora-beam",    t,T_ICE,      z,Z_SPECIAL,   p,20, d,65,  a,1   ; -- 100
    ; name,"peck",           t,T_FLYING,   z,Z_PHYSICAL,  p,35, d,35,  a,1   ; -- 101
    ; name,"drill-peck",     t,T_FLYING,   z,Z_PHYSICAL,  p,20, d,80,  a,1   ; -- 102
    ; name,"low-kick",       t,T_FIGHTING, z,Z_PHYSICAL,  p,20,        a,1   ; -- 103
    ; name,"absorb",         t,T_GRASS,    z,Z_SPECIAL,   p,25, d,20,  a,1   ; -- 104
    ; name,"leech-seed",     t,T_GRASS,    z,Z_STATUS,    p,10,        a,.9  ; -- 105
    ; name,"growth",         t,T_NORMAL,   z,Z_STATUS,    p,20,              ; -- 106
    ; name,"razor-leaf",     t,T_GRASS,    z,Z_PHYSICAL,  p,25, d,55,  a,.95 ; -- 107
    ; name,"poison-powder",  t,T_POISON,   z,Z_STATUS,    p,35,        a,.75 ; -- 108
    ; name,"stun-spore",     t,T_GRASS,    z,Z_STATUS,    p,30,        a,.75 ; -- 109
    ; name,"sleep-powder",   t,T_GRASS,    z,Z_STATUS,    p,15,        a,.75 ; -- 110
    ; name,"petal-dance",    t,T_GRASS,    z,Z_SPECIAL,   p,10, d,120, a,1   ; -- 111
    ; name,"string-shot",    t,T_BUG,      z,Z_STATUS,    p,40,        a,.95 ; -- 112
    ; name,"fire-spin",      t,T_FIRE,     z,Z_SPECIAL,   p,15, d,35,  a,.85 ; -- 113
    ; name,"thunder-shock",  t,T_ELECTRIC, z,Z_SPECIAL,   p,30, d,40,  a,1   ; -- 114
    ; name,"rock-throw",     t,T_ROCK,     z,Z_PHYSICAL,  p,15, d,50,  a,.9  ; -- 115
    ; name,"confusion",      t,T_PSYCHIC,  z,Z_SPECIAL,   p,25, d,50,  a,1   ; -- 116
    ; name,"hypnosis",       t,T_PSYCHIC,  z,Z_STATUS,    p,20,        a,.6  ; -- 117
    ; name,"meditate",       t,T_PSYCHIC,  z,Z_STATUS,    p,40,              ; -- 118
    ; name,"agility",        t,T_PSYCHIC,  z,Z_STATUS,    p,30,              ; -- 119
    ; name,"quick-attack",   t,T_NORMAL,   z,Z_PHYSICAL,  p,30, d,40,  a,1   ; -- 120
    ; name,"night-shade",    t,T_GHOST,    z,Z_SPECIAL,   p,15,        a,1   ; -- 121
    ; name,"screech",        t,T_NORMAL,   z,Z_STATUS,    p,40,        a,.85 ; -- 122
    ; name,"recover",        t,T_NORMAL,   z,Z_STATUS,    p,5,               ; -- 123
    ; name,"harden",         t,T_NORMAL,   z,Z_STATUS,    p,30,              ; -- 124
    ; name,"minimize",       t,T_NORMAL,   z,Z_STATUS,    p,10,              ; -- 125
    ; name,"smokescreen",    t,T_NORMAL,   z,Z_STATUS,    p,20,        a,1   ; -- 126
    ; name,"confuse-ray",    t,T_GHOST,    z,Z_STATUS,    p,10,        a,1   ; -- 127
    ; name,"withdraw",       t,T_WATER,    z,Z_STATUS,    p,40,              ; -- 128
    ; name,"defense-curl",   t,T_NORMAL,   z,Z_STATUS,    p,40,              ; -- 129
    ; name,"barrier",        t,T_PSYCHIC,  z,Z_STATUS,    p,20,              ; -- 130
    ; name,"light-screen",   t,T_PSYCHIC,  z,Z_STATUS,    p,30,              ; -- 131
    ; name,"haze",           t,T_ICE,      z,Z_STATUS,    p,30,              ; -- 132
    ; name,"focus-energy",   t,T_NORMAL,   z,Z_STATUS,    p,30,              ; -- 133
    ; name,"mirror-move",    t,T_FLYING,   z,Z_STATUS,    p,20,              ; -- 134
    ; name,"lick",           t,T_GHOST,    z,Z_PHYSICAL,  p,30, d,30,  a,1   ; -- 135
    ; name,"smog",           t,T_POISON,   z,Z_SPECIAL,   p,20, d,30,  a,.7  ; -- 136
    ; name,"sludge",         t,T_POISON,   z,Z_SPECIAL,   p,20, d,65,  a,1   ; -- 137
    ; name,"bone-club",      t,T_GROUND,   z,Z_PHYSICAL,  p,20, d,65,  a,.85 ; -- 138
    ; name,"waterfall",      t,T_WATER,    z,Z_PHYSICAL,  p,15, d,80,  a,1   ; -- 139
    ; name,"clamp",          t,T_WATER,    z,Z_PHYSICAL,  p,15, d,35,  a,.85 ; -- 140
    ; name,"spike-cannon",   t,T_NORMAL,   z,Z_PHYSICAL,  p,15, d,20,  a,1   ; -- 141
    ; name,"constrict",      t,T_NORMAL,   z,Z_PHYSICAL,  p,35, d,10,  a,1   ; -- 142
    ; name,"amnesia",        t,T_PSYCHIC,  z,Z_STATUS,    p,20,              ; -- 143
    ; name,"kinesis",        t,T_PSYCHIC,  z,Z_STATUS,    p,15,        a,.8  ; -- 144
    ; name,"high-jump-kick", t,T_FIGHTING, z,Z_PHYSICAL,  p,10, d,130, a,.9  ; -- 145
    ; name,"glare",          t,T_NORMAL,   z,Z_STATUS,    p,30,        a,1   ; -- 146
    ; name,"poison-gas",     t,T_POISON,   z,Z_STATUS,    p,40,        a,.9  ; -- 147
    ; name,"barrage",        t,T_NORMAL,   z,Z_PHYSICAL,  p,20, d,15,  a,.85 ; -- 148
    ; name,"leech-life",     t,T_BUG,      z,Z_PHYSICAL,  p,10, d,80,  a,1   ; -- 149
    ; name,"lovely-kiss",    t,T_NORMAL,   z,Z_STATUS,    p,10,        a,.75 ; -- 150
    ; name,"transform",      t,T_NORMAL,   z,Z_STATUS,    p,10,              ; -- 151
    ; name,"bubble",         t,T_WATER,    z,Z_SPECIAL,   p,30, d,40,  a,1   ; -- 152
    ; name,"dizzy-punch",    t,T_NORMAL,   z,Z_PHYSICAL,  p,10, d,70,  a,1   ; -- 153
    ; name,"spore",          t,T_GRASS,    z,Z_STATUS,    p,15,        a,1   ; -- 154
    ; name,"splash",         t,T_NORMAL,   z,Z_STATUS,    p,40,              ; -- 155
    ; name,"acid-armor",     t,T_POISON,   z,Z_STATUS,    p,20,              ; -- 156
    ; name,"crabhammer",     t,T_WATER,    z,Z_PHYSICAL,  p,10, d,100, a,.9  ; -- 157
    ; name,"fury-swipes",    t,T_NORMAL,   z,Z_PHYSICAL,  p,15, d,18,  a,.8  ; -- 158
    ; name,"bonemerang",     t,T_GROUND,   z,Z_PHYSICAL,  p,10, d,50,  a,.9  ; -- 159
    ; name,"hyper-fang",     t,T_NORMAL,   z,Z_PHYSICAL,  p,15, d,80,  a,.9  ; -- 160
    ; name,"sharpen",        t,T_NORMAL,   z,Z_STATUS,    p,30,              ; -- 161
    ; name,"conversion",     t,T_NORMAL,   z,Z_STATUS,    p,30,              ; -- 162
    ; name,"super-fang",     t,T_NORMAL,   z,Z_PHYSICAL,  p,10,        a,.9  ; -- 163
    ; name,"slash",          t,T_NORMAL,   z,Z_PHYSICAL,  p,20, d,70,  a,1   ; -- 164
]]
