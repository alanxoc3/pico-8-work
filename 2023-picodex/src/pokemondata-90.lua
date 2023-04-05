-- battle mechanic differences
-- todo: something to consider. Minimize makes the sprite smaller.
-- todo: might be fun to add a few more event pokemon -- slowbro, magikarp, dragonite, fearow, rapidash, flying pikachu
--  juggler's slowbro - metronome (glitch)
--  lance's dragonite - barrier (glitch)
--  (super rare event) payday fearow & rapidash
--  (super rare event) dragon rage magikarp
--  (super rare event) flying pikachu -- idk how the sprite is decided for this - maybe only 1 or the other... yeah, only 1 event move can be learned.

|[c_pokemon]| f_zobj[[]] $$
|[c_pokemon_names]| _split"missingno,bulbasaur,ivysaur,venusaur,charmander,charmeleon,charizard,squirtle,wartortle,blastoise,caterpie,metapod,butterfree,weedle,kakuna,beedrill,pidgey,pidgeotto,pidgeot,rattata,raticate,spearow,fearow,ekans,arbok,pikachu,raichu,sandshrew,sandslash,nidoran f,nidorina,nidoqueen,nidoran m,nidorino,nidoking,clefairy,clefable,vulpix,ninetales,jigglypuff,wigglytuff,zubat,golbat,oddish,gloom,vileplume,paras,parasect,venonat,venomoth,diglett,dugtrio,meowth,persian,psyduck,golduck,mankey,primeape,growlithe,arcanine,poliwag,poliwhirl,poliwrath,abra,kadabra,alakazam,machop,machoke,machamp,bellsprout,weepinbell,victreebel,tentacool,tentacruel,geodude,graveler,golem,ponyta,rapidash,slowpoke,slowbro,magnemite,magneton,farfetchd,doduo,dodrio,seel,dewgong,grimer,muk,shellder,cloyster,gastly,haunter,gengar,onix,drowzee,hypno,krabby,kingler,voltorb,electrode,exeggcute,exeggutor,cubone,marowak,hitmonlee,hitmonchan,lickitung,koffing,weezing,rhyhorn,rhydon,chansey,tangela,kangaskhan,horsea,seadra,goldeen,seaking,staryu,starmie,mr mime,scyther,jynx,electabuzz,magmar,pinsir,tauros,magikarp,gyarados,lapras,ditto,eevee,vaporeon,jolteon,flareon,porygon,omanyte,omastar,kabuto,kabutops,aerodactyl,snorlax,articuno,zapdos,moltres,dratini,dragonair,dragonite,mewtwo,mew" $$
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
   --  "name",     movetype        pp  dmg  acc
  -1;, "none",     ~f_move_default -- -1  This is the move used for confusion damage.
  ;0;, "struggle", ~f_move_recoil
   ;;, "megapnch", ~f_move_default
   ;;, "razrwind", ~f_move_prepare
   ;;, "sworddnc", ~f_move_self, ~f_move_stat, attack, 2
   ;;, "whrlwind", ~f_move_roar
   ;;, "megakick", ~f_move_default
   ;;, "toxic",    ~f_move_toxic
   ;;, "horndril", ~f_move_ohko
   ;;, "bodyslam", ~f_move_default,30,~f_move_major_other,C_MAJOR_PARALYZED
   ;;, "takedown", ~f_move_recoil
   ;;, "doubedge", ~f_move_recoil
   ;;, "bublbeam", ~f_move_default,10,~f_move_other, ~f_move_stat, speed, -1
   ;;, "watergun", ~f_move_default
   ;;, "icebeam",  ~f_move_default,10,~f_move_major_other,C_MAJOR_FROZEN
   ;;, "blizzard", ~f_move_default,10,~f_move_major_other,C_MAJOR_FROZEN
   ;;, "hyprbeam", ~f_move_hyperbeam
   ;;, "payday",   ~f_move_default
   ;;, "submsion", ~f_move_recoil
   ;;, "counter",  ~f_move_counter
   ;;, "seistoss", ~f_move_setdmg,C_LEVEL
   ;;, "rage",     ~f_move_rage
   ;;, "megdrain", ~f_move_drain
   ;;, "solrbeam", ~f_move_prepare
   ;;, "drgnrage", ~f_move_setdmg,40
   ;;, "thndrblt", ~f_move_default,10,~f_move_major_other,C_MAJOR_PARALYZED
   ;;, "thunder",  ~f_move_default,10,~f_move_major_other,C_MAJOR_PARALYZED
   ;;, "earthqke", ~f_move_default
   ;;, "fissure",  ~f_move_ohko
   ;;, "dig",      ~f_move_flydig,"|begins|digging"
   ;;, "psychic",  ~f_move_default,30,~f_move_other, ~f_move_stat,special,-1
   ;;, "teleport", ~f_move_teleport
   ;;, "mimic",    ~f_move_mimic
   ;;, "doubteam", ~f_move_self, ~f_move_stat, evasion, 1
   ;;, "reflect",  ~f_move_self,~f_movehelp_minor,"|raises|defense",reflected
   ;;, "bide",     ~f_move_bide
   ;;, "metrnome", ~f_move_metronome
   ;;, "selfdstr", ~f_move_default
   ;;, "eggbomb",  ~f_move_default
   ;;, "fireblst", ~f_move_default,30,~f_move_major_other,C_MAJOR_BURNED
   ;;, "swift",    ~f_move_default
   ;;, "skulbash", ~f_move_prepare
   ;;, "softboil", ~f_move_recover
   ;;, "dreameat", ~f_move_dreameater
   ;;, "skyattck", ~f_move_prepare
   ;;, "rest",     ~f_move_rest
   ;;, "thndrwav", ~f_move_major_other, C_MAJOR_PARALYZED
   ;;, "psywave",  ~f_move_psywave
   ;;, "explsion", ~f_move_default
   ;;, "rockslid", ~f_move_default
   ;;, "triattck", ~f_move_default
   ;;, "substute", ~f_move_substitute
   ;;, "cut",      ~f_move_default
   ;;, "fly",      ~f_move_flydig,"|begins|flying"
   ;;, "surf",     ~f_move_default
   ;;, "strength", ~f_move_default
   ;;, "flash",    ~f_move_other, ~f_move_stat, accuracy, -1
   ;;, "pound",    ~f_move_default
   ;;, "karatchp", ~f_move_default
   ;;, "doubslap", ~f_move_multihit_var
   ;;, "comtpnch", ~f_move_multihit_var
   ;;, "firepnch", ~f_move_default,10,~f_move_major_other,C_MAJOR_BURNED
   ;;, "icepnch",  ~f_move_default,10,~f_move_major_other,C_MAJOR_FROZEN
   ;;, "thndpnch", ~f_move_default,10,~f_move_major_other,C_MAJOR_PARALYZED
   ;;, "scratch",  ~f_move_default
   ;;, "vicegrip", ~f_move_default
   ;;, "guilotin", ~f_move_ohko
   ;;, "gust",     ~f_move_default
   ;;, "wingatck", ~f_move_default
   ;;, "bind",     ~f_move_trapping
   ;;, "slam",     ~f_move_default
   ;;, "vinewhip", ~f_move_default
   ;;, "stomp",    ~f_move_default,30,~f_move_other,~f_movehelp_flinch
   ;;, "doubkick", ~f_move_multihit_set,2,~f_nop
   ;;, "jumpkick", ~f_move_default
   ;;, "rllngkck", ~f_move_default,30,~f_move_other,~f_movehelp_flinch
   ;;, "sandatck", ~f_move_other, ~f_move_stat, accuracy, -1
   ;;, "headbutt", ~f_move_default,30,~f_move_other,~f_movehelp_flinch
   ;;, "hornatck", ~f_move_default
   ;;, "furyatck", ~f_move_multihit_var
   ;;, "tackle",   ~f_move_default
   ;;, "wrap",     ~f_move_trapping
   ;;, "thrash",   ~f_move_thrash
   ;;, "tailwhip", ~f_move_other, ~f_move_stat, defense, -1
   ;;, "psnsting", ~f_move_default,20,~f_move_major_other,C_MAJOR_POISONED
   ;;, "twineedl", ~f_move_multihit_twin
   ;;, "pinmisil", ~f_move_multihit_var
   ;;, "leer",     ~f_move_other, ~f_move_stat, defense, -1
   ;;, "bite",     ~f_move_default,10,~f_move_other,~f_movehelp_flinch
   ;;, "growl",    ~f_move_other, ~f_move_stat, attack, -1
   ;;, "roar",     ~f_move_roar
   ;;, "sing",     ~f_move_major_other, C_MAJOR_SLEEPING
   ;;, "sprsonic", ~f_move_other,~f_movehelp_confuse
   ;;, "sonicbom", ~f_move_setdmg,20
   ;;, "disable",  ~f_move_disable
   ;;, "acid",     ~f_move_default,10,~f_move_other, ~f_move_stat, defense, -1
   ;;, "ember",    ~f_move_default,10,~f_move_major_other,C_MAJOR_BURNED
   ;;, "flamthwr", ~f_move_default,10,~f_move_major_other,C_MAJOR_BURNED
   ;;, "mist",     ~f_move_self,~f_movehelp_minor,"|stat lower|immunity",misted
   ;;, "hydropmp", ~f_move_default
   ;;, "psybeam",  ~f_move_default,10,~f_move_other,~f_movehelp_confuse
   ;;, "aurorabm", ~f_move_default,10,~f_move_other, ~f_move_stat, attack, -1
   ;;, "peck",     ~f_move_default
   ;;, "drillpck", ~f_move_default
   ;;, "lowkick",  ~f_move_default,30,~f_move_other,~f_movehelp_flinch
   ;;, "absorb",   ~f_move_drain
   ;;, "leechsed", ~f_move_other,~f_movehelp_minor,"|is now|seeded",seeded
   ;;, "growth",   ~f_move_self, ~f_move_stat, special, 1
   ;;, "razrleaf", ~f_move_default
   ;;, "psnpowdr", ~f_move_major_other, C_MAJOR_POISONED
   ;;, "stunspor", ~f_move_major_other, C_MAJOR_PARALYZED
   ;;, "slppowdr", ~f_move_major_other, C_MAJOR_SLEEPING
   ;;, "petldanc", ~f_move_thrash
   ;;, "strngsht", ~f_move_other, ~f_move_stat, speed, -1
   ;;, "firespin", ~f_move_trapping
   ;;, "thndshck", ~f_move_default,10,~f_move_major_other,C_MAJOR_PARALYZED
   ;;, "rockthrw", ~f_move_default
   ;;, "cnfusion", ~f_move_default,10,~f_move_other,~f_movehelp_confuse
   ;;, "hypnosis", ~f_move_major_other, C_MAJOR_SLEEPING
   ;;, "meditate", ~f_move_self, ~f_move_stat, attack, 1
   ;;, "agility",  ~f_move_self, ~f_move_stat, speed, 2
   ;;, "quickatk", ~f_move_default
   ;;, "ngtshade", ~f_move_setdmg,C_LEVEL
   ;;, "screech",  ~f_move_other, ~f_move_stat, defense, -2
   ;;, "recover",  ~f_move_recover
   ;;, "harden",   ~f_move_self, ~f_move_stat, defense, 1
   ;;, "minimize", ~f_move_self, ~f_move_stat, evasion, 1
   ;;, "smokscrn", ~f_move_other, ~f_move_stat, accuracy, -1
   ;;, "cnfusray", ~f_move_other,~f_movehelp_confuse
   ;;, "withdraw", ~f_move_self, ~f_move_stat, defense, 1
   ;;, "dfnscurl", ~f_move_self, ~f_move_stat, defense, 1
   ;;, "barrier",  ~f_move_self, ~f_move_stat, defense, 2
   ;;, "lghtscrn", ~f_move_self,~f_movehelp_minor,"|raises|spcdefense",screened
   ;;, "haze",     ~f_move_haze
   ;;, "fcsenrgy", ~f_move_self,~f_movehelp_minor,"|raises|crit ratio",focused
   ;;, "mirrmove", ~f_move_mirror_move
   ;;, "lick",     ~f_move_default,30,~f_move_major_other,C_MAJOR_PARALYZED
   ;;, "smog",     ~f_move_default,30,~f_move_major_other,C_MAJOR_POISONED
   ;;, "sludge",   ~f_move_default,30,~f_move_major_other,C_MAJOR_POISONED
   ;;, "boneclub", ~f_move_default,10,~f_move_other,~f_movehelp_flinch
   ;;, "watrfall", ~f_move_default
   ;;, "clamp",    ~f_move_trapping
   ;;, "spikcann", ~f_move_multihit_var
   ;;, "constrct", ~f_move_default,10,~f_move_other, ~f_move_stat, speed, -1
   ;;, "amnesia",  ~f_move_self, ~f_move_stat, special, 2
   ;;, "kinesis",  ~f_move_other, ~f_move_stat, accuracy, -1
   ;;, "hijmpkck", ~f_move_default
   ;;, "glare",    ~f_move_major_other, C_MAJOR_PARALYZED
   ;;, "poisngas", ~f_move_major_other, C_MAJOR_POISONED
   ;;, "barrage",  ~f_move_multihit_var
   ;;, "leechlif", ~f_move_drain
   ;;, "lovekiss", ~f_move_major_other, C_MAJOR_SLEEPING
   ;;, "tranform", ~f_move_transform
   ;;, "bubble",   ~f_move_default,10,~f_move_other, ~f_move_stat, speed, -1
   ;;, "dizypnch", ~f_move_default
   ;;, "spore",    ~f_move_major_other, C_MAJOR_SLEEPING
   ;;, "splash",   ~f_move_splash
   ;;, "acidarmr", ~f_move_self, ~f_move_stat, defense, 2
   ;;, "crabhamr", ~f_move_default
   ;;, "furyswps", ~f_move_multihit_var
   ;;, "bonerang", ~f_move_multihit_set,2,~f_nop
   ;;, "hyprfang", ~f_move_default,10,~f_move_other,~f_movehelp_flinch
   ;;, "sharpen",  ~f_move_self, ~f_move_stat, attack, 1
   ;;, "convrson", ~f_move_conversion
   ;;, "suprfang", ~f_move_superfang
   ;;, "slash",    ~f_move_default
]]

-- could get an error if a trainer doesn't have 6 pkmn, because of assumptions i make when starting a fight

-- this becomes a list of tables on init
|[c_trainers]| _split"youngstr,bugcatch,junior,brock,lass,hiker,swimmer,misty,gentlman,sailor,rocker,ltsurge,channelr,gambler,beauty,erika,biker,birdkeep,juggler,koga,blckbelt,rocket,psychic,sabrina,scientst,pkmaniac,suprnerd,blaine,cooltrnr,fishrman,tamer,giovanni,lorelei,bruno,agatha,lance,blue,green,red,legendry" $$
