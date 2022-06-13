zclass[[enemy|
    get_path,nil,
    init,%enemy_init,
    check_collision,%enemy_check_collision
]]

|[enemy_init]| function(a)
    a.sind = rnd_item(a.possible_sinds)
end $$

|[enemy_check_collision]| function(a)
    if a.target_x == g_sword.target_x and a.target_y == g_sword.target_y then
        a:kill()
    elseif a.target_x == g_pl.target_x and a.target_y == g_pl.target_y then
        g_pl:kill()
    end
end $$

zclass[[snake,tile_entity,enemy,drawlayer_30|
    x,@, y,@,
    target_x,~x,
    target_y,~y,
    get_path,%snake_get_path,
    update,%snake_update;

    possible_sinds; ,42,46,40,44;
]]

|[snake_update]| function(a)
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
        if is_spot_empty(x, y) and not is_spot_on_sword(x, y) then
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
    get_path,%seagull_get_path,
    update,%seagull_update;

    possible_sinds; ,10,12,8,14;
]]

|[seagull_update]| function(a)
        if a.dx < 0 and a.dy < 0 then a.sind = 10
    elseif a.dx < 0 and a.dy > 0 then a.sind = 12
    elseif a.dx > 0 and a.dy < 0 then a.sind = 08
    elseif a.dy > 0 and a.dy > 0 then a.sind = 14
    end
end $$

|[seagull_get_path]| function(a)
    local possible_spots = {}
    for i=0,3 do
        local x, y = round(cos(.125+i/4))+a.target_x, round(sin(.125+i/4))+a.target_y
        if is_spot_empty(x, y) and not is_spot_on_sword(x, y) then
            add(possible_spots, {x=x, y=y})
        end
    end

    return {
        {x=a.target_x, y=a.target_y},
        rnd_item(possible_spots)
    }
end $$

-- FOX
zclass[[fox,tile_entity,enemy,drawlayer_30|
    x,@, y,@,
    target_x,~x,
    target_y,~y,
    get_path,%fox_get_path,
    update,%fox_update;

    possible_sinds; ,224,226,200,228,192,196,194,198;
]]

|[fox_update]| function(a)
        if a.dx < 0 and a.dy < 0 then a.sind = 224
    elseif a.dx < 0 and a.dy > 0 then a.sind = 226
    elseif a.dx > 0 and a.dy < 0 then a.sind = 200
    elseif a.dy > 0 and a.dy > 0 then a.sind = 228

    elseif a.dx == 0 and a.dy < 0 then a.sind = 192
    elseif a.dx == 0 and a.dy > 0 then a.sind = 196
    elseif a.dx < 0 and a.dy == 0 then a.sind = 194
    elseif a.dy > 0 and a.dy == 0 then a.sind = 198
    end
end $$

|[fox_get_path]| function(a)
    local path = {{x=a.target_x, y=a.target_y}}
    local xdir, ydir = zsgn(g_pl.target_x - a.target_x), zsgn(g_pl.target_y - a.target_y)

    -- first test the direction, don't want a sword
    local cur_x, cur_y = a.target_x, a.target_y
    while true do
        cur_x += xdir cur_y += ydir
        if not is_spot_empty(cur_x, cur_y)     then break
        elseif is_spot_on_player(cur_x, cur_y) then break
        elseif is_spot_on_sword(cur_x, cur_y)  then
            local ang = atan2(xdir, ydir) + rnd_item{-.125, .125}
            xdir, ydir = zsgn(cos(ang)), zsgn(sin(ang))
            break
        end
    end

    -- reset and you have a direction for sure
    cur_x, cur_y = a.target_x, a.target_y
    while true do
        cur_x += xdir cur_y += ydir
        if is_spot_empty(cur_x, cur_y) then
            add(path, {x=cur_x, y=cur_y})
        else
            break
        end
    end

    return path
end $$
