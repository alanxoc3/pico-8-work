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
    -- DEBUG_BEGIN
    if btnp(4) and btn(5) then g_debug = not g_debug end
    -- DEBUG_END

    loop_zobjs('actor',      'clean') -- delete any actors that were killed, and call their "destroy" callback
    register_zobjs()                  -- register all zobs from previous game loop iteration
    loop_zobjs('timer',      'tick')  -- update the timers
    loop_zobjs('game_state', 'state') -- game state controls the different overall states in the game
end

function _draw()
    cls()
    loop_zobjs('game_state', 'draw')
    -- DEBUG_BEGIN
    if g_debug then rect(0, 0, 127, 127, 8) end
    -- DEBUG_END
end

|game_init| function()
    -- [0,0] is the center of the level
    -- add player
    g_pl = _g.pl(0, 0)
    g_view = _g.view(g_pl)

    -- add planets
    _g.planet(1,3)
    g_cateroid = _g.cateroid(10, 0)

    -- add background stars
    for i=1,50 do
        _g.twinkle()
    end
end $$

|game_update| function()
    loop_zobjs('actor', 'state')
    loop_zobjs('view', 'match_following')

    loop_zobjs('wall', 'collide', g_zclass_entities['pl'])
    loop_zobjs('collision_circ', 'follow_anchoring')
    loop_zobjs('mov', 'mov_update')
    loop_zobjs('acc', 'acc_update')
    loop_zobjs('vec', 'vec_update')
end $$

|game_draw| function()
    loop_zobjs('drawable', 'draw')
end $$

----------------------------------------------

zclass[[pl,actor,model|
    x,@, y,@,
    missile_ready,yes,
    init,%pl_init,
    update,%pl_update,
    hit,%pl_hit,
    collision_func,%good_collision_circ
]]

|pl_init| function(a)
    a:model_init[[field,1;lines;1;,9,0.5,0,-0.5,-0.3,-0.3,0,-0.5,0.3,0.5,0;collisions;1;,0,0,0.1;collisions;2;,-0.3,0,0.2;]]
end $$

|pl_update| function(a)
    if btn'4' and a.missile_ready then
        _g.missile(a.x+1,a.y+1,a.ang)
        a.missile_ready = false
        a:set_timer('missile_cooldown', 0.1, function() a.missile_ready=true end)
    end
    a.speed = -ybtn()*.01
    a.d_ang = -xbtn()*.01
end $$

|pl_hit| function(a, b, dx, dy)
    a.dx += dx
    a.dy += dy
end $$


zclass[[wall|]]

zclass[[cateroid,model,wall|
    x,@, y,@,
    init,%cateroid_init
]]

|cateroid_init| function(a)
    a:model_init[[field,2;lines;1;,7,-1.2,-0.4,-1.3,0,-1.2,0.5,-0.8,0.9,-0.4,1,0,1;lines;2;,7,1.2,-0.4,1.3,0,1.2,0.5,0.8,0.9,0.4,1,0,1;lines;3;,7,0,0.4,0.2,0.3,0.1,0.2,-0.1,0.2,-0.2,0.3,0,0.4;lines;4;,7,0,0.4,0,0.5,-0.1,0.6,-0.2,0.6;lines;5;,7,0,0.4,0,0.5,0.1,0.6,0.2,0.6;lines;6;,7,0.6,0.2,0.5,0.1,0.5,-0.1,0.6,-0.2,0.7,-0.1,0.7,0.1,0.6,0.2;lines;7;,7,-0.6,0.2,-0.5,0.1,-0.5,-0.1,-0.6,-0.2,-0.7,-0.1,-0.7,0.1,-0.6,0.2;lines;8;,7,-1,-0.6,-0.8,-0.8,-0.5,-1,-0.1,-1.1,0,-1.1;lines;9;,7,1,-0.6,0.8,-0.8,0.5,-1,0.1,-1.1,0,-1.1;lines;10;,7,-1.2,-0.5,-1.1,-1.1,-0.9,-1.5,-0.5,-1;lines;11;,7,1.2,-0.5,1.1,-1.1,0.9,-1.5,0.5,-1;lines;12;,7,0.9,-1.5,0.8,-1.2,0.8,-0.8;lines;13;,7,-0.9,-1.5,-0.8,-1.2,-0.8,-0.8;lines;14;,7,0.9,0.3,1.2,0.3;lines;15;,7,-0.9,0.3,-1.2,0.3;lines;16;,7,0.9,0.2,1.1,0;lines;17;,7,-0.9,0.2,-1.1,0;lines;18;,7,0.9,0.4,1.1,0.6;lines;19;,7,-0.9,0.4,-1.1,0.6;collisions;1;,0.3,0,1;collisions;2;,-0.3,0,1;collisions;3;,-0.8,-0.9,0.4;collisions;4;,-0.9,-1.3,0.2;collisions;5;,-0.8,-0.6,0.4;collisions;6;,0.8,-0.9,0.4;collisions;7;,0.9,-1.3,0.2;collisions;8;,0.8,-0.6,0.4;collisions;9;,0,-0.3,0.9;]]
    a.d_ang = .001
end $$
