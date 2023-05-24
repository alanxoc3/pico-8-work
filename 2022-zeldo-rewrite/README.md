# Not The Story of Zeldo
Lank wakes up from a good night's rest only to find Hi-roll in danger! Ya gotta
help him save the Land of Hi-roll from the FORCES-OF-EVIL.

# Todo List
TODO: separate code into shared & not shared
TODO: 3 jump then bouncy shot
TODO: no spikes when you beat boss?
TODO: eliminate randomness
TODO: slime refactor
TODO: chest with sword
TODO: fix miny logic
TODO: banjo with lark text logic
TODO: add "i am glitch" (fixes in lark section)
TODO: bugfix bomb hold when no energy
TODO: banjo makes enemies dance (not attack you)
TODO: item going up snap/fix
TODO: chicken follow not throw
TODO: get item logic
TODO: right ma sprite shouldn't be flipped
TODO: fix item offsets (many items are either off or sometimes off)
TODO: when items go up, slight bug
TODO: token crunch for 30 minutes
TODO: bomb blow up crate
TODO: first boss (lime)
TODO: mask particle effect
TODO: polish until beating first boss
TODO: think of more enemies
TODO: think about chicken collection for canon logic (throw chicken onto a platform)
TODO: remove duck throw
TODO: duck throw
TODO: duck follow logic
TODO: don't wait for ma for picking things up/interacting (pot, duck?)

# refactoring ideas:
Maybe, I could replace the whole zclass system with a metatable.

Everything could have all parents, with the defaults. These are the things that currently use id/parents:

pl-10.lua:43:        if obj.id == 'pot' then
pl-10.lua:46:        elseif obj.id == 'quack' then
pl-10.lua:286:    if (g_rstat_right:get() or {}).id == 'saveplat' and a:get_elapsed_percent'min_play' and a:get_elapsed_percent'min_play' >= 1 then
pl-10.lua:394:    return override or not a.item or a.item.id ~= 'mask'
ui-10.lua:146:        local has_health = obj.parents and obj.parents.healthobj

Should work as long as there are no table values... Oh. States are problematic. I would have to never touch them and it wouldn't add correctly.... This idea might not pan out actually.

One idea could be, definitions are prepended with strings that represent parents. I really do wonder if the base library functions could be trimmed down. No matter how big the refactor would be.

What are the limitations of the trimmed down picodex library? no parents

Oh, well adding to a parents array is really useful. any way to get around that?

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
- long:       village/house
- long:       forest
- long+short: field/mountain
- long: castle/canon
- long: crypt
- long: ivan boss fight (based on computer room)
- long: endless mode
- shrt: title screen
- shrt: intro (cut scene)
- shrt: graveyard (village + crypt)
- shrt: forest boss
- shrt: computer room
- shrt: game over
- shrt: meh?

## Characters
Lank   - Main character.
Ivan   - Evil fairy.
Navy   - Older brother of Lime, first boss.
Lime   - Younger sister of Navy, gives you the sword. Year passed.
Bobb   - Husband of Jane.
Jain   - Bob's wife.
Teach  - The banjo teacher.
Grover - The gravedigger. Zeldo's dad.
Teach  - The teacher.
Keep   - The shopkeeper.
Lark   - Mayor of town.
Canon  - Proposed to zeldo with squareforce. Weirdo dressed as santa. Gave Lime the mask.
Zeldo  - Canon proposed to her with squareforce.

## Item Locations
Sword  - Mandatory. Chest next to tomb stone.
Cup    - Mandatory. From Navy.
Banjo  - Mandatory. From chest in house.
Bomb   - Mandatory. From canon in ice castle.
Brang  - Optional.  4 coins from shop in village.
Shield - Optional.  4 coins from shop in field. Need brang.
Sling  - Optional.  4 coins from shop in crypt. Need bomb.
Ears   - Optional.  4 coins from shop in woods.

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
Coin #6  - Vilag: Play banjo for Lark.
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

## Multicart format
If I have to end up making a multicart. Here are the divisors:
- Title
- Village
- Woods - Slobs
- Crypt - Duke
- Field - Ivan
- Mountain - Canon

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
- Find sword in chest next to tombstone.
- Navy lets you enter woods.
- Fight Slobs to save Lime.
- Go back to Navy's house & get a cup.
- Fill cup with Quack soup.
- Bobb lets you enter field.
- Go through field to ice castle.
- Canonball tennis. Bombs spawn that you have to dodge. A canonball is flung between you and canon. Hit it with your sword to deflect.
- Reveal. Ivan tells Lank to kill Canon. Ask where squareforce is. Runs away.
- Canon gives Lank bombs.
- Use bomb to enter crypt.
- Grover sets traps in each room of crypt.
- He prepares for boss fight when you reach the end, but Zeldo stops him.
- She says Canon gave her the square to propose to her, but she doesn't even want it, hands to Lank, but Ivan intercepts.
- Ivan takes it away. Game glitches. Lots of enemies. Find Ivan.
- Ivan in computer room.
- Go there for final fight, extra monsters along the way to block your path.
- Ivan has powers of all bosses, enemies, & lank. He appears as a shadow Lank.
- After game is beat, Lark has endless mode.
- Most characters don't say anything new after game is beat.

## Quotes
- Here's my heart.
- All that's left of my son.
- Silly lank, only works against evil forces. That tickles (canon says on deathbead)
- Canon can't give gifts. He gave some kid a creepy mask and now he gives me a hunk of metal.
- I gave it to zeldo you know the gravedigger's daughter?
- I used most of my explosives on tennis match. This is all I have left, please use it to save my fiancee zeldo.
- Take these infinite bombs.
- Only someone loaded with explosives could have gotten past that barrier. You must be the creep that wants to marry my daughter!
- Daddy! Lank can't talk. How can he even propose to me? Canon is the creep you're looking for!

## Boss Fights
- Slobs
- Canon
- Duke
- Ivan

## Areas
Ice Castle, Graveyard, Zeldo Home, Field, Mountain Area, Spike Forest, Village

## Randomness
how about chicken starts with jane. she says she will make soup. soup is done when you beat lime.

each chicken has a name. later in the game, canon asks where quin is. that's the one jane cooked.

maybe canon says you smell like quack soup. he hates quack soup. ducks are
friends. so he gets angry and sends his pet duck to fight you. Then you settle
the duel with a game of tennis.

"i'm hungry, i mean i'm canon"
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

ivan says canon is the creepy guy who gave her the mask.

sword belongs to lark's father.

you dare to drink duck soup next to a duck's grave? How dare you.
i think you need to learn a lesson.

soup is temporary

my daughter is trapped behind this giant rock. if only someone had a bomb to save her.
mwa heh ha... i've been waiting for you. you must be that creep that wants to marry my daughter.
if you want to see her that bad, you'll have to get through this crypt i filled with monsters. heh.

2 different levels of ma. Battle level and interact level. Interact level is higher priority.

years have past since cannon tried to take over hiroll.
