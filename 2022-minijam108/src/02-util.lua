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

function rnd_item(list)
   return list[flr_rnd(#list)+1]
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

function xbtnp() return zbtn(btnp, 0) end
function ybtnp() return zbtn(btnp, 2) end

function zsgn(num) return num == 0 and 0 or sgn(num) end

function approx_dist(dx,dy)
    local maskx,masky=dx>>31,dy>>31
    local a0,b0=(dx+maskx)^^maskx,(dy+masky)^^masky
    if a0>b0 then
        return a0*0.9609+b0*0.3984
    end
    return b0*0.9609+a0*0.3984
end
