TOP_LANE_Y = 8
MID_LANE_Y = 10
BOT_LANE_Y = 12

function draw_health_bar(health, max_health)
    local health_drawn = health/max_health * 119
    if health_drawn > 0 then
        rectfill(4, 119, 4 + health_drawn, 124, 12)
        rect(4, 124, 4 + health_drawn, 124, 1)
    end
end
