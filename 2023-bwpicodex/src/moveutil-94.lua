-- moveutil: functions that are not an actual move mapping itself, but used to combine/simplify logic for actual move mappings.
-- if a function isn't used by a move mapping directly or derivatively, it doesn't belong in moveutil.

-- naming convention for all functions in this file is: f_moveutil_onewordnounderscore

-- There are a few layers of setting damage moves go through.
-- f_moveutil_hpchange: a function that shares logic between healing and damaging moves. healing moves call this directly, damaging indirectly through f_moveutil_dmg. recoil damage calls this directly as well.
-- f_moveutil_dmgother: all damage that goes to the opponent goes through this function, so that applicable logic passes through.

-- return of true means the hpchange failed. aka amount is zero
|[f_moveutil_hpchange]| function(player, amount, callback_function, issub)
  -- ensure amount is in bounds. TODO: verify this logic
  local pkmn = player.active
  local hp = issub and pkmn.substitute or pkmn.hp
  callback_function = callback_function or f_nop

  amount = mid(amount > 0 and hp or -pkmn.maxhp + hp, amount, 0)

  local dmgtxt = (amount > 0 and "-" or "+")..abs(amount).." hp change"

  local hpchange = function()
    a_self_active.hp -= amount
    if a_self_active.hp <= 0 then
      a_self_active.base.major = C_MAJOR_FAINTED
    end
  end

  -- situations where this would be zero:
  -- - try to heal when hp is full
  -- - false swipe 0 dmg
  if amount == 0 then
    return true
  else
    local amount_str = (amount > 0 and "-" or "+")..abs(amount)
    local text = issub and "substitute "..amount_str.." hp" or amount_str.." hp change"
    a_addaction(player, text, function()
      if issub then
        hpchange()

        if pkmn.substitute <= 0 then
          a_addaction(player,
            "substitute broke",
            function()
              callback_function(amount)
            end
          )
        else
          callback_function(amount)
        end
      else
        a_addaction(p_self, text, function()
          hpchange()
          callback_function(amount)
        end)
      end
    end)
  end
end $$

|[f_moveutil_dmgself]| function(dmg)
  -- TODO: some logic could go here, like focus band or endure (can protect against self-inflicted damage)
  return f_moveutil_hpchange(a_turnself, dmg)
end $$

-- all opponent dmg goes through here. based on code from OG picodex.
-- dmg:      either a move object or a number representing an amount of damage.
-- callback_function: if the move did damage, do this function, param to the function is the actual amount of damage done
-- returns true when the hp change is zero and not resisted (eg: protect or maybe falseswipe 1hp)
|[f_moveutil_dmgother]| function(dmg, callback_function)
  callback_function = callback_function or f_nop
  local advantage, crit = 1 -- implied nil/false
  if type(dmg) == "table" then
    dmg, advantage, crit = f_moveutil_calc_move_damage(dmg, a_self_active, a_other_active)
  end

  -- zero damage only means that attack was resisted. moves with set damage don't monitor resistance.
  if advantage > 0 then
    if advantage > 1     then a_addaction(p_self, "super effective")
    elseif advantage < 1 then a_addaction(p_self, "not very effective") end
    if crit then a_addaction(p_self, "critical hit") end

    return f_moveutil_hpchange(p_other, dmg, function(dmg)
      -- TODO: rage/bide logic can go here?
      -- TODO: counter/mirrorcoat logic might go here? It did in the OG picodex
      callback_function(dmg)
    end, a_other_active.substitute > 0)
  else
    a_addaction(p_other, "resisted attack")
  end
end $$

-- calculates the "movemod" variable that is used in the damage formula. This is a multiplier that changes based on special conditions. Like certain moves or move plus weather condition, etc. Or move state.
|[f_moveutil_movemod]| function(active, move)
  printh(a_other_active.nextmove)
  if f_in_split(move.num, 'M_EXPLOSION,M_SELFDESTRUCT') or not p_other.nextmove then
    return 2
  end
  return 1
  -- movemod: must be <= 32 to prevent any possible number overflow
  --   rollout:    2^(n+d) -- n=times, d=defcurl and 1 or 0
  --   furycutter: 2^n     -- n=times
  --   rage:       num of times user damaged while using rage
  --   triplekick: 1, 2, then 3 for each kick
  --   pursuit:    2 -- if target is switching
  --   stomp:      2 -- if target minimized
  --   gust:       2 -- if target is flying
  --   twister:    2 -- if target is flying
  --   earthquake: 2 -- if target is digging
  --   magnitude:  2 -- if target is digging
  --   explosion:  2 -- always
  --   selfdstrct: 2 -- always
  --   payday:     3 -- if holding amulet coin
  --   rain:       1.5 -- if water pktype move is used during rain
  --   sun:        1.5 -- if solar beam or fire pktype move used during sunlight
  --   rain:       .5  -- if solar beam or fire pktype move used during rain
  --   sun:        .5  -- if water pktype move is used during sun
  --   else:       1 -- for every other scenario
end $$

|[f_moveutil_typeadv]| function(move, defender)
  return (c_types[move.pktype][defender.type1] or 1)*(c_types[move.pktype][defender.type2] or 1)
end $$

--   ((.44*power*att/def)*item*crit+2)*weather*stab*movemod*pktype*random
-- damage formula: https://bulbapedia.bulbagarden.net/wiki/Damage#Generation_II
|[f_moveutil_calc_move_damage]| function(move, attacker, defender)
  -- BEGIN: PHYSICAL/SPECIAL
  local attack, defense = attacker:f_stat_calc('specialattack', true), defender:f_stat_calc('specialdefense', true)
  if move.pktype % 2 == 1 then -- iscontact
    attack, defense = attacker:f_stat_calc('attack', true), defender:f_stat_calc('defense', true)
  end

  -- BEGIN: CRIT
  -- TODO: really implement all the stuff here (focus energy, etc)
  local crit = rnd'1' < f_stat_crit(0)
  local stab = (move.pktype == attacker.pktype1 or move.pktype == attacker.pktype2) and 1.5 or 1
  local itemdmg = 1 -- TODO: fill this out! item is 1.1 if move pktype equals item specialty for type boost items

  local base_damage = mid( -- min: .44*1*.2*1*1+2 = 2.088 | max: .44*999*10*1.1*2+2 = 9672.32
      1, 999,
      .44*move.pow
      *mid(10, .2, attack/defense) -- this .2 to 10 ratio range comes from the original picodex. it exists to bound minimum and maximum damages
      *itemdmg
      *(crit and 2 or 1)+2
  )

  -- min: 1*1*.25 = .25 | max: 999*1.5*4 = 5994
  local advantage = f_moveutil_typeadv(move, defender)
  base_damage = mid(1, 999, base_damage*stab*advantage)

  -- min: 1*1 = 1 | max: 999*32 = 31968
  printh("movemod "..f_moveutil_movemod(attacker, move))
  base_damage = mid(1, 999, base_damage*f_moveutil_movemod(attacker, move)*(rnd'.15'+.85))

  return base_damage\1, advantage, crit
end $$
