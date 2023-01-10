|[fight_update]| function(a)
    if g_bpx or g_bpo then a:pop() end
end $$

|[fight_draw1]| function(a)
    rectfill(0,0,39,39,1)
    zprint("no",     20, 12-2, 13, 0)
    zprint("active", 20, 19-2, 13, 0)
    zprint("party",  20, 26-2, 13, 0)
end $$

|[fight_draw2]| function(a)

end $$

|[fight_draw3]| function(a)

end $$
