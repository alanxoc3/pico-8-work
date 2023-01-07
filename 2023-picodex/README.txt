# Picodex
## Credits
-- https://gamefaqs.gamespot.com/gameboy/924467-pokemon-green/faqs/12776
-- px9
-- smap
-- battle mechanics: https://www.smogon.com/rb/articles/rby_mechanics_guide

## Compilation
To compile the resources, run this:

```
pico8 -x compile.lua
```

To compile the code, run pico-compile, which is located in the /bin directory of this repo.

## Design
use the 

Blue buttons on the right correspond to the different pokedex modes.

Modes are:
- Mode Select

- Browse
  - Description?, Weight, Height, Location?, Moves
- Party
  - set active party
  - customize parties
- Battle
  - story (predefined fights, end in missingno)
  - pokedown (fight pokemon in order, aim for high score)
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
