c_creditlist = split"!alanxoc3,code,design,!gr8-cadet,graphics,sound,!wadlo,magikarp,gyarados,!snippets,zep: px9,mot: smap,!pkmn data,blbapedia,pokeapi,serebii,smogon,upokecntr,volvox,nintendo"
--c_creditlist = split"!stats,lvl: 50,atk: 333,def: 123,spc: 1021,spd: 121,hit: 999,sum: 1201"

c_credwid = 10
|[credits_update]| function(a)
    if g_bpo then a:pop() end
    if g_bpu then a.credits_offset-=10 end
    if g_bpd then a.credits_offset+=10 end
    a.credits_offset = mid(0, a.credits_offset, #c_creditlist*c_credwid-3*c_credwid)
end $$

|[credits_draw1]| function(a)
    rectfill(0,0,39,39,1)

    zcamera(0, -a.credits_offset, function()
        for i,txt in ipairs(c_creditlist) do
            local y = (i-1)*c_credwid+5
            local col, col2 = 1, 5
            if sub(txt,1,1) == '!' then
                txt = sub(txt,2)
                -- rect(-1, y-1, 40, y+8, 5)
                col, col2 = 1, 13
            end
            rectfill(-1, y, 40, y+9, col2)
            wobble_text(txt, 20, y+2, col)
        end
    end)
end $$
