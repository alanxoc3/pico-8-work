-- params: initCallback, endCallback
create_actor[[#,fader_out,act|
    =fade_time,i,e,u,@;
    :start,tl_max_time,~fade_time;
]]

--[[]] function(a)
    g_card_fade = max(a.tl_tim/a.tl_max_time*10, g_card_fade)
end)

-- params: initCallback, endCallback
ztable[[
    act,fader_in,act;
    =,fade_time,i,e,@;
    =,u,%fader_in_u;
    :,start,tl_max_time,~fade_time;
]]

--[[fader_in_u]]
function(a)
    g_card_fade = min((a.tl_max_time-a.tl_tim)/a.tl_max_time*10, g_card_fade)
end
--[[]]

