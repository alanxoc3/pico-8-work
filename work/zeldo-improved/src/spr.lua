function scr_spr_out(col, a)
	for c=0,15 do pal(c,col) end

	for xx=0xffff, 1 do
      for yy=0xffff, 1 do
         scr_spr(a, xx, yy)
		end
	end

	for c=0,15 do pal(c,c) end
   scr_spr(a)
end

function scr_spr(a, xx, yy)
   spr(a.sind, scr_x(a.x-a.sw*.5)+a.xx+(xx or 0), scr_y(a.y-a.sh*.5)+a.yy+(yy or 0), a.sw, a.sh, a.xf, a.yf)
end
