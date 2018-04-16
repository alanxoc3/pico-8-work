--- tokens: 15
-- can't just do pal(), because that gets rid of transparency color. >:0
function clear_fade()
	for c=0,15 do
		pal(c,c)
	end
end
