function restore_pal()
   for i=1,15 do pal(i,g_pal[i]) end
end

function scr_sspr(a, off_x, off_y)
   sspr(
      off_x+a.sind%8*10,
      off_y+flr(a.sind/8)*10,
      a.sw*10,
      a.sh*10,
      scr_x(a.x-a.sw*(10/16))+a.xx,
      scr_y(a.y-a.sh*(10/16))+a.yy,
      a.sw*10,
      a.sh*10,
      a.xf,
      a.yf
   )
end

function scr_spr(a)
   spr(a.sind, scr_x(a.x-a.sw*.5)+a.xx, scr_y(a.y-a.sh*.5)+a.yy, a.sw, a.sh, a.xf, a.yf)
end
