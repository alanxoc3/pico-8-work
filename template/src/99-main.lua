-- overview of basic game loop:
-- * create things
-- * tick (start at 0)
-- * update
-- * destroy / delete
-- * draw

_g = G_TABLE_INITIALIZATION

zobj[[,game_state,actor|
    curr,logo;
    logo; init,%logo_init, update,%logo_update, draw,%logo_draw, duration,2.5, next,game;
    game; init,nop,        update,%game_update, draw,%game_draw;
]]

|game_update| function()
    -- loop_zobjs('actor', 'state')
end $$

|game_draw| function()
    loop_zobjs('drawable', 'draw')
end $$

function _init()
    g_tl = _g.game_state()
end

function _update60()
    register_zobjs()
    loop_zobjs('timer', 'tick')
    loop_zobjs('actor', 'state')
    loop_zobjs('actor', 'clean')
end

function _draw()
    cls()
    loop_zobjs('game_state', 'draw')
end
