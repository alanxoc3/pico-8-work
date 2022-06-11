-- BASIC EXAMPLE FOR SIMPLE GAME BELOW:
zclass[[test_obj,actor,drawlayer_50|x,@,y,@,color,7,init,%test_init,update,%test_update,draw,%test_draw;]]
|[test_init]|   function(a) a.color += 1                   end $$
|[test_update]| function(a) a.x += xbtn() a.y += ybtn()    end $$
|[test_draw]|   function(a) circfill(a.x, a.y, 2, a.color) end $$

|[game_init]| function()
    g_level = 0
    _g.level_state()
    g_grid = set_grid(g_level)
    _g.fader_in()
    _g.test_obj(64, 64)
end $$

|[game_update]| function()
    loop_entities('actor', 'state')
end $$

function round(num) return flr(num + .5) end
|[game_draw]| function()
    --fillp(0b0101101001011010)
    rectfill(0,0,127,127,12)
    --fillp()

    g_offx, g_offy = 64, 53
    draw_tiles()

    loop_entities('drawlayer_50', 'draw')

    --:rectfill(0,105,127,127,13)
    local x=35
    local y=107
    spr(64, x,       y, 2, 2)
    spr(64, x+21,    y, 2, 2)
    spr(64, x+21+21, y, 2, 2)
    --rect(0,127,127,127,1)

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
    local width=91
    local mult=sgn(sin(t()/7))*2+round(cos(t()/3))
    local inc=.05

    color(15)
    line() for i=0,1,inc do line(tlx+i*width, cos(i*mult)*amp+tly+1) end
    line() for i=0,1,inc do line(tlx+i*width, -cos(i*mult)*amp+tly+90) end
    line() for i=0,1,inc do line(cos(i*mult)*amp+tlx+1, tly+i*width) end
    line() for i=0,1,inc do line(-cos(i*mult)*amp+tlx+90, tly+i*width) end

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
    line() for i=0,1,inc do line(tlx+i*width, -cos(i*mult)*amp+tly+91) end
    line() for i=0,1,inc do line(tlx+i*width, -cos(i*mult)*amp+tly+92) end
    line() for i=0,1,inc do line(cos(i*mult)*amp+tlx-1, tly+i*width) end
    line() for i=0,1,inc do line(cos(i*mult)*amp+tlx, tly+i*width) end
    line() for i=0,1,inc do line(-cos(i*mult)*amp+tlx+91, tly+i*width) end
    line() for i=0,1,inc do line(-cos(i*mult)*amp+tlx+92, tly+i*width) end
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
