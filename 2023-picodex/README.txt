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
Sound effects are stored in the `./129-151.p8` cartridge. The `compile.lua` script will copy those sound effects into the `game.p8` file. Each sfx/pkmn cry is only 2 notes. Originally was 4 for each, but I ran into space constraint.

```
             1         2     |     3        4      |     5          6      |     7          8      |     9         10      |    11        12      |    13         14      |    15         16
sfx 54 - missingno bulbasaur | ivysaur  venusaur   | charmander charmeleon | charizard  squirtle   | wartortle  blastoise  | caterpie  metapod    | butterfree weedle     | kakuna     beedrill
sfx 55 - pidgey    pidgeotto | pidgeot  rattata    | raticate   spearow    | fearow     ekans      | arbok      pikachu    | raichu    sandshrew  | sandslash  nidoranf   | nidorina   nidoqueen
sfx 56 - nidoranm  nidorino  | nidoking clefairy   | clefable   vulpix     | ninetales  jigglypuff | wigglytuff zubat      | golbat    oddish     | gloom      vileplume  | paras      parasect
sfx 57 - venonat   venomoth  | diglett  dugtrio    | meowth     persian    | psyduck    golduck    | mankey     primeape   | growlithe arcanine   | poliwag    poliwhirl  | poliwrath  abra
sfx 58 - kadabra   alakazam  | machop   machoke    | machamp    bellsprout | weepinbell victreebel | tentacool  tentacruel | geodude   graveler   | golem      ponyta     | rapidash   slowpoke
sfx 59 - slowbro   magnemite | magneton farfetchd  | doduo      dodrio     | seel       dewgong    | grimer     muk        | shellder  cloyster   | gastly     haunter    | gengar     onix
sfx 60 - drowzee   hypno     | krabby   kingler    | voltorb    electrode  | exeggcute  exeggutor  | cubone     marowak    | hitmonlee hitmonchan | lickitung  koffing    | weezing    rhyhorn
sfx 61 - rhydon    chansey   | tangela  kangaskhan | horsea     seadra     | goldeen    seaking    | staryu     starmie    | mrmime    scyther    | jynx       electabuzz | magmar     pinsir
sfx 62 - tauros    magikarp  | gyarados lapras     | ditto      eevee      | vaporeon   jolteon    | flareon    porygon    | omanyte   omastar    | kabuto     kabutops   | aerodactyl snorlax
sfx 63 - articuno  zapdos    | moltres  dratini    | dragonair  dragonite  | mewtwo     mew        | *okay      *back      | *error    *boot      | *logo      *todo      | *todo      *todo
```

## workspace
Here are some of the standard messages.

begin|hit #
comes|back
comes|out
created|substitute
does|nothing
failed|hit #
hitpoints
hitpoints
is now|
is|sleeping
resets|stats -- haze

copies|{pkmn}
copies|types
copies|{move}    -- mimic

charges|energy   -- solarbeam
recharges|energy -- hyperbeam
resumes|{move} -- multihit & multiturn

misses|{move}
fails|{move}
uses|{move}

f_move_rage
f_move_bide
f_move_thrash
f_move_trapping
f_move_flydig
f_move_prepare



IF I NEED TO TAKE DOWN ON TOKENS/COMPRESSION....
here are some functions that seem to be only used once and are referenced in code, so they could probably be removed.

f_does_move_miss
f_draw_screen
f_fightover_xfunc
f_get_crit_ratio
f_get_natural_moveset
f_horde_select
f_match_select
f_match_start
f_menu_cancel
f_menu_refresh
f_menu_set
f_movedel
f_movehelp_incstat
f_pop_next_action
f_populate_c_moves
f_postmove_logic
f_premovelogic
f_psel_forfeit
f_select_random_move
