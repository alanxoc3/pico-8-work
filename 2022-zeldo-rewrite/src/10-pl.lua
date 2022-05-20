zclass[[pl,actor,mov,drawlayer_50|
    x,@,y,@,
    init,%pl_init,
    update,%pl_update,
    draw,%pl_draw
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

|pl_draw| function(a)
    zspr(88, a.x*8, a.y*8)
end $$
