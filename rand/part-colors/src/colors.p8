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

function init_colors()
	g_ctrl_lft=false
	g_ctrl_rgt=false
end

function draw_colors()
	for i=1,16 do
		local x1 = (i-1)*8
		local x2 = x1+7
		local y1 = 119
		local y2 = 126

		rectfill(x1, y1, x2, y2, i-1)
	end

	local x1 = g_col_1*8
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

function left_button_col(_x, _y, press, func)
	-- left btn
	local lft_btn = btn_col(0, _x, _y)

	-- initial press.
	if lft_btn and press and not g_ctrl_lft then
		g_ctrl_lft = true
		func()
		return true
	elseif not lft_btn then
		g_ctrl_lft = false
	end

	return false
end

function right_button_col(_x, _y, press, func)
	-- right btn
	local rgt_btn = btn_col(112, _x, _y)

	-- initial press.
	if rgt_btn and press and not g_ctrl_rgt then
		g_ctrl_rgt = true
		func()
		return true
	elseif not rgt_btn then
		g_ctrl_rgt = false
	end

	return false
end

function btn_col(xoff, _x, _y)
	return _y > 100 and _y < 117 and _x >= xoff and _x < xoff + 16
end

function draw_cursor()
	circ(g_x, g_y, 2, g_bkg_col)
	circ(g_x, g_y, 3, g_col_1)
	line(g_x-4, g_y, g_x+4, g_y, g_col_1)
	line(g_x, g_y-4, g_x, g_y+4, g_col_1)
end

function draw_controls()
	draw_control(0, g_ctrl_lft)
	draw_control(112, g_ctrl_rgt)
	-- left
	line(9, 104, 4, 109, 8)
	line(9, 103, 4, 108, 8)

	line(9, 113, 4, 108, 8)
	line(9, 114, 4, 109, 8)

	-- right
	line(118, 104, 123, 109, 8)
	line(118, 103, 123, 108, 8)

	line(118, 113, 123, 108, 8)
	line(118, 114, 123, 109, 8)
end

function draw_control(xoff, dwn)
	local f_col = 6
	local b_col = 7
	if dwn then f_col, b_col = 13, 5 end

	rectfill(xoff, 101, xoff+15, 116, f_col)
	rect(xoff, 101, xoff+15, 116, b_col)
	rect(xoff-1, 100, xoff+16, 117, 0)
end
