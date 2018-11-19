function outline_callback(callback, col, x, y)
	-- reset palette to black
	for c=1,15 do
		pal(c,col)
	end
	-- draw outline
	for xx=-1,1 do
		for yy=-1,1 do
			callback(x+xx, y+yy)
		end
	end
	-- reset palette
	pal()
	-- draw final sprite
	callback(x, y)
end

function outline_sprite(col,n,sx,sy,w,h,flip_x,flip_y)
	outline_callback(function(x, y)
      spr(n,x,y,w,h,flip_x,flip_y)
	end, col, sx, sy)
end

-- con_acts_spr.p8
function acts_spr_draw_outline()
	local acts = filter_val(g_actors, "spr")
	-- set speed
	foreach(acts,
		function(a)
			if a.sind >= 0 then
				outline_sprite(0, a.sind,
					scr_x(a.x-a.sw/2),
					scr_y(a.y-a.sh/2),
					a.sw, a.sh, a.xf, a.yf)
			end
		end)
end

function map_outline(col, cx, cy, sx, sy, cw, ch)
	outline_callback(function(x, y)
      map(cx, cy, x, y, cw, ch)
	end, col, sx, sy)
end
