-- this is called on startup to populate c_moves
|[f_populate_c_moves]| function()
    for i=-1,#c_moves_raw do
        local move = c_moves_raw[i]
        local params = {}
        for i=7,#move do _add(params, move[i]) end
        c_moves[i] = f_zobj([[
            name,@, type,@, pp,@, maxpp,~pp, damage,@, accuracy,@, func,@, num,@
        ]], move[1],
            move[2],
            move[3],
            move[4],
            move[5],
            function(m, p0, other)
                return move[6](m, p0, other, _unpack(params))
            end,
            i
        )
    end
end $$

|[f_get_natural_moveset]| function(num)
    local pkmn, moveset = c_pokemon[num], f_create_empty_moveset()
    for i=1,min(4,#pkmn.moves_natural) do
        moveset[i] = f_create_move(pkmn.moves_natural[i])
    end
    return moveset
end $$

-- move is between -1 and 
|[f_create_move]| function(id)
    return _setmetatable(f_zobj[[]], {__index=c_moves[id]})
end $$

|[f_create_empty_moveset]| function()
    local moveset = {}
    for i=1,4 do _add(moveset, f_create_move(-1)) end
    return moveset
end $$

--------------------------------
---------- move funcs ----------
--------------------------------
|[f_move_stat_self]| function(move, self, other, key, stage)

end $$

|[f_move_default]| function(move, self, other)
    -- only less than 0 for struggle and none moves. none move would never be selected though
    if move.num > 0 then
        move.pp -= 1
    end

    local dmg = f_calc_move_damage(self.active, other.active, move)
    if dmg > 0 then
        if f_does_move_miss(self.active, other.active, move) then
            f_addaction(self, self, "|missed|attack")
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

-- Meditate     Raises the user's Attack by 1 stage.
-- Sharpen      Raises the user's Attack by 1 stage.
-- Swords-Dance Raises the user's Attack by 2 stages.
-- Defense-Curl Raises the user's Defense by 1 stage.
-- Harden       Raises the user's Defense by 1 stage.
-- Withdraw     Raises the user's Defense by 1 stage.
-- Acid-Armor   Raises the user's Defense by 2 stages.
-- Barrier      Raises the user's Defense by 2 stages.
-- Double-Team  Raises the user's Evasion by 1 stage.
-- Minimize     Raises the user's Evasion by 1 stage.
-- Growth       Raises the user's Special by 1 stage.
-- Amnesia      Raises the user's Special by 2 stages.
-- Agility      Raises the user's Speed by 2 stages.

