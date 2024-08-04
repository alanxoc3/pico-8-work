-- moveutil: functions that are not an actual move mapping itself, but used to combine/simplify logic for actual move mappings.
-- if a function isn't used by a move mapping directly or derivatively, it doesn't belong in moveutil.

-- naming convention for all functions in this file is: f_moveutil_onewordnounderscore

-- There are a few layers of setting damage moves go through.
-- f_moveutil_hpchange: a function that shares logic between healing and damaging moves. healing moves call this directly, damaging indirectly through f_moveutil_dmg. recoil damage calls this directly as well.
-- f_moveutil_dmgother: all damage that goes to the opponent goes through this function, so that applicable logic passes through.

-- this is used by sandstorm/leech/mare/burn/poison/struggle, anything that self inflicts a percentage of damage based on maxhp.
|[f_hurt_self]| function(hurtby, divide, activation)
  if activation then
    -- TODO: from what I can tell, divide is a floor operation, not a ceil. I could technically save a token by making it floor, but then i lose a KO in exact number of turns. Think about it bro!
    f_turn_addattack(p_turn_self, "hurt by "..hurtby)
    f_moveutil_dmgself(ceil(p_turn_self_active.maxhp/divide))
  end
end $$

-- return of true means the hpchange failed. aka amount is zero
|[f_moveutil_hpchange]| function(player, amount, callback_function, issub)
  -- ensure amount is in bounds. TODO: verify this logic
  local pkmn = player.active
  local hp = issub and pkmn.substitute or pkmn.hp
  callback_function = callback_function or f_nop

  amount = mid(amount > 0 and hp or -pkmn.maxhp + hp, amount, 0)

  local dmgtxt = (amount > 0 and "-" or "+")..abs(amount).." hp change"

  local hpchange = function()
    p_action_self_active.base.hp -= amount
    if p_action_self_active.base.hp <= 0 then
      p_action_self_active.base.major = C_MAJOR_FAINTED
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
    f_turn_addattack(player, text, function()
      if issub then
        hpchange()

        if pkmn.substitute <= 0 then
          f_turn_addattack(player,
            "substitute broke",
            function()
              callback_function(amount)
            end
          )
        else
          callback_function(amount)
        end
      else
        f_turn_addattack(p_action_self, text, function()
          hpchange()
          callback_function(amount)
        end)
      end
    end)
  end
end $$

|[f_moveutil_dmgself]| function(dmg)
  -- TODO: some logic could go here, like focus band or endure (can protect against self-inflicted damage)
  return f_moveutil_hpchange(p_turn_self, dmg)
end $$

-- all opponent dmg goes through here. based on code from OG picodex.
-- dmg:      either a move object or a number representing an amount of damage.
-- callback_function: if the move did damage, do this function, param to the function is the actual amount of damage done
-- returns true when the hp change is zero and not resisted (eg: protect or maybe falseswipe 1hp)
|[f_moveutil_dmgother]| function(dmg, callback_function)
  callback_function = callback_function or f_nop
  local advantage, crit = 1 -- implied nil/false
  if type(dmg) == "table" then
    dmg, advantage, crit = f_moveutil_calc_move_damage(dmg, p_turn_self_active, p_turn_other_active)
  end

  -- zero damage only means that attack was resisted. moves with set damage don't monitor resistance.
  if advantage > 0 then
    f_zcall([[ -- using zcall saves a few tokens
       ;,~f_turn_addattack ,~p_action_self ,@
      ;;,~f_turn_addattack ,~p_action_self ,@
    ]], advantage > 1 and "super effect" or advantage < 1 and "little effect", crit and "critical hit")

    return f_moveutil_hpchange(p_turn_other, dmg, function(dmg)
      -- TODO: rage/bide logic can go here?
      -- TODO: counter/mirrorcoat logic might go here? It did in the OG picodex
      callback_function(dmg)
    end, p_turn_other_active.substitute > 0)
  else
    f_turn_addattack(p_turn_other, "resists attack")
  end
end $$

-- calculates the "movemod" variable that is used in the damage formula. This is a multiplier that changes based on special conditions. Like certain moves or move plus weather condition, etc. Or move state.
|[f_moveutil_movemod]| function(active, move)
  -- TODO: token crunching here. maybe a func that takes pairs of bools, idk.
  if f_in_split(move.num, 'M_EXPLOSION,M_SELFDESTRUCT')
    or move.num == M_PURSUIT and not p_action_other.nextmove then
    return 2
  elseif move.num == M_TRIPLEKICK then
    return p_turn_self_active.numtimes
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
  return (c_types[move.pktype][defender.pktype1] or 1)*(c_types[move.pktype][defender.pktype2] or 1)
end $$

-- ((.44*power*att/def)*item*crit+2)*weather*stab*movemod*pktype*random
-- damage formula: https://bulbapedia.bulbagarden.net/wiki/Damage#Generation_II
|[f_moveutil_calc_move_damage]| function(move, attacker, defender)
  -- BEGIN: PHYSICAL/SPECIAL
  local attack, defense = attacker:f_stat_calc('specialattack', true), defender:f_stat_calc('specialdefense', true)
  if move.pktype % 2 == 1 then -- iscontact
    attack, defense = attacker:f_stat_calc('attack', true), defender:f_stat_calc('defense', true)
  end

  -- BEGIN: CRIT
  -- TODO: really implement all the stuff here (focus energy, etc)
  -- TODO: verify this is the correct crit logic
  local crit_count = p_turn_self_active.stages.crit
  if f_in_split(move.num, 'M_AEROBLAST,M_CRABHAMMER,M_CROSSCHOP,M_KARATECHOP,M_RAZORLEAF,M_SLASH,M_RAZORWIND') then crit_count += 1 end
  if p_turn_self_active.item == I_SCOPELENS                                                                    then crit_count += 1 end
  if p_turn_self_active.item == I_LUCKYPUNCH and p_turn_self_active.num == P_CHANSEY                           then crit_count += 2 end
  if p_turn_self_active.item == I_STICK      and p_turn_self_active.num == P_FARFETCHD                         then crit_count += 2 end

  local crit = rnd'1' < f_stat_crit(crit_count)
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
  base_damage = mid(1, 999, base_damage*f_moveutil_movemod(attacker, move)*(rnd'.15'+.85))

  return base_damage\1, advantage, crit
end $$

-- types that resist the move's type and opponents with types equal to the moves type means that the status effect doesn't apply/work.
|[f_movehelp_effect_works]| function(_ENV)
  -- TODO: I could probably make this smaller
  return f_moveutil_typeadv(_ENV, p_turn_other_active) > 0 and pktype ~= p_turn_other_active.pktype1 and pktype ~= p_turn_other_active.pktype2
end $$

|[f_move_major_other]| function(_ENV, majorind)
  -- if you thawed out, you won't get burned that turn
  if p_turn_other_active.major == C_MAJOR_FROZEN and majorind == C_MAJOR_BURNED then
    f_turn_addattack(p_turn_other, "thawed out", function()
      p_turn_other_active.base.major = C_MAJOR_NONE
    end)

  -- sing works on ghost pokemon and should. TODO: verify this logic is correct
  elseif p_turn_other_active.major == C_MAJOR_NONE and (majorind == C_MAJOR_SLEEPING or f_movehelp_effect_works(_ENV)) then
    f_turn_addattack(p_turn_other, "now "..c_major_names_long[majorind], function()
      p_turn_other_active.base.major = majorind

      -- every time major stat is set, sleep timer is set, but sleep timer isn't used unless pkmn is actually sleeping
      p_turn_other_active.sleeping = f_flr_rnd'7'+1 -- TODO: verify this is the correct number of turns for sleeping
      -- ^^ If I change the sleep timer amount, remember to change it somewhere else too!
    end)
  else
    return true
  end
end $$
