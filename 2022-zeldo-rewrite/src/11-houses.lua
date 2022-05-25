zclass[[house,actor,auto_outline,drawlayer_60,outlayer_50|
    cspr,SPR_HOUSE,
    room,TEST_ROOM_INDEX,
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
        _g.fader_out(function()
            zcall(zdset, [[
                1;,MEM_RET_ROOM_IND,@;
                2;,MEM_RET_PL_X,@;
                3;,MEM_RET_PL_Y,@;
                4;,MEM_ROOM_IND,@;
                5;,MEM_PL_X,SMALL_ROOM_START_X;
                6;,MEM_PL_Y,SMALL_ROOM_START_Y;
                7;,MEM_PL_XF,@;

            ]], zdget_value'MEM_ROOM_IND',
                a.x*POS_MULTIPLIER_FOR_MEMORY,
                (a.y+1.5)*POS_MULTIPLIER_FOR_MEMORY,
                a.room,
                g_pl.xf and 1 or 0
            )

            g_state:load'room'
        end)
    end)
end $$

|house_draw| function(a)
    zspr(a.cspr, a.x*8, a.y*8, 2, 2)
end $$

zclass[[housetest,house|x,@,y,@]]
