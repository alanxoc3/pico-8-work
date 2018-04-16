--- tokens: 6
-- optional number of which state should be loaded next.
function tl_next(tl, num)
	tl.time=0
	if num then tl.next=num end
end
