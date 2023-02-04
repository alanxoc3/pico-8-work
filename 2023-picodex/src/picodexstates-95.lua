-- game state funcs
|[gamefadein_init]| function(a)
    _g.fader_in()
    sfx(-2,0) -- stop the creepy logo sound from looping
end $$

-- you can factory reset when the pokedex is closed
|[closed_init]| function(a)
    menuitem(1, "factory reset", function()
        sfx(59,0)
        memset(0x5e00, 0, 0x100)
        a:start_timer('shaking', .5)
    end)
end $$

function any_btn() return g_bl or g_br or g_bu or g_bd or g_bx or g_bo end

|[closed_update]| function(a)
    -- if player 1 pressed any button, go to the next state.
    if not any_btn() and a.backbuttonheld then
        a.backbuttonheld = false
        a:load()
        menuitem(1) -- no factory reset now
    elseif any_btn() then
        a.backbuttonheld = true
        menuitem(1) -- no factory reset now
    end
end $$

|[closed_draw]| function(a)
    draw_picodex(a:is_active'shaking', -1, nop, nop, nop, a.light, a.backbuttonheld)
end $$

|[closing_draw]| function(a)
    draw_picodex(a:is_active'shaking', cos(a:get_elapsed_percent'closing'/2), nop, nop, nop)
end $$

|[light_init]| function(a)
    sfx(60,0)
end $$

|[opened_draw]| function(a)
    draw_picodex(a:is_active'shaking', 1, nop, nop, nop, a.light)
end $$

|[opening_draw]| function(a)
    draw_picodex(a:is_active'shaking', -cos(a:get_elapsed_percent'opening'/2), nop, nop, nop)
end $$

-- utility funcs

function draw_picodex(shaking, rotation, l_screen, tr_screen, br_screen, light, backbuttonheld, top_row_buttons, bot_row_buttons)
    light = light or 0

    zcamera(28-(rotation+1)*14+(shaking and flr(rnd(3)-1) or 0), 15, function()
        draw_back_panel(light)
        draw_left_flap(light >= 4, l_screen)
        draw_right_flap(light >= 4, rotation, backbuttonheld, tr_screen, br_screen, top_row_buttons, bot_row_buttons)
    end)
end

-- https://www.lexaloffle.com/bbs/?tid=38931
-- c = map, s = screen
function smap(cx,cy,cw,ch,sx,sy,sw,sh,flipx)
 -- delta
 local dx,dy=cw/sw,ch/sh

 -- apply flip
 if flipx then
  cx+=cw
  dx=-dx
 end

 -- clip
 if(sx<0)cx-=sx*dx sx=0
 if(sy<0)cy-=sy*dy sy=0
 if(sw>128)sw=128
 if(sh>128)sh=128

 -- render with tlines
 -- pick direction that results
 -- in fewest tline calls
 if sh<sw then
  -- horizontal lines
  for y=sy,sy+sh-1 do
   tline(sx,y,sx+sw-1,y,cx,cy,dx,0)
   cy+=dy
  end
 else
  -- vertical lines
  for x=sx,sx+sw-1 do
   tline(x,sy,x,sy+sh-1,cx,cy,0,dy)
   cx+=dx
  end   
 end
end

-- ! means male. ? means female. for nidoran.
function wobble_text(text, x, y, color)
    x -= #text*2

    local t1 = ""
    local t2 = ""
    for i=1,#text do
        letter = sub(text, i, i)
        if letter == '!' then
            letter = "\^:040e040e0e000000"
        end

        if letter == '?' then
            letter = "\^:0e0e040e04000000"
        end

        if i%2 == 0 then
            t1 = t1.." "
            t2 = t2..letter
        else
            t1 = t1..letter
            t2 = t2.." "
        end
    end

    print(t1, x, y, color)
    print(t2, x, y+1, color)
end

function zprint(str, x, y, color, align)
    str = ""..str
    if align == 0    then x -= #str*2
    elseif align > 0 then x -= #str*4+1 end

    print(str, x, y, color)
end

function draw_screen(xoff, yoff, w, h, screen_func)
    clip(-%0x5f28+xoff,-%0x5f2a+yoff,w,h)
    zcamera(xoff, yoff, screen_func)
    clip()
end

function draw_left_flap(is_on, screen_func)
    rectfill(-1+5,  9+5, 8*8-5,  11*8-5, is_on and 13 or 5)
    if is_on then draw_screen(11, 21, 40, 40, screen_func) end

    map(8,  0, -1,  9, 8,  11)
    spr(g_bl and 186 or 154, 07, 77) -- button presses
    spr(g_br and 188 or 156, 23, 77)
    spr(g_bu and 171 or 139, 15, 73)
    spr(g_bd and 187 or 155, 15, 81)
    spr(g_bo and 170 or 138, 39, 77)
    spr(g_bx and 172 or 140, 47, 77)
end

-- flap_rotation is between -1 and 1. -1 means closed, 1 means open.
function draw_right_flap(is_on, flap_rotation, backbuttonheld, topscreen_func, botscreen_func, top_row_buttons, bot_row_buttons)
    if flap_rotation < 0 then
        smap(0, 0, 8, 11, 8*8*(1-abs(flap_rotation))-1, 9, 8*8*abs(flap_rotation), 11*8)

        -- once the rotation changes, the back button is released.
        if flap_rotation == -1 and backbuttonheld then spr(123, 3, 49) end

    elseif flap_rotation > 0 then
        rectfill(65+5, 9+5, 65+8*8*flap_rotation-5, 9+11*8-5, is_on and 13 or 5)
        if flap_rotation == 1 and is_on then
            draw_screen(74, 18, 46, 13, topscreen_func)
            draw_screen(74, 67, 46, 21, botscreen_func)
        end

        smap(16, 0, 8, 11, 65, 9, 8*8*flap_rotation, 11*8)
        if flap_rotation == 1 then
            if top_row_buttons then spr(100, 73+(top_row_buttons\1%6)*8,  41) end
            if bot_row_buttons then spr(100, 73+(bot_row_buttons\1%6)*8,  49) end
        end
    end
end

function draw_back_panel(light)
    local rate = t()*7
    map(24, 0, -1,  1, 9, 12)
    spr((light > 0) and (rate%11<.5 and 131 or 130) or 132, 19, 3)
    spr((light > 1) and (rate%13<.5 and 131 or 129) or 132, 14, 3)
    spr((light > 2) and (rate%17<.5 and 131 or 128) or 132, 9,  3)
    spr((light > 3) and (rate%43<.5 and 134 or 133) or 135, 3,  3)
end