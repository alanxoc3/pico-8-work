|[f_minisfx]| function(num) -- plays a sfx with len of 4. num corresponds to pkmn numbers. 252, 253, 254, 255 are sfx.
  if num < P_NONE then
    g_cur_pkmn_cry = num -- initial g_cur_pkmn_cry value is the default nil
  end
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

|[f_roundrect]| function(x1, y1, x2, y2, c)
  rectfill(x1, y1+1, x2, y2-1, c)
  if x2-x1 > 2 then -- if check is for the hp bar, so it looks good when small.
    rectfill(x1+1, y1, x2-1, y2, c)
  end
end $$

|[f_draw_pkmn]| function(num, x, y, style, flip, selected, disabled, func)
  func = func or f_nop
  local in_c  = disabled and C_2 or selected and C_3 or C_2
  local out_c = disabled and C_1 or C_1
  local row = num/8\1
  local col = num%8
  local width = style == STYLE_SMALL and 6 or 16

  if (style ~= STYLE_SHAKE or disabled) and num == P_NONE then
    rectfill(x+width/2-1, y+width/2-1, x+width/2, y+width/2, disabled and C_2 or out_c)
    return
  end

  -- the "min" is needed to draw trainers
  if style == STYLE_SHAKE and selected and not disabled and stat'46' > -1 and g_cur_pkmn_cry == num then -- if a pkmn cry is currently playing and selected, shake!
    x += sin(g_shake_timer/4)
  end

  local row = num/8\1
  local col = num%8
  local width = style == STYLE_SMALL and 6 or 16

  local masks = {8, 4, 2, 1}
  local colordrawfunc = function(ix, iy, c)
    local mask = masks[num\64+1]
    for i=1,15 do
      if i & mask == 0 then
        palt(i, true)
      else
        pal(i, c)
      end
    end
    palt(mask, false)
    pal(mask, c)

    sspr(col*16, row%8*16, 16, 16, ix, iy, width, width, flip, false)

    palt()
    pal()
  end

  for yy=-1,1,1 do
    for xx=-1,1,1 do
      colordrawfunc(x+xx, y+yy, out_c)
    end
  end

  colordrawfunc(x, y, in_c) -- sprite
  func(x+(flip and -38+1 or 19+1),y)
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

-- TODO: does this need to be extracted into a function, or can it just run here?
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
