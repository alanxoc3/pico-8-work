-- BASIC EXAMPLE FOR SIMPLE GAME BELOW:
zclass[[test_obj,actor,drawlayer_50|x,@,y,@,color,7,init,%test_init,update,%test_update,draw,%test_draw;]]
|[test_init]|   function(a) a.color += 1                   end $$
|[test_update]| function(a) a.x += xbtn() a.y += ybtn()    end $$
|[test_draw]|   function(a) circfill(a.x, a.y, 2, a.color) end $$

|[game_init]| function()
    _g.level_state()
    g_grid = set_grid(0)
    _g.fader_in()
    _g.test_obj(64, 64)
end $$

|[game_update]| function()
    loop_entities('actor', 'state')
end $$

|[game_draw]| function()
    g_offx, g_offy = 64, 64
    draw_tiles()
    rect(0, 0, 127, 127, 8)
    loop_entities('drawlayer_50', 'draw')
end $$

function draw_tiles()
    local midr = 7/2*TILE_RADIUS
    for ind, tile in pairs(g_grid) do
        local x,y = unpack_grid_index(ind)
        if tile.active then
            local sind = TILE_SPR_1
            if (y*7+x)%2 == 0 then sind = TILE_SPR_2 end
            spr(sind, scr_x(x)-7, scr_y(y)-7, 2, 2)
        end
    end
end

-- [ind]: {active}
function set_grid(level)
    local mapx, mapy = level%16, level\16
    local grid = {}

    for y=0,6 do
        for x=0,6 do
            local objind = mget(mapx*8+x, mapy*8+y)
            local spot = {active = true}

            if objind == MAP_PL then
                spot.entity = _g.hermit(x, y)
            elseif objind == MAP_SNAKE then
                spot.entity = _g.snake(x, y)
            end

            grid[y*7+x] = spot
        end
    end

    return grid
end

-- gets the coordinates for the center of each tile
function unpack_grid_index(index)
    return index%7, index\7
end

zclass[[level_state,actor|
    update,%level_state_update,
    curr,level_intro;

    level_intro;   init,nop, next,card_select;
    card_select;   init,nop, next,move_select;
    move_select;   init,%move_select_init, next,player_update;
    player_update; init,nop, next,enemy_update;
    enemy_update;  init,nop, next,card_select;
]]

|[move_select_init]| function(a)
    a.moves = get_move_coordinates('move')

    for m in all(a.moves) do
        _g.possible_move_obj(a, m.x, m.y)
    end
end $$

|[level_state_update]| function(a)
    printh(a.curr)
    if btnp(4) or btnp(5) then
        a:load(a.next)
    end
end $$

function get_move_coordinates(move_type)
    if move_type == 'move' then
        return {{x=1, y=5}}
    end

    return {}
end

-- next step:
    -- list of next moves (indexes)
    -- move through next moves
    -- for each next move, make a new object

-- Object has it's own reference of where it is. Object is also in the grid. So you can loop through the grid and loop through function on all the objects.
-- 
