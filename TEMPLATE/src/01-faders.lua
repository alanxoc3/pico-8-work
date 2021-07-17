-- params: initCallback, endCallback
create_actor([[fader_out;3;act,;update,|
    fade_time:@1; i:@2; e:@3; u:@4;

   tl_max_time=@1,
]], function(a)
    g_card_fade = max(a.tl_tim/a.tl_max_time*10, g_card_fade)
end)

-- params: initCallback, endCallback
create_actor([[fader_in;3;act,;update,|
   fade_time:@1; i:@2; e:@3; u:@4;

   tl_max_time=@1,
]], function(a)
    g_card_fade = min((a.tl_max_time-a.tl_tim)/a.tl_max_time*10, g_card_fade)
end)
