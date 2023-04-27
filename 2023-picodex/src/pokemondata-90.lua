|[c_pokemon]| f_zobj[[]] $$
|[c_pokemon_names]| split"missingno,bulbasaur,ivysaur,venusaur,charmander,charmeleon,charizard,squirtle,wartortle,blastoise,caterpie,metapod,butterfree,weedle,kakuna,beedrill,pidgey,pidgeotto,pidgeot,rattata,raticate,spearow,fearow,ekans,arbok,pikachu,raichu,sandshrew,sandslash,nidoran f,nidorina,nidoqueen,nidoran m,nidorino,nidoking,clefairy,clefable,vulpix,ninetales,jigglypuff,wigglytuff,zubat,golbat,oddish,gloom,vileplume,paras,parasect,venonat,venomoth,diglett,dugtrio,meowth,persian,psyduck,golduck,mankey,primeape,growlithe,arcanine,poliwag,poliwhirl,poliwrath,abra,kadabra,alakazam,machop,machoke,machamp,bellsprout,weepinbell,victreebel,tentacool,tentacruel,geodude,graveler,golem,ponyta,rapidash,slowpoke,slowbro,magnemite,magneton,farfetchd,doduo,dodrio,seel,dewgong,grimer,muk,shellder,cloyster,gastly,haunter,gengar,onix,drowzee,hypno,krabby,kingler,voltorb,electrode,exeggcute,exeggutor,cubone,marowak,hitmonlee,hitmonchan,lickitung,koffing,weezing,rhyhorn,rhydon,chansey,tangela,kangaskhan,horsea,seadra,goldeen,seaking,staryu,starmie,mr mime,scyther,jynx,electabuzz,magmar,pinsir,tauros,magikarp,gyarados,lapras,ditto,eevee,vaporeon,jolteon,flareon,porygon,omanyte,omastar,kabuto,kabutops,aerodactyl,snorlax,articuno,zapdos,moltres,dratini,dragonair,dragonite,mewtwo,mew" $$
|[c_major_names]|       f_zobj"0,none;,fainted,burned,frozen,paralyzed,poisoned,sleeping" $$
|[c_major_names_short]| f_zobj"0, ;,FNT,BRN,FZN,PAR,PSN,SLP" $$ -- keep the space here! needed for printing nothing in battle screen

-- pokemon moves can be physical or special. the order here is specific. odd numbers are physical. even numbers are special.
|[c_types]| f_zobj[[
    T_NONE;     bg,2,  name,~c_empty;
    T_NORMAL;   bg,2,  name,"normal",   T_GHOST,0,    T_ROCK,.5;
    T_FIRE;     bg,10, name,"fire",     T_GRASS,2,    T_ICE,2,      T_BUG,2,       T_FIRE,.5,     T_WATER,.5,    T_ROCK,.5,   T_DRAGON,.5;
    T_FIGHTING; bg,7,  name,"fighting", T_ICE,2,      T_NORMAL,2,   T_ROCK,2,      T_GHOST,0,     T_BUG,.5,      T_FLYING,.5, T_POISON,.5, T_PSYCHIC,.5;
    T_WATER;    bg,9,  name,"water",    T_FIRE,2,     T_GROUND,2,   T_ROCK,2,      T_DRAGON,.5,   T_GRASS,.5,    T_WATER,.5;
    T_POISON;   bg,6,  name,"poison",   T_BUG,2,      T_GRASS,2,    T_GHOST,.5,    T_GROUND,.5,   T_POISON,.5,   T_ROCK,.5;
    T_ELECTRIC; bg,11, name,"electric", T_FLYING,2,   T_WATER,2,    T_GROUND,0,    T_DRAGON,.5,   T_ELECTRIC,.5, T_GRASS,.5;
    T_GROUND;   bg,7,  name,"ground",   T_ELECTRIC,2, T_FIRE,2,     T_POISON,2,    T_ROCK,2,      T_FLYING,0,    T_BUG,.5,    T_GRASS,.5;
    T_GRASS;    bg,8,  name,"grass",    T_GROUND,2,   T_ROCK,2,     T_WATER,2,     T_BUG,.5,      T_DRAGON,.5,   T_FIRE,.5,   T_FLYING,.5, T_GRASS,.5, T_POISON,.5;
    T_FLYING;   bg,2,  name,"flying",   T_BUG,2,      T_FIGHTING,2, T_GRASS,2,     T_ELECTRIC,.5, T_ROCK,.5;
    T_ICE;      bg,9,  name,"ice",      T_DRAGON,2,   T_FLYING,2,   T_GRASS,2,     T_FIRE,.5,     T_ICE,.5,      T_WATER,.5;
    T_BUG;      bg,8,  name,"bug",      T_GRASS,2,    T_PSYCHIC,2,  T_FIGHTING,.5, T_FIRE,.5,     T_FLYING,.5,   T_GHOST,.5,  T_POISON,.5;
    T_PSYCHIC;  bg,6,  name,"psychic",  T_FIGHTING,2, T_POISON,2,   T_PSYCHIC,.5;
    T_ROCK;     bg,2,  name,"rock",     T_BUG,2,      T_FIRE,2,     T_FLYING,2,    T_ICE,2,       T_FIGHTING,.5, T_GROUND,.5;
    T_DRAGON;   bg,2,  name,"dragon",   T_DRAGON,2;
    T_GHOST;    bg,6,  name,"ghost",    T_GHOST,2,    T_NORMAL,0,   T_PSYCHIC,2;
    T_BIRD;     bg,2,  name,"bird";
]] $$

|[c_stages]| f_zobj[[
    maxhp,    "hp",
    special,  "spc",
    attack,   "att",
    defense,  "def",
    speed,    "spd",
    total,    "tot",
    accuracy, "acc",
    evasion,  "eva"
]] $$

-- 4 styles: 13,1 6,13 2,1, 8,2
|[c_menu_styles]| f_zobj[[
    ;bg,13, aa,5,  fg,1
   ;;bg,6,  aa,13, fg,13  -- "normal" movetype and "selected" row
   ;;bg,5,  aa,5,  fg,1
   ;;bg,6,  aa,5,  fg,5   -- disable + default battle bkgd
   ;;bg,1,  aa,5,  fg,13  -- this one is for credit/winmenu headers

   ;;bg,14, aa,4   -- darker/psychic/poison/ghost
   ;;bg,9,  aa,4   -- electric/ground
   ;;bg,11, aa,3   -- grass
   ;;bg,12, aa,5   -- water
   ;;bg,8,  aa,2   -- fire
   ;;bg,10, aa,4   -- electric/ground
]] $$

-- Agility      Raises the user's Speed by 2 stages.

-- accuracy 2 means it can't miss.
-- accuracy 0 means it affects the user.
-- pp 0 means it is struggle
-- dmg 0 means it likely changes status or has an effect.
|[c_moves]| f_zobj[[]] $$

-- this can't be in the global zobj struct because it references "%" funcs.
-- accuracy: 0 means can't miss. -1 means can't miss, but mirrormove can copy it & displays "??". else means can miss.
-- damage:   0 means no damage.  -1 means variable damage & shows  "??". else means normal dmg formula. n't miss. -1 means can't miss, but displays "??". else means can miss.
-- pp:       0 means infinite pp. else means finite pp.
_g.c_moves_raw = f_zobj[[
   --  "name",     movetype    pp  dmg  acc  func+params
  -1;, "none",     T_BIRD,     0,  40,  0  , ~f_move_default -- -1  This is the move used for confusion damage.
  ;0;, "struggle", T_BIRD,     0,  50,  100, ~f_move_recoil
   ;;, "megapnch", T_NORMAL,   20, 80,  85 , ~f_move_default
   ;;, "razrwind", T_NORMAL,   10, 80,  75 , ~f_move_prepare
   ;;, "sworddnc", T_NORMAL,   30, 0,   0  , ~f_move_self, ~f_move_stat, attack, 2
   ;;, "whrlwind", T_NORMAL,   20, 0,   100, ~f_move_other,~f_move_switch
   ;;, "megakick", T_NORMAL,   5,  120, 75 , ~f_move_default
   ;;, "toxic",    T_POISON,   10, 0,   85 , ~f_move_toxic
   ;;, "horndril", T_NORMAL,   5,  -5,  30 , ~f_move_ohko
   ;;, "bodyslam", T_NORMAL,   15, 85,  100, ~f_move_default,30,~f_move_major_other,C_MAJOR_PARALYZED
   ;;, "takedown", T_NORMAL,   20, 90,  85 , ~f_move_recoil
   ;;, "doubedge", T_NORMAL,   15, 100, 100, ~f_move_recoil
   ;;, "bublbeam", T_WATER,    20, 65,  100, ~f_move_default,10,~f_move_other, ~f_move_stat, speed, -1
   ;;, "watergun", T_WATER,    25, 40,  100, ~f_move_default
   ;;, "icebeam",  T_ICE,      10, 95,  100, ~f_move_default,10,~f_move_major_other,C_MAJOR_FROZEN
   ;;, "blizzard", T_ICE,      5,  120, 90 , ~f_move_default,10,~f_move_major_other,C_MAJOR_FROZEN
   ;;, "hyprbeam", T_NORMAL,   5,  150, 90 , ~f_move_hyperbeam
   ;;, "payday",   T_NORMAL,   20, 40,  100, ~f_move_default
   ;;, "submsion", T_FIGHTING, 20, 80,  80 , ~f_move_recoil
   ;;, "counter",  T_FIGHTING, 20, -5,  100, ~f_move_counter
   ;;, "seistoss", T_FIGHTING, 20, -5,  100, ~f_move_setdmg,C_LEVEL
   ;;, "rage",     T_NORMAL,   20, 20,  100, ~f_move_rage
   ;;, "megdrain", T_GRASS,    10, 40,  100, ~f_move_drain
   ;;, "solrbeam", T_GRASS,    10, 120, 100, ~f_move_prepare
   ;;, "drgnrage", T_DRAGON,   10, -5,  100, ~f_move_setdmg,40
   ;;, "thndrblt", T_ELECTRIC, 15, 95,  100, ~f_move_default,10,~f_move_major_other,C_MAJOR_PARALYZED
   ;;, "thunder",  T_ELECTRIC, 10, 120, 70 , ~f_move_default,10,~f_move_major_other,C_MAJOR_PARALYZED
   ;;, "earthqke", T_GROUND,   10, 100, 100, ~f_move_default
   ;;, "fissure",  T_GROUND,   5,  -5,  30 , ~f_move_ohko
   ;;, "dig",      T_GROUND,   10, 100, 100, ~f_move_flydig,"|begins|digging"
   ;;, "psychic",  T_PSYCHIC,  10, 90,  100, ~f_move_default,30,~f_move_other, ~f_move_stat,special,-1
   ;;, "teleport", T_PSYCHIC,  20, 0,   0  , ~f_move_self,~f_move_switch
   ;;, "mimic",    T_NORMAL,   10, 0,   0  , ~f_move_mimic
   ;;, "doubteam", T_NORMAL,   15, 0,   0  , ~f_move_self, ~f_move_stat, evasion, 1
   ;;, "reflect",  T_PSYCHIC,  20, 0,   0  , ~f_move_self,~f_movehelp_minor,"|raises|defense",reflected
   ;;, "bide",     T_NORMAL,   10, -5,  100, ~f_move_bide
   ;;, "metrnome", T_NORMAL,   10, 0,   0  , ~f_move_metronome
   ;;, "selfdstr", T_NORMAL,   5,  260, 100, ~f_move_default
   ;;, "eggbomb",  T_NORMAL,   10, 100, 75 , ~f_move_default
   ;;, "fireblst", T_FIRE,     5,  120, 85 , ~f_move_default,30,~f_move_major_other,C_MAJOR_BURNED
   ;;, "swift",    T_NORMAL,   20, 60,  -5 , ~f_move_default
   ;;, "skulbash", T_NORMAL,   15, 100, 100, ~f_move_prepare
   ;;, "softboil", T_NORMAL,   10, 0,   0  , ~f_move_recover
   ;;, "dreameat", T_PSYCHIC,  15, 100, 100, ~f_move_dreameater
   ;;, "skyattck", T_FLYING,   5,  140, 90 , ~f_move_prepare
   ;;, "rest",     T_PSYCHIC,  10, 0,   0  , ~f_move_rest
   ;;, "thndrwav", T_ELECTRIC, 20, 0,   100, ~f_move_major_other, C_MAJOR_PARALYZED
   ;;, "psywave",  T_PSYCHIC,  15, -5,  80 , ~f_move_psywave
   ;;, "explsion", T_NORMAL,   5,  340, 100, ~f_move_default
   ;;, "rockslid", T_ROCK,     10, 75,  90 , ~f_move_default
   ;;, "triattck", T_NORMAL,   10, 80,  100, ~f_move_default
   ;;, "substute", T_NORMAL,   10, 0,   0  , ~f_move_substitute
   ;;, "cut",      T_NORMAL,   30, 50,  95 , ~f_move_default
   ;;, "fly",      T_FLYING,   15, 70,  95 , ~f_move_flydig,"|begins|flying"
   ;;, "surf",     T_WATER,    15, 95,  100, ~f_move_default
   ;;, "strength", T_NORMAL,   15, 80,  100, ~f_move_default
   ;;, "flash",    T_NORMAL,   20, 0,   70 , ~f_move_other, ~f_move_stat, accuracy, -1
   ;;, "pound",    T_NORMAL,   35, 40,  100, ~f_move_default
   ;;, "karatchp", T_FIGHTING, 25, 55,  100, ~f_move_default
   ;;, "doubslap", T_NORMAL,   10, 15,  85 , ~f_move_multihit_var
   ;;, "comtpnch", T_NORMAL,   15, 20,  85 , ~f_move_multihit_var
   ;;, "firepnch", T_FIRE,     15, 75,  100, ~f_move_default,10,~f_move_major_other,C_MAJOR_BURNED
   ;;, "icepnch",  T_ICE,      15, 75,  100, ~f_move_default,10,~f_move_major_other,C_MAJOR_FROZEN
   ;;, "thndpnch", T_ELECTRIC, 15, 75,  100, ~f_move_default,10,~f_move_major_other,C_MAJOR_PARALYZED
   ;;, "scratch",  T_NORMAL,   35, 40,  100, ~f_move_default
   ;;, "vicegrip", T_NORMAL,   30, 55,  100, ~f_move_default
   ;;, "guilotin", T_NORMAL,   5,  -5,  30 , ~f_move_ohko
   ;;, "gust",     T_FLYING,   35, 40,  100, ~f_move_default
   ;;, "wingatck", T_FLYING,   35, 35,  100, ~f_move_default
   ;;, "bind",     T_NORMAL,   20, 15,  75 , ~f_move_trapping
   ;;, "slam",     T_NORMAL,   20, 80,  75 , ~f_move_default
   ;;, "vinewhip", T_GRASS,    10, 35,  100, ~f_move_default
   ;;, "stomp",    T_NORMAL,   20, 65,  100, ~f_move_default,30,~f_move_other,~f_movehelp_flinch
   ;;, "doubkick", T_FIGHTING, 30, 30,  100, ~f_move_multihit_set,2,~f_nop
   ;;, "jumpkick", T_FIGHTING, 20, 70,  95 , ~f_move_default
   ;;, "rllngkck", T_FIGHTING, 15, 60,  85 , ~f_move_default,30,~f_move_other,~f_movehelp_flinch
   ;;, "sandatck", T_GROUND,   15, 0,   100, ~f_move_other, ~f_move_stat, accuracy, -1
   ;;, "headbutt", T_NORMAL,   15, 70,  100, ~f_move_default,30,~f_move_other,~f_movehelp_flinch
   ;;, "hornatck", T_NORMAL,   25, 65,  100, ~f_move_default
   ;;, "furyatck", T_NORMAL,   20, 15,  85 , ~f_move_multihit_var
   ;;, "tackle",   T_NORMAL,   35, 35,  95 , ~f_move_default
   ;;, "wrap",     T_NORMAL,   20, 15,  85 , ~f_move_trapping
   ;;, "thrash",   T_NORMAL,   20, 90,  100, ~f_move_thrash
   ;;, "tailwhip", T_NORMAL,   30, 0,   100, ~f_move_other, ~f_move_stat, defense, -1
   ;;, "psnsting", T_POISON,   35, 15,  100, ~f_move_default,20,~f_move_major_other,C_MAJOR_POISONED
   ;;, "twineedl", T_BUG,      20, 25,  100, ~f_move_multihit_twin
   ;;, "pinmisil", T_BUG,      20, 15,  85 , ~f_move_multihit_var
   ;;, "leer",     T_NORMAL,   30, 0,   100, ~f_move_other, ~f_move_stat, defense, -1
   ;;, "bite",     T_NORMAL,   25, 60,  100, ~f_move_default,10,~f_move_other,~f_movehelp_flinch
   ;;, "growl",    T_NORMAL,   40, 0,   100, ~f_move_other, ~f_move_stat, attack, -1
   ;;, "roar",     T_NORMAL,   20, 0,   100, ~f_move_other,~f_move_switch
   ;;, "sing",     T_NORMAL,   15, 0,   55 , ~f_move_major_other, C_MAJOR_SLEEPING
   ;;, "sprsonic", T_NORMAL,   20, 0,   55 , ~f_move_other,~f_movehelp_confuse
   ;;, "sonicbom", T_NORMAL,   20, -5,  90 , ~f_move_setdmg,20
   ;;, "disable",  T_NORMAL,   20, 0,   55 , ~f_move_disable
   ;;, "acid",     T_POISON,   30, 40,  100, ~f_move_default,10,~f_move_other, ~f_move_stat, defense, -1
   ;;, "ember",    T_FIRE,     25, 40,  100, ~f_move_default,10,~f_move_major_other,C_MAJOR_BURNED
   ;;, "flamthwr", T_FIRE,     15, 95,  100, ~f_move_default,10,~f_move_major_other,C_MAJOR_BURNED
   ;;, "mist",     T_ICE,      30, 0,   0  , ~f_move_self,~f_movehelp_minor,"|stat lower|immunity",misted
   ;;, "hydropmp", T_WATER,    5,  120, 80 , ~f_move_default
   ;;, "psybeam",  T_PSYCHIC,  20, 65,  100, ~f_move_default,10,~f_move_other,~f_movehelp_confuse
   ;;, "aurorabm", T_ICE,      20, 65,  100, ~f_move_default,10,~f_move_other, ~f_move_stat, attack, -1
   ;;, "peck",     T_FLYING,   35, 35,  100, ~f_move_default
   ;;, "drillpck", T_FLYING,   20, 80,  100, ~f_move_default
   ;;, "lowkick",  T_FIGHTING, 20, 50,  90 , ~f_move_default,30,~f_move_other,~f_movehelp_flinch
   ;;, "absorb",   T_GRASS,    20, 20,  100, ~f_move_drain
   ;;, "leechsed", T_GRASS,    10, 0,   90 , ~f_move_other,~f_movehelp_minor,"|is now|seeded",seeded,1,~c_yes
   ;;, "growth",   T_NORMAL,   40, 0,   0  , ~f_move_self, ~f_move_stat, special, 1
   ;;, "razrleaf", T_GRASS,    25, 55,  95 , ~f_move_default
   ;;, "psnpowdr", T_POISON,   35, 0,   75 , ~f_move_major_other, C_MAJOR_POISONED
   ;;, "stunspor", T_GRASS,    30, 0,   75 , ~f_move_major_other, C_MAJOR_PARALYZED
   ;;, "slppowdr", T_GRASS,    15, 0,   75 , ~f_move_major_other, C_MAJOR_SLEEPING
   ;;, "petldanc", T_GRASS,    20, 70,  100, ~f_move_thrash
   ;;, "strngsht", T_BUG,      40, 0,   95 , ~f_move_other, ~f_move_stat, speed, -1
   ;;, "firespin", T_FIRE,     15, 15,  70 , ~f_move_trapping
   ;;, "thndshck", T_ELECTRIC, 30, 40,  100, ~f_move_default,10,~f_move_major_other,C_MAJOR_PARALYZED
   ;;, "rockthrw", T_ROCK,     15, 50,  65 , ~f_move_default
   ;;, "cnfusion", T_PSYCHIC,  25, 50,  100, ~f_move_default,10,~f_move_other,~f_movehelp_confuse
   ;;, "hypnosis", T_PSYCHIC,  20, 0,   60 , ~f_move_major_other, C_MAJOR_SLEEPING
   ;;, "meditate", T_PSYCHIC,  40, 0,   0  , ~f_move_self, ~f_move_stat, attack, 1
   ;;, "agility",  T_PSYCHIC,  30, 0,   0  , ~f_move_self, ~f_move_stat, speed, 2
   ;;, "quickatk", T_NORMAL,   30, 40,  100, ~f_move_default
   ;;, "ngtshade", T_GHOST,    15, -5,  100, ~f_move_setdmg,C_LEVEL
   ;;, "screech",  T_NORMAL,   10, 0,   85 , ~f_move_other, ~f_move_stat, defense, -2
   ;;, "recover",  T_NORMAL,   20, 0,   0  , ~f_move_recover
   ;;, "harden",   T_NORMAL,   30, 0,   0  , ~f_move_self, ~f_move_stat, defense, 1
   ;;, "minimize", T_NORMAL,   20, 0,   0  , ~f_move_minimize
   ;;, "smokscrn", T_NORMAL,   20, 0,   100, ~f_move_other, ~f_move_stat, accuracy, -1
   ;;, "cnfusray", T_GHOST,    10, 0,   100, ~f_move_other,~f_movehelp_confuse
   ;;, "withdraw", T_WATER,    40, 0,   0  , ~f_move_self, ~f_move_stat, defense, 1
   ;;, "dfnscurl", T_NORMAL,   40, 0,   0  , ~f_move_self, ~f_move_stat, defense, 1
   ;;, "barrier",  T_PSYCHIC,  30, 0,   0  , ~f_move_self, ~f_move_stat, defense, 2
   ;;, "lghtscrn", T_PSYCHIC,  30, 0,   0  , ~f_move_self,~f_movehelp_minor,"|raises|spcdefense",screened
   ;;, "haze",     T_ICE,      30, 0,   -5 , ~f_move_haze
   ;;, "fcsenrgy", T_NORMAL,   30, 0,   0  , ~f_move_self,~f_movehelp_minor,"|raises|crit ratio",focused
   ;;, "mirrmove", T_FLYING,   20, -5,  0  , ~f_move_mirror_move
   ;;, "lick",     T_GHOST,    30, 20,  100, ~f_move_default,30,~f_move_major_other,C_MAJOR_PARALYZED
   ;;, "smog",     T_POISON,   20, 20,  100, ~f_move_default,30,~f_move_major_other,C_MAJOR_POISONED
   ;;, "sludge",   T_POISON,   20, 65,  100, ~f_move_default,30,~f_move_major_other,C_MAJOR_POISONED
   ;;, "boneclub", T_GROUND,   20, 65,  85 , ~f_move_default,10,~f_move_other,~f_movehelp_flinch
   ;;, "watrfall", T_WATER,    15, 80,  100, ~f_move_default
   ;;, "clamp",    T_WATER,    10, 35,  75 , ~f_move_trapping
   ;;, "spikcann", T_NORMAL,   15, 20,  100, ~f_move_multihit_var
   ;;, "constrct", T_NORMAL,   35, 10,  100, ~f_move_default,10,~f_move_other, ~f_move_stat, speed, -1
   ;;, "amnesia",  T_PSYCHIC,  20, 0,   0  , ~f_move_self, ~f_move_stat, special, 2
   ;;, "kinesis",  T_PSYCHIC,  15, 0,   80 , ~f_move_other, ~f_move_stat, accuracy, -1
   ;;, "hijmpkck", T_FIGHTING, 20, 85,  90 , ~f_move_default
   ;;, "glare",    T_NORMAL,   30, 0,   75 , ~f_move_major_other, C_MAJOR_PARALYZED
   ;;, "poisngas", T_POISON,   40, 0,   55 , ~f_move_major_other, C_MAJOR_POISONED
   ;;, "barrage",  T_NORMAL,   20, 15,  85 , ~f_move_multihit_var
   ;;, "leechlif", T_BUG,      15, 20,  100, ~f_move_drain
   ;;, "lovekiss", T_NORMAL,   10, 0,   75 , ~f_move_major_other, C_MAJOR_SLEEPING
   ;;, "tranform", T_NORMAL,   10, 0,   0  , ~f_move_transform
   ;;, "bubble",   T_WATER,    30, 20,  100, ~f_move_default,10,~f_move_other, ~f_move_stat, speed, -1
   ;;, "dizypnch", T_NORMAL,   10, 70,  100, ~f_move_default
   ;;, "spore",    T_GRASS,    15, 0,   100, ~f_move_major_other, C_MAJOR_SLEEPING
   ;;, "splash",   T_NORMAL,   40, 0,   0  , ~f_move_splash
   ;;, "acidarmr", T_POISON,   40, 0,   0  , ~f_move_self, ~f_move_stat, defense, 2
   ;;, "crabhamr", T_WATER,    10, 90,  85 , ~f_move_default
   ;;, "furyswps", T_NORMAL,   15, 10,  80 , ~f_move_multihit_var
   ;;, "bonerang", T_GROUND,   10, 50,  90 , ~f_move_multihit_set,2,~f_nop
   ;;, "hyprfang", T_NORMAL,   15, 80,  90 , ~f_move_default,10,~f_move_other,~f_movehelp_flinch
   ;;, "sharpen",  T_NORMAL,   30, 0,   0  , ~f_move_self, ~f_move_stat, attack, 1
   ;;, "convrson", T_NORMAL,   30, 0,   0  , ~f_move_conversion
   ;;, "suprfang", T_NORMAL,   10, -5,  90 , ~f_move_superfang
   ;;, "slash",    T_NORMAL,   20, 70,  100, ~f_move_default
]]

-- could get an error if a trainer doesn't have 6 pkmn, because of assumptions i make when starting a fight
-- this becomes a list of tables on init
|[c_trainer_names]| split"youngstr,bugcatch,junior,brock,lass,hiker,swimmer,misty,gentlman,sailor,rocker,ltsurge,channelr,gambler,beauty,erika,biker,birdkeep,juggler,koga,blckbelt,rocket,psychic,sabrina,scientst,pkmaniac,suprnerd,blaine,cooltrnr,fishrman,tamer,giovanni,lorelei,bruno,agatha,lance,blue,green,red,legendry" $$
|[c_trainers]| f_zobj[[]] $$
