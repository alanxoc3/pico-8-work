-- battle mechanic differences
-- DIFF: frozen/sleep will reset multiturn moves
-- DIFF: if a pokemon faints, the next pokemon in the party will automatically be sent out
-- DIFF: pokemon have a 20% chance to unthaw

-- todo: something to consider. For dig/fly/hypebeam, it would be nice to have alternate text on the second turn, instead of "blah|used|hyperbeam". so maybe i can do something for that.

|[c_pokemon]| f_zobj[[]] $$
|[c_pokemon_names]| _split"missingno,bulbasaur,ivysaur,venusaur,charmander,charmeleon,charizard,squirtle,wartortle,blastoise,caterpie,metapod,butterfree,weedle,kakuna,beedrill,pidgey,pidgeotto,pidgeot,rattata,raticate,spearow,fearow,ekans,arbok,pikachu,raichu,sandshrew,sandslash,nidoran f,nidorina,nidoqueen,nidoran m,nidorino,nidoking,clefairy,clefable,vulpix,ninetales,jigglypuff,wigglytuff,zubat,golbat,oddish,gloom,vileplume,paras,parasect,venonat,venomoth,diglett,dugtrio,meowth,persian,psyduck,golduck,mankey,primeape,growlithe,arcanine,poliwag,poliwhirl,poliwrath,abra,kadabra,alakazam,machop,machoke,machamp,bellsprout,weepinbell,victreebel,tentacool,tentacruel,geodude,graveler,golem,ponyta,rapidash,slowpoke,slowbro,magnemite,magneton,farfetchd,doduo,dodrio,seel,dewgong,grimer,muk,shellder,cloyster,gastly,haunter,gengar,onix,drowzee,hypno,krabby,kingler,voltorb,electrode,exeggcute,exeggutor,cubone,marowak,hitmonlee,hitmonchan,lickitung,koffing,weezing,rhyhorn,rhydon,chansey,tangela,kangaskhan,horsea,seadra,goldeen,seaking,staryu,starmie,mr mime,scyther,jynx,electabuzz,magmar,pinsir,tauros,magikarp,gyarados,lapras,ditto,eevee,vaporeon,jolteon,flareon,porygon,omanyte,omastar,kabuto,kabutops,aerodactyl,snorlax,articuno,zapdos,moltres,dratini,dragonair,dragonite,mewtwo,mew" $$
-- c_pokemon_names[0] = "" -- for "none" pkmn, technically not needed possibly (-1)

|[c_major_names]|       f_zobj"0,none;,fainted,burned,frozen,paralyzed,poisoned,sleeping" $$
|[c_major_names_short]| f_zobj"0,NON;,FNT,BRN,FZN,PAR,PSN,SLP" $$

-- pokemon moves can be physical or special. the order here is specific. odd numbers are physical. even numbers are special.
-- includes type effectiveness chart. according to the gen 1 games, which had bugs. i'm keeping the bugs :).
|[c_types]| f_zobj[[
    T_NONE;     bg,0, name,~c_empty;
    T_NORMAL;   bg,0, name,"normal",   T_GHOST,0,    T_ROCK,.5;
    T_FIRE;     bg,5, name,"fire",     T_GRASS,2,    T_ICE,2,      T_BUG,2,       T_FIRE,.5,     T_WATER,.5,    T_ROCK,.5,   T_DRAGON,.5;
    T_FIGHTING; bg,2, name,"fighting", T_ICE,2,      T_NORMAL,2,   T_ROCK,2,      T_GHOST,0,     T_BUG,.5,      T_FLYING,.5, T_POISON,.5, T_PSYCHIC,.5;
    T_WATER;    bg,4, name,"water",    T_FIRE,2,     T_GROUND,2,   T_ROCK,2,      T_DRAGON,.5,   T_GRASS,.5,    T_WATER,.5;
    T_POISON;   bg,1, name,"poison",   T_BUG,2,      T_GRASS,2,    T_GHOST,.5,    T_GROUND,.5,   T_POISON,.5,   T_ROCK,.5;
    T_ELECTRIC; bg,6, name,"electric", T_FLYING,2,   T_WATER,2,    T_GROUND,0,    T_DRAGON,.5,   T_ELECTRIC,.5, T_GRASS,.5;
    T_GROUND;   bg,2, name,"ground",   T_ELECTRIC,2, T_FIRE,2,     T_POISON,2,    T_ROCK,2,      T_FLYING,0,    T_BUG,.5,    T_GRASS,.5;
    T_GRASS;    bg,3, name,"grass",    T_GROUND,2,   T_ROCK,2,     T_WATER,2,     T_BUG,.5,      T_DRAGON,.5,   T_FIRE,.5,   T_FLYING,.5, T_GRASS,.5, T_POISON,.5;
    T_FLYING;   bg,0, name,"flying",   T_BUG,2,      T_FIGHTING,2, T_GRASS,2,     T_ELECTRIC,.5, T_ROCK,.5;
    T_ICE;      bg,4, name,"ice",      T_DRAGON,2,   T_FLYING,2,   T_GRASS,2,     T_FIRE,.5,     T_ICE,.5,      T_WATER,.5;
    T_BUG;      bg,3, name,"bug",      T_GRASS,2,    T_PSYCHIC,2,  T_FIGHTING,.5, T_FIRE,.5,     T_FLYING,.5,   T_GHOST,.5,  T_POISON,.5;
    T_PSYCHIC;  bg,1, name,"psychic",  T_FIGHTING,2, T_POISON,2,   T_PSYCHIC,.5;
    T_ROCK;     bg,0, name,"rock",     T_BUG,2,      T_FIRE,2,     T_FLYING,2,    T_ICE,2,       T_FIGHTING,.5, T_GROUND,.5;
    T_DRAGON;   bg,0, name,"dragon",   T_DRAGON,2;
    T_GHOST;    bg,1, name,"ghost",    T_GHOST,2,    T_NORMAL,0,   T_PSYCHIC,0;
    T_BIRD;     bg,0, name,"bird";
]] $$

|[c_stages]| f_zobj[[
    special;  longname,"special", shortname, "spc"
   ;attack;   longname,"attack",  shortname, "att"
   ;defense;  longname,"defense", shortname, "def"
   ;speed;    longname,"speed",   shortname, "spd"
   ;total;                        shortname, "tot"
   ;accuracy; longname,"accuracy"
   ;evasion;  longname,"evasion"
]] $$

-- 5 bg styles
|[c_bg_styles]| f_zobj[[
    0;bg,6,  aa,13 -- normal
   ;; bg,14, aa,4  -- darker/psychic/poison/ghost
   ;; bg,9,  aa,4  -- electric/ground
   ;; bg,11, aa,3  -- grass
   ;; bg,12, aa,5  -- water
   ;; bg,8,  aa,2  -- fire
   ;; bg,10, aa,4  -- electric/ground
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
   --  "name",     type        pp  dmg  acc
  -1;, "none",     ~f_move_default                                                 -- -1  This is the move used for confusion damage.
  ;0;, "struggle", ~f_move_recoil                                                  -- 0   DIFF: ignores resistance now. hits ghost pokemon.
   ;;, "megapnch", ~f_move_default                                                 -- 1
   ;;, "razrwind", ~f_move_prepare                                                 -- 2   DIFF: move resets when interrupted
   ;;, "sworddnc", ~f_move_self, ~f_move_stat, attack, 2                           -- 3
   ;;, "whrlwind", ~f_move_roar                                                    -- 4   DIFF: switches opponent with random pokemon
   ;;, "megakick", ~f_move_default                                                 -- 5
   ;;, "toxic",    ~f_move_toxic                                                   -- 6   DIFF: toxic counter does not affect leech seed dmg
   ;;, "horndril", ~f_move_ohko                                                    -- 7
   ;;, "bodyslam", ~f_move_default,30,~f_move_major_other,C_MAJOR_PARALYZED        -- 8
   ;;, "takedown", ~f_move_recoil                                                  -- 9
   ;;, "doubedge", ~f_move_recoil                                                  -- 10
   ;;, "bublbeam", ~f_move_default,10,~f_move_other, ~f_move_stat, speed, -1       -- 11
   ;;, "watergun", ~f_move_default                                                 -- 12
   ;;, "icebeam",  ~f_move_default,10,~f_move_major_other,C_MAJOR_FROZEN           -- 13
   ;;, "blizzard", ~f_move_default,10,~f_move_major_other,C_MAJOR_FROZEN           -- 14
   ;;, "hyprbeam", ~f_move_hyperbeam                                               -- 15
   ;;, "payday",   ~f_move_default                                                 -- 16
   ;;, "submsion", ~f_move_recoil                                                  -- 17
   ;;, "counter",  ~f_move_counter                                                 -- 18  DIFF: respects resistance, counts all physical damage taken during turn or taken by substitute
   ;;, "seistoss", ~f_move_setdmg,C_LEVEL                                          -- 19  DIFF: respects resistance
   ;;, "rage",     ~f_move_rage                                                    -- 20  DIFF: you can switch out while using rage, rage also ends when frozen/sleep/trapped/disabled, just like other multiturn moves
   ;;, "megdrain", ~f_move_drain                                                   -- 21
   ;;, "solrbeam", ~f_move_prepare                                                 -- 22  DIFF: move resets when interrupted
   ;;, "drgnrage", ~f_move_setdmg,40                                               -- 23  DIFF: respects resistance
   ;;, "thndrblt", ~f_move_default,10,~f_move_major_other,C_MAJOR_PARALYZED        -- 24
   ;;, "thunder",  ~f_move_default,10,~f_move_major_other,C_MAJOR_PARALYZED        -- 25
   ;;, "earthqke", ~f_move_default                                                 -- 26
   ;;, "fissure",  ~f_move_ohko                                                    -- 27
   ;;, "dig",      ~f_move_flydig,"|begins|digging"                                -- 28
   ;;, "psychic",  ~f_move_default,30,~f_move_other, ~f_move_stat,special,-1       -- 29
   ;;, "teleport", ~f_move_teleport                                                -- 30  DIFF: switches with random pokemon from user's team
   ;;, "mimic",    ~f_move_mimic                                                   -- 31  DIFF: doesn't miss and copies 5 pp like transform
   ;;, "doubteam", ~f_move_self, ~f_move_stat, evasion, 1                          -- 32
   ;;, "reflect",  ~f_move_self,~f_movehelp_minor,"|raises|defense",reflected      -- 33
   ;;, "bide",     ~f_move_bide                                                    -- 34  DIFF: doesn't bypass accuracy check & respects resistance, counts damage done to substitute
   ;;, "metrnome", ~f_move_metronome                                               -- 35
   ;;, "selfdstr", ~f_move_default                                                 -- 36  DIFF: user inflicts damage to self before damaging opponent, so you can't win a match by suicide
   ;;, "eggbomb",  ~f_move_default                                                 -- 37
   ;;, "fireblst", ~f_move_default,30,~f_move_major_other,C_MAJOR_BURNED           -- 38
   ;;, "swift",    ~f_move_default                                                 -- 39  DIFF: always hits when used, even against dig/fly, can't go past substitute though
   ;;, "skulbash", ~f_move_prepare                                                 -- 40  DIFF: move resets when interrupted
   ;;, "softboil", ~f_move_recover                                                 -- 41
   ;;, "dreameat", ~f_move_dreameater                                              -- 42
   ;;, "skyattck", ~f_move_prepare                                                 -- 43  DIFF: move resets when interrupted
   ;;, "rest",     ~f_move_rest                                                    -- 44
   ;;, "thndrwav", ~f_move_major_other, C_MAJOR_PARALYZED                          -- 45
   ;;, "psywave",  ~f_move_psywave                                                 -- 46  DIFF: respects resistance
   ;;, "explsion", ~f_move_default                                                 -- 47  DIFF: user inflicts damage to self before damaging opponent, so you can't win a match by suicide
   ;;, "rockslid", ~f_move_default                                                 -- 48
   ;;, "triattck", ~f_move_default                                                 -- 49
   ;;, "substute", ~f_move_substitute                                              -- 50  DIFF: recoil moves damage user. only protects from direct enemy damage, user is still vulnerable to all other effects
   ;;, "cut",      ~f_move_default                                                 -- 51
   ;;, "fly",      ~f_move_flydig,"|begins|flying"                                 -- 52
   ;;, "surf",     ~f_move_default                                                 -- 53
   ;;, "strength", ~f_move_default                                                 -- 54
   ;;, "flash",    ~f_move_other, ~f_move_stat, accuracy, -1                       -- 55
   ;;, "pound",    ~f_move_default                                                 -- 56
   ;;, "karatchp", ~f_move_default                                                 -- 57
   ;;, "doubslap", ~f_move_multihit_var                                            -- 58  DIFF: if KOs pkmn, will also hit new pokemon switched in & hits after substitute
   ;;, "comtpnch", ~f_move_multihit_var                                            -- 59  DIFF: if KOs pkmn, will also hit new pokemon switched in & hits after substitute
   ;;, "firepnch", ~f_move_default,10,~f_move_major_other,C_MAJOR_BURNED           -- 60
   ;;, "icepnch",  ~f_move_default,10,~f_move_major_other,C_MAJOR_FROZEN           -- 61
   ;;, "thndpnch", ~f_move_default,10,~f_move_major_other,C_MAJOR_PARALYZED        -- 62
   ;;, "scratch",  ~f_move_default                                                 -- 63
   ;;, "vicegrip", ~f_move_default                                                 -- 64
   ;;, "guilotin", ~f_move_ohko                                                    -- 65
   ;;, "gust",     ~f_move_default                                                 -- 66
   ;;, "wingatck", ~f_move_default                                                 -- 67
   ;;, "bind",     ~f_move_trapping                                                -- 68
   ;;, "slam",     ~f_move_default                                                 -- 69
   ;;, "vinewhip", ~f_move_default                                                 -- 70
   ;;, "stomp",    ~f_move_default,30,~f_move_other,~f_movehelp_flinch             -- 71
   ;;, "doubkick", ~f_move_multihit_set,2,~f_nop                                   -- 72  DIFF: if KOs pkmn, will also hit new pokemon switched in
   ;;, "jumpkick", ~f_move_default                                                 -- 73
   ;;, "rllngkck", ~f_move_default,30,~f_move_other,~f_movehelp_flinch             -- 74
   ;;, "sandatck", ~f_move_other, ~f_move_stat, accuracy, -1                       -- 75
   ;;, "headbutt", ~f_move_default,30,~f_move_other,~f_movehelp_flinch             -- 76
   ;;, "hornatck", ~f_move_default                                                 -- 77
   ;;, "furyatck", ~f_move_multihit_var                                            -- 78  DIFF: if KOs pkmn, will also hit new pokemon switched in
   ;;, "tackle",   ~f_move_default                                                 -- 79
   ;;, "wrap",     ~f_move_trapping                                                -- 80
   ;;, "thrash",   ~f_move_thrash                                                  -- 81
   ;;, "tailwhip", ~f_move_other, ~f_move_stat, defense, -1                        -- 82
   ;;, "psnsting", ~f_move_default,20,~f_move_major_other,C_MAJOR_POISONED         -- 83
   ;;, "twineedl", ~f_move_multihit_twin                                           -- 84  DIFF: if KOs pkmn, will also hit new pokemon switched in
   ;;, "pinmisil", ~f_move_multihit_var                                            -- 85  DIFF: if KOs pkmn, will also hit new pokemon switched in
   ;;, "leer",     ~f_move_other, ~f_move_stat, defense, -1                        -- 86
   ;;, "bite",     ~f_move_default,10,~f_move_other,~f_movehelp_flinch             -- 87
   ;;, "growl",    ~f_move_other, ~f_move_stat, attack, -1                         -- 88
   ;;, "roar",     ~f_move_roar                                                    -- 89  DIFF: switches opponent with random pokemon
   ;;, "sing",     ~f_move_major_other, C_MAJOR_SLEEPING                           -- 90
   ;;, "sprsonic", ~f_move_other,~f_movehelp_confuse                               -- 91
   ;;, "sonicbom", ~f_move_setdmg,20                                               -- 92  DIFF: respects resistance
   ;;, "disable",  ~f_move_disable                                                 -- 93  DIFF: lasts 2-7 turns
   ;;, "acid",     ~f_move_default,10,~f_move_other, ~f_move_stat, defense, -1     -- 94
   ;;, "ember",    ~f_move_default,10,~f_move_major_other,C_MAJOR_BURNED           -- 95
   ;;, "flamthwr", ~f_move_default,10,~f_move_major_other,C_MAJOR_BURNED           -- 96
   ;;, "mist",     ~f_move_self,~f_movehelp_minor,"|stat lower|immunity",misted    -- 97  DIFF: protects against modifier decreases from damaging moves too
   ;;, "hydropmp", ~f_move_default                                                 -- 98
   ;;, "psybeam",  ~f_move_default,10,~f_move_other,~f_movehelp_confuse            -- 99
   ;;, "aurorabm", ~f_move_default,10,~f_move_other, ~f_move_stat, attack, -1      -- 100
   ;;, "peck",     ~f_move_default                                                 -- 101
   ;;, "drillpck", ~f_move_default                                                 -- 102
   ;;, "lowkick",  ~f_move_default,30,~f_move_other,~f_movehelp_flinch             -- 103
   ;;, "absorb",   ~f_move_drain                                                   -- 104
   ;;, "leechsed", ~f_move_other,~f_movehelp_minor,"|is now|seeded",seeded         -- 105
   ;;, "growth",   ~f_move_self, ~f_move_stat, special, 1                          -- 106
   ;;, "razrleaf", ~f_move_default                                                 -- 107
   ;;, "psnpowdr", ~f_move_major_other, C_MAJOR_POISONED                           -- 108
   ;;, "stunspor", ~f_move_major_other, C_MAJOR_PARALYZED                          -- 109
   ;;, "slppowdr", ~f_move_major_other, C_MAJOR_SLEEPING                           -- 110
   ;;, "petldanc", ~f_move_thrash                                                  -- 111
   ;;, "strngsht", ~f_move_other, ~f_move_stat, speed, -1                          -- 112
   ;;, "firespin", ~f_move_trapping                                                -- 113 DIFF: can thaw out frozen pokemon.
   ;;, "thndshck", ~f_move_default,10,~f_move_major_other,C_MAJOR_PARALYZED        -- 114
   ;;, "rockthrw", ~f_move_default                                                 -- 115
   ;;, "cnfusion", ~f_move_default,10,~f_move_other,~f_movehelp_confuse            -- 116
   ;;, "hypnosis", ~f_move_major_other, C_MAJOR_SLEEPING                           -- 117
   ;;, "meditate", ~f_move_self, ~f_move_stat, attack, 1                           -- 118
   ;;, "agility",  ~f_move_self, ~f_move_stat, speed, 2                            -- 119
   ;;, "quickatk", ~f_move_default                                                 -- 120
   ;;, "ngtshade", ~f_move_setdmg,C_LEVEL                                          -- 121 DIFF: respects resistance now
   ;;, "screech",  ~f_move_other, ~f_move_stat, defense, -2                        -- 122
   ;;, "recover",  ~f_move_recover                                                 -- 123
   ;;, "harden",   ~f_move_self, ~f_move_stat, defense, 1                          -- 124
   ;;, "minimize", ~f_move_self, ~f_move_stat, evasion, 1                          -- 125
   ;;, "smokscrn", ~f_move_other, ~f_move_stat, accuracy, -1                       -- 126
   ;;, "cnfusray", ~f_move_other,~f_movehelp_confuse                               -- 127
   ;;, "withdraw", ~f_move_self, ~f_move_stat, defense, 1                          -- 128
   ;;, "dfnscurl", ~f_move_self, ~f_move_stat, defense, 1                          -- 129
   ;;, "barrier",  ~f_move_self, ~f_move_stat, defense, 2                          -- 130
   ;;, "lghtscrn", ~f_move_self,~f_movehelp_minor,"|raises|spcdefense",screened    -- 131
   ;;, "haze",     ~f_move_haze                                                    -- 132 DIFF: only resets stat modifiers, applies even when mist is in effect
   ;;, "fcsenrgy", ~f_move_self,~f_movehelp_minor,"|raises|crit ratio",focused     -- 133
   ;;, "mirrmove", ~f_move_mirror_move                                             -- 134
   ;;, "lick",     ~f_move_default,30,~f_move_major_other,C_MAJOR_PARALYZED        -- 135 DIFF: super effective against psychic type now
   ;;, "smog",     ~f_move_default,30,~f_move_major_other,C_MAJOR_POISONED         -- 136
   ;;, "sludge",   ~f_move_default,30,~f_move_major_other,C_MAJOR_POISONED         -- 137
   ;;, "boneclub", ~f_move_default,10,~f_move_other,~f_movehelp_flinch             -- 138
   ;;, "watrfall", ~f_move_default                                                 -- 139
   ;;, "clamp",    ~f_move_trapping                                                -- 140
   ;;, "spikcann", ~f_move_multihit_var                                            -- 141 DIFF: if KOs pkmn, will also hit new pokemon switched in
   ;;, "constrct", ~f_move_default,10,~f_move_other, ~f_move_stat, speed, -1       -- 142
   ;;, "amnesia",  ~f_move_self, ~f_move_stat, special, 2                          -- 143
   ;;, "kinesis",  ~f_move_other, ~f_move_stat, accuracy, -1                       -- 144
   ;;, "hijmpkck", ~f_move_default                                                 -- 145
   ;;, "glare",    ~f_move_major_other, C_MAJOR_PARALYZED                          -- 146
   ;;, "poisngas", ~f_move_major_other, C_MAJOR_POISONED                           -- 147
   ;;, "barrage",  ~f_move_multihit_var                                            -- 148 DIFF: if KOs pkmn, will also hit new pokemon switched in
   ;;, "leechlif", ~f_move_drain                                                   -- 149
   ;;, "lovekiss", ~f_move_major_other, C_MAJOR_SLEEPING                           -- 150
   ;;, "tranform", ~f_move_transform                                               -- 151 DIFF: Does not copy stat stages
   ;;, "bubble",   ~f_move_default,10,~f_move_other, ~f_move_stat, speed, -1       -- 152
   ;;, "dizypnch", ~f_move_default                                                 -- 153
   ;;, "spore",    ~f_move_major_other, C_MAJOR_SLEEPING                           -- 154
   ;;, "splash",   ~f_move_splash                                                  -- 155
   ;;, "acidarmr", ~f_move_self, ~f_move_stat, defense, 2                          -- 156
   ;;, "crabhamr", ~f_move_default                                                 -- 157
   ;;, "furyswps", ~f_move_multihit_var                                            -- 158 DIFF: if KOs pkmn, will also hit new pokemon switched in
   ;;, "bonerang", ~f_move_multihit_set,2,~f_nop                                   -- 159 DIFF: if KOs pkmn, will also hit new pokemon switched in
   ;;, "hyprfang", ~f_move_default,10,~f_move_other,~f_movehelp_flinch             -- 160
   ;;, "sharpen",  ~f_move_self, ~f_move_stat, attack, 1                           -- 161
   ;;, "convrson", ~f_move_conversion                                              -- 162
   ;;, "suprfang", ~f_move_superfang                                               -- 163 DIFF: respects resistance now
   ;;, "slash",    ~f_move_default                                                 -- 164
]]

-- could get an error if a trainer doesn't have 6 pkmn, because of assumptions i make when starting a fight

-- this becomes a list of tables on init
|[c_trainers]| _split"youngstr,bugcatch,junior,brock,lass,hiker,swimmer,misty,gentlman,sailor,rocker,ltsurge,channelr,gambler,beauty,erika,biker,birdkeep,juggler,koga,blckbelt,rocket,psychic,sabrina,scientst,pkmaniac,suprnerd,blaine,cooltrnr,fishrman,tamer,giovanni,lorelei,bruno,agatha,lance,blue,green,red,legendry" $$
