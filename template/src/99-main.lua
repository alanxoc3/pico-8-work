-- TEMPLATE TOKEN COUNT: 895

zclass[[game_state,actor|
    actor,ignore; -- remove game_state from the actor group
    curr,logo;
    logo; init,%logo_init, update,%logo_update, draw,%logo_draw, duration,2.5, next,game;
    game; init,%game_init, update,%game_update, draw,%game_draw;
]]

function _init()
    g_tl = _g.game_state()
end

function _update60()
    loop_zobjs('actor',      'clean') -- delete any actors that were killed, and call their "destroy" callback
    register_zobjs()                  -- register all zobs from previous game loop iteration
    loop_zobjs('timer',      'tick')  -- update the timers
    loop_zobjs('game_state', 'state') -- game state controls the different overall states in the game
end

function _draw()
    cls()
    loop_zobjs('game_state', 'draw')
end

-- BASIC EXAMPLE FOR SIMPLE GAME BELOW:
zclass[[test_obj,actor,drawable|x,@,y,@,color,7,init,%test_init,update,%test_update,draw,%test_draw;]]
|test_init|   function(a) a.color += 1                   end $$
|test_update| function(a) a.x += xbtn() a.y += ybtn()    end $$
|test_draw|   function(a) circfill(a.x, a.y, 2, a.color) end $$

|game_init|   function() _g.test_obj(64, 64)             end $$
|game_update| function() loop_zobjs('actor', 'state')    end $$
|game_draw|   function() rect(0, 0, 127, 127, 8)
                         loop_zobjs('drawable', 'draw')  end $$
