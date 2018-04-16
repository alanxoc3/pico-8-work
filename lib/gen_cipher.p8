--- tokens: 47
-- call this at the start of your game.
function gen_cipher()
	c_str = "0123456789abcdefxghijklmnopqrstuvwyz!@#$%^&*()[]{}?+/=-_,<.>"
	s2x, x2s = {}, {}
	for i=1,#c_str do
		s2x[ sub(c_str,i,i) ]=i-1
		x2s[i-1] = sub(c_str,i,i)
	end
end
