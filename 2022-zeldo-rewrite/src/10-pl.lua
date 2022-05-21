zclass[[pl,actor,mov,tilecol,drawlayer_50,outlayer_50|
    x,@,y,@,
    rx,.375,ry,.375,
    update,%pl_update,
    draw,%pl_draw,
    drawout,%pl_drawout
]]

|pl_update| function(a)
    if xbtn() | ybtn() ~= 0 then
        a.ang, a.speed = atan2(xbtn(), ybtn()), PL_SPEED
    else
        a.speed = 0
    end
end $$

|pl_drawout| function(a)
    zspro(88, a.x*8, a.y*8-2)
    zspro(91, a.x*8, a.y*8-2)
end $$

|pl_draw| function(a)
    zspr(88, a.x*8, a.y*8-2)
    zspr(91, a.x*8, a.y*8-2)
end $$
