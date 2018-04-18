-- for a sprite
-- a, sprite, 
function acts_attach_sprite(a, ind, anim_len, anim_spd, sw, sh, xf, yf)
	-- things used by collision
	a.base_ind = ind
	a.sw, a.sh = sw or 1, sh or 1
	a.xf, a.yf = xf, yf
	a.anim_len = anim_len or 1
	a.anim_off = 0
	a.anim_spd = anim_spd or 1

	a.draw = function(self)
		scr_spr(a.base_ind + a.anim_off, a.x-a.sw/2, a.y-a.sh/2, a.sw, a.sh, a.xf, a.yf)
	end

	return a
end
