function _init()
end

function _update60()
	local num_list = "3,23,42,11,99,03"
	nums = gun_nums(num_list)
end

function _draw()
	cls()
	print('pico project!', 20, 20, 7)
	print(nums[1], 20, 30, 8)
	print(nums[2], 20, 40, 9)
	print(nums[3], 20, 50, 10)
	print(nums[4], 20, 60, 11)
	print(nums[5], 20, 70, 12)
	print(nums[6], 20, 80, 13)
end
