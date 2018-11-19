-- calls the hit function for each actor touching a.
function acts_hit(a,alist, dirlist)
	-- hits with the main actor.
	for i=1, #alist do

		a.hit(alist[i], dirlist[i])
		if dirlist[i] % 2 == 1 then 
			alist[i].hit(a, dirlist[i]-1)
		else
			alist[i].hit(a, dirlist[i]+1)
		end
	end
end
