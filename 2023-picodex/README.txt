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

## Todos
- I want the browse pkmn interface to include a "random" button between the bulbasaur and mew rows. This could be used for either browsing or selecting for party.
- Random move should be one of the menu items in the move selection. There would be no button to randomize all moves.
- Parties should be able to have a name. Might be cool to be able to export/import a party.
- Pokemon info in browse interface should be similar to credit screen. You can scroll through it.
- Credit screen shouldn't wrap.
- Implement the battle system of course.
- Maybe screen transitions should have a flash of some sort.

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

plus num

111 bytes to store 3 parties (1 byte per party for the party count. 6 bytes per pokemon: pokemon movecount move1 move2 move3 move4)

enabled pokemon move1 move2 move3 move4
enabled pokemon move1 move2 move3 move4
enabled pokemon move1 move2 move3 move4

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

surfing pikachu (add surf as hm for pikachu) - raichu will auto-inherit it too
amnesia psyduck (add amnesia as lvl 1 move for psyduck) - golduck will auto-inherit it too

## Things
Random Party - Random pokemon w/default moves
Random Moves - For predermined pokemon

For moves, if it is learned twice, take the one that is learned at a higher level, unless one was learned at level 1, then take the one at level 1. And if a TM matches the move, remove the TM.

Pkmn yellow has moveset changes: https://gamefaqs.gamespot.com/gameboy/198314-pokemon-yellow-version-special-pikachu-edition/answers/572415-what-pokemon-have-moveset-changes-from-red-and-blue
So, this game includes moves from yellow,red, and blue
