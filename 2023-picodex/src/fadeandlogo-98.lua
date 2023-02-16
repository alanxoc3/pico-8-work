-- x=64, y=64, i=@2, u=nf, d=@1, tl_max_time=2.5; -- logo

|[g_fade]| 1 $$

-- todo: remove the first number row (;; syntax)
|[g_fade_table]| zobj[[
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
]] $$

-- takes a percent between 0 and 1
-- 0 means no fade (regular)
-- 1 means completely black
|[fade]| function(threshold)
    for c=0,15 do
        _pal(c,g_fade_table[c][1+_flr(7*_min(1, _max(0, threshold)))],1)
    end
end $$

zclass[[fader,actor|
    ecs_exclusions;actor,yes,timer,yes;
]]

zclass[[fader_out,fader|
    start; duration,FADE_SPEED, destroyed,@, update,%fader_out_update
]]

|[fader_out_update]| function(a)
    _poke(0x5f43, 0xff)
    _g.g_fade = a:get_elapsed_percent'start'
end $$

zclass[[fader_in,fader|
    start; duration,FADE_SPEED, update,%fader_in_update
]]

|[fader_in_update]| function(a)
    _g.g_fade = 1 - a:get_elapsed_percent'start'
end $$

|[logo_init]| function() _sfx(63,1) end $$

|[logo_draw]| function(a)
    _g.g_fade = _cos(a:get_elapsed_percent'logo')+1
    _camera(g_fade > .5 and rnd_one())
    zspr(SPR_LOGO, 64, 64, SPR_LOGO_W, SPR_LOGO_H)
    _camera()
end $$
