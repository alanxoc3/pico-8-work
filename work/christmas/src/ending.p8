--- tokens: 74
function draw_dedication()
	print_center("dedicated to my family :)")
end

function print_center(txt, col)
	local off = 64 - (#txt / 2) * 4
	print(txt, off, 61, col or 6)
end


function draw_ending_1()
	print_center("jesus christ", 8)
end

function draw_ending_2()
	print_center("is the reason")
end

function draw_ending_3()
	print_center("for the season.")
end

function draw_ending_4()
	print_center("come unto him")
end

function draw_ending_5()
	print_center("and he will give you rest.")
end

function draw_ending_6()
	print_center("merry christmas :)", 11)
end
