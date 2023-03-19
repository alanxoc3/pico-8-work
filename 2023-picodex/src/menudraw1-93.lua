|[f_editteam_draw1]| function(game)
    f_modes_default_draw1(game)
    f_wobble_text("team #"..game:cursor'team1'+1, 20, 27, 1)
end $$

|[f_turn_draw1]|  function(_ENV)
    local cra, p1a, p2a = cur_action.active, p1.active, p2.active
    local p1on, p2on = p1a == cra, p2a == cra
    local p1c, p2c = p1on and 6 or 1, p2on and 6 or 1
    
    -- draw gray bg for health bars
    f_zcall(_rectfill, [[
       ;,0,0, 39,6, 5
      ;;,0,33,39,39,5
    ]])

    -- draw the health bars
    f_zcall(_rectfill, [[
         ;,-1, 33, @, 41, @
        ;;,40, -2, @, 6,  @
    ]], -1+_max(_ceil(p1a.hp/p1a.maxhp*40), 0), p1c, 
        40-_max(_ceil(p2a.hp/p2a.maxhp*40), 0), p2c)

    -- shape the health bars, so they are kinda curvy
    f_zcall(_rectfill, [[
         ;,0, 6, 24,6, 13
        ;;,0, 5, 23,5, 13

        ;;,15,33,39,33,13
        ;;,16,34,39,34,13
    ]])

    -- print hp and major condition
    f_zcall(f_zprint, [[
         ;,@, 2, 34, 13, -1
        ;;,@, 41,29, @,  1

        ;;,@, 40,1, 13, 1
        ;;,@, 1, 5, @,  -1
    ]], p1a.hp, c_major_names_short[p1a.major], p1c, p2a.hp, c_major_names_short[p2a.major], p2c)

    -- draw the pkmn
    -- todo: fix the invisible party pkmn in switch screen
    -- todo: replace these draws with an actual function not on the pokemon & zcall
    p1a:draw(10, 23, 5, 1)
    p2a:draw(30, 17, 5, -1)
end $$
