zclass[[game_state,actor|
    curr,fadein; -- curr,logo;

    init,%game_state_init;
    ecs_exclusions; actor,yes; -- remove game_state from the actor group
    defaults;       sinit,nop, update,nop, draw,nop, light,0, backbuttonheld,no, modes,;

    logo; next,fadein, sinit,%logo_init, update,nop, draw,%logo_draw, duration,2.5;

    fadein; next,game, duration,0, sinit,%gamefadein_init; -- fadein; next,closed, duration,0, sinit,%gamefadein_init;

    closed;     next,opening,                            sinit,%closed_init, update,%closed_update, draw,%closed_draw;
    opening;    next,starting_1,          duration,.25,                                             draw,%opening_draw;
    starting_1; next,starting_2, light,1, duration,.125, sinit,%light_init,                         draw,%opened_draw;
    starting_2; next,starting_3, light,2, duration,.125, sinit,%light_init,                         draw,%opened_draw;
    starting_3; next,game,       light,3, duration,.125, sinit,%light_init,                         draw,%opened_draw;
    game;       next,closing,    light,4,                sinit,%game_init,   update,%game_update,   draw,%game_draw;
    closing;    next,closed,              duration,.25,                      update,nop,            draw,%closing_draw;
]]

-- every state change will clean up all the entities.
|[game_state_init]| function(state)
    clean_all_entities('game_state', 'fader_in')
    state:sinit()
end $$

function _init()
    -- clear all the read only memory. testing things out showed that this doesn't get cleared automatically.
    memset(0x8000, 0, 0x7fff)

    poke(0x5f5c, 15) -- set the initial delay before repeating. 255 means never repeat.
    poke(0x5f5d, 5) -- set the repeating delay.

    cls()
    sfx(62,0) -- a sound indicator that the came is actually running while loading

-- NORMAL_BEGIN -- debug mode doesn't need to load these sheets for faster startup

    -- 0x0000
    extract_sheet(0)

    -- 0x0002
    extract_sheet(1)

-- NORMAL_END

    -- 0x0004
    extract_sheet(2)

    poke(0x5f56, 0xe0) -- make map funcs point here instead

    -- 0x0006
    px9_decomp(0, 0, peek2(3*2), mget, mset)

    -- 0x0008
    normalize_pokemon_data()

    -- Need the pokedex tiles to stay loaded. This starts at sprite index #96.
    memcpy(0x0000, 0xc000, 0x2000)

    g_tl = _g.game_state()
end

function _update60()
    g_bl  = btn'0'  g_br  = btn'1'
    g_bu  = btn'2'  g_bd  = btn'3'
    g_bo  = btn'4'  g_bx  = btn'5'
    g_bpl = btnp'0' g_bpr = btnp'1'
    g_bpu = btnp'2' g_bpd = btnp'3'
    g_bpo = btnp'4' g_bpx = btnp'5'

    if @S_SWAP_CONTROLS == 1 then
        g_bo,  g_bx  = g_bx,  g_bo
        g_bpo, g_bpx = g_bpx, g_bpo
    end

    -- DEBUG_BEGIN
    if g_bo and g_bpx then g_debug = not g_debug end
    -- DEBUG_END

    zcall(loop_entities, [[
        1;,actor,clean;
        2;,fader,clean;
    ]])

    register_entities()

    zcall(loop_entities, [[
        1;,fader,tick;
        2;,game_state,tick;
        3;,fader,state;
        4;,game_state,state;
    ]])
end

function _draw()
    cls()
    loop_entities('game_state', 'draw')
    fade(g_fade)
end

function parse_numlist(str)
    local tbl = {}
    for x in all(split(str or '', '|')) do
        if type(x) == "number" then
            add(tbl, x)
        end
    end
    return tbl
end

-- 255 is dashes. 0 is next pkmn. num is move index.
function normalize_pokemon_data()
    local all_pokemon_moves = {}
    local movemem = peek2(8)

    for i=0,151 do
        local is_range = false
        local moves = {}

        while @movemem ~= 0 do
            if @movemem == 255 then
                is_range = true
            elseif is_range then
                for i=moves[#moves],@movemem do
                    add(moves, i)
                end
                is_range = false
            else
                add(moves, @movemem)
            end
            movemem += 1
        end

        movemem += 1

        all_pokemon_moves[i] = moves
    end

    -- first, get move data

    -- initializing some data to make it easier to work with.
    -- -2 is for larger empty pkmn
    -- -1 is for smaller empty pkmn
    -- yes, i know it's a weird solution, but i don't care
    for i=-2,151 do
        local pkmn = c_pokemon[i] or {}
        local movelvls = {}
        for i=11,#pkmn do
            add(movelvls, pkmn[i])
        end

        c_pokemon[i] = {
            name     = pkmn[1],
            width    = pkmn[2],
            height   = pkmn[3],
            type1    = pkmn[4],
            type2    = pkmn[5],
            hp       = pkmn[6],
            attack   = pkmn[7],
            defence  = pkmn[8],
            speed    = pkmn[9],
            special  = pkmn[10],
            movelvls = movelvls,
            moves    = all_pokemon_moves[i],

            -- get moves that the pokemon would have naturally learned at a level
            get_natural_moveset = function(level)
                                     local a, moveset = c_pokemon[i], {}
                                     for i=#a.movelvls,1,-1 do
                                        if a.movelvls[i] <= level and #moveset < 4 then
                                           add(moveset, a.moves[i])
                                        end
                                     end
                                     return moveset
                                  end,
            draw       = function(...) draw_pkmn_out(i, ...) end,
            num        = i,
        }

        -- maybe moves should be formatted like the menu thing...
        -- name (easy), state=nil, desc=type|pp|pow|type?, function
    end

    c_pokemon[0].draw = function(...)
        draw_pkmn_out(@S_MISSINGNO ~= 0 and 0 or -2, ...)
    end

    -- initialize moves to make it easier to work with
    for i=0,#c_moves do
        local move = c_moves[i]
        c_moves[i] = {
            name     = move[1],
            type     = move[2],
            category = move[3],
            pp       = move[4],
            damage   = move[5],
            accuracy = move[6],
            istm     = i >= 1 and i <= 50,
            tmid     = i,
            ishm     = i >= 51 and i <= 55,
            hmid     = i-50,
            num      = i,
        }
    end
end

-- how does it l
-- 1-5|10|20

-- 255 = dash
-- 0   = next-pkmn
