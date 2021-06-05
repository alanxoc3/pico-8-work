create_actor([[cloud;1;pre_drawable,spr,pos,confined|
    x:@1; i:@2; u:@3;
    , tl_max_time=96;
]], function(a)
    local sinfo = rnd_item{
        {192,4,2},
        {197,4,2},
        {197,4,2},
        {197,4,2},
        {224,3,2},
        {224,3,2},
        {224,3,2},
        {224,3,2},
        {227,5,2}
    }

    a.dx = 0.015625*(flr_rnd(2)+1)

    a.xf = rnd_item{true, false}
    a.sind = sinfo[1]
    a.sw = sinfo[2]
    a.sh = sinfo[3]
    a.y = flr_rnd(2)*2+2
end)
