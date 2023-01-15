-- there are stat stages for modifying moves. accuracy doesn't have same stat stages though: https://www.smogon.com/rb/articles/stadium_guide
-- here is where the table came from: https://gamefaqs.gamespot.com/gameboy/367023-pokemon-red-version/faqs/64175/stat-modifiers

-- fire can't be burned by fire type moves. ice can't be frozen by ice type moves. ground can't be paralyzed by electric type moves. anyone can sleep. poison can't be poisoned by poison type moves.

-- main modifications from pokemon stadium:
-- whirlwind: has later priority & switch random pokemon from opponent
-- roar:      has later priority & switch random pokemon from opponent
-- teleport:  has later priority & switch random pokemon from user
-- swift:     always hits. no accuracy check. hits dig, fly, and pokemon behind substitute.
-- frozen stat condition has 10% chance to unthaw
-- pokemon can't receive status conditions from moves of one of their own types or resistances
-- two abras that keep using teleport to switch out will not take poison damage.
-- if opponent keeps using roar, preventing you from attacking (because you use roar/teleport/whirlwind/counter), then you don't take poison damage.

-- a battle's turn consists of actions. once both players have made their moves, the actions are compiled, then applied one at a time. Each action has a status message.
-- turn_actions = {
--   message?                  -- lowered attack
--   function (does something) -- takes attack down 1
--   koed!
-- }

-- func that generates actions for status effects
-- func that generates actions for dealing damage



-- takes in the hard-coded base speed value for the pkmn, so electrode would have highest crit ratio.
function get_crit_ratio(base_speed)
    -- range is 0 to 255. then random roll is done out of 256, so high crit still has like a .5% chance of failing.
    -- todo: redo these slightly
    -- (bs+76)/4 | (bs+236)/2 | (bs+76)/4*8 (crit move)
    return min(.99, (base_speed+76)/1024)
    -- slash:        min(.99, (base_speed+76)/128)
    -- focus energy: min(.99, (base_speed+236)/512)
end

-- pokemon rb just have one rnd check here. but stadium makes it two.
function move_accuracy_rate()
    return flr_rnd'256' == 0 and flr_rnd'256' == 0
end

function get_stat_multiplier(stage)
    return mid(2, 2+stage, 8)/mid(2, 2-stage, 8)
end

function get_stat_accuracy_multiplier(stage)
    return mid(1, 1+stage/3, 3)/mid(1, 1-stage/3, 3)
end

-- C_LEVEL is the level of the pkmn. hardcoding as a constant for now, but it could be changed.
-- thanks to bulbapedia: https://bulbapedia.bulbagarden.net/wiki/Stat#Stat
function calc_max_stat(lvl, base) return ceil(lvl*.01*(base*2+93)) + 5 end
function calc_max_hp(lvl, base)   return calc_max_stat(lvl, base) + 5 + lvl end

function calc_move_damage(lvl, attack, defence, critical, move_power)
    -- critical is 1 or 2
    -- need function for attack/defence ratio to prevent divide by zero
    -- base_damage can be a max of 997
    local base_damage = (2*lvl*critical/5+2)*move_power*(attack/defence)/50+2

    -- stab is 1.5 of base damage if move type equals pkmn type
    -- types are .5, 1, or 2, based on move's effectivenes against the opposing dual type pokemon
    -- random is between 217/255 and 255/255 inclusive
    return base_damage*stab*type1*type2*random
end

function begin_fight(game)
    local party1 = get_fight_party(get_party(@S_CUR_PARTY), 100)
    local party2 = get_fight_party({  { num=129,moves=c_pokemon[129].get_natural_moveset(10) }  }, 100)

    game.fightdata = zobj([[
        party1,@,
        party2,@,
        active1,@,
        active2,@
    ]], party1, party2, get_next_active(party1), get_next_active(party2))

    -- DEBUG_BEGIN
    printh(tostring(game.fightdata))
    -- DEBUG_END

    game:load'fight'
end

|[fight_init]|   function(a)
end $$

|[fight_update]| function(a) end $$
|[fight_draw1]|  function(a) end $$
|[fight_draw2]|  function(a) end $$
|[fight_draw3]|  function(a) end $$

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

        minor = {},
        shared = partypkmn,
    }
end
