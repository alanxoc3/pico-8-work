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

-- fast approximate distance formula (no need for sqrt & ^2)
-- stolen from a pico-8 forum
function approx_dist(dx,dy)
    local maskx,masky=dx>>31,dy>>31
    local a0,b0=(dx+maskx)^^maskx,(dy+masky)^^masky
    if a0>b0 then
        return a0*0.9609+b0*0.3984
    end
    return b0*0.9609+a0*0.3984
end

-- thanks to https://www.lexaloffle.com/bbs/?tid=34282
-- negative colors are transparent
function draw_polygon(points, color)
    if color >= 0 then
        local xl,xr,ymin,ymax={},{},129,0xffff
        for i=1,#points,1 do
            local k, v = i, points[i]
            local p2=points[k%#points+1]
            local x1,y1,x2,y2=v.x,flr(v.y),p2.x,flr(p2.y)
            if y1>y2 then
                y1,y2,x1,x2=y2,y1,x2,x1
            end
            local d=y2-y1
            for y=y1,y2 do
                local xval=flr(x1+(x2-x1)*(d==0 and 1 or (y-y1)/d))
                xl[y],xr[y]=min(xl[y] or 32767,xval),max(xr[y] or 0x8001,xval)
            end
            ymin,ymax=min(y1,ymin),max(y2,ymax)
        end

        for y=ymin,ymax do
            rectfill(xl[y],y,xr[y],y,color)
        end
    end
end

-- call srand before this function to make the wobbliness more consistent
-- negative colors are transparent
function wobble_line(x1, y1, x3, y3, color)
    if color >= 0 then
        local x2, y2 = (x3-x1)/2+x1+flr_rnd(3)-1, (y3-y1)/2+y1+flr_rnd(3)-1
        line(x1, y1, x2, y2, color)
        line(x2, y2, x3, y3, color)
    end
end

function scr_wobble_line(x1, y1, x3, y3, color)
    wobble_line(zoomx(x1), zoomy(y1), zoomx(x2), zoomy(y2), color)
end

function scr_draw_polygon(old_points, color)
    local points = {}
    foreach(old_points, function(p)
        add(points, {x=zoomx(p.x), y=zoomy(p.y)})
    end)
    
    draw_polygon(points, color)
end

function zoom(num) return num * g_view.zoom_factor end
function zoomx(x) return zoom(x - g_view.x) + 64 end
function zoomy(y) return zoom(y - g_view.y) + 64 end

-- DEBUG_BEGIN
-- Converts anything to a string.
function tostring(any)
    if type(any)~="table" then return tostr(any) end
    local str = "{"
    for k,v in pairs(any) do
        if str~="{" then str=str.."," end
        str=str..tostring(k).."="..tostring(v)
    end
    return str.."}"
end
-- DEBUG_END
