-- todo: make it so showing a different player's stats also shows their name in draw2.
-- todo: need something that takes percent & function for moves that have 10% chance to do something extra.

-- todo: initial wave: make every move do things (rest sets sleep...)
-- todo: second wave: make states actually have an effect and unset properly (dig/rest/poison....)

-- returns true if it increased, false otherwise
|[f_movehelp_incstat]| function(a, stat, inc)
    local prev = a.stages[stat] or 0
    a.stages[stat] = mid(-6, 6, prev+inc)
    return prev ~= a.stages[stat]
end $$

|[f_movehelp_getstat]| function(a, stat)
    -- evasion and accuracy have a different formula: https://www.smogon.com/rb/articles/stadium_guide
    -- all stats cap at 999: https://www.smogon.com/rb/articles/rby_mechanics_guide
    -- and i'm giving it a _min of 1 too, because zero messes things up

    local stage = a.stages[stat] or 0
    return _ceil(_mid(1, 999,
        a[stat]*(
            (stat == 'evasion' or stat == 'accuracy')
            and _mid(1, 1+stage/3, 3)/_mid(1, 1-stage/3, 3)
             or _mid(2, 2+stage,   8)/_mid(2, 2-stage,   8)
        )
    ))
end $$

-- move utility funcs
|[f_movehelp_update_pp]| function(move)
    -- only less than 0 for struggle and none moves. none move would never be selected though
    if move.num > 0 then
        move.pp -= 1
    end
end $$

--------------------------------
---------- move funcs ----------
--------------------------------
|[f_move_stat_self]| function(move, self, other, key, stage)
    f_movehelp_update_pp(move)

    -- todo: add message if stat does not increase
    if f_movehelp_incstat(self.active, key, stage) then
        -- todo: token crunch create function that formats a num with +/- & apply it to move_stat_self and battle logic
        f_addaction(self, self, "|+"..stage.."/6|"..key)
    else
        f_addaction(self, self, "|failed|"..move.name)
    end
end $$

-- todo: token crunch, combine logic with move_stat_self
|[f_move_stat_other]| function(move, self, other, key, stage)
    f_movehelp_update_pp(move)

    if f_does_move_miss(self.active, other.active, move) then
        -- todo: token crunch combine missed logic with default move
        f_addaction(self, self, "|missed|"..move.name)
    else
        -- todo: add message if stat does not increase
        if f_movehelp_incstat(other.active, key, stage) then
            -- todo: token crunch create function that formats a num with +/- & apply it to move_stat_self and battle logic
            f_addaction(self, other, "|-"..abs(stage).."/6|"..key)
        else
            f_addaction(self, self, "|failed|"..move.name)
        end
    end
end $$

|[f_move_transform]| function(move, self, other)
    f_movehelp_update_pp(move)

    if self.active.transform then
        f_addaction(self, self, "|failed|transform")
    else
        f_addaction(self, self, "|copied|"..other.active.name, function()
            self.active.transform = true
            self.active.num     = other.active.num
            self.active.attack  = other.active.attack
            self.active.defense = other.active.defense
            self.active.speed   = other.active.speed
            self.active.special = other.active.special
            self.active.type1   = other.active.type1
            self.active.type2   = other.active.type2

            self.active.mynewmoves = {}
            foreach(other.active.mynewmoves, function(m)
                local newmove = f_create_move(m.num)
                newmove.pp, newmove.maxpp = 5, 5
                _add(self.active.mynewmoves, newmove)
            end)
        end)
    end
end $$

|[f_move_default]| function(move, self, other)
    f_movehelp_update_pp(move)

    local dmg = f_calc_move_damage(self.active, other.active, move)
    if dmg > 0 then
        if f_does_move_miss(self.active, other.active, move) then
            f_addaction(self, self, "|missed|"..move.name)
        else
            f_addaction(self, other, "|-"..dmg.."|hitpoints", function()
                other.active.shared.hp = _max(0, other.active.shared.hp-dmg)
            end)
        end
    -- otherwise, it is splash for now i guess
    else
        f_addaction(self, self, "|does|nothing")
    end
end $$
