-------------------------------------------------------
-- BELOW IS INIT LOGIC. NOT IN FUNCTION TO SAVE TOKENS!
-------------------------------------------------------

|[c_trainers]| f_zobj[[]] $$

local _ENV = _g -- todo: this can be removed i think

-- clear all the read only memory. testing things out showed that this doesn't get cleared automatically.
memset(0x8000, 0, 0x7fff)

f_zcall(poke, [[
   ;,0x5f5c, 8 -- set btn initial delay before repeating. 255 means never repeat.
  ;;,0x5f5d, 1 -- set btn repeating delay.
]]) -- TODO: I could do something really hacky if I need to save 4 tokens... Combine this with the memcpy below and find a spot with a "1" and "8". Love it...

-- TODO: replace peeks with peek_inc, save tokens.

-- STEP 2: UNPACK TYPE CHART
|[f_init_peek_inc]| function()
  g_init_peek_loc += 1
  return @g_init_peek_loc
end $$

-- 136 to 118. Storing data all together saves like 18 code tokens.
for i=0,251 do -- There are 252 pkmn and 252 moves. So zipped when unpacking to save some tokens.
  local pkmn = f_zobj[[learn;, ;teach;, ;event;,]]
  -- cur_list is not local just so I can save 1 token
  cur_list, c_moves[i], c_pokemon[i] = pkmn.learn, {}, pkmn

  foreach(split'pow,type,acc,pp', function(key)
    c_moves[i][key] = f_init_peek_inc()
  end)

  foreach(split'prevolve,type1,type2,hp,att,def,spd,sat,sdf,gender_item', function(key)
    pkmn[key] = f_init_peek_inc()
  end)

  while f_init_peek_inc() < C_NEXT do
    if     @g_init_peek_loc == C_TEACH then cur_list = pkmn.teach
    elseif @g_init_peek_loc == C_EVENT then cur_list = pkmn.event
    elseif @g_init_peek_loc == C_DASH  then
      for j=cur_list[#cur_list-1]+1,cur_list[#cur_list]-1 do
        add(cur_list, j)
      end
    else
      add(cur_list, @g_init_peek_loc)
    end
  end
end

|[c_types]| f_zobj[[ -- 0 to 17 are all tables
  0;, ;;, ;;, ;;, ;;, ;;, ;;, ;;, ;;,
  ;;, ;;, ;;, ;;, ;;, ;;, ;;, ;;, ;;,
]] $$

for i=0,323 do -- 18*18 = 324 (18 types)
  c_types[i\18][i%18] = f_init_peek_inc()\2
end

for i=0,56 do
  c_trainers[i] = {move=f_init_peek_inc()}
  for j=1,6 do
    add(c_trainers[i], f_init_peek_inc)
  end
end

for i=0,251 do
  local sub = c_pokemon[i]

  while sub.prevolve < 252 do
    sub = c_pokemon[sub.prevolve]

    foreach(split'learn,teach,event', function(key)
      foreach(sub[key], function(v)
        add(c_pokemon[i][key], v)
      end)
    end)
  end
end

|[c_move_names]| split"struggl,acid,acidarm,barrage,bonclub,bind,clamp,moonlit,lechsed,extrspd,soncbom,twineed,thnshck,glare,gilotin,hypfang,jmpkick,kinesis,lockon,lovkiss,macpnch,vicegrp,spkcann,spikes,spore,cotspor,present,vitthrw,cmtpnch,drlpeck,sandatk,agility,furyatk,quikatk,falswip,growl,healbel,sing,pound,minimiz,tailwhp,dblslap,meghorn,bonrang,conver,conver2,spark,mlkdrnk,mornsun,ngtshad,octzook,pinmiss,powdsnw,supfang,tm05,firspin,psngas,barrier,meditat,futsigt,hypnosi,psybeam,litscrn,safegrd,petldnc,charm,synthes,swtscen,razleaf,psnpowd,slppowd,absorb,stnspor,flail,cnfsion,slam,constri,amnesia,bubble,splash,hydrpmp,mndread,mist,hornatk,spdrweb,dblkick,swtkiss,mtlclaw,trnform,trikick,gust,twister,crabham,dizpnch,sludge,painspl,dstbond,haze,lick,persong,meanlok,cnfsray,croschp,smog,karachp,ember,smkscrn,beldrum,beatup,scratch,slash,ancpowr,leer,bite,outrage,scarfac,thrash,stomp,rocslid,magntud,rocthrw,harden,bonrush,hijkick,recover,aerblst,horndrl,drgrage,sofboil,drgbrea,selfdes,explosi,eggbomb,slgbomb,gigdrai,megdrai,swordnc,cut,furycut,thief,dig,rollout,defcurl,detect,solbeam,raindnc,flash,psychic,psychup,drmeatr,ngtmare,shadbal,zapcann,thunder,thnbolt,irntail,strngth,rocsmas,headbut,mudslap,sunyday,protect,dblteam,slptalk,curse,hidpowr,swagger,frustra,return,toxic,snore,rest,endure,attract,bide,mimic,substit,rage,dbledge,takdown,sklbash,bodslam,watrgun,bblbeam,icebeam,blizard,icywind,surf,wrlpool,watrfal,swift,payday,triatk,reflect,thnwave,telport,psywave,metrnom,counter,megpnch,seitoss,submiss,megkick,dynpnch,firpnch,thnpnch,icepnch,firblst,flmthrw,fissure,earquak,sandsto,hypbeam,roar,stlwing,fly,razwind,wrlwind,skyatk,wingatk,peck,mirmove,fainatk,withdrw,rapspin,supsonc,aurbeam,mircoat,psnstng,spite,crunch,pursuit,strshot,lechlif,btnpass,disable,screech,tackle,flmweel,reversl,furywip,fcsnrgy,forsigt,lowkick,rolkick,encore,wrap,growth,vinwhip,sacrfir,sharpen,sketch" $$
|[c_pkmn_names]| split"missing,bulsaur,ivysaur,vensaur,charman,charmel,charzar,squirtl,wartort,blstois,catrpie,metapod,butfree,weedle,kakuna,beedril,pidgey,pidgeto,pidgeot,rattata,raticat,spearow,fearow,ekans,arbok,pikachu,raichu,sndshrw,sndslas,nidranf,nidrina,nidquen,nidranm,nidrino,nidking,clfairy,clfable,vulpix,nintale,jigpuff,wigtuff,zubat,golbat,oddish,gloom,vilplum,paras,parsect,venonat,venmoth,diglett,dugtrio,meowth,persian,psyduck,golduck,mankey,primape,growlth,arcanin,poliwag,polwirl,polrath,abra,kadabra,alkazam,machop,machoke,machamp,belsprt,weepbel,victbel,tntcool,tntcrul,geodude,gravler,golem,ponyta,rapdash,slowpok,slowbro,magnmit,magnton,fafetch,doduo,dodrio,seel,dewgong,grimer,muk,shelder,clyster,gastly,haunter,gengar,onix,drowzee,hypno,krabby,kingler,voltorb,elcrode,eggcute,eggutor,cubone,marowak,hitmlee,hitmchn,liktung,koffing,weezing,rhyhorn,rhydon,chansey,tangela,kangkan,horsea,seadra,goldeen,seaking,staryu,starmie,mrmime,scyther,jynx,elcabuz,magmar,pinsir,tauros,magkarp,gyardos,lapras,ditto,eevee,vapreon,jolteon,flareon,porygon,omanyte,omastar,kabuto,kabtops,aerodac,snorlax,artcuno,zapdos,moltres,dratini,dragair,dragite,mewtwo,mew,chikita,bayleef,megnium,cyndqil,quilava,typhlos,totodil,crocnaw,frlgatr,sentret,furret,hootoot,noctowl,ledyba,ledian,spinrak,ariados,crobat,chinchu,lanturn,pichu,cleffa,iggbuff,togepi,togetic,natu,xatu,mareep,flaaffy,amphros,belosom,marill,azmaril,sudwood,poltoed,hoppip,skiplom,jumpluf,aipom,sunkern,sunflor,yanma,wooper,quagsir,espeon,umbreon,murkrow,slowkng,misdvus,unown,wobufet,gifarig,pineco,fortres,dunspar,gligar,steelix,snubbul,granbul,qilfish,scizor,shuckle,hercros,sneasel,tediurs,ursring,slugma,macargo,swinub,pilswin,corsola,remraid,octlery,delbird,mantine,skarmry,hondour,hondoom,kingdra,phanpy,donphan,porygn2,stantlr,smeargl,tyrogue,hitmtop,smoochm,elekid,magby,miltank,blissey,raikou,entei,suicune,larvtar,pupitar,tyratar,lugia,hooh,celebi" $$
|[c_trnr_names]| split"youngst,sage,falkner,rktgrnt,bugcatr,bugsy,pokefan,beauty,whitney,kimino,medium,morty,officer,blkbelt,chuck,gntlman,sailor,jasmine,rktexec,skier,pryce,scienct,twins,clair,sprnerd,camper,brock,school,swimmer,misty,juggler,guitar,ltsurge,hiker,lass,erika,biker,picnikr,janine,maniac,psychic,sabrina,fisher,firbrea,blaine,brdkeep,cooltrn,blue,silver,will,koga,bruno,karen,lance,eusine,lawrnce,red" $$
|[c_type_names]| split"bird,normal,fire,fightn,water,poison,electr,ground,grass,flying,ice,bug,psychc,rock,dragon,ghost,dark,steel" $$
|[c_item_names]| split"pinkbow,charcol,blkbelt,mstwatr,psnbarb,magnet,softsnd,mirased,shrbeak,nevrice,slvpowd,twstspn,harston,drgscal,speltag,blkglas,metcoat,bripowd,focband,kingrok,leftovr,quikclw,scoplen,amucoin,litball,lukpnch,metpowd,stick,thkclub,berserk,berry,btrbery,brnbery,gldbery,icebery,mntbery,mirbery,mstbery,parbery,psnbery" $$

print(c_pkmn_names[14+1])
for x in all(c_pokemon[14].learn) do
  print(c_move_names[x+1])
end
print(c_item_names[c_pokemon[14].gender_item & 0x3f])
