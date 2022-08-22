-- x=64, y=64, i=@2, u=nf, d=@1, tl_max_time=2.5; -- logo

g_fade, g_fade_table = 1, zobj[[
0;  ,0  ,0  ,0  ,0  ,0  ,0  ,0  ,0;
1;  ,1  ,1  ,1  ,1  ,0  ,0  ,0  ,0;
2;  ,2  ,2  ,2  ,1  ,0  ,0  ,0  ,0;
3;  ,3  ,3  ,3  ,3  ,1  ,1  ,0  ,0;
4;  ,4  ,4  ,2  ,2  ,2  ,1  ,0  ,0;
5;  ,5  ,5  ,5  ,1  ,0  ,0  ,0  ,0;
6;  ,6  ,6  ,13 ,13 ,5  ,5  ,0  ,0;
7;  ,7  ,7  ,6  ,13 ,13 ,5  ,0  ,0;
8;  ,8  ,8  ,8  ,2  ,2  ,2  ,0  ,0;
9;  ,9  ,9  ,4  ,4  ,4  ,5  ,0  ,0;
10; ,10 ,10 ,9  ,4  ,4  ,5  ,0  ,0;
11; ,11 ,11 ,3  ,3  ,3  ,3  ,0  ,0;
12; ,12 ,12 ,12 ,3  ,1  ,0  ,0  ,0;
13; ,13 ,13 ,5  ,5  ,1  ,0  ,0  ,0;
14; ,14 ,14 ,13 ,4  ,2  ,2  ,0  ,0;
15; ,15 ,15 ,13 ,13 ,5  ,5  ,0  ,0;
]]

g_fade_table_gray = zobj[[
0;  ,0,  0  ;
1;  ,1,  1  ;
2;  ,2,  5  ;
3;  ,3,  13 ;
4;  ,4,  13 ;
5;  ,5,  5  ;
6;  ,6,  6  ;
7;  ,7,  7  ;
8;  ,8,  13 ;
9;  ,9,  6  ;
10; ,10, 7  ;
11; ,11, 7  ;
12; ,12, 7  ;
13; ,13, 13 ;
14; ,14, 6  ;
15; ,15, 6  ;
]]

-- 2 4 7 8 14
g_fade_table_red = zobj[[
0;  ,0,  0  ;
1;  ,1,  2  ;
2;  ,2,  2  ;
3;  ,3,  4 ;
4;  ,4,  4 ;
5;  ,5,  2  ;
6;  ,6,  4  ;
7;  ,7,  14  ;
8;  ,8,  8 ;
9;  ,9,  14  ;
10; ,10, 14  ;
11; ,11, 8  ;
12; ,12, 7  ;
13; ,13, 4 ;
14; ,14, 8  ;
15; ,15, 14  ;
]]

-- takes a percent between 0 and 1
-- 0 means no fade (regular)
-- 1 means completely black
function fade(threshold)
    for c=0,15 do
        pal(c,g_fade_table[c][1+flr(7*min(1, max(0, threshold)))],1)
    end
end

-- 0 = no fade. 1 = gray
function gray_fade(threshold)
    for c=0,15 do
        pal(c,g_fade_table_gray[c][1+threshold])
    end
end

function shade_fade()
    for c=0,15 do
        pal(c,13)
    end
end

function red_fade(threshold)
    for c=0,15 do
        pal(c,g_fade_table_red[c][1+threshold])
    end
end

zclass[[fader,actor|
    ecs_exclusions;actor,yes,timer,yes;
]]

zclass[[fader_out,fader|
    start; duration,FADE_SPEED, destroyed,@, update,%fader_out_update
]]

|[fader_out_update]| function(a)
    poke(0x5f43, 0xff)
    g_fade = a:get_elapsed_percent'start'
end $$

zclass[[fader_in,fader|
    start; duration,FADE_SPEED, update,%fader_in_update
]]

|[fader_in_update]| function(a)
    g_fade = 1 - a:get_elapsed_percent'start'
end $$

|[logo_init]| function() sfx(63, 0) end $$

|[logo_draw]| function(a)
    g_fade = cos(a:get_elapsed_percent'logo')+1
    camera(g_fade > .5 and rnd_one())
    zspr(SPR_LOGO, 64, 64, SPR_LOGO_W, SPR_LOGO_H)
    camera()
end $$
