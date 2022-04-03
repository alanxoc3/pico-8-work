zclass[[game_state,actor|
    actor,ignore; -- remove game_state from the actor group
    curr,level_select;
    logo; init,%logo_init, update,%logo_update, draw,%logo_draw, duration,2.5, next,level_select;
    level_select; init,%level_select_init, update,%level_select_update, draw,%level_select_draw;
]]

function _init()
    g_tl = _g.game_state()
    g_fade = 0
end

function _update60()
    -- DEBUG_BEGIN
    if btnp(4) and btnp(5) then g_debug = not g_debug end
    -- DEBUG_END

    loop_zobjs('actor',      'clean') -- delete any actors that were killed, and call their "destroy" callback
    register_zobjs()                  -- register all zobs from previous game loop iteration
    loop_zobjs('timer',      'tick')  -- update the timers
    loop_zobjs('game_state', 'state') -- game state controls the different overall states in the game
end

function _draw()
    cls()
    fade(g_fade)
    loop_zobjs('game_state', 'draw')
    -- DEBUG_BEGIN
    if g_debug then rect(0, 0, 127, 127, 8) end
    -- DEBUG_END
end

zclass[[letter,model,drawable_post|
    x,@, y,@, model_template,@,
    init,%letter_init;
]]

|letter_init| function(a)
    a:model_init(a.model_template)
end $$

|level_select_init| function()
    -- [0,0] is the center of the level
    -- add player
    g_pl = _g.pl(0, 0)
    g_view = _g.view(g_pl)

    -- this view is just for stars, so they don't lose their position when the screen wraps
    g_star_view = _g.star_view(g_pl)

    _g.fader_in(1)

    g_title_screen_coord = 20
    g_title_screen_dim = g_title_screen_coord*2

    -- title
    _g.letter(-3,   -3, [[TEST_LET_R]])
    _g.letter(-1.5, -3, [[TEST_LET_E]])
    _g.letter(0,    -3, [[TEST_LET_W]])
    _g.letter(1.5,  -3, [[TEST_LET_O]])
    _g.letter(3,    -3, [[TEST_LET_B]])

    -- add planets
    _g.planet(1,3)
    g_cateroid = _g.cateroid(10, 0)

    -- add background stars
    for i=1,50 do
        _g.twinkle()
    end
end $$

|level_select_update| function()
    loop_zobjs('actor',     'state')
    loop_zobjs('view',      'match_following')
    loop_zobjs('star_view', 'match_following')

    loop_zobjs('wall', 'collide', g_zclass_entities['pl'])
    loop_zobjs('collision_circ', 'follow_anchoring')
    loop_zobjs('mov', 'mov_update')
    loop_zobjs('acc', 'acc_update')
    loop_zobjs('vec', 'vec_update')

    -- wrap the level select screen
    if g_pl.x >  g_title_screen_coord then g_pl.x -= g_title_screen_dim-1 g_view.x -= g_title_screen_dim-1 end
    if g_pl.y >  g_title_screen_coord then g_pl.y -= g_title_screen_dim-1 g_view.y -= g_title_screen_dim-1 end
    if g_pl.x < -g_title_screen_coord then g_pl.x += g_title_screen_dim-1 g_view.x += g_title_screen_dim-1 end
    if g_pl.y < -g_title_screen_coord then g_pl.y += g_title_screen_dim-1 g_view.y += g_title_screen_dim-1 end
end $$

|level_select_draw| function()
    loop_zobjs('drawable_pre', 'draw')
    loop_zobjs('drawable', 'draw')
    loop_zobjs('drawable_post', 'draw')
end $$

----------------------------------------------

zclass[[pl,actor,model,drawable|
    x,@, y,@,
    missile_ready,yes,
    init,%pl_init,
    update,%pl_update,
    hit,%pl_hit,
    collision_func,%good_collision_circ
]]

|pl_init| function(a)
    a:model_init[[PLAYER_SPACESHIP]]
end $$

|pl_update| function(a)
    if btn'4' and a.missile_ready then
        _g.missile(a.x+cos(a.ang)*.8,a.y+sin(a.ang)*.8,a.ang)
        a.missile_ready = false
        a:set_timer('missile_cooldown', 0.1, function() a.missile_ready=true end)
    end
    a.speed = -ybtn()*.01
    a.d_ang = -xbtn()*.01
end $$

|pl_hit| function(a, b, dx, dy)
    a.dx += dx
    a.dy += dy
    a:explode()
    b:explode()
end $$


zclass[[wall|]]

zclass[[cateroid,model,wall,drawable|
    x,@, y,@,
    init,%cateroid_init
]]

|cateroid_init| function(a)
    a:model_init[[CATEROID]]
    a.d_ang = .001
end $$
