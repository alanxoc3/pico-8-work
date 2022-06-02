zclass[[spike,enemy,simple_spr,actor,drawlayer_25|
    sind,52,
    rx,.375, ry,.375,
    draw,~drawout;

    start;   next,down;
    down;    sind,52, duration,.5, next,middle1;
    middle1; sind,53, duration,.125, next,up;
    up;      pl_collide_func,%spike_pl_collide_func, sind,54, duration,.25,  next,middle2;
    middle2; pl_collide_func,nop, sind,53, duration,.125, next,down;
]]

|[spike_pl_collide_func]| function(a, pl)
    if not pl:is_active'stunned' then
        pl:start_timer('stunned', .125, nop)
        pl:hurt(1)
    end
end $$

zclass[[r1spike,spike|x,@,y,@,xf, 1;start;duration, .25;]]
zclass[[r2spike,spike|x,@,y,@,xf, 1;start;duration,.75;]]

zclass[[l1spike,spike|x,@,y,@,xf,-1;start;duration, .25;]]
zclass[[l2spike,spike|x,@,y,@,xf,-1;start;duration,.75;]]

zclass[[saveplat,box,simple_spr,actor,drawlayer_25|
    x,@, y,@, rx,.375, ry,.375,
    cname,"save", cspr,10,
    sind,40, sw,2, sh,2, draw,~drawout,

    update,%saveplat_update;
]]

|[saveplat_update]| function(a)
    if not a:outside(g_pl) then
        g_rstat_right:set(a)
    end
end $$
