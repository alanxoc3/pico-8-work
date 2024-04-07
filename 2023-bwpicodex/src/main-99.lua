------------------------------------------------------
-- GLOBALS USED IN INIT
-------------------------------------------------------

-- IDEA: maybe missingno can be #1. That allows 0 to be nothing for representing empties. and gets by the pkmn_names indexing issue
-- No, missingno should be 252, then i don't have to do a weird thing for horde mode. And zero should be empty. Also don't have to shift everything in the sprite sheet.
-- Or I can have an enabled/disabled attribute for each thing in the party.

-- pVp cVc pVc league horde
-- pLR1 pLR2 cPU1 cPU2
-- league turns into horde when you beat it.
-- pvp can customize to cpu

-- during battle when selecting a pkmn, you can:
-- view stats, switch out
-- split"sTRUGGL,aCID,aCIDARM,bARRAGE,bONCLUB,bIND,cLAMP,mOONLIT,lECHSED,eXTRSPD,sONCBOM,tWINEED,tHNSHCK,gLARE,gILOTIN,hYPFANG,jMPKICK,kINESIS,lOCKON,lOVKISS,mACPNCH,vICEGRP,sPKCANN,sPIKES,sPORE,cOTSPOR,pRESENT,vITTHRW,cMTPNCH,dRLPECK,sANDATK,aGILITY,fURYATK,qUIKATK,fALSWIP,gROWL,hEALBEL,sING,pOUND,mINIMIZ,tAILWHP,dBLSLAP,mEGHORN,bONRANG,cONVER,cONVER2,sPARK,mLKDRNK,mORNSUN,nGTSHAD,oCTZOOK,pINMISS,pOWDSNW,sUPFANG,tM05,fIRSPIN,pSNGAS,bARRIER,mEDITAT,fUTSIGT,hYPNOSI,pSYBEAM,lITSCRN,sAFEGRD,pETLDNC,cHARM,sYNTHES,sWTSCEN,rAZLEAF,pSNPOWD,sLPPOWD,aBSORB,sTNSPOR,fLAIL,cNFSION,sLAM,cONSTRI,aMNESIA,bUBBLE,sPLASH,hYDRPMP,mNDREAD,mIST,hORNATK,sPDRWEB,dBLKICK,sWTKISS,mTLCLAW,tRNFORM,tRIKICK,gUST,tWISTER,cRABHAM,dIZPNCH,sLUDGE,pAINSPL,dSTBOND,hAZE,lICK,pERSONG,mEANLOK,cNFSRAY,cROSCHP,sMOG,kARACHP,eMBER,sMKSCRN,bELDRUM,bEATUP,sCRATCH,sLASH,aNCPOWR,lEER,bITE,oUTRAGE,sCARFAC,tHRASH,sTOMP,rOCSLID,mAGNTUD,rOCTHRW,hARDEN,bONRUSH,hIJKICK,rECOVER,aERBLST,hORNDRL,dRGRAGE,sOFBOIL,dRGBREA,sELFDES,eXPLOSI,eGGBOMB,sLGBOMB,gIGDRAI,mEGDRAI,sWORDNC,cUT,fURYCUT,tHIEF,dIG,rOLLOUT,dEFCURL,dETECT,sOLBEAM,rAINDNC,fLASH,pSYCHIC,pSYCHUP,dRMEATR,nGTMARE,sHADBAL,zAPCANN,tHUNDER,tHNBOLT,iRNTAIL,sTRNGTH,rOCSMAS,hEADBUT,mUDSLAP,sUNYDAY,pROTECT,dBLTEAM,sLPTALK,cURSE,hIDPOWR,sWAGGER,fRUSTRA,rETURN,tOXIC,sNORE,rEST,eNDURE,aTTRACT,bIDE,mIMIC,sUBSTIT,rAGE,dBLEDGE,tAKDOWN,sKLBASH,bODSLAM,wATRGUN,bBLBEAM,iCEBEAM,bLIZARD,iCYWIND,sURF,wRLPOOL,wATRFAL,sWIFT,pAYDAY,tRIATK,rEFLECT,tHNWAVE,tELPORT,pSYWAVE,mETRNOM,cOUNTER,mEGPNCH,sEITOSS,sUBMISS,mEGKICK,dYNPNCH,fIRPNCH,tHNPNCH,iCEPNCH,fIRBLST,fLMTHRW,fISSURE,eARQUAK,sANDSTO,hYPBEAM,rOAR,sTLWING,fLY,rAZWIND,wRLWIND,sKYATK,wINGATK,pECK,mIRMOVE,fAINATK,wITHDRW,rAPSPIN,sUPSONC,aURBEAM,mIRCOAT,pSNSTNG,sPITE,cRUNCH,pURSUIT,sTRSHOT,lECHLIF,bTNPASS,dISABLE,sCREECH,tACKLE,fLMWEEL,rEVERSL,fURYWIP,fCSNRGY,fORSIGT,lOWKICK,rOLKICK,eNCORE,wRAP,gROWTH,vINWHIP,sACRFIR,sHARPEN,sKETCH"
|[c_move_names]| split"___,aCID,aCIDaR,bARAGE,bONcLB,bIND,cLAMP,mOONlT,lECHsD,eXTRsP,sNCbOM,tWInDL,tHNsHK,gLARE,gILOTN,hYPfNG,jMPkCK,kINSIS,lOCKoN,lOVkIS,mACpNC,vICgRP,sPIcAN,sPIKES,sPORE,cOTsPR,pRESNT,vItHRW,cMTpNC,dRLpCK,sNDaTK,aGILTY,fRYaTK,qIKaTK,fALsWP,gROWL,hEALbL,sING,pOUND,mINMIZ,tAILwP,dBLsLP,mEGhRN,bONRNG,cONVR1,cONVR2,sPARK,mLKdRK,mORsUN,nGTsHD,oCTZOK,pINmIS,pWDsNW,sUPfNG,fIRsPN,pSNgAS,bARIER,mEDTAT,fTRsGT,hYPNOS,pSYbEM,lITsCR,sAFgRD,pETdNC,cHARM,sYNTHS,sWTsCN,rAZlEF,pSNpWD,sLPpWD,aBSORB,sTNsPR,fLAIL,cONFSN,sLAM,cONSTR,aMNESA,bUBBLE,sPLASH,hYDpMP,mNDrED,mIST,hRNaTK,sPIwEB,dBLkCK,sWTkIS,mTLcLW,tRFORM,tRIKCK,gUST,tWISTR,cRBhAM,dIZpNC,sLUDGE,pAINsP,dSTbND,hAZE,lICK,pERsNG,mEANlK,cNFrAY,cRScHP,sMOG,kARcHP,eMBER,sMKsCR,bELdRM,bEATUP,sCRTCH,sLASH,aNCpWR,lEER,bITE,oUTrGE,sCRYfC,tHRASH,sTOMP,rOKsLD,mAGTUD,rOCtHR,hARDEN,bONrSH,hIJkCK,rECOVR,aERbLS,hRNdRL,dRGrGE,sFbOIL,dRGbRt,sLFdES,eXPLSN,eGGbMB,sLGbMB,gIGdRN,mEGdRN,sWRdNC,cUT,fRYcTR,tHIEF,dIG,rOLOUT,dFNcRL,dETECT,sOLbEM,rAIdNC,fLASH,pSYCIC,pSYCuP,dRMeAT,nGTMAR,sHDbAL,zAPcAN,tHUNDR,tHNbLT,iRNtAL,sTRENG,rOCsMS,hEDbUT,mUDsLP,sUNdAY,pROTCT,dBLtEM,sLPtLK,cURSE,hIDpWR,sWAGER,fRUSTR,rETURN,tOXIC,sNORE,rEST,eNDURE,aTRACT,bIDE,mIMIC,sUBSTU,rAGE,dBLeDG,tAKdWN,sKLbAS,bODsLM,wTRgUN,bBLbEM,iCEbEM,bLIZRD,iCYwND,sURF,wRLPOL,wTRFAL,sWIFT,pAYDAY,tRIaTK,rFLECT,tHNwAV,tELPRT,pSYwAV,mETRNM,cOUNTR,mEGpNC,sEITOS,sUBMIS,mEGkCK,dYNpNC,fIRpNC,tHNpNC,iCEpNC,fIRbLS,fLMtHR,fISURE,eARTqK,sNDsTR,hYPbEM,rOAR,sTLwNG,fLY,rAZwND,wRLwND,sKYaTK,wNGaTK,pECK,mIRMOV,fNTaTK,wITdRW,rAPsPN,sUPsNC,aURbEM,mIRcOT,pSNsTG,sPITE,cRUNCH,pURSUT,sTRsHT,lECHlF,bTNpAS,dISABL,sCRECH,tACKLE,fLMwEL,rEVERS,fRYsWP,fCSeNG,fORsGT,lOWkCK,rOLkCK,eNCORE,wRAP,gROWTH,vINwHP,sACfIR,sHRPEN,sKETCH,tM05,sTRUGL,nONE,nONE,nONE" $$
|[c_trnr_names]| split"yOUNGS,sAGE,fALKNR,gRUNT,bUGcTR,bUGSY,pKMfAN,bEAUTY,wITNEY,kIMINO,mEDIUM,mORTY,pOLICE,kARATE,cHUCK,gENTLE,sAILOR,jASMIN,rOCKET,sKIER,pRYCE,sCIENT,tWINS,cLAIR,nERD,cAMPER,bROCK,sCHOOL,sWIMER,mISTY,jUGLER,gUITAR,lTsURG,hIKER,lASS,eRIKA,bIKER,pICNIK,jANINE,mANIAC,pSYCIC,sABRIN,fISHER,bREATH,bLAINE,bIRDkP,cOOLtR,bLUE,sILVER,wILL,kOGA,bRUNO,kAREN,lANCE,eUSINE,lAWRNC,rED,hORDE" $$
|[c_type_names]| split"bIRD,nORMAL,fIRE,fIGHTN,wATER,pOISON,eLECTR,gROUND,gRASS,fLYING,iCE,bUG,pSYCIC,rOCK,dRAGON,gHOST,dARK,sTEEL" $$
|[c_item_names]| split"nONE,pNKBOW,cHRCOL,bLKbLT,mYwATR,pSNbRB,mAGNET,sOsAND,mIRACL,sHbEAK,nVRiCE,sLVpWD,tWsPON,hSTONE,dRAGsC,sPELtG,bLKgLS,mTLcOT,bRIpWD,fOCbND,kINGrK,lEFToV,qIKcLW,sCOPlN,aMcOIN,lITbAL,lUKpNC,mTLpWD,sTICK,tHKcLB,bERSRK,bERRY,bTRbRY,bRNbRY,gLDbRY,iCEbRY,mNTbRY,mIRbRY,mYSbRY,pARbRY,pSNbRY" $$
|[c_pkmn_names]| split"___,bULSAUR,iVYSAUR,vENSAUR,cHARMAN,cHARMEL,cHARZAR,sQUIRTL,wARTORT,bLSTOIS,cATRPIE,mETAPOD,bUTFREE,wEEDLE,kAKUNA,bEEDRIL,pIDGEY,pIDGETO,pIDGEOT,rATTATA,rATICAT,sPEAROW,fEAROW,eKANS,aRBOK,pIKACHU,rAICHU,sNDSHRW,sNDSLAS,nIDRANf,nIDRINA,nIDQUEN,nIDRANm,nIDRINO,nIDKING,cLFAIRY,cLFABLE,vULPIX,nINTALE,jIGPUFF,wIGTUFF,zUBAT,gOLBAT,oDDISH,gLOOM,vILPLUM,pARAS,pARSECT,vENONAT,vENMOTH,dIGLETT,dUGTRIO,mEOWTH,pERSIAN,pSYDUCK,gOLDUCK,mANKEY,pRIMAPE,gROWLTH,aRCANIN,pOLIWAG,pOLWIRL,pOLRATH,aBRA,kADABRA,aLKAZAM,mACHOP,mACHOKE,mACHAMP,bELSPRT,wEEPBEL,vICTBEL,tNTCOOL,tNTCRUL,gEODUDE,gRAVLER,gOLEM,pONYTA,rAPDASH,sLOWPOK,sLOWBRO,mAGNMIT,mAGNTON,fAFETCd,dODUO,dODRIO,sEEL,dEWGONG,gRIMER,mUK,sHELDER,cLYSTER,gASTLY,hAUNTER,gENGAR,oNIX,dROWZEE,hYPNO,kRABBY,kINGLER,vOLTORB,eLCRODE,eGGCUTE,eGGUTOR,cUBONE,mAROWAK,hITMLEE,hITMCHN,lIKTUNG,kOFFING,wEEZING,rHYHORN,rHYDON,cHANSEY,tANGELA,kANGKAN,hORSEA,sEADRA,gOLDEEN,sEAKING,sTARYU,sTARMIE,mRmIME,sCYTHER,jYNX,eLCABUZ,mAGMAR,pINSIR,tAUROS,mAGKARP,gYARDOS,lAPRAS,dITTO,eEVEE,vAPREON,jOLTEON,fLAREON,pORYGON,oMANYTE,oMASTAR,kABUTO,kABTOPS,aERODAC,sNORLAX,aRTCUNO,zAPDOS,mOLTRES,dRATINI,dRAGAIR,dRAGITE,mEWTWO,mEW,cHIKITA,bAYLEEF,mEGNIUM,cYNDQIL,qUILAVA,tYPHLOS,tOTODIL,cROCNAW,fRLGATR,sENTRET,fURRET,hOOTOOT,nOCTOWL,lEDYBA,lEDIAN,sPINRAK,aRIADOS,cROBAT,cHINCHU,lANTURN,pICHU,cLEFFA,iGGBUFF,tOGEPI,tOGETIC,nATU,xATU,mAREEP,fLAAFFY,aMPHROS,bELOSOM,mARILL,aZMARIL,sUDWOOD,pOLTOED,hOPPIP,sKIPLOM,jUMPLUF,aIPOM,sUNKERN,sUNFLOR,yANMA,wOOPER,qUAGSIR,eSPEON,uMBREON,mURKROW,sLOWKNG,mISDVUS,uNOWN,wOBUFET,gIFARIG,pINECO,fORTRES,dUNSPAR,gLIGAR,sTEELIX,sNUBBUL,gRANBUL,qILFISH,sCIZOR,sHUCKLE,hERCROS,sNEASEL,tEDIURS,uRSRING,sLUGMA,mACARGO,sWINUB,pILSWIN,cORSOLA,rEMRAID,oCTLERY,dELBIRD,mANTINE,sKARMRY,hONDOUR,hONDOOM,kINGDRA,pHANPY,dONPHAN,pORYGN2,sTANTLR,sMEARGL,tYROGUE,hITMTOP,sMOOCHM,eLEKID,mAGBY,mILTANK,bLISSEY,rAIKOU,eNTEI,sUICUNE,lARVTAR,pUPITAR,tYRATAR,lUGIA,hOoH,cELEBI,mISNGnO,___,___,___" $$
|[c_pkmn_color]| split"5,5,5,12,13,12,11,11,11,5,5,11,7,13,13,10,10,10,8,10,11,11,8,8,13,11,10,11,12,12,12,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,3" $$

|[f_init_peek_inc]| function()
  g_init_peek_loc += 1
  return @g_init_peek_loc
end $$

|[c_types]| f_zobj[[ -- 0 to 17 are all tables
  0;, ;;, ;;, ;;, ;;, ;;, ;;, ;;, ;;,
  ;;, ;;, ;;, ;;, ;;, ;;, ;;, ;;, ;;,
]] $$

f_zcall(poke, [[
   ;,0x5f2c, 3 -- screen to 64x64
  ;;,0x5f5c, 8 -- set btn initial delay before repeating. 255 means never repeat.
  ;;,0x5f5d, 1 -- set btn repeating delay.
]])

-------------------------------------------------------
-- INIT LOGIC
-------------------------------------------------------

-- STEP 2: UNPACK TYPE CHART
for i=0,323 do -- 18*18 = 324 (18 types)
  c_types[i\18][i%18] = f_init_peek_inc()\2
end

-- 136 to 118. Storing data all together saves like 18 code tokens.
for i=1,252 do -- There are 252 pkmn and 252 moves. So zipped when unpacking to save some tokens.
  local pkmn = f_zobj[[old;learn,#, teach,#, event,#; learn;, ;teach;, ;event;,]]
  -- cur_list is not local just so I can save 1 token
  cur_list, c_moves[i-1], c_pokemon[i] = pkmn.old.learn, {}, pkmn -- todo: get rid of i-1

  foreach(split'pow,type,acc,pp', function(key)
    c_moves[i-1][key] = f_init_peek_inc()
  end)

  foreach(split'prevolve,type1,type2,hp,att,def,spd,sat,sdf,gender_item', function(key)
    pkmn[key] = f_init_peek_inc()
  end)

  f_zobj_set(pkmn, [[name,@, num,@]], c_pkmn_names[i+1], i%252)

  while f_init_peek_inc() < C_NEXT do
    if     @g_init_peek_loc == C_TEACH then cur_list = pkmn.old.teach
    elseif @g_init_peek_loc == C_EVENT then cur_list = pkmn.old.event
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
    foreach(split'learn,teach,event', function(key)
      foreach(sub.old[key], function(v)
        add(c_pokemon[i][key], v)
      end)
    end)

    sub = c_pokemon[sub.prevolve]
  end
end

|[f_can_pokemon_teach_move]| function(pkmn_ind, move_ind) -- todo: can replace this by making a movemap on the pkmn
  for l in all(split'teach,event') do
    for ind in all(c_pokemon[pkmn_ind][l]) do
      if ind == move_ind then
        return true
      end
    end
  end
end $$

for i=0,56 do
  local trainer, move = {}, f_init_peek_inc()
  for j=1,6 do
    local pkmn = {ind=f_init_peek_inc()}
    for i=1,min(4,#c_pokemon[pkmn.ind].learn) do
      pkmn[i] = c_pokemon[pkmn.ind].learn[i]
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
  for i=1,min(4,#c_pokemon[i].learn) do
    pkmn[i] = c_pokemon[i].learn[i]
  end

  if pkmn.ind == 252 then pkmn[4] = M_TM05 end
  add(horde, pkmn)
end
add(c_trainers, horde)

menuitem(1, "swap 🅾️/❎", function()
end)

menuitem(2, "factory reset", function()
  cls() flip() -- Makes the screen go black while resetting
  memset(0x5e00, 0, 256)
  run() -- this is the function that reruns the cartridge
end)

-- This updates the lock variables, which determine if a pokemon/item/move is unlocked.
|[f_op_def]| function()
  return {{}}
end $$

|[f_op_browse]| function()
  local op = {}

  for i=1,252 do
    add(op, {data=g_lock_pokemon[i] and i or 0, disabled=not g_lock_pokemon[i]})
  end

  return op
end $$

|[f_update_locks]| function()
  for ind in all(split'1,4,7,152,155,158') do -- 6 starter pokemon
    g_lock_pokemon[ind] = true
  end

  if @S_NEW == 0 then
    poke(S_NEW, 1)
    memcpy(S_PARTY1, L_PARTY1, 42) -- Copies the Pokemon data to the first party from cart storage. 42 = 7*6 pkmn
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
      g_lock_item[c_pokemon[pkmn.ind].gender_item & 0b00111111] = true
    end
  end
end $$

poke(S_STORY,20) -- todo: remove me, this is just for debugging
f_update_locks()
|[f_op_edit]| function(sumdisable)
  local op = {}
  for partynum=0,3 do
    local sumind = 0
    local inds = {}
    for pkmnnum=0,5 do
      local party_loc = S_PARTY1+partynum*42
      local pkmn_ind = @(party_loc+pkmnnum*7)
      sumind += pkmn_ind
      add(inds, pkmn_ind)
    end
    add(op, {data=inds, disabled=sumdisable and sumind==0})
  end
  return op
end $$

|[f_op_editparty]| function()
  local op = {}
  for pkmnnum=0,5 do
    local party_loc = S_PARTY1+(@S_TEAM)*42
    local pkmn_ind = @(party_loc+pkmnnum*7)
    add(op, {data=pkmn_ind})
  end
  return op
end $$

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

|[f_strtoq]| function(s)
  local ns = ""
  for i=1,#s do ns ..= "?" end
  return ns
end $$

-- d_browse = {}
-- for i=0,251 do add(d_browse, f_create_cell(true)) end

|[f_op_title]| function() return {{text="bROWSE"}, {text="eDIT"}, {text="lEAGUE"}, {text="vERSUS"}} end $$
|[f_op_teams]| function()
  local op = {}
  for i=1, 58 do
    add(op, {text=c_trnr_names[i], disabled=@S_STORY+1<i})
  end
  return op
end $$

|[f_op_editstat]| function()
  local op = {}
  for i=0,3 do
    local move_ind = @(S_PARTY1+@S_TEAM*42+@S_TEAME*7+3+i)
    add(op, {text=c_move_names[move_ind+1], select=function()
      add(g_gridstack, g_grid_editmove)
    end})
  end
  add(op, {text="pNKBOW", select=function() end})
  add(op, {text="nEUTER", disabled=true, select=function() end})
  add(op, {text="lV 5", select=function() end})
  add(op, {text="dELETE", select=function()
    memset(S_PARTY1+@S_TEAM*42+@S_TEAME*7, 0, 7)
    deli(g_gridstack)
  end})
  return op
end $$

|[f_op_editmove]| function()
  local op = {}
  local pkmn_ind = @(S_PARTY1+@S_TEAM*42+@S_TEAME*7)
  local pkmn = c_pokemon[pkmn_ind+1]
  printh(pkmn_ind)
  printh(pkmn_ind)
  for i=0,3 do add(op, {text="nONE"}) end
  for m in all(pkmn.learn) do add(op, {text=c_move_names[m+1]}) end
  for m in all(pkmn.teach) do add(op, {text=c_move_names[m+1]}) end
  for m in all(pkmn.event) do add(op, {text=c_move_names[m+1]}) end
  if #op % 2 == 1 then add(op, {text="", disabled=true}) end
  return op
end $$

f_nf = function() end

|[f_op_pkstat]| function()
  local op = {}
  local pkmn = c_pokemon[@g_grid_browse[1].mem]

  local genders = ""
  if pkmn.gender_item & G_MALE > 0 then genders ..= "m" end
  if pkmn.gender_item & G_FEMA > 0 then
    if #genders > 0 then genders ..= "/" end
    genders ..= "f" end
  if #genders == 0 then genders ..= "n" end

  --add(op, {text="bASE sTATS", header=true})
  --add(op, {text=""})

  add(op, {text="hP:"..pkmn.hp})
  add(op, {text="sP:"..pkmn.spd})
  add(op, {text="aT:"..pkmn.att})
  add(op, {text="dF:"..pkmn.def})
  add(op, {text="sA:"..pkmn.sat})
  add(op, {text="sD:"..pkmn.sdf})
  add(op, {text="gD:"..genders})
  add(op, {text="lV:50"})
  return op

  --if #pkmn.learn > 0 then
  --  add(op, {text="lEARN mOVES", disabled=true, header=true})
  --  add(op, {text="", disabled=true, header=true})

  --  for m in all(pkmn.learn) do
  --    add(op, {text=c_move_names[m+1]})
  --  end

  --  if #op % 2 == 1 then add(op, {text="", disabled=true}) end
  --end

  --if #pkmn.teach > 0 then
  --  add(op, {text="tEACH mOVES", header=true, disabled=true})
  --  add(op, {text="", disabled=true})

  --  for m in all(pkmn.teach) do
  --    local movename = c_move_names[m+1]
  --    if not g_lock_move[m] then
  --      movename = f_strtoq(movename)
  --    end
  --    add(op, {text=movename})
  --  end

  --  if #op % 2 == 1 then add(op, {text="", disabled=true}) end
  --end

  --if #pkmn.event > 0 then
  --  add(op, {text="eVENT mOVES", header=true, disabled=true})
  --  add(op, {text="", disabled=true})

  --  for m in all(pkmn.event) do
  --    local movename = c_move_names[m+1]
  --    if not g_lock_move[m] then
  --      movename = f_strtoq(movename)
  --    end
  --    add(op, {text=movename})
  --  end

  --  if #op % 2 == 1 then add(op, {text="", disabled=true}) end
  --end
end $$

f_browselr = function(dir)
  local prev = @S_BROWSE
  local next = prev+1
  if dir > 0 then
    for i=next+1,252,1 do
      if g_lock_pokemon[i] then
        next = i
        break
      end
    end
  elseif dir < 0 then
    for i=prev,0,-1 do
      if g_lock_pokemon[i] then
        next = i
        break
      end
    end
  end

  poke(S_BROWSE, next-1)
  if prev ~= @S_BROWSE then
    f_minisfx(SFX_MOVE)
    -- f_populate_stats() f_op_pkstat related
  elseif dir ~= 0 then
    f_minisfx(SFX_ERROR)
  end
end

|[f_dp_browse]| function(i, is_sel, gridobj)
  f_draw_pkmn(gridobj.data, 1, 1, 6, false, is_sel, gridobj.disabled)
end $$

-- todo: only used in dp_edit so far
|[f_loop_through_team_pkmn]| function(party_num, callback)
  for ii=0,5 do
    local party_loc = S_PARTY1+party_num*42
    local pkmn_ind = @(party_loc+ii*7)
    callback(g_lock_pokemon[pkmn_ind] and pkmn_ind, ii)
  end
end $$

|[f_dp_edit]| function(i, is_sel, gridobj)
  for ii, ind in ipairs(gridobj.data) do
    f_draw_pkmn(ind, (ii-1)%3+1+(ii-1)%3*9, 1+(ii-1)\3*10, 6, false, is_sel, gridobj.disabled)
  end
end $$

|[f_dt_edit2]| function(i, is_sel)
  local pkstr_arr = {}
  local pkstr_lens = split'3,3,3,2'

  local party_loc = S_PARTY1+(@S_TEAM)*42
  local pkmn_loc = party_loc+(@S_TEAME)*7

  for move_i=0,3 do
    local move_ind = @(pkmn_loc+3+move_i)
    add(pkstr_arr, sub(c_move_names[(move_ind+1)], 1, pkstr_lens[move_i+1]))
  end

  local pkstr = pkstr_arr[1].."-"..pkstr_arr[2].."-"..pkstr_arr[3].."-"..pkstr_arr[4]
  print("\^y7\f3#"..(@S_TEAME+1).." \f4"..(c_pkmn_names[@pkmn_loc+1]).."\n\f1"..pkstr, 1, 1, C_1)
end $$

|[f_dt_editstat]| function(i, is_sel)
  if @S_EDITSTAT < 4 then
    print("\f4mOVE #"..@S_EDITSTAT, 1, 1)
  end
end $$

|[f_dp_edit2]| function(i, is_sel, gridobj)
  -- local party_loc = S_PARTY1+(@S_TEAM)*42
  -- local pkmn_ind = @(party_loc+(@S_TEAME)*7)
  f_draw_pkmn(gridobj.data, 1, 1, 16, false, is_sel)
end $$

|[f_dt_browse]| function(i, is_sel)
  local numstr = tostr(@S_BROWSE+1)
  local pkmn = c_pokemon[@S_BROWSE+1]

  while #numstr < 3 do numstr = "0"..numstr end
  local namestr, type1, type2 = pkmn.name, c_type_names[pkmn.type1+1], ""

  if pkmn.type2 > T_NONE then
    type2 = c_type_names[pkmn.type2+1]
  end

  if not g_lock_pokemon[@S_BROWSE+1] then
    namestr, type1, type2 = f_strtoq(namestr), f_strtoq(type1), f_strtoq(type2)
  end

  local str = "\^y7\f3#"..numstr.." \f4"..namestr.."\n\f1"..type1.." "..type2

  print(str, 1, 1)
end $$

|[f_dt_edit]| function(i, is_sel)
  local pkstr_arr = {}
  local pkstr_lens = split'3,3,1,1,1,2'
  f_loop_through_team_pkmn(@g_cg_m.mem, function(ind, ii)
    add(pkstr_arr, sub(c_pkmn_names[(ind or 255)+1], 1, pkstr_lens[ii+1]))
  end)

  local pkstr = pkstr_arr[1].."-"..pkstr_arr[2].."-"..pkstr_arr[3]..pkstr_arr[4]..pkstr_arr[5].."-"..pkstr_arr[6]
  print("\^y7\f4tEAM #"..(@g_cg_m.mem+1).." \f1\n"..pkstr, 1, 1, C_1)
end $$

|[f_dt_league]| function()
  -- TODO: save tokens / compression by extracting out this if.
  if g_cg_m.name == 'g_grid_league' then
    print("\^y7\f1pLR: \f4tEAM "..(@S_TEAM+1).."\f1\ncPU: \f3"..c_trnr_names[@S_TEAML+1], 1, 1)
  else
    print("\^y7\f1pLR: \f3tEAM "..(@S_TEAM+1).."\f1\ncPU: \f4"..c_trnr_names[@S_TEAML+1], 1, 1)
  end
end $$

|[f_dt_versus]| function()
  if g_cg_m.name == 'g_grid_versus' then
    print("\^y7\f1pLR1: \f4tEAM "..(@S_TEAM+1).."\f1\npLR2: \f3tEAM "..(@S_TEAM2+1), 1, 1)
  else
    print("\^y7\f1pLR1: \f3tEAM "..(@S_TEAM+1).."\f1\npLR2: \f4tEAM "..(@S_TEAM2+1), 1, 1)
  end
end $$

|[f_l_browse]| function()
  deli(g_gridstack)
end $$

|[f_s_browse]| function()
  add(g_gridstack, g_grid_pkstat)
end $$

-- TODO: It would be fun to be able to customize pkmn colors.
|[f_dp_title]| function(i, is_sel)
  print("\^w\^tpicodex", 2, 1,  4)
  print("dUAL vERSION",  2, 12, 1)

  --f_draw_pkmn(250,       -8+sin(t())*10, 20, C_1, C_3)
  -- todo: give title pokemon correct colors
  f_draw_pkmn(g_title_l, -8+15+(mid(-1, -.75, cos(0+g_title_an_timer/300))+.75)*4*26   + (g_title_an_timer > 190 and g_title_an_timer < 220 and (rnd(3)\1-1) or 0), 20, 16)
  f_draw_pkmn(g_title_r, 50-15-(mid(-1, -.75, cos(.5+g_title_an_timer/300))+.75)*4*26  + (g_title_an_timer > 40  and g_title_an_timer < 70  and (rnd(3)\1-1) or 0), 20, 16, true)

  --print("gAME BY\naLANxOC3",  32-6-10, 33+sin(g_title_timer/60)*10, C_1)
  -- print("\^y7aLANxOC3\npRESENTS",  32-6-10-2, 33+sin(mid(0, g_title_timer, 30)/60-.25)*11, C_1)
  --f_draw_pkmn(t()\1%252, 32-4+4+4-1, 24-4, C_1, C_3, false)

  --print("hORDE\nhs: 123", 32-6, 23, C_1)
  --print("dUAL\nvERSION",  32-6, 23, C_1)
end $$

g_title_an_timer = 70 -- starts at 70, so both are centered and not shaking. TODO: try setting with better syntax
|[f_dp_title_update]| function()
  g_title_an_timer = (g_title_an_timer+1)%300

  if g_title_an_timer == 0 then
    g_title_r = rnd"252"\1+1
  elseif g_title_an_timer == 150 then
    g_title_l = rnd"252"\1+1

  elseif g_title_an_timer == 50-10  then f_minisfx(g_title_r-1)
  elseif g_title_an_timer == 200-10 then f_minisfx(g_title_l-1)
  end
end $$

|[f_s_title]| function()
  if @g_cg_m.mem == 0 then
    add(g_gridstack, g_grid_browse)
  elseif @g_cg_m.mem == 1 then
    add(g_gridstack, g_grid_edit)
  elseif @g_cg_m.mem == 2 then
    add(g_gridstack, g_grid_league)
  elseif @g_cg_m.mem == 3 then
    add(g_gridstack, g_grid_versus)
  end
end $$

|[f_dp_pkpreview]| function(i, is_sel)
  local pkmn_ind = @S_BROWSE+1
  f_draw_pkmn(pkmn_ind, 13+(g_preview_timer > 0 and (rnd(3)\1-1) or 0), 1+2, 32)
end $$

|[f_l_pkpreview]| function()
  deli(g_gridstack)
end $$

|[f_s_pkpreview]| function()
  g_preview_timer = 20
  return @g_grid_browse[1].mem
end $$

|[f_dp_pkstat]| function(i, is_sel, obj)
end $$

|[f_l_pkstat]| function()
  deli(g_gridstack)
end $$

|[f_s_pkstat]| function()
  add(g_gridstack, g_grid_pkpreview)
end $$

|[f_s_versus]| function()
  add(g_gridstack, g_grid_versus2)
end $$

|[f_s_league]| function()
  add(g_gridstack, g_grid_league2)
end $$

|[f_s_edit]| function()
  add(g_gridstack, g_grid_edit2)
end $$

|[f_s_edit2]| function()
  local party_loc = S_PARTY1+(@S_TEAM)*42
  local pkmn_loc = party_loc+@S_TEAME*7
  if @pkmn_loc > 0 then -- includes missingno at 252
    add(g_gridstack, g_grid_edit3)
  else
    add(g_gridstack, g_grid_editpkmn)
  end
end $$

|[f_s_editstat]| function()
  gridpo[@S_EDITSTAT+1].select()
end $$

|[f_s_editmove]| function()
  -- poke(@S_TEAM+@S_TEAME*42+1+@S_EDITSTAT
  -- f_l_browse()
end $$

g_palettes = {
  --   bg1 bg2 mg  fg1 fg2
  {[0]=129,  1, 13,  6,  7,138,135, 14,15,143,142, 12,9,8,3,136}, -- default
  {[0]=131,129,  3, 11, 10,138,135, 14,15,143,142, 12,9,8,3,136}, -- green
  {[0]=129,  1,140, 12,  6,138,135, 14,15,143,142, 12,9,8,3,136}, -- blues
  {[0]=8,    0, 10,136,  9,138,135, 14,15,143,142, 12,9,8,3,136}, -- hotdog
  {[0]=7,    6,  0,134,  5,  5,  4,129, 3,130,  2,128,1,5,5,  5}, -- invert
  {[0]=128,130,141,134,135,138,135, 14,15,143,142, 12,9,8,3,136}, -- purple yel
}
g_palette = 0

|[f_l_title]| function()
  return SFX_ERROR
end $$

-- next, implement edit.
-- in picodex, the screen is always divided into 2 sections, the "preview" grid and the "text" grid.
-- p_ = preview, t_ = text. The "preview" grid is the area at the top of the screen. The "text" grid is the area at the bottom of the screen.
f_zcall(f_create_gridpair, [[
  --            w  vh x  y   cw   ch draw func        update func
   p_browse;    ,6 ,4 ,2 ,2  ,10 ,10 ,~f_dp_browse    ,~f_nf
  ;t_browse;    ,1 ,1 ,2 ,45 ,60 ,16 ,~f_dt_browse    ,~f_nf
  ;p_title;     ,1 ,1 ,2 ,2  ,60 ,40 ,~f_dp_title     ,~f_dp_title_update
  ;t_title;     ,2 ,2 ,2 ,44 ,30 ,9  ,~f_nf           ,~f_nf
  ;p_pkpreview; ,1 ,1 ,2 ,2  ,60 ,40 ,~f_dp_pkpreview ,~f_nf
  ;p_pkstat;    ,2 ,4 ,2 ,4  ,30 ,9  ,~f_dp_pkstat    ,~f_nf

  ;t_edit;      ,1 ,1 ,2 ,45 ,60 ,16 ,~f_dt_edit      ,~f_nf
  ;p_edit;      ,2 ,2 ,2 ,2  ,30 ,20 ,~f_dp_edit      ,~f_nf

  ;t_edit2;     ,1 ,1 ,2 ,45 ,60 ,16 ,~f_dt_edit2     ,~f_nf
  ;p_edit2;     ,3 ,2 ,2 ,2  ,20 ,20 ,~f_dp_edit2     ,~f_nf

  ;t_edit3;     ,1 ,1 ,2 ,45 ,60 ,16 ,~f_dt_editstat  ,~f_nf
  ;p_edit3;     ,2 ,4 ,2 ,4  ,30 ,9  ,~f_nf           ,~f_nf

  ;t_edit4;     ,1 ,1 ,2 ,45 ,60 ,16 ,~f_dt_editstat  ,~f_nf
  ;p_edit4;     ,2 ,4 ,2 ,4  ,30 ,9  ,~f_nf           ,~f_nf

  ;t_versus;    ,1 ,1 ,2 ,45 ,60 ,16 ,~f_dt_versus    ,~f_nf
  ;t_league;    ,1 ,1 ,2 ,45 ,60 ,16 ,~f_dt_league    ,~f_nf

  ;p_teamed;    ,2 ,4 ,2 ,4  ,30 ,9  ,~f_nf           ,~f_nf
  ;t_teamed;    ,1 ,1 ,2 ,45 ,60 ,16 ,~f_dt_edit      ,~f_nf

  -- name              active mem  main grid     info grid  mg op mkfunc      select func     leave func
  ;;,g_grid_browse    ,S_BROWSE    ,~p_browse    ,~t_browse ,~f_op_browse,    ~f_s_pkstat     ,~f_l_browse,   ,~c_no
  ;;,g_grid_title     ,S_TITLE     ,~t_title     ,~p_title  ,~f_op_title,     ~f_s_title      ,~f_l_title,    ,~c_no
  ;;,g_grid_pkpreview ,S_PKPREVIEW ,~p_pkpreview ,~t_browse ,~f_op_def,       ~f_s_pkpreview  ,~f_l_pkpreview ,~f_browselr
  ;;,g_grid_pkstat    ,S_PKSTAT    ,~p_pkstat    ,~t_browse ,~f_op_pkstat,    ~f_s_pkstat     ,~f_l_pkstat,   ,~c_no
  ;;,g_grid_edit      ,S_TEAM      ,~p_edit      ,~t_edit   ,~f_op_edit,      ~f_s_edit       ,~f_l_browse,   ,~c_no
  ;;,g_grid_edit2     ,S_TEAME     ,~p_edit2     ,~t_edit2  ,~f_op_editparty, ~f_s_edit2      ,~f_l_browse,   ,~c_no
  ;;,g_grid_edit3     ,S_EDITSTAT  ,~p_edit3     ,~t_edit3  ,~f_op_editstat,  ~f_s_editstat   ,~f_l_browse,   ,~c_no
  ;;,g_grid_editmove  ,S_EDITMOVE  ,~p_edit4     ,~t_edit4  ,~f_op_editmove,  ~f_s_editmove   ,~f_l_browse,   ,~c_no
  ;;,g_grid_editpkmn  ,S_BROWSE    ,~p_browse    ,~t_browse ,~f_op_browse,    ~f_nf           ,~f_l_browse,   ,~c_no

  ;;,g_grid_league    ,S_TEAM      ,~p_edit      ,~t_league ,~f_op_edit,      ~f_s_league     ,~f_l_browse,   ,~c_no, ~c_yes
  ;;,g_grid_league2   ,S_TEAML     ,~p_teamed    ,~t_league ,~f_op_teams,     ~f_nf           ,~f_l_browse,   ,~c_no
  ;;,g_grid_versus    ,S_TEAM      ,~p_edit      ,~t_versus ,~f_op_edit,      ~f_s_versus     ,~f_l_browse,   ,~c_no, ~c_yes
  ;;,g_grid_versus2   ,S_TEAM2     ,~p_edit      ,~t_versus ,~f_op_edit,      ~f_nf           ,~f_l_browse,   ,~c_no, ~c_yes
]])

-- 4 sounds: go forward. go backward. disallow. move
-- how to determine disabled cell? could have a "disabled" list.
-- locked pkmn are disabled, disabled move is disabled. mean look disables switching. no pp is disabled.
-- clicking on something... does it always take me to a new place? not during battle.
-- when is something disabled? moves can be disabled...
g_gridstack = {g_grid_title}

-------------------------------------------------------
-- UPDATE AND DRAW
-------------------------------------------------------

g_preview_timer = 0
g_title_timer = 0
g_title_l = 254
g_title_r = 254

sfx'63' -- Plays all the 4 sound effects in picodex as the logo/startup tune.

function bitmaskToIndex(bitmask)
  for i = 0, 5 do
    if bitmask & (1 << i) ~= 0 then
      return i
    end
  end
  return nil -- Return -1 if no bits are set
end

|[_update60]| function()
  g_title_timer = min(80, (g_title_timer+1))
  g_preview_timer = max(0, g_preview_timer-1)
  g_cg_m, g_cg_s, gridpo, params = unpack(g_gridstack[#g_gridstack])
  gridpo = gridpo(unpack(params)) -- TODO: Maybe I shouldn't be calling this every frame and instead only on adds.

  if g_title_timer == 80 then
    g_cg_m.updatefunc() -- This is used for the title animation and maybe other animations. TODO: Refactor me.
    g_cg_s.updatefunc() -- This is used for the title animation and maybe other animations. TODO: Refactor me.
    f_update_grid(g_cg_m, gridpo)
  elseif g_title_timer < 80 then
    local b = bitmaskToIndex(btnp())
    if b then
      g_palette = b
    end
  end
end $$

|[_draw]| function()
  cls'C_0'

  print("\^y7\f4aLANxOC3\n\-d \f2pRESENTS",  32-4*4, 32-6)

  local easing = sin(max(60, g_title_timer)/80)
  f_draw_grid(g_cg_m, gridpo, @g_cg_m.mem, @g_cg_m.memview, g_cg_m.x, g_cg_m.y+easing*20, true)
  f_draw_grid(g_cg_s, {{}},   -1,          0,               g_cg_s.x, g_cg_s.y-easing*45)

  pal(g_palettes[g_palette+1],1)
end $$
