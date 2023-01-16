|[p1sel_init]| function(game)
    local p1 = game.p1
    p1.actions = {}

    local priority_class = C_PRIORITY_ATTACK

    -- speed can be between 1 and 999, so multiples of 1000 can be priority
    -- highest priority goes first. if priority is same, roll a dice to decide
    p1.priority = min(C_PRIORITY_SWITCH, priority_class+p1.active:getstat'speed')

    game:load()
end $$

|[p2sel_init]| function(game)
    local p2 = game.p2
    p2.actions = {}

    local priority_class = C_PRIORITY_ATTACK

    -- speed can be between 1 and 999, so multiples of 1000 can be priority
    -- highest priority goes first. if priority is same, roll a dice to decide
    p2.priority = min(C_PRIORITY_SWITCH, priority_class+p2.active:getstat'speed')

    -- logic to determine who goes first
    local p1 = game.p1
    if p1.priority == p2.priority then p2.priority += sgn(rnd'2'-1) end
    game.p0 = p1.priority > p2.priority and p1 or p2
    game:load()
end $$

|[turn_update]| function(game)

    -- use this right before loading next:
    -- game.p0 = game.p0 == game.p1 and game.p2 or game.p1
end $$

|[turn_draw1]|  function(game)

end $$

|[turn_draw2]|  function(game)

end $$

|[turn_draw3]|  function(game)

end $$














-- there are stat stages for modifying moves. accuracy doesn't have same stat stages though: https://www.smogon.com/rb/articles/stadium_guide
-- here is where the table came from: https://gamefaqs.gamespot.com/gameboy/367023-pokemon-red-version/faqs/64175/stat-modifiers

-- fire can't be burned by fire type moves. ice can't be frozen by ice type moves. ground can't be paralyzed by electric type moves. anyone can sleep. poison can't be poisoned by poison type moves.

-- a battle's turn consists of actions. once both players have made their moves, the actions are compiled, then applied one at a time. Each action has a status message.
-- turn_actions = {
--   message?                  -- lowered attack
--   function (does something) -- takes attack down 1
--   koed!
-- }

-- func that generates actions for status effects
-- func that generates actions for dealing damage

-- i use game states?
-- or battle uses extra states?

-- for fight
-- selecting action is a menu, so it pushes on the game stack
-- turn -> turn -> select -> turn -> turn -> select
-- turn init will switch the 2 pokemon. select will set it.

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

