-- overview of basic game loop:
-- * tick (start at 0)
-- * create things
-- * update
-- * destroy / delete
-- * draw

_g = G_TABLE_INITIALIZATION

zobj[[,game_state,actor|
    next,logo;
    logo; update,%logo_update, draw,%logo_draw, duration,2.5, next,game;
    game; update,%game_update, draw,%game_draw;
]]

|game_update| function()
    loop_zobjs('actor', 'state')
end $$

|game_draw| function()
    loop_zobjs('drawable', 'draw')
end $$

function _init()
    g_tl = _g.game_state()
end

function _update60()
    loop_zobjs('timer', 'tick')
    register_zobjs()
    g_tl:state()
    loop_zobjs('actor', 'clean')
end

function _draw()
    cls()
    g_tl:draw()
end
