c_pokemon = zobj[[
    -- "name"         w     h   t1          t2           hp   att  def  spd  spc  movenums/levels string
   0;, "missingno",   10,   10, T_BIRD,     T_NORMAL,    33,  136, 0,   29,  6,   43|12,1|1
   ;;, "bulbasaur",   69,   7,  T_GRASS,    T_POISON,    45,  49,  49,  45,  65,  88|79|105|70|108|107|106|110|22,1|1|7|13|20|27|34|41|48
   ;;, "ivysaur",     130,  10, T_GRASS,    T_POISON,    60,  62,  63,  60,  80,  88|105|79|70|108|107|106|110|22,1|1|1|13|22|30|38|46|54
   ;;, "venusaur",    1000, 20, T_GRASS,    T_POISON,    80,  82,  83,  80,  100, 88|105|79|70|108|107|106|110|22,1|1|1|1|22|30|43|55|65
   ;;, "charmander",  85,   6,  T_FIRE,     T_NONE,      39,  52,  43,  65,  50,  88|63|95|86|20|164|96|113,1|1|9|15|22|30|38|46
   ;;, "charmeleon",  190,  11, T_FIRE,     T_NONE,      58,  64,  58,  80,  65,  95|88|63|86|20|164|96|113,1|1|1|15|24|33|42|56
   ;;, "charizard",   905,  17, T_FIRE,     T_FLYING,    78,  84,  78,  100, 85,  95|88|86|63|20|164|96|113,1|1|1|1|24|36|46|55
   ;;, "squirtle",    90,   5,  T_WATER,    T_NONE,      44,  48,  65,  43,  50,  79|82|152|12|87|128|40|98,1|1|8|15|22|28|35|42
   ;;, "wartortle",   225,  10, T_WATER,    T_NONE,      59,  63,  80,  58,  65,  152|79|82|12|87|128|40|98,1|1|1|15|24|31|39|47
   ;;, "blastoise",   855,  16, T_WATER,    T_NONE,      79,  83,  100, 78,  85,  152|79|82|12|87|128|40|98,1|1|1|1|24|31|42|52
   ;;, "caterpie",    29,   3,  T_BUG,      T_NONE,      45,  30,  35,  45,  20,  112|79,1|1
   ;;, "metapod",     99,   7,  T_BUG,      T_NONE,      50,  20,  55,  30,  25,  124,1
   ;;, "butterfree",  320,  11, T_BUG,      T_FLYING,    60,  45,  50,  70,  80,  116|108|109|110|91|4|99,1|15|16|17|21|26|32
   ;;, "weedle",      32,   3,  T_BUG,      T_POISON,    40,  35,  30,  50,  20,  83|112,1|1
   ;;, "kakuna",      100,  6,  T_BUG,      T_POISON,    45,  25,  50,  35,  25,  124,1
   ;;, "beedrill",    295,  10, T_BUG,      T_POISON,    65,  80,  40,  75,  45,  78|133|84|20|85|119,1|16|20|25|30|35
   ;;, "pidgey",      18,   3,  T_NORMAL,   T_FLYING,    40,  45,  40,  56,  35,  66|75|120|4|67|119|134,1|5|12|19|28|36|44
   ;;, "pidgeotto",   300,  11, T_NORMAL,   T_FLYING,    63,  60,  55,  71,  50,  66|75|120|4|67|119|134,1|1|12|21|31|40|49
   ;;, "pidgeot",     395,  15, T_NORMAL,   T_FLYING,    83,  80,  75,  91,  70,  66|120|75|4|67|119|134,1|1|1|21|31|44|54
   ;;, "rattata",     35,   3,  T_NORMAL,   T_NONE,      30,  56,  35,  72,  25,  79|82|120|160|133|163,1|1|7|14|23|34
   ;;, "raticate",    185,  7,  T_NORMAL,   T_NONE,      55,  81,  60,  97,  50,  120|79|82|160|133|163,1|1|1|14|27|41
   ;;, "spearow",     20,   3,  T_NORMAL,   T_FLYING,    40,  60,  30,  70,  31,  88|101|86|78|134|102|119,1|1|9|15|22|29|36
   ;;, "fearow",      380,  12, T_NORMAL,   T_FLYING,    65,  90,  65,  100, 61,  88|86|101|78|134|102|119,1|1|1|15|25|34|43
   ;;, "ekans",       69,   20, T_POISON,   T_NONE,      35,  60,  44,  55,  40,  86|80|83|87|146|122|94,1|1|10|17|24|31|38
   ;;, "arbok",       650,  35, T_POISON,   T_NONE,      60,  85,  69,  80,  65,  86|83|80|87|146|122|94,1|1|1|17|27|36|47
   ;;, "pikachu",     60,   4,  T_ELECTRIC, T_NONE,      35,  55,  30,  90,  50,  88|114|45|120|39|119|25,1|1|9|16|26|33|43
   ;;, "raichu",      300,  8,  T_ELECTRIC, T_NONE,      60,  90,  55,  100, 90,  88|114|45,1|1|1
   ;;, "sandshrew",   120,  6,  T_GROUND,   T_NONE,      50,  75,  85,  40,  30,  63|75|164|83|39|158,1|10|17|24|31|38
   ;;, "sandslash",   295,  10, T_GROUND,   T_NONE,      75,  100, 110, 65,  55,  75|63|164|83|39|158,1|1|17|27|36|47
   ;;, "nidoran?",    70,   4,  T_POISON,   T_NONE,      55,  47,  52,  41,  40,  88|79|63|83|82|87|158|72,1|1|8|14|21|29|36|43
   ;;, "nidorina",    200,  8,  T_POISON,   T_NONE,      70,  62,  67,  56,  55,  88|79|63|83|82|87|158|72,1|1|8|14|23|32|41|50
   ;;, "nidoqueen",   600,  13, T_POISON,   T_GROUND,    90,  82,  87,  76,  75,  8|63|79|82|83,1|1|1|1|14
   ;;, "nidoran!",    90,   5,  T_POISON,   T_NONE,      46,  57,  40,  50,  40,  86|79|77|83|133|78|7|72,1|1|8|14|21|29|36|43
   ;;, "nidorino",    195,  9,  T_POISON,   T_NONE,      61,  72,  57,  65,  55,  77|86|79|83|133|78|7|72,1|1|1|14|23|32|41|50
   ;;, "nidoking",    620,  14, T_POISON,   T_GROUND,    81,  92,  77,  85,  75,  77|83|79|81,1|1|1|1
   ;;, "clefairy",    75,   6,  T_NORMAL,   T_NONE,      70,  45,  48,  35,  60,  88|56|90|58|125|35|129|131,1|1|13|18|24|31|39|48
   ;;, "clefable",    400,  13, T_NORMAL,   T_NONE,      95,  70,  73,  60,  85,  58|35|125|90,1|1|1|1
   ;;, "vulpix",      99,   6,  T_FIRE,     T_NONE,      38,  41,  40,  65,  65,  95|82|120|89|127|96|113,1|1|16|21|28|35|42
   ;;, "ninetales",   199,  11, T_FIRE,     T_NONE,      73,  76,  75,  100, 100, 95|120|89|82,1|1|1|1
   ;;, "jigglypuff",  55,   5,  T_NORMAL,   T_NONE,      115, 45,  20,  20,  25,  90|56|93|129|58|44|8|10,1|9|14|19|24|29|34|39
   ;;, "wigglytuff",  120,  10, T_NORMAL,   T_NONE,      140, 70,  45,  45,  50,  129|93|58|90,1|1|1|1
   ;;, "zubat",       75,   8,  T_POISON,   T_FLYING,    40,  45,  35,  55,  40,  149|91|87|127|67|132,1|10|15|21|28|36
   ;;, "golbat",      550,  16, T_POISON,   T_FLYING,    75,  80,  70,  90,  75,  87|149|122|91|127|67|132,1|1|1|10|21|32|43
   ;;, "oddish",      54,   5,  T_GRASS,    T_POISON,    45,  50,  55,  30,  75,  104|108|109|110|94|111|22,1|15|17|19|24|33|46
   ;;, "gloom",       86,   8,  T_GRASS,    T_POISON,    60,  65,  70,  40,  85,  104|108|109|110|94|111|22,1|1|1|19|28|38|52
   ;;, "vileplume",   186,  12, T_GRASS,    T_POISON,    75,  80,  85,  50,  100, 94|111|110|109|108,1|1|1|1|15
   ;;, "paras",       54,   3,  T_BUG,      T_GRASS,     35,  70,  55,  25,  55,  63|109|149|154|164|106,1|13|20|27|34|41
   ;;, "parasect",    295,  10, T_BUG,      T_GRASS,     60,  95,  80,  30,  80,  149|63|109|154|164|106,1|1|1|30|39|48
   ;;, "venonat",     300,  10, T_BUG,      T_POISON,    60,  55,  50,  45,  40,  93|79|108|149|109|99|110|29,1|1|24|27|30|35|38|43
   ;;, "venomoth",    125,  15, T_BUG,      T_POISON,    70,  65,  60,  90,  90,  93|149|108|79|109|99|110|29,1|1|1|1|30|38|43|50
   ;;, "diglett",     8,    2,  T_GROUND,   T_NONE,      10,  55,  25,  95,  45,  63|88|28|75|164|26,1|15|19|24|31|40
   ;;, "dugtrio",     333,  7,  T_GROUND,   T_NONE,      35,  80,  50,  120, 70,  28|88|63|75|164|26,1|1|1|24|35|47
   ;;, "meowth",      42,   4,  T_NORMAL,   T_NONE,      40,  45,  35,  90,  40,  88|63|87|16|122|158|164,1|1|12|17|24|33|44
   ;;, "persian",     320,  10, T_NORMAL,   T_NONE,      65,  70,  60,  115, 65,  87|88|63|122|16|158|164,1|1|1|1|17|37|51
   ;;, "psyduck",     196,  8,  T_WATER,    T_NONE,      50,  52,  48,  55,  50,  63|82|93|116|158|98,1|28|31|36|43|52
   ;;, "golduck",     766,  17, T_WATER,    T_NONE,      80,  82,  78,  85,  80,  93|63|82|116|158|98,1|1|1|39|48|59
   ;;, "mankey",      280,  5,  T_FIGHTING, T_NONE,      40,  80,  35,  70,  35,  86|63|57|158|133|19|81,1|1|15|21|27|33|39
   ;;, "primeape",    320,  10, T_FIGHTING, T_NONE,      65,  105, 60,  95,  60,  158|57|86|63|133|19|81,1|1|1|1|27|37|46
   ;;, "growlithe",   190,  7,  T_FIRE,     T_NONE,      55,  70,  45,  60,  50,  87|89|95|86|9|119|96,1|1|18|23|30|39|50
   ;;, "arcanine",    1550, 19, T_FIRE,     T_NONE,      90,  110, 80,  95,  80,  95|86|89|9,1|1|1|1
   ;;, "poliwag",     124,  6,  T_WATER,    T_NONE,      40,  50,  40,  90,  40,  152|117|12|58|8|143|98,1|16|19|25|31|38|45
   ;;, "poliwhirl",   200,  10, T_WATER,    T_NONE,      65,  65,  65,  90,  50,  152|117|12|58|8|143|98,1|1|1|26|33|41|49
   ;;, "poliwrath",   540,  13, T_WATER,    T_FIGHTING,  90,  85,  95,  70,  70,  8|58|117|12,1|1|1|1
   ;;, "abra",        195,  9,  T_PSYCHIC,  T_NONE,      25,  20,  15,  90,  105, 30,1
   ;;, "kadabra",     565,  13, T_PSYCHIC,  T_NONE,      40,  35,  30,  105, 120, 116|93|30|99|123|29|33,1|1|1|27|31|38|42
   ;;, "alakazam",    480,  15, T_PSYCHIC,  T_NONE,      55,  50,  45,  120, 135, 116|93|30|99|123|29|33,1|1|1|27|31|38|42
   ;;, "machop",      195,  8,  T_FIGHTING, T_NONE,      70,  80,  50,  35,  35,  57|103|86|133|19|17,1|20|25|32|39|46
   ;;, "machoke",     705,  15, T_FIGHTING, T_NONE,      80,  100, 70,  45,  50,  57|86|103|133|19|17,1|1|1|36|44|52
   ;;, "machamp",     1300, 16, T_FIGHTING, T_NONE,      90,  130, 80,  55,  65,  57|86|103|133|19|17,1|1|1|36|44|52
   ;;, "bellsprout",  40,   7,  T_GRASS,    T_POISON,    50,  75,  35,  40,  70,  106|70|80|108|110|109|94|107|69,1|1|13|15|18|21|26|33|42
   ;;, "weepinbell",  64,   10, T_GRASS,    T_POISON,    65,  90,  50,  55,  85,  106|70|80|108|110|109|94|107|69,1|1|1|15|18|23|29|38|49
   ;;, "victreebel",  155,  17, T_GRASS,    T_POISON,    80,  105, 65,  70,  100, 94|107|110|109|80|108,1|1|1|1|13|15
   ;;, "tentacool",   455,  9,  T_WATER,    T_POISON,    40,  40,  35,  70,  100, 94|91|80|83|12|142|130|122|98,1|7|13|18|22|27|33|40|48
   ;;, "tentacruel",  550,  16, T_WATER,    T_POISON,    80,  70,  65,  100, 120, 94|91|80|83|12|142|130|122|98,1|1|1|18|22|27|35|43|50
   ;;, "geodude",     200,  4,  T_ROCK,     T_GROUND,    40,  80,  100, 20,  30,  79|129|115|36|124|26|47,1|11|16|21|26|31|36
   ;;, "graveler",    1050, 10, T_ROCK,     T_GROUND,    55,  95,  115, 35,  45,  129|79|115|36|124|26|47,1|1|16|21|29|36|43
   ;;, "golem",       3000, 14, T_ROCK,     T_GROUND,    80,  110, 130, 45,  55,  129|79|115|36|124|26|47,1|1|16|21|29|36|43
   ;;, "ponyta",      300,  10, T_FIRE,     T_NONE,      50,  85,  55,  90,  65,  95|82|71|88|113|9|119,1|30|32|35|39|43|48
   ;;, "rapidash",    950,  17, T_FIRE,     T_NONE,      65,  100, 70,  105, 80,  95|88|71|82|113|9|119,1|1|1|1|39|47|55
   ;;, "slowpoke",    360,  12, T_WATER,    T_PSYCHIC,   90,  65,  65,  15,  40,  116|93|76|88|12|143|29,1|18|22|27|33|40|48
   ;;, "slowbro",     785,  16, T_WATER,    T_PSYCHIC,   95,  75,  110, 30,  80,  116|93|76|88|12|128|143|29,1|1|1|27|33|37|44|55
   ;;, "magnemite",   60,   3,  T_ELECTRIC, T_NONE,      25,  35,  70,  45,  95,  79|92|114|91|45|39|122,1|21|25|29|35|41|47
   ;;, "magneton",    600,  10, T_ELECTRIC, T_NONE,      50,  60,  95,  70,  120, 92|79|114|91|45|39|122,1|1|1|29|38|46|54
   ;;, "farfetch'd",  150,  8,  T_NORMAL,   T_FLYING,    52,  65,  55,  60,  58,  101|75|86|78|3|119|164,1|1|7|15|23|31|39
   ;;, "doduo",       392,  14, T_NORMAL,   T_FLYING,    35,  85,  45,  75,  35,  101|88|78|102|20|49|119,1|20|24|30|36|40|44
   ;;, "dodrio",      852,  18, T_NORMAL,   T_FLYING,    60,  110, 70,  100, 60,  78|88|101|102|20|49|119,1|1|1|30|39|45|51
   ;;, "seel",        900,  11, T_WATER,    T_NONE,      65,  45,  55,  45,  70,  76|88|100|44|9|13,1|30|35|40|45|50
   ;;, "dewgong",     1200, 17, T_WATER,    T_ICE,       90,  70,  80,  70,  95,  100|88|76|44|9|13,1|1|1|44|50|56
   ;;, "grimer",      300,  9,  T_POISON,   T_NONE,      80,  80,  50,  25,  40,  93|56|147|125|137|124|122|156,1|1|30|33|37|42|48|55
   ;;, "muk",         300,  12, T_POISON,   T_NONE,      105, 105, 75,  50,  65,  93|147|56|125|137|124|122|156,1|1|1|33|37|45|53|60
   ;;, "shellder",    40,   3,  T_WATER,    T_NONE,      30,  65,  100, 40,  45,  79|128|91|140|100|86|13,1|1|18|23|30|39|50
   ;;, "cloyster",    1325, 15, T_WATER,    T_ICE,       50,  95,  180, 70,  85,  100|140|91|128|141,1|1|1|1|50
   ;;, "gastly",      1,    13, T_GHOST,    T_POISON,    30,  35,  30,  80,  100, 127|135|121|117|42,1|1|1|27|35
   ;;, "haunter",     1,    16, T_GHOST,    T_POISON,    45,  50,  45,  95,  115, 127|135|121|117|42,1|1|1|29|38
   ;;, "gengar",      405,  15, T_GHOST,    T_POISON,    60,  65,  60,  110, 130, 127|135|121|117|42,1|1|1|29|38
   ;;, "onix",        2100, 88, T_ROCK,     T_GROUND,    35,  45,  160, 70,  30,  122|79|68|115|20|69|124,1|1|15|19|25|33|43
   ;;, "drowzee",     324,  10, T_PSYCHIC,  T_NONE,      60,  48,  45,  42,  90,  117|56|93|116|76|147|29|118,1|1|12|17|24|29|32|37
   ;;, "hypno",       756,  16, T_PSYCHIC,  T_NONE,      85,  73,  70,  67,  115, 116|93|117|56|76|147|29|118,1|1|1|1|24|33|37|43
   ;;, "krabby",      65,   4,  T_WATER,    T_NONE,      30,  105, 90,  50,  25,  152|86|64|65|71|157|124,1|1|20|25|30|35|40
   ;;, "kingler",     600,  13, T_WATER,    T_NONE,      55,  130, 115, 75,  50,  152|86|64|65|71|157|124,1|1|1|25|34|42|49
   ;;, "voltorb",     104,  5,  T_ELECTRIC, T_NONE,      40,  30,  50,  100, 55,  122|79|92|36|131|39|47,1|1|17|22|29|36|43
   ;;, "electrode",   666,  12, T_ELECTRIC, T_NONE,      60,  50,  70,  140, 80,  122|92|79|36|131|39|47,1|1|1|22|29|40|50
   ;;, "exeggcute",   25,   4,  T_GRASS,    T_PSYCHIC,   60,  40,  80,  40,  60,  148|117|33|105|109|108|22|110,1|1|25|28|32|37|42|48
   ;;, "exeggutor",   1200, 20, T_GRASS,    T_PSYCHIC,   95,  95,  85,  55,  125, 148|117|71,1|1|28
   ;;, "cubone",      65,   4,  T_GROUND,   T_NONE,      50,  50,  95,  35,  40,  138|88|86|133|81|159|20,1|1|25|31|38|43|46
   ;;, "marowak",     450,  10, T_GROUND,   T_NONE,      60,  80,  110, 45,  50,  138|133|88|86|81|159|20,1|1|1|1|41|48|55
   ;;, "hitmonlee",   498,  15, T_FIGHTING, T_NONE,      50,  120, 53,  87,  35,  72|118|74|73|133|145|5,1|1|33|38|43|48|53
   ;;, "hitmonchan",  502,  14, T_FIGHTING, T_NONE,      50,  105, 79,  76,  35,  119|59|60|61|62|1|18,1|1|33|38|43|48|53
   ;;, "lickitung",   655,  12, T_NORMAL,   T_NONE,      90,  55,  75,  30,  60,  91|80|71|93|129|69|122,1|1|7|15|23|31|39
   ;;, "koffing",     10,   6,  T_POISON,   T_NONE,      40,  65,  95,  35,  60,  136|79|137|126|36|132|47,1|1|32|37|40|45|48
   ;;, "weezing",     95,   12, T_POISON,   T_NONE,      65,  90,  120, 60,  85,  137|136|79|126|36|132|47,1|1|1|39|43|49|53
   ;;, "rhyhorn",     1150, 10, T_GROUND,   T_ROCK,      80,  85,  95,  25,  30,  77|71|82|78|7|86|9,1|30|35|40|45|50|55
   ;;, "rhydon",      1200, 19, T_GROUND,   T_ROCK,      105, 130, 120, 40,  45,  78|77|71|82|7|86|9,1|1|1|1|48|55|64
   ;;, "chansey",     346,  11, T_NORMAL,   T_NONE,      250, 5,   5,   50,  105, 58|56|90|88|125|129|131|10,1|1|24|30|38|44|48|54
   ;;, "tangela",     350,  10, T_GRASS,    T_NONE,      65,  55,  115, 60,  100, 68|142|104|108|109|110|69|106,1|1|29|32|36|39|45|49
   ;;, "kangaskhan",  800,  22, T_NORMAL,   T_NONE,      105, 95,  80,  90,  40,  59|20|87|82|1|86|153,1|1|26|31|36|41|46
   ;;, "horsea",      80,   4,  T_WATER,    T_NONE,      30,  40,  70,  60,  70,  152|126|86|12|119|98,1|19|24|30|37|45
   ;;, "seadra",      250,  12, T_WATER,    T_NONE,      55,  65,  95,  85,  95,  152|126|86|12|119|98,1|1|24|30|41|52
   ;;, "goldeen",     150,  6,  T_WATER,    T_NONE,      45,  67,  60,  63,  50,  101|82|91|77|78|139|7|119,1|1|19|24|30|37|45|54
   ;;, "seaking",     390,  13, T_WATER,    T_NONE,      80,  92,  65,  68,  80,  101|91|82|77|78|139|7|119,1|1|1|24|30|39|48|54
   ;;, "staryu",      345,  8,  T_WATER,    T_NONE,      30,  45,  55,  85,  70,  79|12|124|123|39|125|131|98,1|17|22|27|32|37|42|47
   ;;, "starmie",     800,  11, T_WATER,    T_PSYCHIC,   60,  75,  85,  115, 100, 124|79|12,1|1|1
   ;;, "mr mime",     545,  13, T_PSYCHIC,  T_NONE,      40,  45,  65,  90,  100, 130|116|131|58|118|50,1|1|23|31|39|47
   ;;, "scyther",     560,  15, T_BUG,      T_FLYING,    70,  110, 80,  105, 55,  120|86|133|32|164|3|119,1|17|20|24|29|35|42
   ;;, "jynx",        406,  14, T_ICE,      T_PSYCHIC,   65,  50,  35,  95,  95,  150|56|135|58|61|8|81|14,1|1|18|23|31|39|47|58
   ;;, "electabuzz",  300,  11, T_ELECTRIC, T_NONE,      65,  83,  57,  105, 85,  86|120|114|122|62|131|25,1|1|34|37|42|49|54
   ;;, "magmar",      445,  13, T_FIRE,     T_NONE,      65,  95,  57,  93,  85,  95|86|127|60|126|136|96,1|36|39|43|48|52|55
   ;;, "pinsir",      550,  15, T_BUG,      T_NONE,      65,  125, 100, 85,  55,  64|19|65|133|124|164|3,1|25|30|36|43|49|54
   ;;, "tauros",      884,  14, T_NORMAL,   T_NONE,      75,  100, 95,  110, 70,  79|71|82|86|20|9,1|21|28|35|44|51
   ;;, "magikarp",    100,  9,  T_WATER,    T_NONE,      20,  10,  55,  80,  20,  155|79,1|15
   ;;, "gyarados",    2350, 65, T_WATER,    T_FLYING,    95,  125, 79,  81,  100, 87|23|98|86|15,1|1|1|1|52
   ;;, "lapras",      2200, 25, T_WATER,    T_ICE,       130, 85,  80,  60,  95,  88|12|90|97|8|127|13|98,1|1|16|20|25|31|38|46
   ;;, "ditto",       40,   3,  T_NORMAL,   T_NONE,      48,  48,  48,  48,  48,  151,1
   ;;, "eevee",       65,   3,  T_NORMAL,   T_NONE,      55,  55,  50,  55,  65,  75|79|120|82|87|9,1|1|27|31|37|45
   ;;, "vaporeon",    290,  10, T_WATER,    T_NONE,      130, 65,  60,  65,  110, 120|75|79|12|82|87|156|132|97|98,1|1|1|1|37|40|42|44|48|54
   ;;, "jolteon",     245,  8,  T_ELECTRIC, T_NONE,      65,  65,  60,  130, 110, 120|75|79|114|82|45|72|119|85|25,1|1|1|1|37|40|42|44|48|54
   ;;, "flareon",     250,  9,  T_FIRE,     T_NONE,      65,  130, 60,  65,  110, 95|120|75|79|82|87|86|113|20|96,1|1|1|1|37|40|42|44|48|54
   ;;, "porygon",     365,  8,  T_NORMAL,   T_NONE,      65,  60,  70,  40,  75,  162|161|79|99|123|119|49,1|1|1|23|28|35|42
   ;;, "omanyte",     75,   4,  T_ROCK,     T_WATER,     35,  40,  100, 35,  90,  12|128|77|86|141|98,1|1|34|39|46|53
   ;;, "omastar",     350,  10, T_ROCK,     T_WATER,     70,  60,  125, 55,  115, 77|12|128|86|141|98,1|1|1|39|44|49
   ;;, "kabuto",      115,  5,  T_ROCK,     T_WATER,     30,  80,  90,  55,  45,  124|63|104|164|86|98,1|1|34|39|44|49
   ;;, "kabutops",    405,  13, T_ROCK,     T_WATER,     60,  115, 105, 80,  70,  104|124|63|164|86|98,1|1|1|39|46|53
   ;;, "aerodactyl",  590,  18, T_ROCK,     T_FLYING,    80,  105, 65,  130, 60,  119|67|91|87|9|15,1|1|33|38|45|54
   ;;, "snorlax",     4600, 21, T_NORMAL,   T_NONE,      160, 110, 65,  30,  65,  143|76|44|8|124|10|15,1|1|1|35|41|48|56
   ;;, "articuno",    554,  17, T_ICE,      T_FLYING,    90,  85,  100, 85,  125, 13|101|14|119|97,1|1|51|55|60
   ;;, "zapdos",      526,  16, T_ELECTRIC, T_FLYING,    90,  90,  85,  100, 125, 102|114|25|119|131,1|1|51|55|60
   ;;, "moltres",     600,  20, T_FIRE,     T_FLYING,    90,  100, 90,  90,  125, 113|101|86|119|43,1|1|51|55|60
   ;;, "dratini",     33,   18, T_DRAGON,   T_NONE,      41,  64,  45,  50,  50,  86|80|45|119|69|23|15,1|1|10|20|30|40|50
   ;;, "dragonair",   165,  40, T_DRAGON,   T_NONE,      61,  84,  65,  70,  70,  86|45|80|119|69|23|15,1|1|1|20|35|45|55
   ;;, "dragonite",   2100, 22, T_DRAGON,   T_FLYING,    91,  134, 95,  80,  100, 119|86|45|80|69|23|15,1|1|1|1|35|45|60
   ;;, "mewtwo",      1220, 20, T_PSYCHIC,  T_NONE,      106, 110, 90,  130, 154, 116|93|29|39|130|123|97|143,1|1|1|1|63|70|75|81
   ;;, "mew",         40,   4,  T_PSYCHIC,  T_NONE,      100, 100, 100, 100, 100, 56|151|1|35|29,1|10|20|30|40
]]

-- includes type effectiveness chart. according to the gen 1 games, which had bugs. i'm keeping the bugs :).
c_types = zobj[[
    0;bg,0, name,"bird",     T_BIRD;     good;,;                                  T_BIRD;     null;,;                   T_BIRD;     weak;,
   ;; bg,0, name,"normal",   T_NORMAL;   good;,;                                  T_NORMAL;   null;,T_GHOST;            T_NORMAL;   weak;,T_ROCK
   ;; bg,5, name,"fire",     T_FIRE;     good;,T_GRASS,T_ICE,T_BUG;               T_FIRE;     null;,;                   T_FIRE;     weak;,T_FIRE,T_WATER,T_ROCK,T_DRAGON
   ;; bg,4, name,"water",    T_WATER;    good;,T_FIRE,T_GROUND,T_ROCK;            T_WATER;    null;,;                   T_WATER;    weak;,T_DRAGON,T_GRASS,T_WATER
   ;; bg,6, name,"electric", T_ELECTRIC; good;,T_FLYING,T_WATER;                  T_ELECTRIC; null;,T_GROUND;           T_ELECTRIC; weak;,T_DRAGON,T_ELECTRIC,T_GRASS
   ;; bg,3, name,"grass",    T_GRASS;    good;,T_GROUND,T_ROCK,T_WATER;           T_GRASS;    null;,;                   T_GRASS;    weak;,T_BUG,T_DRAGON,T_FIRE,T_FLYING,T_GRASS,T_POISON
   ;; bg,4, name,"ice",      T_ICE;      good;,T_DRAGON,T_FLYING,T_GRASS;         T_ICE;      null;,;                   T_ICE;      weak;,T_FIRE,T_ICE,T_WATER
   ;; bg,2, name,"fighting", T_FIGHTING; good;,T_ICE,T_NORMAL,T_ROCK;             T_FIGHTING; null;,T_GHOST;            T_FIGHTING; weak;,T_BUG,T_FLYING,T_POISON,T_PSYCHIC
   ;; bg,1, name,"poison",   T_POISON;   good;,T_BUG,T_GRASS;                     T_POISON;   null;,;                   T_POISON;   weak;,T_GHOST,T_GROUND,T_POISON,T_ROCK
   ;; bg,2, name,"ground",   T_GROUND;   good;,T_ELECTRIC,T_FIRE,T_POISON,T_ROCK; T_GROUND;   null;,T_FLYING;           T_GROUND;   weak;,T_BUG,T_GRASS
   ;; bg,0, name,"flying",   T_FLYING;   good;,T_BUG,T_FIGHTING,T_GRASS;          T_FLYING;   null;,;                   T_FLYING;   weak;,T_ELECTRIC,T_ROCK
   ;; bg,1, name,"psychic",  T_PSYCHIC;  good;,T_FIGHTING,T_POISON;               T_PSYCHIC;  null;,;                   T_PSYCHIC;  weak;,T_PSYCHIC
   ;; bg,3, name,"bug",      T_BUG;      good;,T_GRASS,T_PSYCHIC;                 T_BUG;      null;,;                   T_BUG;      weak;,T_FIGHTING,T_FIRE,T_FLYING,T_GHOST,T_POISON
   ;; bg,0, name,"rock",     T_ROCK;     good;,T_BUG,T_FIRE,T_FLYING,T_ICE;       T_ROCK;     null;,;                   T_ROCK;     weak;,T_FIGHTING,T_GROUND
   ;; bg,1, name,"ghost",    T_GHOST;    good;,T_GHOST;                           T_GHOST;    null;,T_NORMAL,T_PSYCHIC; T_GHOST;    weak;,
   ;; bg,0, name,"dragon",   T_DRAGON;   good;,T_DRAGON;                          T_DRAGON;   null;,;                   T_DRAGON;   weak;,
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
   -- "name",      type        category    pp  dmg  acc
    0;"struggle",  T_NORMAL,   Z_PHYSICAL, ,   50,

    -- tms
   ;; "megapunch", T_NORMAL,   Z_PHYSICAL, 20, 80,  .85 -- 1
   ;; "razorwind", T_NORMAL,   Z_SPECIAL,  10, 80,  1   -- 2
   ;; "swordance", T_NORMAL,   Z_STATUS,   20, ,        -- 3
   ;; "whirlwind", T_NORMAL,   Z_STATUS,   20, ,        -- 4
   ;; "megakick",  T_NORMAL,   Z_PHYSICAL, 5,  120, .75 -- 5
   ;; "toxic",     T_POISON,   Z_STATUS,   10, ,    .9  -- 6
   ;; "horndril|", T_NORMAL,   Z_PHYSICAL, 5,  ,    .3  -- 7
   ;; "bodyslam",  T_NORMAL,   Z_PHYSICAL, 15, 85,  1   -- 8
   ;; "takedown",  T_NORMAL,   Z_PHYSICAL, 20, 90,  .85 -- 9
   ;; "doubledge", T_NORMAL,   Z_PHYSICAL, 15, 120, 1   -- 10
   ;; "bublebeam", T_WATER,    Z_SPECIAL,  20, 65,  1   -- 11
   ;; "watergun",  T_WATER,    Z_SPECIAL,  25, 40,  1   -- 12
   ;; "icebeam",   T_ICE,      Z_SPECIAL,  10, 90,  1   -- 13
   ;; "blizzard",  T_ICE,      Z_SPECIAL,  5,  110, .7  -- 14
   ;; "hyperbeam", T_NORMAL,   Z_SPECIAL,  5,  150, .9  -- 15
   ;; "payday",    T_NORMAL,   Z_PHYSICAL, 20, 40,  1   -- 16
   ;; "submision", T_FIGHTING, Z_PHYSICAL, 20, 80,  .8  -- 17
   ;; "counter",   T_FIGHTING, Z_PHYSICAL, 20, ,    1   -- 18
   ;; "seismctss", T_FIGHTING, Z_PHYSICAL, 20, ,    1   -- 19
   ;; "rage",      T_NORMAL,   Z_PHYSICAL, 20, 20,  1   -- 20
   ;; "megadrain", T_GRASS,    Z_SPECIAL,  15, 40,  1   -- 21
   ;; "solarbeam", T_GRASS,    Z_SPECIAL,  10, 120, 1   -- 22
   ;; "drgonrage", T_DRAGON,   Z_SPECIAL,  10, ,    1   -- 23
   ;; "thndrbolt", T_ELECTRIC, Z_SPECIAL,  15, 90,  1   -- 24
   ;; "thunder",   T_ELECTRIC, Z_SPECIAL,  10, 110, .7  -- 25
   ;; "eartquake", T_GROUND,   Z_PHYSICAL, 10, 100, 1   -- 26
   ;; "fissure",   T_GROUND,   Z_PHYSICAL, 5,  ,    .3  -- 27
   ;; "dig",       T_GROUND,   Z_PHYSICAL, 10, 80,  1   -- 28
   ;; "psychic",   T_PSYCHIC,  Z_SPECIAL,  10, 90,  1   -- 29
   ;; "teleport",  T_PSYCHIC,  Z_STATUS,   20, ,        -- 30
   ;; "mimic",     T_NORMAL,   Z_STATUS,   10, ,        -- 31
   ;; "dubleteam", T_NORMAL,   Z_STATUS,   15, ,        -- 32
   ;; "reflect",   T_PSYCHIC,  Z_STATUS,   20, ,        -- 33
   ;; "bide",      T_NORMAL,   Z_PHYSICAL, 10, ,        -- 34
   ;; "metronome", T_NORMAL,   Z_STATUS,   10, ,        -- 35
   ;; "slfdstrct", T_NORMAL,   Z_PHYSICAL, 5,  200, 1   -- 36
   ;; "eggbomb",   T_NORMAL,   Z_PHYSICAL, 10, 100, .75 -- 37
   ;; "fireblast", T_FIRE,     Z_SPECIAL,  5,  110, .85 -- 38
   ;; "swift",     T_NORMAL,   Z_SPECIAL,  20, 60,      -- 39
   ;; "skullbash", T_NORMAL,   Z_PHYSICAL, 10, 130, 1   -- 40
   ;; "softboild", T_NORMAL,   Z_STATUS,   5,  ,        -- 41
   ;; "dreameatr", T_PSYCHIC,  Z_SPECIAL,  15, 100, 1   -- 42
   ;; "skyattack", T_FLYING,   Z_PHYSICAL, 5,  140, .9  -- 43
   ;; "rest",      T_PSYCHIC,  Z_STATUS,   5,  ,        -- 44
   ;; "thndrwave", T_ELECTRIC, Z_STATUS,   20, ,    .9  -- 45
   ;; "psywave",   T_PSYCHIC,  Z_SPECIAL,  15, ,    1   -- 46
   ;; "explosion", T_NORMAL,   Z_PHYSICAL, 5,  250, 1   -- 47
   ;; "rockslide", T_ROCK,     Z_PHYSICAL, 10, 75,  .9  -- 48
   ;; "triattack", T_NORMAL,   Z_SPECIAL,  10, 80,  1   -- 49
   ;; "sbstitute", T_NORMAL,   Z_STATUS,   10, ,        -- 50

    -- hms
   ;; "cut",       T_NORMAL,   Z_PHYSICAL, 30, 50,  .95 -- 51
   ;; "fly",       T_FLYING,   Z_PHYSICAL, 15, 90,  .95 -- 52
   ;; "surf",      T_WATER,    Z_SPECIAL,  15, 90,  1   -- 53
   ;; "strength",  T_NORMAL,   Z_PHYSICAL, 15, 80,  1   -- 54
   ;; "flash",     T_NORMAL,   Z_STATUS,   20, ,    1   -- 55

    -- remaining moves (besides struggle)
   ;; "pound",     T_NORMAL,   Z_PHYSICAL, 35, 40,  1   -- 56
   ;; "karatechp", T_FIGHTING, Z_PHYSICAL, 25, 50,  1   -- 57
   ;; "dubleslap", T_NORMAL,   Z_PHYSICAL, 10, 15,  .85 -- 58
   ;; "cometpnch", T_NORMAL,   Z_PHYSICAL, 15, 18,  .85 -- 59
   ;; "firepunch", T_FIRE,     Z_PHYSICAL, 15, 75,  1   -- 60
   ;; "icepunch",  T_ICE,      Z_PHYSICAL, 15, 75,  1   -- 61
   ;; "thndrpnch", T_ELECTRIC, Z_PHYSICAL, 15, 75,  1   -- 62
   ;; "scratch",   T_NORMAL,   Z_PHYSICAL, 35, 40,  1   -- 63
   ;; "vicegrip",  T_NORMAL,   Z_PHYSICAL, 30, 55,  1   -- 64
   ;; "guilotine", T_NORMAL,   Z_PHYSICAL, 5,  ,    .3  -- 65
   ;; "gust",      T_FLYING,   Z_SPECIAL,  35, 40,  1   -- 66
   ;; "wingattck", T_FLYING,   Z_PHYSICAL, 35, 60,  1   -- 67
   ;; "bind",      T_NORMAL,   Z_PHYSICAL, 20, 15,  .85 -- 68
   ;; "slam",      T_NORMAL,   Z_PHYSICAL, 20, 80,  .75 -- 69
   ;; "vinewhip",  T_GRASS,    Z_PHYSICAL, 25, 45,  1   -- 70
   ;; "stomp",     T_NORMAL,   Z_PHYSICAL, 20, 65,  1   -- 71
   ;; "dublekick", T_FIGHTING, Z_PHYSICAL, 30, 30,  1   -- 72
   ;; "jumpkick",  T_FIGHTING, Z_PHYSICAL, 10, 100, .95 -- 73
   ;; "rolingkck", T_FIGHTING, Z_PHYSICAL, 15, 60,  .85 -- 74
   ;; "sandattck", T_GROUND,   Z_STATUS,   15, ,    1   -- 75
   ;; "headbutt",  T_NORMAL,   Z_PHYSICAL, 15, 70,  1   -- 76
   ;; "hornattck", T_NORMAL,   Z_PHYSICAL, 25, 65,  1   -- 77
   ;; "furyattck", T_NORMAL,   Z_PHYSICAL, 20, 15,  .85 -- 78
   ;; "tackle",    T_NORMAL,   Z_PHYSICAL, 35, 40,  1   -- 79
   ;; "wrap",      T_NORMAL,   Z_PHYSICAL, 20, 15,  .9  -- 80
   ;; "thrash",    T_NORMAL,   Z_PHYSICAL, 10, 120, 1   -- 81
   ;; "tailwhip",  T_NORMAL,   Z_STATUS,   30, ,    1   -- 82
   ;; "psnsting",  T_POISON,   Z_PHYSICAL, 35, 15,  1   -- 83
   ;; "twineedle", T_BUG,      Z_PHYSICAL, 20, 25,  1   -- 84
   ;; "pinmisile", T_BUG,      Z_PHYSICAL, 20, 25,  .95 -- 85
   ;; "leer",      T_NORMAL,   Z_STATUS,   30, ,    1   -- 86
   ;; "bite",      T_NORMAL,   Z_PHYSICAL, 25, 60,  1   -- 87
   ;; "growl",     T_NORMAL,   Z_STATUS,   40, ,    1   -- 88
   ;; "roar",      T_NORMAL,   Z_STATUS,   20, ,        -- 89
   ;; "sing",      T_NORMAL,   Z_STATUS,   15, ,    .55 -- 90
   ;; "suprsonic", T_NORMAL,   Z_STATUS,   20, ,    .55 -- 91
   ;; "sonicboom", T_NORMAL,   Z_SPECIAL,  20, ,    .9  -- 92
   ;; "disable",   T_NORMAL,   Z_STATUS,   20, ,    1   -- 93
   ;; "acid",      T_POISON,   Z_SPECIAL,  30, 40,  1   -- 94
   ;; "ember",     T_FIRE,     Z_SPECIAL,  25, 40,  1   -- 95
   ;; "flmethrwr", T_FIRE,     Z_SPECIAL,  15, 90,  1   -- 96
   ;; "mist",      T_ICE,      Z_STATUS,   30, ,        -- 97
   ;; "hydropump", T_WATER,    Z_SPECIAL,  5,  110, .8  -- 98
   ;; "psybeam",   T_PSYCHIC,  Z_SPECIAL,  20, 65,  1   -- 99
   ;; "aurorbeam", T_ICE,      Z_SPECIAL,  20, 65,  1   -- 100
   ;; "peck",      T_FLYING,   Z_PHYSICAL, 35, 35,  1   -- 101
   ;; "drillpeck", T_FLYING,   Z_PHYSICAL, 20, 80,  1   -- 102
   ;; "lowkick",   T_FIGHTING, Z_PHYSICAL, 20, ,    1   -- 103
   ;; "absorb",    T_GRASS,    Z_SPECIAL,  25, 20,  1   -- 104
   ;; "leechseed", T_GRASS,    Z_STATUS,   10, ,    .9  -- 105
   ;; "growth",    T_NORMAL,   Z_STATUS,   20, ,        -- 106
   ;; "razorleaf", T_GRASS,    Z_PHYSICAL, 25, 55,  .95 -- 107
   ;; "psnpowder", T_POISON,   Z_STATUS,   35, ,    .75 -- 108
   ;; "stunspore", T_GRASS,    Z_STATUS,   30, ,    .75 -- 109
   ;; "slppowder", T_GRASS,    Z_STATUS,   15, ,    .75 -- 110
   ;; "petldance", T_GRASS,    Z_SPECIAL,  10, 120, 1   -- 111
   ;; "stringsht", T_BUG,      Z_STATUS,   40, ,    .95 -- 112
   ;; "firespin",  T_FIRE,     Z_SPECIAL,  15, 35,  .85 -- 113
   ;; "thndrshck", T_ELECTRIC, Z_SPECIAL,  30, 40,  1   -- 114
   ;; "rockthrow", T_ROCK,     Z_PHYSICAL, 15, 50,  .9  -- 115
   ;; "confusion", T_PSYCHIC,  Z_SPECIAL,  25, 50,  1   -- 116
   ;; "hypnosis",  T_PSYCHIC,  Z_STATUS,   20, ,    .6  -- 117
   ;; "meditate",  T_PSYCHIC,  Z_STATUS,   40, ,        -- 118
   ;; "agility",   T_PSYCHIC,  Z_STATUS,   30, ,        -- 119
   ;; "quickatck", T_NORMAL,   Z_PHYSICAL, 30, 40,  1   -- 120
   ;; "niteshade", T_GHOST,    Z_SPECIAL,  15, ,    1   -- 121
   ;; "screech",   T_NORMAL,   Z_STATUS,   40, ,    .85 -- 122
   ;; "recover",   T_NORMAL,   Z_STATUS,   5,  ,        -- 123
   ;; "harden",    T_NORMAL,   Z_STATUS,   30, ,        -- 124
   ;; "minimize",  T_NORMAL,   Z_STATUS,   10, ,        -- 125
   ;; "smokescrn", T_NORMAL,   Z_STATUS,   20, ,    1   -- 126
   ;; "confusray", T_GHOST,    Z_STATUS,   10, ,    1   -- 127
   ;; "withdraw",  T_WATER,    Z_STATUS,   40, ,        -- 128
   ;; "defenscrl", T_NORMAL,   Z_STATUS,   40, ,        -- 129
   ;; "barrier",   T_PSYCHIC,  Z_STATUS,   20, ,        -- 130
   ;; "lightscrn", T_PSYCHIC,  Z_STATUS,   30, ,        -- 131
   ;; "haze",      T_ICE,      Z_STATUS,   30, ,        -- 132
   ;; "focusnrgy", T_NORMAL,   Z_STATUS,   30, ,        -- 133
   ;; "mirormove", T_FLYING,   Z_STATUS,   20, ,        -- 134
   ;; "lick",      T_GHOST,    Z_PHYSICAL, 30, 30,  1   -- 135
   ;; "smog",      T_POISON,   Z_SPECIAL,  20, 30,  .7  -- 136
   ;; "sludge",    T_POISON,   Z_SPECIAL,  20, 65,  1   -- 137
   ;; "boneclub",  T_GROUND,   Z_PHYSICAL, 20, 65,  .85 -- 138
   ;; "waterfall", T_WATER,    Z_PHYSICAL, 15, 80,  1   -- 139
   ;; "clamp",     T_WATER,    Z_PHYSICAL, 15, 35,  .85 -- 140
   ;; "spikcanon", T_NORMAL,   Z_PHYSICAL, 15, 20,  1   -- 141
   ;; "constrict", T_NORMAL,   Z_PHYSICAL, 35, 10,  1   -- 142
   ;; "amnesia",   T_PSYCHIC,  Z_STATUS,   20, ,        -- 143
   ;; "kinesis",   T_PSYCHIC,  Z_STATUS,   15, ,    .8  -- 144
   ;; "hghjmpkck", T_FIGHTING, Z_PHYSICAL, 10, 130, .9  -- 145
   ;; "glare",     T_NORMAL,   Z_STATUS,   30, ,    1   -- 146
   ;; "poisongas", T_POISON,   Z_STATUS,   40, ,    .9  -- 147
   ;; "barrage",   T_NORMAL,   Z_PHYSICAL, 20, 15,  .85 -- 148
   ;; "leechlife", T_BUG,      Z_PHYSICAL, 10, 80,  1   -- 149
   ;; "lovelykss", T_NORMAL,   Z_STATUS,   10, ,    .75 -- 150
   ;; "transform", T_NORMAL,   Z_STATUS,   10, ,        -- 151
   ;; "bubble",    T_WATER,    Z_SPECIAL,  30, 40,  1   -- 152
   ;; "dizypunch", T_NORMAL,   Z_PHYSICAL, 10, 70,  1   -- 153
   ;; "spore",     T_GRASS,    Z_STATUS,   15, ,    1   -- 154
   ;; "splash",    T_NORMAL,   Z_STATUS,   40, ,        -- 155
   ;; "acidarmor", T_POISON,   Z_STATUS,   20, ,        -- 156
   ;; "crbhammer", T_WATER,    Z_PHYSICAL, 10, 100, .9  -- 157
   ;; "furyswipe", T_NORMAL,   Z_PHYSICAL, 15, 18,  .8  -- 158
   ;; "bonemrang", T_GROUND,   Z_PHYSICAL, 10, 50,  .9  -- 159
   ;; "hyperfang", T_NORMAL,   Z_PHYSICAL, 15, 80,  .9  -- 160
   ;; "sharpen",   T_NORMAL,   Z_STATUS,   30, ,        -- 161
   ;; "convrsion", T_NORMAL,   Z_STATUS,   30, ,        -- 162
   ;; "superfang", T_NORMAL,   Z_PHYSICAL, 10, ,    .9  -- 163
   ;; "slash",     T_NORMAL,   Z_PHYSICAL, 20, 70,  1   -- 164
]]
