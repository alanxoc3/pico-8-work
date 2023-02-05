-- todo: remove x,y,w,h
-- CHOOSE PARTY LOGIC --
|[party_select]| function(game) game:push'editparty' end $$

|[party_init]| function(game)
    game.menu_party:refresh(zobj[[,1,2,3]], function(i)
        local party = get_party(i-1)
        local is_disabled = true
        for i=1,6 do
            if party[i] then is_disabled = false end
        end

        return {
            name="team #"..i,
            select=function() game:select_func() end,
            disabled=game.disable_empty_party and is_disabled
        }
    end)
end $$

|[party_update]| function(game) game.menu_party:update(game) end $$
|[party_draw1]|  function(game) game.menu_party:draw1()  end $$

-- CHOOSE PKMN IN PARTY LOGIC --
-- this is used both in "editparty" and selecting a pkmn in battle.
|[editparty_init]| function(game)
    local party = get_party(game.menu_party.c)
    game.menu_editparty:refresh(zobj[[,1,2,3,4,5,6]], function(i)
        return {
            select=function(entry, game)
                local party = get_party(game.menu_party.c)
                if party[game.menu_editparty.c+1] then
                    game:push'partyaction'
                else
                    game:push'partypkmn'
                end
            end,
            num=party[i] and party[i].num or -2
        }
    end)
end $$

|[editparty_update]| function(game)
    game.menu_editparty:update(game)
end $$

-- todo: make this smaller
|[editparty_draw1]| function(game)
    game.menu_editparty:draw1()
    wobble_text("team #"..game.menu_party.c+1, 20, 27, 1)
end $$

|[editparty_draw2]| function(game)
    zprint("spot #"..(game.menu_editparty.c+1), 46/2, 4, 1, 0)
end $$

|[editparty_draw3]| function(game)
    local party = get_party(game.menu_party.c)
    local partypkmn = party[game.menu_editparty.c+1]
    if partypkmn then
        draw3_pokeinfo(get_pokemon(partypkmn.num))
    else
        print_draw3_message("select", "your", "pokemon")
    end
end $$

-- UTILITY FUNCTIONS --
function print_draw3_message(top, mid, bot)
    rectfill(0,0,45,20,1)
    zprint(top, 46/2, 1,  13, 0)
    zprint(mid, 46/2, 8,  13, 0)
    zprint(bot, 46/2, 15, 13, 0)
end

-- no moves means the pokemon is deleted
c_party_memlocs = zobj[[0,S_PARTY1, 1,S_PARTY2, 2,S_PARTY3]]
function get_party(party_index) -- 0 to 2
    local mem = c_party_memlocs[party_index]
    local party = {}

    for i=1,6 do
        local memstart = mem+(i-1)*5
        local moves = {}
        local has_moves = false
        for i=1,4 do
            local move = peek(memstart+i)
            if move > 0 then
                moves[i] = move
                has_moves = true
            end
        end

        if has_moves then
            party[i] = { num=peek(memstart), moves=moves }
        end
    end

    return party
end

function save_party(party_index, party) -- 0 to 2
    local mem = c_party_memlocs[party_index]
    memset(mem,0,30)

    -- clear party and we'll replace it with the logic below

    for i=1,6 do
        local memstart = mem+(i-1)*5
        local pkmn = party[i]
        if pkmn then
            poke(memstart, pkmn.num)

            for i=1,4 do
                poke(memstart+i, pkmn.moves[i])
            end
        end
    end
end
