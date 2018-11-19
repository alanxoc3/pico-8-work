function restore_pal()
   for i=1,15 do pal(i,g_pal[i]) end
end

function scr_spr_out(col, a)
	for c=1,15 do pal(c,g_pal[col]) end

	for xx=0xffff, 1 do
      for yy=0xffff, 1 do
         scr_spr(a, xx, yy)
		end
	end

   restore_pal()
   scr_spr(a)
end

function scr_spr(a, xx, yy)
   spr(a.sind, scr_x(a.x-a.sw*.5)+a.xx+(xx or 0), scr_y(a.y-a.sh*.5)+a.yy+(yy or 0), a.sw, a.sh, a.xf, a.yf)
end
