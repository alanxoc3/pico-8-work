# Picodex
Picodex is a complete Pokemon generation 1 battle simulator for PICO-8. The entire battle simulator fits within only 32 kilobytes, which is the cartridge size for a PICO-8 game. This directory contains the un-minified code for Picodex.
There were tons of hacky things I had to do to get everything fitting. When I get the time, I'd like to write an article about it.

A few ways to play picodex:
- Lexaloffle BBS: TODO
- Itch.io: TODO
- Run this command in PICO-8: `TODO`

You can find the guide here:
- https://github.com/alanxoc3/pico-8-work/blob/master/2023-picodex/guide.md

## Constraints
trainer, pokemon, move, item, type names must all be <= 7 characters
Pokemon names must be <=7 characters
Moves must be <=7 characters (so they can fit side-by-side)
Types must be <=7 characters.

pokemon names that change:

    charmandr charmleon buterfree jiglypuff wiglytuff belsprout
    weepinbel victrebel tentcruel hitmnchan kangaskan electabuz
    aerdactyl typhlsion fraligatr misdreavs foretress

TODO: need to fix the order of types on pokemon.

## Some sort of devlog
Around 2023-09-23, I finished creating the trainer pokemon lineup for story mode.
Around 2023-09-26, I finished a rough draft of color versions for all 251 pokemon.
Around 2023-10-01, I finished getting all the move info I need from decompiled games.
2023-10-06, ran into issue with compiling. 200,000 characters used for compile cart, when I need under 65000. Fix will be to compile the compile cart and break it up into multiple files, each saving one thing.
2023-10-08, got most of stuff packed into cartridge, but there isn't enough room for everything. will need to figure out what to take out and keep.
2023-10-21, instead came up with a solution to save space even more. got down to:
  - 0x3830
  - 0x372f
  - 0x371a
  - 0x36d5
  - 0x36be
  - 0x3698
  - 0x3688
  - 0x3681
  - 0x364b
  # - 0x3639
  # - 0x35ff
  # - 0x35ff

2023-11-12, redid the trainers and pokemon default move order. trainers will have used every move in the game.
2023-11-18, designed the basics for the UI.

## changes
Smeargle can learn and sketch these moves that it couldn't in the gen 2 games:
- M_MIRRORMOVE
- M_SLEEPTALK
- M_METRONOME
- M_MIMIC
- M_TRANSFORM

Smeargle still can't sketch these moves: (probably mimic would do the same thing, but transform would only not do struggle)
- M_EXPLOSION
- M_SELFDESTRUCT
- M_SKETCH
- M_STRUGGLE
- M_TM05 (glitch move not in the gen2 games)

sketch glitch? YES, that's cool. but it only works within the same battle. doesn't carry over to other battles.

Smeargle cannot sketch these moves:
- Explosion    -- cant be copied because user faints
- Selfdestruct -- cant be copied because user faints
- Sketch       -- doh
- Struggle     -- doh
- Mirror Move  -- likely a bug with the game
- Sleep Talk   -- likely a bug with the game
- Metronome    -- later games removed this restriction
- Mimic        -- later games removed this restriction
- Transform    -- later games removed this restriction

Should sleep talk be able to select rest? I think so, like the OG games. Sleep talk cannot select itself. (no difference)

# Next steps...
- Mock entire UI.
- Finish python script to try to squeeze some extra bytes.
- Finish compression code.
- Then actually do the UI code.
- Then the battle system.
- Then improve sprites.
- Horde mode could be all 6 custom teams against all 57 trainers, followed by a missingno. That seems possible.

# Save format
256 bytes:

  1 -> story (unlocked pkmn)
  1 pkmn 4 moves 1 gender 1 item
  168 (7*6*4)

  pretty much every screen can have a save slot
  2 -> browseloc
  2 -> edit loc
  2 -> edit-edit loc

# How to win horde mode:
One idea is Marowak, because it has the highest attack in the game.

Another idea is to have some Scizor. They can learn agility, swordsdance, and baton pass. Maybe one can buff, the others can be filled with high-pp attack moves. If 5 are filled with moves, each one needs to take out ~50 Pokemon.

TODO: Ensure smeargle cannot learn tm05.
TODO: Ensure missingno learns tm05 as a taught move, not a natural move.

Pokemon can be "neuter" gender: https://archive.org/details/nintendo-power-2001-pokemon-crystal/page/n25/mode/2up
