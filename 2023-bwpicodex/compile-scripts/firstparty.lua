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

firstparty = [[
  P_BULBASAUR  G_MALE I_BERRY M_TACKLE  M_GROWL    M_VINEWHIP  M_LEECHSEED
  P_CHARMANDER G_FEMA I_BERRY M_SCRATCH M_GROWL    M_EMBER     M_SMOKESCREEN
  P_SQUIRTLE   G_MALE I_BERRY M_TACKLE  M_TAILWHIP M_BUBBLE    M_WITHDRAW
  P_CHIKORITA  G_FEMA I_BERRY M_TACKLE  M_GROWL    M_RAZORLEAF M_REFLECT
  P_CYNDAQUIL  G_MALE I_BERRY M_TACKLE  M_LEER     M_EMBER     M_SMOKESCREEN
  P_TOTODILE   G_FEMA I_BERRY M_SCRATCH M_LEER     M_WATERGUN  M_RAGE
]]
