pico-8 cartridge // http://www.pico-8.com
version 16
__lua__



function _init()
	pl = { x=64, y=64, r=2, col=12, dx=0, dy=0 }
	circles = {}
	add(circles, pl)
	for i=1,10 do
		add(circles, {
			x=rnd(127), y=rnd(127), r=rnd(10)+1, col=flr(rnd(3))+1, dx=rnd(2)-1, dy=rnd(2)-1
		})
	end
		
end

function _update60()
	if btn(0) then pl.dx=-.5
	elseif btn(1) then pl.dx=.5
	else pl.dx=0 end

	if btn(2) then pl.dy=-.5
	elseif btn(3) then pl.dy=.5
	else pl.dy=0 end

	for c in all(circles) do
		c.x += c.dx
		c.y += c.dy
		if c.x >= 127 then c.dx = -abs(c.dx) end
		if c.y >= 127 then c.dy = -abs(c.dy) end

		if c.x <= 0 then c.dx = abs(c.dx) end
		if c.y <= 0 then c.dy = abs(c.dy) end
	end

	for c in all(circles) do
		if c != pl then
			if abs(c.x - pl.x) < c.r+pl.r and abs(c.y - pl.y) < c.r+pl.r then
				del(circles, c)
			end
		end
	end

	if pl.x < 0 then
	end
end

function _draw()
	cls(0)
	for c in all(circles) do
		if c == pl then
			circfill(c.x, c.y, c.r, c.col)
		else
			local col = sub("894", c.col, c.col)
			circ(c.x, c.y, c.r, col)
		end
	end
end

