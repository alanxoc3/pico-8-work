-- con_tbox()

-- check if a text box is currently visible (useful if the dialogue clear
-- button is used for other actions as well)
function tbox_active()
	return #tbox_messages>0
end
