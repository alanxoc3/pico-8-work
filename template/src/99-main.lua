_g = G_TABLE_INITIALIZATION

zactor[[,game_state,stateful|
    next,logo;
    logo; u,%logo_update, d,%logo_draw;
]]

function _init()
    g_tl = _g.game_state()
end

function _update60()
    g_tl:update()
    g_tl:tick()
end

function _draw()
    g_tl:draw()
end
