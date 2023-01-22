|[fight_select]| function(a)
    local party = get_party(@S_CUR_PARTY)

    -- can't fight with an empty party
    for i=1,6 do
        if party[i] then
            a:push'fightsel'
            return
        end
    end

    sfx'60' -- idk, please just do any error sound
end $$

|[fightsel_init]| function(a)
    -- hmmm....
    -- i could populate based on levels
    a.available_actions = {
        {name="bugcatcher", func=function(a, game)
            local cpu_party_draft = {}
            for i=1,6 do
                local num = flr_rnd(151)+1
                add(cpu_party_draft, { num=num, moves=c_pokemon[num].get_natural_moveset(100) })
            end

            begin_fight(game, 100, get_party(@S_CUR_PARTY), cpu_party_draft, "player 1", "bugcatcher", true, true)
        end, desc="i|like|bugs"}
    }

    --name and func
end $$

|[fightsel_update]| function(a) menu_update(a, S_CURSOR_FIGHTSEL, a.available_actions) end $$
|[fightsel_draw1]|  function(a) menu_draw1 (a, S_CURSOR_FIGHTSEL, a.available_actions) end $$
|[fightsel_draw2]|  function(a) end $$
|[fightsel_draw3]|  function(a) menu_draw3 (a, S_CURSOR_FIGHTSEL, a.available_actions) end $$
