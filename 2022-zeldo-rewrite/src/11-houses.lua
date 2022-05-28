|[spawn_walls]| function(a)
    zcall_tbl(_g.wall, a.walls)
    if a.walls[1][1] == a then printh("HEOEU") end
end $$

zclass[[bed,actor,simple_spr,drawlayer_50|
    sh,2, sy,-8,
    init,%spawn_walls;

    
    walls;1;,~, .75,.5,.25,.75;
    walls;2;,~,-.75,.5,.25,.75;
    walls;3;,~,    0, 0,.75,.25;
]]

zclass[[house,actor,simple_spr,drawlayer_50|
    cspr,SPR_HOUSE,
    sind,SPR_HOUSE, sw,2, sh,2,
    init,%house_init;

    walls;1;,~, .75,.5,.25,.75;
    walls;2;,~,-.75,.5,.25,.75;
    walls;3;,~,    0, 0,.75,.25;
]]

|[house_init]| function(a)
    _g.spawn_walls(a)

    zcall(_g.target, [[
        1;,.125,.375,0,.5,@,@,nop;
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

zclass[[house231,  house|x,@,y,@,room,231]]
zclass[[house224,  house|x,@,y,@,room,224]]
zclass[[house225,  house|x,@,y,@,room,225]]
zclass[[house226,  house|x,@,y,@,room,226]]
zclass[[house227,  house|x,@,y,@,room,227]]
zclass[[house228,  house|x,@,y,@,room,228]]
zclass[[house229,  house|x,@,y,@,room,229]]



zclass[[bed]]
