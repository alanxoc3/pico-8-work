-- alan morgan

function is_containing(x, y, xrad, yrad, bx1, by1, bx2, by2)
	return x-xrad >= bx1 and x+xrad <= bx2 and y-yrad >= by1 and y+yrad <= by2
end
