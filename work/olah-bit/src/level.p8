function map_to_chars()
	for j=g_lvl*10+1, g_lvl*10+10 do
		for i=0, 127 do
			local char = mget(i, j)
			local x, y = i+.5, j+.5

			if char == 64 then
				mset(i, j, 0)
				pl1 = gen_player(x, y, pl1 and pl1.points or 0, 0)
			elseif char == 80 then
				mset(i, j, 0)
				pl2 = gen_player(x, y, pl2 and pl2.points or 0, 1)
			elseif char == 112 then
				mset(i, j, 0)
				gen_zombie(x, y)
			elseif char == 96 then
				mset(i, j, 0)
				gen_alien(x, y)
			elseif char == 27 then
				mset(i, j, 0)
				gen_portal(x, y)
			elseif char == 101 then
				mset(i, j, 0)
				gen_yellow_suit(x, y)
			end
		end
	end
end

function animate_sprs()
	for j=g_lvl*10+1, g_lvl*10+10 do
		for i=0, 127 do
			local item = mget(i, j)
			local x, y = i+.5, j+.5
			if     item == 6 then item = 22
			elseif item == 22 then item = 6
			elseif item == 7 then item = 23
			elseif item == 23 then item = 7
			elseif item == 8 then item = 24
			elseif item == 24 then item = 8
			elseif item == 44 then item = 60
			elseif item == 60 then item = 44
			elseif item == 10 then item = 26
			elseif item == 26 then item = 10
			end

			mset(i, j, item)
		end
	end
end
