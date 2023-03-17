-- DIFF: frozen stat will reset multiturn moves
-- todo: figure out how to make preparing moves (solarbeam/skyattack), not use pp if it's the first turn.

|[c_pokemon]| f_zobj[[]] $$
|[c_pokemon_names]| split"missingno,bulbasaur,ivysaur,venusaur,charmander,charmeleon,charizard,squirtle,wartortle,blastoise,caterpie,metapod,butterfree,weedle,kakuna,beedrill,pidgey,pidgeotto,pidgeot,rattata,raticate,spearow,fearow,ekans,arbok,pikachu,raichu,sandshrew,sandslash,nidoran f,nidorina,nidoqueen,nidoran m,nidorino,nidoking,clefairy,clefable,vulpix,ninetales,jigglypuff,wigglytuff,zubat,golbat,oddish,gloom,vileplume,paras,parasect,venonat,venomoth,diglett,dugtrio,meowth,persian,psyduck,golduck,mankey,primeape,growlithe,arcanine,poliwag,poliwhirl,poliwrath,abra,kadabra,alakazam,machop,machoke,machamp,bellsprout,weepinbell,victreebel,tentacool,tentacruel,geodude,graveler,golem,ponyta,rapidash,slowpoke,slowbro,magnemite,magneton,farfetchd,doduo,dodrio,seel,dewgong,grimer,muk,shellder,cloyster,gastly,haunter,gengar,onix,drowzee,hypno,krabby,kingler,voltorb,electrode,exeggcute,exeggutor,cubone,marowak,hitmonlee,hitmonchan,lickitung,koffing,weezing,rhyhorn,rhydon,chansey,tangela,kangaskhan,horsea,seadra,goldeen,seaking,staryu,starmie,mr mime,scyther,jynx,electabuzz,magmar,pinsir,tauros,magikarp,gyarados,lapras,ditto,eevee,vaporeon,jolteon,flareon,porygon,omanyte,omastar,kabuto,kabutops,aerodactyl,snorlax,articuno,zapdos,moltres,dratini,dragonair,dragonite,mewtwo,mew" $$
c_pokemon_names[0] = "" -- for "none" pkmn, technically not needed possibly (-1)

-- todo: add short names
|[c_major_names]| split"fainted,burned,frozen,paralyzed,poisoned,sleeping" $$
c_major_names[0] = "healthy" -- for "none" status

-- pokemon moves can be physical or special. the order here is specific. odd numbers are physical. even numbers are special.
-- includes type effectiveness chart. according to the gen 1 games, which had bugs. i'm keeping the bugs :).
|[c_types]| f_zobj[[
    T_NONE;     bg,0, name,%c_empty;
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

-- 0 means disabled
-- -1 means it last forever
-- positive means x turns left
|[c_flags]| f_zobj[[
    -- todo: current - how to handle these?
    confused,   "confused", -- 1-4 turn
    disabled,   "disable",  -- 2-7 turn -- disabled, disabled_move

    digging,    "digging",   -- 1 turn
    flying,     "flying",    -- 1 turn
    preparing,  "prepare",   -- 1 turn
    recharging, "recharge",  -- 1 turn
    flinching,  "flinch",   -- bool
    thrashed,   "thrashing", -- 2-3
    trapping,   "trapping",  -- 2-5 turns

    trapped,    "trapped",  -- 2-5 turns

    raged,      "enraged",   -- no - moveturn -1
    decoyed,    "decoyed",  -- no - kill-sub, num=hp
    focused,    "focus",    -- no
    misted,     "mist",     -- no
    reflected,  "reflect",  -- no
    screened,   "screened", -- no
    seeded,     "seeded",   -- no
    toxiced,    "toxiced",  -- no
    transform,  "tranform"  -- no
]] $$

|[c_stages]| f_zobj[[
     ;name,"spc", key,special
    ;;name,"att", key,attack
    ;;name,"def", key,defense
    ;;name,"spd", key,speed
    ;;name,"acc", key,accuracy
    ;;name,"eva", key,evasion
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

|[c_zmovetype]| f_zobj[[
    0;name,"status";
    ; name,"physical";
    ; name,"special";
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
  -1;, "none",     T_BIRD,     0,  40,  0,    %f_move_default                                               -- -1  This is the move used for confusion damage.
  ;0;, "struggle", T_BIRD,     1,  50,  100,  %f_move_recoil                                                -- 0   DIFF: ignores resistance now. hits ghost pokemon.
   ;;, "megapnch", T_NORMAL,   20, 80,  85,   %f_move_default                                               -- 1
   ;;, "razrwind", T_NORMAL,   10, 80,  75,   %f_move_implement                                             -- 2
   ;;, "sworddnc", T_NORMAL,   30, 0,   0,    %f_move_stat_self, attack, 2                                  -- 3
   ;;, "whrlwind", T_NORMAL,   20, 0,   100,  %f_move_roar                                                  -- 4   DIFF: switches opponent with random pokemon & hits pokemon using fly
   ;;, "megakick", T_NORMAL,   5,  120, 75,   %f_move_default                                               -- 5
   ;;, "toxic",    T_POISON,   10, 0,   85,   %f_move_toxic                                                 -- 6
   ;;, "horndril", T_NORMAL,   5,  -1,  30,   %f_move_ohko                                                  -- 7
   ;;, "bodyslam", T_NORMAL,   15, 85,  100,  %f_move_percent,30,%f_move_major_other,C_MAJOR_PARALYZED      -- 8
   ;;, "takedown", T_NORMAL,   20, 90,  85,   %f_move_recoil                                                -- 9
   ;;, "doubedge", T_NORMAL,   15, 100, 100,  %f_move_recoil                                                -- 10
   ;;, "bublbeam", T_WATER,    20, 65,  100,  %f_move_percent,10,%f_move_stat_other, speed, -1              -- 11
   ;;, "watergun", T_WATER,    25, 40,  100,  %f_move_default                                               -- 12
   ;;, "icebeam",  T_ICE,      10, 95,  100,  %f_move_percent,10,%f_move_major_other,C_MAJOR_FROZEN         -- 13
   ;;, "blizzard", T_ICE,      5,  120, 90,   %f_move_percent,10,%f_move_major_other,C_MAJOR_FROZEN         -- 14
   ;;, "hyprbeam", T_NORMAL,   5,  150, 90,   %f_move_implement                                             -- 15
   ;;, "payday",   T_NORMAL,   20, 40,  100,  %f_move_default                                               -- 16
   ;;, "submsion", T_FIGHTING, 20, 80,  80,   %f_move_recoil                                                -- 17
   ;;, "counter",  T_FIGHTING, 20, -1,  100,  %f_move_counter                                               -- 18  DIFF: respects resistance, counts all physical damage taken during turn or taken by substitute
   ;;, "seistoss", T_FIGHTING, 20, -1,  100,  %f_move_setdmg,C_LEVEL                                        -- 19  DIFF: respects resistance
   ;;, "rage",     T_NORMAL,   20, 20,  100,  %f_move_rage                                                  -- 20  DIFF: you can switch out while using rage, rage also ends when frozen/sleep/trapped/disabled, just like other multiturn moves
   ;;, "megdrain", T_GRASS,    10, 40,  100,  %f_move_drain                                                 -- 21
   ;;, "solrbeam", T_GRASS,    10, 120, 100,  %f_move_implement                                             -- 22
   ;;, "drgnrage", T_DRAGON,   10, -1,  100,  %f_move_setdmg,40                                             -- 23  DIFF: respects resistance
   ;;, "thndrblt", T_ELECTRIC, 15, 95,  100,  %f_move_percent,10,%f_move_major_other,C_MAJOR_PARALYZED      -- 24
   ;;, "thunder",  T_ELECTRIC, 10, 120, 70,   %f_move_percent,10,%f_move_major_other,C_MAJOR_PARALYZED      -- 25  DIFF: hits pokemon using fly + double damage
   ;;, "earthqke", T_GROUND,   10, 100, 100,  %f_move_default                                               -- 26  DIFF: hits pokemon using dig + double damage
   ;;, "fissure",  T_GROUND,   5,  -1,  30,   %f_move_ohko                                                  -- 27  DIFF: hits pokemon underground
   ;;, "dig",      T_GROUND,   10, 100, 100,  %f_move_implement                                             -- 28
   ;;, "psychic",  T_PSYCHIC,  10, 90,  100,  %f_move_percent,30,%f_move_stat_other,special,-1              -- 29
   ;;, "teleport", T_PSYCHIC,  20, 0,   0,    %f_move_teleport                                              -- 30  DIFF: switches with random pokemon from user's team
   ;;, "mimic",    T_NORMAL,   10, 0,   100,  %f_move_mimic                                                 -- 31  DIFF: doesn't miss and copies 5 pp like transform
   ;;, "doubteam", T_NORMAL,   15, 0,   0,    %f_move_stat_self, evasion, 1                                 -- 32
   ;;, "reflect",  T_PSYCHIC,  20, 0,   0,    %f_move_self,%f_movehelp_minor,reflected                      -- 33
   ;;, "bide",     T_NORMAL,   10, -1,  100,  %f_move_implement                                             -- 34  DIFF: doesn't bypass accuracy check & respects resistance, counts damage done to substitute
   ;;, "metrnome", T_NORMAL,   10, 0,   0,    %f_move_metronome                                             -- 35
   ;;, "selfdstr", T_NORMAL,   5,  260, 100,  %f_move_default                                               -- 36
   ;;, "eggbomb",  T_NORMAL,   10, 100, 75,   %f_move_default                                               -- 37
   ;;, "fireblst", T_FIRE,     5,  120, 85,   %f_move_percent,30,%f_move_major_other,C_MAJOR_BURNED         -- 38
   ;;, "swift",    T_NORMAL,   20, 60,  -1,   %f_move_default                                               -- 39  DIFF: always hits when used, even against dig/fly, can't go past substitute though
   ;;, "skulbash", T_NORMAL,   15, 100, 100,  %f_move_implement                                             -- 40
   ;;, "softboil", T_NORMAL,   10, 0,   0,    %f_move_recover                                               -- 41
   ;;, "dreameat", T_PSYCHIC,  15, 100, 100,  %f_move_dreameater                                            -- 42
   ;;, "skyattck", T_FLYING,   5,  140, 90,   %f_move_implement                                             -- 43
   ;;, "rest",     T_PSYCHIC,  10, 0,   0,    %f_move_rest                                                  -- 44
   ;;, "thndrwav", T_ELECTRIC, 20, 0,   100,  %f_move_major_other, C_MAJOR_PARALYZED                        -- 45
   ;;, "psywave",  T_PSYCHIC,  15, -1,  80,   %f_move_psywave                                               -- 46  DIFF: respects resistance
   ;;, "explsion", T_NORMAL,   5,  340, 100,  %f_move_default                                               -- 47
   ;;, "rockslid", T_ROCK,     10, 75,  90,   %f_move_default                                               -- 48
   ;;, "triattck", T_NORMAL,   10, 80,  100,  %f_move_default                                               -- 49
   ;;, "substute", T_NORMAL,   10, 0,   0,    %f_move_implement                                             -- 50  DIFF: recoil moves damage user. only protects from direct enemy damage, user is still vulnerable to all other effects
   ;;, "cut",      T_NORMAL,   30, 50,  95,   %f_move_default                                               -- 51
   ;;, "fly",      T_FLYING,   15, 70,  95,   %f_move_implement                                             -- 52
   ;;, "surf",     T_WATER,    15, 95,  100,  %f_move_default                                               -- 53
   ;;, "strength", T_NORMAL,   15, 80,  100,  %f_move_default                                               -- 54
   ;;, "flash",    T_NORMAL,   20, 0,   70,   %f_move_stat_other, accuracy, -1                              -- 55
   ;;, "pound",    T_NORMAL,   35, 40,  100,  %f_move_default                                               -- 56
   ;;, "karatchp", T_FIGHTING, 25, 55,  100,  %f_move_default                                               -- 57
   ;;, "doubslap", T_NORMAL,   10, 15,  85,   %f_move_multihit_var                                          -- 58  DIFF: if KOs pkmn, will also hit new pokemon switched in & hits after substitute
   ;;, "comtpnch", T_NORMAL,   15, 18,  85,   %f_move_multihit_var                                          -- 59  DIFF: if KOs pkmn, will also hit new pokemon switched in & hits after substitute
   ;;, "firepnch", T_FIRE,     15, 75,  100,  %f_move_percent,10,%f_move_major_other,C_MAJOR_BURNED         -- 60
   ;;, "icepnch",  T_ICE,      15, 75,  100,  %f_move_percent,10,%f_move_major_other,C_MAJOR_FROZEN         -- 61
   ;;, "thndpnch", T_ELECTRIC, 15, 75,  100,  %f_move_percent,10,%f_move_major_other,C_MAJOR_PARALYZED      -- 62
   ;;, "scratch",  T_NORMAL,   35, 40,  100,  %f_move_default                                               -- 63
   ;;, "vicegrip", T_NORMAL,   30, 55,  100,  %f_move_default                                               -- 64
   ;;, "guilotin", T_NORMAL,   5,  -1,  30,   %f_move_ohko                                                  -- 65
   ;;, "gust",     T_FLYING,   35, 40,  100,  %f_move_default                                               -- 66  DIFF: hits pokemon using fly & double damage
   ;;, "wingatck", T_FLYING,   35, 35,  100,  %f_move_default                                               -- 67
   ;;, "bind",     T_NORMAL,   20, 15,  75,   %f_move_implement                                             -- 68
   ;;, "slam",     T_NORMAL,   20, 80,  75,   %f_move_default                                               -- 69
   ;;, "vinewhip", T_GRASS,    10, 35,  100,  %f_move_default                                               -- 70
   ;;, "stomp",    T_NORMAL,   20, 65,  100,  %f_move_percent,30,%f_move_other,%f_movehelp_minor,flinching  -- 71
   ;;, "doubkick", T_FIGHTING, 30, 30,  100,  %f_move_multihit_set,2,%f_nop                                 -- 72  DIFF: if KOs pkmn, will also hit new pokemon switched in
   ;;, "jumpkick", T_FIGHTING, 20, 70,  95,   %f_move_default                                               -- 73
   ;;, "rllngkck", T_FIGHTING, 15, 60,  85,   %f_move_percent,30,%f_move_other,%f_movehelp_minor,flinching  -- 74
   ;;, "sandatck", T_GROUND,   15, 0,   100,  %f_move_stat_other, accuracy, -1                              -- 75
   ;;, "headbutt", T_NORMAL,   15, 70,  100,  %f_move_percent,30,%f_move_other,%f_movehelp_minor,flinching  -- 76
   ;;, "hornatck", T_NORMAL,   25, 65,  100,  %f_move_default                                               -- 77
   ;;, "furyatck", T_NORMAL,   20, 15,  85,   %f_move_multihit_var                                          -- 78  DIFF: if KOs pkmn, will also hit new pokemon switched in
   ;;, "tackle",   T_NORMAL,   35, 35,  95,   %f_move_default                                               -- 79
   ;;, "wrap",     T_NORMAL,   20, 15,  85,   %f_move_implement                                             -- 80
   ;;, "thrash",   T_NORMAL,   20, 90,  100,  %f_move_thrash                                                -- 81
   ;;, "tailwhip", T_NORMAL,   30, 0,   100,  %f_move_stat_other, defense, -1                               -- 82
   ;;, "psnsting", T_POISON,   35, 15,  100,  %f_move_percent,20,%f_move_major_other,C_MAJOR_POISONED       -- 83
   ;;, "twineedl", T_BUG,      20, 25,  100,  %f_move_multihit_twin                                         -- 84  DIFF: if KOs pkmn, will also hit new pokemon switched in
   ;;, "pinmisil", T_BUG,      20, 14,  85,   %f_move_multihit_var                                          -- 85  DIFF: if KOs pkmn, will also hit new pokemon switched in
   ;;, "leer",     T_NORMAL,   30, 0,   100,  %f_move_stat_other, defense, -1                               -- 86
   ;;, "bite",     T_NORMAL,   25, 60,  100,  %f_move_percent,10,%f_move_other,%f_movehelp_minor,flinching  -- 87
   ;;, "growl",    T_NORMAL,   40, 0,   100,  %f_move_stat_other, attack, -1                                -- 88
   ;;, "roar",     T_NORMAL,   20, 0,   100,  %f_move_roar                                                  -- 89  DIFF: switches opponent with random pokemon
   ;;, "sing",     T_NORMAL,   15, 0,   55,   %f_move_major_other, C_MAJOR_SLEEPING                         -- 90
   ;;, "sprsonic", T_NORMAL,   20, 0,   55,   %f_move_other,%f_movehelp_confuse                             -- 91
   ;;, "sonicbom", T_NORMAL,   20, -1,  90,   %f_move_setdmg,20                                             -- 92  DIFF: respects resistance
   ;;, "disable",  T_NORMAL,   20, 0,   55,   %f_move_disable                                               -- 93  DIFF: lasts 2-7 turns
   ;;, "acid",     T_POISON,   30, 40,  100,  %f_move_percent,10,%f_move_stat_other, defense, -1            -- 94
   ;;, "ember",    T_FIRE,     25, 40,  100,  %f_move_percent,10,%f_move_major_other,C_MAJOR_BURNED         -- 95
   ;;, "flamthwr", T_FIRE,     15, 95,  100,  %f_move_percent,10,%f_move_major_other,C_MAJOR_BURNED         -- 96
   ;;, "mist",     T_ICE,      30, 0,   0,    %f_move_self,%f_movehelp_minor,misted                         -- 97  DIFF: protects against modifier decreases from damaging moves too
   ;;, "hydropmp", T_WATER,    5,  120, 80,   %f_move_default                                               -- 98
   ;;, "psybeam",  T_PSYCHIC,  20, 65,  100,  %f_move_percent,10,%f_move_other,%f_movehelp_confuse          -- 99
   ;;, "aurorabm", T_ICE,      20, 65,  100,  %f_move_percent,10,%f_move_stat_other, attack, -1             -- 100
   ;;, "peck",     T_FLYING,   35, 35,  100,  %f_move_default                                               -- 101
   ;;, "drillpck", T_FLYING,   20, 80,  100,  %f_move_default                                               -- 102
   ;;, "lowkick",  T_FIGHTING, 20, 50,  90,   %f_move_percent,30,%f_move_other,%f_movehelp_minor,flinching  -- 103
   ;;, "absorb",   T_GRASS,    20, 20,  100,  %f_move_drain                                                 -- 104
   ;;, "leechsed", T_GRASS,    10, 0,   90,   %f_move_other,%f_movehelp_minor,seeded                        -- 105
   ;;, "growth",   T_NORMAL,   40, 0,   0,    %f_move_stat_self, special, 1                                 -- 106
   ;;, "razrleaf", T_GRASS,    25, 55,  95,   %f_move_default                                               -- 107
   ;;, "psnpowdr", T_POISON,   35, 0,   75,   %f_move_major_other, C_MAJOR_POISONED                         -- 108
   ;;, "stunspor", T_GRASS,    30, 0,   75,   %f_move_major_other, C_MAJOR_PARALYZED                        -- 109
   ;;, "slppowdr", T_GRASS,    15, 0,   75,   %f_move_major_other, C_MAJOR_SLEEPING                         -- 110
   ;;, "petldanc", T_GRASS,    20, 70,  100,  %f_move_thrash                                                -- 111
   ;;, "strngsht", T_BUG,      40, 0,   95,   %f_move_stat_other, speed, -1                                 -- 112
   ;;, "firespin", T_FIRE,     15, 15,  70,   %f_move_implement                                             -- 113
   ;;, "thndshck", T_ELECTRIC, 30, 40,  100,  %f_move_percent,10,%f_move_major_other,C_MAJOR_PARALYZED      -- 114
   ;;, "rockthrw", T_ROCK,     15, 50,  65,   %f_move_default                                               -- 115
   ;;, "cnfusion", T_PSYCHIC,  25, 50,  100,  %f_move_percent,10,%f_move_other,%f_movehelp_confuse          -- 116
   ;;, "hypnosis", T_PSYCHIC,  20, 0,   60,   %f_move_major_other, C_MAJOR_SLEEPING                         -- 117
   ;;, "meditate", T_PSYCHIC,  40, 0,   0,    %f_move_stat_self, attack, 1                                  -- 118
   ;;, "agility",  T_PSYCHIC,  30, 0,   0,    %f_move_stat_self, speed, 2                                   -- 119
   ;;, "quickatk", T_NORMAL,   30, 40,  100,  %f_move_default                                               -- 120
   ;;, "ngtshade", T_GHOST,    15, -1,  100,  %f_move_setdmg,C_LEVEL                                        -- 121 DIFF: respects resistance now
   ;;, "screech",  T_NORMAL,   10, 0,   85,   %f_move_stat_other, defense, -2                               -- 122
   ;;, "recover",  T_NORMAL,   20, 0,   0,    %f_move_recover                                               -- 123
   ;;, "harden",   T_NORMAL,   30, 0,   0,    %f_move_stat_self, defense, 1                                 -- 124
   ;;, "minimize", T_NORMAL,   20, 0,   0,    %f_move_stat_self, evasion, 1                                 -- 125
   ;;, "smokscrn", T_NORMAL,   20, 0,   100,  %f_move_stat_other, accuracy, -1                              -- 126
   ;;, "cnfusray", T_GHOST,    10, 0,   100,  %f_move_other,%f_movehelp_confuse                             -- 127
   ;;, "withdraw", T_WATER,    40, 0,   0,    %f_move_stat_self, defense, 1                                 -- 128
   ;;, "dfnscurl", T_NORMAL,   40, 0,   0,    %f_move_stat_self, defense, 1                                 -- 129
   ;;, "barrier",  T_PSYCHIC,  30, 0,   0,    %f_move_stat_self, defense, 2                                 -- 130
   ;;, "lghtscrn", T_PSYCHIC,  30, 0,   0,    %f_move_self,%f_movehelp_minor,screened                       -- 131
   ;;, "haze",     T_ICE,      30, 0,   -1,   %f_move_haze                                                  -- 132 DIFF: only resets stat modifiers, applies even when mist is in effect
   ;;, "fcsenrgy", T_NORMAL,   30, 0,   0,    %f_move_self,%f_movehelp_minor,focused                        -- 133
   ;;, "mirrmove", T_FLYING,   20, -1,  0,    %f_move_mirror_move                                           -- 134
   ;;, "lick",     T_GHOST,    30, 20,  100,  %f_move_percent,30,%f_move_major_other,C_MAJOR_PARALYZED      -- 135 DIFF: super effective against psychic type now
   ;;, "smog",     T_POISON,   20, 20,  100,  %f_move_percent,30,%f_move_major_other,C_MAJOR_POISONED       -- 136
   ;;, "sludge",   T_POISON,   20, 65,  100,  %f_move_percent,30,%f_move_major_other,C_MAJOR_POISONED       -- 137
   ;;, "boneclub", T_GROUND,   20, 65,  85,   %f_move_percent,10,%f_move_other,%f_movehelp_minor,flinching  -- 138
   ;;, "watrfall", T_WATER,    15, 80,  100,  %f_move_default                                               -- 139
   ;;, "clamp",    T_WATER,    10, 35,  75,   %f_move_implement                                             -- 140
   ;;, "spikcann", T_NORMAL,   15, 20,  100,  %f_move_multihit_var                                          -- 141 DIFF: if KOs pkmn, will also hit new pokemon switched in
   ;;, "constrct", T_NORMAL,   35, 10,  100,  %f_move_percent,10,%f_move_stat_other, speed, -1              -- 142
   ;;, "amnesia",  T_PSYCHIC,  20, 0,   0,    %f_move_stat_self, special, 2                                 -- 143
   ;;, "kinesis",  T_PSYCHIC,  15, 0,   80,   %f_move_stat_other, accuracy, -1                              -- 144
   ;;, "hijmpkck", T_FIGHTING, 20, 85,  90,   %f_move_default                                               -- 145
   ;;, "glare",    T_NORMAL,   30, 0,   75,   %f_move_major_other, C_MAJOR_PARALYZED                        -- 146
   ;;, "poisngas", T_POISON,   40, 0,   55,   %f_move_major_other, C_MAJOR_POISONED                         -- 147
   ;;, "barrage",  T_NORMAL,   20, 15,  85,   %f_move_multihit_var                                          -- 148 DIFF: if KOs pkmn, will also hit new pokemon switched in
   ;;, "leechlif", T_BUG,      15, 20,  100,  %f_move_drain                                                 -- 149
   ;;, "lovekiss", T_NORMAL,   10, 0,   75,   %f_move_major_other, C_MAJOR_SLEEPING                         -- 150
   ;;, "tranform", T_NORMAL,   10, 0,   0,    %f_move_transform                                             -- 151 DIFF: Does not copy stat stages
   ;;, "bubble",   T_WATER,    30, 20,  100,  %f_move_percent,10,%f_move_stat_other, speed, -1              -- 152
   ;;, "dizypnch", T_NORMAL,   10, 70,  100,  %f_move_default                                               -- 153
   ;;, "spore",    T_GRASS,    15, 0,   100,  %f_move_major_other, C_MAJOR_SLEEPING                         -- 154
   ;;, "splash",   T_NORMAL,   40, 0,   0,    %f_move_splash                                                -- 155
   ;;, "acidarmr", T_POISON,   40, 0,   0,    %f_move_stat_self, defense, 2                                 -- 156
   ;;, "crabhamr", T_WATER,    10, 90,  85,   %f_move_default                                               -- 157
   ;;, "furyswps", T_NORMAL,   15, 10,  80,   %f_move_multihit_var                                          -- 158 DIFF: if KOs pkmn, will also hit new pokemon switched in
   ;;, "bonerang", T_GROUND,   10, 50,  90,   %f_move_multihit_set,2,%f_nop                                 -- 159 DIFF: if KOs pkmn, will also hit new pokemon switched in
   ;;, "hyprfang", T_NORMAL,   15, 80,  90,   %f_move_percent,10,%f_move_other,%f_movehelp_minor,flinching  -- 160
   ;;, "sharpen",  T_NORMAL,   30, 0,   0,    %f_move_stat_self, attack, 1                                  -- 161
   ;;, "convrson", T_NORMAL,   30, 0,   0,    %f_move_conversion                                            -- 162
   ;;, "suprfang", T_NORMAL,   10, -1,  90,   %f_move_superfang                                             -- 163 DIFF: respects resistance now
   ;;, "slash",    T_NORMAL,   20, 70,  100,  %f_move_default                                               -- 164
]]

-- could get an error if a trainer doesn't have 6 pkmn, because of assumptions i make when starting a fight
|[c_trainers]| f_zobj[[
    ;,"youngstr", P_RATTATA,   P_PIDGEY,    P_CATERPIE,  P_SPEAROW,   P_WEEDLE,    P_BELLSPROUT
   ;;,"bugcatch", P_WEEDLE,    P_PARAS,     P_KAKUNA,    P_CATERPIE,  P_METAPOD,   P_PINSIR
   ;;,"junior",   P_EKANS,     P_SQUIRTLE,  P_SANDSHREW, P_CHARMANDER,P_RATTATA,   P_BULBASAUR
   ;;,"brock",    P_GEODUDE,   P_OMANYTE,   P_CUBONE,    P_VULPIX,    P_KABUTO,    P_ONIX

   ;;,"lass",     P_ODDISH,    P_MEOWTH,    P_CLEFAIRY,  P_NIDORANF,  P_DODUO,     P_JIGGLYPUFF
   ;;,"hiker",    P_GEODUDE,   P_DIGLETT,   P_ZUBAT,     P_MACHOP,    P_PARAS,     P_GRAVELER
   ;;,"swimmer",  P_HORSEA,    P_POLIWAG,   P_SHELLDER,  P_MAGIKARP,  P_STARYU,    P_GOLDEEN
   ;;,"misty",    P_STARYU,    P_SEADRA,    P_PSYDUCK,   P_SEAKING,   P_SEEL,      P_STARMIE

   ;;,"gentlman", P_GROWLITHE, P_NIDORANM,  P_DRATINI,   P_PONYTA,    P_SANDSHREW, P_EEVEE
   ;;,"sailor",   P_SHELLDER,  P_TENTACOOL, P_PSYDUCK,   P_POLIWAG,   P_KRABBY,    P_POLIWHIRL
   ;;,"rocker",   P_VOLTORB,   P_ZUBAT,     P_VENONAT,   P_MAGNEMITE, P_ABRA,      P_PIKACHU
   ;;,"ltsurge",  P_PIKACHU,   P_JOLTEON,   P_VOLTORB,   P_ELECTABUZZ,P_MAGNETON,  P_RAICHU

   ;;,"channelr", P_GASTLY,    P_JIGGLYPUFF,P_CUBONE,    P_CLEFAIRY,  P_HAUNTER,   P_MAROWAK
   ;;,"gambler",  P_PIDGEOTTO, P_GRAVELER,  P_POLIWHIRL, P_RHYHORN,   P_GROWLITHE, P_GLOOM
   ;;,"beauty",   P_BELLSPROUT,P_CHANSEY,   P_WIGGLYTUFF,P_WEEPINBELL,P_EEVEE,     P_CLEFABLE
   ;;,"erika",    P_PARASECT,  P_VICTREEBEL,P_EXEGGCUTE, P_BUTTERFREE,P_TANGELA,   P_VILEPLUME

   ;;,"biker",    P_KOFFING,   P_MANKEY,    P_TENTACOOL, P_GRIMER,    P_MACHOKE,   P_TENTACRUEL
   ;;,"birdkeep", P_DODUO,     P_PIDGEOTTO, P_FEAROW,    P_FARFETCHD, P_DODRIO,    P_PIDGEOT
   ;;,"juggler",  P_VENONAT,   P_GLOOM,     P_MRMIME,    P_DROWZEE,   P_ELECTRODE, P_SLOWPOKE
   ;;,"koga",     P_NIDORINA,  P_MUK,       P_WEEZING,   P_BEEDRILL,  P_NIDORINO,  P_VENOMOTH

   ;;,"blckbelt", P_MACHOP,    P_MACHOKE,   P_HITMONLEE, P_MANKEY,    P_PRIMEAPE,  P_HITMONCHAN
   ;;,"rocket",   P_SANDSLASH, P_RATICATE,  P_ELECTRODE, P_GOLBAT,    P_WEEZING,   P_ARBOK
   ;;,"psychic",  P_SLOWPOKE,  P_ABRA,      P_SLOWBRO,   P_DROWZEE,   P_EXEGGCUTE, P_KADABRA
   ;;,"sabrina",  P_MRMIME,    P_EXEGGUTOR, P_KADABRA,   P_JYNX,      P_HYPNO,     P_ALAKAZAM

   ;;,"scientst", P_DITTO,     P_VICTREEBEL,P_GASTLY,    P_VENOMOTH,  P_HYPNO,     P_PORYGON
   ;;,"pkmaniac", P_CHANSEY,   P_PINSIR,    P_ELECTABUZZ,P_SCYTHER,   P_LICKITUNG, P_GOLDUCK
   ;;,"suprnerd", P_PONYTA,    P_MAGNETON,  P_PRIMEAPE,  P_FLAREON,   P_VULPIX,    P_RAPIDASH
   ;;,"blaine",   P_RAPIDASH,  P_ARCANINE,  P_FLAREON,   P_NINETALES, P_GOLEM,     P_MAGMAR

   ;;,"cooltrnr", P_DRAGONAIR, P_WARTORTLE, P_PARASECT,  P_CHARMELEON,P_POLIWRATH, P_IVYSAUR
   ;;,"fishrman", P_GOLDEEN,   P_TENTACRUEL,P_SEADRA,    P_SEAKING,   P_CLOYSTER,  P_KINGLER
   ;;,"tamer",    P_MAROWAK,   P_TAUROS,    P_SANDSLASH, P_RATICATE,  P_RHYHORN,   P_PERSIAN
   ;;,"giovanni", P_DUGTRIO,   P_NIDOKING,  P_PERSIAN,   P_NIDOQUEEN, P_KANGASKHAN,P_RHYDON

   ;;,"lorelei",  P_CLOYSTER,  P_JYNX,      P_VAPOREON,  P_LAPRAS,    P_SLOWBRO,   P_DEWGONG
   ;;,"bruno",    P_ONIX,      P_HITMONCHAN,P_OMASTAR,   P_HITMONLEE, P_GOLEM,     P_MACHAMP
   ;;,"agatha",   P_GOLBAT,    P_MUK,       P_HAUNTER,   P_VILEPLUME, P_ARBOK,     P_GENGAR
   ;;,"lance",    P_GYARADOS,  P_DRAGONAIR, P_AERODACTYL,P_DRAGONITE, P_KABUTOPS,  P_SNORLAX

   ;;,"blue",     P_PIDGEOT,   P_ALAKAZAM,  P_JOLTEON,   P_ARCANINE,  P_EXEGGUTOR, P_BLASTOISE
   ;;,"green",    P_GENGAR,    P_KANGASKHAN,P_CLEFABLE,  P_GYARADOS,  P_NINETALES, P_VENUSAUR
   ;;,"red",      P_SCYTHER,   P_SNORLAX,   P_RAICHU,    P_LAPRAS,    P_DODRIO,    P_CHARIZARD
   ;;,"legendry", P_DRAGONITE, P_ZAPDOS,    P_MOLTRES,   P_ARTICUNO,  P_MEWTWO,    P_MEW
]] $$
