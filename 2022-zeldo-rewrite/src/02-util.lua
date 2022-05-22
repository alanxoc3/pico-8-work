-- noop
function nop() end

-- gives a discrete random number: [0, x)
function flr_rnd(x)
    return flr(rnd(x))
end

-- a random item from the list.
function rnd_item(list)
   return list[flr_rnd(#list)+1]
end

-- gives a random value that is one of: -1, 0, 1
function rnd_one(val)
    return rnd_item{-1,0,1}
end

function zbtn(f, a) return f(a) and f(a+1) and 0 or f(a) and -1 or f(a+1) and 1 or 0 end

-- draws a sprite centered on x & y.
function zspr(sind, x, y, sw, sh, ...)
    sw, sh = sw or 1, sh or 1
    x, y = x-sw*4, y-sh*4
    spr(sind, x, y, sw, sh, ...)
end

function zprint(str, x, y, align, color)
    if align == 0    then x -= #str*2
    elseif align > 0 then x -= #str*4+1 end
    print(str, x, y, color)
end

function zprinttbox(str, x, y, align, fg, bg)
    zprint(str, x, y+1, align, bg)
    zprint(str, x, y, align, fg)
end

function zprintgui(str, x, y, fg, bg, out)
    for yy=-1,2 do
        for xx=-1,1 do
            zprint(str, x+xx, y+yy, 0, out)
        end
    end
    zprinttbox(str, x, y, 0, fg, bg)
end

function zcall(func, text, ...)
    foreach(zobj(text, ...), function(params)
        func(unpack(params))
    end)
end

function zrect(x, y, rx, ry, color) rect(x-rx, y-ry, x+rx-1, y+ry-1, color) end
function scr_help_four(func, x1, y1, x2, y2, color) func(8*x1, 8*y1, 8*x2, 8*y2, color) end
function scr_line(...) scr_help_four(line, ...) end
function scr_zrect(...) scr_help_four(zrect, ...) end
function scr_pset(x, y, color) pset(8*x, 8*y, color) end
