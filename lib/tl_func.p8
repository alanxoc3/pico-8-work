--- tokens: 17
-- call a function if not nil
-- call a function if not nil
function tl_func(tl, num)
	if tl.master[tl.current][num] then
		tl.master[tl.current][num]()
	end
end

