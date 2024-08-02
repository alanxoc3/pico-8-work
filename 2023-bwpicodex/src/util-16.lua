-- TODO: see if a roundrect function could be implemented that supports changing the 4 corners and used in the grid cell + hp bar. only do it if it saves tokens.

|[f_minisfx]| function(num) -- plays a sfx with len of 4. num corresponds to pkmn numbers. 252, 253, 254, 255 are sfx.
  sfx(num\4, num < P_NONE and 0 or 1, num%4*8, 8)
end $$

|[f_flr_rnd]| function(n) return flr(rnd(n)) end $$

|[f_in_split]| function(val, str)
  for m in all(split(str)) do
    if m == val then
      return true
    end
  end
end $$

|[f_draw_pkmn]| function(num, x, y, style, flip, selected, disabled, draw_side)
  local width = g_style_size[style]

  -- P_NONE is shared with the substitute sprite, so need some special logic
  if num == P_NONE and (style ~= STYLE_SHAKE or disabled) then
    rectfill(x+width-1, y+width-1, x+width, y+width, disabled and C_2 or C_1)
    return
  end

  -- the "min" is needed to draw trainers
  if style == STYLE_SHAKE and selected and not disabled and num == stat'46'*4+stat'50'\8 then -- if a pkmn cry is currently playing and selected, shake!
    x += sin(g_shake_timer/4)
  end

  local colordrawfunc = function(ix, iy, c)
    for i=1,15 do
      palt(i, i & g_draw_masks[num\64+1] == 0)
      pal(i, c)
    end

    -- can't use a zcall here because it's too slow
    sspr(num%8*16, num/8\1%8*16, 16, 16, ix, iy, width*2, width*2, flip, false)
    pal() -- dont need to reset palt because that doesn't affect print operations and this is the only function in the game that draws.
  end

  for yy=-1,1 do
    for xx=-1,1 do
      colordrawfunc(x+xx, y+yy, C_1)
    end
  end

  colordrawfunc(x, y, not disabled and selected and C_3 or C_2) -- sprite
  if draw_side then
    draw_side(x+(flip and -37 or 20), y)
  end
end $$

-- Turn a string into a question marks with the same length
|[f_strtoq]| function(s)
  local ns = ""
  for i=1,#s do ns ..= "?" end
  return ns
end $$

-- some util funcs used in the init file

|[f_init_peek_inc]| function()
  g_init_peek_loc += 1
  return @g_init_peek_loc
end $$

|[f_unlock]| function(list, ind)
  list[ind].lock = true
end $$

|[f_update_locks]| function(start_trnr) -- game lags with this function, so it should be called when there can be a lag. TODO: Or I could try speeding it up?
  foreach(f_zobj[[
    -- Only 2 items when you start the game.
     ;,~c_items, I_NONE
    ;;,~c_items, I_BERRY

    -- These are the moves used for the default party.
    -- TODO: Maybe I can use GROWL. I think Bulb/Chik/Charm are the 3 that can learn growl. not positive.
    ;;,~c_moves, M_STRUGGLE
    ;;,~c_moves, M_NONE
    ;;,~c_moves, M_LEECHSEED
    ;;,~c_moves, M_EMBER
    ;;,~c_moves, M_WATERGUN
    ;;,~c_moves, M_VINEWHIP
    ;;,~c_moves, M_TACKLE
    ;;,~c_moves, M_BITE
    ;;,~c_moves, M_TAILWHIP
    ;;,~c_moves, M_LEER
    ;;,~c_moves, M_SMOKESCREEN
    ;;,~c_moves, M_LIGHTSCREEN
    ;;,~c_moves, M_SCREECH

    ;;,~c_pokemon, P_BULBASAUR
    ;;,~c_pokemon, P_CHARMANDER
    ;;,~c_pokemon, P_SQUIRTLE
    ;;,~c_pokemon, P_CHIKORITA
    ;;,~c_pokemon, P_CYNDAQUIL
    ;;,~c_pokemon, P_TOTODILE
    ;;,~c_pokemon, P_NONE
  ]], function(obj)
    f_unlock(unpack(obj))
  end)

  if @S_NEW == 0 then
    for i, ind in ipairs(split'P_BULBASAUR,P_CHARMANDER,P_SQUIRTLE,P_CHIKORITA,P_CYNDAQUIL,P_TOTODILE') do -- 6 starter pokemon. the none pokemon should be unlocked too
      f_save_party_pkmn(f_mkpkmn(ind, c_pokemon[ind], true, 0, 0, 5, 5, 5, 5), 0, i-1) -- TODO: more crunching could be done here.
    end

    poke(S_NEW, 1)
    memset(S_PARTY2, P_NONE, 126) -- set the "NONE" pokemon to all the other slots. this is 0x7e, which is the length of 3 parties
  end

  for i=start_trnr,min(LEAGUE_HORDE, @S_STORY) do
    for pkmn in all(f_team_league(i, i\LEAGUE_HORDE*251+1)) do -- this math will do start the team at just missingno for the last team, that way missingno gets unlocked.
      f_unlock(c_pokemon, pkmn.num)
      f_unlock(c_items, pkmn.item)
      for i=1,4 do
        f_unlock(c_moves, pkmn[i].num)
      end
    end
  end
end $$
