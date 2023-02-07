-- todo: remove x,y,w,h
-- CHOOSE PARTY LOGIC --
|[party_select]| function(game) game:push'editparty' end $$

-- CHOOSE PKMN IN PARTY LOGIC --

-- UTILITY FUNCTIONS --
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
