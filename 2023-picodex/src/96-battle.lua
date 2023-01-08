|[battle_update]| function(a)
    if g_bpx or g_bpo then a:load'main' end
end $$

|[battle_draw1]| function(a)
    rectfill(0,0,37,37,1)
    zprint("no",     19, 12-3, 13, 0)
    zprint("active", 19, 19-3, 13, 0)
    zprint("party",  19, 26-3, 13, 0)
end $$

|[battle_draw2]| function(a)

end $$

|[battle_draw3]| function(a)

end $$
