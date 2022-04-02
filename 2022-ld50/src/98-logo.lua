-- x=64, y=64, i=@2, u=nf, d=@1, tl_max_time=2.5; -- logo

g_fade_table = zobj[[
0;  ,0  ,0  ,0  ,0  ,0  ,0  ,0  ,0;
1;  ,1  ,1  ,1  ,1  ,0  ,0  ,0  ,0;
2;  ,2  ,2  ,2  ,2  ,1  ,0  ,0  ,0;
3;  ,3  ,3  ,3  ,3  ,1  ,0  ,0  ,0;
4;  ,4  ,4  ,2  ,2  ,2  ,1  ,0  ,0;
5;  ,5  ,5  ,5  ,1  ,1  ,1  ,0  ,0;
6;  ,6  ,6  ,13 ,13 ,5  ,5  ,1  ,0;
7;  ,7  ,7  ,6  ,13 ,13 ,5  ,1  ,0;
8;  ,8  ,8  ,8  ,2  ,2  ,2  ,0  ,0;
9;  ,9  ,9  ,4  ,4  ,4  ,5  ,0  ,0;
10; ,10 ,10 ,9  ,4  ,4  ,5  ,5  ,0;
11; ,11 ,11 ,3  ,3  ,3  ,3  ,0  ,0;
12; ,12 ,12 ,12 ,3  ,1  ,1  ,1  ,0;
13; ,13 ,13 ,5  ,5  ,1  ,1  ,1  ,0;
14; ,14 ,14 ,13 ,4  ,2  ,2  ,1  ,0;
15; ,15 ,15 ,13 ,13 ,5  ,5  ,1  ,0;
]]

-- takes a percent between 0 and 1
-- 0 means no fade (regular)
-- 1 means completely black
function fade(threshold)
    for c=0,15 do
        pal(c,g_fade_table[c][1+flr(7*min(1, max(0, threshold)))])
    end
end

|logo_init| function() sfx'63' end $$

|logo_draw| function(a)
    -- stateful: load(state)
    -- timed_state: state_duration, state_tick, state_next=nil (end)
    local logo_opacity = cos(a:get_elapsed_percent'state')+1

    fade(logo_opacity)
    camera(logo_opacity > .5 and rnd_one())
    zspr(108, 64, 64, 4, 2)
    fade'0'
    camera()
end $$
