-- assumes over 100
function draw_health_meter(x, y, w, h, health)
	rectfill(x, y, x+w, y+h, 8)
	rectfill(x, y, x+-flr(-max(w*health/100, 0)), y+h, 11)
	rect(x, y, x+w, y+h, 1)
end

