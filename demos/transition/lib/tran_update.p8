-- con_tran()

function tran_update()
	local prev_tran = g_tran
	g_tran = min(g_tran+g_tran_inc, 1)

	if prev_tran < 0 and g_tran >= 0 then
		if g_tran_init then g_tran_init() end
	end
end

