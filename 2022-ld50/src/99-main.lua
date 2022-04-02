-- TEMPLATE TOKEN COUNT: 895

zclass[[game_state,actor|
    actor,ignore; -- remove game_state from the actor group
    curr,game;
    logo; init,%logo_init, update,%logo_update, draw,%logo_draw, duration,2.5, next,game;
    game; init,%game_init, update,%game_update, draw,%game_draw;
]]

function _init()
    g_tl = _g.game_state()
end

function _update60()
    register_zobjs()                  -- register all zobs from previous game loop iteration
    loop_zobjs('timer',      'tick')  -- update the timers
    loop_zobjs('game_state', 'state') -- game state controls the different overall states in the game
    loop_zobjs('actor',      'clean') -- delete any actors that were killed, and call their "destroy" callback
end

function _draw()
    cls()
    loop_zobjs('game_state', 'draw')
end

|game_init| function()
    -- [0,0] is the center of the level
    local g_pl = _g.pl(0, 0)
    g_view = _g.view(g_pl)
end $$

|game_update| function()
    loop_zobjs('actor', 'state')
    loop_zobjs('mov', 'mov_update')
    loop_zobjs('acc', 'acc_update')
    loop_zobjs('vec', 'vec_update')
    loop_zobjs('view', 'match_following')
end $$

|game_draw| function()
    rect(0, 0, 127, 127, 8)
    loop_zobjs('drawable', 'draw')
end $$

-- BASIC EXAMPLE FOR SIMPLE GAME BELOW:
zclass[[pl,actor,model|
    x,@, y,@,
    init,%pl_init,
    update,%pl_update,
]]

|pl_init| function(a)
    a.model = zobj[[lines;1;,9,0.5,0,-0.5,-0.3,-0.3,0,-0.5,0.3,0.5,0;]]
end $$

|pl_update| function(a)
    -- a.x += xbtn()
    a.speed = -ybtn()*.01
    a.ang -= xbtn()*.01
    -- printh("x: "..a.x.." y: "..a.y)
end $$
