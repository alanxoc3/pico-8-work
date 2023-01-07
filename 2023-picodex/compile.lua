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
    printh(logstr)
    print(logstr)
    flip()
end


ENCODE_OFFSET=8
local enc_vget = function(...) return vget(0x8000, ...) end
function encode_cart(cartname, w, h, func)
    reload(0x8000, 0x0000, 0x3000, cartname)
    log("pos: "..ENCODE_OFFSET)
    ENCODE_OFFSET += px9_comp(0,0,w,h,ENCODE_OFFSET,func)
    return ENCODE_OFFSET
end

cls()
memset(0x0000, 0, 0x3100)
local write_len = 0

poke2(0x0000, ENCODE_OFFSET) encode_cart("001-064.p8", 128, 128, enc_vget)
poke2(0x0002, ENCODE_OFFSET) encode_cart("065-128.p8", 128, 128, enc_vget)
poke2(0x0004, ENCODE_OFFSET) encode_cart("129-151.p8", 128, 128, enc_vget)

poke(0x5f56, 0xa0) -- mget points to the loaded map.
poke2(0x0006, ENCODE_OFFSET) encode_cart("129-151.p8", 34,  12,  mget)
log("end: "..ENCODE_OFFSET)

-- load sound data from the 129 cartridge.
reload(0x3100, 0x3100, 0x1200, "129-151.p8")

-- then finally save to the game cartridge.
cstore(0x0000, 0x0000, 0x4300, "game.p8")
log("done!")
