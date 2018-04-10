-- numbers are zipped with commas.
-- like gunzip, but for numbers.
function gun_nums(num_str)
	num_str = num_str..","
	local num_list, num = {}, ""
	for i=1, #num_str do
		local x = sub(num_str, i, i)
		if x == "," then
			-- +0 turns a string into a number.
			add(num_list, num+0)
			num=""
		else
			num=num..x
		end
	end
	return num_list
end
