--c_creditlist = split"!stats,hp 999,atk 333,def 123,spc 1021,spd 121,acc 100%,eva 100%,!major,paralyze,!minor,tranform,fly,confuse,!fin"
c_creditlist = split"110,,!alanxoc3,code,design,6,,!gr8cadet,graphics,sound,129,,!wadlo,magikarp,gyarados,123,,!snippets,zep px9,mot smap,137,,!pkmndata,blbpedia,pokeapi,serebii,smogon,upokcntr,volvox,nintendo"

|[credits_init]| function(game)
    game.menu_credits:refresh(c_creditlist, function(txt)
        if type(txt) == "number" then
            return { pkmn=txt }
        end

        local style = 1
        if sub(txt,1,1) == '!' then
            txt, style = sub(txt,2), 3
        end

        return { name=txt, style=style, hidden=txt=='' }
    end)
end $$

|[credits_update]| function(game) game.menu_credits:update(game) end $$
|[credits_draw1]|  function(game) game.menu_credits:draw1()      end $$
