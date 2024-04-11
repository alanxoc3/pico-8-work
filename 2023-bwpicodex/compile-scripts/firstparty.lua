-- Saves the first party data to storage. This is used only for new games.

function init() -- entry point for this compile script
  local statarr = {}
  for arr in all(datastr_to_arr(firstparty)) do
    for val in all(arr) do
      offsetpoke(val)
    end
  end

  log("Wrote First Party Data")
end

-- the level is +1, because lvl 0 is impossible. So levels are actually "50"
-- the moves are specific to each pokemon and would have to change if move orders change.
-- so yeah, don't change the move stuff unless you know what you're doing
-- pkmn ind    gender item   lvl moves.............
firstparty = [[
  --                        tackle growl     leechseed   none
  P_BULBASAUR  0 I_BERRY 49 19     7         6           0

  --                        scratch growl    ember       none
  P_CHARMANDER 1 I_BERRY 49 12      6        7           0

  --                        tackle  tailwhip bubble      none
  P_SQUIRTLE   0 I_BERRY 49 18      7        10          0

  --                        tackle  growl    razorleaf   none
  P_CHIKORITA  1 I_BERRY 49 17      8        5           0

  --                        tackle  leer     smokescreen none
  P_CYNDAQUIL  0 I_BERRY 49 12      8        6           0

  --                        scratch leer     rage        none
  P_TOTODILE   1 I_BERRY 49 8       12       14          0
]]
