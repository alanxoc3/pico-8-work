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

## Sfx
Sound effects are stored in the `./129-151.p8` cartridge. The `compile.lua` script will copy those sound effects into the `game.p8` file. Here is what each sfx is:

```
00-37 Pokemon cries
59    Factory reset noise
60    Pokedex starting beep
61    Pokedex started beep
62    Logo bkgd
63    Logo melody
```


## Credits
-- px9
-- smap
-- battle mechanics: https://www.smogon.com/rb/articles/rby_mechanics_guide
-- https://gamefaqs.gamespot.com/gameboy/924467-pokemon-green/faqs/12776
-- https://www.serebii.net/pokedex/000.shtml
-- https://pokeapi.co/
-- bulbapedia

## Random Temporary Notes
Move changes from gen 1 to gen 2: https://bulbapedia.bulbagarden.net/wiki/List_of_modified_moves

Modes are:
- Mode Select

- Browse
  - Description?, Weight, Height, Location?, Moves
- Party
  - set active party
  - customize parties
- Battle
  - story (predefined fights, end in missingno)
  - numeric (fight pokemon in order, aim for high score)
  - random fight (fight a completely random team)
  - party fight (fight one of the saved parties)
- Quiz
  - Guess Who
  - Type Quiz
- Settings
  - metric system
  - alphabetic/numeric
- Credits

Missingno stats:
https://bulbapedia.bulbagarden.net/wiki/MissingNo.
https://www.serebii.net/pokedex/000.shtml

unlock missingno by:
- guessing all the pokemon
- beat the final legendary battle
- winning the pokedown mode
- getting to end of type quiz

256 bytes


180 bytes to store up to 6 parties (5 nums per pokemon: pokemon move1 move2 move3 move4)
6 bytes needed for the battles to win (8*6 is 48, there are 48 different battles)
1 byte needed for current mode
2 bytes for settings
1 byte (bit) needed for unlocking missingno
1 byte for guess pokemon score
1 byte for picodown score
1 byte for swap controls

## Special unlockables
Amnesia Psyduck -- quiz
Surfing Pikachu -- guess who
Missingno       -- battle

guess who - surfing pikachu
amnesia psyduck

## Things
Random Party - Random pokemon w/default moves
Random Moves - For predermined pokemon
