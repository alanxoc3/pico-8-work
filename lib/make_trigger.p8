-- name, bounds (x1, y1, x2, y2), mark, dat (pl x, pl y, mus, snd)
function make_trigger(nam_num_mrk_dat)
	-- yes, this is very cryptic. it saved at least 15 tokens though.
	local n, d=gun_nums(nam_num_mrk_dat[2]), nam_num_mrk_dat[4]
	local field = {
		box={x1=n[1], y1=n[2], x2=n[3], y2=n[4]},
		active={x1=n[1], y1=n[2], x2=n[3], y2=n[4]}
	}

	if d then
		d = gun_nums(nam_num_mrk_dat[4])
		field.posx,field.posy=d[1],d[2]
		field.func=function() transition(nam_num_mrk_dat[3], d[3], d[4]) end
	end

	triggers[nam_num_mrk_dat[1]] = field
end
