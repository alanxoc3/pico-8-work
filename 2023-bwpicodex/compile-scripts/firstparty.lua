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
  P_BULBASAUR  G_MALE I_BERRY M_SOLARBEAM    M_GROWTH       M_VINEWHIP     M_LEECHSEED
  P_CHARMANDER G_FEMA I_BERRY M_FLAMETHROWER M_FIRESPIN     M_DRAGONRAGE   M_GROWL
  P_SQUIRTLE   G_MALE I_BERRY M_HYDROPUMP    M_SKULLBASH    M_PROTECT      M_RAPIDSPIN
  P_CHIKORITA  G_FEMA I_BERRY M_SOLARBEAM    M_SYNTHESIS    M_RAZORLEAF    M_BODYSLAM
  P_CYNDAQUIL  G_MALE I_BERRY M_FLAMEWHEEL   M_QUICKATTACK  M_SUBMISSION   M_SMOKESCREEN
  P_TOTODILE   G_FEMA I_BERRY M_WATERGUN     M_CRUNCH       M_ROCKSLIDE    M_SCARYFACE
]]
