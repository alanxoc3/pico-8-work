-- every function in this file is prepended with f_move_
-- these are the different functions a move could implement

|[f_change_pp]| function()

end $$

-- healing is just negative damage
|[f_moveutil_damage]| function(player, amount)
  local pkmn = player.active
  printh("a "..amount)
  amount = mid(amount > 0 and pkmn.hp or -pkmn.maxhp + pkmn.hp, amount, 0)
  printh("b "..amount)

  -- situations where this would be zero:
  -- try to heal when hp is full
  if amount == 0 then
    f_move_splash()
  else
    local text = (amount > 0 and "-" or "+")..abs(amount).." hp change"
    a_addaction(player, text, function()
      a_addaction(p_self, text, function()
        a_self_active.hp -= amount
        if a_self_active.hp <= 0 then
          a_self_active.base.major = C_MAJOR_FAINTED
        end
      end)
    end)
  end
end $$

-- called for splash, but also when a move fails
|[f_move_splash]| function()
  a_addaction(p_self, "does nothing")
end $$

-- moves like cut/surf/tackle. the move only does damage with no other side effect
|[f_move_damage]| function(_ENV)
  local dmg = f_calc_move_damage(a_self_active, a_other_active, _ENV)
  f_moveutil_damage(p_other, dmg)
end $$

|[f_move_seismictoss]| function(_ENV) printh("SPEC ".. spec) f_moveutil_damage(p_other, spec)     end $$ -- also: night shade, sonicboom, dragonrage
|[f_move_psywave]|     function()     f_move_seismictoss(f_flr_rnd'75'+1) end $$

|[f_move_heal]| function(_ENV) f_moveutil_damage(p_self, -a_self_active.maxhp\2) end $$ -- softboiled, recover, milk drink
