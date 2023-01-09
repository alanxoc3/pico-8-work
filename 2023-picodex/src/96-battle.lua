|[battle_update]| function(a)
    if g_bpx or g_bpo then a:load'main' end
end $$

|[battle_draw1]| function(a)
    rectfill(0,0,39,39,1)
    zprint("no",     20, 12-2, 13, 0)
    zprint("active", 20, 19-2, 13, 0)
    zprint("party",  20, 26-2, 13, 0)
end $$

|[battle_draw2]| function(a)

end $$

|[battle_draw3]| function(a)

end $$
