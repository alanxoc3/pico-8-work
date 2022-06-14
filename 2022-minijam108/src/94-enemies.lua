zclass[[shake_dead,pos,actor,drawlayer_30|
    sind,@, x,@, y,@, draw,%shake_dead_draw;
    start; duration,.5;
]]

|[shake_dead_draw]| function(a)
    if a.sind then
        spr(a.sind, rnd_one() + scr_x(a.x)-g_spr_info[a.sind][3], rnd_one() + scr_y(a.y)-g_spr_info[a.sind][4], g_spr_info[a.sind][1], g_spr_info[a.sind][2])
    end
end $$

zclass[[enemy,pos|
    get_path,nil,
    init,%enemy_init,
    update,%enemy_update,
    destroyed,%enemy_destroyed,
    check_collision,%enemy_check_collision;
]]

|[enemy_destroyed]| function(a)
    printh("DIE")
    _g.shake_dead(a.sind, a.x, a.y)
end $$

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

|[enemy_dying]| function(a)
    a.shake_x = rnd_item{-1, 0, 1}
    a.shake_y = rnd_item{-1, 0, 1}
end $$

|[enemy_update]| function(a)
    if a.speed > 0 then
        a.sind = a:setsind2(zsgn(cos(a.ang)), zsgn(sin(a.ang))) or a.sind
    end
end $$

zclass[[snake,tile_entity,enemy,drawlayer_30|
    x,@, y,@,
    target_x,~x,
    target_y,~y,
    get_path,%snake_get_path,
    setsind2,%snake_setsind2;

    possible_sinds; ,42,46,40,44;
]]

|[snake_setsind2]| function(a, dx, dy)
        if dx < 0 then return 42
    elseif dx > 0 then return 46
    elseif dy < 0 then return 40
    elseif dy > 0 then return 44
    end
end $$

|[snake_get_path]| function(a)
    local path = {{x=a.target_x, y=a.target_y}}
    local possible_spots = {}
    for i=0,3 do
        local x, y = round(cos(i/4))+a.target_x, round(sin(i/4))+a.target_y
        if is_spot_empty(x, y) and not is_spot_puddle(x, y) and not is_spot_on_sword(x, y) then
            add(possible_spots, {x=x, y=y})
        end
    end

    if #possible_spots > 0 then
        local xdiff, ydiff = abs(g_pl.target_x-a.target_x), abs(g_pl.target_y-a.target_y)
        if xdiff <= 1 and ydiff <= 1 then
            local smartest = get_smartest_direction(possible_spots, a.target_x, a.target_y)
            if smartest then
                add(path, smartest)
            end
        else
            add(path, rnd_item(possible_spots))
        end
    end

    return path
end $$

zclass[[frog,tile_entity,enemy,drawlayer_30|
    x,@, y,@,
    target_x,~x,
    target_y,~y,
    get_path,%frog_get_path,
    setsind2,%frog_setsind2;

    possible_sinds; ,230,76,78,232;
]]

|[frog_setsind2]| function(a, dx, dy)
        if dx < 0 then return 230
    elseif dx > 0 then return 76
    elseif dy < 0 then return 78
    elseif dy > 0 then return 232
    end
end $$

|[frog_get_path]| function(a)
    local path = {{x=a.target_x, y=a.target_y}}
    local possible_spots = {}
    for i=0,3 do
        local x, y = round(cos(i/4))*2+a.target_x, round(sin(i/4))*2+a.target_y
        if is_spot_empty(x, y) and not is_spot_puddle(x, y) and not is_spot_on_sword(x, y) then
            add(possible_spots, {x=x, y=y})
        end
    end

    local smartest = get_smartest_direction(possible_spots, a.target_x, a.target_y)
    if smartest then
        add(path, smartest)
    end

    return path
end $$

zclass[[seagull,tile_entity,enemy,drawlayer_30|
    x,@, y,@,
    target_x,~x,
    target_y,~y,
    get_path,%seagull_get_path,
    setsind2,%seagull_setsind2;

    possible_sinds; ,10,12,8,14;
]]

|[seagull_setsind2]| function(a, dx, dy)
        if dx < 0 and dy < 0 then return 10
    elseif dx < 0 and dy > 0 then return 12
    elseif dx > 0 and dy < 0 then return 08
    elseif dy > 0 and dy > 0 then return 14
    end
end $$

function get_smartest_direction(possible_spots, x, y)
    local smallest_ang_diff = 10
    local selected_spot
    local ideal_ang = atan2(g_pl.target_x - x, g_pl.target_y - y)

    for i=1,#possible_spots do
        local spot = possible_spots[i]
        local ang = atan2(spot.x - x, spot.y - y)
        if abs(ideal_ang-ang) < smallest_ang_diff then
            smallest_ang_diff = abs(ideal_ang-ang)
            selected_spot = i
        end
    end

    if selected_spot then
        return possible_spots[selected_spot]
    end
end

|[seagull_get_path]| function(a)
    local path = {{x=a.target_x, y=a.target_y}}

    local possible_spots = {}
    for i=0,3 do
        local ang = .125+i/4
        local x, y = round(cos(ang))+a.target_x, round(sin(ang))+a.target_y

        if is_spot_empty(x, y) and not is_spot_on_sword(x, y) then
            add(possible_spots, {x=x, y=y})
        end
    end

    local smartest = get_smartest_direction(possible_spots, a.target_x, a.target_y)
    if smartest then
        add(path, smartest)
    end

    return path
end $$

-- FOX
zclass[[fox,tile_entity,enemy,drawlayer_30|
    x,@, y,@,
    target_x,~x,
    target_y,~y,
    get_path,%fox_get_path,
    setsind2,%fox_setsind2;

    possible_sinds; ,224,226,200,228,192,196,194,198;
]]

|[fox_setsind2]| function(a, dx, dy)
        if dx < 0 and dy < 0 then return 224
    elseif dx < 0 and dy > 0 then return 226
    elseif dx > 0 and dy < 0 then return 200
    elseif dx > 0 and dy > 0 then return 228

    elseif dx == 0 and dy < 0  then return 192
    elseif dx == 0 and dy > 0  then return 196
    elseif dx < 0  and dy == 0 then return 194
    elseif dx > 0  and dy == 0 then return 198
    end
end $$

|[fox_get_path]| function(a)
    local path = {{x=a.target_x, y=a.target_y}}

    -- get all non sword and non empty directions
    -- create possible one with only the first thing
    -- use smart thing

    local possible_spots = {}
    for i=0,7 do
        local local_path = {}
        local xdir, ydir = zsgn(cos(i/8)), zsgn(sin(i/8))
        local is_good = false

        local cur_x, cur_y = a.target_x, a.target_y
        while true do
            cur_x += xdir cur_y += ydir
            if is_spot_puddle(cur_x, cur_y) or not is_spot_empty(cur_x, cur_y) then break
            elseif is_spot_on_sword(cur_x, cur_y) then
                is_good = false
                break
            end

            add(local_path, {x=cur_x, y=cur_y})
            is_good = true
        end

        if is_good and #local_path > 0 then
            add(possible_spots, {x=local_path[1].x, y=local_path[1].y, remaining=local_path})
        end
    end

    local smartest = get_smartest_direction(possible_spots, a.target_x, a.target_y)
    if smartest then
        for spot in all(smartest.remaining) do
            add(path, spot)
        end
    end

    return path
end $$
