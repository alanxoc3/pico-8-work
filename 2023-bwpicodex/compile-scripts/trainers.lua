function init() -- entry point for this compile script
  for trainer in all(datastr_to_arr(g_trainer_data)) do
    for thing in all(trainer) do
      offsetpoke(thing)
    end
  end
  log("Wrote Trainer Data")
end

-- 57 trainers total - includes every pokemon and every move besides missingno, tm05, and struggle.
-- saves a few tokens when upacking to put the move at the beginning
-- 254 is girl. 35 boys. 22 girls
-- IDEA: I could set the gender bit of every pokemon if I want with the first byte. maybe overkill though. Anyways, I can fit something in that first byte. Maybe the trainer AI alg? Idk...
g_trainer_data = [[
  253 M_SWIFT        P_RATTATA    P_PIDGEY     P_SENTRET    P_ZUBAT      P_WOOPER     P_EEVEE      -- youngster    TM39 -- ACTUALLY, not using the gender flag, but it might be cool to use :D
  253 M_DREAMEATER   P_PSYDUCK    P_CUBONE     P_HOOTHOOT   P_MEOWTH     P_GASTLY     P_BELLSPROUT -- sage         TM42
  253 M_MUDSLAP      P_PIDGEY     P_SPEAROW    P_DELIBIRD   P_FARFETCHD  P_DODUO      P_PIDGEOTTO  -- falkner      TM31

  254 M_FRUSTRATION  P_ZUBAT      P_EKANS      P_GRIMER     P_SLOWPOKE   P_KOFFING    P_RATICATE   -- rocketgrunt  TM21
  253 M_CUT          P_CATERPIE   P_LEDYBA     P_PARAS      P_WEEDLE     P_VENONAT    P_SPINARAK   -- bugcatcher   HM01
  253 M_FURYCUTTER   P_KAKUNA     P_WEEPINBELL P_METAPOD    P_PINSIR     P_PINECO     P_SCYTHER    -- bugsy        TM49

  253 M_RETURN       P_CHIKORITA  P_CYNDAQUIL  P_TOTODILE   P_IGGLYBUFF  P_PICHU      P_SNUBBULL   -- pokefan      TM27
  254 M_PSYCHUP      P_MAREEP     P_POLIWAG    P_TEDDIURSA  P_CLEFFA     P_HOPPIP     P_TOGEPI     -- beauty       TM09
  254 M_ATTRACT      P_JIGGLYPUFF P_CLEFAIRY   P_CHANSEY    P_PHANPY     P_LICKITUNG  P_MILTANK    -- whitney      TM45

  254 M_REST         P_EEVEE      P_VAPOREON   P_JOLTEON    P_FLAREON    P_ESPEON     P_UMBREON    -- kiminogirl   TM44
  254 M_NIGHTMARE    P_CUBONE     P_GASTLY     P_ABRA       P_DROWZEE    P_HAUNTER    P_SLOWBRO    -- medium       TM50
  253 M_SHADOWBALL   P_WOBBUFFET  P_STANTLER   P_HAUNTER    P_MISDREAVUS P_SUDOWOODO  P_GENGAR     -- morty        TM30

  253 M_ROAR         P_LARVITAR   P_NIDORANF   P_HOUNDOUR   P_VULPIX     P_NIDORANM   P_GROWLITHE  -- officer      TM05
  253 M_ROCKSMASH    P_MACHOP     P_TYROGUE    P_MANKEY     P_POLIWHIRL  P_ONIX       P_HERACROSS  -- blackbelt    TM08
  253 M_DYNAMICPUNCH P_MACHOKE    P_GRANBULL   P_HITMONTOP  P_POLITOED   P_PRIMEAPE   P_POLIWRATH  -- chuck        TM01

  253 M_FLY          P_BAYLEEF    P_QUILAVA    P_CROCONAW   P_FLAAFFY    P_PIKACHU    P_NOCTOWL    -- gentleman    HM02
  253 M_STRENGTH     P_HORSEA     P_MARILL     P_MACHOKE    P_KRABBY     P_GEODUDE    P_QUAGSIRE   -- sailor       HM04
  254 M_IRONTAIL     P_CORSOLA    P_MAGNEMITE  P_FORRETRESS P_SKARMORY   P_MANTINE    P_STEELIX    -- jasmine      TM23

  254 M_HEADBUTT     P_ARBOK      P_RATICATE   P_GOLBAT     P_MURKROW    P_WEEZING    P_PERSIAN    -- rocketexec   TM02
  254 M_ICEPUNCH     P_SMOOCHUM   P_SHELLDER   P_SWINUB     P_DELIBIRD   P_SEEL       P_AZUMARILL  -- skier        TM33
  253 M_ICYWIND      P_LAPRAS     P_FEAROW     P_SNEASEL    P_URSARING   P_DEWGONG    P_PILOSWINE  -- pryce        TM16

  253 M_THUNDER      P_VOLTORB    P_PORYGON    P_KOFFING    P_SMEARGLE   P_ODDISH     P_DITTO      -- scientist    TM25 -- both smeargle and porygon learn sharpen
  254 M_SWEETSCENT   P_SHUCKLE    P_DRATINI    P_MAGIKARP   P_SKIPLOOM   P_SEADRA     P_LEDIAN     -- twins        TM12
  254 M_DRAGONBREATH P_DONPHAN    P_DRAGONAIR  P_AMPHAROS   P_GYARADOS   P_PUPITAR    P_KINGDRA    -- clair        TM24

  253 M_THIEF        P_ELEKID     P_OMANYTE    P_TENTACOOL  P_KABUTO     P_PONYTA     P_GLIGAR     -- supernerd    TM46
  254 M_DEFENSECURL  P_DIGLETT    P_NIDORINA   P_SANDSHREW  P_PRIMEAPE   P_GRAVELER   P_NIDORINO   -- camper       TM40
  253 M_SANDSTORM    P_OMASTAR    P_RHYHORN    P_KABUTOPS   P_AERODACTYL P_STEELIX    P_GOLEM      -- brock        TM37

  253 M_ROLLOUT      P_NATU       P_YANMA      P_DITTO      P_LEDIAN     P_TANGELA    P_TOGETIC    -- schoolboy    TM04
  254 M_WHIRLPOOL    P_STARYU     P_MANTINE    P_REMORAID   P_QWILFISH   P_GOLDEEN    P_TENTACRUEL -- swimmer      HM06
  254 M_SURF         P_GOLDUCK    P_QUAGSIRE   P_WIGGLYTUFF P_FERALIGATR P_SEAKING    P_STARMIE    -- misty        HM03

  253 M_HIDDENPOWER  P_BULBASAUR  P_CHARMANDER P_SQUIRTLE   P_SUNKERN    P_OMASTAR    P_UNOWN      -- juggler      TM10
  253 M_FLASH        P_KABUTOPS   P_CHINCHOU   P_ARBOK      P_SCIZOR     P_SANDSLASH  P_ELECTABUZZ -- guitarist    HM05
  253 M_ZAPCANNON    P_MAGNETON   P_ELECTRODE  P_PORYGON2   P_LANTURN    P_ELECTABUZZ P_RAICHU     -- ltsurge      TM07

  253 M_DIG          P_SANDSLASH  P_GLIGAR     P_PARASECT   P_MAROWAK    P_DONPHAN    P_DUGTRIO    -- hiker        TM28
  254 M_SOLARBEAM    P_BUTTERFREE P_GRANBULL   P_GLOOM      P_WIGGLYTUFF P_SUNFLORA   P_CLEFABLE   -- lass         TM22
  254 M_GIGADRAIN    P_TANGELA    P_MEGANIUM   P_VILEPLUME  P_BELLOSSOM  P_PARASECT   P_VICTREEBEL -- erika        TM19

  253 M_FIREPUNCH    P_SMEARGLE   P_SLUGMA     P_PINSIR     P_TAUROS     P_TENTACRUEL P_RAPIDASH   -- biker        TM48
  254 M_SLEEPTALK    P_EXEGGCUTE  P_AZUMARILL  P_FURRET     P_CLEFABLE   P_JUMPLUFF   P_KANGASKHAN -- picnicker    TM35
  254 M_SLUDGEBOMB   P_WEEZING    P_ARIADOS    P_ELECTRODE  P_MUK        P_NIDORINA   P_VENOMOTH   -- janine       TM36

  253 M_SNORE        P_IVYSAUR    P_CHARMELEON P_WARTORTLE  P_MAGNEMITE  P_KANGASKHAN P_DODRIO     -- pokemaniac   TM13
  254 M_THUNDERPUNCH P_MRMIME     P_GIRAFARIG  P_WOBBUFFET  P_KADABRA    P_SLOWBRO    P_HYPNO      -- psychic      TM41
  254 M_PSYCHIC      P_KADABRA    P_JYNX       P_STARMIE    P_HYPNO      P_MRMIME     P_ALAKAZAM   -- sabrina      TM29

  253 M_WATERFALL    P_QWILFISH   P_DUNSPARCE  P_CLOYSTER   P_SEAKING    P_CORSOLA    P_KINGLER    -- fisher       HM07
  253 M_SUNNYDAY     P_PERSIAN    P_MAGCARGO   P_RAPIDASH   P_BEEDRILL   P_MAGBY      P_NINETALES  -- firebreather TM11
  253 M_FIREBLAST    P_ARCANINE   P_GOLEM      P_TYPHLOSION P_MAGCARGO   P_OCTILLERY  P_MAGMAR     -- blaine       TM38

  253 M_STEELWING    P_FEAROW     P_DODUO      P_PIDGEOTTO  P_NOCTOWL    P_DODRIO     P_PIDGEOT    -- birdkeeper   TM47
  254 M_RAINDANCE    P_AIPOM      P_DUGTRIO    P_DEWGONG    P_CHANSEY    P_BLASTOISE  P_BLISSEY    -- cooltrainer  TM18
  253 M_EARTHQUAKE   P_PIDGEOT    P_ARCANINE   P_NIDOQUEEN  P_NIDOKING   P_VAPOREON   P_RHYDON     -- blue         TM26

  254 M_ENDURE       P_RAIKOU     P_ENTEI      P_SUICUNE    P_ZAPDOS     P_ARTICUNO   P_MOLTRES    -- legend       TM20
  253 M_PROTECT      P_CROBAT     P_MAGNETON   P_URSARING   P_SNEASEL    P_GENGAR     P_TYRANITAR  -- silver       TM17
  253 M_BLIZZARD     P_GIRAFARIG  P_JYNX       P_ESPEON     P_XATU       P_EXEGGUTOR  P_SLOWKING   -- will         TM14

  253 M_TOXIC        P_MUK        P_FORRETRESS P_VENOMOTH   P_ARIADOS    P_NIDOKING   P_CROBAT     -- koga         TM06
  253 M_DETECT       P_HITMONCHAN P_HITMONLEE  P_POLIWRATH  P_HERACROSS  P_HITMONTOP  P_MACHAMP    -- bruno        TM43
  254 M_CURSE        P_MURKROW    P_VENUSAUR   P_UMBREON    P_VILEPLUME  P_MISDREAVUS P_HOUNDOOM   -- karen        TM03

  253 M_HYPERBEAM    P_AERODACTYL P_GYARADOS   P_SNORLAX    P_KINGDRA    P_CHARIZARD  P_DRAGONITE  -- lance        TM15
  253 M_DOUBLETEAM   P_VENUSAUR   P_CHARIZARD  P_BLASTOISE  P_PIKACHU    P_MEWTWO     P_MEW        -- red          TM32 -- grass fire water is the order of starters from left to right when you choose it at te beginning of the game
  253 M_SWAGGER      P_MEGANIUM   P_TYPHLOSION P_FERALIGATR P_HOOH       P_LUGIA      P_CELEBI     -- gold         TM34 -- grass fire water is the order of starters from left to right when you choose it at te beginning of the game
]]
