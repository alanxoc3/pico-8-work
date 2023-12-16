function init() -- entry point for this compile script
  local statarr  = {} -- for each pokemon, array/order of moves

  for arr in all(datastr_to_arr(pokemon_stats)) do
    -- todo: merge gender and item
    local pkmnid, prevolve, type1, type2, hp, att, def, spd, sat, sdf, gender, item = unpack(arr)
    statarr[pkmnid] = {prevolve, type1, type2, hp, att, def, spd, sat, sdf, gender | item}
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
  P_MISSINGNO  P_NONE       T_BIRD     T_NORMAL    33  136    0   29    6    6 G_NONE I_BERSERKGENE       -- because it is already glitchy. might be funny if it just dies from confusion
  P_BULBASAUR  P_NONE       T_GRASS    T_POISON    45   49   49   45   65   65 G_BOTH I_BERRY             -- starter first of 3
  P_IVYSAUR    P_BULBASAUR  T_GRASS    T_POISON    60   62   63   60   80   80 G_BOTH I_MIRACLESEED       -- mid of 3 boost type
  P_VENUSAUR   P_IVYSAUR    T_GRASS    T_POISON    80   82   83   80  100  100 G_BOTH I_LEFTOVERS         -- tanky
  P_CHARMANDER P_NONE       T_FIRE     T_NONE      39   52   43   65   60   50 G_BOTH I_BERRY             -- starter first of 3
  P_CHARMELEON P_CHARMANDER T_FIRE     T_NONE      58   64   58   80   80   65 G_BOTH I_CHARCOAL          -- mid of 3 boost type
  P_CHARIZARD  P_CHARMELEON T_FIRE     T_FLYING    78   84   78  100  109   85 G_BOTH I_LEFTOVERS         -- tanky
  P_SQUIRTLE   P_NONE       T_WATER    T_NONE      44   48   65   43   50   64 G_BOTH I_BERRY             -- starter first of 3
  P_WARTORTLE  P_SQUIRTLE   T_WATER    T_NONE      59   63   80   58   65   80 G_BOTH I_MYSTICWATER       -- mid of 3 boost type
  P_BLASTOISE  P_WARTORTLE  T_WATER    T_NONE      79   83  100   78   85  105 G_BOTH I_GOLDBERRY         -- tanky
  P_CATERPIE   P_NONE       T_BUG      T_NONE      45   30   35   45   20   20 G_BOTH I_POISONCUREBERRY   -- because not psn type first of 3
  P_METAPOD    P_CATERPIE   T_BUG      T_NONE      50   20   55   30   25   25 G_BOTH I_GOLDBERRY         -- complement harden
  P_BUTTERFREE P_METAPOD    T_BUG      T_FLYING    60   45   50   70   80   80 G_BOTH I_TWISTEDSPOON      -- complement psybeam
  P_WEEDLE     P_NONE       T_BUG      T_POISON    40   35   30   50   20   20 G_BOTH I_PARALYZECUREBERRY -- to complement caterpie first of 3
  P_KAKUNA     P_WEEDLE     T_BUG      T_POISON    45   25   50   35   25   25 G_BOTH I_POISONBARB        -- 2nd and complement poison sting
  P_BEEDRILL   P_KAKUNA     T_BUG      T_POISON    65   80   40   75   45   80 G_BOTH I_SILVERPOWDER      -- complement twineed/pinmiss
  P_PIDGEY     P_NONE       T_NORMAL   T_FLYING    40   45   40   56   35   35 G_BOTH I_POISONCUREBERRY   -- no reason first of 3
  P_PIDGEOTTO  P_PIDGEY     T_NORMAL   T_FLYING    63   60   55   71   50   50 G_BOTH I_SHARPBEAK         -- 2nd and wing attack
  P_PIDGEOT    P_PIDGEOTTO  T_NORMAL   T_FLYING    83   80   75   91   70   70 G_BOTH I_LEFTOVERS         -- wing attack
  P_RATTATA    P_NONE       T_NORMAL   T_NONE      30   56   35   72   25   35 G_BOTH I_BURNTBERRY        -- first evol
  P_RATICATE   P_RATTATA    T_NORMAL   T_NONE      55   81   60   97   50   70 G_BOTH I_QUICKCLAW         -- complement scary face
  P_SPEAROW    P_NONE       T_NORMAL   T_FLYING    40   60   30   70   31   31 G_BOTH I_MINTBERRY         -- first evol
  P_FEAROW     P_SPEAROW    T_NORMAL   T_FLYING    65   90   65  100   61   61 G_BOTH I_SHARPBEAK         -- wild has it and drillpeck
  P_EKANS      P_NONE       T_POISON   T_NONE      35   60   44   55   40   54 G_BOTH I_PARALYZECUREBERRY -- first evol no reason
  P_ARBOK      P_EKANS      T_POISON   T_NONE      60   85   69   80   65   79 G_BOTH I_POISONBARB        -- acid and type boost
  P_PIKACHU    P_PICHU      T_ELECTRIC T_NONE      35   55   30   90   50   40 G_BOTH I_LIGHTBALL         -- specific special item
  P_RAICHU     P_PIKACHU    T_ELECTRIC T_NONE      60   90   55  100   90   80 G_BOTH I_SCOPELENS         -- make up for lack of hp
  P_SANDSHREW  P_NONE       T_GROUND   T_NONE      50   75   85   40   20   30 G_BOTH I_BURNTBERRY        -- first evol, why not
  P_SANDSLASH  P_SANDSHREW  T_GROUND   T_NONE      75  100  110   65   45   55 G_BOTH I_SCOPELENS         -- because of slash
  P_NIDORANF   P_NONE       T_POISON   T_NONE      55   47   52   41   40   40 G_FEMA I_BURNTBERRY        -- no reason first of 3
  P_NIDORINA   P_NIDORANF   T_POISON   T_NONE      70   62   67   56   55   55 G_FEMA I_PINKBOW           -- has a normal move
  P_NIDOQUEEN  P_NIDORINA   T_POISON   T_GROUND    90   82   87   76   75   85 G_FEMA I_LEFTOVERS         -- just make it tanky
  P_NIDORANM   P_NONE       T_POISON   T_NONE      46   57   40   50   40   40 G_MALE I_ICEBERRY          -- complement nidoranf first of 3
  P_NIDORINO   P_NIDORANM   T_POISON   T_NONE      61   72   57   65   55   55 G_MALE I_BLACKBELT         -- has a fighting move
  P_NIDOKING   P_NIDORINO   T_POISON   T_GROUND    81   92   77   85   85   75 G_MALE I_LEFTOVERS         -- just make it tanky
  P_CLEFAIRY   P_CLEFFA     T_NORMAL   T_NONE      70   45   48   35   60   65 G_BOTH I_PINKBOW           -- mid evolve type boost and a normal type move
  P_CLEFABLE   P_CLEFAIRY   T_NORMAL   T_NONE      95   70   73   60   85   90 G_BOTH I_GOLDBERRY         -- match wigglytuff
  P_VULPIX     P_NONE       T_FIRE     T_NONE      38   41   40   65   50   65 G_BOTH I_BURNTBERRY        -- 1st evol
  P_NINETALES  P_VULPIX     T_FIRE     T_NONE      73   76   75  100   81  100 G_BOTH I_CHARCOAL          -- 2 fire type moves
  P_JIGGLYPUFF P_IGGLYBUFF  T_NORMAL   T_NONE     115   45   20   20   45   25 G_BOTH I_PINKBOW           -- mid evol type boost and gen 2 trade item (polkadot technically)
  P_WIGGLYTUFF P_JIGGLYPUFF T_NORMAL   T_NONE     140   70   45   45   75   50 G_BOTH I_GOLDBERRY         -- doubedge in moveset
  P_ZUBAT      P_NONE       T_POISON   T_FLYING    40   45   35   55   30   40 G_BOTH I_MYSTERYBERRY      -- first evol and leech life sucks
  P_GOLBAT     P_ZUBAT      T_POISON   T_FLYING    75   80   70   90   65   75 G_BOTH I_BLACKGLASSES      -- faint attack type boost
  P_ODDISH     P_NONE       T_GRASS    T_POISON    45   50   55   30   75   65 G_BOTH I_BITTERBERRY       -- has petal dance, first of 3
  P_GLOOM      P_ODDISH     T_GRASS    T_POISON    60   65   70   40   85   75 G_BOTH I_POISONBARB        -- for acid type boost & 2nd evol
  P_VILEPLUME  P_GLOOM      T_GRASS    T_POISON    75   80   85   50  100   90 G_BOTH I_SCOPELENS         -- tanky
  P_PARAS      P_NONE       T_BUG      T_GRASS     35   70   55   25   45   55 G_BOTH I_ICEBERRY          -- why not, 1st evol
  P_PARASECT   P_PARAS      T_BUG      T_GRASS     60   95   80   30   60   80 G_BOTH I_SCOPELENS         -- slash
  P_VENONAT    P_NONE       T_BUG      T_POISON    60   55   50   45   40   55 G_BOTH I_ICEBERRY          -- why not, match paras
  P_VENOMOTH   P_VENONAT    T_BUG      T_POISON    70   65   60   90   90   75 G_BOTH I_SILVERPOWDER      -- psybeam
  P_DIGLETT    P_NONE       T_GROUND   T_NONE      10   55   25   95   35   45 G_BOTH I_POISONCUREBERRY   -- why not... 1st evol
  P_DUGTRIO    P_DIGLETT    T_GROUND   T_NONE      35   80   50  120   50   70 G_BOTH I_SOFTSAND          -- just a type boost for dig
  P_MEOWTH     P_NONE       T_NORMAL   T_NONE      40   45   35   90   40   40 G_BOTH I_AMULETCOIN        -- payday
  P_PERSIAN    P_MEOWTH     T_NORMAL   T_NONE      65   70   60  115   65   65 G_BOTH I_AMULETCOIN        -- payday
  P_PSYDUCK    P_NONE       T_WATER    T_NONE      50   52   48   55   65   50 G_BOTH I_PARALYZECUREBERRY -- why not, electric weak
  P_GOLDUCK    P_PSYDUCK    T_WATER    T_NONE      80   82   78   85   95   80 G_BOTH I_MYSTICWATER       -- hydropump
  P_MANKEY     P_NONE       T_FIGHTING T_NONE      40   80   35   70   35   45 G_BOTH I_BITTERBERRY       -- has thrash, first of 3
  P_PRIMEAPE   P_MANKEY     T_FIGHTING T_NONE      65  105   60   95   60   70 G_BOTH I_SCOPELENS         -- cross chop & karate chop... Rage too maybe
  P_GROWLITHE  P_NONE       T_FIRE     T_NONE      55   70   45   60   70   50 G_BOTH I_PARALYZECUREBERRY -- idk
  P_ARCANINE   P_GROWLITHE  T_FIRE     T_NONE      90  110   80   95  100   80 G_BOTH I_SCOPELENS         -- takedown in moveset (only 1 firetype move)
  P_POLIWAG    P_NONE       T_WATER    T_NONE      40   50   40   90   40   40 G_BOTH I_MYSTERYBERRY      -- has bellydrum (polywhirl does too, but not after) first of 3
  P_POLIWHIRL  P_POLIWAG    T_WATER    T_NONE      65   65   65   90   50   50 G_BOTH I_GOLDBERRY         -- bellydrum
  P_POLIWRATH  P_POLIWHIRL  T_WATER    T_FIGHTING  90   85   95   70   70   90 G_BOTH I_FOCUSBAND         -- submiss & belly drum
  P_ABRA       P_NONE       T_PSYCHIC  T_NONE      25   20   15   90  105   55 G_BOTH I_POISONCUREBERRY   -- no reason first of 3
  P_KADABRA    P_ABRA       T_PSYCHIC  T_NONE      40   35   30  105  120   70 G_BOTH I_TWISTEDSPOON      -- 2nd evol type boost
  P_ALAKAZAM   P_KADABRA    T_PSYCHIC  T_NONE      55   50   45  120  135   85 G_BOTH I_FOCUSBAND         -- recover can bring it back maybe
  P_MACHOP     P_NONE       T_FIGHTING T_NONE      70   80   50   35   35   35 G_BOTH I_ICEBERRY          -- no reason first of 3
  P_MACHOKE    P_MACHOP     T_FIGHTING T_NONE      80  100   70   45   50   60 G_BOTH I_BLACKBELT         -- type boost midd evol
  P_MACHAMP    P_MACHOKE    T_FIGHTING T_NONE      90  130   80   55   65   85 G_BOTH I_SCOPELENS         -- crit for cross chop
  P_BELLSPROUT P_NONE       T_GRASS    T_POISON    50   75   35   40   70   30 G_BOTH I_PARALYZECUREBERRY -- no reason first of 3
  P_WEEPINBELL P_BELLSPROUT T_GRASS    T_POISON    65   90   50   55   85   45 G_BOTH I_MIRACLESEED       -- evol 2 type boost
  P_VICTREEBEL P_WEEPINBELL T_GRASS    T_POISON    80  105   65   70  100   60 G_BOTH I_SCOPELENS         -- final evol, good with razor leaf
  P_TENTACOOL  P_NONE       T_WATER    T_POISON    40   40   35   70   50  100 G_BOTH I_BITTERBERRY       -- why not 1st evol
  P_TENTACRUEL P_TENTACOOL  T_WATER    T_POISON    80   70   65  100   80  120 G_BOTH I_POISONBARB        -- acid
  P_GEODUDE    P_NONE       T_ROCK     T_GROUND    40   80  100   20   30   30 G_BOTH I_POISONCUREBERRY   -- no reason first of 3
  P_GRAVELER   P_GEODUDE    T_ROCK     T_GROUND    55   95  115   35   45   45 G_BOTH I_HARDSTONE         -- rollout boost
  P_GOLEM      P_GRAVELER   T_ROCK     T_GROUND    80  110  130   45   55   65 G_BOTH I_FOCUSBAND         -- has explosion
  P_PONYTA     P_NONE       T_FIRE     T_NONE      50   85   55   90   65   65 G_BOTH I_BURNTBERRY        -- cure ice since it doesn't learn flame wheel by default
  P_RAPIDASH   P_PONYTA     T_FIRE     T_NONE      65  100   70  105   80   80 G_BOTH I_CHARCOAL          -- fire blast
  P_SLOWPOKE   P_NONE       T_WATER    T_PSYCHIC   90   65   65   15   40   40 G_BOTH I_MYSTERYBERRY      -- no reason first of 3
  P_SLOWBRO    P_SLOWPOKE   T_WATER    T_PSYCHIC   95   75  110   30  100   80 G_BOTH I_TWISTEDSPOON      -- good with psychic
  P_MAGNEMITE  P_NONE       T_STEEL    T_ELECTRIC  25   35   70   45   95   55 G_NONE I_ICEBERRY          -- burn is bad for steel i guess
  P_MAGNETON   P_MAGNEMITE  T_STEEL    T_ELECTRIC  50   60   95   70  120   70 G_NONE I_MAGNET            -- its literally a magnet... kinda sticks
  P_FARFETCHD  P_NONE       T_NORMAL   T_FLYING    52   65   55   60   58   62 G_BOTH I_STICK             -- special item
  P_DODUO      P_NONE       T_NORMAL   T_FLYING    35   85   45   75   35   35 G_BOTH I_MINTBERRY         -- why not
  P_DODRIO     P_DODUO      T_NORMAL   T_FLYING    60  110   70  100   60   60 G_BOTH I_SHARPBEAK         -- wild has it and drillpeck
  P_SEEL       P_NONE       T_WATER    T_NONE      65   45   55   45   45   70 G_BOTH I_MINTBERRY         -- has rest and first evol
  P_DEWGONG    P_SEEL       T_WATER    T_ICE       90   70   80   70   70   95 G_BOTH I_NEVERMELTICE      -- ice beam
  P_GRIMER     P_NONE       T_POISON   T_NONE      80   80   50   25   40   50 G_BOTH I_MINTBERRY         -- why not
  P_MUK        P_GRIMER     T_POISON   T_NONE     105  105   75   50   65  100 G_BOTH I_POISONBARB        -- 2 poison moves
  P_SHELLDER   P_NONE       T_WATER    T_NONE      30   65  100   40   45   25 G_BOTH I_BITTERBERRY       -- why not
  P_CLOYSTER   P_SHELLDER   T_WATER    T_ICE       50   95  180   70   85   45 G_BOTH I_KINGSROCK         -- it's cool. cloyster is a rock
  P_GASTLY     P_NONE       T_GHOST    T_POISON    30   35   30   80  100   35 G_BOTH I_BERRY             -- has curse
  P_HAUNTER    P_GASTLY     T_GHOST    T_POISON    45   50   45   95  115   55 G_BOTH I_SPELLTAG          -- type upgrade, though unused without changing moves
  P_GENGAR     P_HAUNTER    T_GHOST    T_POISON    60   65   60  110  130   75 G_BOTH I_FOCUSBAND         -- maybe good with dream eater
  P_ONIX       P_NONE       T_ROCK     T_GROUND    35   45  160   70   30   45 G_BOTH I_HARDSTONE         -- no berry because of flail
  P_DROWZEE    P_NONE       T_PSYCHIC  T_NONE      60   48   45   42   43   90 G_BOTH I_MINTBERRY         -- he hypnotizes... shouldn't fall asleep!
  P_HYPNO      P_DROWZEE    T_PSYCHIC  T_NONE      85   73   70   67   73  115 G_BOTH I_KINGSROCK         -- with headbutt
  P_KRABBY     P_NONE       T_WATER    T_NONE      30  105   90   50   25   25 G_BOTH I_PARALYZECUREBERRY -- why not
  P_KINGLER    P_KRABBY     T_WATER    T_NONE      55  130  115   75   50   50 G_BOTH I_MYSTICWATER       -- crab hammer et al
  P_VOLTORB    P_NONE       T_ELECTRIC T_NONE      40   30   50  100   55   55 G_NONE I_POISONCUREBERRY   -- why not
  P_ELECTRODE  P_VOLTORB    T_ELECTRIC T_NONE      60   50   70  140   80   80 G_NONE I_FOCUSBAND         -- with explosion
  P_EXEGGCUTE  P_NONE       T_GRASS    T_PSYCHIC   60   40   80   40   60   45 G_BOTH I_MIRACLESEED       -- for solar beam
  P_EXEGGUTOR  P_EXEGGCUTE  T_GRASS    T_PSYCHIC   95   95   85   55  125   65 G_BOTH I_LEFTOVERS         -- tanky
  P_CUBONE     P_NONE       T_GROUND   T_NONE      50   50   95   35   40   50 G_BOTH I_THICKCLUB         -- special
  P_MAROWAK    P_CUBONE     T_GROUND   T_NONE      60   80  110   45   50   80 G_BOTH I_THICKCLUB         -- special
  P_HITMONLEE  P_TYROGUE    T_FIGHTING T_NONE      50  120   53   87   35  110 G_MALE I_BLACKBELT         -- cliche
  P_HITMONCHAN P_TYROGUE    T_FIGHTING T_NONE      50  105   79   76   35  110 G_MALE I_BLACKBELT         -- cliche
  P_LICKITUNG  P_NONE       T_NORMAL   T_NONE      90   55   75   30   60   75 G_BOTH I_GOLDBERRY         -- tanky
  P_KOFFING    P_NONE       T_POISON   T_NONE      40   65   95   35   60   45 G_BOTH I_ICEBERRY          -- idk why, 1st evol
  P_WEEZING    P_KOFFING    T_POISON   T_NONE      65   90  120   60   85   70 G_BOTH I_FOCUSBAND         -- explosion
  P_RHYHORN    P_NONE       T_GROUND   T_ROCK      80   85   95   25   30   30 G_BOTH I_POISONCUREBERRY   -- heal
  P_RHYDON     P_RHYHORN    T_GROUND   T_ROCK     105  130  120   40   45   45 G_BOTH I_LEFTOVERS         -- why not and upgrade from berry
  P_CHANSEY    P_NONE       T_NORMAL   T_NONE     250    5    5   50   35  105 G_FEMA I_LUCKYPUNCH        -- special
  P_TANGELA    P_NONE       T_GRASS    T_NONE      65   55  115   60  100   40 G_BOTH I_MIRACLESEED       -- sure
  P_KANGASKHAN P_NONE       T_NORMAL   T_NONE     105   95   80   90   40   80 G_FEMA I_PINKBOW           -- no berry because of reversal
  P_HORSEA     P_NONE       T_WATER    T_NONE      30   40   70   60   70   25 G_BOTH I_BURNTBERRY        -- no reason (first evol)
  P_SEADRA     P_HORSEA     T_WATER    T_NONE      55   65   95   85   95   45 G_BOTH I_MYSTICWATER       -- has water move
  P_GOLDEEN    P_NONE       T_WATER    T_NONE      45   67   60   63   35   50 G_BOTH I_BITTERBERRY       -- no reason
  P_SEAKING    P_GOLDEEN    T_WATER    T_NONE      80   92   65   68   65   80 G_BOTH I_MYSTICWATER       -- water moves
  P_STARYU     P_NONE       T_WATER    T_NONE      30   45   55   85   70   55 G_NONE I_ICEBERRY          -- no reason
  P_STARMIE    P_STARYU     T_WATER    T_PSYCHIC   60   75   85  115  100   85 G_NONE I_MYSTICWATER       -- bubblebeam
  P_MRMIME     P_NONE       T_PSYCHIC  T_NONE      40   45   65   90  100  120 G_BOTH I_MYSTERYBERRY      -- wild has it
  P_SCYTHER    P_NONE       T_BUG      T_FLYING    70  110   80  105   55   80 G_BOTH I_SCOPELENS         -- slash
  P_JYNX       P_SMOOCHUM   T_ICE      T_PSYCHIC   65   50   35   95  115   95 G_FEMA I_NEVERMELTICE      -- why not.. ice punch
  P_ELECTABUZZ P_ELEKID     T_ELECTRIC T_NONE      65   83   57  105   95   85 G_BOTH I_MAGNET            -- why not.. match their type
  P_MAGMAR     P_MAGBY      T_FIRE     T_NONE      65   95   57   93  100   85 G_BOTH I_CHARCOAL          -- why not.. match their type
  P_PINSIR     P_NONE       T_BUG      T_NONE      65  125  100   85   55   70 G_BOTH I_SILVERPOWDER      -- doesn't any bug moves so no powder
  P_TAUROS     P_NONE       T_NORMAL   T_NONE      75  100   95  110   40   70 G_MALE I_KINGSROCK         -- flinching with rage
  P_MAGIKARP   P_NONE       T_WATER    T_NONE      20   10   55   80   15   20 G_BOTH I_BITTERBERRY       -- no berry because of reversal
  P_GYARADOS   P_MAGIKARP   T_WATER    T_FLYING    95  125   79   81   60  100 G_BOTH I_MYSTICWATER       -- hydropump
  P_LAPRAS     P_NONE       T_WATER    T_ICE      130   85   80   60   85   95 G_BOTH I_NEVERMELTICE      -- ice beam
  P_DITTO      P_NONE       T_NORMAL   T_NONE      48   48   48   48   48   48 G_NONE I_METALPOWDER       -- special
  P_EEVEE      P_NONE       T_NORMAL   T_NONE      55   55   50   55   45   65 G_BOTH I_QUICKCLAW         -- eevee should be quick
  P_VAPOREON   P_EEVEE      T_WATER    T_NONE     130   65   60   65  110   95 G_BOTH I_MYSTICWATER       -- type match
  P_JOLTEON    P_EEVEE      T_ELECTRIC T_NONE      65   65   60  130  110   95 G_BOTH I_MAGNET            -- type match
  P_FLAREON    P_EEVEE      T_FIRE     T_NONE      65  130   60   65   95  110 G_BOTH I_CHARCOAL          -- type match
  P_PORYGON    P_NONE       T_NORMAL   T_NONE      65   60   70   40   85   75 G_NONE I_MINTBERRY         -- why not
  P_OMANYTE    P_NONE       T_ROCK     T_WATER     35   40  100   35   90   55 G_BOTH I_MYSTERYBERRY      -- in ruins of alph omanyte room
  P_OMASTAR    P_OMANYTE    T_ROCK     T_WATER     70   60  125   55  115   70 G_BOTH I_HARDSTONE         -- ancient power
  P_KABUTO     P_NONE       T_ROCK     T_WATER     30   80   90   55   55   45 G_BOTH I_POISONCUREBERRY   -- in ruins of alph kabuto room
  P_KABUTOPS   P_KABUTO     T_ROCK     T_WATER     60  115  105   80   65   70 G_BOTH I_HARDSTONE         -- ancient power
  P_AERODACTYL P_NONE       T_ROCK     T_FLYING    80  105   65  130   60   75 G_BOTH I_GOLDBERRY         -- in ruins of alph aerodactyl room
  P_SNORLAX    P_NONE       T_NORMAL   T_NONE     160  110   65   30   65  110 G_BOTH I_LEFTOVERS         -- def yes for the tankz
  P_ARTICUNO   P_NONE       T_ICE      T_FLYING    90   85  100   85   95  125 G_NONE I_BRIGHTPOWDER      -- trade from rby to gsc
  P_ZAPDOS     P_NONE       T_ELECTRIC T_FLYING    90   90   85  100  125   90 G_NONE I_BRIGHTPOWDER      -- trade from rby to gsc
  P_MOLTRES    P_NONE       T_FIRE     T_FLYING    90  100   90   90  125   85 G_NONE I_BRIGHTPOWDER      -- trade from rby to gsc
  P_DRATINI    P_NONE       T_DRAGON   T_NONE      41   64   45   50   50   50 G_BOTH I_BITTERBERRY       -- has thrash & first evol
  P_DRAGONAIR  P_DRATINI    T_DRAGON   T_NONE      61   84   65   70   70   70 G_BOTH I_DRAGONFANG        -- level 2 type boost and in dragons den and wild has it
  P_DRAGONITE  P_DRAGONAIR  T_DRAGON   T_FLYING    91  134   95   80  100  100 G_BOTH I_LEFTOVERS         -- has outrage
  P_MEWTWO     P_NONE       T_PSYCHIC  T_NONE     106  110   90  130  154   90 G_NONE I_BERSERKGENE       -- trade from rby to gsc
  P_MEW        P_NONE       T_PSYCHIC  T_NONE     100  100  100  100  100  100 G_NONE I_MIRACLEBERRY      -- wild has it (celebi too)
  P_CHIKORITA  P_NONE       T_GRASS    T_NONE      45   49   65   45   49   65 G_BOTH I_BERRY             -- starter first evol
  P_BAYLEEF    P_CHIKORITA  T_GRASS    T_NONE      60   62   80   60   63   80 G_BOTH I_MIRACLESEED       -- 2nd evol type boost
  P_MEGANIUM   P_BAYLEEF    T_GRASS    T_NONE      80   82  100   80   83  100 G_BOTH I_QUICKCLAW         -- tanky
  P_CYNDAQUIL  P_NONE       T_FIRE     T_NONE      39   52   43   65   60   50 G_BOTH I_BERRY             -- starter first evol
  P_QUILAVA    P_CYNDAQUIL  T_FIRE     T_NONE      58   64   58   80   80   65 G_BOTH I_CHARCOAL          -- 2nd evol type boost
  P_TYPHLOSION P_QUILAVA    T_FIRE     T_NONE      78   84   78  100  109   85 G_BOTH I_QUICKCLAW         -- tanky SUBMISSION in moveset
  P_TOTODILE   P_NONE       T_WATER    T_NONE      50   65   64   43   44   48 G_BOTH I_BERRY             -- starter first evol
  P_CROCONAW   P_TOTODILE   T_WATER    T_NONE      65   80   80   58   59   63 G_BOTH I_MYSTICWATER       -- 2nd evol type boost
  P_FERALIGATR P_CROCONAW   T_WATER    T_NONE      85  105  100   78   79   83 G_BOTH I_GOLDBERRY         -- tanky
  P_SENTRET    P_NONE       T_NORMAL   T_NONE      35   46   34   20   35   45 G_BOTH I_BERRY             -- wild has berry
  P_FURRET     P_SENTRET    T_NORMAL   T_NONE      85   76   64   90   45   55 G_BOTH I_PINKBOW           -- has multiple normal moves
  P_HOOTHOOT   P_NONE       T_NORMAL   T_FLYING    60   30   30   50   36   56 G_BOTH I_MYSTERYBERRY      -- why not
  P_NOCTOWL    P_HOOTHOOT   T_NORMAL   T_FLYING   100   50   50   70   76   96 G_BOTH I_SCOPELENS         -- takedown in moveset
  P_LEDYBA     P_NONE       T_BUG      T_FLYING    40   20   30   55   40   80 G_BOTH I_MINTBERRY         -- why not
  P_LEDIAN     P_LEDYBA     T_BUG      T_FLYING    55   35   50   85   55  110 G_BOTH I_FOCUSBAND         -- doubed in moveset
  P_SPINARAK   P_NONE       T_BUG      T_POISON    40   60   40   30   40   40 G_BOTH I_ICEBERRY          -- why not
  P_ARIADOS    P_SPINARAK   T_BUG      T_POISON    70   90   70   40   60   60 G_BOTH I_QUICKCLAW         -- for trapping
  P_CROBAT     P_GOLBAT     T_POISON   T_FLYING    85   90   80  130   70   80 G_BOTH I_KINGSROCK         -- op for final evol
  P_CHINCHOU   P_NONE       T_WATER    T_ELECTRIC  75   38   38   67   56   56 G_BOTH I_MINTBERRY         -- first evol
  P_LANTURN    P_CHINCHOU   T_WATER    T_ELECTRIC 125   58   58   67   76   76 G_BOTH I_GOLDBERRY         -- tanky
  P_PICHU      P_NONE       T_ELECTRIC T_NONE      20   40   15   60   35   35 G_BOTH I_POISONCUREBERRY   -- baby first evol of 3
  P_CLEFFA     P_NONE       T_NORMAL   T_NONE      50   25   28   15   45   55 G_BOTH I_BURNTBERRY        -- baby first evol of 3
  P_IGGLYBUFF  P_NONE       T_NORMAL   T_NONE      90   30   15   15   40   20 G_BOTH I_ICEBERRY          -- baby first evol of 3
  P_TOGEPI     P_NONE       T_NORMAL   T_NONE      35   20   65   20   40   65 G_BOTH I_MYSTERYBERRY      -- baby
  P_TOGETIC    P_TOGEPI     T_NORMAL   T_FLYING    55   40   85   40   80  105 G_BOTH I_FOCUSBAND         -- doubleedge in moveset and belongs in final evol
  P_NATU       P_NONE       T_PSYCHIC  T_FLYING    40   50   45   70   70   45 G_BOTH I_BITTERBERRY       -- no confuse since it has confuse ray?
  P_XATU       P_NATU       T_PSYCHIC  T_FLYING    65   75   70   95   95   70 G_BOTH I_LEFTOVERS         -- psychic
  P_MAREEP     P_NONE       T_ELECTRIC T_NONE      55   40   40   35   65   45 G_BOTH I_POISONCUREBERRY   -- no reason first evol
  P_FLAAFFY    P_MAREEP     T_ELECTRIC T_NONE      70   55   55   45   80   60 G_BOTH I_MAGNET            -- 2nd evol type boost
  P_AMPHAROS   P_FLAAFFY    T_ELECTRIC T_NONE      90   75   75   55  115   90 G_BOTH I_SCOPELENS         -- why not
  P_BELLOSSOM  P_GLOOM      T_GRASS    T_NONE      75   80   85   50   90  100 G_BOTH I_KINGSROCK         -- tanky
  P_MARILL     P_NONE       T_WATER    T_NONE      70   20   50   40   20   50 G_BOTH I_PARALYZECUREBERRY -- protect from electric
  P_AZUMARILL  P_MARILL     T_WATER    T_NONE     100   50   80   50   50   80 G_BOTH I_MYSTICWATER       -- bubble beam
  P_SUDOWOODO  P_NONE       T_ROCK     T_NONE      70  100  115   30   30   65 G_BOTH I_HARDSTONE         -- has rock move
  P_POLITOED   P_POLIWHIRL  T_WATER    T_NONE      90   75   75   70   90  100 G_BOTH I_KINGSROCK         -- evolve trade
  P_HOPPIP     P_NONE       T_GRASS    T_FLYING    35   35   40   50   35   55 G_BOTH I_AMULETCOIN        -- can learn pay day :D
  P_SKIPLOOM   P_HOPPIP     T_GRASS    T_FLYING    55   45   50   80   45   65 G_BOTH I_AMULETCOIN        -- can learn pay day :D
  P_JUMPLUFF   P_SKIPLOOM   T_GRASS    T_FLYING    75   55   70  110   55   85 G_BOTH I_AMULETCOIN        -- can learn pay day :D
  P_AIPOM      P_NONE       T_NORMAL   T_NONE      55   70   55   85   40   55 G_BOTH I_KINGSROCK         -- spammy
  P_SUNKERN    P_NONE       T_GRASS    T_NONE      30   30   30   30   30   30 G_BOTH I_BURNTBERRY        -- idk
  P_SUNFLORA   P_SUNKERN    T_GRASS    T_NONE      75   75   55   30  105   85 G_BOTH I_SCOPELENS         -- Lost its healing move
  P_YANMA      P_NONE       T_BUG      T_FLYING    65   65   45   95   75   45 G_BOTH I_QUICKCLAW         -- speedy bug
  P_WOOPER     P_NONE       T_WATER    T_GROUND    55   45   45   15   25   25 G_BOTH I_MINTBERRY         -- idk
  P_QUAGSIRE   P_WOOPER     T_WATER    T_GROUND    95   85   85   35   65   65 G_BOTH I_SOFTSAND          -- has earthquake
  P_ESPEON     P_EEVEE      T_PSYCHIC  T_NONE      65   65   60  110  130   95 G_BOTH I_TWISTEDSPOON      -- type eevee
  P_UMBREON    P_EEVEE      T_DARK     T_NONE      95   65  110   65   60  130 G_BOTH I_BLACKGLASSES      -- type eevee
  P_MURKROW    P_NONE       T_DARK     T_FLYING    60   85   42   91   85   42 G_BOTH I_GOLDBERRY         -- why not. it might learn thief
  P_SLOWKING   P_SLOWBRO    T_WATER    T_PSYCHIC   95   75   80   30  100  110 G_BOTH I_KINGSROCK         -- evolve trade
  P_MISDREAVUS P_NONE       T_GHOST    T_NONE      60   60   60   85   85   85 G_BOTH I_SPELLTAG          -- wild has it
  P_UNOWN      P_NONE       T_PSYCHIC  T_NONE      48   72   48   48   72   48 G_NONE I_MYSTERYBERRY      -- mysterious and pp fight?
  P_WOBBUFFET  P_NONE       T_PSYCHIC  T_NONE     190   33   58   33   33   58 G_BOTH I_QUICKCLAW         -- for destiny bond... maybe good
  P_GIRAFARIG  P_NONE       T_NORMAL   T_PSYCHIC   70   80   65   85   90   65 G_BOTH I_TWISTEDSPOON      -- psybeam
  P_PINECO     P_NONE       T_BUG      T_NONE      50   65   90   15   35   35 G_BOTH I_MYSTERYBERRY      -- idk
  P_FORRETRESS P_PINECO     T_BUG      T_STEEL     75   90  140   40   60   60 G_BOTH I_FOCUSBAND         -- for explosion
  P_DUNSPARCE  P_NONE       T_NORMAL   T_NONE     100   70   70   45   65   65 G_BOTH I_GOLDBERRY         -- Recoil from take down and bide in possible moveset
  P_GLIGAR     P_NONE       T_GROUND   T_FLYING    65   75  105   85   35   65 G_BOTH I_QUICKCLAW         -- just a general help
  P_STEELIX    P_ONIX       T_STEEL    T_GROUND    75   85  200   30   55   65 G_BOTH I_METALCOAT         -- evolve trade
  P_SNUBBULL   P_NONE       T_NORMAL   T_NONE      60   80   50   30   40   40 G_BOTH I_BERRY             -- trainer has return...
  P_GRANBULL   P_SNUBBULL   T_NORMAL   T_NONE      90  120   75   45   60   60 G_BOTH I_QUICKCLAW         -- Takedown in moveset
  P_QWILFISH   P_NONE       T_WATER    T_POISON    65   95   75   85   55   55 G_BOTH I_FOCUSBAND         -- IDK. Why not.
  P_SCIZOR     P_SCYTHER    T_BUG      T_STEEL     70  130  100   65   55   80 G_BOTH I_METALCOAT         -- evolve trade
  P_SHUCKLE    P_NONE       T_BUG      T_ROCK      20   10  230    5   10  230 G_BOTH I_GOLDBERRY         -- complement high defense and low hp
  P_HERACROSS  P_NONE       T_BUG      T_FIGHTING  80  125   75   85   40   95 G_BOTH I_QUICKCLAW         -- this could complement reversal+endure pretty well
  P_SNEASEL    P_NONE       T_DARK     T_ICE       55   95   55  115   35   75 G_BOTH I_QUICKCLAW         -- wild has quickclaw
  P_TEDDIURSA  P_NONE       T_NORMAL   T_NONE      60   80   50   40   50   50 G_BOTH I_BITTERBERRY       -- has thrash and first evol
  P_URSARING   P_TEDDIURSA  T_NORMAL   T_NONE      90  130   75   55   75   75 G_BOTH I_QUICKCLAW         -- tanky
  P_SLUGMA     P_NONE       T_FIRE     T_NONE      40   40   40   20   70   40 G_BOTH I_BURNTBERRY        -- more default rock moves than fire
  P_MAGCARGO   P_SLUGMA     T_FIRE     T_ROCK      50   50  120   30   80   80 G_BOTH I_HARDSTONE         -- more default rock moves than fire
  P_SWINUB     P_NONE       T_ICE      T_GROUND    50   50   40   50   30   30 G_BOTH I_ICEBERRY          -- cure burnt, why not
  P_PILOSWINE  P_SWINUB     T_ICE      T_GROUND   100  100   80   50   60   60 G_BOTH I_NEVERMELTICE      -- blizzard
  P_CORSOLA    P_NONE       T_WATER    T_ROCK      55   55   85   35   65   85 G_BOTH I_KINGSROCK         -- its a rock!
  P_REMORAID   P_NONE       T_WATER    T_NONE      35   65   35   65   65   35 G_BOTH I_BURNTBERRY        -- idk
  P_OCTILLERY  P_REMORAID   T_WATER    T_NONE      75  105   75   45  105   75 G_BOTH I_MYSTICWATER       -- octazooka
  P_DELIBIRD   P_NONE       T_ICE      T_FLYING    45   55   45   75   65   45 G_BOTH I_NEVERMELTICE      -- aurbeam
  P_MANTINE    P_NONE       T_WATER    T_FLYING    65   40   70   70   80  140 G_BOTH I_MYSTICWATER       -- bubbeam
  P_SKARMORY   P_NONE       T_STEEL    T_FLYING    65   80  140   70   40   70 G_BOTH I_METALCOAT         -- steel of course
  P_HOUNDOUR   P_NONE       T_DARK     T_FIRE      45   60   30   65   80   50 G_BOTH I_PARALYZECUREBERRY -- idk
  P_HOUNDOOM   P_HOUNDOUR   T_DARK     T_FIRE      75   90   50   95  110   80 G_BOTH I_LEFTOVERS         -- crunch
  P_KINGDRA    P_SEADRA     T_WATER    T_DRAGON    75   95   95   85   95   95 G_BOTH I_DRAGONFANG        -- evolve trade
  P_PHANPY     P_NONE       T_GROUND   T_NONE      90   60   60   40   40   40 G_BOTH I_BERRY             -- no berry because of flail
  P_DONPHAN    P_PHANPY     T_GROUND   T_NONE      90  120  120   50   60   60 G_BOTH I_KINGSROCK         -- rollout have flinch
  P_PORYGON2   P_PORYGON    T_NORMAL   T_NONE      85   80   90   60  105   95 G_NONE I_PINKBOW           -- for tri attack
  P_STANTLER   P_NONE       T_NORMAL   T_NONE      73   95   62   85   85   65 G_BOTH I_FOCUSBAND         -- takedown in moveset
  P_SMEARGLE   P_NONE       T_NORMAL   T_NONE      55   20   35   75   20   45 G_BOTH I_FOCUSBAND         -- just helps
  P_TYROGUE    P_NONE       T_FIGHTING T_NONE      35   35   35   35   35   35 G_MALE I_PARALYZECUREBERRY -- baby
  P_HITMONTOP  P_TYROGUE    T_FIGHTING T_NONE      50   95   95   70   35  110 G_MALE I_BLACKBELT         -- cliche
  P_SMOOCHUM   P_NONE       T_ICE      T_PSYCHIC   45   30   15   65   85   65 G_FEMA I_PARALYZECUREBERRY -- baby
  P_ELEKID     P_NONE       T_ELECTRIC T_NONE      45   63   37   95   65   55 G_BOTH I_BITTERBERRY       -- baby
  P_MAGBY      P_NONE       T_FIRE     T_NONE      45   75   37   83   70   55 G_BOTH I_MINTBERRY         -- baby
  P_MILTANK    P_NONE       T_NORMAL   T_NONE      95   80  105  100   40   70 G_FEMA I_KINGSROCK         -- rollout with flinch
  P_BLISSEY    P_CHANSEY    T_NORMAL   T_NONE     255   10   10   55   75  135 G_FEMA I_LEFTOVERS         -- final evol & lots of hp, why not
  P_RAIKOU     P_NONE       T_ELECTRIC T_NONE      90   85   75  115  115  100 G_NONE I_BRIGHTPOWDER      -- match gen 1 legendaries
  P_ENTEI      P_NONE       T_FIRE     T_NONE     115  115   85  100   90   75 G_NONE I_BRIGHTPOWDER      -- match gen 1 legendaries
  P_SUICUNE    P_NONE       T_WATER    T_NONE     100   75  115   85   90  115 G_NONE I_BRIGHTPOWDER      -- match gen 1 legendaries
  P_LARVITAR   P_NONE       T_ROCK     T_GROUND    50   64   50   41   45   50 G_BOTH I_MYSTERYBERRY      -- no reason first evol
  P_PUPITAR    P_LARVITAR   T_ROCK     T_GROUND    70   84   70   51   65   70 G_BOTH I_SOFTSAND          -- level 2 type boost
  P_TYRANITAR  P_PUPITAR    T_ROCK     T_DARK     100  134  110   61   95  100 G_BOTH I_KINGSROCK         -- cause he's awesome and kingly. complements leftovers on dragonite
  P_LUGIA      P_NONE       T_PSYCHIC  T_FLYING   106   90  130  110   90  154 G_NONE I_BRIGHTPOWDER      -- match gen 1 legendaries
  P_HOOH       P_NONE       T_FIRE     T_FLYING   106  130   90   90  110  154 G_NONE I_BRIGHTPOWDER      -- match gen 1 legendaries
  P_CELEBI     P_NONE       T_PSYCHIC  T_GRASS    100  100  100  100  100  100 G_NONE I_MIRACLEBERRY      -- wild has it (mew too)
]]
