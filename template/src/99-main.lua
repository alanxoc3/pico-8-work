_g = G_TABLE_INITIALIZATION

zactor[[,movable|
    x,64, y,64,
    move,%move_with_arrows
]]


zactor[[,ball,movable|
    radius,3, color,7,
    draw, %ball_draw,
    grow, %ball_grow
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
    g_tl = ztable[[u,%game_update, d,%logo_draw]]
    ball = _g.ball(50, 50)
end


|ball_draw| function(a)
    circ(a.x, a.y, a.radius, a.color)
end $$

|logo_draw| function(a)
   local logo_opacity = 8+cos(a.tl_tim/a.tl_max_time)*4-4

   fade(logo_opacity)
   camera(logo_opacity > 1 and rnd_one())
   zspr(108, a.x, a.y, 4, 2)
   fade'0'
   camera()
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
