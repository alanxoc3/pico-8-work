function init() -- entry point for this compile script
  local statarr  = {} -- for each pokemon, array/order of moves

  for arr in all(datastr_to_arr(pokemon_stats)) do
    local pkmnid = arr[1]
    statarr[pkmnid] = {arr[2], arr[3], arr[4], arr[5], arr[6], arr[7], arr[8], arr[9], arr[10]} -- arr[11] is gender and should probably be included somehow.
  end

  for i=0,251 do
    for x in all(statarr[i]) do
      offsetpoke(x)
    end
  end

  log("Wrote Pokemon Stats")
end

-- only  39 pokemon without both gender. Maybe those 39 should be encoded separately. it would be 78 instead of 252.
--  39 pokemon without both gender. can be combined with one of the types
-- 130 pokemon with "none" evolution
-- 143 pokemon with "none" type

-- 5 bits for type. 1 for gender/type2. 1 for "has" evolution. (could save some bytes)
-- results from crystal decompiled - besides missingno
-- primary and secondary types are sometimes switched, to improve sprite color
--pokemon      pre-evolve   type 1     type 2      hp  att  def  spd  sat  sdf gender
pokemon_stats = [[
  P_MISSINGNO  P_NONE       T_BIRD     T_NORMAL    33  136    0   29    6    6 G_NONE
  P_BULBASAUR  P_NONE       T_GRASS    T_POISON    45   49   49   45   65   65 G_BOTH
  P_IVYSAUR    P_BULBASAUR  T_GRASS    T_POISON    60   62   63   60   80   80 G_BOTH
  P_VENUSAUR   P_IVYSAUR    T_GRASS    T_POISON    80   82   83   80  100  100 G_BOTH
  P_CHARMANDER P_NONE       T_FIRE     T_NONE      39   52   43   65   60   50 G_BOTH
  P_CHARMELEON P_CHARMANDER T_FIRE     T_NONE      58   64   58   80   80   65 G_BOTH
  P_CHARIZARD  P_CHARMELEON T_FIRE     T_FLYING    78   84   78  100  109   85 G_BOTH
  P_SQUIRTLE   P_NONE       T_WATER    T_NONE      44   48   65   43   50   64 G_BOTH
  P_WARTORTLE  P_SQUIRTLE   T_WATER    T_NONE      59   63   80   58   65   80 G_BOTH
  P_BLASTOISE  P_WARTORTLE  T_WATER    T_NONE      79   83  100   78   85  105 G_BOTH
  P_CATERPIE   P_NONE       T_BUG      T_NONE      45   30   35   45   20   20 G_BOTH
  P_METAPOD    P_CATERPIE   T_BUG      T_NONE      50   20   55   30   25   25 G_BOTH
  P_BUTTERFREE P_METAPOD    T_BUG      T_FLYING    60   45   50   70   80   80 G_BOTH
  P_WEEDLE     P_NONE       T_BUG      T_POISON    40   35   30   50   20   20 G_BOTH
  P_KAKUNA     P_WEEDLE     T_BUG      T_POISON    45   25   50   35   25   25 G_BOTH
  P_BEEDRILL   P_KAKUNA     T_BUG      T_POISON    65   80   40   75   45   80 G_BOTH
  P_PIDGEY     P_NONE       T_FLYING   T_NORMAL    40   45   40   56   35   35 G_BOTH
  P_PIDGEOTTO  P_PIDGEY     T_FLYING   T_NORMAL    63   60   55   71   50   50 G_BOTH
  P_PIDGEOT    P_PIDGEOTTO  T_FLYING   T_NORMAL    83   80   75   91   70   70 G_BOTH
  P_RATTATA    P_NONE       T_NORMAL   T_NONE      30   56   35   72   25   35 G_BOTH
  P_RATICATE   P_RATTATA    T_NORMAL   T_NONE      55   81   60   97   50   70 G_BOTH
  P_SPEAROW    P_NONE       T_FLYING   T_NORMAL    40   60   30   70   31   31 G_BOTH
  P_FEAROW     P_SPEAROW    T_FLYING   T_NORMAL    65   90   65  100   61   61 G_BOTH
  P_EKANS      P_NONE       T_POISON   T_NONE      35   60   44   55   40   54 G_BOTH
  P_ARBOK      P_EKANS      T_POISON   T_NONE      60   85   69   80   65   79 G_BOTH
  P_PIKACHU    P_PICHU      T_ELECTRIC T_NONE      35   55   30   90   50   40 G_BOTH
  P_RAICHU     P_PIKACHU    T_ELECTRIC T_NONE      60   90   55  100   90   80 G_BOTH
  P_SANDSHREW  P_NONE       T_GROUND   T_NONE      50   75   85   40   20   30 G_BOTH
  P_SANDSLASH  P_SANDSHREW  T_GROUND   T_NONE      75  100  110   65   45   55 G_BOTH
  P_NIDORANF   P_NONE       T_POISON   T_NONE      55   47   52   41   40   40 G_FEMA
  P_NIDORINA   P_NIDORANF   T_POISON   T_NONE      70   62   67   56   55   55 G_FEMA
  P_NIDOQUEEN  P_NIDORINA   T_POISON   T_GROUND    90   82   87   76   75   85 G_FEMA
  P_NIDORANM   P_NONE       T_POISON   T_NONE      46   57   40   50   40   40 G_MALE
  P_NIDORINO   P_NIDORANM   T_POISON   T_NONE      61   72   57   65   55   55 G_MALE
  P_NIDOKING   P_NIDORINO   T_POISON   T_GROUND    81   92   77   85   85   75 G_MALE
  P_CLEFAIRY   P_CLEFFA     T_NORMAL   T_NONE      70   45   48   35   60   65 G_BOTH
  P_CLEFABLE   P_CLEFAIRY   T_NORMAL   T_NONE      95   70   73   60   85   90 G_BOTH
  P_VULPIX     P_NONE       T_FIRE     T_NONE      38   41   40   65   50   65 G_BOTH
  P_NINETALES  P_VULPIX     T_FIRE     T_NONE      73   76   75  100   81  100 G_BOTH
  P_JIGGLYPUFF P_IGGLYBUFF  T_NORMAL   T_NONE     115   45   20   20   45   25 G_BOTH
  P_WIGGLYTUFF P_JIGGLYPUFF T_NORMAL   T_NONE     140   70   45   45   75   50 G_BOTH
  P_ZUBAT      P_NONE       T_POISON   T_FLYING    40   45   35   55   30   40 G_BOTH
  P_GOLBAT     P_ZUBAT      T_POISON   T_FLYING    75   80   70   90   65   75 G_BOTH
  P_ODDISH     P_NONE       T_GRASS    T_POISON    45   50   55   30   75   65 G_BOTH
  P_GLOOM      P_ODDISH     T_GRASS    T_POISON    60   65   70   40   85   75 G_BOTH
  P_VILEPLUME  P_GLOOM      T_GRASS    T_POISON    75   80   85   50  100   90 G_BOTH
  P_PARAS      P_NONE       T_BUG      T_GRASS     35   70   55   25   45   55 G_BOTH
  P_PARASECT   P_PARAS      T_BUG      T_GRASS     60   95   80   30   60   80 G_BOTH
  P_VENONAT    P_NONE       T_POISON   T_BUG       60   55   50   45   40   55 G_BOTH
  P_VENOMOTH   P_VENONAT    T_POISON   T_BUG       70   65   60   90   90   75 G_BOTH
  P_DIGLETT    P_NONE       T_GROUND   T_NONE      10   55   25   95   35   45 G_BOTH
  P_DUGTRIO    P_DIGLETT    T_GROUND   T_NONE      35   80   50  120   50   70 G_BOTH
  P_MEOWTH     P_NONE       T_NORMAL   T_NONE      40   45   35   90   40   40 G_BOTH
  P_PERSIAN    P_MEOWTH     T_NORMAL   T_NONE      65   70   60  115   65   65 G_BOTH
  P_PSYDUCK    P_NONE       T_WATER    T_NONE      50   52   48   55   65   50 G_BOTH
  P_GOLDUCK    P_PSYDUCK    T_WATER    T_NONE      80   82   78   85   95   80 G_BOTH
  P_MANKEY     P_NONE       T_FIGHTING T_NONE      40   80   35   70   35   45 G_BOTH
  P_PRIMEAPE   P_MANKEY     T_FIGHTING T_NONE      65  105   60   95   60   70 G_BOTH
  P_GROWLITHE  P_NONE       T_FIRE     T_NONE      55   70   45   60   70   50 G_BOTH
  P_ARCANINE   P_GROWLITHE  T_FIRE     T_NONE      90  110   80   95  100   80 G_BOTH
  P_POLIWAG    P_NONE       T_WATER    T_NONE      40   50   40   90   40   40 G_BOTH
  P_POLIWHIRL  P_POLIWAG    T_WATER    T_NONE      65   65   65   90   50   50 G_BOTH
  P_POLIWRATH  P_POLIWHIRL  T_WATER    T_FIGHTING  90   85   95   70   70   90 G_BOTH
  P_ABRA       P_NONE       T_PSYCHIC  T_NONE      25   20   15   90  105   55 G_BOTH
  P_KADABRA    P_ABRA       T_PSYCHIC  T_NONE      40   35   30  105  120   70 G_BOTH
  P_ALAKAZAM   P_KADABRA    T_PSYCHIC  T_NONE      55   50   45  120  135   85 G_BOTH
  P_MACHOP     P_NONE       T_FIGHTING T_NONE      70   80   50   35   35   35 G_BOTH
  P_MACHOKE    P_MACHOP     T_FIGHTING T_NONE      80  100   70   45   50   60 G_BOTH
  P_MACHAMP    P_MACHOKE    T_FIGHTING T_NONE      90  130   80   55   65   85 G_BOTH
  P_BELLSPROUT P_NONE       T_GRASS    T_POISON    50   75   35   40   70   30 G_BOTH
  P_WEEPINBELL P_BELLSPROUT T_GRASS    T_POISON    65   90   50   55   85   45 G_BOTH
  P_VICTREEBEL P_WEEPINBELL T_GRASS    T_POISON    80  105   65   70  100   60 G_BOTH
  P_TENTACOOL  P_NONE       T_WATER    T_POISON    40   40   35   70   50  100 G_BOTH
  P_TENTACRUEL P_TENTACOOL  T_WATER    T_POISON    80   70   65  100   80  120 G_BOTH
  P_GEODUDE    P_NONE       T_ROCK     T_GROUND    40   80  100   20   30   30 G_BOTH
  P_GRAVELER   P_GEODUDE    T_ROCK     T_GROUND    55   95  115   35   45   45 G_BOTH
  P_GOLEM      P_GRAVELER   T_ROCK     T_GROUND    80  110  130   45   55   65 G_BOTH
  P_PONYTA     P_NONE       T_FIRE     T_NONE      50   85   55   90   65   65 G_BOTH
  P_RAPIDASH   P_PONYTA     T_FIRE     T_NONE      65  100   70  105   80   80 G_BOTH
  P_SLOWPOKE   P_NONE       T_PSYCHIC  T_WATER     90   65   65   15   40   40 G_BOTH
  P_SLOWBRO    P_SLOWPOKE   T_PSYCHIC  T_WATER     95   75  110   30  100   80 G_BOTH
  P_MAGNEMITE  P_NONE       T_STEEL    T_ELECTRIC  25   35   70   45   95   55 G_NONE
  P_MAGNETON   P_MAGNEMITE  T_STEEL    T_ELECTRIC  50   60   95   70  120   70 G_NONE
  P_FARFETCHD  P_NONE       T_FLYING   T_NORMAL    52   65   55   60   58   62 G_BOTH
  P_DODUO      P_NONE       T_FLYING   T_NORMAL    35   85   45   75   35   35 G_BOTH
  P_DODRIO     P_DODUO      T_FLYING   T_NORMAL    60  110   70  100   60   60 G_BOTH
  P_SEEL       P_NONE       T_WATER    T_NONE      65   45   55   45   45   70 G_BOTH
  P_DEWGONG    P_SEEL       T_WATER    T_ICE       90   70   80   70   70   95 G_BOTH
  P_GRIMER     P_NONE       T_POISON   T_NONE      80   80   50   25   40   50 G_BOTH
  P_MUK        P_GRIMER     T_POISON   T_NONE     105  105   75   50   65  100 G_BOTH
  P_SHELLDER   P_NONE       T_WATER    T_NONE      30   65  100   40   45   25 G_BOTH
  P_CLOYSTER   P_SHELLDER   T_WATER    T_ICE       50   95  180   70   85   45 G_BOTH
  P_GASTLY     P_NONE       T_GHOST    T_POISON    30   35   30   80  100   35 G_BOTH
  P_HAUNTER    P_GASTLY     T_GHOST    T_POISON    45   50   45   95  115   55 G_BOTH
  P_GENGAR     P_HAUNTER    T_GHOST    T_POISON    60   65   60  110  130   75 G_BOTH
  P_ONIX       P_NONE       T_ROCK     T_GROUND    35   45  160   70   30   45 G_BOTH
  P_DROWZEE    P_NONE       T_PSYCHIC  T_NONE      60   48   45   42   43   90 G_BOTH
  P_HYPNO      P_DROWZEE    T_PSYCHIC  T_NONE      85   73   70   67   73  115 G_BOTH
  P_KRABBY     P_NONE       T_WATER    T_NONE      30  105   90   50   25   25 G_BOTH
  P_KINGLER    P_KRABBY     T_WATER    T_NONE      55  130  115   75   50   50 G_BOTH
  P_VOLTORB    P_NONE       T_ELECTRIC T_NONE      40   30   50  100   55   55 G_NONE
  P_ELECTRODE  P_VOLTORB    T_ELECTRIC T_NONE      60   50   70  140   80   80 G_NONE
  P_EXEGGCUTE  P_NONE       T_GRASS    T_PSYCHIC   60   40   80   40   60   45 G_BOTH
  P_EXEGGUTOR  P_EXEGGCUTE  T_GRASS    T_PSYCHIC   95   95   85   55  125   65 G_BOTH
  P_CUBONE     P_NONE       T_GROUND   T_NONE      50   50   95   35   40   50 G_BOTH
  P_MAROWAK    P_CUBONE     T_GROUND   T_NONE      60   80  110   45   50   80 G_BOTH
  P_HITMONLEE  P_TYROGUE    T_FIGHTING T_NONE      50  120   53   87   35  110 G_MALE
  P_HITMONCHAN P_TYROGUE    T_FIGHTING T_NONE      50  105   79   76   35  110 G_MALE
  P_LICKITUNG  P_NONE       T_NORMAL   T_NONE      90   55   75   30   60   75 G_BOTH
  P_KOFFING    P_NONE       T_POISON   T_NONE      40   65   95   35   60   45 G_BOTH
  P_WEEZING    P_KOFFING    T_POISON   T_NONE      65   90  120   60   85   70 G_BOTH
  P_RHYHORN    P_NONE       T_GROUND   T_ROCK      80   85   95   25   30   30 G_BOTH
  P_RHYDON     P_RHYHORN    T_GROUND   T_ROCK     105  130  120   40   45   45 G_BOTH
  P_CHANSEY    P_NONE       T_NORMAL   T_NONE     250    5    5   50   35  105 G_FEMA
  P_TANGELA    P_NONE       T_GRASS    T_NONE      65   55  115   60  100   40 G_BOTH
  P_KANGASKHAN P_NONE       T_NORMAL   T_NONE     105   95   80   90   40   80 G_FEMA
  P_HORSEA     P_NONE       T_WATER    T_NONE      30   40   70   60   70   25 G_BOTH
  P_SEADRA     P_HORSEA     T_WATER    T_NONE      55   65   95   85   95   45 G_BOTH
  P_GOLDEEN    P_NONE       T_WATER    T_NONE      45   67   60   63   35   50 G_BOTH
  P_SEAKING    P_GOLDEEN    T_WATER    T_NONE      80   92   65   68   65   80 G_BOTH
  P_STARYU     P_NONE       T_WATER    T_NONE      30   45   55   85   70   55 G_NONE
  P_STARMIE    P_STARYU     T_WATER    T_PSYCHIC   60   75   85  115  100   85 G_NONE
  P_MRMIME     P_NONE       T_PSYCHIC  T_NONE      40   45   65   90  100  120 G_BOTH
  P_SCYTHER    P_NONE       T_BUG      T_FLYING    70  110   80  105   55   80 G_BOTH
  P_JYNX       P_SMOOCHUM   T_PSYCHIC  T_ICE       65   50   35   95  115   95 G_FEMA
  P_ELECTABUZZ P_ELEKID     T_ELECTRIC T_NONE      65   83   57  105   95   85 G_BOTH
  P_MAGMAR     P_MAGBY      T_FIRE     T_NONE      65   95   57   93  100   85 G_BOTH
  P_PINSIR     P_NONE       T_BUG      T_NONE      65  125  100   85   55   70 G_BOTH
  P_TAUROS     P_NONE       T_NORMAL   T_NONE      75  100   95  110   40   70 G_MALE
  P_MAGIKARP   P_NONE       T_WATER    T_NONE      20   10   55   80   15   20 G_BOTH
  P_GYARADOS   P_MAGIKARP   T_WATER    T_FLYING   95  125   79   81   60  100 G_BOTH
  P_LAPRAS     P_NONE       T_WATER    T_ICE      130   85   80   60   85   95 G_BOTH
  P_DITTO      P_NONE       T_NORMAL   T_NONE      48   48   48   48   48   48 G_NONE
  P_EEVEE      P_NONE       T_NORMAL   T_NONE      55   55   50   55   45   65 G_BOTH
  P_VAPOREON   P_EEVEE      T_WATER    T_NONE     130   65   60   65  110   95 G_BOTH
  P_JOLTEON    P_EEVEE      T_ELECTRIC T_NONE      65   65   60  130  110   95 G_BOTH
  P_FLAREON    P_EEVEE      T_FIRE     T_NONE      65  130   60   65   95  110 G_BOTH
  P_PORYGON    P_NONE       T_NORMAL   T_NONE      65   60   70   40   85   75 G_NONE
  P_OMANYTE    P_NONE       T_ROCK     T_WATER     35   40  100   35   90   55 G_BOTH
  P_OMASTAR    P_OMANYTE    T_ROCK     T_WATER     70   60  125   55  115   70 G_BOTH
  P_KABUTO     P_NONE       T_ROCK     T_WATER     30   80   90   55   55   45 G_BOTH
  P_KABUTOPS   P_KABUTO     T_ROCK     T_WATER     60  115  105   80   65   70 G_BOTH
  P_AERODACTYL P_NONE       T_ROCK     T_FLYING    80  105   65  130   60   75 G_BOTH
  P_SNORLAX    P_NONE       T_NORMAL   T_NONE     160  110   65   30   65  110 G_BOTH
  P_ARTICUNO   P_NONE       T_ICE      T_FLYING    90   85  100   85   95  125 G_NONE
  P_ZAPDOS     P_NONE       T_ELECTRIC T_FLYING    90   90   85  100  125   90 G_NONE
  P_MOLTRES    P_NONE       T_FIRE     T_FLYING    90  100   90   90  125   85 G_NONE
  P_DRATINI    P_NONE       T_DRAGON   T_NONE      41   64   45   50   50   50 G_BOTH
  P_DRAGONAIR  P_DRATINI    T_DRAGON   T_NONE      61   84   65   70   70   70 G_BOTH
  P_DRAGONITE  P_DRAGONAIR  T_DRAGON   T_FLYING    91  134   95   80  100  100 G_BOTH
  P_MEWTWO     P_NONE       T_PSYCHIC  T_NONE     106  110   90  130  154   90 G_NONE
  P_MEW        P_NONE       T_PSYCHIC  T_NONE     100  100  100  100  100  100 G_NONE
  P_CHIKORITA  P_NONE       T_GRASS    T_NONE      45   49   65   45   49   65 G_BOTH
  P_BAYLEEF    P_CHIKORITA  T_GRASS    T_NONE      60   62   80   60   63   80 G_BOTH
  P_MEGANIUM   P_BAYLEEF    T_GRASS    T_NONE      80   82  100   80   83  100 G_BOTH
  P_CYNDAQUIL  P_NONE       T_FIRE     T_NONE      39   52   43   65   60   50 G_BOTH
  P_QUILAVA    P_CYNDAQUIL  T_FIRE     T_NONE      58   64   58   80   80   65 G_BOTH
  P_TYPHLOSION P_QUILAVA    T_FIRE     T_NONE      78   84   78  100  109   85 G_BOTH
  P_TOTODILE   P_NONE       T_WATER    T_NONE      50   65   64   43   44   48 G_BOTH
  P_CROCONAW   P_TOTODILE   T_WATER    T_NONE      65   80   80   58   59   63 G_BOTH
  P_FERALIGATR P_CROCONAW   T_WATER    T_NONE      85  105  100   78   79   83 G_BOTH
  P_SENTRET    P_NONE       T_NORMAL   T_NONE      35   46   34   20   35   45 G_BOTH
  P_FURRET     P_SENTRET    T_NORMAL   T_NONE      85   76   64   90   45   55 G_BOTH
  P_HOOTHOOT   P_NONE       T_FLYING   T_NORMAL    60   30   30   50   36   56 G_BOTH
  P_NOCTOWL    P_HOOTHOOT   T_FLYING   T_NORMAL   100   50   50   70   76   96 G_BOTH
  P_LEDYBA     P_NONE       T_BUG      T_FLYING    40   20   30   55   40   80 G_BOTH
  P_LEDIAN     P_LEDYBA     T_BUG      T_FLYING    55   35   50   85   55  110 G_BOTH
  P_SPINARAK   P_NONE       T_BUG      T_POISON    40   60   40   30   40   40 G_BOTH
  P_ARIADOS    P_SPINARAK   T_BUG      T_POISON    70   90   70   40   60   60 G_BOTH
  P_CROBAT     P_GOLBAT     T_POISON   T_FLYING    85   90   80  130   70   80 G_BOTH
  P_CHINCHOU   P_NONE       T_ELECTRIC T_WATER     75   38   38   67   56   56 G_BOTH
  P_LANTURN    P_CHINCHOU   T_ELECTRIC T_WATER    125   58   58   67   76   76 G_BOTH
  P_PICHU      P_NONE       T_ELECTRIC T_NONE      20   40   15   60   35   35 G_BOTH
  P_CLEFFA     P_NONE       T_NORMAL   T_NONE      50   25   28   15   45   55 G_BOTH
  P_IGGLYBUFF  P_NONE       T_NORMAL   T_NONE      90   30   15   15   40   20 G_BOTH
  P_TOGEPI     P_NONE       T_NORMAL   T_NONE      35   20   65   20   40   65 G_BOTH
  P_TOGETIC    P_TOGEPI     T_NORMAL   T_FLYING    55   40   85   40   80  105 G_BOTH
  P_NATU       P_NONE       T_PSYCHIC  T_FLYING    40   50   45   70   70   45 G_BOTH
  P_XATU       P_NATU       T_PSYCHIC  T_FLYING    65   75   70   95   95   70 G_BOTH
  P_MAREEP     P_NONE       T_ELECTRIC T_NONE      55   40   40   35   65   45 G_BOTH
  P_FLAAFFY    P_MAREEP     T_ELECTRIC T_NONE      70   55   55   45   80   60 G_BOTH
  P_AMPHAROS   P_FLAAFFY    T_ELECTRIC T_NONE      90   75   75   55  115   90 G_BOTH
  P_BELLOSSOM  P_GLOOM      T_GRASS    T_NONE      75   80   85   50   90  100 G_BOTH
  P_MARILL     P_NONE       T_WATER    T_NONE      70   20   50   40   20   50 G_BOTH
  P_AZUMARILL  P_MARILL     T_WATER    T_NONE     100   50   80   50   50   80 G_BOTH
  P_SUDOWOODO  P_NONE       T_ROCK     T_NONE      70  100  115   30   30   65 G_BOTH
  P_POLITOED   P_POLIWHIRL  T_WATER    T_NONE      90   75   75   70   90  100 G_BOTH
  P_HOPPIP     P_NONE       T_GRASS    T_FLYING    35   35   40   50   35   55 G_BOTH
  P_SKIPLOOM   P_HOPPIP     T_GRASS    T_FLYING    55   45   50   80   45   65 G_BOTH
  P_JUMPLUFF   P_SKIPLOOM   T_GRASS    T_FLYING    75   55   70  110   55   85 G_BOTH
  P_AIPOM      P_NONE       T_NORMAL   T_NONE      55   70   55   85   40   55 G_BOTH
  P_SUNKERN    P_NONE       T_GRASS    T_NONE      30   30   30   30   30   30 G_BOTH
  P_SUNFLORA   P_SUNKERN    T_GRASS    T_NONE      75   75   55   30  105   85 G_BOTH
  P_YANMA      P_NONE       T_BUG      T_FLYING    65   65   45   95   75   45 G_BOTH
  P_WOOPER     P_NONE       T_WATER    T_GROUND    55   45   45   15   25   25 G_BOTH
  P_QUAGSIRE   P_WOOPER     T_WATER    T_GROUND    95   85   85   35   65   65 G_BOTH
  P_ESPEON     P_EEVEE      T_PSYCHIC  T_NONE      65   65   60  110  130   95 G_BOTH
  P_UMBREON    P_EEVEE      T_DARK     T_NONE      95   65  110   65   60  130 G_BOTH
  P_MURKROW    P_NONE       T_DARK     T_FLYING    60   85   42   91   85   42 G_BOTH
  P_SLOWKING   P_SLOWBRO    T_PSYCHIC  T_WATER     95   75   80   30  100  110 G_BOTH
  P_MISDREAVUS P_NONE       T_GHOST    T_NONE      60   60   60   85   85   85 G_BOTH
  P_UNOWN      P_NONE       T_PSYCHIC  T_NONE      48   72   48   48   72   48 G_NONE
  P_WOBBUFFET  P_NONE       T_PSYCHIC  T_NONE     190   33   58   33   33   58 G_BOTH
  P_GIRAFARIG  P_NONE       T_PSYCHIC  T_NORMAL    70   80   65   85   90   65 G_BOTH
  P_PINECO     P_NONE       T_BUG      T_NONE      50   65   90   15   35   35 G_BOTH
  P_FORRETRESS P_PINECO     T_BUG      T_STEEL     75   90  140   40   60   60 G_BOTH
  P_DUNSPARCE  P_NONE       T_NORMAL   T_NONE     100   70   70   45   65   65 G_BOTH
  P_GLIGAR     P_NONE       T_GROUND   T_FLYING    65   75  105   85   35   65 G_BOTH
  P_STEELIX    P_ONIX       T_STEEL    T_GROUND    75   85  200   30   55   65 G_BOTH
  P_SNUBBULL   P_NONE       T_NORMAL   T_NONE      60   80   50   30   40   40 G_BOTH
  P_GRANBULL   P_SNUBBULL   T_NORMAL   T_NONE      90  120   75   45   60   60 G_BOTH
  P_QWILFISH   P_NONE       T_WATER    T_POISON    65   95   75   85   55   55 G_BOTH
  P_SCIZOR     P_SCYTHER    T_STEEL    T_BUG       70  130  100   65   55   80 G_BOTH
  P_SHUCKLE    P_NONE       T_BUG      T_ROCK      20   10  230    5   10  230 G_BOTH
  P_HERACROSS  P_NONE       T_BUG      T_FIGHTING  80  125   75   85   40   95 G_BOTH
  P_SNEASEL    P_NONE       T_DARK     T_ICE       55   95   55  115   35   75 G_BOTH
  P_TEDDIURSA  P_NONE       T_NORMAL   T_NONE      60   80   50   40   50   50 G_BOTH
  P_URSARING   P_TEDDIURSA  T_NORMAL   T_NONE      90  130   75   55   75   75 G_BOTH
  P_SLUGMA     P_NONE       T_FIRE     T_NONE      40   40   40   20   70   40 G_BOTH
  P_MAGCARGO   P_SLUGMA     T_FIRE     T_ROCK      50   50  120   30   80   80 G_BOTH
  P_SWINUB     P_NONE       T_GROUND   T_ICE       50   50   40   50   30   30 G_BOTH
  P_PILOSWINE  P_SWINUB     T_GROUND   T_ICE      100  100   80   50   60   60 G_BOTH
  P_CORSOLA    P_NONE       T_ROCK     T_WATER     55   55   85   35   65   85 G_BOTH
  P_REMORAID   P_NONE       T_WATER    T_NONE      35   65   35   65   65   35 G_BOTH
  P_OCTILLERY  P_REMORAID   T_WATER    T_NONE      75  105   75   45  105   75 G_BOTH
  P_DELIBIRD   P_NONE       T_FLYING   T_ICE       45   55   45   75   65   45 G_BOTH
  P_MANTINE    P_NONE       T_WATER    T_FLYING    65   40   70   70   80  140 G_BOTH
  P_SKARMORY   P_NONE       T_STEEL    T_FLYING    65   80  140   70   40   70 G_BOTH
  P_HOUNDOUR   P_NONE       T_DARK     T_FIRE      45   60   30   65   80   50 G_BOTH
  P_HOUNDOOM   P_HOUNDOUR   T_DARK     T_FIRE      75   90   50   95  110   80 G_BOTH
  P_KINGDRA    P_SEADRA     T_WATER    T_DRAGON    75   95   95   85   95   95 G_BOTH
  P_PHANPY     P_NONE       T_GROUND   T_NONE      90   60   60   40   40   40 G_BOTH
  P_DONPHAN    P_PHANPY     T_GROUND   T_NONE      90  120  120   50   60   60 G_BOTH
  P_PORYGON2   P_PORYGON    T_NORMAL   T_NONE      85   80   90   60  105   95 G_NONE
  P_STANTLER   P_NONE       T_NORMAL   T_NONE      73   95   62   85   85   65 G_BOTH
  P_SMEARGLE   P_NONE       T_NORMAL   T_NONE      55   20   35   75   20   45 G_BOTH
  P_TYROGUE    P_NONE       T_FIGHTING T_NONE      35   35   35   35   35   35 G_MALE
  P_HITMONTOP  P_TYROGUE    T_FIGHTING T_NONE      50   95   95   70   35  110 G_MALE
  P_SMOOCHUM   P_NONE       T_PSYCHIC  T_ICE       45   30   15   65   85   65 G_FEMA
  P_ELEKID     P_NONE       T_ELECTRIC T_NONE      45   63   37   95   65   55 G_BOTH
  P_MAGBY      P_NONE       T_FIRE     T_NONE      45   75   37   83   70   55 G_BOTH
  P_MILTANK    P_NONE       T_NORMAL   T_NONE      95   80  105  100   40   70 G_FEMA
  P_BLISSEY    P_CHANSEY    T_NORMAL   T_NONE     255   10   10   55   75  135 G_FEMA
  P_RAIKOU     P_NONE       T_ELECTRIC T_NONE      90   85   75  115  115  100 G_NONE
  P_ENTEI      P_NONE       T_FIRE     T_NONE     115  115   85  100   90   75 G_NONE
  P_SUICUNE    P_NONE       T_WATER    T_NONE     100   75  115   85   90  115 G_NONE
  P_LARVITAR   P_NONE       T_ROCK     T_GROUND    50   64   50   41   45   50 G_BOTH
  P_PUPITAR    P_LARVITAR   T_ROCK     T_GROUND    70   84   70   51   65   70 G_BOTH
  P_TYRANITAR  P_PUPITAR    T_DARK     T_ROCK     100  134  110   61   95  100 G_BOTH
  P_LUGIA      P_NONE       T_PSYCHIC  T_FLYING   106   90  130  110   90  154 G_NONE
  P_HOOH       P_NONE       T_FIRE     T_FLYING   106  130   90   90  110  154 G_NONE
  P_CELEBI     P_NONE       T_GRASS    T_PSYCHIC  100  100  100  100  100  100 G_NONE
]]
