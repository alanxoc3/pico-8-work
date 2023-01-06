function extract_sheet(index)
    memset(0x8000+index*0x2000, 0, 0x2000)
    px9_decomp(0, 0, peek2(index*2),
        function(...) return vget(0x8000+index*0x2000, ...) end,
        function(...) return vset(0x8000+index*0x2000, ...) end)
end

function _init()
    extract_sheet(0)
    extract_sheet(1)
    extract_sheet(2)

    -- Need the pokedex tiles to stay loaded. This starts at sprite index #96.
    memcpy(0x0000, 0xc000, 0x2000)
end

function _draw()
    cls()
    -- memcpy(0x6000, 0x0000, 0x2000)
    map(32,16,0,0,16,16)
    map(0,16,0,0,16,16)
    map(16,16,0,0,16,16)
    -- spr(0,0,0,16,16)
end

function vget(offset, x, y)
    x = min(max(0, x), 127)\1
    y = y\1

    local val = peek(y*64+offset+x\2)
    if x%2 == 1 then return (val & 0xf0) >>> 4
    else             return (val & 0x0f) end
end

function vset(offset, x, y, val)
    x = min(max(0, x), 127)\1
    y = y\1

    local mem_coord = y*64+offset+x\2
    local oldval = peek(mem_coord)

    if x%2 == 1 then poke(mem_coord, (oldval & 0x0f) | (((val or 0) & 0x0f) << 4))
                else poke(mem_coord, (oldval & 0xf0) | (((val or 0) & 0x0f) << 0))
    end
end

function px9_decomp(x0,y0,src,vget,vset)
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
