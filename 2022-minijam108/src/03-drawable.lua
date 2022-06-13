-- start with drawlayer_50 and divide by 2 if something needs to go forward or backward
-- max = 99, min = 00
zclass[[drawlayer_25|]] -- puddle
zclass[[drawlayer_30|]] -- enemies
zclass[[drawlayer_50|]] -- pl
zclass[[drawlayer_75|]] -- ui

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
    190;,1,1,0,3;
    189;,1,1,0,3;
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

    224;,2,2,6,8; -- fox
    226;,2,2,6,8;
    200;,2,2,6,8;
    228;,2,2,6,8;
    192;,2,2,6,8;
    196;,2,2,6,8;
    194;,2,2,6,8;
    198;,2,2,6,8;

    230;,2,2,6,8; -- frog
    76;,2,2,6,8;
    78;,2,2,6,8;
    232;,2,2,6,8;

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

g_card_namemap = zobj[[
    128,"spin",
    130,"stab",
    132,"thrust",
    134,"move",
    136,"charge",
    160,"swap",
    162,"undo",
    164,"idle",
    166,"jump";
]]

g_card_colormap = zobj[[
    128,8,
    130,8,
    132,8,
    134,11,
    136,11,
    160,10,
    162,10,
    164,10,
    166,11;
]]

g_card_colormap_outline = zobj[[
    128,2,
    130,2,
    132,2,
    134,3,
    136,3,
    160,4,
    162,4,
    164,4,
    166,3;
]]

g_icon_lookup = zobj[[
    move;    s,120, l,142;
    attack;  s,119, l,156;
    special; s,121, l,174;
    disable; s,64,  l,206;
]]

-- used everwhere
function zspr(sind, x, y, sw, sh, xf, yf)
    sw, sh = sw or 1, sh or 1
    xf, yf = xf and xf < 0, yf and yf < 0
    x, y = x-sw*4, y-sh*4
    spr(sind, flr(x+.5), flr(y+.5), sw, sh, xf, yf)
end

function print_wide_centered(text, x, y, color)
    print("\^w"..text.."\^-w", x-#text*4, y-2, color)
end
