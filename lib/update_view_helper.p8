--- tokens: 74
function update_view_helper(pc, gc, rc, rd)
	-- order matters here.
	-- this helper shaved over 30 tokens.
	if pc < gc + g_s1 then gc = pc - g_s1 end
	if pc > gc + g_s2 then gc = pc - g_s2 end
	if gc < rc        then gc = rc end
	if gc+16 > rc+rd  then gc = rc+rd-16 end
	if rd < 16        then gc = rd/2 - 8 + rc end
	return gc
end
