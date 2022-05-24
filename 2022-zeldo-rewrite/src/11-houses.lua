zclass[[house,actor,auto_outline,drawlayer_60,outlayer_50|
    cspr,SPR_HOUSE,
    init,%house_init,
    draw,%house_draw
]]

|house_init| function(a)
    zcall(_g.wall, [[
        a,@;
        1;,~a, .75,.5,.25,.75;
        2;,~a,-.75,.5,.25,.75;
        3;,~a,    0, 0,.75,.25;
    ]], a)

    zcall(_g.target, [[
        1;,.125,.375,0,.5,@,@,nop;
    ]], a, function()
        printh("entering "..t())
    end)
end $$

|house_draw| function(a)
    zspr(a.cspr, a.x*8, a.y*8, 2, 2)
end $$

zclass[[housetest,house|x,@,y,@]]
