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
