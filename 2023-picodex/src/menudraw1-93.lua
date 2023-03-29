-- todo: try outlining pkmn whos turn it is
-- todo: try healthbar animation (or highlighting the bar, then status change happens)
|[f_editteam_draw1]| function(game)
    f_modes_default_draw1(game)
    f_wobble_text("team #"..game:f_modes_cursor'team1'+1, 20, 27, 1)
end $$

|[f_turn_draw1]|  function(_ENV)
    local cra, p1a, p2a = cur_action.active, p1.active, p2.active
    local p1on, p2on = p1a == cra, p2a == cra
    local p1c, p2c = 11, 11 -- p1on and 6 or 1, p2on and 6 or 1
    
    -- draw gray bg for health bars
    f_zcall(_rectfill, [[
       ;,0,0, 39,6, 5
      ;;,0,33,39,39,5
    ]])

    -- draw the health bars
    f_zcall(_rectfill, [[
         ;,-1, 33, @, 41, 1
        ;;,-1, -2, @, 6,  1
    ]], _max(_ceil(p1a.hp/p1a.maxhp*40), 0)-1,
        _max(_ceil(p2a.hp/p2a.maxhp*40), 0)-1)

    -- shape the health bars, so they are kinda curvy
    f_zcall(_rectfill, [[
         ;,15, 6, 39,6, 13
        ;;,16, 5, 39,5, 13
        ;;,0,33,24,33,13
        ;;,0,34,23,34,13
    ]])

    -- print hp and major condition
    f_zcall(f_zprint, [[
         ;,@, 40, 34, 13, 1
        ;;,@, 40,27, 1,  1
        ;;,@, 2,1,  13, -1
        ;;,@, 2, 7,  1,  -1
    ]], p1a.hp, c_major_names_short[p1a.major], p2a.hp, c_major_names_short[p2a.major])

    -- draw the pkmn
    local p1s, p2s = 1, 1
    p1a:f_draw_pkmn_out(10, 25, c_menu_styles[4], p1s,  p1s, p1on)
    p2a:f_draw_pkmn_out(30, 15, c_menu_styles[4], -p2s, p2s, p2on)
end $$
