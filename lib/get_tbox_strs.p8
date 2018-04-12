function get_tbox_strs()
	local str1, str2 = "", ""

	if tbox_messages[1] then
		str1 = tbox_messages[1].line
	end

	if tbox_messages[2] then
		str2 = tbox_messages[2].line
	end

	return str1, str2
end

