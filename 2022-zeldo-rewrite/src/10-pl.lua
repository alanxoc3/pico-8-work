zclass[[nopause|nopause_update,nop]]
zclass[[pl,actor,mov,nopause,tilecol,drawlayer_50,outlayer_50|
    x,@,y,@,xf,@,
    sind,88,
    rx,PL_RADIUS,ry,PL_RADIUS,
    nopause_update,%pl_nopause_update,
    draw,%pl_draw,
    drawout,%pl_drawout;
    sinds;,SPR_PL_FEET_1,SPR_PL_FEET_2,SPR_PL_FEET_3
]]

|pl_nopause_update| function(a)
    if xbtn() | ybtn() ~= 0 then
        a.ang, a.speed = atan2(xbtn(), ybtn()), PL_SPEED

        if cos(a.ang) ~= 0 then
            a.xf = cos(a.ang) < 0
        end
    else
        a.speed = 0
    end

    a.sind = a.sinds[a.dx|a.dy ~= 0 and t()*12%3\1+1 or 1]
end $$

|pl_drawout| function(a)
    zspro(a.sind, a.x*8, a.y*8-2, 1, 1, a.xf)
    zspro(91, a.x*8, a.y*8-2, 1, 1, a.xf)
end $$

|pl_draw| function(a)
    zspr(a.sind, a.x*8, a.y*8-2, 1, 1, a.xf)
    zspr(91, a.x*8, a.y*8-2, 1, 1, a.xf)
end $$
