function draw_pkmn(num, x, y, sw, sh)
    sw = sw or 1
    sh = sh or 1

    local row = (num-1)/8\1
    local col = (num-1)%8

    local w, h = 16*sw, 16*sh
    sspr(col*16, row*16, 16, 16, x-w/2, y-h/2, w, h)
end

function draw_pkmn_out(num, x, y, col, orad, prad)
    orad = orad or 1
    prad = prad or 1

    for c=1,15 do pal(c,col) end
    for i=-orad,orad,orad*2 do draw_pkmn(num, x-orad, y+i, prad, prad) end
    for i=-orad,orad,orad*2 do draw_pkmn(num, x+orad, y+i, prad, prad) end

    for c=1,15 do pal(c,1) end
    for i=-orad,orad,orad*2 do draw_pkmn(num, x+i, y, prad, prad) end
    for i=-orad,orad,orad*2 do draw_pkmn(num, x, y+i, prad, prad) end

    for c=1,15 do pal(c, c) end
    draw_pkmn(num, x, y, prad, prad)
end

local sp, of, c, r = 20, 14, 6, 6
cls(13) for i=0,c*r-1 do draw_pkmn_out(i+000+1, 00+i%r*sp+of, 00+i\r*sp+of, 5, 1, 1) end flip() extcmd("set_filename", "render1") extcmd("screen")
cls(13) for i=0,c*r-1 do draw_pkmn_out(i+c*r+1, (i>=24 and 20 or 0)+00+i%r*sp+of, 00+i\r*sp+of, 5, 1, 1) end flip() extcmd("set_filename", "render2") extcmd("screen")
