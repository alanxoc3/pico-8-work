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
    end
    spr(a.sind, a.x, a.y+offy, 2, 2)
end $$

|[card_normal_update]| function(a)
    if g_level_state.curr != 'card_select' and g_level_state.curr != 'move_select' then
        a:kill()
    end
end $$

zclass[[card_selector,actor,vec,drawlayer_50|
    itemind,2,
    init,%card_selector_init,
    update,%card_selector_update;
    
    itemsinds;,@,@,@;
    items;,;
]]

|[card_selector_init]| function(a)
    add(a.items, _g.card(35,       a.itemsinds[1], false))
    add(a.items, _g.card(35+21,    a.itemsinds[2], true))
    add(a.items, _g.card(35+21+21, a.itemsinds[3], false))
end $$

|[card_selector_update]| function(a)
    if xbtnp() ~= 0 then
        a.itemind = mid(1, a.itemind+xbtnp(), 3)
    end

    for i=1,#a.items do
        a.items[i].selected = i == a.itemind
    end

    if g_level_state.curr != 'card_select' and g_level_state.curr != 'move_select' then
        a:kill()
    end
end $$

zclass[[level_state,actor|
    update,%level_state_update,
    curr,level_intro;

    level_intro;   init,nop,               next,card_select;
    card_select;   init,%card_select_init, next,move_select;
    move_select;   init,%move_select_init, next,player_update;
    player_update; init,nop,               next,enemy_update;
    enemy_update;  init,nop,               next,card_select;
]]

|[card_select_init]| function(a)
    _g.card_selector(64, 66, 70)
    a.moves = get_move_coordinates('move')

    for m in all(a.moves) do
        _g.possible_move_obj(a, m.x, m.y)
    end
end $$

|[move_select_init]| function(a)
    a.moves = get_move_coordinates('move')

    for m in all(a.moves) do
        _g.possible_move_obj(a, m.x, m.y)
    end
end $$

|[level_state_update]| function(a)
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
