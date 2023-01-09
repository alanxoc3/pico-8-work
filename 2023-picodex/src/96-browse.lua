function set_browse(delta)
    poke(S_BROWSE_PKMN, (@S_BROWSE_PKMN+delta)%152)
end

|[browse_update]| function(a)
    if g_bpl then set_browse'-1' end
    if g_bpr then set_browse'1'  end
    if g_bpu then set_browse'-4' end
    if g_bpd then set_browse'4'  end

    if g_bpo then a:load'main' end
    if g_bpx then sfx(flr(rnd(9))) end
end $$

|[browse_draw1]| function(a)
    for j=0,3 do
        for i=0,3 do
            draw_pkmn_out(j*4+i, i*10+5, j*10+5, 5, .375)
        end
    end

    local x, y = (@S_BROWSE_PKMN%4)*10+5, (@S_BROWSE_PKMN\4)*10+5
    if @S_BROWSE_PKMN%4 == 0 then x+=1 end
    if @S_BROWSE_PKMN%4 == 3 then x-=1 end
    if @S_BROWSE_PKMN\4 == 0 then y+=1 end
    if @S_BROWSE_PKMN\4 == 3 then y-=1 end
    rectfill(x-7-1,y-7-1,x+6+1,y+6+1,13)
    rectfill(x-6-1,y-6-1,x+5+1,y+5+1,6)
    draw_pkmn_out(@S_BROWSE_PKMN, x, y, 13, .5)
    rect    (x-7  ,y-7  ,x+6  ,y+6  ,1)
end $$

|[browse_draw2]| function(a)
    zprint(c_pokemon[@S_BROWSE_PKMN].name, 46/2, 4, 1, 0)
end $$

|[browse_draw3]| function(a)
    rectfill(0,0,46,22,13)
    rectfill(0,0,6,46,1)

    zprint(""..(c_pokemon[@S_BROWSE_PKMN].height/10).." m",  9, 3-1,  1, -1)
    zprint(""..(c_pokemon[@S_BROWSE_PKMN].width/10).." kg", 9, 9-1,  1, -1)
    -- zprint("transport", 9, 15-1,  1, -1)

    print("h", 2, 3-1, 13) --
    print("w", 2, 9-1, 13)-- 
    -- print("s", 2, 15-1, 13)-- 


    --zprint("ABCDEFGHIJKLM", 2+4, 1, 1, -1)
    --zprint("ABCDEFGHIJKLM", 2+4, 6, 1, -1)
    --zprint("ABCDEFGHIJKLM", 2+4, 11, 1, -1)
    --zprint("ABCDEFGHIJKLM", 2+4, 16, 1, -1)
end $$

-- Draw a pokemon by number. Pokemon is centered at x & y. sw and sh can be decimals.
-- Num 1 would be bulbasaur.
g_loaded_row = 16 -- default corresponds to the top row in the "129-151.p8" file.
function draw_pkmn(num, x, y, sw, sh)
    sw = sw or 1
    sh = sh or 1

    local row = num/8\1
    local col = num%8

    if row ~= g_loaded_row then
        g_loaded_row = row
        memcpy(0x0000, 0x8000+0x400*row, 0x400)
    end

    local w, h = 16*sw, 16*sh
    sspr(col*16, 0, 16, 16, x-w/2, y-h/2, w, h)
end

function draw_pkmn_out(num, x, y, col, scale_factor, outline_width)
    scale_factor = scale_factor or 1
    outline_width = outline_width or 1

    for c=1,15 do pal(c,col) end
    for i=-outline_width,outline_width,outline_width*2 do draw_pkmn(num, x-outline_width, y+i, scale_factor, scale_factor) end
    for i=-outline_width,outline_width,outline_width*2 do draw_pkmn(num, x+outline_width, y+i, scale_factor, scale_factor) end

    for c=1,15 do pal(c,1) end
    for i=-outline_width,outline_width,outline_width*2 do draw_pkmn(num, x+i, y, scale_factor, scale_factor) end
    for i=-outline_width,outline_width,outline_width*2 do draw_pkmn(num, x, y+i, scale_factor, scale_factor) end

    for c=1,15 do pal(c, c) end
    draw_pkmn(num, x, y, scale_factor, scale_factor)
end

function format_num(num)
    local str = ''..num
    for i=#str+1,3 do
        str = '0'..str
    end
    return '#'..str
end
