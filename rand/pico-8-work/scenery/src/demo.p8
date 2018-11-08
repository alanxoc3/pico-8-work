function _init()
	local hexstr="0123456789abcdefg"
	local c s2x={} x2s={}
	for i=1,17 do
		c=sub(hexstr,i,i)
		s2x[c]=i-1 x2s[i-1]=c
	end
end

g_x = 0
function _update()
	if btn(0) then g_x -= 1 end
	if btn(1) then g_x += 1 end
end


function _draw()
	cls()
	camera()
	print("cpu: "..stat(1))
	--red triangle blue fill
	shape(0,0,0,
	"c8t80lcglcgl08l08lc0lc0ccf8g8")

	draw_hell_scene(g_x, 0)
	--draw_space_scene(g_x, 0)
end
