-- there are stat stages for modifying moves. accuracy doesn't have same stat stages though: https://www.smogon.com/rb/articles/stadium_guide
-- here is where the table came from: https://gamefaqs.gamespot.com/gameboy/367023-pokemon-red-version/faqs/64175/stat-modifiers

-- fire can't be burned by fire type moves. ice can't be frozen by ice type moves. ground can't be paralyzed by electric type moves. anyone can sleep. poison can't be poisoned by poison type moves.

-- modifications from pokemon stadium:
-- whirlwind: switch random pokemon from opponent
-- roar: switch random pokemon from opponent
-- teleport: switch random pokemon from user
-- fzn stat condition has 10% chance to unthaw

-- flinch... a few moves have a flinch chance.
-- if pokemon is faster, the slower pokemon might flinch instead of attack.

-- transform - mirror move copies currently transformed pokemon, not the moves it had before it was transformed. transform will do the same thing.


-- stat conditions are weird. I need a function like this:
-- set_status_condition(target-type, move-type, condition)
-- fire can't recieve burned by fire moves, ice is same, normal is same, 
-- no move can inflict a status condition on the same type or resisting type.


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
function calc_max_stat(base) return (base*2+93)*C_LEVEL*.01 + 5 end
function calc_max_hp(base)   return calc_max_stat(base, C_LEVEL) + 5 + C_LEVEL end

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
    game:load'fight'

    -- there are only 3 priorities in og pkmn: counter, normal, quickattack

    -- need both parties
    -- how does party look like?
    -- need 2 parties
    -- each player has an "active" pokemon.
    -- each player has a party.
    -- roar and whirlwind work (switch with random benched pkmn)
    
    -- shared between active and benched:
    -- major stat condition: burn, freeze, paralyze, poison, sleep
    -- pp for moves
    -- hp for health

    -- speed, special, attack, defense
    -- has mist? (makes it so stat reductions can't happen to you until you switch out)
    -- has reflect
    -- has light screen
    -- each move can be disabled, unless it's the last move
    -- things active pokemon has that can change:
    -- which pokemon it is (transform)
    -- is_transformed (needed to prevent infinite battles with two pokemon knowing transform)
        -- need special logic around transform and mimic to prevent infinite battles
    -- i need to store the last move recieved, so mirror move can work.
    -- which type it is (conversion, transform)
    -- which moves it has (transform, mimic)
    -- evade and accuracy stats
    -- semi-invulnerable state (dig)
    -- semi-invulnerable state (fly)
    -- is leech-seeded?
    -- only active pkmn can have: confuse, flinch

    -- confusion, Disable, Focus Energy, Leech Seed, Light Screen, Mist, and Reflect from both Pokemon and removes the target's major status condition

    -- which major stat conditions (persists): burn, freeze, paralyze, poison, sleep
    game.fightdata = {
        
    }
end

|[fight_init]|   function(a) end $$
|[fight_update]| function(a) end $$
|[fight_draw1]|  function(a) end $$
|[fight_draw2]|  function(a) end $$
|[fight_draw3]|  function(a) end $$
