-- draws a sprite centered on x & y.
function zspr(sind, x, y, sw, sh, ...)
    sw, sh = sw or 1, sh or 1
    spr(sind, x-sw*4, y-sh*4, sw, sh, ...)
end

-- gives a discrete random number: [0, x)
function flr_rnd(x)
    return flr(rnd(x))
end

-- gives a random value that is one of: -1, 0, 1
function rnd_one(val)
    return (flr_rnd'3'-1)*(val or 1)
end

function zcall_tbl(func, tbl)
    foreach(tbl, function(params)
        func(unpack(params))
    end)
end

-- used everwhere
function zcall(func, text, ...)
    zcall_tbl(func, zobj(text, ...))
end

function zcls(col)
   rectfill(0x8000,0x8000,0x7fff,0x7fff,col or 0)
end

function zcamera(nx, ny, func)
    local ox, oy = %0x5f28, %0x5f2a
    camera(ox-nx, oy-ny)
    func()
    camera(ox, oy)
end

-- DEBUG_BEGIN
function tostring(any)
    if type(any)~="table" then return tostr(any) end
    local str = "{"
    local keys = {}
    for i=1,#any do
        if str~="{" then str=str.."," end
        keys[i] = true
        str=str..tostring(any[i])
    end
    local sortedkeys = {}
    for k,v in pairs(any) do
        if not keys[k] then
            add(sortedkeys, k)
        end
    end

    for k in all(sortedkeys) do
        if str~="{" then str=str.."," end
        str=str..tostring(k).."="..tostring(any[k])
    end
    return str.."}"
end
-- DEBUG_END
