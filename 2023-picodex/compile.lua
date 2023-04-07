-- get pixels, but not limited to the graphics data section, can go beyond.
function vget(offset, x, y)
    x = min(max(0, x), 127)\1
    y = y\1

    local val = peek(y*64+offset+x\2)
    if x%2 == 1 then return (val & 0xf0) >>> 4
    else             return (val & 0x0f) end
end

-- px9 compression
function px9_comp(x0,y0,w,h,dest,vget)
    local dest0=dest
    local bit=1
    local byte=0

    local function vlist_val(l, val)
        -- find position and move
        -- to head of the list

--[ 2-3x faster than block below
        local v,i=l[1],1
        while v!=val do
            i+=1
            v,l[i]=l[i],v
        end
        l[1]=val
        return i
--]]

--[[ 8 tokens smaller than above
        for i,v in ipairs(l) do
            if v==val then
                add(l,deli(l,i),1)
                return i
            end
        end
--]]
    end

    local cache,cache_bits=0,0
    function putbit(bval)
     cache=cache<<1|bval
     cache_bits+=1
        if cache_bits==8 then
            poke(dest,cache)
            dest+=1
            cache,cache_bits=0,0
        end
    end

    function putval(val, bits)
        for i=bits-1,0,-1 do
            putbit(val>>i&1)
        end
    end

    function putnum(val)
        local bits = 0
        repeat
            bits += 1
            local mx=(1<<bits)-1
            local vv=min(val,mx)
            putval(vv,bits)
            val -= vv
        until vv<mx
    end


    -- first_used

    local el={}
    local found={}
    local highest=0
    for y=y0,y0+h-1 do
        for x=x0,x0+w-1 do
            c=vget(x,y)
            if not found[c] then
                found[c]=true
                add(el,c)
                highest=max(highest,c)
            end
        end
    end

    -- header

    local bits=1
    while highest >= 1<<bits do
        bits+=1
    end

    putnum(w-1)
    putnum(h-1)
    putnum(bits-1)
    putnum(#el-1)
    for i=1,#el do
        putval(el[i],bits)
    end


    -- data

    local pr={} -- predictions

    local dat={}

    for y=y0,y0+h-1 do
        for x=x0,x0+w-1 do
            local v=vget(x,y)

            local a=y>y0 and vget(x,y-1) or 0

            -- create vlist if needed
            local l=pr[a] or {unpack(el)}
            pr[a]=l

            -- add to vlist
            add(dat,vlist_val(l,v))
           
            -- and to running list
            vlist_val(el, v)
        end
    end

    -- write
    -- store bit-0 as runtime len
    -- start of each run

    local nopredict
    local pos=1

    while pos <= #dat do
        -- count length
        local pos0=pos

        if nopredict then
            while dat[pos]!=1 and pos<=#dat do
                pos+=1
            end
        else
            while dat[pos]==1 and pos<=#dat do
                pos+=1
            end
        end

        local splen = pos-pos0
        putnum(splen-1)

        if nopredict then
            -- values will all be >= 2
            while pos0 < pos do
                putnum(dat[pos0]-2)
                pos0+=1
            end
        end

        nopredict=not nopredict
    end

    if cache_bits>0 then
        -- flush
        poke(dest,cache<<8-cache_bits)
        dest+=1
    end

    return dest-dest0
end


function log(logstr)
    printh(logstr or '')
    print(logstr or '')
    flip()
end

function encode_cart(message, cartname, w, h, func)
    reload(0x8000, 0x0000, 0x3000, cartname)
    log(message.." | pos: "..tostr(ENCODE_OFFSET, 0x1)) -- show numbers as hex
    ENCODE_OFFSET += px9_comp(0,0,w,h,ENCODE_OFFSET,func)
    return ENCODE_OFFSET
end

function myinit()
    ENCODE_OFFSET=12 -- this must be set to where data can start writing
    local enc_vget = function(...) return vget(0x8000, ...) end

    cls()
    memset(0x0000, 0, 0x3100)
    local write_len = 0

                                              log("gfx             | pos: 0x0000")
                                              log("gfx2/map2       | pos: 0x1000")
                                              log("map             | pos: 0x2000")
                                              log("gfx flags       | pos: 0x3000")
                                              log("song            | pos: 0x3100")
                                              log("sfx             | pos: 0x3200")
                                              log("end of cart     | pos: 0x4300")
                                              log()

    poke2(0x0000, ENCODE_OFFSET) encode_cart     ("pokemon 0-63   ", "000-063.p8", 128, 128, enc_vget)
    poke2(0x0002, ENCODE_OFFSET) encode_cart     ("pokemon 64-127 ", "064-127.p8", 128, 128, enc_vget)
    poke2(0x0004, ENCODE_OFFSET) encode_cart     ("pokemon 128-151", "128-151.p8", 128, 128, enc_vget)

    poke(0x5f56, 0xa0) -- mget points to the loaded map.
    poke2(0x0006, ENCODE_OFFSET) encode_cart     ("picodex skin   ", "128-151.p8", 32,  11,  mget)
    poke2(0x0008, ENCODE_OFFSET) encode_pkmv_data("pokemon moves  ", g_pkmn_move_data)
    poke2(0x000a, ENCODE_OFFSET) encode_trnr_data("pokemon trnrs  ", g_trainer_data)   -- 40*6  = 240

                                              log("end of compile  | pos: "..tostr(ENCODE_OFFSET, 0x1))

    -- reserve the rest for sfx. this is only 10 sfxs as of 2023-03-21.
    reload(ENCODE_OFFSET, ENCODE_OFFSET, 0x4300 - ENCODE_OFFSET, "128-151.p8")

                                              log("copy remaining  | pos: 0x4300 ")

    -- then finally save to the game cartridge.
    cstore(0x0000, 0x0000, 0x4300, "game.p8")
    log("done!")
end

-- poke a 1 byte val and increment offset
function offsetpoke(val)
    poke(ENCODE_OFFSET, val)
    ENCODE_OFFSET += 1
end

function encode_trnr_data(message, data)
    log(message.." | pos: "..tostr(ENCODE_OFFSET, 0x1)) -- show numbers as hex

    for tnum=0,39 do
        for pnum=0,5 do
            offsetpoke(data[tnum*6+pnum+1])
        end
    end
end

function strip_spaces(data)
    local newdata = ""
    for i=1,#data do
        local c = sub(data, i, i)
        if c ~= " " then
            newdata = newdata..c
        end
    end
    return newdata
end

EVENT = 252 -- is event
TMHM  = 253 -- is tm/hm
DASH  = 254 -- is a dash/range
NEXT  = 255 -- is next pokemon
function encode_pkmv_data(message, data)
    log(message.." | pos: "..tostr(ENCODE_OFFSET, 0x1)) -- show numbers as hex

    local newdata = strip_spaces(data)

    newdata = split(newdata, "\n")
    for line in all(newdata) do
        if line ~= "" then
            local fields = split(line, "|")
            for field in all(fields) do
                if type(field) == "number"   then offsetpoke(field)
                elseif field == "T_NONE"     then offsetpoke(T_NONE)
                elseif field == "T_NORMAL"   then offsetpoke(T_NORMAL)
                elseif field == "T_FIRE"     then offsetpoke(T_FIRE)
                elseif field == "T_FIGHTING" then offsetpoke(T_FIGHTING)
                elseif field == "T_WATER"    then offsetpoke(T_WATER)
                elseif field == "T_POISON"   then offsetpoke(T_POISON)
                elseif field == "T_ELECTRIC" then offsetpoke(T_ELECTRIC)
                elseif field == "T_GROUND"   then offsetpoke(T_GROUND)
                elseif field == "T_GRASS"    then offsetpoke(T_GRASS)
                elseif field == "T_FLYING"   then offsetpoke(T_FLYING)
                elseif field == "T_ICE"      then offsetpoke(T_ICE)
                elseif field == "T_BUG"      then offsetpoke(T_BUG)
                elseif field == "T_PSYCHIC"  then offsetpoke(T_PSYCHIC)
                elseif field == "T_ROCK"     then offsetpoke(T_ROCK)
                elseif field == "T_DRAGON"   then offsetpoke(T_DRAGON)
                elseif field == "T_GHOST"    then offsetpoke(T_GHOST)
                elseif field == "T_BIRD"     then offsetpoke(T_BIRD)
                elseif field == "TM"         then offsetpoke(TMHM)
                elseif field == "EVENT"      then offsetpoke(EVENT)
                else
                    local range = split(field,"-")
                    offsetpoke(range[1])
                    offsetpoke(DASH)
                    offsetpoke(range[2])
                end
            end
        end
        offsetpoke(NEXT)
    end
    offsetpoke(NEXT)
end

-- BEFORE: 2699
-- AFTER: 3400 about
-- add levels
-- 164 is highest move index
-- 81 is highest level  N

-- spots 1-8 are: evol t1 t2 hp att def spd spc
-- spots 9+ are moves.
-- 1-164 ar moves
-- 252 is event
-- 253 is tm/hm
-- 254 is a dash/range
-- 255 is next pokemon

T_NONE     = 0  T_NORMAL   = 1
T_FIRE     = 2  T_FIGHTING = 3
T_WATER    = 4  T_POISON   = 5
T_ELECTRIC = 6  T_GROUND   = 7
T_GRASS    = 8  T_FLYING   = 9
T_ICE      = 10 T_BUG      = 11
T_PSYCHIC  = 12 T_ROCK     = 13
T_DRAGON   = 14 T_GHOST    = 15
T_BIRD     = 17

P_MISSINGNO   = 0   P_BULBASAUR   = 1   P_IVYSAUR     = 2   P_VENUSAUR    = 3
P_CHARMANDER  = 4   P_CHARMELEON  = 5   P_CHARIZARD   = 6   P_SQUIRTLE    = 7
P_WARTORTLE   = 8   P_BLASTOISE   = 9   P_CATERPIE    = 10  P_METAPOD     = 11
P_BUTTERFREE  = 12  P_WEEDLE      = 13  P_KAKUNA      = 14  P_BEEDRILL    = 15
P_PIDGEY      = 16  P_PIDGEOTTO   = 17  P_PIDGEOT     = 18  P_RATTATA     = 19
P_RATICATE    = 20  P_SPEAROW     = 21  P_FEAROW      = 22  P_EKANS       = 23
P_ARBOK       = 24  P_PIKACHU     = 25  P_RAICHU      = 26  P_SANDSHREW   = 27
P_SANDSLASH   = 28  P_NIDORANF    = 29  P_NIDORINA    = 30  P_NIDOQUEEN   = 31
P_NIDORANM    = 32  P_NIDORINO    = 33  P_NIDOKING    = 34  P_CLEFAIRY    = 35
P_CLEFABLE    = 36  P_VULPIX      = 37  P_NINETALES   = 38  P_JIGGLYPUFF  = 39
P_WIGGLYTUFF  = 40  P_ZUBAT       = 41  P_GOLBAT      = 42  P_ODDISH      = 43
P_GLOOM       = 44  P_VILEPLUME   = 45  P_PARAS       = 46  P_PARASECT    = 47
P_VENONAT     = 48  P_VENOMOTH    = 49  P_DIGLETT     = 50  P_DUGTRIO     = 51
P_MEOWTH      = 52  P_PERSIAN     = 53  P_PSYDUCK     = 54  P_GOLDUCK     = 55
P_MANKEY      = 56  P_PRIMEAPE    = 57  P_GROWLITHE   = 58  P_ARCANINE    = 59
P_POLIWAG     = 60  P_POLIWHIRL   = 61  P_POLIWRATH   = 62  P_ABRA        = 63
P_KADABRA     = 64  P_ALAKAZAM    = 65  P_MACHOP      = 66  P_MACHOKE     = 67
P_MACHAMP     = 68  P_BELLSPROUT  = 69  P_WEEPINBELL  = 70  P_VICTREEBEL  = 71
P_TENTACOOL   = 72  P_TENTACRUEL  = 73  P_GEODUDE     = 74  P_GRAVELER    = 75
P_GOLEM       = 76  P_PONYTA      = 77  P_RAPIDASH    = 78  P_SLOWPOKE    = 79
P_SLOWBRO     = 80  P_MAGNEMITE   = 81  P_MAGNETON    = 82  P_FARFETCHD   = 83
P_DODUO       = 84  P_DODRIO      = 85  P_SEEL        = 86  P_DEWGONG     = 87
P_GRIMER      = 88  P_MUK         = 89  P_SHELLDER    = 90  P_CLOYSTER    = 91
P_GASTLY      = 92  P_HAUNTER     = 93  P_GENGAR      = 94  P_ONIX        = 95
P_DROWZEE     = 96  P_HYPNO       = 97  P_KRABBY      = 98  P_KINGLER     = 99
P_VOLTORB     = 100 P_ELECTRODE   = 101 P_EXEGGCUTE   = 102 P_EXEGGUTOR   = 103
P_CUBONE      = 104 P_MAROWAK     = 105 P_HITMONLEE   = 106 P_HITMONCHAN  = 107
P_LICKITUNG   = 108 P_KOFFING     = 109 P_WEEZING     = 110 P_RHYHORN     = 111
P_RHYDON      = 112 P_CHANSEY     = 113 P_TANGELA     = 114 P_KANGASKHAN  = 115
P_HORSEA      = 116 P_SEADRA      = 117 P_GOLDEEN     = 118 P_SEAKING     = 119
P_STARYU      = 120 P_STARMIE     = 121 P_MRMIME      = 122 P_SCYTHER     = 123
P_JYNX        = 124 P_ELECTABUZZ  = 125 P_MAGMAR      = 126 P_PINSIR      = 127
P_TAUROS      = 128 P_MAGIKARP    = 129 P_GYARADOS    = 130 P_LAPRAS      = 131
P_DITTO       = 132 P_EEVEE       = 133 P_VAPOREON    = 134 P_JOLTEON     = 135
P_FLAREON     = 136 P_PORYGON     = 137 P_OMANYTE     = 138 P_OMASTAR     = 139
P_KABUTO      = 140 P_KABUTOPS    = 141 P_AERODACTYL  = 142 P_SNORLAX     = 143
P_ARTICUNO    = 144 P_ZAPDOS      = 145 P_MOLTRES     = 146 P_DRATINI     = 147
P_DRAGONAIR   = 148 P_DRAGONITE   = 149 P_MEWTWO      = 150 P_MEW         = 151

g_trainer_data = {
   P_RATTATA,   P_PIDGEY,    P_CATERPIE,  P_SPEAROW,   P_WEEDLE,    P_BELLSPROUT, -- youngstr
   P_WEEDLE,    P_PARAS,     P_KAKUNA,    P_CATERPIE,  P_METAPOD,   P_PINSIR,     -- bugcatch
   P_EKANS,     P_SQUIRTLE,  P_SANDSHREW, P_CHARMANDER,P_RATTATA,   P_BULBASAUR,  -- junior
   P_GEODUDE,   P_OMANYTE,   P_CUBONE,    P_VULPIX,    P_KABUTO,    P_ONIX,       -- brock

   P_ODDISH,    P_MEOWTH,    P_CLEFAIRY,  P_NIDORANF,  P_DODUO,     P_JIGGLYPUFF, -- lass
   P_GEODUDE,   P_DIGLETT,   P_ZUBAT,     P_MACHOP,    P_PARAS,     P_GRAVELER,   -- hiker
   P_HORSEA,    P_POLIWAG,   P_SHELLDER,  P_MAGIKARP,  P_STARYU,    P_GOLDEEN,    -- swimmer
   P_STARYU,    P_SEADRA,    P_PSYDUCK,   P_SEAKING,   P_SEEL,      P_STARMIE,    -- misty

   P_GROWLITHE, P_NIDORANM,  P_DRATINI,   P_PONYTA,    P_SANDSHREW, P_EEVEE,      -- gentlman
   P_SHELLDER,  P_TENTACOOL, P_PSYDUCK,   P_POLIWAG,   P_KRABBY,    P_POLIWHIRL,  -- sailor
   P_VOLTORB,   P_ZUBAT,     P_VENONAT,   P_MAGNEMITE, P_ABRA,      P_PIKACHU,    -- rocker
   P_PIKACHU,   P_JOLTEON,   P_VOLTORB,   P_ELECTABUZZ,P_MAGNETON,  P_RAICHU,     -- ltsurge

   P_GASTLY,    P_JIGGLYPUFF,P_CUBONE,    P_CLEFAIRY,  P_HAUNTER,   P_MAROWAK,    -- channelr
   P_PIDGEOTTO, P_GRAVELER,  P_POLIWHIRL, P_RHYHORN,   P_GROWLITHE, P_GLOOM,      -- gambler
   P_BELLSPROUT,P_CHANSEY,   P_WIGGLYTUFF,P_WEEPINBELL,P_EEVEE,     P_CLEFABLE,   -- beauty
   P_PARASECT,  P_VICTREEBEL,P_EXEGGCUTE, P_BUTTERFREE,P_TANGELA,   P_VILEPLUME,  -- erika

   P_KOFFING,   P_MANKEY,    P_TENTACOOL, P_GRIMER,    P_MACHOKE,   P_TENTACRUEL, -- biker
   P_DODUO,     P_PIDGEOTTO, P_FEAROW,    P_FARFETCHD, P_DODRIO,    P_PIDGEOT,    -- birdkeep
   P_VENONAT,   P_GLOOM,     P_MRMIME,    P_DROWZEE,   P_ELECTRODE, P_SLOWPOKE,   -- juggler
   P_NIDORINA,  P_MUK,       P_WEEZING,   P_BEEDRILL,  P_NIDORINO,  P_VENOMOTH,   -- koga

   P_MACHOP,    P_MACHOKE,   P_HITMONLEE, P_MANKEY,    P_PRIMEAPE,  P_HITMONCHAN, -- blckbelt
   P_SANDSLASH, P_RATICATE,  P_ELECTRODE, P_GOLBAT,    P_WEEZING,   P_ARBOK,      -- rocket
   P_SLOWPOKE,  P_ABRA,      P_SLOWBRO,   P_DROWZEE,   P_EXEGGCUTE, P_KADABRA,    -- psychic
   P_MRMIME,    P_EXEGGUTOR, P_KADABRA,   P_JYNX,      P_HYPNO,     P_ALAKAZAM,   -- sabrina

   P_DITTO,     P_VICTREEBEL,P_GASTLY,    P_VENOMOTH,  P_HYPNO,     P_PORYGON,    -- scientst
   P_CHANSEY,   P_PINSIR,    P_ELECTABUZZ,P_SCYTHER,   P_LICKITUNG, P_GOLDUCK,    -- pkmaniac
   P_PONYTA,    P_MAGNETON,  P_PRIMEAPE,  P_FLAREON,   P_VULPIX,    P_RAPIDASH,   -- suprnerd
   P_RAPIDASH,  P_ARCANINE,  P_FLAREON,   P_NINETALES, P_GOLEM,     P_MAGMAR,     -- blaine

   P_DRAGONAIR, P_WARTORTLE, P_PARASECT,  P_CHARMELEON,P_POLIWRATH, P_IVYSAUR,    -- cooltrnr
   P_GOLDEEN,   P_TENTACRUEL,P_SEADRA,    P_SEAKING,   P_CLOYSTER,  P_KINGLER,    -- fishrman
   P_MAROWAK,   P_TAUROS,    P_SANDSLASH, P_RATICATE,  P_RHYHORN,   P_PERSIAN,    -- tamer
   P_DUGTRIO,   P_NIDOKING,  P_PERSIAN,   P_NIDOQUEEN, P_KANGASKHAN,P_RHYDON,     -- giovanni

   P_CLOYSTER,  P_JYNX,      P_VAPOREON,  P_LAPRAS,    P_SLOWBRO,   P_DEWGONG,    -- lorelei
   P_ONIX,      P_HITMONCHAN,P_OMASTAR,   P_HITMONLEE, P_GOLEM,     P_MACHAMP,    -- bruno
   P_GOLBAT,    P_MUK,       P_HAUNTER,   P_VILEPLUME, P_ARBOK,     P_GENGAR,     -- agatha
   P_GYARADOS,  P_DRAGONAIR, P_AERODACTYL,P_DRAGONITE, P_KABUTOPS,  P_SNORLAX,    -- lance

   P_PIDGEOT,   P_ALAKAZAM,  P_JOLTEON,   P_ARCANINE,  P_EXEGGUTOR, P_BLASTOISE,  -- blue
   P_GENGAR,    P_KANGASKHAN,P_CLEFABLE,  P_GYARADOS,  P_NINETALES, P_VENUSAUR,   -- green
   P_SCYTHER,   P_SNORLAX,   P_RAICHU,    P_LAPRAS,    P_DODRIO,    P_CHARIZARD,  -- red
   P_DRAGONITE, P_ZAPDOS,    P_MOLTRES,   P_ARTICUNO,  P_MEWTWO,    P_MEW         -- legendry
}

-- from missingno (0) to mew (151), these are the tms they can learn.
-- 1-50 are tms. 51-55 are hms. There shouldn't be anything higher than that.
g_pkmn_move_data =
--v t1         t2        hp  att def spd spc  learn                                    tm & event
[[0|T_BIRD    |T_NORMAL  |33 |136|0  |29 |6   |12|43                                   |TM |1-3|5|6|9-11|13|14|17|19|20|25-27|29|30|44|45|49-52
  0|T_GRASS   |T_POISON  |45 |49 |49 |45 |65  |22|105|106|107|110|108|70|79|88         |TM |3|6|8-10|20|21|31-34|44|50|51
  1|T_GRASS   |T_POISON  |60 |62 |63 |60 |80
  1|T_GRASS   |T_POISON  |80 |82 |83 |80 |100                                          |TM |15
  0|T_FIRE    |T_NONE    |39 |52 |43 |65 |50  |113|96|164|20|86|95|63|88               |TM |1|3|5|6|8-10|17-19|23|28|31-34|38-40|44|50|51|54
  1|T_FIRE    |T_NONE    |58 |64 |58 |80 |65
  1|T_FIRE    |T_FLYING  |78 |84 |78 |100|85                                           |TM |15|26|27|52
  0|T_WATER   |T_NONE    |44 |48 |65 |43 |50  |98|40|128|87|12|152|82|79               |TM |1|5|6|8-11|13|14|17-20|28|31-34|44|50|53|54
  1|T_WATER   |T_NONE    |59 |63 |80 |58 |65
  1|T_WATER   |T_NONE    |79 |83 |100|78 |85                                           |TM |15|26|27
  0|T_BUG     |T_NONE    |45 |30 |35 |45 |20  |79|112
  1|T_BUG     |T_NONE    |50 |20 |55 |30 |25  |124
  1|T_BUG     |T_FLYING  |60 |45 |50 |70 |80  |99|66|4|91|108-110|116                  |TM |2|6|9|10|15|20-22|29-34|39|44|46|50|55
  0|T_BUG     |T_POISON  |40 |35 |30 |50 |20  |112|83
  1|T_BUG     |T_POISON  |45 |25 |50 |35 |25  |124
  1|T_BUG     |T_POISON  |65 |80 |40 |75 |45  |119|85|20|84|133|78                     |TM |3|6|9|10|15|21|31-34|39|40|44|50|51
  0|T_NORMAL  |T_FLYING  |40 |45 |40 |56 |35  |134|119|67|4|120|75|66                  |TM |2|6|9|10|20|31-34|39|43|44|50|52
  1|T_NORMAL  |T_FLYING  |63 |60 |55 |71 |50
  1|T_NORMAL  |T_FLYING  |83 |80 |75 |91 |70                                           |TM |15
  0|T_NORMAL  |T_NONE    |30 |56 |35 |72 |25  |163|133|160|120|82|79                   |TM |6|8-12|14|20|24|25|28|31|32|34|39|40|44|50
  1|T_NORMAL  |T_NONE    |55 |81 |60 |97 |50                                           |TM |13|15
  0|T_NORMAL  |T_FLYING  |40 |60 |30 |70 |31  |119|102|134|78|86|101|88                |TM |2|4|6|9|10|20|31|32|34|39|43|44|50|52
  1|T_NORMAL  |T_FLYING  |65 |90 |65 |100|61                                           |TM |15
  0|T_POISON  |T_NONE    |35 |60 |44 |55 |40  |94|122|146|87|83|80|86                  |TM |6|8-10|20|21|26-28|31|32|34|40|44|48|50|54
  1|T_POISON  |T_NONE    |60 |85 |69 |80 |65                                           |TM |15
  0|T_ELECTRIC|T_NONE    |35 |55 |30 |90 |50  |131|25|119|24|39|69|120|32|45|82|114|88 |TM |1|5|6|8-10|16|17|19|20|31|33|34|40|44|50|55 |EVENT|53
  1|T_ELECTRIC|T_NONE    |60 |90 |55 |100|90                                           |TM |15|24|25|32|39
  0|T_GROUND  |T_NONE    |50 |75 |85 |40 |30  |158|39|83|164|75|63                     |TM |3|6|8-10|17|19|20|26-28|31|32|34|40|44|48|50|51|54
  1|T_GROUND  |T_NONE    |75 |100|110|65 |55                                           |TM |15
  0|T_POISON  |T_NONE    |55 |47 |52 |41 |40  |72|158|87|82|83|63|79|88                |TM |6|8-10|14|20|24|25|31-34|40|44|50
  1|T_POISON  |T_NONE    |70 |62 |67 |56 |55                                           |TM |7|11-13
  1|T_POISON  |T_GROUND  |90 |82 |87 |76 |75  |8                                       |TM |1|5|15-19|26|27|38|48|53|54
  0|T_POISON  |T_NONE    |46 |57 |40 |50 |40  |72|7|78|133|83|77|79|86                 |TM |6|8-10|14|20|24|25|31-34|40|44|50
  1|T_POISON  |T_NONE    |61 |72 |57 |65 |55                                           |TM |11-13
  1|T_POISON  |T_GROUND  |81 |92 |77 |85 |75  |81                                      |TM |1|5|7|15-19|26|27|38|48|53|54
  0|T_NORMAL  |T_NONE    |70 |45 |48 |35 |60  |131|35|58|125|129|90|56|88              |TM |1|5|6|8-14|17-20|22|24|25|29-34|38|40|44-46|49|50|54|55
  1|T_NORMAL  |T_NONE    |95 |70 |73 |60 |85                                           |TM |15
  0|T_FIRE    |T_NONE    |38 |41 |40 |65 |65  |113|96|127|89|120|82|95                 |TM |6|8-10|20|28|31-34|38-40|44|50
  1|T_FIRE    |T_NONE    |73 |76 |75 |100|100                                          |TM |15
  0|T_NORMAL  |T_NONE    |115|45 |20 |20 |25  |10|8|44|90|58|129|93|56                 |TM |1|5|6|9|11-14|17-20|22|24|25|29-34|38|40|45|46|49|50|54|55
  1|T_NORMAL  |T_NONE    |140|70 |45 |45 |50                                           |TM |8|10|15|44
  0|T_POISON  |T_FLYING  |40 |45 |35 |55 |40  |132|67|127|87|91|149                    |TM |2|4|6|9|10|20|21|31|32|34|39|44|50
  1|T_POISON  |T_FLYING  |75 |80 |70 |90 |75  |122                                     |TM |15
  0|T_GRASS   |T_POISON  |45 |50 |55 |30 |75  |22|111|94|108-110|104                   |TM |3|6|9|10|20|21|31-34|44|50|51
  1|T_GRASS   |T_POISON  |60 |65 |70 |40 |85
  1|T_GRASS   |T_POISON  |75 |80 |85 |50 |100                                          |TM |8|15|22
  0|T_BUG     |T_GRASS   |35 |70 |55 |25 |55  |106|164|154|149|109|63                  |TM |3|6|8-10|20-22|28|31-34|40|44|50|51
  1|T_BUG     |T_GRASS   |60 |95 |80 |30 |80                                           |TM |15
  0|T_BUG     |T_POISON  |60 |55 |50 |45 |40  |29|110|99|109|149|108|116|91|79|93      |TM |6|9|10|20-22|31-34|44|46|50|55
  1|T_BUG     |T_POISON  |70 |65 |60 |90 |90                                           |TM |2|4|15|30|39
  0|T_GROUND  |T_NONE    |10 |55 |25 |95 |45  |26|164|75|28|88|63                      |TM |6|8-10|20|27|31|32|34|44|48|50|51
  1|T_GROUND  |T_NONE    |35 |80 |50 |120|70                                           |TM |15
  0|T_NORMAL  |T_NONE    |40 |45 |35 |90 |40  |164|158|122|16|87|63|88                 |TM |6|8-12|20|24|25|31|32|34|39|40|44|50
  1|T_NORMAL  |T_NONE    |65 |70 |60 |115|65                                           |TM |15
  0|T_WATER   |T_NONE    |50 |52 |48 |55 |50  |98|158|116|93|82|63                     |TM |1|5|6|8-14|16-20|28|31|32|34|39|40|44|50|53|54 |EVENT|143
  1|T_WATER   |T_NONE    |80 |82 |78 |85 |80                                           |TM |15
  0|T_FIGHTING|T_NONE    |40 |80 |35 |70 |35  |122|81|19|133|158|57|103|63|86          |TM |1|5|6|8-10|16-18|20|24|25|28|31|32|34|35|39|40|44|48|50|54
  1|T_FIGHTING|T_NONE    |65 |105|60 |95 |60  |20                                      |TM |15
  0|T_FIRE    |T_NONE    |55 |70 |45 |60 |50  |96|119|9|86|95|89|87                    |TM |6|8|10|20|23|28|31-34|38-40|44|50
  1|T_FIRE    |T_NONE    |90 |110|80 |95 |80                                           |TM |15|30
  0|T_WATER   |T_NONE    |40 |50 |40 |90 |40  |98|143|8|58|12|117|152                  |TM |6|9-11|13|14|20|29|31|32|34|40|44|46|50|53
  1|T_WATER   |T_NONE    |65 |65 |65 |90 |50                                           |TM |1|5|17-19|26|27|35|54
  1|T_WATER   |T_FIGHTING|90 |85 |95 |70 |70                                           |TM |15
  0|T_PSYCHIC |T_NONE    |25 |20 |15 |90 |105 |30                                      |TM |1|5|6|8-10|17-20|29|31-35|40|44-46|49|50|55
  1|T_PSYCHIC |T_NONE    |40 |35 |30 |105|120 |33|29|144|99|123|93|116                 |TM |28
  1|T_PSYCHIC |T_NONE    |55 |50 |45 |120|135                                          |TM |15
  0|T_FIGHTING|T_NONE    |70 |80 |50 |35 |35  |17|19|133|103|86|57                     |TM |1|5|6|8-10|18|20|26-28|31|32|34|35|38|40|44|48|50|54
  1|T_FIGHTING|T_NONE    |80 |100|70 |45 |50
  1|T_FIGHTING|T_NONE    |90 |130|80 |55 |65                                           |TM |15
  0|T_GRASS   |T_POISON  |50 |75 |35 |40 |70  |69|107|94|109|110|108|80|70|106         |TM |3|6|9|10|20-22|31-34|44|50|51
  1|T_GRASS   |T_POISON  |65 |90 |50 |55 |85
  1|T_GRASS   |T_POISON  |80 |105|65 |70 |100                                          |TM |8|15
  0|T_WATER   |T_POISON  |40 |40 |35 |70 |100 |98|122|130|142|12|83|80|91|94           |TM |3|6|9-11|13|14|20|21|31-34|40|44|50|51|53
  1|T_WATER   |T_POISON  |80 |70 |65 |100|120                                          |TM |15
  0|T_ROCK    |T_GROUND  |40 |80 |100|20 |30  |47|26|124|115|36|129|79                 |TM |1|6|8-10|17-20|27|28|31|32|34|35|38|44|48|50|54
  1|T_ROCK    |T_GROUND  |55 |95 |115|35 |45
  1|T_ROCK    |T_GROUND  |80 |110|130|45 |55                                           |TM |5|15
  0|T_FIRE    |T_NONE    |50 |85 |55 |90 |65  |119|9|113|88|71|82|95                   |TM |6-8|10|20|31-34|38-40|44|50
  1|T_FIRE    |T_NONE    |65 |100|70 |105|80                                           |TM |15
  0|T_WATER   |T_PSYCHIC |90 |65 |65 |15 |40  |29|143|12|88|76|93|116                  |TM |6|8-11|13|14|16|20|26-28|30-34|38-40|44-46|49|50|53-55
  1|T_WATER   |T_PSYCHIC |95 |75 |110|30 |80  |128                                     |TM |1|5|15|17-19
  0|T_ELECTRIC|T_NONE    |25 |35 |70 |45 |95  |122|39|45|91|114|92|79                  |TM |6|9|10|20|24|25|30-34|44|50|55
  1|T_ELECTRIC|T_NONE    |50 |60 |95 |70 |120                                          |TM |15
  0|T_NORMAL  |T_FLYING  |52 |65 |55 |60 |58  |164|119|3|78|86|75|101                  |TM |2|4|6|8-10|20|31-34|39|40|44|50-52
  0|T_NORMAL  |T_FLYING  |35 |85 |45 |75 |35  |119|49|20|102|78|88|101                 |TM |4|6|8-10|31-34|40|43|44|50|52
  1|T_NORMAL  |T_FLYING  |60 |110|70 |100|60                                           |TM |15
  0|T_WATER   |T_NONE    |65 |45 |55 |45 |70  |13|9|44|100|88|76                       |TM |6-8|10-12|14|16|20|31|32|34|40|50|53|54
  1|T_WATER   |T_ICE     |90 |70 |80 |70 |95                                           |TM |15
  0|T_POISON  |T_NONE    |80 |80 |50 |25 |40  |156|122|124|137|125|147|56|93           |TM |6|8|20|21|24|25|31|32|34|36|38|44|47|50
  1|T_POISON  |T_NONE    |105|105|75 |50 |65                                           |TM |15
  0|T_WATER   |T_NONE    |30 |65 |100|40 |45  |13|86|100|140|91|128|79                 |TM |6|9-12|14|20|30-34|36|39|44|47|49|50|53
  1|T_WATER   |T_ICE     |50 |95 |180|70 |85  |141                                     |TM |13|15
  0|T_GHOST   |T_POISON  |30 |35 |30 |80 |100 |42|117|121|135|127                      |TM |6|20|21|24|25|29|31|32|34|36|44|46|47|50
  1|T_GHOST   |T_POISON  |45 |50 |45 |95 |115
  1|T_GHOST   |T_POISON  |60 |65 |60 |110|130                                          |TM |1|5|8-10|15|17-19|35|40|54
  0|T_ROCK    |T_GROUND  |35 |45 |160|70 |30  |124|69|20|115|68|79|122                 |TM |6|8-10|26-28|31|32|34|36|40|44|47|48|50|54
  0|T_PSYCHIC |T_NONE    |60 |48 |45 |42 |90  |118|29|147|76|116|93|56|117             |TM |1|5|6|8-10|17-20|30-35|40|42|44-46|49|50|55
  1|T_PSYCHIC |T_NONE    |85 |73 |70 |67 |115                                          |TM |15
  0|T_WATER   |T_NONE    |30 |105|90 |50 |25  |124|157|71|65|64|86|152                 |TM |3|6|8-14|20|31|32|34|44|50|51|53|54
  1|T_WATER   |T_NONE    |55 |130|115|75 |50                                           |TM |15
  0|T_ELECTRIC|T_NONE    |40 |30 |50 |100|55  |47|39|131|92|36|79|122                  |TM |6|9|20|24|25|30-34|44|45|50|55
  1|T_ELECTRIC|T_NONE    |60 |50 |70 |140|80                                           |TM |15|40
  0|T_GRASS   |T_PSYCHIC |60 |40 |80 |40 |60  |148|22|108|109|105|33|117|110           |TM |6|9|10|20|29-32|34|36|37|44|46|47|50
  1|T_GRASS   |T_PSYCHIC |95 |95 |85 |55 |125 |71                                      |TM |15|21|22|33|54
  0|T_GROUND  |T_NONE    |50 |50 |95 |35 |40  |20|159|138|133|81|86|76|82|88           |TM |1|5|6|8-14|17-19|26-28|31|32|34|38|40|44|50|54
  1|T_GROUND  |T_NONE    |60 |80 |110|45 |50                                           |TM |15
  0|T_FIGHTING|T_NONE    |50 |120|53 |87 |35  |5|145|133|73|74|118|72                  |TM |1|6|8-10|17-20|31|32|34|35|39|40|44|50|54
  0|T_FIGHTING|T_NONE    |50 |105|79 |76 |35  |18|1|59-62|119                          |TM |5|6|8-10|17|19|20|31|32|34|35|39|40|44|50|54
  0|T_NORMAL  |T_NONE    |90 |55 |75 |30 |60  |122|69|129|71|93|80|91                  |TM |1|3|5|6|8-15|17-20|24-27|31|32|34|38|40|44|50|51|53|54
  0|T_POISON  |T_NONE    |40 |65 |95 |35 |60  |47|132|126|137|36|79|136                |TM |6|20|24|25|31|32|34|38|44|50
  1|T_POISON  |T_NONE    |65 |90 |120|60 |85                                           |TM |15
  0|T_GROUND  |T_ROCK    |80 |85 |95 |25 |30  |9|86|7|78|82|71|77                      |TM |6|8|10|20|24-28|31|32|34|38|40|44|48|50|54
  1|T_GROUND  |T_ROCK    |105|130|120|40 |45                                           |TM |1|5|11-19|53
  0|T_NORMAL  |T_NONE    |250|5  |5  |50 |105 |10|131|129|58|125|88|90|82|56           |TM |1|5|6|8|9|11-15|17-20|22|24|25|29-35|37|38|40|41|44-46|49|50|54|55
  0|T_GRASS   |T_NONE    |65 |55 |115|60 |100 |106|69|70|108-110|104|68|142            |TM |3|6|8-10|15|20-22|31|32|34|40|44|50|51
  0|T_NORMAL  |T_NONE    |105|95 |80 |90 |40  |153|86|1|82|87|20|59                    |TM |5|6|8-15|17-19|24-27|31|32|34|38|40|44|48|50|53|54
  0|T_WATER   |T_NONE    |30 |40 |70 |60 |70  |98|119|12|86|126|152                    |TM |6|9-11|13|14|20|31|32|34|39|40|44|50|53
  1|T_WATER   |T_NONE    |55 |65 |95 |85 |95                                           |TM |15
  0|T_WATER   |T_NONE    |45 |67 |60 |63 |50  |119|7|139|78|77|91|82|101               |TM |6|9-14|20|31|32|34|39|40|44|50|53
  1|T_WATER   |T_NONE    |80 |92 |65 |68 |80                                           |TM |15
  0|T_WATER   |T_NONE    |30 |45 |55 |85 |70  |98|131|125|39|123|124|12|79             |TM |6|9-11|13|14|20|24|25|29-34|40|44-46|49|50|53|55
  1|T_WATER   |T_PSYCHIC |60 |75 |85 |115|100                                          |TM |15|39
  0|T_PSYCHIC |T_NONE    |40 |45 |65 |90 |100 |50|118|58|116|131|130                   |TM |1|5|6|8-10|15|17-20|22|24|25|29-35|40|44-46|55
  0|T_BUG     |T_FLYING  |70 |110|80 |105|55  |67|119|3|164|32|133|86|120              |TM |6|9|10|15|20|31|34|39|40|44|50|51
  0|T_ICE     |T_PSYCHIC |65 |50 |35 |95 |95  |14|81|150|61|8|58|135|56                |TM |1|5|6|9-13|15|17-20|29-35|40|44|46|50
  0|T_ELECTRIC|T_NONE    |65 |83 |57 |105|85  |25|131|62|122|114|120|86                |TM |1|5|6|8-10|15|17-20|24|29-35|39|40|44-46|50|54|55
  0|T_FIRE    |T_NONE    |65 |95 |57 |93 |85  |96|136|126|60|127|86|95                 |TM |1|5|6|8-10|15|17-20|29-32|34|35|38|40|44|46|50|54
  0|T_BUG     |T_NONE    |65 |125|100|85 |55  |3|164|124|65|133|19|68|64               |TM |6|8-10|15|17|20|31|32|34|44|50|51|54
  0|T_NORMAL  |T_NONE    |75 |100|95 |110|70  |9|20|86|71|82|79                        |TM |6-8|10|13-15|24-27|31|32|34|38|40|44|50|54
  0|T_WATER   |T_NONE    |20 |10 |55 |80 |20  |79|155
  1|T_WATER   |T_FLYING  |95 |125|79 |81 |100 |15|98|86|23|87                          |TM |6|8-14|20|24|25|31-34|38|40|44|50|53|54
  0|T_WATER   |T_ICE     |130|85 |80 |60 |95  |98|13|127|8|97|90|12|88                 |TM |6|7|9-11|14|15|20|22-25|29|31-34|40|44|46|50|53|54
  0|T_NORMAL  |T_NONE    |48 |48 |48 |48 |48  |151
  0|T_NORMAL  |T_NONE    |55 |55 |50 |55 |65  |9|87|133|82|120|88|75|79                |TM |6|8|10|20|31-34|39|40|44|50
  1|T_WATER   |T_NONE    |130|65 |60 |65 |110 |98|97|156|100|132|12                    |TM |9|11|13-15|53
  2|T_ELECTRIC|T_NONE    |65 |65 |60 |130|110 |25|85|119|45|72|114                     |TM |9|15|24|55
  3|T_FIRE    |T_NONE    |65 |130|60 |65 |110 |96|20|86|113|136|95                     |TM |9|15|38
  0|T_NORMAL  |T_NONE    |65 |60 |70 |40 |75  |49|99|161|162|119|123|79                |TM |6|9|10|13-15|20|24|25|29-34|39|40|44-46|50|55
  0|T_ROCK    |T_WATER   |35 |40 |100|35 |90  |98|141|86|77|128|12                     |TM |6|8-11|13|14|20|31-34|44|50|53
  1|T_ROCK    |T_WATER   |70 |60 |125|55 |115                                          |TM |7|15|17|19|40
  0|T_ROCK    |T_WATER   |30 |80 |90 |55 |45  |98|86|164|104|63|124                    |TM |6|8-14|20|31-34|44|50|53
  1|T_ROCK    |T_WATER   |60 |115|105|80 |70                                           |TM |2|3|5|15|17|19|40|51
  0|T_ROCK    |T_FLYING  |80 |105|65 |130|60  |15|9|87|91|67|119                       |TM |2|4|6|10|20|23|31-34|38|39|43|44|50|52
  0|T_NORMAL  |T_NONE    |160|110|65 |30 |65  |15|10|124|44|8|76|143                   |TM |1|5|6|9|11-14|16-20|22|24-27|29|31-36|38|40|46|48|50|53|54
  0|T_ICE     |T_FLYING  |90 |85 |100|85 |125 |97|119|14|13|101                        |TM |2|4|6|9-12|15|20|31-34|39|43|44|50|52
  0|T_ELECTRIC|T_FLYING  |90 |90 |85 |100|125 |131|119|25|102|114                      |TM |2|4|6|9|10|15|20|24|31-34|39|43-45|50|52|55
  0|T_FIRE    |T_FLYING  |90 |100|90 |90 |125 |43|119|86|113|101                       |TM |2|4|6|9|10|15|20|31-34|38|39|44|50|52
  0|T_DRAGON  |T_NONE    |41 |64 |45 |50 |50  |15|23|69|119|45|80|86                   |TM |6|8-14|20|24|25|31-34|38-40|44|50|53
  1|T_DRAGON  |T_NONE    |61 |84 |65 |70 |70                                           |TM |7
  1|T_DRAGON  |T_FLYING  |91 |134|95 |80 |100                                          |TM |2|54
  0|T_PSYCHIC |T_NONE    |106|110|90 |130|154 |143|97|123|29|130|39|93|116             |TM |1|5|6|8-20|22|24|25|30-36|38|40|44-46|49|50|54|55
  0|T_PSYCHIC |T_NONE    |100|100|100|100|100 |29|35|1|151|56                          |TM |2-28|30-34|36-55 ]]

myinit()
