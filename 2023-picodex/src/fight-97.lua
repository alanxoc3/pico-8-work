-- todo: implement player selection
-- todo: make fightover accept losing pl instead of winning pl. less tokens that way
-- todo: implement a "one of" function, so you don't have these long if statements. And check if it saves tokens. gets rid of "x == y or x == z or ..."

-- pl,1-4,false - select a move slot  are move slots
-- pl,0,false   - select default move (solar beam charge, hyper beam recharge, struggle, ...)
-- pl,1-6,true  - switch with party slot
function select_move(pl, slot, switch)
    pl.actions = {}
    local priority_class = C_PRIORITY_ATTACK

    if switch then
        priority_class = C_PRIORITY_SWITCH
    else
        local move = pl.active.moveids[slot] or M_STRUGGLE
        addaction(pl, pl, "#,uses,"..c_moves[move].name, function(s, o) -- self, other
            generic_attack(s, o, slot)
        end)

        -- hardcoding the only moves that can change priority for now. Maybe there is a more token efficient way to do this?
        if move == M_QUICK_ATTACK then priority_class = C_PRIORITY_QUICKATTACK end
        if move == M_COUNTER or move == M_WHIRLWIND or move == M_ROAR or move == M_TELEPORT then
            priority_class = C_PRIORITY_COUNTER
        end
    end

    -- speed can be between 1 and 999, so multiples of 1000 can be priority
    -- highest priority goes first. if priority is same, roll a dice to decide
    pl.priority = min(C_PRIORITY_SWITCH, priority_class+pl.active:getstat'speed')
end

|[turn_init]| function(game)
    -- if there is no action, assume it's a computer player.
    for p in all{game.p1, game.p2} do
        if #p.actions == 0 then
            select_move(p, select_random_move_slot(p.active))
        end
    end

    -- p0 is equal to the higher priority
    local p1, p2 = game.p1, game.p2
    if p1.priority == p2.priority then p2.priority += sgn(rnd'2'-1) end
    game.p0 = p1.priority > p2.priority and p1 or p2
end $$

|[turn_update]| function(game)
    if g_bpx or g_bpo or not game.cur_action then
        -- check for win condition before selecting every action
        for p in all{game.p1, game.p2} do
            if not get_next_active(p.party) then
                game.p0 = get_other_pl(game, p)
                game:load'fightover'
                return
            end
        end

        local action = pop_next_action(game)
        if action then
            game.cur_action = action
            local actionpl = game.cur_action.active == game.p1.active and game.p1 or game.p2

            action.logic(actionpl, get_other_pl(game, actionpl), game)
        else
            game:load() -- next turn
        end
    end
end $$

function get_other_pl(game, pl)
    return pl == game.p1 and game.p2 or game.p1   
end

function draw_hp(x, y, hp, maxhp, status, align, col)
    hp = max(ceil(hp), 0)
    zprint(hp,           x+3*max(align, 0), y-2+5*align, col, align)
    zprint(status or "", x+3*max(align, 0), y-2-5*align, col, align)
    rectfill(x, y-1, x-align*ceil(hp/maxhp*17), y+1, col)
end

|[turn_draw1]|  function(game)
    local a1, a2, active = game.p1.active, game.p2.active, game.cur_action.active
    draw_hp(38, 30, a1.shared.hp, a1.shared.maxhp, a1.shared.major, 1,  active == game.p1.active and 6 or 1)
    draw_hp(1,  9,  a2.shared.hp, a2.shared.maxhp, a2.shared.major, -1, active == game.p2.active and 6 or 1)
    c_pokemon[a1.shared.num].draw(   10, 40-10-t()%2\1, 5)
    c_pokemon[a2.shared.num].draw(40-10,    10+t()%2\1, 5, -1)
end $$

|[turn_draw2]|  function(game)
    print_draw2_message(game.cur_action.pl.name)
end $$

|[turn_draw3]|  function(game)
    local message_tbl = split(game.cur_action.message)
    if message_tbl[1] == '#' then message_tbl[1] = c_pokemon[game.cur_action.active.shared.num].name end
    print_draw3_message(message_tbl)
end $$

---------------------------------------------------------------------------
-- misc stuff
---------------------------------------------------------------------------
function newaction(pactive, message, logic)
    return {pl=pactive, active=pactive.active, message=message, logic=logic or nop}
end

function addaction(p0, ...)
    add(p0.actions, newaction(...))
end

-- switch if there is a next pokemon
-- otherwise, do nothing. turn logic will check every turn if there is a win condition
function logic_faint(s)
    s.active.shared.major = C_MAJOR_FAINTED
    local na = get_next_active(s.party)

    if na then
        s.active = party_pkmn_to_active(get_next_active(s.party))
        addaction(s, s, "#,comes,out")
    end
end

-- self pl, other pl
-- return faint action if no hp and not dead
-- return nothing if end of turn
function pop_next_action(game)
    -- if an active pokemon has no hp, but not the faint status yet, return an action that makes the pokemon faint.
    for p in all{game.p1,game.p2} do
        if p.active.shared.hp <= 0 and p.active.shared.major ~= C_MAJOR_FAINTED then
            return newaction(p, "#,is,fainted", logic_faint)
        end
    end

    for s in all{game.p0, get_other_pl(game, game.p0)} do
        local o = get_other_pl(game, s)

        -- if the active pokemon shouldn't faint right now, find the next action that references a pokemon still on the field.
        while #s.actions > 0 do
            local action = deli(s.actions, 1)
            if action.active.shared.major ~= C_MAJOR_FAINTED and (action.active == s.active or action.active == o.active) then
                return action
            end
        end
    end
end

-- returns move slot number. 0 means to use struggle.
function get_possible_move_slots(active)
    local possible_moves = {}

    for i=1,4 do
        if active.moveids[i] and active.movepps[i] > 0 then
            add(possible_moves, i)
        end
    end

    return possible_moves
end

function select_random_move_slot(active)
    local possible_moves = get_possible_move_slots(active)
    return possible_moves[flr_rnd(#possible_moves)+1] or M_STRUGGLE
end

-- [s]elf pl, [o]ther pl, [m]ove slot
function generic_attack(s, o, m)
    local move = c_moves[s.active.moveids[m] or 0]

    -- should only be nil for struggle?
    if move.num != 0 then
        s.active.movepps[m] -= 1
    end

    local dmg = move.damage -- calc_move_damage(s.active.shared.lvl, s.active.shared.attack, defense, critical, move_power)
    if dmg > 0 then
        addaction(s, o, "#,-"..dmg..",hitpoints", function()
            o.active.shared.hp = max(0, o.active.shared.hp-dmg)
        end)

    -- otherwise, it is splash for now i guess
    else
        addaction(s, s, "#,does,nothing")
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

function calc_move_damage(lvl, attack, defense, critical, move_power)
    -- critical is 1 or 2
    -- need function for attack/defense ratio to prevent divide by zero
    -- base_damage can be a max of 997
    local base_damage = (2*lvl*critical/5+2)*move_power*(attack/defense)/50+2

    -- stab is 1.5 of base damage if move type equals pkmn type
    -- types are .5, 1, or 2, based on move's effectivenes against the opposing dual type pokemon
    -- random is between 217/255 and 255/255 inclusive
    return base_damage*stab*type1*type2*random
end

