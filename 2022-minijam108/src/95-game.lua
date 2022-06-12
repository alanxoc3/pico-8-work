-- BASIC EXAMPLE FOR SIMPLE GAME BELOW:
zclass[[test_obj,actor,drawlayer_50|x,@,y,@,color,7,init,%test_init,update,%test_update,draw,%test_draw;]]
|[test_init]|   function(a) a.color += 1                   end $$
|[test_update]| function(a) a.x += xbtn() a.y += ybtn()    end $$
|[test_draw]|   function(a) circfill(a.x, a.y, 2, a.color) end $$

|[game_init]| function()
    g_level = 0
    g_level_state = _g.level_state()
    g_grid = set_grid(g_level)
    _g.fader_in()
    _g.test_obj(64, 64)
end $$

|[game_update]| function()
    zcall(loop_entities, [[
        1 ;,timer,       tick;
        2 ;,actor,       state;
        3 ;,mov,         mov_update;
        4 ;,vec,         vec_update;
    ]])
end $$

function round(num) return flr(num + .5) end
|[game_draw]| function()
    rectfill(0,0,127,127,12)

    g_offx, g_offy = 64, 53
    draw_tiles()

    loop_entities('drawlayer_50', 'draw')

    if g_debug then
        rect(0, 0, 127, 127, 8)
    end
end $$

function print_vert_wobble(text, x, y, col, off, wob)
    for i=1,#text do
        print("\^w"..sub(text, i, i).."\^-w", x+wob*((i+off+t())\1%2), y+i*7, col)
    end
end

function draw_tiles()
    local tlx, tly = g_offx-46, g_offy-46
    rectfill(tlx,tly,tlx+90,tly+90,15)
    
    print_vert_wobble("stabby crabby", tlx-14, tly-6, 7, 1, 1)
    print_vert_wobble("level "..g_level, tlx+99, tly-6+7*3, 7, 1, 1)
    
    local amp=cos(.9)*.4+.8
    local amp1=cos(.25+.9)*.4+.8
    local amp2=cos(.5+.9)*.4+.8
    local amp3=cos(.75+.9)*.4+.8
    local width=91
    local mult=sgn(sin(t()/7))*2+round(cos(t()/3))
    local inc=.05

    color(15)
    line() for i=0,1,inc do line(tlx+i*width, cos(i*mult)*amp+tly+1) end
    line() for i=0,1,inc do line(tlx+i*width, -cos(i*mult)*amp1+tly+90) end
    line() for i=0,1,inc do line(cos(i*mult)*amp2+tlx+1, tly+i*width) end
    line() for i=0,1,inc do line(-cos(i*mult)*amp3+tlx+90, tly+i*width) end

    local midr = 7/2*TILE_RADIUS
    for ind, tile in pairs(g_grid) do
        local x,y = unpack_grid_index(ind)
        if tile.active then
            local sind = TILE_SPR_1
            if (y*7+x)%2 == 0 then sind = TILE_SPR_2 end
            spr(sind, scr_x(x)-6, scr_y(y)-6, 2, 2)
        end
    end

    color(7)
    line() for i=0,1,inc do line(tlx+i*width, cos(i*mult)*amp+tly-1) end
    line() for i=0,1,inc do line(tlx+i*width, cos(i*mult)*amp+tly) end
    line() for i=0,1,inc do line(tlx+i*width, -cos(i*mult)*amp1+tly+91) end
    line() for i=0,1,inc do line(tlx+i*width, -cos(i*mult)*amp1+tly+92) end
    line() for i=0,1,inc do line(cos(i*mult)*amp2+tlx-1, tly+i*width) end
    line() for i=0,1,inc do line(cos(i*mult)*amp2+tlx, tly+i*width) end
    line() for i=0,1,inc do line(-cos(i*mult)*amp3+tlx+91, tly+i*width) end
    line() for i=0,1,inc do line(-cos(i*mult)*amp3+tlx+92, tly+i*width) end
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
                g_pl = spot.entity

            elseif objind == MAP_SWORD then
                spot.entity = _g.sword(x, y)
                g_sword = spot.entity
                
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

zclass[[card,actor,vec,drawlayer_50|
    x,@, sind,@, selected,@,
    y,141,
    draw,%card_draw;
    start;duration,.25, next,normal, dy,-2;
    normal;dy,0, update,%card_normal_update;
    ending;update,nop, duration,.25, dy,2;
]]

|[card_draw]| function(a)
    local offy = 0
    if a.selected then
        offy = -2
        spr(104, a.x, a.y+offy-1, 2, 2)
        spr(104, a.x, a.y+offy, 2, 2)
        spr(16,a.x+4, a.y+16)
    elseif g_level_state.curr != 'card_select' then
        offy = 13
    end
    spr(a.sind, a.x, a.y+offy, 2, 2)
end $$

|[card_normal_update]| function(a)
    if g_level_state.curr != 'card_select' and g_level_state.curr != 'move_select' then
        a:kill()
    end
end $$

zclass[[level_state,actor|
    itemind,2,
    curr,pre_card_select;

    items;,;

    pre_card_select;     init,%pre_card_select_init, duration,0, next,card_select;
    card_select;         init,%card_select_init, update,%card_select_update, next,move_select;
    move_select;         init,%move_select_init, update,%move_select_update;
    player_update;       init,nop,               nop, next,enemy_update;
    enemy_update;        init,nop,               nop, next,card_select;
]]

|[pre_card_select_init]| function(a)
    a.items = {
        _g.card(35,       64, false),
        _g.card(35+21,    66, true),
        _g.card(35+21+21, 70, false)
    }
end $$

|[card_select_init]| function(a)
    local moves = get_move_coordinates(a.items[a.itemind].sind)
    for m in all(moves) do
        _g[m.type_small](a, a.itemind, m.x, m.y)
    end
end $$

|[card_select_update]| function(a)
    local prev_ind = a.itemind
    if xbtnp() ~= 0 then
        a.itemind = mid(1, a.itemind +xbtnp(), 3)
    end

    if a.itemind ~= prev_ind then
        local moves = get_move_coordinates(a.items[a.itemind].sind)
        for m in all(moves) do
            _g[m.type_small](a, a.itemind, m.x, m.y)
        end
    end

    for i=1,#a.items do
        a.items[i].selected = i == a.itemind
    end

    if btnp'4' then
        a:load'move_select'
    end
end $$

|[move_select_init]| function(a)
    a.moves = get_move_coordinates(a.items[a.itemind].sind)

    for m in all(a.moves) do
        _g[m.type](a, a.itemind, m.x, m.y)
    end
end $$

|[move_select_update]| function(a)
    if btnp(5) then
        a:load'card_select'
    end
end $$

-- returns list of {{x=1,y=1}}
function find_on_grid(predicate)
    local l = {}
    for y=0,6 do
        for x=0,6 do
            if predicate(g_grid[y*7+x]) then
                add(l, {x=x, y=y})
            end
        end
    end
    return l
end

function find_sword_on_grid()
end

function find_pl_on_grid()
    return find_on_grid(function(spot)
        return spot.entity == g_pl
    end)[1]
end

function is_spot_valid(x, y)
    local spot = g_grid[y*7+x]
    return x >= 0 and x <= 6 and y >= 0 and y <= 6 and spot.active
end

function is_spot_empty(x, y)
    local spot = g_grid[y*7+x]
    return is_spot_valid(x, y) and spot.entity == nil
end

function is_spot_attackable(x, y)
    local spot = g_grid[y*7+x]
    return is_spot_valid(x, y) and spot.entity and spot.entity.parents.enemy
end

function add_spot(list, x, y, type, type_small)
    add(list, {x=x, y=y, type=type, type_small=type_small})
end

function add_spot_if_empty(list, x, y, ...)
    if is_spot_empty(x, y) then
        add_spot(list, x, y, ...)
    end
end

function add_spot_if_attackable(list, x, y, ...)
    if is_spot_empty(x, y) or is_spot_attackable(x, y) then
        add_spot(list, x, y, ...)
    end
end

function get_move_coordinates(move_type)
    local pc = find_pl_on_grid()
    local spots = {}
    if move_type == 64 then
        add_spot(spots, pc.x+1, pc.y, 'pos_sword', 'pos_sword_small')
    elseif move_type == 66 then
        add_spot_if_attackable(spots, pc.x+1, pc.y, 'pos_sword', 'pos_sword_small')
        add_spot_if_attackable(spots, pc.x-1, pc.y, 'pos_sword', 'pos_sword_small')
        add_spot_if_attackable(spots, pc.x, pc.y+1, 'pos_sword', 'pos_sword_small')
        add_spot_if_attackable(spots, pc.x, pc.y-1, 'pos_sword', 'pos_sword_small')

        add_spot_if_attackable(spots, pc.x-1, pc.y-1, 'pos_sword', 'pos_sword_small')
        add_spot_if_attackable(spots, pc.x-1, pc.y+1, 'pos_sword', 'pos_sword_small')
        add_spot_if_attackable(spots, pc.x+1, pc.y+1, 'pos_sword', 'pos_sword_small')
        add_spot_if_attackable(spots, pc.x+1, pc.y-1, 'pos_sword', 'pos_sword_small')
    elseif move_type == 70 then
        add_spot_if_empty(spots, pc.x+1, pc.y, 'pos_move', 'pos_move_small')
        add_spot_if_empty(spots, pc.x-1, pc.y, 'pos_move', 'pos_move_small')
        add_spot_if_empty(spots, pc.x, pc.y+1, 'pos_move', 'pos_move_small')
        add_spot_if_empty(spots, pc.x, pc.y-1, 'pos_move', 'pos_move_small')

        add_spot_if_empty(spots, pc.x-1, pc.y-1, 'pos_move', 'pos_move_small')
        add_spot_if_empty(spots, pc.x-1, pc.y+1, 'pos_move', 'pos_move_small')
        add_spot_if_empty(spots, pc.x+1, pc.y+1, 'pos_move', 'pos_move_small')
        add_spot_if_empty(spots, pc.x+1, pc.y-1, 'pos_move', 'pos_move_small')
    end

    return spots
end

-- next step:
    -- list of next moves (indexes)
    -- move through next moves
    -- for each next move, make a new object

-- Object has it's own reference of where it is. Object is also in the grid. So you can loop through the grid and loop through function on all the objects.
-- 
