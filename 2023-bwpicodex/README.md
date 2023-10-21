# Picodex
Picodex is a complete Pokemon generation 1 battle simulator for PICO-8. The entire battle simulator fits within only 32 kilobytes, which is the cartridge size for a PICO-8 game. This directory contains the un-minified code for Picodex.
There were tons of hacky things I had to do to get everything fitting. When I get the time, I'd like to write an article about it.

A few ways to play picodex:
- Lexaloffle BBS: TODO
- Itch.io: TODO
- Run this command in PICO-8: `TODO`

You can find the guide here:
- https://github.com/alanxoc3/pico-8-work/blob/master/2023-picodex/guide.md

## Some sort of devlog
Around 2023-09-23, I finished creating the trainer pokemon lineup for story mode.
Around 2023-09-26, I finished a rough draft of color versions for all 251 pokemon.
Around 2023-10-01, I finished getting all the move info I need from decompiled games.
2023-10-06, ran into issue with compiling. 200,000 characters used for compile cart, when I need under 65000. Fix will be to compile the compile cart and break it up into multiple files, each saving one thing.
2023-10-08, got most of stuff packed into cartridge, but there isn't enough room for everything. will need to figure out what to take out and keep.
2023-10-21, instead came up with a solution to save space even more. got down to 0x3734 to 0x3633 to

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
