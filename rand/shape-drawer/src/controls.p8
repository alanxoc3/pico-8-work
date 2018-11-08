-- this is in charge of the colors at the bottom of the screen.

-- sorry, we have an array with a zero index, but this is really more like a
-- lookup table than an array.
g_cols={
	[0 ]={name='black',   bkgd=6 , col2=5,  col3=1 },
	[1 ]={name='blue',    bkgd=6 , col2=13, col3=6 },
	[2 ]={name='purple',  bkgd=6 , col2=14, col3=6 },
	[3 ]={name='green',   bkgd=6 , col2=11, col3=9 },
	[4 ]={name='brown',   bkgd=6 , col2=2 , col3=5 },
	[5 ]={name='grey',    bkgd=1 , col2=6 , col3=7 },
	[6 ]={name='grey',    bkgd=1 , col2=5 , col3=0 },
	[7 ]={name='white',   bkgd=1 , col2=5 , col3=6 },
	[8 ]={name='red',     bkgd=0 , col2=1 , col3=2 },
	[9 ]={name='orange',  bkgd=0 , col2=4 , col3=2 },
	[10]={name='yellow',  bkgd=0 , col2=4 , col3=9 },
	[11]={name='green',   bkgd=0 , col2=5 , col3=3 },
	[12]={name='cyan',    bkgd=0 , col2=5 , col3=13},
	[13]={name='blue',    bkgd=0 , col2=1 , col3=5 },
	[14]={name='pink',    bkgd=0 , col2=8 , col3=2 },
	[15]={name='tan',     bkgd=0 , col2=4 , col3=1 }
}

function draw_colors()
	for i=1,16 do
		local x1 = (i-1)*8
		local x2 = x1+7
		local y1 = 119
		local y2 = 126

		rectfill(x1, y1, x2, y2, i-1)
	end

	local x1 = g_col*8
	local x2 = x1+7

	-- bounding box
	line(0, 117, 127, 117, 0)
	line(0, 118, 127, 118, 7)
	line(0, 127, 127, 127, 0)

	-- cur selection
	rect(x1, 119, x2, 126, 0)
	rect(x1-1, 118, x2+1, 127, 7)
end

-- returns -1 if the position is invalid.
function col_from_pos(x, y)
	if y > 118 and y < 128 and x > 0 and x < 128 then
		return flr(x / 8)
	end

	return -1
end

function draw_cursor(x, y)
	-- maybe change this.
	circ(g_x, g_y, 2, g_bkg_col)
	circ(g_x, g_y, 3, g_col)
	line(g_x-4, g_y, g_x+4, g_y, g_col)
	line(g_x, g_y-4, g_x, g_y+4, g_col)
end
