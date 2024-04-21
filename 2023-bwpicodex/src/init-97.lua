sfx'63' -- Plays all the 4 sound effects in picodex as the logo/startup tune.

f_zcall(poke, [[
   ;,0x5f2c, 3 -- screen to 64x64
  ;;,0x5f5c, 8 -- set btn initial delay before repeating. 255 means never repeat.
  ;;,0x5f5d, 1 -- set btn repeating delay.
  ;;,S_STORY, 50 -- todo: remove me, this is just for debugging
]])

|[c_move_names]|   f_zobj[["0,___;,aCID,aCIDaR,bARAGE,bONcLB,bIND,cLAMP,mOONlT,lECHsD,eXTRsP,sNCbOM,tWInDL,tHNsHK,gLARE,gILOTN,hYPfNG,jMPkCK,kINSIS,lOCKoN,lOVkIS,mACpNC,vICgRP,sPIcAN,sPIKES,sPORE,cOTsPR,pRESNT,vItHRW,cMTpNC,dRLpCK,sNDaTK,aGILTY,fRYaTK,qIKaTK,fALsWP,gROWL,hEALbL,sING,pOUND,mINMIZ,tAILwP,dBLsLP,mEGhRN,bONRNG,cONVR1,cONVR2,sPARK,mLKdRK,mORsUN,nGTsHD,oCTZOK,pINmIS,pWDsNW,sUPfNG,fIRsPN,pSNgAS,bARIER,mEDTAT,fTRsGT,hYPNOS,pSYbEM,lITsCR,sAFgRD,pETdNC,cHARM,sYNTHS,sWTsCN,rAZlEF,pSNpWD,sLPpWD,aBSORB,sTNsPR,fLAIL,cONFSN,sLAM,cONSTR,aMNESA,bUBBLE,sPLASH,hYDpMP,mNDrED,mIST,hRNaTK,sPIwEB,dBLkCK,sWTkIS,mTLcLW,tRFORM,tRIKCK,gUST,tWISTR,cRBhAM,dIZpNC,sLUDGE,pAINsP,dSTbND,hAZE,lICK,pERsNG,mEANlK,cNFrAY,cRScHP,sMOG,kARcHP,eMBER,sMKsCR,bELdRM,bEATUP,sCRTCH,sLASH,aNCpWR,lEER,bITE,oUTrGE,sCRYfC,tHRASH,sTOMP,rOKsLD,mAGTUD,rOCtHR,hARDEN,bONrSH,hIJkCK,rECOVR,aERbLS,hRNdRL,dRGrGE,sFbOIL,dRGbRt,sLFdES,eXPLSN,eGGbMB,sLGbMB,gIGdRN,mEGdRN,sWRdNC,cUT,fRYcTR,tHIEF,dIG,rOLOUT,dFNcRL,dETECT,sOLbEM,rAIdNC,fLASH,pSYCIC,pSYCuP,dRMeAT,nGTMAR,sHDbAL,zAPcAN,tHUNDR,tHNbLT,iRNtAL,sTRENG,rOCsMS,hEDbUT,mUDsLP,sUNdAY,pROTCT,dBLtEM,sLPtLK,cURSE,hIDpWR,sWAGER,fRUSTR,rETURN,tOXIC,sNORE,rEST,eNDURE,aTRACT,bIDE,mIMIC,sUBSTU,rAGE,dBLeDG,tAKdWN,sKLbAS,bODsLM,wTRgUN,bBLbEM,iCEbEM,bLIZRD,iCYwND,sURF,wRLPOL,wTRFAL,sWIFT,pAYDAY,tRIaTK,rFLECT,tHNwAV,tELPRT,pSYwAV,mETRNM,cOUNTR,mEGpNC,sEITOS,sUBMIS,mEGkCK,dYNpNC,fIRpNC,tHNpNC,iCEpNC,fIRbLS,fLMtHR,fISURE,eARTqK,sNDsTR,hYPbEM,rOAR,sTLwNG,fLY,rAZwND,wRLwND,sKYaTK,wNGaTK,pECK,mIRMOV,fNTaTK,wITdRW,rAPsPN,sUPsNC,aURbEM,mIRcOT,pSNsTG,sPITE,cRUNCH,pURSUT,sTRsHT,lECHlF,bTNpAS,dISABL,sCRECH,tACKLE,fLMwEL,rEVERS,fRYsWP,fCSeNG,fORsGT,lOWkCK,rOLkCK,eNCORE,wRAP,gROWTH,vINwHP,sACfIR,sHRPEN,sKETCH,tM05,sTRUGL,nONE,nONE,nONE"]] $$
|[c_trnr_names]|   split"yOUNGS,sAGE,fALKNR,gRUNT,bUGcTR,bUGSY,pKMfAN,bEAUTY,wITNEY,kIMINO,mEDIUM,mORTY,pOLICE,kARATE,cHUCK,gENTLE,sAILOR,jASMIN,rOCKET,sKIER,pRYCE,sCIENT,tWINS,cLAIR,nERD,cAMPER,bROCK,sCHOOL,sWIMER,mISTY,jUGLER,gUITAR,lTsURG,hIKER,lASS,eRIKA,bIKER,pICNIK,jANINE,mANIAC,pSYCIC,sABRIN,fISHER,bREATH,bLAINE,bIRDkP,cOOLtR,bLUE,sILVER,wILL,kOGA,bRUNO,kAREN,lANCE,eUSINE,lAWRNC,rED,hORDE" $$
|[c_type_names]|   split"bIRD,nORMAL,fIRE,fIGHTN,wATER,pOISON,eLECTR,gROUND,gRASS,fLYING,iCE,bUG,pSYCIC,rOCK,dRAGON,gHOST,dARK,sTEEL" $$
|[c_item_names]|   f_zobj[["0,___;,pNKbOW,cHRcOL,bLKbLT,mYSwTR,pSNbRB,mAGNET,sOsAND,mIRACL,sHbEAK,nVRiCE,sLVpWD,tWsPON,hSTONE,dRAGsC,sPELtG,bLKgLS,mTLcOT,pLKbOW,bRIpWD,fOCbND,kINGrK,lEFToV,qIKcLW,sCOPlN,aMcOIN,lITbAL,lUKpNC,mTLpWD,sTICK,tHKcLB,bERSRK,bERRY,bTRbRY,bRNbRY,gLDbRY,iCEbRY,mNTbRY,mIRbRY,mYSbRY,pARbRY,pSNbRY"]] $$
|[c_pkmn_names]|   f_zobj[["0,___;,bULSAUR,iVYSAUR,vENSAUR,cHARMAN,cHARMEL,cHARZAR,sQUIRTL,wARTORT,bLSTOIS,cATRPIE,mETAPOD,bUTFREE,wEEDLE,kAKUNA,bEEDRIL,pIDGEY,pIDGETO,pIDGEOT,rATTATA,rATICAT,sPEAROW,fEAROW,eKANS,aRBOK,pIKACHU,rAICHU,sNDSHRW,sNDSLAS,nIDRANf,nIDRINA,nIDQUEN,nIDRANm,nIDRINO,nIDKING,cLFAIRY,cLFABLE,vULPIX,nINTALE,jIGPUFF,wIGTUFF,zUBAT,gOLBAT,oDDISH,gLOOM,vILPLUM,pARAS,pARSECT,vENONAT,vENMOTH,dIGLETT,dUGTRIO,mEOWTH,pERSIAN,pSYDUCK,gOLDUCK,mANKEY,pRIMAPE,gROWLTH,aRCANIN,pOLIWAG,pOLWIRL,pOLRATH,aBRA,kADABRA,aLKAZAM,mACHOP,mACHOKE,mACHAMP,bELSPRT,wEEPBEL,vICTBEL,tNTCOOL,tNTCRUL,gEODUDE,gRAVLER,gOLEM,pONYTA,rAPDASH,sLOWPOK,sLOWBRO,mAGNMIT,mAGNTON,fAFETCd,dODUO,dODRIO,sEEL,dEWGONG,gRIMER,mUK,sHELDER,cLYSTER,gASTLY,hAUNTER,gENGAR,oNIX,dROWZEE,hYPNO,kRABBY,kINGLER,vOLTORB,eLCRODE,eGGCUTE,eGGUTOR,cUBONE,mAROWAK,hITMLEE,hITMCHN,lIKTUNG,kOFFING,wEEZING,rHYHORN,rHYDON,cHANSEY,tANGELA,kANGKAN,hORSEA,sEADRA,gOLDEEN,sEAKING,sTARYU,sTARMIE,mRmIME,sCYTHER,jYNX,eLCABUZ,mAGMAR,pINSIR,tAUROS,mAGKARP,gYARDOS,lAPRAS,dITTO,eEVEE,vAPREON,jOLTEON,fLAREON,pORYGON,oMANYTE,oMASTAR,kABUTO,kABTOPS,aERODAC,sNORLAX,aRTCUNO,zAPDOS,mOLTRES,dRATINI,dRAGAIR,dRAGITE,mEWTWO,mEW,cHIKITA,bAYLEEF,mEGNIUM,cYNDQIL,qUILAVA,tYPHLOS,tOTODIL,cROCNAW,fRLGATR,sENTRET,fURRET,hOOTOOT,nOCTOWL,lEDYBA,lEDIAN,sPINRAK,aRIADOS,cROBAT,cHINCHU,lANTURN,pICHU,cLEFFA,iGGBUFF,tOGEPI,tOGETIC,nATU,xATU,mAREEP,fLAAFFY,aMPHROS,bELOSOM,mARILL,aZMARIL,sUDWOOD,pOLTOED,hOPPIP,sKIPLOM,jUMPLUF,aIPOM,sUNKERN,sUNFLOR,yANMA,wOOPER,qUAGSIR,eSPEON,uMBREON,mURKROW,sLOWKNG,mISDVUS,uNOWN,wOBUFET,gIFARIG,pINECO,fORTRES,dUNSPAR,gLIGAR,sTEELIX,sNUBBUL,gRANBUL,qILFISH,sCIZOR,sHUCKLE,hERCROS,sNEASEL,tEDIURS,uRSRING,sLUGMA,mACARGO,sWINUB,pILSWIN,cORSOLA,rEMRAID,oCTLERY,dELBIRD,mANTINE,sKARMRY,hONDOUR,hONDOOM,kINGDRA,pHANPY,dONPHAN,pORYGN2,sTANTLR,sMEARGL,tYROGUE,hITMTOP,sMOOCHM,eLEKID,mAGBY,mILTANK,bLISSEY,rAIKOU,eNTEI,sUICUNE,lARVTAR,pUPITAR,tYRATAR,lUGIA,hOoH,cELEBI,mISNGnO,___,___,___"]] $$
|[c_gender_names]| f_zobj[["0,nEUTER;,mALE,fEMALE"]] $$
|[c_movemethod_names]| split"lEARN,tEACH,eVENT" $$

|[c_types]| f_zobj[[ -- 0 to 17 are all tables
  0;, ;;, ;;, ;;, ;;, ;;, ;;, ;;, ;;,
  ;;, ;;, ;;, ;;, ;;, ;;, ;;, ;;, ;;,
]] $$

|[f_init_peek_inc]| function()
  g_init_peek_loc += 1
  return @g_init_peek_loc
end $$

|[f_can_pokemon_teach_move]| function(pkmn_ind, move_ind) -- todo: can replace this by making a movemap on the pkmn
  for l=2,3 do
    for ind in all(c_pokemon[pkmn_ind].moves_grouped[l]) do
      if ind == move_ind then
        return true
      end
    end
  end
end $$

-- STEP 2: UNPACK TYPE CHART
for i=0,323 do -- 18*18 = 324 (18 types)
  c_types[i\18][i%18] = f_init_peek_inc()\2
end

-- 136 to 118. Storing data all together saves like 18 code tokens.
for i=1,252 do -- There are 252 pkmn and 252 moves. So zipped when unpacking to save some tokens.
  local pkmn = f_zobj[[moves_progress;,#,#,#; moves_grouped;,#,#,#; possible_moves,#]]
  -- cur_list is not local just so I can save 1 token
  cur_list, c_moves[i-1], c_pokemon[i] = pkmn.moves_progress[1], {}, pkmn -- todo: get rid of i-1

  foreach(split'pow,type,acc,pp', function(key)
    c_moves[i-1][key] = f_init_peek_inc()
  end)

  -- 'color' actually has gender and color information, but keeping the name color saves a possible token
  foreach(split'prevolve,type1,type2,hp,att,def,spd,sat,sdf,item,color', function(key)
    pkmn[key] = f_init_peek_inc()
  end)

  -- this is guaranteed to set pkmn.genders, as long as the data is all correct, which it is.
  -- saves tokens to be ugly like this (not setting a default value)
  for k, v in pairs(f_zobj[[
     GP_BOTH;,G_MALE,G_FEMA
    ;GP_NEUT;,G_NEUT
    ;GP_MALE;,G_MALE
    ;GP_FEMA;,G_FEMA
  ]]) do
    if pkmn.color & GP_BOTH == k then
      pkmn.genders = v
    end
  end

  f_zobj_set(pkmn, [[name,@, num,@]], c_pkmn_names[i], i%252)

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

for i=1,252 do
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

for i=1,252 do -- todo: token crunching - can move up
  for j=0,2 do -- the pokemon that can learn the most moves is smeargle at 253 slots, so we can add 3 safely in all cases
    add(c_pokemon[i].possible_moves, {method="eMPTY", num=0}) -- todo: token crunching
  end

  for ii=1,3 do
    foreach(c_pokemon[i].moves_grouped[ii], function(v)
      add(c_pokemon[i].possible_moves, {method=c_movemethod_names[ii], num=v}) -- todo: token crunching
    end)
  end
end

for i=0,56 do
  local trainer, move = {}, f_init_peek_inc()
  for j=1,6 do
    local pkmn = {ind=f_init_peek_inc()}
    for i=1,min(4,#c_pokemon[pkmn.ind].moves_grouped[1]) do
      pkmn[i] = c_pokemon[pkmn.ind].moves_grouped[1][i]
    end
    if f_can_pokemon_teach_move(pkmn.ind, move) then
      pkmn[4] = move
    end
    add(trainer, pkmn)
  end
  add(c_trainers, trainer)
end

-- Logic to add the horde.
-- TODO: dedup with above
-- TODO: figure out how trainer len/party goes to battle
--       only trainers are saved as continuous things.

local horde = {}
for i=1,252 do
  local pkmn = {ind=i}
  for i=1,min(4,#c_pokemon[i].moves_grouped[1]) do
    pkmn[i] = c_pokemon[i].moves_grouped[1][i]
  end

  if pkmn.ind == 252 then pkmn[4] = M_TM05 end
  add(horde, pkmn)
end
add(c_trainers, horde)

menuitem(1, "swap 🅾️/❎", function()
  -- todo: fill me out
end)

menuitem(2, "factory reset", function()
  cls() flip() -- Makes the screen go black while resetting
  memset(0x5e00, 0, 256)
  run() -- this is the function that reruns the cartridge
end)

-- TODO: does this need to be extracted into a function, or can it just run here?
|[f_update_locks]| function()
  g_lock_item[I_NONE] = true
  g_lock_item[I_BERRY] = true
  for ind in all(split'P_BULBASAUR,P_CHARMANDER,P_SQUIRTLE,P_CHIKORITA,P_CYNDAQUIL,P_TOTODILE') do -- 6 starter pokemon
    g_lock_pokemon[ind] = true
  end

  if @S_NEW == 0 then
    poke(S_NEW, 1)
    memcpy(S_PARTY1, L_PARTY1, 48) -- Copies the Pokemon data to the first party from cart storage. 48 = 8 bytes * 6 pkmn
  end

  -- these are the moves available in the default party
  for ind in all(split'M_NONE,M_TACKLE,M_GROWL,M_LEECHSEED,M_SCRATCH,M_EMBER,M_TAILWHIP,M_BUBBLE,M_RAZORLEAF,M_LEER,M_SMOKESCREEN,M_RAGE') do
    g_lock_move[ind] = true
  end

  for i=1,min(58,@S_STORY) do
    for pkmn in all(c_trainers[i]) do
      g_lock_pokemon[pkmn.ind] = true
      for i=1,4 do
        if pkmn[i] then
          g_lock_move[pkmn[i]] = true
        end
      end
      g_lock_pokemon[pkmn.ind] = true
      g_lock_item[c_pokemon[pkmn.ind].item] = true
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
