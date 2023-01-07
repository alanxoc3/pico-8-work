-- game state funcs
|[gamefadein_init]| function(a)
    _g.fader_in()
    sfx(-2,0) -- stop the creepy logo sound from looping
end $$

|[closed_draw]| function(a)
    rect(0,0,127,127,14)
    local rotation = sin(t())

    camera(-28+(rotation+1)*14,-15)
    draw_back_panel(0)
    draw_left_flap(nop)
    draw_right_flap(rotation, true, nop, nop)

    camera(0,0)
end $$

|[closed_update]| function(a)
end $$

|[closing_draw]| function(a)
end $$

|[light_init]| function(a)
end $$

|[opened_draw]| function(a)
end $$

|[opening_draw]| function(a)
end $$

-- utility funcs
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

    print(t1, x, y+(t()%2), color)
    print(t2, x, y+((t()+1)%2), color)
end

function zprint(str, x, y, color, align)
    if align == 0    then x -= #str*2
    elseif align > 0 then x -= #str*4+1 end

    print(str, x, y, color)
end

-- pixels are 0 to 37 (38x38 screen)
function draw_main_screen()
    --local fill_pattern = t()\1 % 2 == 0 and 0b1010010110100101 or 0b0101101001011010
    --local fill_pattern = t()*2\1 % 2 == 0 and 0b1111000011110000 or 0b0000111100001111
    --fillp(fill_pattern)
    --rectfill(0,0,37,37,0x5d)
    --fillp()
    sspr(0,0,16,16,23,0+t()*2%2,16,16, true)
    sspr(0,0,16,16,-1,21+(t()*2+1)%2,16,16, false)
end

function draw_screen(xoff, yoff, w, h, bg_color, screen_func)
    local ox, oy = %0x5f28, %0x5f2a
    clip(-ox+xoff,-oy+yoff,w,h)
    camera(ox-xoff, oy-yoff)

    rectfill(0,0,w,h,   bg_color)

    screen_func()
    camera(ox, oy)
    clip()
end

function draw_left_flap(screen_func)
    draw_screen(12, 22, 38, 38, 13, screen_func)

    map(8,  0, -1,  9, 8,  11)
    spr(btn(0) and 186 or 154, 07, 77) -- button presses
    spr(btn(1) and 188 or 156, 23, 77)
    spr(btn(2) and 171 or 139, 15, 73)
    spr(btn(3) and 187 or 155, 15, 81)
    spr(btn(4) and 170 or 138, 39, 77)
    spr(btn(5) and 172 or 140, 47, 77)
end

-- flap_rotation is between -1 and 1. -1 means closed, 1 means open.
function draw_right_flap(flap_rotation, backbutton, topscreen_func, botscreen_func, b1, b2, b3, b4, b5, b6, b7, b8, b9, b10, b11, b12)
    if flap_rotation < 0 then
        smap(0, 0, 8, 11, 8*8*(1-abs(flap_rotation))-1, 9, 8*8*abs(flap_rotation), 11*8)
        if flap_rotation == -1 and not backbutton then spr(129, 3, 49) end

    elseif flap_rotation > 0 then
        if flap_rotation == 1 then palt(5, true) end
        smap(16, 0, 8, 11, 65, 9, 8*8*flap_rotation, 11*8)
        if flap_rotation == 1 then palt(5, false)
            draw_screen(74, 18, 46, 14,  5, topscreen_func)
            draw_screen(74, 66, 46, 22,  5, botscreen_func)

            if b1  then spr(100, 73,  41) end
            if b2  then spr(100, 89,  41) end
            if b3  then spr(100, 81,  41) end
            if b4  then spr(100, 97,  41) end
            if b5  then spr(100, 105, 41) end
            if b6  then spr(100, 113, 41) end
            if b7  then spr(100, 73,  49) end
            if b8  then spr(100, 81,  49) end
            if b9  then spr(100, 89,  49) end
            if b10 then spr(100, 97,  49) end
            if b11 then spr(100, 105, 49) end
            if b12 then spr(100, 113, 49) end
        end
    end
end

function draw_closed_flap()
end

function draw_back_panel(light)
    map(24, 0, -1,  1, 9, 12)
    spr((light > 0) and 120 or 121, 19, 3)
    spr((light > 1) and 119 or 121, 14, 3)
    spr((light > 2) and 118 or 121, 9,  3)
    spr((light > 3) and 122 or 123, 3,  3)
end
