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

    --gf_lvl    = 50
    --gf_party1 = {}
    --gf_party2 = {}

    --status_condition
    --hp
    --pp

    -- when you switch, pp, hp, and status condition are copied...
    -- hp and status condition are easy. pp is not because of transform
    -- okay, switch the moves table... that would work.


    game.fightdata = {
    }
end

|[fight_init]|   function(a) end $$
|[fight_update]| function(a) end $$
|[fight_draw1]|  function(a) end $$
|[fight_draw2]|  function(a) end $$
|[fight_draw3]|  function(a) end $$

-- here is what an active pokemon looks like:
-- gf_active2 = {
--     type1    = normal, -- can be changed with conversion
--     type2    = grass,  -- can be changed with conversion
--     moveids  = { 0=13, 1=11, 2=96, 3=33 }, -- copied from shared. move id can change with mimic. or entire table can be changed with transform.
--     movepps  = { 0=10, 1=10, 2=10, 3=10 }, -- this is the same as shared.movepps, unless you use transform and switch it out.

--     stages   = {
--         special  = 0, -- how much it is modified (-6 to 6)
--         defence  = 0, -- how much it is modified (-6 to 6)
--         attack   = 0, -- how much it is modified (-6 to 6)
--         speed    = 0, -- how much it is modified (-6 to 6)
--         accuracy = 0, -- how much it is modified (-6 to 6)
--         evasion  = 0, -- how much it is modified (-6 to 6)
--     },

--     -- many minor status conditions
--     minor = {
--         confused   = false,
--         conversion = false,
--         critmove   = false,
--         decoyed    = false,
--         digging    = false,
--         flinching  = false,
--         flying     = false,
--         focused    = false,
--         misted     = false,
--         preparing  = false,
--         recharging = false,
--         reflected  = false,
--         screened   = false,
--         seeded     = false,
--         toxiced    = false,
--         transform  = false,
--     },

--     -- if you change something in shared, it is immediately applied to bench too, so it persists when you switch out.
--     shared = {
--         -- things that would change in a battle
--         hp = 100,
--         major = nil|frozen|poisoned|burned|sleeping|paralyzed|fainted,
--         movepps = { 0=10, 1=10, 2=10, 3=10 }, -- needs to be separate list so mimic works
--
--         -- other stuff in this table are things that wouldn't change in a battle
--         moveids = { 0=11, 1=19, 2=19, 3=13 },
--         num = 3 -- pokemon number (venasaur in this case)
--         lvl      = 50,  -- set at start of battle
--         maxhp    = 100, -- calculated from level
--         special  = 100, -- calculated from level
--         defence  = 100, -- calculated from level
--         attack   = 100, -- calculated from level
--         speed    = 100, -- calculated from level
--         accuracy = 100, -- calculated from level
--         evasion  = 100, -- calculated from level
--     }
-- }


-- generate party pokemon needs: num, moves, lvl
-- generate active pokemon needs: party pkmn
