-- every function in this file is prepended with f_move_
-- these are the different functions a move could implement

-- called for splash, but also when a move fails
-- TODO: idea, maybe splash could actually just go through a 0 dmg tackle. but maybe this is a bad idea. idk!
|[f_move_splash]| function() a_addaction(p_self, "does nothing") end $$
|[f_move_recover]| function(_ENV) return f_moveutil_hpchange(p_self, -a_self_active.maxhp\2) end $$

-- moves like cut/surf/tackle. the move only does damage with no other side effect
|[f_move_tackle]| function(_ENV)
  f_moveutil_dmgother(_ENV)
end $$

|[f_move_seismictoss]| function(_ENV) f_moveutil_dmgother(spec) end $$ -- also: night shade, sonicboom, dragonrage
|[f_move_psywave]|     function()     f_moveutil_dmgother(f_flr_rnd'75'+1) end $$

|[f_move_superfang]|  function() f_moveutil_dmgother(ceil(a_other_active.hp/2)) end $$
|[f_move_falseswipe]| function(_ENV)
  -- TODO: remove local variable... can i? since there are multiple return values.. maybe :D
  local dmg = f_moveutil_calc_move_damage(_ENV, a_self_active, a_other_active)
  return f_moveutil_dmgother(min(a_other_active.hp-1, dmg)) -- there is a zero check in the damage function already, which will fail false swipe
end $$

|[f_move_submission]| function(_ENV)
  f_moveutil_dmgother(_ENV, function(dmg)
    f_moveutil_dmgself(p_other, ceil(dmg/4))
  end)
end $$
