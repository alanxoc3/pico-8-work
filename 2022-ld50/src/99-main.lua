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
    loop_zobjs('view', 'match_following')

    loop_zobjs('collision_circ', 'follow_anchoring')
    loop_zobjs('mov', 'mov_update')
    loop_zobjs('acc', 'acc_update')
    loop_zobjs('vec', 'vec_update')
end $$

|game_draw| function()
    -- DEBUG_BEGIN
    rect(0, 0, 127, 127, 8)
    -- DEBUG_END
    loop_zobjs('drawable', 'draw')
end $$

----------------------------------------------

zclass[[pl,actor,model|
    x,@, y,@,
    init,%pl_init,
    update,%pl_update,
]]

|pl_init| function(a)
    a.model = zobj[[lines;1;,9,0.5,0,-0.5,-0.3,-0.3,0,-0.5,0.3,0.5,0;collisions;1;,0,0,0.1;collisions;2;,-0.3,0,0.2;]]
    create_collision_circs_from_model(a, a.model)
end $$

|pl_update| function(a)
    -- a.x += xbtn()
    a.speed = -ybtn()*.01
    a.d_ang = -xbtn()*.01
    -- printh("x: "..a.x.." y: "..a.y)
end $$

function create_collision_circs_from_model(a, model)
    foreach(model.collisions or {}, function(collision)
        _g.collision_circ(a, collision[1], collision[2], collision[3])
    end)
end


