-- every function in this file is prepended with f_move_
-- these are the different functions a move could implement

-- called for splash, but also when a move fails
-- TODO: idea, maybe splash could actually just go through a 0 dmg tackle. but maybe this is a bad idea. idk!
|[f_move_splash]| function() a_addaction(p_selfaction, "does nothing") end $$
|[f_move_recover]| function(_ENV) return f_moveutil_hpchange(p_selfaction, -a_self_active.maxhp\2) end $$

-- moves like cut/surf/tackle. the move only does damage with no other side effect
|[f_move_tackle]| function(_ENV)
  f_moveutil_dmgother(_ENV)
end $$

|[f_move_seismictoss]| function(_ENV) f_moveutil_dmgother(spec) end $$ -- also: night shade, sonicboom, dragonrage
|[f_move_psywave]|     function()     f_moveutil_dmgother(f_flr_rnd'75'+1) end $$

|[f_move_superfang]|  function() f_moveutil_dmgother(ceil(a_other_active.hp/2)) end $$ -- TODO: maybe this shouldn't be ceil and instead be floor with a min of 1
|[f_move_falseswipe]| function(_ENV)
  -- -- TODO: remove local variable... can i? since there are multiple return values.. maybe :D
  -- local dmg = f_moveutil_calc_move_damage(_ENV, a_self_active, a_other_active)
  -- return f_moveutil_dmgother(min(a_other_active.hp-1, dmg)) -- there is a zero check in the damage function already, which will fail false swipe
end $$

|[f_move_submission]| function(_ENV)
  f_moveutil_dmgother(_ENV, function(dmg)
    f_moveutil_dmgself(ceil(dmg/4))
  end)
end $$

-- TODO: Currently, struggle loses pp. Fix this, it should remain constant pp.
|[f_move_struggle]| function(_ENV)
  f_moveutil_dmgother(_ENV, function(dmg)
    f_moveutil_dmgself(ceil(p_selfturn.active.maxhp/4))
  end)
end $$

|[f_move_multihit_set]| function(_ENV, hitcount, isresume)
  -- if hitcount > 0 then
  --   a_addaction(p_selfturn, isresume and "resumes "..name, function()
  --     p_selfturn.active.numtimes += 1
  --     f_moveutil_dmgother(_ENV, function()
  --       f_move_multihit_set(_ENV, hitcount-1, true)
  --     end)
  --   end)
  -- end
end $$

|[f_move_barrage]| function(_ENV)
  -- f_move_multihit_set(_ENV, 2+f_flr_rnd'4')
end $$

|[f_move_doublekick]| function(_ENV)
  -- f_move_multihit_set(_ENV, spec)
end $$

|[f_move_flail]| function(_ENV)
  -- TODO: token crunch
  local hplist = f_zobj[[;,.7,20;;,.4,40;;,.2,80;;,.1,100;;,.05,150]]
  local perc = p_selfturn.active.hp/p_selfturn.active.maxhp
  local pow = 200 -- hpperc < 5%

  for pair in all(hplist) do
    if perc > pair[1] then
      pow = pair[2]
      break
    end
  end

  f_moveutil_dmgother(f_zobj_setmeta(_ENV, [[pow,@]], pow))
end $$

|[f_move_return]| function(_ENV)
  local is_happy = p_selfturn.active.hp/p_selfturn.active.maxhp >= p_otherturn.active.hp/p_otherturn.active.maxhp
  f_moveutil_dmgother(f_zobj_setmeta(_ENV, [[pow,@]], is_happy and 100 or 50))
end $$

|[f_move_frustration]| function(_ENV)
  local is_sad = p_selfturn.active.hp/p_selfturn.active.maxhp <= p_otherturn.active.hp/p_otherturn.active.maxhp
  f_moveutil_dmgother(f_zobj_setmeta(_ENV, [[pow,@]], is_sad and 100 or 50))
end $$

|[f_move_present]| function(_ENV)
  -- local perc, pow = rnd() -- implied nil
  -- for pair in all(f_zobj[[;,.2,120;;,.3,80;;,.6,40]]) do
  --   if perc > pair[1] then
  --     pow = pair[2]
  --   end
  -- end

  -- if pow then
  --   f_moveutil_dmgother(f_zobj_setmeta(_ENV, [[pow,@]], pow))
  -- else
  --   return f_moveutil_hpchange(p_otherturn, -p_otherturn.active.maxhp\4)
  -- end
end $$

|[f_move_magnitude]| function(_ENV)
  -- magnitude is between 4-10 representing how powerful the magnitude was.
  local perc, num, pow = rnd()
  for i, pair in ipairs(f_zobj[[;,0,10;;,.05,30;;,.15,50;;,.35,70;;,.65,90;;,.85,110;;,.95,150]]) do
    if perc >= pair[1] then
      pow, num = pair[2], i+3
    end
  end

  -- safe to add 2 actions next to each other, because there is no function/effect on the first one.
  a_addaction(p_selfturn, "magnitude "..num)
  f_moveutil_dmgother(f_zobj_setmeta(_ENV, [[pow,@]], pow))
end $$

-- TODO: currently hidden power saves the new type to the bench version. I don't think I want that.
-- TODO: what other moves change the move just for active but keep pp. Mimic does, but needs to keep pp.
|[f_move_hiddenpower]| function(_ENV)
  local possible_types = {}
  for i=T_NORMAL,T_BIRD do
    local v = f_moveutil_typeadv(f_zobj_setmeta(_ENV, [[pktype,@]], i), p_otherturn.active)
    if v > 1 then
      add(possible_types, i)
    end
  end

  -- TODO: T_BIRD could be removed, since there are no pokemon with zero type weaknesses in first 2 gens. Sableye and Spiritomb were the only ones at one point.
  -- Missingno is likely the closest to this. It is only weak against bird type. It resists everything else except fighting which just does normal amount of damage.
  local newpktype = #possible_types > 0 and possible_types[f_flr_rnd(#possible_types)+1] or T_BIRD
  a_addaction(p_selfturn, "type "..c_type_names[newpktype])

  -- TODO: maybe i can set pow to 60 as part of the compiled data
  -- TODO: the newpktype should reset when switching out the move.
  pktype = newpktype
  f_moveutil_dmgother(f_zobj_setmeta(_ENV, [[pow,@]], 60))
end $$
