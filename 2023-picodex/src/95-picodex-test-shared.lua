-- these are shared with the pokedex test

-- https://www.lexaloffle.com/bbs/?tid=38931
function smap(cx,cy,cw,ch,sx,sy,sw,sh,flipx,flipy,layers)
 -- negative screen sizes
 if(sw<0)flipx=not flipx sx+=sw
 if(sh<0)flipy=not flipy sy+=sh
 sw,sh=abs(sw),abs(sh)

 -- delta
 local dx,dy=cw/sw,ch/sh

 -- apply flip
 if flipx then
  cx+=cw
  dx=-dx
 end
 if flipy then
  cy+=ch
  dy=-dy
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
   tline(sx,y,sx+sw-1,y,cx,cy,dx,0,layers)
   cy+=dy
  end
 else
  -- vertical lines
  for x=sx,sx+sw-1 do
   tline(x,sy,x,sy+sh-1,cx,cy,0,dy,layers)
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

function draw_left_flap()
    draw_screen(12, 29, 38, 38, 13, draw_main_screen)

    map(103,  21, -1,  16, 8,  11)
    spr(btn(0) and 186 or 154, 07, 84) -- button presses
    spr(btn(1) and 188 or 156, 23, 84)
    spr(btn(2) and 171 or 139, 15, 80)
    spr(btn(3) and 187 or 155, 15, 88)
    spr(btn(4) and 170 or 138, 39, 84)
    spr(btn(5) and 172 or 140, 47, 84)
end

function draw_right_flap()
    draw_screen(74, 25, 46, 14,  5, function() wobble_text("nidoran?", 46/2, 4, 6) end)
    draw_screen(74, 73, 46, 22,  5, function() sspr(32,32,16,16,1,1,16,16,true) end)
    --draw_screen(106, 73, 14, 14, 5, function() sspr(64,32,16,16,1,1,12,12,true) end)

    palt(5, true)
    smap(111,  21, 8, 11, -1+8*8+2, 16, 8*8, 11*8)
    palt(5, false)

    spr(btn(0) and 100 or 99, 73,  48) spr(btn(0) and 100 or 99, 89,  56)
    spr(btn(1) and 100 or 99, 89,  48) spr(btn(1) and 100 or 99, 81,  56)
    spr(btn(2) and 100 or 99, 81,  48) spr(btn(2) and 100 or 99, 97,  56)
    spr(btn(3) and 100 or 99, 97,  48) spr(btn(3) and 100 or 99, 105, 56)
    spr(btn(4) and 100 or 99, 105, 48) spr(btn(4) and 100 or 99, 113, 56)
    spr(btn(5) and 100 or 99, 113, 48) spr(btn(5) and 100 or 99, 73,  56)

    --spr(103, 77, 90, 5, 1)
    --spr(103, 77, 53, 5, 1)
    --zprint("aMORG gAMES",           97, 41+50, 7, 0)

end

function draw_closed_flap()
    -- draw_screen(74, 25, 46, 14,  5, function() wobble_text("nidoran?", 46/2, 4, 6) end)
    -- draw_screen(74, 73, 46, 22,  5, function() sspr(32,32,16,16,1,1,16,16,true) end)
    --draw_screen(106, 73, 14, 14, 5, function() sspr(64,32,16,16,1,1,12,12,true) end)

    map(95,  21, -1, 16, 8, 11)

    if btn(0) or btn(1) or btn(2) or btn(3) or btn(4) or btn(5) then
        spr(129, 3, 56)
    end
    --spr(103, 10, 34, 5, 1)
    --spr(103, 77, 90, 5, 1)
    --spr(103, 77, 53, 5, 1)
    --zprint("aMORG gAMES",           97, 41+50, 7, 0)

end

function draw_back_panel()
    map(119, 20, -1,  8, 9, 12)
    local tval = t()*2\1%5 -- 0, 1, 2, 3, 4
    spr((tval > 0) and 120 or 121, 20-1, 10)
    spr((tval > 1) and 119 or 121, 15-1, 10)
    spr((tval > 2) and 118 or 121, 10-1, 10)
    spr((tval > 3) and 122 or 123, 3,  10)
end
