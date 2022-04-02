zclass[[twinkle,actor,drawable|
    x,@,y,@,
    draw,%twinkle_draw,
    init,%twinkle_init,
]]

|twinkle_draw| function(a)
    pset(a.x, a.y, sin(time() / 10 + a.twinkle_offset) > 0.5 and 6 or 5)
end $$

|twinkle_init| function(a)
    a.twinkle_offset = rnd()
end $$
