--c_creditlist = split"!stats,hp 999,atk 333,def 123,spc 1021,spd 121,acc 100%,eva 100%,!major,paralyze,!minor,tranform,fly,confuse,!fin"
c_creditlist = split"!alanxoc3,code,design,!gr8cadet,graphics,sound,!snippets,zep px9,mot smap,!pkmndata,blbpedia,pokeapi,serebii,smogon,upokcntr,volvox,nintendo,!fin"

|[credits_init]| function(game)
    game.menu_credits:refresh(c_creditlist, function(txt)
        local style = 3
        if sub(txt,1,1) == '!' then
            txt = sub(txt,2)
            style = 1
        end

        return { name=txt, style=style }
    end)
end $$

|[credits_update]| function(game) game.menu_credits:update(game) end $$
|[credits_draw1]|  function(game) game.menu_credits:draw1()      end $$
