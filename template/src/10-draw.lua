function zspr(sind, x, y, sw, sh, ...)
   sw, sh = sw or 1, sh or 1
   spr(sind, x-sw*4, y-sh*4, sw, sh, ...)
end

function zprint(str, x, y, align, fg, bg)
   if align == 0    then x -= #str*2
   elseif align > 0 then x -= #str*4+1 end

   batch_call_new(print, [[
      @1,@2,!plus/@3/1,@5;
      @1,@2,@3,@4;
   ]], str, x, y, fg, bg)
end

function zclip(x1, y1, x2, y2)
   clip(x1, y1, x2+1-flr(x1), y2+1-flr(y1))
end

function zcls(col)
   batch_call_new(rectfill, [[0x8000,0x8000,0x7fff,0x7fff,@1]], col or 0)
end

function zrect(x1, y1, x2, y2)
   batch_call_new(rect,
   [[ !plus/@1/-2, !plus/@2/-2, !plus/@3/2, !plus/@4/2, 13;
      !plus/@1/-1, !plus/@2/-1, !plus/@3/1, !plus/@4/1, 1;
   ]], x1, y1, x2, y2)
end


function scr_spr(a, spr_func, ...)
   if a and a.visible then
      (spr_func or zspr)(a.sind, a.x*8+a.ixx+a.xx, a.y*8+a.iyy+a.yy, a.sw, a.sh, a.xf, a.yf, ...)
   end
end

function scr_spr_out(a) scr_spr(a, spr_out, a.outline_color) end

function scr_spr_and_out(...)
   foreach({...}, scr_spr_out)
   foreach({...}, scr_spr)
end

function outline_helper(flip, coord, dim)
   coord = coord-dim*4
   if flip then
      return dim*8-1+coord, -1
   else
      return coord, 1
   end
end

function spr_out(sind, x, y, sw, sh, xf, yf, col)
   local ox, x_mult = outline_helper(xf, x, sw)
   local oy, y_mult = outline_helper(yf, y, sh)

   local out_tbl = g_out_cache[sind]
   if out_tbl then
      for i=1,#out_tbl,4 do
         rectfill(
            ox+x_mult*out_tbl[i],
            oy+y_mult*out_tbl[i+1],
            ox+x_mult*out_tbl[i+2],
            oy+y_mult*out_tbl[i+3],
         col)
      end
   end
end

function tprint(str, x, y, c1, c2)
   for i=-1,1 do
      for j=-1,1 do
         zprint(str, x+i, y+j, 0, BG_UI, BG_UI)
      end
   end
   zprint(str, x, y, 0, c1, c2)
end

-- fading
g_fadetable=ztable[[
:0,0,0,0,0,0,0,0;
:1,1,1,1,0,0,0,0;
:2,2,2,2,1,0,0,0;
:3,3,3,3,1,0,0,0;
:4,4,2,2,2,1,0,0;
:5,5,5,1,1,1,0,0;
:6,6,13,13,5,5,1,0;
:7,7,6,13,13,5,1,0;
:8,8,8,2,2,2,0,0;
:9,9,4,4,4,5,0,0;
:10,10,9,4,4,5,5,0;
:11,11,3,3,3,3,0,0;
:12,12,12,3,1,1,1,0;
:13,13,5,5,1,1,1,0;
:14,14,13,4,2,2,1,0;
:15,15,13,13,5,5,1,0;
]]

function fade(i)
   for c=0,15 do
      pal(c,g_fadetable[c][min(flr(i+1), 7)])
   end
end
