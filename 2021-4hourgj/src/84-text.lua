create_actor([[texter;2;pre_drawable,pos,confined|
    x:@1; y:@2; d:@3; u:@4; txt:"hey there kitty";
]], function(a)
    zprint(a.txt, a.x*8, a.y*8-2*8, 0, 7, 2)
end, function(a)
    local wait = 3
        if a.tl_tim <  1*wait then a.txt = "hey there kitty"
    elseif a.tl_tim <  2*wait then a.txt = "you are in a game now"
    elseif a.tl_tim <  3*wait then a.txt = "how do you like it?"
    elseif a.tl_tim <  4*wait then a.txt = "use ⬅️ and ➡️ to move"
    elseif a.tl_tim <  5*wait then a.txt = "press 🅾️ or z to jump"
    elseif a.tl_tim <  6*wait then a.txt = "press ❎ or x to meow"
    elseif a.tl_tim <  7*wait then a.txt = ""
    elseif a.tl_tim <  8*wait then a.txt = "oh"
    elseif a.tl_tim <  9*wait then a.txt = "dont fall into the water"
    elseif a.tl_tim < 10*wait then a.txt = "kittens cant swim"
    elseif a.tl_tim < 11*wait then a.txt = ""
    elseif a.tl_tim < 12*wait then a.txt = "i also forgot to mention"
    elseif a.tl_tim < 13*wait then a.txt = "this game isn't finished"
    elseif a.tl_tim < 14*wait then a.txt = "so... you win!"
    elseif a.tl_tim < 15*wait then a.txt = "congratulations"
    elseif a.tl_tim < 16*wait then a.txt = "spectacular"
    elseif a.tl_tim < 17*wait then a.txt = "goodbye for now"

    elseif a.tl_tim < 22*wait then a.txt = ""
    elseif a.tl_tim < 23*wait then a.txt = "huh?"
    elseif a.tl_tim < 24*wait then a.txt = "you're still here?"
    elseif a.tl_tim < 25*wait then a.txt = "you must be waiting"
    elseif a.tl_tim < 26*wait then a.txt = "for the credits"
    elseif a.tl_tim < 27*wait then a.txt = "@alanxoc3 = code & sfx"
    elseif a.tl_tim < 28*wait then a.txt = "@cadetthegreat = gfx"
    elseif a.tl_tim < 29*wait then a.txt = "that's it for real"
    elseif a.tl_tim < 30*wait then a.txt = "bye bye kitty"
    elseif a.tl_tim < 31*wait then a.txt = ""
    end
end)
