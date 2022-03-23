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

function xbtn() return btn_helper(btn, 0, 1) end
function ybtn() return btn_helper(btn, 2, 3) end
