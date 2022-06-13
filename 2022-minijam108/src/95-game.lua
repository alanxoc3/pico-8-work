-- BASIC EXAMPLE FOR SIMPLE GAME BELOW:

g_level = 0
g_death_count = 0
g_turn_count = 0

|[game_init]| function()
    g_level_state = _g.level_state()
    g_grid = set_grid(g_level)
end $$

|[game_update]| function()
    zcall(loop_entities, [[
        1 ;,timer,       tick;
        2 ;,actor,       state;
        3 ;,enemy,       check_collision;
        4 ;,tile_entity, to_target;
        5 ;,hermit,      to_target;
        6 ;,mov,         mov_update;
        7 ;,vec,         vec_update;
    ]])

    update_grid()
end $$

function round(num) return flr(num + .5) end
|[game_draw]| function()
    rectfill(0,0,127,127,12)

    g_offx, g_offy = 64, 53
    draw_tiles()

    loop_entities('drawlayer_25', 'draw')
    loop_entities('drawlayer_30', 'draw')
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
    
    local txtfunc = function()
        print_vert_wobble("stabby crabby", tlx-14, tly-6, 7, 1, 1)
        print_vert_wobble("level "..(g_level+1), tlx+99, tly-6+7*3, 7, 1, 1)
    end

    draw_outline(1, txtfunc)
    txtfunc()
    
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
                g_pl = _g.hermit(x, y)

            elseif objind == MAP_SWORD then
                g_sword = _g.sword(x, y)

            elseif objind == MAP_PUDDLE then
                spot.puddle = _g.puddle(x, y)
                
            elseif objind == MAP_SNAKE then
                spot.entity = _g.snake(x, y)

            elseif objind == MAP_SEAGULL then
                spot.entity = _g.seagull(x, y)

            elseif objind == MAP_FOX then
                spot.entity = _g.fox(x, y)

            elseif objind == MAP_FROG then
                spot.entity = _g.frog(x, y)
            end

            grid[y*7+x] = spot
        end
    end

    return grid
end

-- call every frame. loop through tile entities
function update_grid()
    for y=0,6 do
        for x=0,6 do
            local spot = g_grid[y*7+x]
            spot.entity = nil
        end
    end
    
    for te in all(g_zclass_entities.tile_entity) do
        local spot = g_grid[te.target_y*7+te.target_x]
        if spot.active then
            spot.entity = te
        end
    end
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
    local func = function()
        spr(a.sind, a.x, a.y+offy-2, 2, 2)
    end

    if a.selected then
        draw_outline(7, func)
        spr(141,a.x+4, a.y+16)

        local name = g_card_namemap[a.sind]
        local txtfunc = function()
            print("\^w"..name.."\^-w", 71, a.y+3, g_card_colormap[a.sind])
        end

        draw_outline(1, txtfunc)
        txtfunc()
    elseif g_level_state.curr != 'card_select' then
        offy = 13
    end
    func()
end $$

|[card_normal_update]| function(a)
    if g_level_state.curr != 'card_select' and g_level_state.curr != 'move_select' then
        a:kill()
    end
end $$

-- returns list of {{x=1,y=1}}
zclass[[status_text,actor,vec,drawlayer_50|
    text,@, checkstate,@, 
    x,64, y,144,
    draw,%status_text_draw;
    start;duration,.25, next,normal, dy,-2;
    normal;dy,0, update,%status_text_update;
    ending;update,nop, duration,.25, dy,2;
]]

|[status_text_draw]| function(a)
    print("\^w"..a.text.."\^-w", a.x-#a.text*4, a.y, 7)
end $$

|[status_text_update]| function(a)
    if g_level_state.curr ~= a.checkstate then
        a:kill()
    end
end $$
