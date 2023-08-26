function draw_pkmn(num, x, y, sw, sh)
    sw = sw or 1
    sh = sh or 1

    local row = (num-1)/8\1
    local col = (num-1)%8

    local w, h = 16*sw, 16*sh
    sspr(col*16, row*16, 16, 16, x-w/2, y-h/2, w, h)
end

g_xoff = 0
g_yoff = 0
g_meh = 0
g_scale = 1
function _update()
    if btnp(2) then g_scale += .125 end
    if btnp(3) then g_scale -= .125 end

    g_scale = min(2, max(.125, g_scale))

    if btnp(0) then g_meh = (g_meh - 1) % 4 end
    if btnp(1) then g_meh = (g_meh + 1) % 4 end

    g_xoff = g_meh % 2
    g_yoff = g_meh \ 2
end

function _draw()
    cls()
    print((g_scale*100).."%", 1, 1, 6)

    for j=0,3 do
        for i=0,3 do
            local ind  = (j+g_yoff*4)*8+(i+g_xoff*4)+1
            local gap = 16
            local offset = 64-8-16-gap-gap/2
            draw_pkmn(ind, offset+i*(16+gap), offset+j*(16+gap), g_scale, g_scale)
        end
    end
end
