--- tokens: 71
-- amorg logo small
function logo_cspr(txt, x, y, w, y_div)
	for i=1, #txt do
		local col = s2x[ sub(txt, i, i) ]
		if col == 7 and y >= y_div then col = 5 end
		if col != 16 then pset(x,y,col) end
		if i % w == 0 then x -= w y += 1 end
		x+=1
	end
end
