function create_platform_for_row(row, y, x1, x2, s_center)
    for x=x1,x2 do
        row[x]=create_block('solid', false, rnd_item(s_center))

        if flr_rnd(4) == 0 then
            _g.minispike(x+.5, y+.625-1, 25, false)
        end
    end
end

function gen_sides_and_floor(c, y, s_bkgd, s_wall, s_side, s_center, s_floor, s_hole)
    y = flr(y)
    local row = {}
    local width = c.room.w
    local bottom = c.room.h - 1

    if y > bottom or y < 0 then
        return {}
    end

    -- bkgd
    for x=1, flr_rnd(2) do
        row[flr_rnd(width)] = create_block('bkgd', false, unpack(s_bkgd))
    end

    -- sides
    row[0]=create_block('solid', true, unpack(s_wall))
    row[width-1]=create_block('solid', false, unpack(s_wall))

    if c.lvl > 0 and y > 3 and y < bottom - 4 then
        -- Side platforms
        if y % 3 == 0 and flr_rnd(6) == 0 then
            if flr_rnd(2) == 0 then
                if c.spike_counter_left < -2 then
                    row[1]=create_block('solid', true, unpack(s_side))
                    c.plat_counter_left = 0
                end
            else
                if c.spike_counter_right < -2 then
                    row[width-2]=create_block('solid', false, unpack(s_side))
                    c.plat_counter_right = 0
                end
            end
        end

        if c.plat_counter_middle < -6 and flr_rnd(10) == 0 then
            local variant = flr_rnd(5)
            if variant == 0 then -- middle
                create_platform_for_row(row, y, width/2-1, width/2, s_center)
            elseif variant == 1 then -- two plats
                create_platform_for_row(row, y, width/2-3, width/2-2, s_center)
                create_platform_for_row(row, y, width/2+1, width/2+2, s_center)
            elseif variant == 2 then -- 3 wide
                create_platform_for_row(row, y, width/2-1, width/2+1, s_center)
            elseif variant == 3 then -- 3 wide
                create_platform_for_row(row, y, width/2-2, width/2, s_center)
            elseif variant == 4 then -- 4 wide
                create_platform_for_row(row, y, width/2-2, width/2+1, s_center)
            end
            c.plat_counter_middle = 0
        end

        c.plat_counter_middle -= 1

        -- spikes
        if c.spike_counter_left > 0 then
            _g.wallspike(1+.25, y+.5, 16, true)
        elseif c.plat_counter_left < -2 and flr_rnd(12) == 0 then
            c.spike_counter_left = flr_rnd(2)+3
        end

        if c.spike_counter_right > 0 then
            _g.wallspike(width-1.25, y+.5, 16, false)
        elseif c.plat_counter_right < -2 and flr_rnd(12) == 0 then
            c.spike_counter_right = flr_rnd(2)+3
        end

        c.spike_counter_left -= 1
        c.spike_counter_right -= 1
        c.plat_counter_left -= 1
        c.plat_counter_right -= 1
    end

    -- floor
    if y == bottom-1 or y == bottom then
        for x=1, width/2-3 do
            row[x]=create_block('solid', true, unpack(s_floor))
            row[width-x-1]=create_block('solid', false, unpack(s_floor))
        end

        -- well siding
        row[width/2-2]=create_block('solid', false, unpack(s_wall))
        row[width/2+1]=create_block('solid', true, unpack(s_wall))
        row[width/2-2]=create_block('solid', false, unpack(s_wall))
        row[width/2+1]=create_block('solid', true, unpack(s_wall))
    end

    if y == bottom then
        row[width/2-1]=create_block('solid', false, unpack(s_hole))
        row[width/2]=create_block('solid', true, unpack(s_hole))
    end

    return row
end

function gen_baddies_for_row(c, y, row, chance)
    y = flr(y)
    local width = c.room.w
    local safe_top = 25
    local bottom = c.room.h - 1
    local safe_bottom = bottom - 20
    local rand_x = function()
        return flr_rnd(width-6)+3+.5
    end

    local x = rand_x()
    if y >= safe_bottom or y <= safe_top or row[flr(x)] then
        return
    end

    if c.lvl >= 3 and flr_rnd(chance) == 0 then
        local num = flr_rnd(4)
        if num == 0 then
            _g.nice_spawner(x, y+.5, _g.coin_bubble)
        elseif num == 1 then
            _g.danger_spawner(x, y+.5, _g.clown_bubble)
        else
            _g.nice_spawner(x, y+.5, _g.bubble)
        end
    end

    if c.lvl >= 2 and flr_rnd(chance) == 0 then
        if c.lvl >= 4 then
            _g.boulder_spawner(x, y+.5, rnd_item{131, 132, 147, 148}, flr_rnd(2) == 0)
        else
            _g.boulder_spawner(x, y+.5, 13, flr_rnd(2) == 0)
        end
    end

    if c.lvl >= 1 and flr_rnd(chance) == 0 then
        if flr_rnd(4) < 2 then
            _g.coin(x, y+.5)
        else
            _g.nice_spawner(x, y+.5, _g.simpleballoon)
        end
    end
end

