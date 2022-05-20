zclass[[pl,actor,mov,box,drawlayer_50,outlayer_50|
    x,@,y,@,
    rx,.5,ry,.5,
    init,%pl_init,
    update,%pl_update,
    draw,%pl_draw,
    drawout,%pl_drawout
]]

|pl_init| function(a)
    _g.fairy(a)
end $$

|pl_update| function(a)
    if xbtn() | ybtn() ~= 0 then
        a.ang, a.speed = atan2(xbtn(), ybtn()), PL_SPEED
    else
        a.speed = 0
    end
end $$

|pl_drawout| function(a)
    zspro(88, a.x*8, a.y*8)
    zspro(91, a.x*8, a.y*8)
end $$

|pl_draw| function(a)
    zspr(88, a.x*8, a.y*8)
    zspr(91, a.x*8, a.y*8)
end $$
