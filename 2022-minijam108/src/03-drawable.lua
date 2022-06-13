-- start with drawlayer_50 and divide by 2 if something needs to go forward or backward
-- max = 99, min = 00
zclass[[drawlayer_25|]] -- puddle
zclass[[drawlayer_30|]] -- enemies
zclass[[drawlayer_50|]] -- pl

g_spr_info = zobj[[
     0;,2,4,8,21; -- crab straight
     2;,2,4,6,10;
     4;,4,2,21,6;
    36;,4,2,10,9;

    64;,3,3,7,17; -- crab diagonal
    67;,3,3,6,7;
    70;,3,3,16,6;
    73;,3,3,17,16;

    --128;,2,2,0,0; -- cards
    --130;,2,2,0,0;
    --132;,2,2,0,0;
    --134;,2,2,0,0;
    --136;,2,2,0,0;
    --160;,2,2,0,0;
    --162;,2,2,0,0;
    --164;,2,2,0,0;
    --166;,2,2,0,0;

    142;,1,1,3,3; -- icons
    143;,1,1,3,3;
    --156;,2,2,0,0;
    --158;,2,2,0,0;

    138;,2,2,0,0; -- ground
    170;,2,2,0,0;

    40;,2,2,6,8; -- snake
    42;,2,2,6,8;
    44;,2,2,6,8;
    46;,2,2,6,8;

    08;,2,2,6,8; -- seagull
    10;,2,2,6,8;
    12;,2,2,6,8;
    14;,2,2,6,8;

    168;,2,2,6,6;
]]

function draw_outline(color, drawfunc)
    for c=1,15 do pal(c,color) end
    -- cache the old camera coords and restore them
    local ox, oy = %0x5f28, %0x5f2a
    for y=-1,1 do for x=-1,1 do
        camera(ox+x, oy+y) drawfunc()
    end end
    camera(ox, oy)
    pal()
end
