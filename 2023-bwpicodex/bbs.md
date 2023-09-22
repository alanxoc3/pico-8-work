Welcome to the world of PICO-8 Pokemon! Picodex is a complete generation 1 Pokemon battle simulator, with slight modifications, that fits within a single 32KB PICO-8 cartridge.

Standard PICO-8 controls apply to this game. For a computer keyboard this is: "arrows", "x/z", "enter".

There are 6 modes in Picodex:
- `BROWSE`: View all Pokemon you have unlocked along with stats and possible moves.
- `EDIT`: Edit up to 3 teams. Customize Pokemon and movesets in each team.
- `LEAGUE`: Battle against trainers in the Pokemon league.
- `VERSUS`: Take turns playing a custom match between you and a friend.
- `HORDE`: Have your team battle all 151 Pokemon in order with no breaks.
- `CREDITS`: See who helped make the game.

Picodex initially loads with only 6 Pokemon unlocked. You can unlock more Pokemon by defeating trainers in LEAGUE mode. Everytime you win a battle, you unlock all the Pokemon the opponent had as well as their entire moveset. Picodex will auto-save any Pokemon/trainers/scores you have unlocked, so don't be afraid to close it and play again later.

If you want to learn more about the battle mechanics, expand this section:

[hidden]
The Picodex battle system follows the mechanics of the original Pokemon Stadium 1 (PS1) game on the Nintendo 64.

For those unfamiliar with how Pokemon Stadium 1 battle mechanics work, I strongly recommend these articles:
- https://www.smogon.com/rb/articles/stadium_guide
- https://www.smogon.com/rb/articles/rby_mechanics_guide

For those already familiar with Pokemon Stadium 1 battle mechanics, most everything should behave the same besides these intentional modifications:

Modifications inspired by original handheld games:
- Substitute only protects from damage done by opponent. Not against any effects.
- Swift will never miss, bypassing all accuracy checks including when opponent uses dig/fly.
- Sleep lasts 0-6 turns, unless caused by rest, then only 1 turn.

Modifications inspired by later Pokemon games:
- Sleep, freeze, trapping moves, and disable can break a user free multiturn moves.
- Roar/Whirlwind switch the opponent's Pokemon with another random Pokemon.
- Teleport switches the user's Pokemon with another random Pokemon.
- The freeze status condition has a 20% chance to unthaw the Pokemon each turn.
- Hyper beam still needs to recharge if it knocks out the opponent Pokemon.
- Haze only resets stat modifiers, it does not reset any special effects.
- Transform fails when opponent is transformed or user is already transformed.
- Leech seed does not use the toxic counter.
- Struggle bypasses type checks.

Modifications inspired by personal preference:
- All Pokemon are set to level 50 with the highest possible stats they can have for that level.
- When you KO the target with a multihit move such as "Double Slap", your attack will continue onto the next Pokemon sent out.
- If a Pokemon faints, the next Pokemon in the user's team is sent out automatically. This places more importance on team order.
- Mimic replaces the move's pp with "5", bypasses accuracy checks, and doesn't copy mimic.
- Rage consumes 1 pp for each turn it is used.
- Damage calculation is capped at 999 damage.
[/hidden]

If you need a reference of all the moves and what they do, expand this section:

[hidden]
Picodex includes the standard movesets for all 151 Pokemon, as well as a few extra moves from various events and glitches for the generation 1 games. Those extra moves are:
- Fearow with Payday. From an in-person event.
- Pickachu with Surf. From an in-person event.
- Pickachu with Fly. From an in-person event.
- Psyduck with Amnesia. A prize Pokemon from Pokemon Stadium 1.
- Rapidash with Payday. From an in-person event.
- Slowbro with Metronome. From a Juggler in Pokemon Stadium 1.
- Magikarp with Dragon Rage. From an in-person event.
- Dragonite with Barrier. From Lance in Red/Blue/Green.

Here is a list of all the moves available in Picodex, along with a short description of what each move does:

```
| move name | canonical name | description                                                                                                      |
| --------- | -------------- | ---------------------------------------------------------------------------------------------------------------- |
| absorb    | Absorb         | damages target. restores users hp by 1/2 of damage inflicted.                                                    |
| acid      | Acid           | damages target. 10% chance to lower defense by 1 stage.                                                          |
| acidarmr  | Acid Armor     | raises users defense by 2 stages.                                                                                |
| agility   | Agility        | raises users speed by 2 stages.                                                                                  |
| amnesia   | Amnesia        | raises users special by 2 stages.                                                                                |
| aurorabm  | Aurora Beam    | damages target. 10% chance to lower attack by 1 stage.                                                           |
| barrage   | Barrage        | damages target. repeats 2-5 times.                                                                               |
| barrier   | Barrier        | raises users defense by 2 stages.                                                                                |
| bide      | Bide           | user endures damage for 2-3 turns then inflicts twice the damage endured.                                        |
| bind      | Bind           | damages target. repeats 2-5 turns. target cannot move during this time.                                          |
| bite      | Bite           | damages target. 10% chance to flinch.                                                                            |
| blizzard  | Blizzard       | damages target. 10% chance to freeze.                                                                            |
| bodyslam  | Body Slam      | damages target. 30% chance to paralyze.                                                                          |
| boneclub  | Bone Club      | damages target. 10% chance to flinch.                                                                            |
| bonerang  | Bonemerang     | damages target. repeats 2 times.                                                                                 |
| bubble    | Bubble         | damages target. 10% chance to lower speed by 1 stage.                                                            |
| bublbeam  | Bubble Beam    | damages target. 10% chance to lower speed by 1 stage.                                                            |
| clamp     | Clamp          | damages target. repeats 2-5 turns. target cannot move during this time.                                          |
| cnfusion  | Confusion      | damages target. 10% chance to confuse.                                                                           |
| cnfusray  | Confuse Ray    | confuses target.                                                                                                 |
| comtpnch  | Comet Punch    | damages target. repeats 2-5 times.                                                                               |
| constrct  | Constrict      | damages target. 10% chance to lower speed by 1 stage.                                                            |
| convrson  | Conversion     | users copies targets types.                                                                                      |
| counter   | Counter        | usually goes last. user retaliates for twice the damage it endured from a physical attack this turn.             |
| crabhamr  | Crabhammer     | damages target. high critical hit ratio.                                                                         |
| cut       | Cut            | damages target.                                                                                                  |
| dfnscurl  | Defense Curl   | raises users defense by 1 stage.                                                                                 |
| dig       | Dig            | user prepares and is nearly invulnerable on turn one then damages target on turn two.                            |
| disable   | Disable        | one randomly selected move for target is disabled for 2-7 turns. fails if target is already disabled.            |
| dizypnch  | Dizzy Punch    | damages target.                                                                                                  |
| doubedge  | Double Edge    | damages target. user receives 1/4 recoil damage.                                                                 |
| doubkick  | Double Kick    | damages target. repeats 2 times.                                                                                 |
| doubslap  | Double Slap    | damages target. repeats 2-5 times.                                                                               |
| doubteam  | Double Team    | raises users evasion by 1 stage.                                                                                 |
| dreameat  | Dream Eater    | restores users hp by 1/2 of the damage inflicted on target but only works on a sleeping target.                  |
| drgnrage  | Dragon Rage    | damages target. deals exactly 40 damage.                                                                         |
| drillpck  | Drill Peck     | damages target.                                                                                                  |
| earthqke  | Earthquake     | damages target.                                                                                                  |
| eggbomb   | Egg Bomb       | damages target.                                                                                                  |
| ember     | Ember          | damages target. 10% chance to burn.                                                                              |
| explsion  | Explosion      | user faints then does high amounts damage to target.                                                             |
| fcsenrgy  | Focus Energy   | raises critical hit ratio.                                                                                       |
| fireblst  | Fire Blast     | damages target. 30% chance to burn.                                                                              |
| firepnch  | Fire Punch     | damages target. 10% chance to burn.                                                                              |
| firespin  | Fire Spin      | damages target. repeats 2-5 turns. target cannot move during this time.                                          |
| fissure   | Fissure        | target faints. doesnt work on faster Pokemon.                                                                    |
| flamthwr  | Flamethrower   | damages target. 10% chance to burn.                                                                              |
| flash     | Flash          | lowers targets accuracy by 1 stage                                                                               |
| fly       | Fly            | user prepares and is nearly invulnerable on turn one then damages target on turn two.                            |
| furyatck  | Fury Attack    | damages target. repeats 2-5 times.                                                                               |
| furyswps  | Fury Swipes    | damages target. repeats 2-5 times.                                                                               |
| glare     | Glare          | paralyzes target.                                                                                                |
| growl     | Growl          | lowers targets attack by 1 stage.                                                                                |
| growth    | Growth         | raises users special by 1 stage.                                                                                 |
| guilotin  | Guillotine     | target faints. doesnt work on faster Pokemon.                                                                    |
| gust      | Gust           | damages target.                                                                                                  |
| harden    | Harden         | raises users defense by 1 stage.                                                                                 |
| haze      | Haze           | resets stat modifiers from both Pokemon.                                                                         |
| headbutt  | Headbutt       | damages target. 30% chance to flinch.                                                                            |
| hijmpkck  | High Jump Kick | damages target. user receives 1 hp of recoil damage if attack misses.                                            |
| hornatck  | Horn Attack    | damages target.                                                                                                  |
| horndril  | Horn Drill     | target faints. doesnt work on faster Pokemon.                                                                    |
| hydropmp  | Hydro Pump     | damages target.                                                                                                  |
| hypnosis  | Hypnosis       | puts target to sleep.                                                                                            |
| hyprbeam  | Hyper Beam     | user attacks on one turn then recharges on turn two.                                                             |
| hyprfang  | Hyper Fang     | damages target. 10% chance to flinch.                                                                            |
| icebeam   | Ice Beam       | damages target. 10% chance to freeze.                                                                            |
| icepnch   | Ice Punch      | damages target. 10% chance to freeze.                                                                            |
| jumpkick  | Jump Kick      | damages target. user receives 1 hp of recoil damage if attack misses.                                            |
| karatchp  | Karate Chop    | damages target. high critical hit ratio.                                                                         |
| kinesis   | Kinesis        | lowers targets accuracy by 1 stage.                                                                              |
| leechlif  | Leech Life     | damages target. restores users hp by 1/2 of damage inflicted.                                                    |
| leechsed  | Leech Seed     | seeds target. user steals 1/16 of targets max hp every turn.                                                     |
| leer      | Leer           | lowers targets defense by 1 stage.                                                                               |
| lghtscrn  | Light Screen   | user receives 1/2 damage from physical attacks.                                                                  |
| lick      | Lick           | damages target. 30% chance to paralyze.                                                                          |
| lovekiss  | Lovely Kiss    | puts target to sleep.                                                                                            |
| lowkick   | Low Kick       | damages target. 30% chance to flinch.                                                                            |
| meditate  | Meditate       | raises users attack by 1 stage.                                                                                  |
| megakick  | Mega Kick      | damages target.                                                                                                  |
| megapnch  | Mega Punch     | damages target.                                                                                                  |
| megdrain  | Mega Drain     | damages target. restores users hp by 1/2 of damage inflicted.                                                    |
| metrnome  | Metronome      | user performs a random move, excluding struggle.                                                                 |
| mimic     | Mimic          | this move is replaced by one of the target's moves at random with 5 pp. move is reset to mimic if user switches. |
| minimize  | Minimize       | raises users evasion by 1 stage.                                                                                 |
| mirrmove  | Mirror Move    | user performs the last move executed by its target, excluding struggle.                                          |
| mist      | Mist           | protects user from modifier decreases.                                                                           |
| ngtshade  | Night Shade    | damages target. deals exactly 50 damage.                                                                         |
| payday    | Pay Day        | damages target.                                                                                                  |
| peck      | Peck           | damages target.                                                                                                  |
| petldanc  | Petal Dance    | damages target. repeats 2-3 turns then gets confused afterwards.                                                 |
| pinmisil  | Pin Missile    | damages target. repeats 2-5 times.                                                                               |
| poisngas  | Poison Gas     | poisons target.                                                                                                  |
| pound     | Pound          | damages target.                                                                                                  |
| psnpowdr  | Poison Powder  | poisons target.                                                                                                  |
| psnsting  | Poison Sting   | damages target. 20% chance to poison.                                                                            |
| psybeam   | Psybeam        | damages target. 10% chance to confuse.                                                                           |
| psychic   | Psychic        | damages target. 30% chance to lower special by 1 stage.                                                          |
| psywave   | Psywave        | damages target. deals a random amount of damage between 1 and 75.                                                |
| quickatk  | Quick Attack   | usually goes first.                                                                                              |
| rage      | Rage           | user attacks uncontrollably and uses 1 pp each turn. raises users attack by 1 stage each time it is damaged.     |
| razrleaf  | Razor Leaf     | damages target. high critical hit ratio.                                                                         |
| razrwind  | Razor Wind     | user prepares on turn one then damages target on turn two.                                                       |
| recover   | Recover        | restores 1/2 of users max hp.                                                                                    |
| reflect   | Reflect        | user receives 1/2 damage from physical attacks.                                                                  |
| rest      | Rest           | user is cured of major status and recovers full hp but falls asleep.                                             |
| rllngkck  | Rolling Kick   | damages target. 30% chance to flinch.                                                                            |
| roar      | Roar           | usually goes last. switches opponent's active Pokemon with a random benched Pokemon.                             |
| rockslid  | Rock Slide     | damages target.                                                                                                  |
| rockthrw  | Rock Throw     | damages target.                                                                                                  |
| sandatck  | Sand Attack    | lowers targets accuracy by 1 stage.                                                                              |
| scratch   | Scratch        | damages target.                                                                                                  |
| screech   | Screech        | lowers targets defense by 2 stages.                                                                              |
| seistoss  | Seismic Toss   | damages target. deals exactly 50 damage.                                                                         |
| selfdstr  | Self Destruct  | user faints then does high amounts damage to target.                                                             |
| sharpen   | Sharpen        | raises users attack by 1 stage.                                                                                  |
| sing      | Sing           | puts target to sleep.                                                                                            |
| skulbash  | Skull Bash     | user prepares on turn one then damages target on turn two.                                                       |
| skyattck  | Sky Attack     | user prepares on turn one then damages target on turn two.                                                       |
| slam      | Slam           | damages target.                                                                                                  |
| slash     | Slash          | damages target. high critical hit ratio.                                                                         |
| slppowdr  | Sleep Powder   | puts target to sleep.                                                                                            |
| sludge    | Sludge         | damages target. 30% chance to poison.                                                                            |
| smog      | Smog           | damages target. 30% chance to poison.                                                                            |
| smokscrn  | Smokescreen    | lowers targets accuracy by 1 stage.                                                                              |
| softboil  | Soft Boiled    | restores 1/2 of users max hp.                                                                                    |
| solrbeam  | Solar Beam     | user prepares on turn one then damages target on turn two.                                                       |
| sonicbom  | Sonic Boom     | damages target. deals exactly 20 damage.                                                                         |
| spikcann  | Spike Cannon   | damages target. repeats 2-5 times.                                                                               |
| splash    | Splash         | does nothing.                                                                                                    |
| spore     | Spore          | puts target to sleep.                                                                                            |
| sprsonic  | Supersonic     | confuses target.                                                                                                 |
| stomp     | Stomp          | damages target. 30% chance to flinch.                                                                            |
| strength  | Strength       | damages target.                                                                                                  |
| strngsht  | String Shot    | lowers targets speed by 1 stage.                                                                                 |
| struggle  | Struggle       | damages target. used when user can't use any more moves. ignores type checks.                                    |
| stunspor  | Stun Spore     | paralyzes target.                                                                                                |
| submsion  | Submission     | damages target. user receives 1/4 recoil damage.                                                                 |
| substute  | Substitute     | user creates a decoy with 1/4 of its hp. opponent will damage substitute but user is vulnerable to effects.      |
| suprfang  | Super Fang     | this move halves targets current hp. inflicts at least 1 damage.                                                 |
| surf      | Surf           | damages target.                                                                                                  |
| swift     | Swift          | damages target. always hits, bypassing all accuracy checks.                                                      |
| sworddnc  | Swords Dance   | raises users attack by 2 stages.                                                                                 |
| tackle    | Tackle         | damages target.                                                                                                  |
| tailwhip  | Tail Whip      | lowers targets defense by 1 stage.                                                                               |
| takedown  | Take Down      | damages target. user receives 1/4 recoil damage.                                                                 |
| teleport  | Teleport       | usually goes last. switches user's active Pokemon with a random benched Pokemon.                                 |
| thndpnch  | Thunder Punch  | damages target. 10% chance to paralyze.                                                                          |
| thndrblt  | Thunderbolt    | damages target. 10% chance to paralyze.                                                                          |
| thndrwav  | Thunder Wave   | paralyzes target.                                                                                                |
| thndshck  | Thunder Shock  | damages target. 10% chance to paralyze.                                                                          |
| thrash    | Thrash         | damages target. repeats 2-3 turns then gets confused afterwards.                                                 |
| thunder   | Thunder        | damages target. 10% chance to paralyze.                                                                          |
| toxic     | Toxic          | target is badly poisoned with poison damage increasing each turn.                                                |
| tranform  | Transform      | user copies target stats, types, and moves. moves are all set to have 5 pp.                                      |
| triattck  | Tri Attack     | damages target.                                                                                                  |
| twineedl  | Twineedle      | damages target. repeats 2 times. 20% chance to poison.                                                           |
| vicegrip  | Vice Grip      | damages target.                                                                                                  |
| vinewhip  | Vine Whip      | damages target.                                                                                                  |
| watergun  | Water Gun      | damages target.                                                                                                  |
| watrfall  | Waterfall      | damages target.                                                                                                  |
| whrlwind  | Whirlwind      | usually goes last. switches opponent's active Pokemon with a random benched Pokemon.                             |
| wingatck  | Wing Attack    | damages target.                                                                                                  |
| withdraw  | Withdraw       | raises users defense by 1 stage.                                                                                 |
| wrap      | Wrap           | damages target. repeats 2-5 turns. target cannot move during this time.                                          |
```
[/hidden]

Anyways, that's everything you need to know to get started on your very own Picodex journey. Good luck catching 'em all!
