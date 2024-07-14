function init() -- entry point for this compile script
  for trainer in all(datastr_to_arr(g_trainer_data)) do
    for thing in all(trainer) do
      offsetpoke(thing)
    end
  end
  log("Wrote Trainer Data")
end

-- 57 trainers total - includes every pokemon and every move besides missingno, tm05, and struggle.
-- saves a few tokens when upacking to put the move first
g_trainer_data = [[
  M_SWIFT        P_RATTATA    P_PIDGEY     P_SENTRET    P_ZUBAT      P_EEVEE      P_WOOPER     -- youngster    TM39 M -- ACTUALLY, not using the gender flag, but it might be cool to use :D
  M_DREAMEATER   P_PSYDUCK    P_CUBONE     P_HOOTHOOT   P_MEOWTH     P_GASTLY     P_BELLSPROUT -- sage         TM42 M
  M_MUDSLAP      P_PIDGEY     P_SPEAROW    P_DELIBIRD   P_FARFETCHD  P_DODUO      P_PIDGEOTTO  -- falkner      TM31 M

  M_FRUSTRATION  P_ZUBAT      P_EKANS      P_GRIMER     P_SLOWPOKE   P_KOFFING    P_RATICATE   -- rocketgrunt  TM21 F
  M_CUT          P_CATERPIE   P_LEDYBA     P_PARAS      P_WEEDLE     P_VENONAT    P_SPINARAK   -- bugcatcher   HM01 M
  M_FURYCUTTER   P_KAKUNA     P_WEEPINBELL P_METAPOD    P_PINSIR     P_PINECO     P_SCYTHER    -- bugsy        TM49 M

  M_RETURN       P_CHIKORITA  P_CYNDAQUIL  P_TOTODILE   P_IGGLYBUFF  P_PICHU      P_SNUBBULL   -- pokefan      TM27 M
  M_PSYCHUP      P_MAREEP     P_POLIWAG    P_TEDDIURSA  P_CLEFFA     P_HOPPIP     P_TOGEPI     -- beauty       TM09 F
  M_ATTRACT      P_JIGGLYPUFF P_CLEFAIRY   P_CHANSEY    P_PHANPY     P_LICKITUNG  P_MILTANK    -- whitney      TM45 F

  M_REST         P_EEVEE      P_VAPOREON   P_JOLTEON    P_FLAREON    P_ESPEON     P_UMBREON    -- kiminogirl   TM44 F
  M_NIGHTMARE    P_CUBONE     P_GASTLY     P_ABRA       P_DROWZEE    P_HAUNTER    P_SLOWBRO    -- medium       TM50 F
  M_SHADOWBALL   P_WOBBUFFET  P_STANTLER   P_HAUNTER    P_MISDREAVUS P_SUDOWOODO  P_GENGAR     -- morty        TM30 M

  M_ROAR         P_LARVITAR   P_NIDORANF   P_HOUNDOUR   P_VULPIX     P_NIDORANM   P_GROWLITHE  -- officer      TM05 M
  M_ROCKSMASH    P_MACHOP     P_TYROGUE    P_MANKEY     P_POLIWHIRL  P_ONIX       P_HERACROSS  -- blackbelt    TM08 M
  M_DYNAMICPUNCH P_MACHOKE    P_GRANBULL   P_HITMONTOP  P_POLITOED   P_PRIMEAPE   P_POLIWRATH  -- chuck        TM01 M

  M_FLY          P_BAYLEEF    P_QUILAVA    P_CROCONAW   P_FLAAFFY    P_PIKACHU    P_NOCTOWL    -- gentleman    HM02 M
  M_STRENGTH     P_HORSEA     P_MARILL     P_MACHOKE    P_KRABBY     P_GEODUDE    P_QUAGSIRE   -- sailor       HM04 M
  M_IRONTAIL     P_CORSOLA    P_MAGNEMITE  P_FORRETRESS P_SKARMORY   P_MANTINE    P_STEELIX    -- jasmine      TM23 F

  M_HEADBUTT     P_ARBOK      P_RATICATE   P_GOLBAT     P_MURKROW    P_WEEZING    P_PERSIAN    -- rocketexec   TM02 F
  M_ICEPUNCH     P_SMOOCHUM   P_SHELLDER   P_SWINUB     P_DELIBIRD   P_SEEL       P_AZUMARILL  -- skier        TM33 F
  M_ICYWIND      P_LAPRAS     P_FEAROW     P_SNEASEL    P_URSARING   P_DEWGONG    P_PILOSWINE  -- pryce        TM16 M

  M_THUNDER      P_VOLTORB    P_PORYGON    P_KOFFING    P_SMEARGLE   P_ODDISH     P_DITTO      -- scientist    TM25 M
  M_SWEETSCENT   P_SHUCKLE    P_DRATINI    P_MAGIKARP   P_SKIPLOOM   P_SEADRA     P_LEDIAN     -- twins        TM12 F
  M_DRAGONBREATH P_DONPHAN    P_DRAGONAIR  P_AMPHAROS   P_GYARADOS   P_PUPITAR    P_KINGDRA    -- clair        TM24 F

  M_THIEF        P_ELEKID     P_OMANYTE    P_TENTACOOL  P_KABUTO     P_PONYTA     P_GLIGAR     -- supernerd    TM46 M
  M_DEFENSECURL  P_DIGLETT    P_NIDORINA   P_SANDSHREW  P_PRIMEAPE   P_GRAVELER   P_NIDORINO   -- camper       TM40 M
  M_SANDSTORM    P_OMASTAR    P_RHYHORN    P_KABUTOPS   P_AERODACTYL P_STEELIX    P_GOLEM      -- brock        TM37 M

  M_ROLLOUT      P_NATU       P_YANMA      P_DITTO      P_LEDIAN     P_TANGELA    P_TOGETIC    -- schoolboy    TM04 M
  M_WHIRLPOOL    P_STARYU     P_MANTINE    P_REMORAID   P_QWILFISH   P_GOLDEEN    P_TENTACRUEL -- swimmer      HM06 F
  M_SURF         P_GOLDUCK    P_QUAGSIRE   P_WIGGLYTUFF P_FERALIGATR P_SEAKING    P_STARMIE    -- misty        HM03 F

  M_HIDDENPOWER  P_BULBASAUR  P_CHARMANDER P_SQUIRTLE   P_SUNKERN    P_OMASTAR    P_UNOWN      -- juggler      TM10 M
  M_FLASH        P_KABUTOPS   P_CHINCHOU   P_ARBOK      P_SCIZOR     P_SANDSLASH  P_ELECTABUZZ -- guitarist    HM05 M
  M_ZAPCANNON    P_MAGNETON   P_ELECTRODE  P_PORYGON2   P_LANTURN    P_ELECTABUZZ P_RAICHU     -- ltsurge      TM07 M

  M_DIG          P_SANDSLASH  P_GLIGAR     P_PARASECT   P_MAROWAK    P_DONPHAN    P_DUGTRIO    -- hiker        TM28 M
  M_SOLARBEAM    P_BUTTERFREE P_GRANBULL   P_GLOOM      P_WIGGLYTUFF P_SUNFLORA   P_CLEFABLE   -- lass         TM22 F
  M_GIGADRAIN    P_TANGELA    P_MEGANIUM   P_VILEPLUME  P_BELLOSSOM  P_PARASECT   P_VICTREEBEL -- erika        TM19 F

  M_FIREPUNCH    P_SMEARGLE   P_SLUGMA     P_PINSIR     P_TAUROS     P_TENTACRUEL P_RAPIDASH   -- biker        TM48 M
  M_SLEEPTALK    P_EXEGGCUTE  P_AZUMARILL  P_FURRET     P_CLEFABLE   P_JUMPLUFF   P_KANGASKHAN -- picnicker    TM35 F
  M_SLUDGEBOMB   P_WEEZING    P_ARIADOS    P_ELECTRODE  P_MUK        P_NIDORINA   P_VENOMOTH   -- janine       TM36 F

  M_SNORE        P_IVYSAUR    P_CHARMELEON P_WARTORTLE  P_MAGNEMITE  P_KANGASKHAN P_DODRIO     -- pokemaniac   TM13 M
  M_THUNDERPUNCH P_MRMIME     P_GIRAFARIG  P_WOBBUFFET  P_KADABRA    P_SLOWBRO    P_HYPNO      -- psychic      TM41 F
  M_PSYCHIC      P_KADABRA    P_JYNX       P_STARMIE    P_HYPNO      P_MRMIME     P_ALAKAZAM   -- sabrina      TM29 F

  M_WATERFALL    P_QWILFISH   P_DUNSPARCE  P_CLOYSTER   P_SEAKING    P_CORSOLA    P_KINGLER    -- fisher       HM07 M
  M_SUNNYDAY     P_PERSIAN    P_MAGCARGO   P_RAPIDASH   P_BEEDRILL   P_MAGBY      P_NINETALES  -- firebreather TM11 M
  M_FIREBLAST    P_ARCANINE   P_GOLEM      P_TYPHLOSION P_MAGCARGO   P_OCTILLERY  P_MAGMAR     -- blaine       TM38 M

  M_STEELWING    P_FEAROW     P_DODUO      P_PIDGEOTTO  P_NOCTOWL    P_DODRIO     P_PIDGEOT    -- birdkeeper   TM47 M
  M_RAINDANCE    P_AIPOM      P_DUGTRIO    P_DEWGONG    P_CHANSEY    P_BLASTOISE  P_BLISSEY    -- cooltrainer  TM18 F
  M_EARTHQUAKE   P_PIDGEOT    P_ARCANINE   P_NIDOQUEEN  P_NIDOKING   P_VAPOREON   P_RHYDON     -- blue         TM26 M

  M_ENDURE       P_RAIKOU     P_ENTEI      P_SUICUNE    P_ZAPDOS     P_ARTICUNO   P_MOLTRES    -- legend       TM20 U
  M_PROTECT      P_CROBAT     P_MAGNETON   P_URSARING   P_SNEASEL    P_GENGAR     P_TYRANITAR  -- silver       TM17 M
  M_BLIZZARD     P_GIRAFARIG  P_JYNX       P_ESPEON     P_XATU       P_EXEGGUTOR  P_SLOWKING   -- will         TM14 M

  M_TOXIC        P_MUK        P_FORRETRESS P_VENOMOTH   P_ARIADOS    P_NIDOKING   P_CROBAT     -- koga         TM06 M
  M_DETECT       P_HITMONCHAN P_HITMONLEE  P_POLIWRATH  P_HERACROSS  P_HITMONTOP  P_MACHAMP    -- bruno        TM43 M
  M_CURSE        P_MURKROW    P_VENUSAUR   P_UMBREON    P_VILEPLUME  P_MISDREAVUS P_HOUNDOOM   -- karen        TM03 F

  M_HYPERBEAM    P_AERODACTYL P_GYARADOS   P_SNORLAX    P_KINGDRA    P_CHARIZARD  P_DRAGONITE  -- lance        TM15 M
  M_DOUBLETEAM   P_VENUSAUR   P_CHARIZARD  P_BLASTOISE  P_PIKACHU    P_MEWTWO     P_MEW        -- red          TM32 M -- grass fire water is the order of starters from left to right when you choose it at te beginning of the game
  M_SWAGGER      P_MEGANIUM   P_TYPHLOSION P_FERALIGATR P_HOOH       P_LUGIA      P_CELEBI     -- gold         TM34 M -- grass fire water is the order of starters from left to right when you choose it at te beginning of the game
]]
