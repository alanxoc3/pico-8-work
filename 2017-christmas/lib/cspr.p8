-- embed this function in your game
-- draws an uncompressed image.
function cspr(txt, x, y, w)
	for i=1, #txt do
		local col = s2x[ sub(txt, i, i) ]
		if col != 16 then pset(x,y,col) end
		if i % w == 0 then x -= w y += 1 end
		x+=1
	end
end
