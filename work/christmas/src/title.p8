--- tokens: 69
function draw_title()
	rectfill(0,0,127,127,0)
	rectfill(0,26,127,102,1)
	rectfill(0,30,127,98,8)
	rectfill(0,32,127,96,13)
	cspr(g_title_string, 15, 33, 12*8) -- don't need height, but it is 7*8
end

function init_title()
	music(5)
	sfx(4, 3) --wind
end
