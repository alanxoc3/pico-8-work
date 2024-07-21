f_zcall(poke, [[
   ;,0x5f2c,   3  -- screen to 64x64
  ;;,0x5f5c,   8  -- set btn initial delay before repeating. 255 means never repeat.
  ;;,0x5f5d,   1  -- set btn repeating delay.
  ;;,S_STORY,  58 -- todo: remove me, this is just for debugging
]])

cls() -- this is just a visual thing when the game starts up. TODO: i can remove it if i want. probably should
|[c_move_names]|        f_zobj[["0,strugl;,acid,acidar,barage,bonclb,bind,clamp,moonlt,lechsd,extrsp,sncbom,twindl,thnshk,glare,gilotn,hypfng,jmpkck,kinsis,lockon,lovkis,macpnc,vicgrp,spican,spikes,spore,cotspr,presnt,vithrw,cmtpnc,drlpck,sndatk,agilty,fryatk,qikatk,falswp,growl,healbl,sing,pound,minmiz,tailwp,dblslp,meghrn,bonrng,convr1,convr2,spark,mlkdrk,morsun,ngtshd,octzok,pinmis,pwdsnw,supfng,firspn,psngas,barier,medtat,ftrsgt,hypnos,psybem,litscr,safgrd,petdnc,charm,synths,swtscn,razlef,psnpwd,slppwd,absorb,stnspr,flail,confsn,slam,constr,amnesa,bubble,splash,hydpmp,mindrd,mist,hrnatk,spiweb,dblkck,swtkis,mtlclw,trform,trikck,gust,twistr,crbham,dizpnc,sludge,painsp,dstbnd,haze,lick,persng,meanlk,cnfray,crschp,smog,karchp,ember,smkscr,beldrm,beatup,scrtch,slash,ancpwr,leer,bite,outrge,scryfc,thrash,stomp,roksld,magtud,rocthr,harden,bonrsh,hijkck,recovr,aerbls,hrndrl,drgrag,sfboil,drgbre,slfdes,explsn,eggbmb,slgbmb,gigdrn,megdrn,swrdnc,cut,fryctr,thief,dig,rolout,dfncrl,detect,solbem,raidnc,flash,psycic,psycup,drmeat,ngtmar,shdbal,zapcan,thundr,thnblt,irntal,streng,rocsms,hedbut,mudslp,sunday,protct,dbltem,slptlk,curse,hidpwr,swager,frustr,return,toxic,snore,rest,endure,atract,bide,mimic,substu,rage,dbledg,takdwn,sklbas,bodslm,wtrgun,bblbem,icebem,blizrd,icywnd,surf,wrlpol,wtrfal,swift,payday,triatk,rflect,thnwav,telprt,psywav,metrnm,countr,megpnc,seitos,submis,megkck,dynpnc,firpnc,thnpnc,icepnc,firbls,flmthr,fisure,eartqk,sndstr,hypbem,roar,stlwng,fly,razwnd,wrlwnd,skyatk,wngatk,peck,mirmov,fntatk,witdrw,rapspn,supsnc,aurbem,mircot,psnstg,spite,crunch,pursut,strsht,lechlf,btnpas,disabl,screch,tackle,flmwel,revrsl,fryswp,fcseng,forsgt,lowkck,rolkck,encore,wrap,growth,vinwip,sacfir,sharpn,sketch,tm05,______"]] $$
|[c_trnr_names]|        split"youngs,sage,falknr,grunt,bugctr,bugsy,pkmfan,beauty,witney,kimono,medium,morty,police,karate,chuck,gentle,sailor,jasmin,rocket,skier,pryce,scient,twins,clair,nerd,camper,brock,school,swimer,misty,jugler,guitar,ltsurg,hiker,lass,erika,biker,picnik,janine,maniac,psycic,sabrin,fisher,breath,blaine,birdkp,cooltr,blue,legend,silver,will,koga,bruno,karen,lance,red,gold,horde" $$
|[c_type_names]|        f_zobj[["0,none;,normal,fire,fightng,water,poison,electrc,ground,grass,flying,ice,bug,psychic,rock,dragon,ghost,dark,steel,bird"]] $$
|[c_item_names]|        f_zobj[["0,none;,pnkbow,chrcol,blkblt,myswtr,psnbrb,magnet,sosand,mirasd,shbeak,nvrice,slvpwd,twspon,hrdstn,dragsc,speltg,blkgls,mtlcot,plkbow,bripwd,focbnd,kingrk,leftov,qikclw,scopln,amcoin,litbal,lukpnc,mtlpwd,stick,thkclb,bersrk,berry,gldbry,btrbry,mntbry,brnbry,icebry,parbry,psnbry,mirbry,mysbry"]] $$
|[c_team_names]|        f_zobj[["0,boy;,girl,cpu-boy,cpu-girl"]] $$

|[c_pkmn_names]| f_zobj[[
 0,"misingno"
 ;,"bulbsaur"
  ,"ivysaur"
  ,"venusaur"
  ,"charmand"
  ,"charmeln"
  ,"charzard"
  ,"squirtle"
  ,"wartortl"
  ,"blastois"
  ,"caterpie"
  ,"metapod"
  ,"butrfree"
  ,"weedle"
  ,"kakuna"
  ,"beedrill"
  ,"pidgey"
  ,"pidgeoto"
  ,"pidgeot"
  ,"rattata"
  ,"raticate"
  ,"spearow"
  ,"fearow"
  ,"ekans"
  ,"arbok"
  ,"pikachu"
  ,"raichu"
  ,"sndshrew"
  ,"sndslash"
  ,"nidoranf"
  ,"nidorina"
  ,"nidoquen"
  ,"nidoranm"
  ,"nidorino"
  ,"nidoking"
  ,"clefairy"
  ,"clefable"
  ,"vulpix"
  ,"ninetale"
  ,"jiglypuf"
  ,"wiglytuf"
  ,"zubat"
  ,"golbat"
  ,"oddish"
  ,"gloom"
  ,"vileplum"
  ,"paras"
  ,"parasect"
  ,"venonat"
  ,"venomoth"
  ,"diglett"
  ,"dugtrio"
  ,"meowth"
  ,"persian"
  ,"psyduck"
  ,"golduck"
  ,"mankey"
  ,"primeape"
  ,"growlith"
  ,"arcanine"
  ,"poliwag"
  ,"polwhirl"
  ,"polwrath"
  ,"abra"
  ,"kadabra"
  ,"alakazam"
  ,"machop"
  ,"machoke"
  ,"machamp"
  ,"belsprot"
  ,"weepnbel"
  ,"victrbel"
  ,"tntacool"
  ,"tntcruel"
  ,"geodude"
  ,"graveler"
  ,"golem"
  ,"ponyta"
  ,"rapidash"
  ,"slowpoke"
  ,"slowbro"
  ,"magnemit"
  ,"magneton"
  ,"fafetchd"
  ,"doduo"
  ,"dodrio"
  ,"seel"
  ,"dewgong"
  ,"grimer"
  ,"muk"
  ,"shellder"
  ,"cloyster"
  ,"gastly"
  ,"haunter"
  ,"gengar"
  ,"onix"
  ,"drowzee"
  ,"hypno"
  ,"krabby"
  ,"kingler"
  ,"voltorb"
  ,"electrod"
  ,"exegcute"
  ,"exegutor"
  ,"cubone"
  ,"marowak"
  ,"hitmnlee"
  ,"hitmnchn"
  ,"licktung"
  ,"koffing"
  ,"weezing"
  ,"rhyhorn"
  ,"rhydon"
  ,"chansey"
  ,"tangela"
  ,"kangakan"
  ,"horsea"
  ,"seadra"
  ,"goldeen"
  ,"seaking"
  ,"staryu"
  ,"starmie"
  ,"mrmime"
  ,"scyther"
  ,"jynx"
  ,"elecabuz"
  ,"magmar"
  ,"pinsir"
  ,"tauros"
  ,"magikarp"
  ,"gyarados"
  ,"lapras"
  ,"ditto"
  ,"eevee"
  ,"vaporeon"
  ,"jolteon"
  ,"flareon"
  ,"porygon"
  ,"omanyte"
  ,"omastar"
  ,"kabuto"
  ,"kabutops"
  ,"aerodact"
  ,"snorlax"
  ,"articuno"
  ,"zapdos"
  ,"moltres"
  ,"dratini"
  ,"dragnair"
  ,"dragnite"
  ,"mewtwo"
  ,"mew"
  ,"chikrita"
  ,"bayleef"
  ,"meganium"
  ,"cyndquil"
  ,"quilava"
  ,"typhlosn"
  ,"totodile"
  ,"croconaw"
  ,"fralgatr"
  ,"sentret"
  ,"furret"
  ,"hoothoot"
  ,"noctowl"
  ,"ledyba"
  ,"ledian"
  ,"spinarak"
  ,"ariados"
  ,"crobat"
  ,"chinchou"
  ,"lanturn"
  ,"pichu"
  ,"cleffa"
  ,"igglybuf"
  ,"togepi"
  ,"togetic"
  ,"natu"
  ,"xatu"
  ,"mareep"
  ,"flaaffy"
  ,"ampharos"
  ,"belossom"
  ,"marill"
  ,"azumaril"
  ,"sudwoodo"
  ,"politoed"
  ,"hoppip"
  ,"skiploom"
  ,"jumpluff"
  ,"aipom"
  ,"sunkern"
  ,"sunflora"
  ,"yanma"
  ,"wooper"
  ,"quagsire"
  ,"espeon"
  ,"umbreon"
  ,"murkrow"
  ,"slowking"
  ,"misdrvus"
  ,"unown"
  ,"wobbufet"
  ,"girafrig"
  ,"pineco"
  ,"foretres"
  ,"dunsparc"
  ,"gligar"
  ,"steelix"
  ,"snubbull"
  ,"granbull"
  ,"qwilfish"
  ,"scizor"
  ,"shuckle"
  ,"heracros"
  ,"sneasel"
  ,"tediursa"
  ,"ursaring"
  ,"slugma"
  ,"magcargo"
  ,"swinub"
  ,"piloswin"
  ,"corsola"
  ,"remoraid"
  ,"octilery"
  ,"delibird"
  ,"mantine"
  ,"skarmory"
  ,"houndour"
  ,"houndoom"
  ,"kingdra"
  ,"phanpy"
  ,"donphan"
  ,"porygon2"
  ,"stantler"
  ,"smeargle"
  ,"tyrogue"
  ,"hitmntop"
  ,"smoochum"
  ,"elekid"
  ,"magby"
  ,"miltank"
  ,"blissey"
  ,"raikou"
  ,"entei"
  ,"suicune"
  ,"larvitar"
  ,"pupitar"
  ,"tyrnitar"
  ,"lugia"
  ,"hooh"
  ,"celebi"
  ,"________"
  ,"none" -- todo: is this used?
  ,"___" -- todo: is this used?
  ,"___" -- todo: is this used?
]] $$ -- todo: last 2 ___ blanks can be removed. maybe none can too? or that is used for prevol? celebi, (the none pokemon for ui), (empty pokemon ind that prevolve points to), unused, unused.

|[c_gender_names]|      f_zobj[["0,neuter;,male,female,mal/fem"]] $$
|[c_major_names_long]|  f_zobj[["0,none;,faint,burn,freeze,parlyz,poisnd,sleep"]] $$
|[c_major_names_short]| f_zobj[["0,___;,fnt,brn,fzn,par,psn,slp"]] $$
|[c_movemethod_names]|  split"learn,teach,cheat" $$
|[c_statmod_names]|     f_zobj[[attack,"atack", defense,"defns", specialattack,"spatk", specialdefense,"spdfn", speed,"speed", evasion,"evasn", accuracy,"acury", crit,"critl"]] $$

-- todo: can this go in cartridge data? maybe i dont want that though (uses more tokens)
|[c_palettes]| f_zobj[[
  -- bg   mg   fg
  0;,129 ,13  ,6   -- dual
  ;;,1   ,140 ,12  -- blue
  ;;,130 ,136 ,8   -- red
  ;;,131 ,3   ,138 -- green
  ;;,0   ,8   ,10  -- htdog
  ;;,5   ,134 ,6   -- silvr
  ;;,4   ,9   ,10  -- gold
]] $$

|[c_palette_names]| f_zobj[["0,DUAL VERSION;,BLUE VERSION,RED VERSION,GREEN VERSION,HOTDOG FLAVOR,SILVR VERSION,GOLD VERSION"]] $$

|[c_types]| f_zobj[[ -- 0 to 18 are all tables
  0;, ;;, ;;, ;;, ;;, ;;, ;;, ;;, ;;,
  ;;, ;;, ;;, ;;, ;;, ;;, ;;, ;;, ;;,
  ;;,
]] $$

|[f_init_peek_inc]| function()
  g_init_peek_loc += 1
  return @g_init_peek_loc
end $$

-- STEP 2: UNPACK TYPE CHART
for i=0,360 do -- 19*19-1 = 324 (19 types, including BIRD and NONE)
  c_types[i\19][i%19] = f_init_peek_inc()/2 -- want division, not integer division. need .5 for less effective moves
end

for i=0,I_END do add(c_items,  f_zobj([[lock,~c_no,  num,@, name,@]], i, c_item_names[i] )) end

-- 136 to 118. Storing data all together saves like 18 code tokens.
for i=0,252 do -- There are 252+1 pkmn and 252+1 moves. The +1s are for empties. So zipped when unpacking to save some tokens.
  local pkmn = f_zobj([[moves_progress;,#,#,#; moves_grouped;,#,#,#; lock,~c_no, pktype2,T_NONE, prevolve,P_EMPTY, name,@, num,@, num_str,@]], c_pkmn_names[i], i, f_prefix_zero(i < P_NONE and i or "???", 3))

  -- cur_list is not local just so I can save 1 token
  cur_list, c_moves[i], c_pokemon[i] = pkmn.moves_progress[1], f_zobj([[lock,~c_no, num,@, name,@]], i, c_move_names[i]), pkmn -- todo: get rid of i-1

  foreach(split'pow,pktype,accuracy,maxpp', function(key)
    c_moves[i][key] = f_init_peek_inc()
  end)

  -- TODO: if these can fit in data section, that would be very sweetscent.
  c_moves[i].pp_obj = {pp=c_moves[i].maxpp}
  c_moves[i].func = _g[c_move_funcs[i][1]]
  c_moves[i].spec = c_move_funcs[i][2]

  -- TODO: idea, i could use the last bit of type1 to specify an extra gender byte. uses more space but saves 13 tokens
  -- 'item' actually has gender and item information, but keeping the name item saves a possible token
  foreach(split'pktype1,hp,attack,defense,speed,specialattack,specialdefense,default_item', function(key)
    pkmn[key] = f_init_peek_inc()
  end)
  for i, key in ipairs{'pktype2','prevolve'} do
    if pkmn.pktype1 >> (4+i) & 1 == 1 then
      pkmn[key] = f_init_peek_inc()
    end
  end

  pkmn.pktype1 &= 31 -- 0b 0001 1111

  foreach(split'hp,attack,defense,speed,specialattack,specialdefense', function(key)
    -- This calculates the max stat possible at level 50. Simplified a ton from the original formula.
    -- HP is different and needs to add an extra 55 to the value (+ level + 10).
    -- Original formula came from here:
    -- https://bulbapedia.bulbagarden.net/wiki/Individual_values#Usage

    -- Stat calculator helped verify: https://pycosites.com/pkmn/stat_gen2.php
    -- MAX EV: 65535 | MAX IV: 15
    pkmn[key] += 52
  end)
  pkmn.hp += 55
  pkmn.maxhp = pkmn.hp -- TODO: save a token by combining with below eqals statement. actually all these sets could use zobj possibly
  pkmn.gender_mask = pkmn.default_item >>> 6 & G_BOTH
  pkmn.default_item &= 63 -- all bits except first two (0x3f or 0b00111111)

  while f_init_peek_inc() < C_NEXT do
    if     @g_init_peek_loc == C_TEACH then cur_list = pkmn.moves_progress[2]
    elseif @g_init_peek_loc == C_EVENT then cur_list = pkmn.moves_progress[3]
    elseif @g_init_peek_loc == C_DASH  then
      for j=cur_list[#cur_list-1]+1,cur_list[#cur_list]-1 do
        add(cur_list, j)
      end
    else
      add(cur_list, @g_init_peek_loc)
    end
  end
end

for i=0,252 do
  local sub = c_pokemon[i]

  while sub do
    for ii=1,3 do
      foreach(sub.moves_progress[ii], function(v)
        add(c_pokemon[i].moves_grouped[ii], v)
      end)
    end

    sub = c_pokemon[sub.prevolve]
  end
end

for i=0,252 do -- todo: token crunching - can move up
  -- having metatables here causes me to run out of lua memory, lets keep good ol' number arrays
  c_pokemon[i].possible_moves = f_zobj[[,M_NONE,M_NONE,M_NONE,M_NONE]]
  c_pokemon[i].possible_moves_method = f_zobj[[M_NONE,"empty"]]

  for ii=1,3 do
    foreach(c_pokemon[i].moves_grouped[ii], function(v)
      -- this if statement is required for pokemon learn a move naturally and their prevolve learns the move through teaching.
      -- Specifically Jigglypuff/Igglybuff have this scenario with rest & rollout. There may be others too.
      -- Missingno is the only exception here because it is the only pokemon that can learn multiple of one move (watergun)
      if i == P_MISSINGNO or not c_pokemon[i].possible_moves_method[v] then
        add(c_pokemon[i].possible_moves, v)
        c_pokemon[i].possible_moves_method[v] = c_movemethod_names[ii]
      end
    end)
  end

  -- TODO: This obviously takes up a few tokens, but it frees up 272 mb of lua memory.
  -- c_pokemon[i].moves_progress = nil
  -- c_pokemon[i].moves_grouped = nil

  -- And finally, set stats/etc on the base pokemon.
  c_pokemon[i] = f_mkpkmn(i, c_pokemon[i], false, false, I_NONE, 5, 6, 7, 8) -- sets the moves for dex entries!
end

for i=1,57 do
  local trainer = {num=f_init_peek_inc()}
  trainer.move = f_init_peek_inc()
  for j=1,6 do add(trainer, f_init_peek_inc()) end
  add(c_trainers, trainer)
end

-- Logic to add the horde.
-- TODO: dedup with above
-- TODO: figure out how trainer len/party goes to battle
--       only trainers are saved as continuous things.

local horde = {num=P_GHOST, move=M_TM05} -- Maybe this should be struggle, I guess it works for now since only 1 pokemon knows it (missingno) -- i could go back to having tm05 be a teach move for missingno
for i=1,252 do add(horde, i%252) end
add(c_trainers, horde)

-- TODO: REMOVE THIS! Only keep this for debugging. Someone could accidentally set it. But really, it falls out of scope of my idea of a fantasy console. And there is a slight bug not worth fixing on the UI when this is done.
menuitem(1, "factory reset", function()
  cls() flip() -- Makes the screen go black while resetting
  memset(0x5e00, 0, 256)
  run() -- this is the function that reruns the cartridge
end)

|[f_unlock]| function(list, ind)
  list[ind].lock = true
end $$

-- TODO: does this need to be extracted into a function, or can it just run here?
|[f_update_locks]| function(start_trnr) -- game lags with this function, so it should be called when there can be a lag. TODO: Or I could try speeding it up?
  f_unlock(c_items, I_NONE+1)
  f_unlock(c_items, I_BERRY+1) -- berry is nice to have to start with

  -- these are the moves available in the default party -- TODO: Maybe I can use GROWL. I think Bulb/Chik/Charm are the 3 that can learn growl. not positive.
  -- Because this happens before unlocking the trainers, the default team will survive a factory reset! Which is good, though factory reset will probably not be available in the released game to save tokens and users accidentally resetting.
  for ind in all(split'M_STRUGGLE,M_NONE,M_LEECHSEED,M_EMBER,M_WATERGUN,M_VINEWHIP,M_TACKLE,M_BITE,M_TAILWHIP,M_LEER,M_SMOKESCREEN,M_LIGHTSCREEN,M_SCREECH') do
    f_unlock(c_moves, ind)
  end

  for i, ind in ipairs(split'P_BULBASAUR,P_CHARMANDER,P_SQUIRTLE,P_CHIKORITA,P_CYNDAQUIL,P_TOTODILE,P_NONE') do -- 6 starter pokemon. the none pokemon should be unlocked too
    f_unlock(c_pokemon, ind)
    if @S_NEW == 0 then
      f_save_party_pkmn(f_mkpkmn(ind, c_pokemon[ind], true, 0, 0, 5, 5, 5, 5), 0, i-1)
    end
  end

  if @S_NEW == 0 then
    poke(S_NEW, 1)
    memset(S_PARTY2, P_NONE, 126) -- set the "NONE" pokemon to all the other slots. this is 0x7e, which is the length of 3 parties
  end

  for i=start_trnr,min(58,@S_STORY) do
    local team = f_team_league(i, i\58*251+1) -- this math will do start the team at just missingno for the last team, that way missingno gets unlocked.
    for pkmn in all(team) do
      f_unlock(c_pokemon, pkmn.num)
      f_unlock(c_items, pkmn.item+1)
      for i=1,4 do
        f_unlock(c_moves, pkmn[i].num)
      end
    end
  end
end $$
f_update_locks'1' -- unlock everything from the first trainer to the current trainer

-- after we have read all the bytes, we can now apply filters to the sfx for the cool sounding pkmn cries.
-- sfx starts at 0x3200. each sfx are 68 bytes. 64 for notes then 4 for effects.
-- 0x4278 = 0x3200+63*68 (0 to 62, only modify 63/64 sfx, because 63*4 = 252, which is how many pkmn there are)
for iloc=0x3200, 0x4278, 68 do
  for loc=iloc, iloc+63, 2 do
    -- breaking apart the bits:
    -- & 0b0111000011011111 (0x70df)
    --   0: disable custom waves
    --   111: keep the note effects
    --   000: dont keeep the volume
    --   011: only allow triangle, tilted saw, saw, and square waves. tilted saw usually gives the "meat" of the cry.
    --   011111: note pitch, but remove the top bit so we don't have tons of super high pitched noises (lots of 255 and 254)
    -- | 0b0000100000000000 (0x0c00): set the volume to 6 for everything (0=0, 2=1, 4=2, 6=3, 8=4, a=5, c=6, e=7)

    poke2(loc, %loc & 0x70df | 0x0a00)
  end

  -- breaking apart the bits:
  -- 0x00: zero out the beg loop
  -- 0x00: zero out the end loop
  -- 0x07: set speed to 7
  -- 0xd7: somehow sets noiz, buzz, detune, reverb, dampen all to max
  poke4(iloc+64, 0x.07d7)
end
