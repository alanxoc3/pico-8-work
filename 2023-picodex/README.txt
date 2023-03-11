# Picodex
A pokedex in pico-8. Comes complete with minigames, pokedex, and a battle simulator. Picodex is based on the generation 1 games and tries to stay true to the original games, though a few minor oversights in the original games may be corrected here.

## Specs
```
Screen 1 (Left):      40x40
Screen 2 (Top-Right): 46x13
Screen 3 (Bot-Right): 46x21
```

## Building
To compile the resources, run this:

```
pico8 -x compile.lua
```

To compile the code, run pico-compile, which is located in the /bin directory of this repository.

You can cheat and load all pkmn with the `./settest.lua` script.

## Sfx
Sound effects are stored in the `./129-151.p8` cartridge. The `compile.lua` script will copy those sound effects into the `game.p8` file. Here is what each sfx is:

```
44-63 Mini sfx (44-62 cries, 63 misc sfx)
```
