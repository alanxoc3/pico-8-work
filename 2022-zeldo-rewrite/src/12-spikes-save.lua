zclass[[spike,enemy,simple_spr,actor,drawlayer_25|
    sind,52,
    rx,.25, ry,.25,
    sy,0,
    draw,~drawout;

    defaults; pl_collide_func,nop;
    start;   next,down;
    down;    next,middle1, sind,52, duration,.9;
    middle1; next,up,      sind,53, duration,.05;
    up;      next,middle2, sind,54, pl_collide_func,%spike_pl_collide_func, duration,.25;
    middle2; next,down,    sind,53, duration,.05;
]]

|[spike_pl_collide_func]| function(a, pl)
    pl:hurt(1)
end $$

zclass[[r1spike,spike|x,@,y,@,xf, 1;start;duration,0;]]
zclass[[r2spike,spike|x,@,y,@,xf, 1;start;duration,.625;]]

zclass[[l1spike,spike|x,@,y,@,xf,-1;start;duration,0;]]
zclass[[l2spike,spike|x,@,y,@,xf,-1;start;duration,.625;]]

zclass[[saveplat,ma_interact,box,simple_spr,actor,drawlayer_25|
    x,@, y,@, rx,.375, ry,.375,
    cname,"save", cspr,10,
    sind,40, sw,2, sh,2, draw,~drawout,

    update,%saveplat_update;
]]

|[saveplat_update]| function(a)
    if not a:outside(g_pl) and peek'MEM_ITEM_INDEX' == ITEM_IND_BANJO then
        a:start_timer('isma', .01)
    end
end $$
