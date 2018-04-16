--- tokens: 21
-- con_tbox()

function is_tbox_done(id)
	for l in all(tbox_messages) do
		if l.id == id then
			return false
		end
	end
	return true
end

