zclass[[enemy|
    get_path,nil
]]

zclass[[snake,tile_entity,enemy,drawlayer_30|
    x,@, y,@,
    target_x,~x,
    target_y,~y,
    sind,40,
    get_path,%snake_get_path,
    update,%snake_update
]]

|[snake_update]| function(a)
    if a.target_x == g_sword.target_x and a.target_y == g_sword.target_y then
        a:kill()
    elseif a.target_x == g_pl.target_x and a.target_y == g_pl.target_y then
        g_pl:kill()
    end

        if a.dx < 0 then a.sind = 42
    elseif a.dx > 0 then a.sind = 46
    elseif a.dy < 0 then a.sind = 40
    elseif a.dy > 0 then a.sind = 44
    end
end $$

|[snake_get_path]| function(a)
    local possible_spots = {}
    for i=0,3 do
        local x, y = round(cos(i/4))+a.target_x, round(sin(i/4))+a.target_y
        if is_spot_empty(x, y) then
            add(possible_spots, {x=x, y=y})
        end
    end

    return {
        {x=a.target_x, y=a.target_y},
        rnd_item(possible_spots)
    }
end $$

zclass[[seagull,tile_entity,enemy,drawlayer_30|
    x,@, y,@,
    target_x,~x,
    target_y,~y,
    sind,10,
    get_path,%seagull_get_path,
    update,%seagull_update
]]

|[seagull_update]| function(a)
    if a.target_x == g_sword.target_x and a.target_y == g_sword.target_y then
        a:kill()
    elseif a.target_x == g_pl.target_x and a.target_y == g_pl.target_y then
        g_pl:kill()
    end

        if a.dx < 0 and dy < 0 then a.sind = 10
    elseif a.dx < 0 and dy > 0 then a.sind = 12
    elseif a.dx > 0 and dy < 0 then a.sind = 08
    elseif a.dy > 0 and dy > 0 then a.sind = 14
    end
end $$

|[seagull_get_path]| function(a)
    local possible_spots = {}
    for i=0,3 do
        local x, y = round(cos(.125+i/4))+a.target_x, round(sin(.125+i/4))+a.target_y
        if is_spot_empty(x, y) then
            add(possible_spots, {x=x, y=y})
        end
    end

    return {
        {x=a.target_x, y=a.target_y},
        rnd_item(possible_spots)
    }
end $$
