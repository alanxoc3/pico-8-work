|[f_extract_sheet]| function(index)
    f_px9_decomp(_peek2(index),
        function(...) return f_vget(0x8000+index*0x1000, ...) end,
        function(...) return f_vset(0x8000+index*0x1000, ...) end)
end $$

|[f_vget]| function(offset, x, y)
    x = _min(_max(0, x), 127)\1

    local val = _peek(y\1*64+offset+x\2)
    if x%2 == 1 then return (val & 0xf0) >>> 4
    else             return (val & 0x0f) end
end $$

|[f_vset]| function(offset, x, y, val)
    x = _min(_max(0, x), 127)\1

    local mem_coord = y\1*64+offset+x\2
    local oldval = _peek(mem_coord)

    if x%2 == 1 then _poke(mem_coord, (oldval & 0x0f) | (((val or 0) & 0x0f) << 4))
                else _poke(mem_coord, (oldval & 0xf0) | (((val or 0) & 0x0f) << 0))
    end
end $$

-- thanks to zep
|[f_px9_decomp]| function(src,f_vget,f_vset)
    local function vlist_val(l, val)
        local v,i=l[1],1
        while v!=val do
            i+=1
            v,l[i]=l[i],v
        end
        l[1]=val
    end

    local cache,cache_bits=0,0
    function getval(bits)
        if cache_bits<8 then
            cache_bits+=8
            cache+=@src>>cache_bits
            src+=1
        end

        cache<<=bits
        local val=cache&0xffff
        cache^^=val
        cache_bits-=bits
        return val
    end

    function gnp(n)
        local bits=0
        repeat
            bits+=1
            local vv=getval(bits)
            n+=vv
        until vv<(1<<bits)-1
        return n
    end

    local w,h_1, eb,el,pr, x,y, splen, predict = gnp"1",gnp"0", gnp"1",{},{}, 0,0, 0
    for i=1,gnp"1" do _add(el,getval(eb)) end
    for y=0,h_1 do
        for x=0,w-1 do
            splen-=1
            if(splen<1) then
                splen,predict=gnp"1",not predict
            end
            local a=y>0 and f_vget(x,y-1) or 0
            local l=pr[a] or {_unpack(el)}
            pr[a]=l
            local v=l[predict and 1 or gnp"2"]
            vlist_val(l, v)
            vlist_val(el, v)
            f_vset(x,y,v)
        end
    end
end $$
