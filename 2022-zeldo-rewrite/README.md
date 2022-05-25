# Not The Story of Zeldo
Lank wakes up from a good night's rest only to find Hi-roll in danger! You gotta
help him save the Land of Hi-roll from the forces of evil.

## Useful Snippet
Use this to update the list of things from mapbuilder:
```
cat mapbuilder.lua | rg INDEX | rg -o '"\w+"' | rg -o '\w+' | tr '\n' ','
| ccl
```

## Tokens & Features
Next: common simple spr func (cut tokens)
Next: no cell shading for separate objects
Next: conditional create func or room init
Next: make a person and combine sign logic

```
2022-05-24 -- house savelogic
    4198 4183 4250 4344 4355 4296 4265

2022-05-23 -- solids signworks collisionfix housebasic 
    3920 4057 4045 4198

2022-05-22 -- ui tbox uipolish placeobjs itemswitchui
    3347 3553 3597 3648 3756 3782 3785 3878 3920

2022-05-21 -- tilecol planim autooutline inventory explode btndelay
    2801 3128 3183 3214 3144 3093 3167 3188 3298 3277 3351 3347

2022-05-20 -- mov box pl fairy roomtran
    2040 2457 2546 2591 2682 2669 2700 2801

2022-05-19 -- tile animation title gameover
    1657 2048 2046 2042 2040

2022-05-15 -- engine map
    0000 1665 1654 1653 1655 1657
```

## Characters
Lank   - Main character.
Ivan   - Evil fairy.
Navy   - Older brother of Lime, first boss.
Lime   - Younger sister of Navy, gives you the sword. Year passed.
Bob    - Husband of Jane.
Jane   - Bob's wife.
Teach  - The banjo teacher.
Grover - The gravedigger. Zeldo's dad.
Teach  - The teacher.
Keep   - The shopkeeper.
Lark   - Mayor of town.
Canon  - Proposed to zeldo with squareforce. Weirdo dressed as santa. Gave Lime the mask.
Zeldo  - Canon proposed to her with squareforce.

## Items
- Shield 99
- Brang  99
- Mega Sword (only effective against evil)
- Bowl - drink it
- Banjo - play it (use for saving & earn money)
- Bomb - place and hold release to blow up (longer hold, stamina goes up) (or timer)
- Bow  - 999
- Mask - 999 Hold down item button. Stamina goes down quickly. Pauses everything in the room.

## Enemies
Batty      - Everywhere.
Slimy/Miny - Everywhere.
Skelly     - Graveyard.
Planty     - Forest.
Handy      - Crypt.
Topy       - Canyon.
Mowy       - Field.
Knighty    - Castle.
Zomby      - Hard mode (village).
Shadow Lank
Ghost

## Ways To Get Money
- Kill enemies
- Under pots
- Find secret chest
- Play banjo

## Game Outline
- Start game.
- Flash back, Zeldo and lank talk. Zeldo leaves. Lank gets attacked. Fade to black.
- In house. Fairy talk to you whatever.
- Grab banjo.
- Learn to play.
- Get money from playing to people.
- Get boomerang or shield.
- Go through woods. Navy lets you in.
- Get sword from chest.
- Fight and kill Lime & Mask.
- Navy is sad. Give you bowl.
- Grab duck. Give to Jane. Says come back later till soup is done (beat lime)
- Get soup. Give to Bob. Soup is like potion.
- Go to ice castle
- Gather ducks for switches.
- Dodge ball
- Tennis
- Reveal. Get bomb.
- Where's Zeldo?
- Graveyard/Crypt.
- Tiny puzzle.
- Zeldo is hiding behind locked door. Blow up the door.
- It's a trick Grover sets some traps for you & puzzles.
- Fight grover?
- Zeldo comes in and explains situation.
- Zeldo tries to give you the square force.
- Ivan intercepts it.
- World corrupted. Enemies everywhere.
- There is some room that has a computer. Go there.
- Ivan battle.
- After you win. Endless mode (lark/high score). Replay game with hard mode (health, enemy...).

## Quotes
- Here's my heart.
- All that's left of my son.
- Silly lank, only works against evil forces. That tickles (canon says on deathbead)
- Canon can't give gifts. He gave some kid a creepy mask and now he gives me a hunk of metal.
- I gave it to zeldo you know the gravedigger's daughter?

## Boss Fights
Lime:
    - teleports every few seconds (mask power)

Canon:
    - dodgeball/tennis

Grover:
    - zeldo's dad

Ivan:
    - repeat of previous bosses + something else?
    - duck with mask???

## Areas
Ice Castle, Graveyard, Zeldo Home, Field, Mountain Area, Spike Forest, Village
