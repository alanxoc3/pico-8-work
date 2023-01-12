c_creditlist = split",,,,,,credits,,⬇️/⬆️  ,,,alanxoc3,CODE,GFX|SFX,,the,great,cadet,GFX|SFX,,wadlo,MAGIKARP,GYARADOS,,,,,code,snippets,,,,,zep,FOR PX9,& PICO-8,,mot,FOR SMAP,,,,,pokemon,data,,,,,blbapedia,,pokeapi,,serebii,,smogon,,volvox,,nintendo,OF COURSE,,,,,gotta,catch,em all,"

|[credits_update]| function(a)
    if g_bpo then a:pop() end
    if g_bu then a.credits_offset-=1/6 end
    if g_bd then a.credits_offset+=1/6 end
    a.credits_offset = a.credits_offset%#c_creditlist
end $$

|[credits_draw1]| function(a)
    rectfill(0,0,39,39,1)
    for i,txt in ipairs(c_creditlist) do
        zprint(txt, 20, (i-a.credits_offset)*6, 13, 0)
    end
end $$
