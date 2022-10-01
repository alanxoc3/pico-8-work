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

function btn_helper(f, a, b)
   return f(a) and f(b) and 0 or f(a) and 0xffff or f(b) and 1 or 0
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

function zbtn(f, a) return f(a) and f(a+1) and 0 or f(a) and -1 or f(a+1) and 1 or 0 end

function xbtn() return zbtn(btn, 0) end
function ybtn() return zbtn(btn, 2) end

function zrect(x, y, rx, ry, color) rect(x-rx, y-ry, x+rx-1, y+ry-1, color) end
function scr_help_four(func, x1, y1, x2, y2, color) func(8*x1, 8*y1, 8*x2, 8*y2, color) end
function scr_zrect(...) scr_help_four(zrect, ...) end
