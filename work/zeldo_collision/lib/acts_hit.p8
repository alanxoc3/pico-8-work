-- calls the hit function for each actor touching a.
function acts_hit(a,alist)
	-- hits with the main actor.
	for other in all(alist) do
		a.hit(other)
		other.hit(a)
	end
end
