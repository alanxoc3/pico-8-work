|[fight_select]| function(game)
    game:push'fightsel'
end $$

|[fightsel_init]| function(game)
    game.menu_fightsel:refresh({
        {name="bugcatcher", select=function(a, game)
                local cpu_party_draft = {}
                for i=1,6 do
                    local num = flr_rnd(151)+1
                    add(cpu_party_draft, { num=num, moves=c_pokemon[num].get_natural_moveset(100) })
                end

                begin_fight(game, 100, get_party(@S_CUR_PARTY), cpu_party_draft, "player 1", "bugcatcher", false, true)
            end, desc="i|like|bugs"
        }
    })
end $$

|[fightsel_update]| function(game) game.menu_fightsel:update(game) end $$
|[fightsel_draw1]|  function(game) game.menu_fightsel:draw1()      end $$
|[fightsel_draw2]|  function(game) end $$
|[fightsel_draw3]|  function(game) end $$
