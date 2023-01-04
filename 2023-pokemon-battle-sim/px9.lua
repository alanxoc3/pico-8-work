-- px9 data compression v9
-- by zep & co.
--
-- changelog:
--
-- v9:
--  @pancelor
--  ★ redo bitstream order
--  234 tokens (but ~4% slower)
--
-- v8:
--  @pancelor
--  ★ smaller vlist initialization
--  241 tokens
--
-- v7:
--  smaller vlist_val by @felice
--  7b -> 254 tokens (fastest)
--  7a -> 247 tokens (smallest)
--
-- v6:
--  smaller vlist_val by @p01
--  -> 258 tokens
--
-- v5:
--  fixed bug found by @icegoat
--  262 tokens (the bug was caused by otherwise redundant code!)
--
-- v4:
--  @catatafish
--  ★ smaller decomp
--
--  @felice
--  ★ fix bit flush at end
--  ★ use 0.2.0 functionality
--  ★ even smaller decomp
--  ★ some code simpler/cleaner
--  ★ hey look, a changelog!
--
-- v3:
--  @felice
--  ★ smaller decomp
--
-- v2:
--  @zep
--  ★ original release
--
--[[

    features:
    ★ 273 token decompress
    ★ handles any bit size data
    ★ no manual tuning required
    ★ decent compression ratios


    ██▒ how to use ▒██

    1. compress your data

        px9_comp(source_x, source_y,
            width, height,
            destination_memory_addr,
            read_function)
               
        e.g. to compress the whole
        spritesheet to the map:
       
        px9_comp(0,0,128,128,
            0x2000, sget)

    …………………………………
    2. decompress
   
        px9_decomp(dest_x, dest_y,
            source_memory_addr,
            read_function,
            write_function)

        e.g. to decompress from map
        memory space back to the
        screen:
       
        px9_decomp(0,0,0x2000,
            pget,pset)

        …………………………………

        (see example below)

        note: only the decompress
        code (tab 1) is needed in
        your release cart after
        storing compressed data.
       
]]

function _init()

    -- test: compress from
    -- spritesheet to map, and
    -- then decomp back to screen

    cls()
    print("compressing..",5)
    flip()

    w=128 h=128
    raw_size=(w*h+1)\2 -- bytes

    ctime=stat(1)

    -- compress spritesheet to map
    -- area (0x2000) and save cart

    clen = px9_comp(
        0,0,
        w,h,
        0x2000,
        sget)

    ctime=stat(1)-ctime

    --cstore() -- save to cart

    -- show compression stats
    print("                 "..(ctime/30).." seconds",0,0)
    print("")
    print("compressed spritesheet to map",6)
    ratio=tostr(clen/raw_size*100)
    print("bytes: "
        ..clen.." / "..raw_size
        .." ("..sub(ratio,1,4).."%)"
        ,12)
    print("")
    print("press ❎ to decompress",14)

    memcpy(0x7000,0x2000,0x1000)

    -- wait for user
    repeat until btn(❎)

    print("")
    print("decompressing..",5)
    flip()

    -- save stats screen
    local cx,cy=cursor()
    local sdata={}
    for a=0x6000,0x7ffc do
        sdata[a]=peek4(a)
    end

    dtime=stat(1)

    -- decompress data from map
    -- (0x2000) to screen

    px9_decomp(0,0,0x2000,pget,pset)

    dtime=stat(1)-dtime

    -- wait for user
    repeat until btn(❎)

    -- restore stats screen
    for a,v in pairs(sdata) do
        poke4(a,v)
    end

    -- add decompression stats
    print("                 "..(dtime/30).." seconds",cx,cy-6,5)
    print("")

end

-->8
-- px9 decompress

-- x0,y0 where to draw to
-- src   compressed data address
-- vget  read function (x,y)
-- vset  write function (x,y,v)

function
    px9_decomp(x0,y0,src,vget,vset)

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
--]]

--[[ 7 tokens smaller than above
        for i,v in ipairs(l) do
            if v==val then
                add(l,deli(l,i),1)
                return
            end
        end
--]]
    end

    -- bit cache is between 8 and
    -- 15 bits long with the next
    -- bits in these positions:
    --   0b0000.12345678...
    -- (1 is the next bit in the
    --   stream, 2 is the next bit
    --   after that, etc.
    --  0 is a literal zero)
    local cache,cache_bits=0,0
    function getval(bits)
        if cache_bits<8 then
            -- cache next 8 bits
            cache_bits+=8
            cache+=@src>>cache_bits
            src+=1
        end

        -- shift requested bits up
        -- into the integer slots
        cache<<=bits
        local val=cache&0xffff
        -- remove the integer bits
        cache^^=val
        cache_bits-=bits
        return val
    end

    -- get number plus n
    function gnp(n)
        local bits=0
        repeat
            bits+=1
            local vv=getval(bits)
            n+=vv
        until vv<(1<<bits)-1
        return n
    end

    -- header

    local
        w,h_1,      -- w,h-1
        eb,el,pr,
        x,y,
        splen,
        predict
        =
        gnp"1",gnp"0",
        gnp"1",{},{},
        0,0,
        0
        --,nil

    for i=1,gnp"1" do
        add(el,getval(eb))
    end
    for y=y0,y0+h_1 do
        for x=x0,x0+w-1 do
            splen-=1

            if(splen<1) then
                splen,predict=gnp"1",not predict
            end

            local a=y>y0 and vget(x,y-1) or 0

            -- create vlist if needed
            local l=pr[a] or {unpack(el)}
            pr[a]=l

            -- grab index from stream
            -- iff predicted, always 1

            local v=l[predict and 1 or gnp"2"]

            -- update predictions
            vlist_val(l, v)
            vlist_val(el, v)

            -- set
            vset(x,y,v)
        end
    end
end

-->8
-- px9 compress

-- x0,y0 where to read from
-- w,h   image width,height
-- dest  address to store
-- vget  read function (x,y)

function
    px9_comp(x0,y0,w,h,dest,vget)

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
