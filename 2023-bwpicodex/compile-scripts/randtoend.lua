-- want random data until the end, so we have all the pokemon cries.
-- also want this to be repeatable so the cries don't keep changing.
-- overwrites all data until the last sound effect of the cart.
function init() -- entry point for this compile script
  srand(33)
  while ENCODE_OFFSET < (0x4300-68) do
    offsetpoke(flr(rnd(256)))
  end

  log("Wrote Random Data To End")
end
