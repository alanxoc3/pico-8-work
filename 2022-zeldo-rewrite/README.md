# Not The Story of Zeldo
Lank wakes up from a good night's rest only to find Hi-roll in danger! Ya gotta
help him save the Land of Hi-roll from the FORCES-OF-EVIL.

## Sprite Flag Reference
```
0: solid
1: not solid for flying things
2: rx=.375 ry=.375 (for trees)
3: rx=.375 ry=.625 (for river)
```

## Songs
16 songs in total:

7 long
- long: village
- long: forest
- long: field/mountain
- long: castle/cannon
- long: crypt
- long: ivan boss fight (based on computer room)
- long: endless mode
- shrt: title screen
- shrt: intro (cut scene)
- shrt: graveyard (village + crypt)
- shrt: forest boss
- shrt: computer room
- shrt: game over
- shrt: house

## Tokens & Features
friday...
TODO: chest with sword
TODO: banjo with lark text logic
TODO: standardize ma time
TODO: pot ma override
TODO: remove duck throw
TODO: duck follow logic
TODO: interact always override hurtable
TODO: item going up snap/fix
TODO: chicken follow not throw
TODO: get item logic
TODO: lank 0 health bug when hit while leaving room
TODO: remove collision for bomb in air

saturday...
TODO: right ma sprite shouldn't be flipped
TODO: fix item offsets (many items are either off or sometimes off)
TODO: when items go up, slight bug
TODO: token crunch for 30 minutes
TODO: bomb blow up crate
TODO: first boss (lime)
TODO: mask particle effect

sunday...
TODO: polish until beating first boss
TODO: think of more enemies
TODO: think about chicken collection for cannon logic (throw chicken onto a platform)

```
2022-08-26 -- stunlogic collaxis
    6653

2022-08-20 -- mask polish stun hurt banjo
    6613

2022-06-02 -- potthrow quackthrow arrowwallbug timerlogicchange
    6117 6229 6287 6266 6240

2022-06-01 -- slimestun gameoverwork mapwork
    5905 6117

2022-05-31 -- betterbomb
    5804 5867 5905

2022-05-30 -- spawnin enemycollision otherstuff
    5396 5434 5558 5804

2022-05-29 -- insidecollision save arrow
    5098 5093 5092 5071 5058 5055 5166 5272 5246 5316 5396

2022-05-28 -- banjo brang bombfix bob keep teach jane lark energylimit objs
    4821 4835 4946 4972 4978 5035 5022 5028 5038 5050 5005 5098

2022-05-27 -- simplifyma expandinventory sword energy mask bow shield bomb
    4438 4426 4488 4483 4528 4549 4680 4692 4689 3739 4722 4742 4785 4835 4821

2022-05-26 -- tileflags tokencrunch singlema fairyfollow
    4421 4515 4511 4512 4504 4495 4485 4480 4468 4437 4394 4431 4427 4424 4438

2022-05-25 -- isorty memcondcreate navy fairypolish
    4265 4263 4323 4311 4307 4317 4375 4466 4423 4421

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

## Item Locations
Sword  - Mandatory. From chest in forest.
Bowl   - Mandatory. From soup Jane gives you in village.
Banjo  - Optional.  From Teach in village.
Bomb   - Mandatory. From cannon in mountains.
Brang  - Optional.  4 coins from shop in village.
Shield - Optional.  4 coins from shop in field. Need brang.
Sling  - Optional.  4 coins from shop in forest. Need bomb.
Mask   - Optional.  4 coins from shop in crypt.

## Duck Locations
Duck #1 - Fores. Room after Lime.
Duck #2 - Village. Near Janes house. This moves Bob when you talk to him with soup.
Duck #3 - Field.
Duck #4 - Mount.

## Coin Locations
Coin #1  - Vilag: Behind keep's house.
Coin #2  - Vilag: Play banjo for Lark.
Coin #3  - Vilag: In bob's bed.
Coin #4  - Vilag: Chest in lank's room.
Coin #5  - Vilag: Crate in teach's house.
Coin #6  - Vilag: Talk to Navy after Lime is dead.
Coin #7  - Vilag: Pot in gravedigger house.
Coin #8  - Fores: Hidden room.
Coin #9  - Fores: Field.
Coin #10 - Fores:
Coin #11 - Field:
Coin #12 - Field:
Coin #13 - Field: 
Coin #14 - Crypt: Next to tombstone in graveyard.
Coin #15 - Crypt: Graveyard/Crypt.
Coin #16 - Crypt: Graveyard/Crypt.

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
- Talk to teach for banjo.
- Unlock field and/or forest. Field needs chicken.
- Go through woods. Navy lets you in.
- Get sword from chest.
- Fight and kill Lime & Mask.
- Navy is sad. Give you college savings.
- Go to ice castle
- Gather ducks across hiroll.
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

Duck Spirit:
    - idk

Grover:
    - zeldo's dad

Ivan:
    - repeat of previous bosses + something else?

## Areas
Ice Castle, Graveyard, Zeldo Home, Field, Mountain Area, Spike Forest, Village

## Randomness
how about chicken starts with jane. she says she will make soup. soup is done when you beat lime.

each chicken has a name. later in the game, cannon asks where quin is. that's the one jane cooked.

maybe cannon says you smell like quack soup. he hates quack soup. ducks are
friends. so he gets angry and sends his pet duck to fight you. Then you settle
the duel with a game of tennis.

"i'm hungry, i mean i'm cannon"
"hey, thanks for the soup"
"what kind of soup was that anyways"
".. 

remember me lank? i've been waiting all day. lets play tennis now.

a different part of the game has a duck boss. Maybe ivan fight? no, graveyard

mask: salesman sells it.
bow:  secret duck boss in graveyard?

you want to see my daughter? she's in her house on the other side of the graveyard. careful, there are ghosts.
secret duck miniboss in graveyard. get slingshot

secret area in forest, lime gives you the mask.

save lime. lime says she bought a mask from someone in the forest and went crazy.
you can buy that mask too after you get bombs.

ivan says cannon is the creepy guy who gave her the mask.

sword belongs to lark's father.

you dare to drink duck soup next to a duck's grave? How dare you.
i think you need to learn a lesson.

soup is temporary

my daughter is trapped behind this giant rock. if only someone had a bomb to save her.
mwa heh ha... i've been waiting for you. you must be that creep that wants to marry my daughter.
if you want to see her that bad, you'll have to get through this crypt i filled with monsters. heh.
