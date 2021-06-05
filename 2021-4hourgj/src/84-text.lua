create_actor([[texter;2;pre_drawable,pos,confined|
    x:@1; y:@2; d:@3; u:@4; txt:"hey there kitty";
]], function(a)
    zprint(a.txt, a.x*8, a.y*8-2*8, 0, 7, 2)
end, function(a)
    local wait = 3
        if a.tl_tim < 1*wait then a.txt = "hey there kitty"
    elseif a.tl_tim < 2*wait then a.txt = "you are in a game now"
    elseif a.tl_tim < 3*wait then a.txt = "how do you like it?"
    elseif a.tl_tim < 4*wait then a.txt = "press 🅾️ or z to jump"
    elseif a.tl_tim < 5*wait then a.txt = "press ❎ or x to meow"
    end
end)
