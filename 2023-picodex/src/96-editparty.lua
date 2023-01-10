|[editparty_update]| function(a)
    save_party(@S_CUR_PARTY, {{num=@S_BROWSE_PKMN}})
    printh'saved party'
    if g_bpo then a:pop() end
end $$

|[editparty_draw1]| function(a)
    --get_pokemon(poks[i+1]).draw(locs[i][1], ty+locs[i][2], 13, locs[i][3]) end
end $$

|[editparty_draw2]| function(a)

end $$

|[editparty_draw3]| function(a)
    print_draw3_message("editing", "your", "party")
end $$
