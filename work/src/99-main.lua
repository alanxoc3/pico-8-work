_g = ztable([[GLOBAL_KEYS]], GLOBAL_VALS)

zactor[[,movable|
    :x:64 :y:64
    :move:%move_with_arrows
]]

zactor[[,ball,movable|
    :radius:3 :color:7
    :draw: %ball_draw
    :grow: %ball_grow
]]

|move_with_arrows| function(a)
    a.x += xbtn()
    a.y += ybtn()
end $$

|ball_grow| function(a)
    if btn(4) then
        a.radius += .5
    elseif btn(5) then
        a.radius -= .5
    end
end $$

function btn_helper(f, a, b)
   return f(a) and f(b) and 0 or f(a) and 0xffff or f(b) and 1 or 0
end
function xbtn() return btn_helper(btn, 0, 1) end
function ybtn() return btn_helper(btn, 2, 3) end

function _init()
    g_tl = ztable[[:u:%game_update :d:%game_draw]]
    ball = _g.ball(50, 50)
    
end

|ball_draw| function(a)
    circ(a.x, a.y, a.radius, a.color)
end $$

|game_draw| function()
    cls()
    print("hello world", 64, 64, 8)
    ball:draw()
end $$

|game_update| function()
    ball:move()
    ball:grow()
end $$

function _update60()
    g_tl.u()
end

function _draw()
    g_tl.d()
end
