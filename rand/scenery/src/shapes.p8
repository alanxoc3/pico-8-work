-- shape func credit to: innomin
-- some genius. idk, maybe i'll be like him one day :0
-- https://www.lexaloffle.com/bbs/?tid=2608
function shape(px,py,r,s)
	camera(-px,-py)
	local x=0 local y=0
	local c local i=1
	local a1 local a2
	local sr=sin(r)
	local cr=cos(r)
	local rx0=x*cr+y*sr+0.5
	local ry0=y*cr-x*sr+0.5
	local x1 local y1
	local rx1 local ry1
	while i<=#s do
		c=sub(s,i,i)
		a1=s2x[sub(s,i+1,i+1)]
		if(c=="c") then
			flcol=a1 color(a1) i+=2
		else
			a2=s2x[sub(s,i+2,i+2)]
			x1=x+a1-8 y1=y+a2-8
			rx1=x1*cr+y1*sr+0.5
			ry1=y1*cr-x1*sr+0.5
			if(c=="l") then
				line(rx0,ry0,rx1,ry1)
				--line(x,y,x1,y1)
			elseif(c=="f") then
				flend=s2x[sub(s,i+3,i+3)] i+=1
				camera(0,0)
				flood(flr(rx1+px),flr(ry1+py))
			end
			x=x1 y=y1 rx0=rx1 ry0=ry1
			i+=3
		end
	end
end
function flood(x,y)
	--if(x==band(x,127) and
	--   y==band(y,127)) then
	if(x>=0 and x<128 and
		y>=0 and y<128) then
		local p=pget(x,y)
		if(p!=flcol and p!=flend) then
			pset(x,y,flcol)
			flood(x-1,y) flood(x+1,y)
			flood(x,y-1) flood(x,y+1)
		end
	end
end

-- here is his tutorial for reference.

-- drawstring commands:
-- "C" color - set drawing Color (for lines and fills). color is a hex value
-- 0-F.

-- "T" x y - move cursor relative To current position, drawing nothing. x and y
-- are chars from "0"-"9"-"A"-"G", which represent -8 to 8. So "T00" means "to -8,
-- -8", and "TGG" means "to 8, 8".

-- "L" x y - draw Line from current position to next position. x and y are
-- 0-9+A-G as described above.

-- "F" x y stopcolor - flood Fill a region with drawing color until you
-- encounter stopcolor. This fully works with rotation by filling the next
-- (rotated) position defined by x,y. x and y are 0-9+A-G as described above,
-- color is a hex value 0-F.
