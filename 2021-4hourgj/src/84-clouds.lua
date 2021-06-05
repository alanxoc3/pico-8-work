create_actor([[cloud;1;pre_drawable,spr,pos,confined|
    x:@1; i:@2; u:@3;
    , tl_max_time=96;
]], function(a)
    local sinfo = rnd_item{{192,5,2},{197,5,2},{224,3,2},{227,5,2}}

    if a.x < 8 then
        a.dx = rnd(.03)+.02
    else
        a.dx = -(rnd(.03)+.02)
    end

    a.xf = rnd_item{true, false}
    a.sind = sinfo[1]
    a.sw = sinfo[2]
    a.sh = sinfo[3]
    a.y = flr_rnd(3)*2+2
end)
