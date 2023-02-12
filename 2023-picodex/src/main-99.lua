zclass[[game_state,actor|
    curr,fadein; -- curr,logo;

    init,%game_state_init;
    ecs_exclusions; actor,yes; -- remove game_state from the actor group
    defaults;       sinit,nop, update,nop, draw,nop, light,0, backbuttonheld,no, modes,;

    logo; next,fadein, sinit,%logo_init, update,nop, draw,%logo_draw, duration,2.5;

    fadein; next,game, duration,0, sinit,%gamefadein_init; -- fadein; next,closed, duration,0, sinit,%gamefadein_init;

    closed;     next,opening,                            sinit,%closed_init, update,%closed_update, draw,%closed_draw;
    opening;    next,starting_1,          duration,.25,                                             draw,%opening_draw;
    starting_1; next,starting_2, light,1, duration,.125, sinit,%beep, draw,%opened_draw;
    starting_2; next,starting_3, light,2, duration,.125, sinit,%beep, draw,%opened_draw;
    starting_3; next,game,       light,3, duration,.125, sinit,%beep, draw,%opened_draw;
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

    poke(0x5f5c, 12) -- set the initial delay before repeating. 255 means never repeat.
    poke(0x5f5d, 2) -- set the repeating delay.

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
    g_bl, g_br, g_bu, g_bd, g_bo, g_bx, g_bpl, g_bpr, g_bpu, g_bpd, g_bpo, g_bpx = btn'0', btn'1', btn'2', btn'3', btn'4', btn'5', btnp'0', btnp'1', btnp'2', btnp'3', btnp'4', btnp'5'
    g_available_pokemon = {}
    for i=0,151 do
        if @(S_POKEMON+i) > 0 then
            add(g_available_pokemon, i)
        end
    end

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

-- thanks to bulbapedia: https://bulbapedia.bulbagarden.net/wiki/Stat#Stat
function calc_max_stat(base) return ceil(C_LEVEL*.01*(base*2+93)) + 5 end

-- 255 is dashes. 0 is next pkmn. num is move index.
function normalize_pokemon_data()
    -- this is a global that the update_pokemon_moves function uses
    g_all_pokemon_moves = {}

    -- initialize moves first, because later logic uses this
    for i=0,#c_moves do
        local move = c_moves[i]
        c_moves[i] = {
            name     = move[1],
            type     = move[2],
            pp       = move[3],
            damage   = move[4],
            accuracy = move[5],
            ref      = (i >= 1 and i <= 50 and "tm "..i) or (i >= 51 and i <= 55 and "hm "..(i-50)),
            num      = i,
        }
    end

    -- next, get the moves for all the pokemon
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

        g_all_pokemon_moves[i] = moves
    end

    -- first, get move data

    -- initializing some data to make it easier to work with.
    -- -2 is for larger empty pkmn
    -- -1 is for smaller empty pkmn
    -- yes, i know it's a weird solution, but i don't care
    for i=0,151 do
        local pkmn = c_pokemon[i] or {}
        local movelvls = {}
        for i=10,#pkmn do
            add(movelvls, pkmn[i])
        end

        -- todo: token crunch on this table
        local newpkmn = {
            evolvesfrom  = (pkmn[1] or 0) > 0 and i-pkmn[1] or nil,
            name         = pkmn[2],
            type1        = pkmn[3],
            type2        = pkmn[4],

            base_hp      = pkmn[5],
            base_attack  = pkmn[6],
            base_defense = pkmn[7],
            base_speed   = pkmn[8],
            base_special = pkmn[9],

            level        = C_LEVEL,
            movelvls     = movelvls,
            moves        = {},

            -- get moves that the pokemon would have naturally learned at a level
            -- TODO: maybe moves should be formatted like the menu thing...
            -- TODO: name (easy), state=nil, desc=type|pp|pow|type?, function
            get_natural_moveset = function(level)
                                     local a, moveset = c_pokemon[i], {}
                                     for i=#a.movelvls,1,-1 do
                                        if a.movelvls[i] <= level and #moveset < 4 then
                                           add(moveset, a.moves[i].num)
                                        end
                                     end
                                     return moveset
                                  end,
            draw       = function(...) draw_pkmn_out(i, ...) end,
            num        = i,
        }

        newpkmn.maxhp   = calc_max_stat(newpkmn.base_hp) + 5 + C_LEVEL -- slightly different formula for hp
        newpkmn.attack  = calc_max_stat(newpkmn.base_attack)
        newpkmn.defense = calc_max_stat(newpkmn.base_defense)
        newpkmn.speed   = calc_max_stat(newpkmn.base_speed)
        newpkmn.special = calc_max_stat(newpkmn.base_special)
        newpkmn.hp      = newpkmn.maxhp

        if newpkmn.evolvesfrom then
            c_pokemon[newpkmn.evolvesfrom].evolvesto = i
        end

        c_pokemon[i] = newpkmn
    end

    -- update the moves for each pokemon
    for i=0,151 do
        local pkmn, moves, movemap = c_pokemon[i], {}, {}

        function set_move(m, reason)
            if not movemap[m] then
                movemap[m] = true
                local refmove = c_moves[m]
                add(moves, {
                    ref=reason or refmove.ref,
                    num=m
                })
            end
        end

        -- just add another loop for previous evolutions
        for i, m in ipairs(g_all_pokemon_moves[i]) do
            set_move(m, pkmn.movelvls[i] and "lvl "..pkmn.movelvls[i])
        end

        -- only 2 hard-coded unlockables (surfing pikachu & amnesia psyduck)
        if i == 25 then set_move(53,  "event") end
        if i == 54 then set_move(143, "event") end

        pkmn.moves = moves

        -- this loop needs to be last, because it changes the "pkmn" variable
        while pkmn.evolvesfrom do
            pkmn = c_pokemon[pkmn.evolvesfrom]
            for m in all(pkmn.moves) do
                set_move(m.num, "previous")
            end
        end
    end
end

-- how does it l
-- 1-5|10|20

-- 255 = dash
-- 0   = next-pkmn
