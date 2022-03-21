function gen_title_row(c, y)
    if y == 0 then
        _g.title_control()
    end

    if c.lvl == 0 then
        if y % 10 == 0 then
            _g.simpleballoon(y % 20 == 0 and 3.5 or c.room.w-3.5, y+.5, rnd_item{19, 23, 36, 40})
        elseif (y + 5) % 10 == 0 then
            _g.simpleballoon((y+5) % 20 == 0 and c.room.w-2.5 or 2.5, y+.5, rnd_item{19, 23, 36, 40})
        end
    end

    return gen_sides_and_floor(
        c, y, 
        {10, 60, 62, 63},
        {12, 28},
        {11, 27},
        {8},
        {9},
        {24}
    )
end

function gen_well_row(c, y)
    local row = gen_sides_and_floor(
        c, y, 
        {10, 60, 62, 63},
        {12, 28},
        {11, 27},
        {8},
        {9},
        {24}
    )
    gen_baddies_for_row(c, y, row, 15)
    return row
end

function gen_clown_row(c, y)
    if y == 0 then
        _g.clown_spawner()
    end

    local row = gen_sides_and_floor(
        c, y, 
        {10, 60, 62, 63},
        {129},
        {130, 146},
        {128},
        {162},
        {24}
    )
    gen_baddies_for_row(c, y, row, 15)
    return row
end
