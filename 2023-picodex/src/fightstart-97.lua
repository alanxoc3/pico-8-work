-- thanks to bulbapedia: https://bulbapedia.bulbagarden.net/wiki/Stat#Stat
function calc_max_stat(lvl, base) return ceil(lvl*.01*(base*2+93)) + 5 end
function calc_max_hp(lvl, base)   return calc_max_stat(lvl, base) + 5 + lvl end

function create_send_action(pl)
    -- this would also have an animation thing eventually
    return { active=pl.active, message="#,comes,out", logic=function(p1, p2) end }
end

-- fight is: turn -> turn -> { (p1 select) -> (p2 select) -> whogoesfirst -> turn -> turn -> ...repeat }
-- in turn init, if there are no actions then go to p1 select
-- in turn init, switch p0
-- in p1select, next is p2select. in p2select, next is turn1, turn2
-- how does a turn know
function begin_fight(game)
    local party1 = get_fight_party(get_party(@S_CUR_PARTY), 100)
    local party2 = get_fight_party({  { num=129,moves=c_pokemon[129].get_natural_moveset(10) }  }, 100)

    game.p1 = { name="player 1",   iscpu=false, actions={}, active=get_next_active(party1), party=party1 }
    game.p2 = { name="bugcatcher", iscpu=true,  actions={}, active=get_next_active(party2), party=party2 }

    add(game.p1.actions, create_send_action(game.p1))
    add(game.p2.actions, create_send_action(game.p2))

    -- how to switch the current player
    -- game.p0 = game.p0 == game.p1 and game.p2 or game.p1
    game.p0 = game.p1

    game:push'turn1'
end

-- used to switch to the next pkmn at the start of the battle and when a pkmn is ko-ed.
-- if this returns nil, the battle is over
function get_next_active(party)
    for i=1,6 do
        if party[i] and party[i].major ~= C_MAJOR_FAINTED then
            return party_pkmn_to_active(party[i])
        end
    end
end

-- converts a party into a party ready for battle
function get_fight_party(party, lvl)
    local fightparty = {}

    -- TODO: optimize for tokens
    for i=1,6 do
        local cur = party[i]
        if cur then
            local pkmn = c_pokemon[cur.num]
            fightparty[i] = {
                -- things that won't change
                num     = cur.num,
                lvl     = lvl,
                maxhp   = calc_max_hp(lvl, pkmn.hp),
                attack  = calc_max_stat(lvl, pkmn.attack),
                defence = calc_max_stat(lvl, pkmn.defence),
                speed   = calc_max_stat(lvl, pkmn.speed),
                special = calc_max_stat(lvl, pkmn.special),
                moveids = (function() local m = {} for i=1,4 do m[i] = cur.moves[i] end return m end)(),

                -- things that can change
                hp      = calc_max_hp(lvl, pkmn.hp),
                movepps = (function() local m = {} for i=1,4 do m[i] = cur.moves[i] and c_moves[cur.moves[i]].pp end return m end)(),
            }
        end
    end

    return fightparty
end

-- partypkmn must be non-nil and match the party table structure defined in get_fight_party 
function party_pkmn_to_active(partypkmn)
    return {
        type1 = c_pokemon[partypkmn.num].type1,
        type2 = c_pokemon[partypkmn.num].type2,
        moveids = (function() local m = {} for i=1,4 do m[i] = partypkmn.moveids[i] end return m end)(),
        movepps = partypkmn.movepps,

        -- these always start at zero
        stages = zobj[[
            special,0,
            defence,0,
            attack,0,
            speed,0,
            accuracy,0,
            evasion,0
        ]],

        -- evasion and accuracy have a different formula: https://www.smogon.com/rb/articles/stadium_guide
        -- all stats cap at 999: https://www.smogon.com/rb/articles/rby_mechanics_guide
        -- and i'm giving it a min of 1 too, because zero messes things up
        getstat = function(a, stat)
            local stage = a.stages[stat]
            return ceil(mid(1, 999,
                a.shared[stat]*(
                    (stat == 'evasion' or stat == 'accuracy')
                    and mid(1, 1+stage/3, 3)/mid(1, 1-stage/3, 3)
                     or mid(2, 2+stage,   8)/mid(2, 2-stage,   8)
                )
            ))
        end,

        minor = {},
        shared = partypkmn,
    }
end
