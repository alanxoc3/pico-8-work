-- draws a sprite centered on x & y.
function zspr_helper(func, sind, x, y, sw, sh, ...)
    sw, sh = sw or 1, sh or 1
    x, y = x-sw*4, y-sh*4
    func(sind, x, y, sw, sh, ...)
end

function spro(sind, x, y, ...)
    for c=1,15 do pal(c,1) end
    for i=0,8 do spr(sind, x+i%3-1, y+i\3-1, ...) end
    pal()
end

function sprb(...) spro(...) spr(...) end

function zspr(...)   zspr_helper(spr, ...)  end -- sprite
function zspro(...)  zspr_helper(spro, ...) end -- outline
function zsprb(...)  zspr_helper(sprb, ...) end -- both

-- noop
function nop() end

-- gives a discrete random number: [0, x)
function flr_rnd(x)
    return flr(rnd(x))
end

-- gives a random value that is one of: -1, 0, 1
function rnd_one(val)
    return (flr_rnd'3'-1)*(val or 1)
end

function btn_helper(f, a, b) return f(a) and f(b) and 0 or f(a) and 0xffff or f(b) and 1 or 0 end
function xbtn() return btn_helper(btn, 0, 1) end
function ybtn() return btn_helper(btn, 2, 3) end

function zprint(str, x, y, align, color)
    if align == 0    then x -= #str*2
    elseif align > 0 then x -= #str*4+1 end
    print(str, x, y, color)
end
