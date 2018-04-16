
function draw_rect_with_border(x1, y1, x2, y2, bor_col, bkg_col, b_w)
	rectfill(x1, y1, x2, y2, bor_col)
	rectfill(x1+b_w, y1+b_w, x2-b_w, y2-b_w, bkg_col)
end

