-- Draw a pokemon by number. Pokemon is centered at x & y. sw and sh can be decimals.
-- Num 1 would be bulbasaur.
g_loaded_row = 16 -- default corresponds to the top row in the "129-151.p8" file.
function draw_pkmn(num, x, y, sw, sh)
    sw = sw or 1
    sh = sh or 1

    local row = (num-1)/8\1
    local col = (num-1)%8

    if row ~= g_loaded_row then
        g_loaded_row = row
        memcpy(0x0000, 0x8000+0x400*row, 0x400)
    end

    local w, h = 16*sw, 16*sh
    sspr(col*16, 0, 16, 16, x-w/2, y-h/2, w, h)
end

function pkmn_len()
    return @S_MISSINGNO ~= 0 and 152 or 151
end

|[browse_update]| function(a)
    if g_bpu then poke(S_BROWSE_PKMN, (@S_BROWSE_PKMN-1)%pkmn_len()) end
    if g_bpd then poke(S_BROWSE_PKMN, (@S_BROWSE_PKMN+1)%pkmn_len()) end
    if g_bpo then a:load'main' end
end $$

|[browse_draw1]| function(a)
    for i=0, 38*2-1, 2 do
        line(i,0,i-38,38,0)
        line(i+1,0,i+1-38,38,0)
    end
    draw_pkmn(@S_BROWSE_PKMN+1, 10, 10)
end $$

|[browse_draw2]| function(a)

end $$

|[browse_draw3]| function(a)

end $$
