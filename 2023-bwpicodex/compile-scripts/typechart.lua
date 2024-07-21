-- i could compress the space here, but I dont think i want to.
function init() -- entry point for this compile script
  for x in all(type_chart) do
    offsetpoke(x)
  end

  log("Wrote Type Chart")
end

-- TODO: I could compress this more. Don't need to take up a full byte for each one.
-- order of types here is important. it corresponds to the constants file.
type_chart = { -- 0: no effect, 1: resist, 2: normal, 4: x2
-- NON NOR FIR FIG WAT POI ELE GRO GRA FLY ICE BUG PSY ROC DRA GHO DAR STE BRD <-def v-atk
    2,  2,  2,  2,  2,  2,  2,  2,  2,  2,  2,  2,  2,  2,  2,  2,  2,  2,  4, -- NON
    2,  2,  2,  2,  2,  2,  2,  2,  2,  2,  2,  2,  2,  1,  2,  0,  2,  1,  1, -- NOR
    2,  2,  1,  2,  1,  2,  2,  2,  4,  2,  4,  4,  2,  1,  1,  2,  2,  4,  1, -- FIR
    2,  4,  2,  2,  2,  1,  2,  2,  2,  1,  4,  1,  1,  4,  2,  0,  4,  4,  1, -- FIG
    2,  2,  4,  2,  1,  2,  2,  4,  1,  2,  2,  2,  2,  4,  1,  2,  2,  2,  1, -- WAT
    2,  2,  2,  2,  2,  1,  2,  1,  4,  2,  2,  2,  2,  1,  2,  1,  2,  0,  1, -- POI
    2,  2,  2,  2,  4,  2,  1,  0,  1,  4,  2,  2,  2,  2,  1,  2,  2,  2,  1, -- ELE
    2,  2,  4,  2,  2,  4,  4,  2,  1,  0,  2,  1,  2,  4,  2,  2,  2,  4,  1, -- GRO
    2,  2,  1,  2,  4,  1,  2,  4,  1,  1,  2,  1,  2,  4,  1,  2,  2,  1,  1, -- GRA
    2,  2,  2,  4,  2,  2,  1,  2,  4,  2,  2,  4,  2,  1,  2,  2,  2,  1,  1, -- FLY
    2,  2,  1,  2,  1,  2,  2,  4,  4,  4,  1,  2,  2,  2,  4,  2,  2,  1,  1, -- ICE
    2,  2,  1,  1,  2,  1,  2,  2,  4,  1,  2,  2,  4,  2,  2,  1,  4,  1,  1, -- BUG
    2,  2,  2,  4,  2,  4,  2,  2,  2,  2,  2,  2,  1,  2,  2,  2,  0,  1,  1, -- PSY
    2,  2,  4,  1,  2,  2,  2,  1,  2,  4,  4,  4,  2,  2,  2,  2,  2,  1,  1, -- ROC
    2,  2,  2,  2,  2,  2,  2,  2,  2,  2,  2,  2,  2,  2,  4,  2,  2,  1,  1, -- DRA
    2,  0,  2,  2,  2,  2,  2,  2,  2,  2,  2,  2,  4,  2,  2,  4,  1,  1,  1, -- GHO
    2,  2,  2,  1,  2,  2,  2,  2,  2,  2,  2,  2,  4,  2,  2,  4,  1,  1,  1, -- DAR
    2,  2,  1,  2,  1,  2,  1,  2,  2,  2,  4,  2,  2,  4,  2,  2,  2,  1,  1, -- STE
    2,  2,  2,  2,  2,  2,  2,  2,  2,  2,  2,  2,  2,  2,  2,  2,  2,  2,  4, -- BRD
}
