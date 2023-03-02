|[c_pokemon]| f_zobj[[]] $$

-- thanks to bulbapedia: https://bulbapedia.bulbagarden.net/wiki/Stat#Stat
-- this formula is much simpler at lvl 50, so I took some parts out.
|[f_calc_max_stat]| function(base)
    return _ceil(base+.5*93)+5
end $$

-- c_pokemon_raw just has data. it requires running it in order. and it can only be called when the game starts, before memory is overwritten.
-- this makes populating c_pokemon much easier.
|[f_populate_c_pokemon]| function()
    local movemem, names = _peek2(8), split"missingno,bulbasaur,ivysaur,venusaur,charmander,charmeleon,charizard,squirtle,wartortle,blastoise,caterpie,metapod,butterfree,weedle,kakuna,beedrill,pidgey,pidgeotto,pidgeot,rattata,raticate,spearow,fearow,ekans,arbok,pikachu,raichu,sandshrew,sandslash,nidoran f,nidorina,nidoqueen,nidoran m,nidorino,nidoking,clefairy,clefable,vulpix,ninetales,jigglypuff,wigglytuff,zubat,golbat,oddish,gloom,vileplume,paras,parasect,venonat,venomoth,diglett,dugtrio,meowth,persian,psyduck,golduck,mankey,primeape,growlithe,arcanine,poliwag,poliwhirl,poliwrath,abra,kadabra,alakazam,machop,machoke,machamp,bellsprout,weepinbell,victreebel,tentacool,tentacruel,geodude,graveler,golem,ponyta,rapidash,slowpoke,slowbro,magnemite,magneton,farfetchd,doduo,dodrio,seel,dewgong,grimer,muk,shellder,cloyster,gastly,haunter,gengar,onix,drowzee,hypno,krabby,kingler,voltorb,electrode,exeggcute,exeggutor,cubone,marowak,hitmonlee,hitmonchan,lickitung,koffing,weezing,rhyhorn,rhydon,chansey,tangela,kangaskhan,horsea,seadra,goldeen,seaking,staryu,starmie,mr mime,scyther,jynx,electabuzz,magmar,pinsir,tauros,magikarp,gyarados,lapras,ditto,eevee,vaporeon,jolteon,flareon,porygon,omanyte,omastar,kabuto,kabutops,aerodactyl,snorlax,articuno,zapdos,moltres,dratini,dragonair,dragonite,mewtwo,mew"

    -- -1 is for disabled things. this is never available.
    for num=-1,151 do
        ---- PASS 1 - create array ----
        -- this populates an array for the pokemon, based on data stored in the cartridge
        -- todo: put these in constants.txt
        local EVENT = 252 -- is event
        local TEACH = 253 -- is teach (tm/hm)
        local DASH  = 254 -- is a dash/range
        local NEXT  = 255 -- is next pokemon

        local pkmndata, is_range = {}, false
        while @movemem ~= NEXT do
            if @movemem == DASH then
                is_range = true
            elseif is_range then
                for i=pkmndata[#pkmndata]+1,@movemem do
                    _add(pkmndata, i)
                end
                is_range = false
            else
                _add(pkmndata, @movemem)
            end
            movemem += 1
        end
        movemem += 1

        ---- PART 2 - populate most attributes ----
        local evolvesfrom = num-pkmndata[1]
        local pkmn = f_zobj([[
            num,@,
            evolvesfrom,@,
            name,@,
            type1,@,
            type2,@,
            base_maxhp,@,
            base_attack,@,
            base_defense,@,
            base_speed,@,
            base_special,@,

            moves_natural,@,
            moves_teach,@,
            moves_event,@
        ]],
            num, -- evl
            evolvesfrom,  -- evl
            names[num+1], -- nam
            pkmndata[2],  -- ty1
            pkmndata[3],  -- ty2
            pkmndata[4],  -- xhp
            pkmndata[5],  -- att
            pkmndata[6],  -- def
            pkmndata[7],  -- spd
            pkmndata[8],  -- spc
            {}, {}, {}
        )

        ---- PASS 3 - populate the moves ----
        local move_bucket = pkmn.moves_natural
        for i=9,#pkmndata do
            local val = pkmndata[i]
            if val == TEACH then
                move_bucket = pkmn.moves_teach
            elseif val == EVENT then
                move_bucket = pkmn.moves_event
            else
                _add(move_bucket, val)
            end
        end

        -- todo: teachs could be in a weird order for evolved forms. i should fix that
        if evolvesfrom < num then
            _foreach(c_pokemon[evolvesfrom].moves_natural, function(move) _add(pkmn.moves_natural, move) end)
            _foreach(c_pokemon[evolvesfrom].moves_teach,      function(move) _add(pkmn.moves_teach,      move) end)
            _foreach(c_pokemon[evolvesfrom].moves_event,   function(move) _add(pkmn.moves_event,   move) end)
        end

        local teach_map, teachs = {}, {}
        _foreach(pkmn.moves_teach, function(move) teach_map[move] = true end)
        for i=1,54 do
            if teach_map[i] then _add(teachs, i) end
        end
        pkmn.moves_teach = teachs

        ---- PASS 4 - add level specific data and other attributes to the pkmn ----
        f_zobj_set(pkmn, [[
            attack,@, defense,@, special,@, speed,@, maxhp,@, level,C_LEVEL
        ]], f_calc_max_stat(pkmn.base_attack),
            f_calc_max_stat(pkmn.base_defense),
            f_calc_max_stat(pkmn.base_special),
            f_calc_max_stat(pkmn.base_speed),
            f_calc_max_stat(pkmn.base_maxhp)+5+C_LEVEL
        )

        pkmn.total = pkmn.attack + pkmn.defense + pkmn.special + pkmn.speed + pkmn.maxhp

        pkmn.browse_draw = function(...)
            -- todo: if logic for surfing pikachu + amnesia psyduck?
            f_draw_pkmn_out(pkmn.available() and pkmn.num or -1, ...)
        end

        pkmn.draw = function(...)
            -- todo: if logic for surfing pikachu + amnesia psyduck?
            f_draw_pkmn_out(pkmn.num, ...)
        end

        pkmn.available = function()
            if pkmn.num >= 0 then -- shouldn't be -1
                return @(S_POKEMON+pkmn.num) > 0
            end
        end

        ---- PASS 5 - finally, set the pokemon to the c_pokemon array ----
        c_pokemon[num] = pkmn
    end
end $$

|[f_get_natural_moveset]| function(num)
    local pkmn, moveset = c_pokemon[num], {}
    for i=1,min(4,#pkmn.moves_natural) do
        _add(moveset, pkmn.moves_natural[i])
    end
    return moveset
end $$

-- pokemon moves can be physical or special. the order here is specific. odd numbers are physical. even numbers are special.
-- includes type effectiveness chart. according to the gen 1 games, which had bugs. i'm keeping the bugs :).
|[c_types]| f_zobj[[
    T_NONE;     bg,0, name,%c_empty;        T_NONE;     good;,;                                  T_NONE;     null;,;                   T_NONE;     weak;,;
    T_NORMAL;   bg,0, name,"normal";   T_NORMAL;   good;,;                                  T_NORMAL;   null;,T_GHOST;            T_NORMAL;   weak;,T_ROCK;
    T_FIRE;     bg,5, name,"fire";     T_FIRE;     good;,T_GRASS,T_ICE,T_BUG;               T_FIRE;     null;,;                   T_FIRE;     weak;,T_FIRE,T_WATER,T_ROCK,T_DRAGON;
    T_FIGHTING; bg,2, name,"fighting"; T_FIGHTING; good;,T_ICE,T_NORMAL,T_ROCK;             T_FIGHTING; null;,T_GHOST;            T_FIGHTING; weak;,T_BUG,T_FLYING,T_POISON,T_PSYCHIC;
    T_WATER;    bg,4, name,"water";    T_WATER;    good;,T_FIRE,T_GROUND,T_ROCK;            T_WATER;    null;,;                   T_WATER;    weak;,T_DRAGON,T_GRASS,T_WATER;
    T_POISON;   bg,1, name,"poison";   T_POISON;   good;,T_BUG,T_GRASS;                     T_POISON;   null;,;                   T_POISON;   weak;,T_GHOST,T_GROUND,T_POISON,T_ROCK;
    T_ELECTRIC; bg,6, name,"electric"; T_ELECTRIC; good;,T_FLYING,T_WATER;                  T_ELECTRIC; null;,T_GROUND;           T_ELECTRIC; weak;,T_DRAGON,T_ELECTRIC,T_GRASS;
    T_GROUND;   bg,2, name,"ground";   T_GROUND;   good;,T_ELECTRIC,T_FIRE,T_POISON,T_ROCK; T_GROUND;   null;,T_FLYING;           T_GROUND;   weak;,T_BUG,T_GRASS;
    T_GRASS;    bg,3, name,"grass";    T_GRASS;    good;,T_GROUND,T_ROCK,T_WATER;           T_GRASS;    null;,;                   T_GRASS;    weak;,T_BUG,T_DRAGON,T_FIRE,T_FLYING,T_GRASS,T_POISON;
    T_FLYING;   bg,0, name,"flying";   T_FLYING;   good;,T_BUG,T_FIGHTING,T_GRASS;          T_FLYING;   null;,;                   T_FLYING;   weak;,T_ELECTRIC,T_ROCK;
    T_ICE;      bg,4, name,"ice";      T_ICE;      good;,T_DRAGON,T_FLYING,T_GRASS;         T_ICE;      null;,;                   T_ICE;      weak;,T_FIRE,T_ICE,T_WATER;
    T_BUG;      bg,3, name,"bug";      T_BUG;      good;,T_GRASS,T_PSYCHIC;                 T_BUG;      null;,;                   T_BUG;      weak;,T_FIGHTING,T_FIRE,T_FLYING,T_GHOST,T_POISON;
    T_PSYCHIC;  bg,1, name,"psychic";  T_PSYCHIC;  good;,T_FIGHTING,T_POISON;               T_PSYCHIC;  null;,;                   T_PSYCHIC;  weak;,T_PSYCHIC;
    T_ROCK;     bg,0, name,"rock";     T_ROCK;     good;,T_BUG,T_FIRE,T_FLYING,T_ICE;       T_ROCK;     null;,;                   T_ROCK;     weak;,T_FIGHTING,T_GROUND;
    T_DRAGON;   bg,0, name,"dragon";   T_DRAGON;   good;,T_DRAGON;                          T_DRAGON;   null;,;                   T_DRAGON;   weak;,;
    T_GHOST;    bg,1, name,"ghost";    T_GHOST;    good;,T_GHOST;                           T_GHOST;    null;,T_NORMAL,T_PSYCHIC; T_GHOST;    weak;,;
    T_BIRD;     bg,0, name,"bird";     T_BIRD;     good;,;                                  T_BIRD;     null;,;                   T_BIRD;     weak;,
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

-- accuracy 2 means it can't miss.
-- accuracy 0 means it affects the user.
-- pp 0 means it is struggle
-- dmg 0 means it likely changes status or has an effect.
|[c_moves_raw]| f_zobj[[
   --  "name",     type        pp  dmg  acc
   0;, "struggle", T_NORMAL,   0,  50, 1

   -- teachs
   ;;, "megapnch", T_NORMAL,   20, 80,  .85 -- 1
   ;;, "razrwind", T_NORMAL,   10, 80,  1   -- 2
   ;;, "sworddnc", T_NORMAL,   20, 0,   0   -- 3
   ;;, "whrlwind", T_NORMAL,   20, 0,   0   -- 4
   ;;, "megakick", T_NORMAL,   5,  120, .75 -- 5
   ;;, "toxic",    T_POISON,   10, 0,   .9  -- 6
   ;;, "horndril", T_NORMAL,   5,  -1,  .3  -- 7
   ;;, "bodyslam", T_NORMAL,   15, 85,  1   -- 8
   ;;, "takedown", T_NORMAL,   20, 90,  .85 -- 9
   ;;, "doubedge", T_NORMAL,   15, 120, 1   -- 10
   ;;, "bublbeam", T_WATER,    20, 65,  1   -- 11
   ;;, "watergun", T_WATER,    25, 40,  1   -- 12
   ;;, "icebeam",  T_ICE,      10, 90,  1   -- 13
   ;;, "blizzard", T_ICE,      5,  110, .7  -- 14
   ;;, "hyprbeam", T_NORMAL,   5,  150, .9  -- 15
   ;;, "payday",   T_NORMAL,   20, 40,  1   -- 16
   ;;, "submsion", T_FIGHTING, 20, 80,  .8  -- 17
   ;;, "counter",  T_FIGHTING, 20, -1,  1   -- 18
   ;;, "siestoss", T_FIGHTING, 20, -1,  1   -- 19
   ;;, "rage",     T_NORMAL,   20, 20,  1   -- 20
   ;;, "megdrain", T_GRASS,    15, 40,  1   -- 21
   ;;, "solrbeam", T_GRASS,    10, 120, 1   -- 22
   ;;, "drgnrage", T_DRAGON,   10, -1,  1   -- 23
   ;;, "thndrblt", T_ELECTRIC, 15, 90,  1   -- 24
   ;;, "thunder",  T_ELECTRIC, 10, 110, .7  -- 25
   ;;, "earthqke", T_GROUND,   10, 100, 1   -- 26
   ;;, "fissure",  T_GROUND,   5,  -1,  .3  -- 27
   ;;, "dig",      T_GROUND,   10, 80,  1   -- 28
   ;;, "psychic",  T_PSYCHIC,  10, 90,  1   -- 29
   ;;, "teleport", T_PSYCHIC,  20, 0,   0   -- 30
   ;;, "mimic",    T_NORMAL,   10, 0,   0   -- 31
   ;;, "doubteam", T_NORMAL,   15, 0,   0   -- 32
   ;;, "reflect",  T_PSYCHIC,  20, 0,   0   -- 33
   ;;, "bide",     T_NORMAL,   10, -1,  0   -- 34
   ;;, "metronom", T_NORMAL,   10, 0,   0   -- 35
   ;;, "selfdstr", T_NORMAL,   5,  200, 1   -- 36
   ;;, "eggbomb",  T_NORMAL,   10, 100, .75 -- 37
   ;;, "fireblst", T_FIRE,     5,  110, .85 -- 38
   ;;, "swift",    T_NORMAL,   20, 60,  -1  -- 39
   ;;, "skulbash", T_NORMAL,   10, 130, 1   -- 40
   ;;, "softboil", T_NORMAL,   5,  0,   0   -- 41
   ;;, "dreameat", T_PSYCHIC,  15, 100, 1   -- 42
   ;;, "skyattck", T_FLYING,   5,  140, .9  -- 43
   ;;, "rest",     T_PSYCHIC,  5,  0,   0   -- 44
   ;;, "thndrwav", T_ELECTRIC, 20, 0,   .9  -- 45
   ;;, "psywave",  T_PSYCHIC,  15, -1,  1   -- 46
   ;;, "explsion", T_NORMAL,   5,  250, 1   -- 47
   ;;, "rockslid", T_ROCK,     10, 75,  .9  -- 48
   ;;, "triattck", T_NORMAL,   10, 80,  1   -- 49
   ;;, "substute", T_NORMAL,   10, 0,   0   -- 50

    -- hms
   ;;, "cut",      T_NORMAL,   30, 50,  .95 -- 51
   ;;, "fly",      T_FLYING,   15, 90,  .95 -- 52
   ;;, "surf",     T_WATER,    15, 90,  1   -- 53
   ;;, "strength", T_NORMAL,   15, 80,  1   -- 54
   ;;, "flash",    T_NORMAL,   20, 0,   1   -- 55

    -- remaining moves (besides struggle)
   ;;, "pound",    T_NORMAL,   35, 40,  1   -- 56
   ;;, "karatchp", T_FIGHTING, 25, 50,  1   -- 57
   ;;, "doubslap", T_NORMAL,   10, 15,  .85 -- 58
   ;;, "comtpnch", T_NORMAL,   15, 18,  .85 -- 59
   ;;, "firepnch", T_FIRE,     15, 75,  1   -- 60
   ;;, "icepnch",  T_ICE,      15, 75,  1   -- 61
   ;;, "thndpnch", T_ELECTRIC, 15, 75,  1   -- 62
   ;;, "scratch",  T_NORMAL,   35, 40,  1   -- 63
   ;;, "vicegrip", T_NORMAL,   30, 55,  1   -- 64
   ;;, "guilotin", T_NORMAL,   5,  -1,  .3  -- 65
   ;;, "gust",     T_FLYING,   35, 40,  1   -- 66
   ;;, "wingatck", T_FLYING,   35, 60,  1   -- 67
   ;;, "bind",     T_NORMAL,   20, 15,  .85 -- 68
   ;;, "slam",     T_NORMAL,   20, 80,  .75 -- 69
   ;;, "vinewhip", T_GRASS,    25, 45,  1   -- 70
   ;;, "stomp",    T_NORMAL,   20, 65,  1   -- 71
   ;;, "doubkick", T_FIGHTING, 30, 30,  1   -- 72
   ;;, "jumpkck",  T_FIGHTING, 10, 100, .95 -- 73
   ;;, "rllngkck", T_FIGHTING, 15, 60,  .85 -- 74
   ;;, "sandatck", T_GROUND,   15, 0,   1   -- 75
   ;;, "headbutt", T_NORMAL,   15, 70,  1   -- 76
   ;;, "hornatck", T_NORMAL,   25, 65,  1   -- 77
   ;;, "furyatck", T_NORMAL,   20, 15,  .85 -- 78
   ;;, "tackle",   T_NORMAL,   35, 40,  1   -- 79
   ;;, "wrap",     T_NORMAL,   20, 15,  .9  -- 80
   ;;, "thrash",   T_NORMAL,   10, 120, 1   -- 81
   ;;, "tailwhip", T_NORMAL,   30, 0,   1   -- 82
   ;;, "psnsting", T_POISON,   35, 15,  1   -- 83
   ;;, "twineedl", T_BUG,      20, 25,  1   -- 84
   ;;, "pinmisil", T_BUG,      20, 25,  .95 -- 85
   ;;, "leer",     T_NORMAL,   30, 0,   1   -- 86
   ;;, "bite",     T_NORMAL,   25, 60,  1   -- 87
   ;;, "growl",    T_NORMAL,   40, 0,   1   -- 88
   ;;, "roar",     T_NORMAL,   20, 0,   1   -- 89
   ;;, "sing",     T_NORMAL,   15, 0,   .55 -- 90
   ;;, "supersnc", T_NORMAL,   20, 0,   .55 -- 91
   ;;, "sonicbom", T_NORMAL,   20, -1,  .9  -- 92
   ;;, "disable",  T_NORMAL,   20, 0,   1   -- 93
   ;;, "acid",     T_POISON,   30, 40,  1   -- 94
   ;;, "ember",    T_FIRE,     25, 40,  1   -- 95
   ;;, "flamthwr", T_FIRE,     15, 90,  1   -- 96
   ;;, "mist",     T_ICE,      30, 0,   0   -- 97
   ;;, "hydropmp", T_WATER,    5,  110, .8  -- 98
   ;;, "psybeam",  T_PSYCHIC,  20, 65,  1   -- 99
   ;;, "aurorabm", T_ICE,      20, 65,  1   -- 100
   ;;, "peck",     T_FLYING,   35, 35,  1   -- 101
   ;;, "drillpck", T_FLYING,   20, 80,  1   -- 102
   ;;, "lowkick",  T_FIGHTING, 20, 0,   1   -- 103
   ;;, "absorb",   T_GRASS,    25, 20,  1   -- 104
   ;;, "leechsed", T_GRASS,    10, 0,   .9  -- 105
   ;;, "growth",   T_NORMAL,   20, 0,   0   -- 106
   ;;, "razrleaf", T_GRASS,    25, 55,  .95 -- 107
   ;;, "psnpowdr", T_POISON,   35, 0,   .75 -- 108
   ;;, "stunspor", T_GRASS,    30, 0,   .75 -- 109
   ;;, "slppowdr", T_GRASS,    15, 0,   .75 -- 110
   ;;, "petldanc", T_GRASS,    10, 120, 1   -- 111
   ;;, "strngsht", T_BUG,      40, 0,   .95 -- 112
   ;;, "firespin", T_FIRE,     15, 35,  .85 -- 113
   ;;, "thndshck", T_ELECTRIC, 30, 40,  1   -- 114
   ;;, "rockthrw", T_ROCK,     15, 50,  .9  -- 115
   ;;, "cnfusion", T_PSYCHIC,  25, 50,  1   -- 116
   ;;, "hypnosis", T_PSYCHIC,  20, 0,   .6  -- 117
   ;;, "meditate", T_PSYCHIC,  40, 0,   0   -- 118
   ;;, "agility",  T_PSYCHIC,  30, 0,   0   -- 119
   ;;, "quickatk", T_NORMAL,   30, 40,  1   -- 120
   ;;, "nghtshde", T_GHOST,    15, -1,  1   -- 121
   ;;, "screech",  T_NORMAL,   40, 0,   .85 -- 122
   ;;, "recover",  T_NORMAL,   5,  0,   0   -- 123
   ;;, "harden",   T_NORMAL,   30, 0,   0   -- 124
   ;;, "minimize", T_NORMAL,   10, 0,   0   -- 125
   ;;, "smokscrn", T_NORMAL,   20, 0,   1   -- 126
   ;;, "cnfusray", T_GHOST,    10, 0,   1   -- 127
   ;;, "withdraw", T_WATER,    40, 0,   0   -- 128
   ;;, "dfnscurl", T_NORMAL,   40, 0,   0   -- 129
   ;;, "barrier",  T_PSYCHIC,  20, 0,   0   -- 130
   ;;, "lghtscrn", T_PSYCHIC,  30, 0,   0   -- 131
   ;;, "haze",     T_ICE,      30, 0,   0   -- 132
   ;;, "fcsenrgy", T_NORMAL,   30, 0,   0   -- 133
   ;;, "mirrmove", T_FLYING,   20, -1,  0   -- 134
   ;;, "lick",     T_GHOST,    30, 30,  1   -- 135
   ;;, "smog",     T_POISON,   20, 30,  .7  -- 136
   ;;, "sludge",   T_POISON,   20, 65,  1   -- 137
   ;;, "boneclub", T_GROUND,   20, 65,  .85 -- 138
   ;;, "waterfal", T_WATER,    15, 80,  1   -- 139
   ;;, "clamp",    T_WATER,    15, 35,  .85 -- 140
   ;;, "spikcann", T_NORMAL,   15, 20,  1   -- 141
   ;;, "constrct", T_NORMAL,   35, 10,  1   -- 142
   ;;, "amnesia",  T_PSYCHIC,  20, 0,   0   -- 143
   ;;, "kinesis",  T_PSYCHIC,  15, 0,   .8  -- 144
   ;;, "hijmpkck", T_FIGHTING, 10, 130, .9  -- 145
   ;;, "glare",    T_NORMAL,   30, 0,   1   -- 146
   ;;, "psngas",   T_POISON,   40, 0,   .9  -- 147
   ;;, "barrage",  T_NORMAL,   20, 15,  .85 -- 148
   ;;, "leechlif", T_BUG,      10, 80,  1   -- 149
   ;;, "lovekiss", T_NORMAL,   10, 0,   .75 -- 150
   ;;, "tranform", T_NORMAL,   10, 0,   0   -- 151
   ;;, "bubble",   T_WATER,    30, 40,  1   -- 152
   ;;, "dizypnch", T_NORMAL,   10, 70,  1   -- 153
   ;;, "spore",    T_GRASS,    15, 0,   1   -- 154
   ;;, "splash",   T_NORMAL,   40, 0,   0   -- 155
   ;;, "acidarmr", T_POISON,   20, 0,   0   -- 156
   ;;, "crabhamr", T_WATER,    10, 100, .9  -- 157
   ;;, "furyswps", T_NORMAL,   15, 18,  .8  -- 158
   ;;, "bonerang", T_GROUND,   10, 50,  .9  -- 159
   ;;, "hyprfang", T_NORMAL,   15, 80,  .9  -- 160
   ;;, "sharpen",  T_NORMAL,   30, 0,   0   -- 161
   ;;, "convrson", T_NORMAL,   30, 0,   0   -- 162
   ;;, "suprfang", T_NORMAL,   10, -1,  .9  -- 163
   ;;, "slash",    T_NORMAL,   20, 70,  1   -- 164
]] $$

|[c_moves]| f_zobj[[]] $$
|[f_populate_c_moves]| function()
    for i=0,#c_moves_raw do
        local move = c_moves_raw[i]
        c_moves[i] = f_zobj([[
            name,@, type,@, pp,@, damage,@, accuracy,@, num,@
        ]],
            move[1],
            move[2],
            move[3],
            move[4],
            move[5],
            i
        )
    end
end $$


-- trainers are given moves at lvl 50
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
