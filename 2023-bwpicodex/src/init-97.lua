f_zcall(poke, [[
   ;,0x5f2c,   3 -- screen to 64x64
  ;;,0x5f5c,   8 -- set btn initial delay before repeating. 255 means never repeat.
  ;;,0x5f5d,   1 -- set btn repeating delay.
  ;;,S_STORY,  58 -- todo: remove me, this is just for debugging
]])

cls() -- this is just a visual thing when the game starts up. TODO: i can remove it if i want. probably should
|[c_move_names]|       f_zobj[["0,______;,aCID,aCIDaR,bARAGE,bONcLB,bIND,cLAMP,mOONlT,lECHsD,eXTRsP,sNCbOM,tWInDL,tHNsHK,gLARE,gILOTN,hYPfNG,jMPkCK,kINSIS,lOCKoN,lOVkIS,mACpNC,vICgRP,sPIcAN,sPIKES,sPORE,cOTsPR,pRESNT,vItHRW,cMTpNC,dRLpCK,sNDaTK,aGILTY,fRYaTK,qIKaTK,fALsWP,gROWL,hEALbL,sING,pOUND,mINMIZ,tAILwP,dBLsLP,mEGhRN,bONRNG,cONVR1,cONVR2,sPARK,mLKdRK,mORsUN,nGTsHD,oCTZOK,pINmIS,pWDsNW,sUPfNG,fIRsPN,pSNgAS,bARIER,mEDTAT,fTRsGT,hYPNOS,pSYbEM,lITsCR,sAFgRD,pETdNC,cHARM,sYNTHS,sWTsCN,rAZlEF,pSNpWD,sLPpWD,aBSORB,sTNsPR,fLAIL,cONFSN,sLAM,cONSTR,aMNESA,bUBBLE,sPLASH,hYDpMP,mNDrED,mIST,hRNaTK,sPIwEB,dBLkCK,sWTkIS,mTLcLW,tRFORM,tRIKCK,gUST,tWISTR,cRBhAM,dIZpNC,sLUDGE,pAINsP,dSTbND,hAZE,lICK,pERsNG,mEANlK,cNFrAY,cRScHP,sMOG,kARcHP,eMBER,sMKsCR,bELdRM,bEATUP,sCRTCH,sLASH,aNCpWR,lEER,bITE,oUTrGE,sCRYfC,tHRASH,sTOMP,rOKsLD,mAGTUD,rOCtHR,hARDEN,bONrSH,hIJkCK,rECOVR,aERbLS,hRNdRL,dRGrAG,sFbOIL,dRGbRE,sLFdES,eXPLSN,eGGbMB,sLGbMB,gIGdRN,mEGdRN,sWRdNC,cUT,fRYcTR,tHIEF,dIG,rOLOUT,dFNcRL,dETECT,sOLbEM,rAIdNC,fLASH,pSYCIC,pSYCuP,dRMeAT,nGTMAR,sHDbAL,zAPcAN,tHUNDR,tHNbLT,iRNtAL,sTRENG,rOCsMS,hEDbUT,mUDsLP,sUNdAY,pROTCT,dBLtEM,sLPtLK,cURSE,hIDpWR,sWAGER,fRUSTR,rETURN,tOXIC,sNORE,rEST,eNDURE,aTRACT,bIDE,mIMIC,sUBSTU,rAGE,dBLeDG,tAKdWN,sKLbAS,bODsLM,wTRgUN,bBLbEM,iCEbEM,bLIZRD,iCYwND,sURF,wRLPOL,wTRFAL,sWIFT,pAYDAY,tRIaTK,rFLECT,tHNwAV,tELPRT,pSYwAV,mETRNM,cOUNTR,mEGpNC,sEITOS,sUBMIS,mEGkCK,dYNpNC,fIRpNC,tHNpNC,iCEpNC,fIRbLS,fLMtHR,fISURE,eARTqK,sNDsTR,hYPbEM,rOAR,sTLwNG,fLY,rAZwND,wRLwND,sKYaTK,wNGaTK,pECK,mIRMOV,fNTaTK,wITdRW,rAPsPN,sUPsNC,aURbEM,mIRcOT,pSNsTG,sPITE,cRUNCH,pURSUT,sTRsHT,lECHlF,bTNpAS,dISABL,sCRECH,tACKLE,fLMwEL,rEVRSL,fRYsWP,fCSeNG,fORsGT,lOWkCK,rOLkCK,eNCORE,wRAP,gROWTH,vINwHP,sACfIR,sHRPEN,sKETCH,tM05,sTRUGL,nONE,nONE,nONE"]] $$
|[c_trnr_names]|       split"yOUNGS,sAGE,fALKNR,gRUNT,bUGcTR,bUGSY,pKMfAN,bEAUTY,wITNEY,kIMINO,mEDIUM,mORTY,pOLICE,kARATE,cHUCK,gENTLE,sAILOR,jASMIN,rOCKET,sKIER,pRYCE,sCIENT,tWINS,cLAIR,nERD,cAMPER,bROCK,sCHOOL,sWIMER,mISTY,jUGLER,gUITAR,lTsURG,hIKER,lASS,eRIKA,bIKER,pICNIK,jANINE,mANIAC,pSYCIC,sABRIN,fISHER,bREATH,bLAINE,bIRDkP,cOOLtR,bLUE,lEGEND,sILVER,wILL,kOGA,bRUNO,kAREN,lANCE,rED,gOLD,hORDE" $$
|[c_type_names]|       split"bIRD,nORMAL,fIRE,fIGHTN,wATER,pOISON,eLECTR,gROUND,gRASS,fLYING,iCE,bUG,pSYCIC,rOCK,dRAGON,gHOST,dARK,sTEEL,nONE" $$ -- TODO: is the nONE type used?
|[c_item_names]|       f_zobj[["0,nONE;,pNKbOW,cHRcOL,bLKbLT,mYSwTR,pSNbRB,mAGNET,sOsAND,mIRACL,sHbEAK,nVRiCE,sLVpWD,tWsPON,hRDsTN,dRAGsC,sPELtG,bLKgLS,mTLcOT,pLKbOW,bRIpWD,fOCbND,kINGrK,lEFToV,qIKcLW,sCOPlN,aMcOIN,lITbAL,lUKpNC,mTLpWD,sTICK,tHKcLB,bERSRK,bERRY,gLDbRY,bTRbRY,mNTbRY,bRNbRY,iCEbRY,pARbRY,pSNbRY,mIRbRY,mYSbRY"]] $$
-- TODO: I think Pokemon names can actually go up to 9 characters now. If the battle UI works out like that, then ya. change the names
|[c_pkmn_names]|       f_zobj[["0,mISNGnO;,bULSAUR,iVYSAUR,vENSAUR,cHARMAN,cHARMEL,cHARZAR,sQUIRTL,wARTORT,bLSTOIS,cATRPIE,mETAPOD,bUTFREE,wEEDLE,kAKUNA,bEEDRIL,pIDGEY,pIDGETO,pIDGEOT,rATTATA,rATICAT,sPEAROW,fEAROW,eKANS,aRBOK,pIKACHU,rAICHU,sNDSHRW,sNDSLAS,nIDRANf,nIDRINA,nIDQUEN,nIDRANm,nIDRINO,nIDKING,cLFAIRY,cLFABLE,vULPIX,nINTALE,jIGPUFF,wIGTUFF,zUBAT,gOLBAT,oDDISH,gLOOM,vILPLUM,pARAS,pARSECT,vENONAT,vENMOTH,dIGLETT,dUGTRIO,mEOWTH,pERSIAN,pSYDUCK,gOLDUCK,mANKEY,pRIMAPE,gROWLTH,aRCANIN,pOLIWAG,pOLWIRL,pOLRATH,aBRA,kADABRA,aLKAZAM,mACHOP,mACHOKE,mACHAMP,bELSPRT,wEEPBEL,vICTBEL,tNTCOOL,tNTCRUL,gEODUDE,gRAVLER,gOLEM,pONYTA,rAPDASH,sLOWPOK,sLOWBRO,mAGNMIT,mAGNTON,fAFETCd,dODUO,dODRIO,sEEL,dEWGONG,gRIMER,mUK,sHELDER,cLYSTER,gASTLY,hAUNTER,gENGAR,oNIX,dROWZEE,hYPNO,kRABBY,kINGLER,vOLTORB,eLCRODE,eGGCUTE,eGGUTOR,cUBONE,mAROWAK,hITMLEE,hITMCHN,lIKTUNG,kOFFING,wEEZING,rHYHORN,rHYDON,cHANSEY,tANGELA,kANGKAN,hORSEA,sEADRA,gOLDEEN,sEAKING,sTARYU,sTARMIE,mRmIME,sCYTHER,jYNX,eLCABUZ,mAGMAR,pINSIR,tAUROS,mAGKARP,gYARDOS,lAPRAS,dITTO,eEVEE,vAPREON,jOLTEON,fLAREON,pORYGON,oMANYTE,oMASTAR,kABUTO,kABTOPS,aERODAC,sNORLAX,aRTCUNO,zAPDOS,mOLTRES,dRATINI,dRAGAIR,dRAGITE,mEWTWO,mEW,cHIKITA,bAYLEEF,mEGNIUM,cYNDQIL,qUILAVA,tYPHLOS,tOTODIL,cROCNAW,fRLGATR,sENTRET,fURRET,hOOTOOT,nOCTOWL,lEDYBA,lEDIAN,sPINRAK,aRIADOS,cROBAT,cHINCHU,lANTURN,pICHU,cLEFFA,iGGBUFF,tOGEPI,tOGETIC,nATU,xATU,mAREEP,fLAAFFY,aMPHROS,bELOSOM,mARILL,aZMARIL,sUDWOOD,pOLTOED,hOPPIP,sKIPLOM,jUMPLUF,aIPOM,sUNKERN,sUNFLOR,yANMA,wOOPER,qUAGSIR,eSPEON,uMBREON,mURKROW,sLOWKNG,mISDVUS,uNOWN,wOBUFET,gIFARIG,pINECO,fORTRES,dUNSPAR,gLIGAR,sTEELIX,sNUBBUL,gRANBUL,qILFISH,sCIZOR,sHUCKLE,hERCROS,sNEASEL,tEDIURS,uRSRING,sLUGMA,mACARGO,sWINUB,pILSWIN,cORSOLA,rEMRAID,oCTLERY,dELBIRD,mANTINE,sKARMRY,hONDOUR,hONDOOM,kINGDRA,pHANPY,dONPHAN,pORYGN2,sTANTLR,sMEARGL,tYROGUE,hITMTOP,sMOOCHM,eLEKID,mAGBY,mILTANK,bLISSEY,rAIKOU,eNTEI,sUICUNE,lARVTAR,pUPITAR,tYRATAR,lUGIA,hOoH,cELEBI,___,nONE,___,___"]] $$ -- celebi, (the none pokemon for UI), (empty pokemon ind that prevolve points to), unused, unused.
|[c_gender_names]|     f_zobj[["0,nEUTER;,mALE,fEMALE"]] $$
|[c_movemethod_names]| split"lEARN,tEACH,eVENT" $$

-- TODO: It would be fun to be able to customize pkmn colors.
-- todo: can this go in cartridge data? maybe i dont want that though (uses more tokens)
-- No blue palette, because that hurts my eyes
|[c_palettes]| f_zobj[[
  -- bg1  bg2  mg   fg1  fg2
  0;,129 ,129  ,13  ,6   ,6   -- dual
  ;;,1   ,1    ,140 ,12  ,12  -- blue
  ;;,130 ,130  ,136 ,8   ,8    -- red
  ;;,131 ,131  ,3   ,138 ,138 -- green
  ;;,0   ,0    ,8   ,10  ,10  -- htdog
  ;;,5   ,5    ,134 ,6   ,6   -- silvr
  ;;,4   ,4    ,9   ,10  ,10  -- gold
]] $$

|[c_palette_names]| f_zobj[["0,dUAL;,bLUE,rED,gREEN,hTdOG,sILVR,gOLD"]] $$

|[c_types]| f_zobj[[ -- 0 to 17 are all tables
  0;, ;;, ;;, ;;, ;;, ;;, ;;, ;;, ;;,
  ;;, ;;, ;;, ;;, ;;, ;;, ;;, ;;, ;;,
]] $$

|[f_init_peek_inc]| function()
  g_init_peek_loc += 1
  return @g_init_peek_loc
end $$

-- STEP 2: UNPACK TYPE CHART
for i=0,323 do -- 18*18 = 324 (18 types)
  c_types[i\18][i%18] = f_init_peek_inc()\2
end

for i=0,I_END do add(c_items,  f_zobj([[lock,~c_no,  num,@, name,@]], i, c_item_names[i] )) end

c_pokemon[P_NONE] = {num_str="___", num=P_NONE, name="eMPTY", type1=18, type2=0, genders={G_NEUT}, possible_moves=f_zobj[[,0,0,0,0]]} -- TODO: is this needed, if so put in data instead

-- 136 to 118. Storing data all together saves like 18 code tokens.
for i=0,251 do -- There are 252 pkmn and 252 moves. So zipped when unpacking to save some tokens.
  local pkmn = f_zobj([[moves_progress;,#,#,#; moves_grouped;,#,#,#; lock,~c_no, name,@, num,@, num_str,@]], c_pkmn_names[i], i, f_prefix_zero(i, 3))

  -- cur_list is not local just so I can save 1 token
  cur_list, c_moves[i], c_pokemon[i] = pkmn.moves_progress[1], f_zobj([[lock,~c_no, num,@, name,@]], i, c_move_names[i]), pkmn -- todo: get rid of i-1

  foreach(split'pow,type,acc,pp', function(key)
    c_moves[i][key] = f_init_peek_inc()
  end)

  -- 'item' actually has gender and item information, but keeping the name item saves a possible token
  foreach(split'prevolve,type1,type2,hp,attack,defense,speed,specialattack,specialdefense,default_item', function(key)
    pkmn[key] = f_init_peek_inc()
  end)

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

  -- this is guaranteed to set pkmn.genders, as long as the data is all correct, which it is.
  -- saves tokens to be ugly like this (not setting a default value)
  for k, v in pairs(f_zobj[[
     GP_BOTH;,G_MALE,G_FEMA
    ;GP_NEUT;,G_NEUT
    ;GP_MALE;,G_MALE
    ;GP_FEMA;,G_FEMA
  ]]) do
    if pkmn.default_item & GP_BOTH == k then
      pkmn.genders = v
      pkmn.default_item &= 0x3f -- all bits except first two
    end
  end

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

for i=0,251 do
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

for i=0,251 do -- todo: token crunching - can move up
  -- having metatables here causes me to run out of lua memory, lets keep good ol' number arrays
  c_pokemon[i].possible_moves = f_zobj[[,0,0,0,0]]
  c_pokemon[i].possible_moves_method = f_zobj[[0,"eMPTY"]]

  for ii=1,3 do
    foreach(c_pokemon[i].moves_grouped[ii], function(v)
      add(c_pokemon[i].possible_moves, v)
      c_pokemon[i].possible_moves_method[v] = c_movemethod_names[ii]
    end)
  end
end

for i=1,57 do
  local trainer = {move=f_init_peek_inc()}
  for j=1,6 do add(trainer, f_init_peek_inc()) end
  add(c_trainers, trainer)
end

-- Logic to add the horde.
-- TODO: dedup with above
-- TODO: figure out how trainer len/party goes to battle
--       only trainers are saved as continuous things.

local horde = {move=M_TM05} -- Maybe this should be struggle, I guess it works for now since only 1 pokemon knows it (missingno) -- i could go back to having tm05 be a teach move for missingno
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
|[f_update_locks]| function()
  f_unlock(c_items, I_NONE+1)
  -- f_unlock(c_items, I_BERRY+1)

  -- these are the moves available in the default party -- TODO: Maybe I can use GROWL. I think Bulb/Chik/Charm are the 3 that can learn growl. not positive.
  for ind in all(split'M_NONE,M_LEECHSEED,M_EMBER,M_WATERGUN,M_VINEWHIP,M_TACKLE,M_BITE,M_TAILWHIP,M_LEER,M_SMOKESCREEN,M_LIGHTSCREEN,M_SCREECH') do
    f_unlock(c_moves, ind)
  end

  for i, ind in ipairs(split'P_BULBASAUR,P_CHARMANDER,P_SQUIRTLE,P_CHIKORITA,P_CYNDAQUIL,P_TOTODILE,P_NONE') do -- 6 starter pokemon
    f_unlock(c_pokemon, ind)
    if @S_NEW == 0 then
      f_save_party_pkmn(f_mkpkmn(ind, true, rnd(2)\1, 0, 5, 5, 5, 5), 0, i-1)
    end
  end

  if @S_NEW == 0 then
    poke(S_NEW, 1)
    memset(S_PARTY2, P_NONE, 126) -- set the "NONE" pokemon to all the other slots. this is 0x7e, which is the length of 3 parties
  end

  for i=1,min(58,@S_STORY) do
    local team = f_team_league(i)
    for pkmn in all(team) do
      f_unlock(c_pokemon, pkmn.num)
      f_unlock(c_items, pkmn.item+1)
      for i=1,4 do
        f_unlock(c_moves, pkmn[i].id)
      end
    end
  end
end $$
f_update_locks()

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
