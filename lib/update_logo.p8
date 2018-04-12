-- alan morgan

function update_logo()
	if l_o <= 0 then
		if l_t > 40 then
			l_p += .25
		else
			l_t += 1
		end
	else
		l_o -= .25
	end
end
