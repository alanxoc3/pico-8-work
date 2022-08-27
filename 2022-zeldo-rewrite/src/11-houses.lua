|[spawn_walls]| function(a)
    zcall_tbl(_g.wall, a.walls)
end $$

zclass[[woodtbl   ,solid,drawlayer_50,simple_spr|x,@,y,@,rx,.375,ry,.375,draw,~drawout,sind,16]]
zclass[[greytbl   ,solid,drawlayer_50,simple_spr|x,@,y,@,rx,.375,ry,.375,draw,~drawout,sind,17]]
zclass[[soupbucket,solid,drawlayer_50,simple_spr|x,@,y,@,rx,.375,ry,.375,draw,~drawout,sind,18]]
zclass[[woodcrate ,solid,drawlayer_50,simple_spr|x,@,y,@,rx,.375,ry,.25,draw,~drawout,sind,35]]

zclass[[pot,solid,class_with_target,drawlayer_50,ma_right,simple_spr|
    x,@,y,@,
    cspr,49, cname,"pot", sind,49,
    rx,.375,ry,.375,
    trx,.5,try,.5,
    callback_touch,%pot_callback_touch
]]

|[pot_callback_touch]| function(a)
    if not _g.sign_target_with_tbox_disable_callback() then
        a:start_timer('isma', 0)
    end
end $$

zclass[[bedbot_l,actor,simple_spr,drawlayer_50|
    x,@, y,@,
    sind,55,
    init,%spawn_walls;

    walls;1;,~,     0, .25, .75, .25;
    walls;2;,~,  .625,   0, .25, .25;
    walls;3;,~, -.625, -.5, .25, 1;
]]

zclass[[bedbot_r,actor,simple_spr,drawlayer_50|
    x,@, y,@,
    sind,55,
    init,%spawn_walls;

    walls;1;,~,     0, .25, .75, .25;
    walls;2;,~, -.625,   0, .25, .25;
    walls;3;,~,  .625, -.5, .25, 1;
]]

zclass[[bedpillow,simple_spr,drawlayer_25|x,@,y,@,sind,39]]

zclass[[house,actor,simple_spr,drawlayer_50|
    cspr,SPR_HOUSE,
    sind,SPR_HOUSE, sw,2, sh,2,
    init,%house_init;

    walls;1;,~, .75, .5,.25,.375;
    walls;2;,~,-.75, .5,.25,.375;
    walls;3;,~,    0,.25,.5,.125;
]]

|[house_init]| function(a)
    _g.spawn_walls(a)

    zcall(_g.target, [[
        1;,.125,.125,0,.5,@,@,nop;
    ]], a, function()
        zcall(poke, [[
            1;,MEM_RET_ROOM_IND,@;
            2;,MEM_RET_PL_X,@;
            3;,MEM_RET_PL_Y,@;
        ]], peek'MEM_ROOM_IND',
            a.x*POS_MULTIPLIER_FOR_MEMORY,
            (a.y+1.5)*POS_MULTIPLIER_FOR_MEMORY
        )

        load_room(a.room, SMALL_ROOM_START_X, SMALL_ROOM_START_Y, g_pl.xf)
    end)
end $$

zclass[[house231,  house|x,@,y,@,xf,-1,room,231]]
zclass[[house224,  house|x,@,y,@,room,224]]
zclass[[house225,  house|x,@,y,@,xf,-1,room,225]]
zclass[[house226,  house|x,@,y,@,room,226]]
zclass[[house227,  house|x,@,y,@,room,227]]
zclass[[house228,  house|x,@,y,@,room,228]]
zclass[[house229,  house|x,@,y,@,xf,-1,room,229]]
