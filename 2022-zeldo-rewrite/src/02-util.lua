-- used with logo
function rnd_item(list) return list[flr_rnd(#list)+1] end
function rnd_one(val) return rnd_item{-1,0,1} end
function flr_rnd(x) return flr(rnd(x)) end

-- used with pl
function zbtn(f, a) return f(a) and f(a+1) and 0 or f(a) and -1 or f(a+1) and 1 or 0 end

-- used everwhere
function zspr(sind, x, y, sw, sh, xf, yf)
    sw, sh = sw or 1, sh or 1
    xf, yf = xf and xf < 0, yf and yf < 0
    x, y = x-sw*4, y-sh*4
    spr(sind, flr(x+.5), flr(y+.5), sw, sh, xf, yf)
end

-- used with ui
function zcamera(x, y, func)
    camera(-x, -y) func() camera()
end

-- used with title and textbox
function zprint(str, x, y, align, color)
    if align == 0    then x -= #str*2
    elseif align > 0 then x -= #str*4+1 end
    print(str, x, y, color)
end
function zprinttbox(str, x, y, align, fg, bg)
    zprint(str, x, y+1, align, bg)
    zprint(str, x, y, align, fg)
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

-- explode logic
function zrect(x, y, rx, ry, color) rect(x-rx, y-ry, x+rx-1, y+ry-1, color) end
function scr_help_four(func, x1, y1, x2, y2, color) func(8*x1, 8*y1, 8*x2, 8*y2, color) end
function scr_zrect(...) scr_help_four(zrect, ...) end

-- fairy logic
function scr_line(...) scr_help_four(line, ...) end
function scr_pset(x, y, color) pset(8*x, 8*y, color) end
