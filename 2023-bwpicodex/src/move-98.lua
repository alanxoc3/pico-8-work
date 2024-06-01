-- every function in this file is prepended with f_move_
-- these are the different functions a move could implement

|[f_move_splash]| function()
  a_addaction(p_self, "does nothing")
end $$

-- moves like cut/surf/tackle. the move only does damage with no other side effect
|[f_move_damage]| function()
  --a_self_active
  printh("ay: "..debug(p_self.nextmove))
  local dmg = f_calc_move_damage(a_self_active, a_other_active, p_self.nextmove)
  a_addaction(p_other, "-"..dmg.."0 hp change")
end $$
