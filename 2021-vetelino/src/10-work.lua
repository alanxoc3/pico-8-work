TOP_LANE_Y = 8
MID_LANE_Y = 10
BOT_LANE_Y = 12

function draw_blueprint()
    rect(0, 0, 127, 127, 2)
    -- zprint("codename: pendae", 4, 4, -1, 11, 1)
    --zprint("objective: steal the ice cream", 4, 12, -1, 11, 1)

    rect(0, TOP_LANE_Y*8-8, 127, TOP_LANE_Y*8+7, 8)
    rect(0, MID_LANE_Y*8-8, 127, MID_LANE_Y*8+7, 8)
    rect(0, BOT_LANE_Y*8-8, 127, BOT_LANE_Y*8+7, 8)

    zprint("time: 32.3s", 4, 119, -1, 10, 2)
end

function draw_health_bar(health, max_health)
    local health_drawn = health/max_health * 119
    if health_drawn > 0 then
        rectfill(4, 119, 4 + health_drawn, 124, 12)
        rect(4, 124, 4 + health_drawn, 124, 1)
    end
end
