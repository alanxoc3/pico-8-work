-- draws a sprite centered on x & y.
|[zspr]| function(sind, x, y, sw, sh, ...)
    sw, sh = sw or 1, sh or 1
    _spr(sind, x-sw*4, y-sh*4, sw, sh, ...)
end $$

-- gives a discrete random number: [0, x)
|[flr_rnd]| function(x)
    return _flr(_rnd(x))
end $$

-- gives a random value that is one of: -1, 0, 1
|[rnd_one]| function(val)
    return (flr_rnd'3'-1)*(val or 1)
end $$

|[zcall_tbl]| function(func, tbl)
    _foreach(tbl, function(params)
        func(_unpack(params))
    end)
end $$

-- used everwhere
|[zcall]| function(func, text, ...)
    zcall_tbl(func, zobj(text, ...))
end $$

|[zcls]| function(col)
   _rectfill(0x8000,0x8000,0x7fff,0x7fff,col or 0)
end $$

|[zcamera]| function(nx, ny, func)
    local ox, oy = %0x5f28, %0x5f2a
    _camera(ox-nx, oy-ny)
    func()
    _camera(ox, oy)
end $$

-- DEBUG_BEGIN
|[tostring]| function(any)
    if _type(any)~="table" then return _tostr(any) end
    local str = "{"
    local keys = {}
    for i=1,#any do
        if str~="{" then str=str.."," end
        keys[i] = true
        str=str..tostring(any[i])
    end
    local sortedkeys = {}
    for k,v in _pairs(any) do
        if not keys[k] then
            _add(sortedkeys, k)
        end
    end

    for k in _all(sortedkeys) do
        if str~="{" then str=str.."," end
        str=str..tostring(k).."="..tostring(any[k])
    end
    return str.."}"
end $$
-- DEBUG_END
