-- todo: logic should pass in p0, p2, move_parameters
-- todo: dead pkmn should send out next
-- todo: empty party should end battle

|[psel_init]| function(game)
    game.p0 = game[game.p0key]

    local p0 = game.p0
    p0.actions = {}

    -- attacking
    local moveslot = select_random_move_slot(p0.active)
    local move = p0.active.moveids[moveslot] or M_STRUGGLE
    add(p0.actions, {
        active=p0.active,
        message="#,uses,"..c_moves[move].name,
        logic=function(s, o) -- self, other
            generic_attack(s, o, moveslot)
        end
    })

    local priority_class = C_PRIORITY_ATTACK

    -- hardcoding the only moves that can change priority for now. Maybe there is a more token efficient way to do this?
    if move == M_QUICK_ATTACK then priority_class = C_PRIORITY_QUICKATTACK end
    if move == M_COUNTER or move == M_WHIRLWIND or move == M_ROAR or move == M_TELEPORT then
        priority_class = C_PRIORITY_COUNTER
    end

    -- speed can be between 1 and 999, so multiples of 1000 can be priority
    -- highest priority goes first. if priority is same, roll a dice to decide
    p0.priority = min(C_PRIORITY_SWITCH, priority_class+p0.active:getstat'speed')
end $$

|[psel_update]| function(game)
    if g_bpx or g_bpo then
        game:load()

        -- logic to determine who goes first
        local p1 = game.p1
        local p2 = game.p2
        if p1.priority == p2.priority then p2.priority += sgn(rnd'2'-1) end
        game.p0 = p1.priority > p2.priority and p1 or p2
    end
end $$

|[psel_draw3]| function(game) print_draw3_message("planning", "an", "action") end $$

|[turn_init]| function(game)
    local action = deli(game.p0.actions, 1)
    if action then
        game.cur_action = action

        -- todo: can this flip logic be combined with what's in finit?
        game.cur_action.logic(game.p0, game.p0 == game.p1 and game.p2 or game.p1)
    else
        game.cur_action = {active=p0.active, message="nothing,to,do", logic=nop}
        game.cur_action.logic()
    end
end $$

-- finit gets executed on the same turn as init
|[turn_finit]| function(game)
    -- switch p0 and go to the next state
    game.p0 = game.p0 == game.p1 and game.p2 or game.p1
end $$

|[turn_update]| function(game)
    if g_bpx or g_bpo then
        local action = deli(game.p0.actions, 1)
        if action then
            game.cur_action = action
            game.cur_action.logic()

            if     game.p1.active.shared.hp <= 0 then add(game.p0.actions, {active=game.p1.active, message="#,is,fainted", logic=nop})
            elseif game.p2.active.shared.hp <= 0 then add(game.p0.actions, {active=game.p2.active, message="#,is,fainted", logic=nop}) end
        else
            game:load()
        end
    end
end $$

function draw_hp(x, y, hp, maxhp, status, align, col)
    hp = max(ceil(hp), 0)
    zprint(hp,           x+3*max(align, 0), y-2+5*align, col, align)
    zprint(status or "", x+3*max(align, 0), y-2-5*align, col, align)
    rectfill(x, y-1, x-align*ceil(hp/maxhp*17), y+1, col)
end

|[turn_draw1]|  function(game)
    -- SIDE/SIDE/TEXT and space i guess
    local a1, a2 = game.p1.active, game.p2.active
    -- this is good positioning
    --zprint(a1.shared.hp, 41, 29, 5, 1)

    local active = game.cur_action.active and game.p0.active
    draw_hp(38, 30, a1.shared.hp, a1.shared.maxhp, a1.shared.major, 1,  active == game.p1.active and 6 or 1)
    draw_hp(1,  9,  a2.shared.hp, a2.shared.maxhp, a2.shared.major, -1, active == game.p2.active and 6 or 1)
    c_pokemon[a1.shared.num].draw(   10, 40-10-t()%2\1, 5)
    c_pokemon[a2.shared.num].draw(40-10,    10+t()%2\1, 5, -1)
end $$

|[turn_draw2]|  function(game)
    zprint(game.p0.name, 23, 4, 1, 0)
end $$

|[turn_draw3]|  function(game)
    local message_tbl = split(game.cur_action.message)
    if message_tbl[1] == '#' then message_tbl[1] = c_pokemon[game.cur_action.active.shared.num].name end
    print_draw3_message(unpack(message_tbl))
end $$

---------------------------------------------------------------------------

-- skip if the active pkmn isn't active anymore.
function get_next_action(s, o)

end

-- returns move slot number. 0 means to use struggle.
function select_random_move_slot(active)
    local possible_moves = {}

    for i=1,4 do
        if active.moveids[i] and active.movepps[i] > 0 then
            add(possible_moves, i)
        end
    end

    return possible_moves[flr_rnd(#possible_moves)+1] or M_STRUGGLE
end

-- [s]elf pl, [o]ther pl, [m]ove slot
function generic_attack(s, o, m)
    local move = c_moves[s.active.moveids[m] or 0]

    -- should only be nil for struggle?
    if move.num != 0 then
        s.active.movepps[m] -= 1
    end

    local dmg = move.damage -- calc_move_damage(s.active.shared.lvl, s.active.shared.attack, defence, critical, move_power)
    if dmg > 0 then
        add(s.actions, {
            active=o.active, message="#,-"..dmg..",hitpoints", logic=function()
                o.active.shared.hp = max(0, o.active.shared.hp-dmg)
            end
        })

    -- otherwise, it is splash for now i guess
    else
        add(s.actions, {active=s.active, message="#,does,nothing", logic=nop})
    end
end

-- turn_actions = {
--   message?                  -- lowered attack
--   function (does something) -- takes attack down 1
--   koed!
-- }

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

