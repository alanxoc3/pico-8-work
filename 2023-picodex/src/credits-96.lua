--c_creditlist = split"!stats,hp 999,atk 333,def 123,spc 1021,spd 121,acc 100%,eva 100%,!major,paralyze,!minor,tranform,fly,confuse,!fin"
--c_creditlist = split"!stats,hp 999,atk 333,def 123,spc 1021,spd 121"
c_creditlist = split"!alanxoc3,code,design,!gr8cadet,graphics,sound,!snippets,zep px9,mot smap,!pkmndata,blbpedia,pokeapi,serebii,smogon,upokcntr,volvox,nintendo,!fin"

c_credwid = 10

|[credits_init]| function(game)
    game.menu_credits:refresh(c_creditlist, function(txt)
        local style = 3
        if sub(txt,1,1) == '!' then
            txt = sub(txt,2)
            style = 1
        end

        return { name=txt, style=style }
    end)
    game.menu_credits.c = -1
end $$

|[credits_update]| function(game)
    if g_bpo then game:pop() end
    if g_bpu then game.menu_credits.v-=1 end
    if g_bpd then game.menu_credits.v+=1 end
    game.menu_credits.v = mid(0, game.menu_credits.v, #game.menu_credits-3)
end $$

|[credits_draw1]| function(game)
    game.menu_credits:draw1()
    -- rectfill(0,0,39,39,1)

    -- zcamera(0, -game.credits_offset, function()
    --     for i,txt in ipairs(c_creditlist) do
    --         local y = (i-1)*c_credwid+5
    --         local col, col2 = 1, 13
    --         if sub(txt,1,1) == '!' then
    --             txt = sub(txt,2)
    --             -- rect(-1, y-1, 40, y+8, 5)
    --             col, col2 = 13, 6
    --         end
    --         rectfill(-1, y, 40, y+9, col2)
    --         wobble_text(txt, 20, y+2, col)
    --     end
    -- end)
end $$
