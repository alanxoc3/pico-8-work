pico-8 cartridge // http://www.pico-8.com
version 16
__lua__
-- mod test
-- by alan morgan
function _init()
	init_logo()
end

function _update60()
	update_logo()
end

function _draw()
	cls(1)
	draw_logo()
end
-->8
-- amorg logo

-- the sound is assumed to be sfx 0!
function init_logo()
	gen_cipher()
	logo_text = img_x("hxp0kxo0kx0i70g70g7g0ixg0i70i70jx07g570j7h0gxh07g5707h50jx0i7075757m0h7g07g0g70ix07g57070507m07g570i750ix05g0505h05m05g050i50jx(0ix[0gx0h40h40h4g0g40h40g4g0h4g0g40x0ha0ha0ha04ga0ha0ga40ha04ga0x0a4a0a4a0a4g0ag40a4g0a0ag0ag0ag40x0ha0ga40gag0ha0gag0a0ag0ag0ha0x0ah0a0a0ag40g4a0ag40a0ag0ag0g4a0x0a0x0a0a0ha0gag0ha0a0ag0ag0ga0hxg0gxh0xh0xg0gxh0x0x0gx0gxg0hx")

	sfx(0)
	l_o, l_p, l_t = 7, 0, 0
	l_x, l_y = 47, 60 -- the o is in the center of the screen.
end

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

function draw_logo()
	clip(0, l_y, 127, 8 + l_p)   -- 7 is the height of the top text (plus 1)
	cspr(logo_text, l_x, l_y+1, 34) -- 34 is the width of the logo
	clip(0, 0, 127, 127)

	logo_cspr("x000000x0077770007500570070cc070070cc0700750057000777700x000000x", l_x+13, l_y+l_o, 8, l_y+6)
end

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

-- embed this function in your game
-- returns an uncompressed version of your image
function img_x(str)
	local ret = ""
	local rep = false
	local cnt = 0

	for i=1, #str do
		local char = sub(str,i,i)
		if cnt > 16 then
			for i=16,cnt do
				ret = ret..char
			end
			cnt = 0
		else
			cnt = s2x[char]

			if cnt <= 16 then
				ret = ret..char
			end
		end
	end

	return ret
end

-- call this at the start of your game.
function gen_cipher()
	c_str = "0123456789abcdefxghijklmnopqrstuvwyz!@#$%^&*()[]{}?+/=-_,<.>"
	s2x, x2s = {}, {}
	for i=1,#c_str do
		s2x[ sub(c_str,i,i) ]=i-1
		x2s[i-1] = sub(c_str,i,i)
	end
end
__sfx__
010f0000212502325029250262502623026220262102620026200262002b0702b0502b0302b0202b0100000000000000000000000000000000000000000000000000000000000000000000000000000000000000
