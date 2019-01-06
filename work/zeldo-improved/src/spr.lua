function restore_pal()
   for i=1,15 do pal(i,g_pal[i]) end
end

-- this is zeldo specific
function scr_spr10(a)
   sspr(
      48+a.sind%8*10,
      24+flr(a.sind/8)*10,
      10, 10,
      scr_x(a.x-a.sw*.625)+a.xx,
      scr_y(a.y-a.sh*.625)+a.yy,
      10, 10,
      a.xf,
      a.yf
   )
end

function scr_spr(a)
   spr(a.sind, scr_x(a.x-a.sw*.5)+a.xx, scr_y(a.y-a.sh*.5)+a.yy, a.sw, a.sh, a.xf, a.yf)
end
