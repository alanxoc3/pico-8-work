zclass[[enemy|
    get_path,nil
]]

zclass[[snake,tile_entity,enemy,drawlayer_50|
    x,@, y,@,
    target_x,~x,
    target_y,~y,
    sind,40,
    get_path,%snake_get_path
]]

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
