-- every function in this file is prepended with f_move_
-- these are the different functions a move could implement

|[f_move_splash]| function()
  a_addaction(p_self, "does nothing")
end $$

-- moves like cut/surf/tackle. the move only does damage with no other side effect
|[f_move_damage]| function()
  --a_self_active
  local dmg = f_calc_move_damage(a_self_active, a_other_active, p_self.nextmove)
  dmg = mid(a_other_active.hp, dmg, 0)
  local text = "-"..dmg.." hp change"
  a_addaction(p_other, text, function()
    a_addaction(p_self, text, function()
      a_self_active.hp -= dmg
      if a_self_active.hp <= 0 then
        a_self_active.base.major = C_MAJOR_FAINTED
      end
    end)
  end)
end $$
