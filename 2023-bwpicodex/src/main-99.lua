-------------------------------------------------------
-- GLOBALS USED IN INIT
-------------------------------------------------------

-- pVp cVc pVc league horde
-- pLR1 pLR2 cPU1 cPU2
-- league turns into horde when you beat it.
-- pvp can customize to cpu

-- during battle when selecting a pkmn, you can:
-- view stats, switch out
-- split"sTRUGGL,aCID,aCIDARM,bARRAGE,bONCLUB,bIND,cLAMP,mOONLIT,lECHSED,eXTRSPD,sONCBOM,tWINEED,tHNSHCK,gLARE,gILOTIN,hYPFANG,jMPKICK,kINESIS,lOCKON,lOVKISS,mACPNCH,vICEGRP,sPKCANN,sPIKES,sPORE,cOTSPOR,pRESENT,vITTHRW,cMTPNCH,dRLPECK,sANDATK,aGILITY,fURYATK,qUIKATK,fALSWIP,gROWL,hEALBEL,sING,pOUND,mINIMIZ,tAILWHP,dBLSLAP,mEGHORN,bONRANG,cONVER,cONVER2,sPARK,mLKDRNK,mORNSUN,nGTSHAD,oCTZOOK,pINMISS,pOWDSNW,sUPFANG,tM05,fIRSPIN,pSNGAS,bARRIER,mEDITAT,fUTSIGT,hYPNOSI,pSYBEAM,lITSCRN,sAFEGRD,pETLDNC,cHARM,sYNTHES,sWTSCEN,rAZLEAF,pSNPOWD,sLPPOWD,aBSORB,sTNSPOR,fLAIL,cNFSION,sLAM,cONSTRI,aMNESIA,bUBBLE,sPLASH,hYDRPMP,mNDREAD,mIST,hORNATK,sPDRWEB,dBLKICK,sWTKISS,mTLCLAW,tRNFORM,tRIKICK,gUST,tWISTER,cRABHAM,dIZPNCH,sLUDGE,pAINSPL,dSTBOND,hAZE,lICK,pERSONG,mEANLOK,cNFSRAY,cROSCHP,sMOG,kARACHP,eMBER,sMKSCRN,bELDRUM,bEATUP,sCRATCH,sLASH,aNCPOWR,lEER,bITE,oUTRAGE,sCARFAC,tHRASH,sTOMP,rOCSLID,mAGNTUD,rOCTHRW,hARDEN,bONRUSH,hIJKICK,rECOVER,aERBLST,hORNDRL,dRGRAGE,sOFBOIL,dRGBREA,sELFDES,eXPLOSI,eGGBOMB,sLGBOMB,gIGDRAI,mEGDRAI,sWORDNC,cUT,fURYCUT,tHIEF,dIG,rOLLOUT,dEFCURL,dETECT,sOLBEAM,rAINDNC,fLASH,pSYCHIC,pSYCHUP,dRMEATR,nGTMARE,sHADBAL,zAPCANN,tHUNDER,tHNBOLT,iRNTAIL,sTRNGTH,rOCSMAS,hEADBUT,mUDSLAP,sUNYDAY,pROTECT,dBLTEAM,sLPTALK,cURSE,hIDPOWR,sWAGGER,fRUSTRA,rETURN,tOXIC,sNORE,rEST,eNDURE,aTTRACT,bIDE,mIMIC,sUBSTIT,rAGE,dBLEDGE,tAKDOWN,sKLBASH,bODSLAM,wATRGUN,bBLBEAM,iCEBEAM,bLIZARD,iCYWIND,sURF,wRLPOOL,wATRFAL,sWIFT,pAYDAY,tRIATK,rEFLECT,tHNWAVE,tELPORT,pSYWAVE,mETRNOM,cOUNTER,mEGPNCH,sEITOSS,sUBMISS,mEGKICK,dYNPNCH,fIRPNCH,tHNPNCH,iCEPNCH,fIRBLST,fLMTHRW,fISSURE,eARQUAK,sANDSTO,hYPBEAM,rOAR,sTLWING,fLY,rAZWIND,wRLWIND,sKYATK,wINGATK,pECK,mIRMOVE,fAINATK,wITHDRW,rAPSPIN,sUPSONC,aURBEAM,mIRCOAT,pSNSTNG,sPITE,cRUNCH,pURSUIT,sTRSHOT,lECHLIF,bTNPASS,dISABLE,sCREECH,tACKLE,fLMWEEL,rEVERSL,fURYWIP,fCSNRGY,fORSIGT,lOWKICK,rOLKICK,eNCORE,wRAP,gROWTH,vINWHIP,sACRFIR,sHARPEN,sKETCH"
|[c_move_names]| split"sTRUGL,aCID,aCIDaR,bARAGE,bONcLB,bIND,cLAMP,mOONlT,lECHsD,eXTRsP,sNCbOM,tWInDL,tHNsHK,gLARE,gILOTN,hYPfNG,jMPkCK,kINSIS,lOCKoN,lOVkIS,mACpNC,vICgRP,sPIcAN,sPIKES,sPORE,cOTsPR,pRESNT,vItHRW,cMTpNC,dRLpCK,sNDaTK,aGILTY,fRYaTK,qIKaTK,fALsWP,gROWL,hEALbL,sING,pOUND,mINMIZ,tAILwP,dBLsLP,mEGhRN,bONRNG,cONVR1,cONVR2,sPARK,mLKdRK,mORsUN,nGTsHD,oCTZOK,pINmIS,pWDsNW,sUPfNG,fIRsPN,pSNgAS,bARIER,mEDTAT,fTRsGT,hYPNOS,pSYbEM,lITsCR,sAFgRD,pETdNC,cHARM,sYNTHS,sWTsCN,rAZlEF,pSNpWD,sLPpWD,aBSORB,sTNsPR,fLAIL,cONFSN,sLAM,cONSTR,aMNESA,bUBBLE,sPLASH,hYDpMP,mNDrED,mIST,hRNATK,sPIwEB,dBLkCK,sWTkIS,mTLcLW,tRFORM,tRIKCK,gUST,tWISTR,cRBhAM,dIZpNC,sLUDGE,pAINsP,dSTbND,hAZE,lICK,pERsNG,mEANlK,cNFrAY,cRScHP,sMOG,kARcHP,eMBER,sMKsCR,bELdRM,bEATUP,sCRTCH,sLASH,aNCpWR,lEER,bITE,oUTrGE,sCRYfC,tHRASH,sTOMP,rOKsLD,mAGTUD,rOCtHR,hARDEN,bONrSH,hIJkCK,rECOVR,aERbLS,hRNdRL,dRGrGE,sFbOIL,dRGbRt,sLFdES,eXPLSN,eGGbMB,sLGbMB,gIGdRN,mEGdRN,sWRdNC,cUT,fRYcTR,tHIEF,dIG,rOLOUT,dFNcRL,dETECT,sOLbEM,rAIdNC,fLASH,pSYCIC,pSYCuP,dRMeAT,nGTMAR,sHDbAL,zAPcAN,tHUNDR,tHNbLT,iRNtAL,sTRENG,rOCsMS,hEDbUT,mUDsLP,sUNdAY,pROTCT,dBLtEM,sLPtLK,cURSE,hIDpWR,sWAGER,fRUSTR,rETURN,tOXIC,sNORE,rEST,eNDURE,aTRACT,bIDE,mIMIC,sUBSTU,rAGE,dBLeDG,tAKdWN,sKLbAS,bODsLM,wTRgUN,bBLbEM,iCEbEM,bLIZRD,iCYwND,sURF,wRLPOL,wTRFAL,sWIFT,pAYDAY,tRIATK,rFLECT,tHNwAV,tELPRT,pSYwAV,mETRNM,cOUNTR,mEGpNC,sEITOS,sUBMIS,mEGkCK,dYNpNC,fIRpNC,tHNpNC,iCEpNC,fIRbLS,fLMtHR,fISURE,eARTqK,sNDsTR,hYPbEM,rOAR,sTLwNG,fLY,rAZwND,wRLwND,sKYaTK,wNGaTK,pECK,mIRMOV,fNTaTK,wITdRW,rAPsPN,sUPsNC,aURbEM,mIRcOT,pSNsTG,sPITE,cRUNCH,pURSUT,sTRsHT,lECHlF,bTNpAS,dISABL,sCRECH,tACKLE,fLMwEL,rEVERS,fRYsWP,fCSeNG,fORsGT,lOWkCK,rOLkCK,eNCORE,wRAP,gROWTH,vINwHP,sACfIR,sHRPEN,sKETCH,tM05" $$
|[c_pkmn_names]| split"mISSING,bULSAUR,iVYSAUR,vENSAUR,cHARMAN,cHARMEL,cHARZAR,sQUIRTL,wARTORT,bLSTOIS,cATRPIE,mETAPOD,bUTFREE,wEEDLE,kAKUNA,bEEDRIL,pIDGEY,pIDGETO,pIDGEOT,rATTATA,rATICAT,sPEAROW,fEAROW,eKANS,aRBOK,pIKACHU,rAICHU,sNDSHRW,sNDSLAS,nIDRANf,nIDRINA,nIDQUEN,nIDRANm,nIDRINO,nIDKING,cLFAIRY,cLFABLE,vULPIX,nINTALE,jIGPUFF,wIGTUFF,zUBAT,gOLBAT,oDDISH,gLOOM,vILPLUM,pARAS,pARSECT,vENONAT,vENMOTH,dIGLETT,dUGTRIO,mEOWTH,pERSIAN,pSYDUCK,gOLDUCK,mANKEY,pRIMAPE,gROWLTH,aRCANIN,pOLIWAG,pOLWIRL,pOLRATH,aBRA,kADABRA,aLKAZAM,mACHOP,mACHOKE,mACHAMP,bELSPRT,wEEPBEL,vICTBEL,tNTCOOL,tNTCRUL,gEODUDE,gRAVLER,gOLEM,pONYTA,rAPDASH,sLOWPOK,sLOWBRO,mAGNMIT,mAGNTON,fAFETCd,dODUO,dODRIO,sEEL,dEWGONG,gRIMER,mUK,sHELDER,cLYSTER,gASTLY,hAUNTER,gENGAR,oNIX,dROWZEE,hYPNO,kRABBY,kINGLER,vOLTORB,eLCRODE,eGGCUTE,eGGUTOR,cUBONE,mAROWAK,hITMLEE,hITMCHN,lIKTUNG,kOFFING,wEEZING,rHYHORN,rHYDON,cHANSEY,tANGELA,kANGKAN,hORSEA,sEADRA,gOLDEEN,sEAKING,sTARYU,sTARMIE,mRmIME,sCYTHER,jYNX,eLCABUZ,mAGMAR,pINSIR,tAUROS,mAGKARP,gYARDOS,lAPRAS,dITTO,eEVEE,vAPREON,jOLTEON,fLAREON,pORYGON,oMANYTE,oMASTAR,kABUTO,kABTOPS,aERODAC,sNORLAX,aRTCUNO,zAPDOS,mOLTRES,dRATINI,dRAGAIR,dRAGITE,mEWTWO,mEW,cHIKITA,bAYLEEF,mEGNIUM,cYNDQIL,qUILAVA,tYPHLOS,tOTODIL,cROCNAW,fRLGATR,sENTRET,fURRET,hOOTOOT,nOCTOWL,lEDYBA,lEDIAN,sPINRAK,aRIADOS,cROBAT,cHINCHU,lANTURN,pICHU,cLEFFA,iGGBUFF,tOGEPI,tOGETIC,nATU,xATU,mAREEP,fLAAFFY,aMPHROS,bELOSOM,mARILL,aZMARIL,sUDWOOD,pOLTOED,hOPPIP,sKIPLOM,jUMPLUF,aIPOM,sUNKERN,sUNFLOR,yANMA,wOOPER,qUAGSIR,eSPEON,uMBREON,mURKROW,sLOWKNG,mISDVUS,uNOWN,wOBUFET,gIFARIG,pINECO,fORTRES,dUNSPAR,gLIGAR,sTEELIX,sNUBBUL,gRANBUL,qILFISH,sCIZOR,sHUCKLE,hERCROS,sNEASEL,tEDIURS,uRSRING,sLUGMA,mACARGO,sWINUB,pILSWIN,cORSOLA,rEMRAID,oCTLERY,dELBIRD,mANTINE,sKARMRY,hONDOUR,hONDOOM,kINGDRA,pHANPY,dONPHAN,pORYGN2,sTANTLR,sMEARGL,tYROGUE,hITMTOP,sMOOCHM,eLEKID,mAGBY,mILTANK,bLISSEY,rAIKOU,eNTEI,sUICUNE,lARVTAR,pUPITAR,tYRATAR,lUGIA,hOoH,cELEBI" $$
|[c_trnr_names]| split"yOUNGS,sAGE,fALKNR,gRUNT,bUGcTR,bUGSY,pKMfAN,bEAUTY,wITNEY,kIMINO,mEDIUM,mORTY,pOLICE,kARATE,cHUCK,gENTLE,sAILOR,jASMIN,rOCKET,sKIER,pRYCE,sCIENT,tWINS,cLAIR,nERD,cAMPER,bROCK,sCHOOL,sWIMER,mISTY,jUGLER,gUITAR,lTsURG,hIKER,lASS,eRIKA,bIKER,pICNIK,jANINE,mANIAC,pSYCIC,sABRIN,fISHER,bREATH,bLAINE,bIRDkP,cOOLtR,bLUE,sILVER,wILL,kOGA,bRUNO,kAREN,lANCE,eUSINE,lAWREN,rED" $$
|[c_type_names]| split"bIRD,nORMAL,fIRE,fIGHTN,wATER,pOISON,eLECTR,gROUND,gRASS,fLYING,iCE,bUG,pSYCIC,rOCK,dRAGON,gHOST,dARK,sTEEL" $$
|[c_item_names]| split"pNKBOW,cHRCOL,bLKbLT,mYwATR,pSNbRB,mAGNET,sOsAND,mIRACL,sHbEAK,nVRiCE,sLVpWD,tWsPON,hSTONE,dRAGsC,sPELtG,bLKgLS,mTLcOT,bRIpWD,fOCbND,kINGrK,lEFToV,qIKcLW,sCOPlN,aMcOIN,lITbAL,lUKpNC,mTLpWD,sTICK,tHKcLB,bERSRK,bERRY,bTRbRY,bRNbRY,gLDbRY,iCEbRY,mNTbRY,mIRbRY,mYSbRY,pARbRY,pSNbRY" $$

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
for i=0,251 do -- There are 252 pkmn and 252 moves. So zipped when unpacking to save some tokens.
  local pkmn = f_zobj[[old;learn,#, teach,#, event,#; learn;, ;teach;, ;event;,]]
  -- cur_list is not local just so I can save 1 token
  cur_list, c_moves[i], c_pokemon[i] = pkmn.old.learn, {}, pkmn

  foreach(split'pow,type,acc,pp', function(key)
    c_moves[i][key] = f_init_peek_inc()
  end)

  foreach(split'prevolve,type1,type2,hp,att,def,spd,sat,sdf,gender_item', function(key)
    pkmn[key] = f_init_peek_inc()
  end)

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

for i=0,251 do
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
  local trainer = {move=f_init_peek_inc()}
  for j=1,6 do
    local pkmn = {ind=f_init_peek_inc()}
    for i=1,min(4,#c_pokemon[pkmn.ind].learn) do
      pkmn[i] = c_pokemon[pkmn.ind].learn[i]
    end
    if f_can_pokemon_teach_move(pkmn.ind, trainer.move) then
      pkmn[4] = trainer.move
    end
    add(trainer, pkmn)
  end
  add(c_trainers, trainer)
end

|[f_update_locks]| function()
  if @S_NEW == 0 then
    memset(0x5e00, 0, 256)
    g_lock_pokemon = {}
    g_lock_move    = {}
    g_lock_item    = {}
    poke(S_NEW, 1)
  end

  op_browse = {}
  for ind in all(split'1,4,7,152,155,158') do -- 6 starter pokemon
    g_lock_pokemon[ind] = true
  end

  for i=1,min(57,@S_STORY) do
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

  for i=0,251 do
    add(op_browse, {data=g_lock_pokemon[i] and i or 255, disabled=not g_lock_pokemon[i]})
  end
end $$

poke(S_STORY,20) -- todo: remove me, this is just for debugging
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
    -- | 0b0000100000000000 (0x0800): set the volume to 4 for everything

    poke2(loc, %loc & 0x70df | 0x0800)
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

op_def = {{}}

op_title = {{text="bROWSE"}, {text="eDIT"}, {text="lEAGUE"}, {text="vERSUS"}}

op_teams = {}
for i=1, 6 do
  add(op_teams, {text="tEAM "..i})
end
add(op_teams, {text="sTARTR"})
for i=1, 57 do
  add(op_teams, {text=c_trnr_names[i], disabled=@S_STORY<i})
end

f_nf = function() end

f_populate_stats = function()
  op_pkstat = {}
  local pkmn = c_pokemon[g_grid_browse[1].num]

  local genders = ""
  if pkmn.gender_item & G_MALE > 0 then genders ..= "M" end
  if pkmn.gender_item & G_FEMA > 0 then
    if #genders > 0 then genders ..= "/" end
    genders ..= "F" end
  if #genders == 0 then genders ..= "U" end

  add(op_pkstat, {text="bASE sTATS", header=true})
  add(op_pkstat, {text=""})

  add(op_pkstat, {text="hP:"..pkmn.hp})
  add(op_pkstat, {text="sP:"..pkmn.spd})
  add(op_pkstat, {text="aT:"..pkmn.att})
  add(op_pkstat, {text="dF:"..pkmn.def})
  add(op_pkstat, {text="sA:"..pkmn.sat})
  add(op_pkstat, {text="sD:"..pkmn.sdf})
  add(op_pkstat, {text="gD:"..genders})
  add(op_pkstat, {text="lV:50"})

  if #pkmn.learn > 0 then
    add(op_pkstat, {text="lEARN mOVES", disabled=true, header=true})
    add(op_pkstat, {text="", disabled=true, header=true})

    for m in all(pkmn.learn) do
      add(op_pkstat, {text=c_move_names[m+1]})
    end

    if #op_pkstat % 2 == 1 then add(op_pkstat, {text="", disabled=true}) end
  end

  if #pkmn.teach > 0 then
    add(op_pkstat, {text="tEACH mOVES", header=true, disabled=true})
    add(op_pkstat, {text="", disabled=true})

    for m in all(pkmn.teach) do
      local movename = c_move_names[m+1]
      if not g_lock_move[m] then
        movename = f_strtoq(movename)
      end
      add(op_pkstat, {text=movename})
    end

    if #op_pkstat % 2 == 1 then add(op_pkstat, {text="", disabled=true}) end
  end

  if #pkmn.event > 0 then
    add(op_pkstat, {text="eVENT mOVES", header=true, disabled=true})
    add(op_pkstat, {text="", disabled=true})

    for m in all(pkmn.event) do
      local movename = c_move_names[m+1]
      if not g_lock_move[m] then
        movename = f_strtoq(movename)
      end
      add(op_pkstat, {text=movename})
    end

    if #op_pkstat % 2 == 1 then add(op_pkstat, {text="", disabled=true}) end
  end

end

f_browselr = function(dir)
  local prev = g_grid_browse[1].num
  local next = prev
  if dir > 0 then
    for i=prev+1,251,1 do
      if g_lock_pokemon[i] then
        next = i
        break
      end
    end
  elseif dir < 0 then
    for i=prev-1,0,-1 do
      if g_lock_pokemon[i] then
        next = i
        break
      end
    end
  end

  g_grid_browse[1].num = next
  if prev ~= g_grid_browse[1].num then
    f_minisfx(SFX_MOVE)
    f_populate_stats()
  elseif dir ~= 0 then
    f_minisfx(SFX_ERROR)
  end
end

|[f_dp_browse]| function(i, is_sel, gridobj)
  f_draw_pkmn(gridobj.data, 1, 1, is_sel and (gridobj.disabled and C_1 or C_2) or C_1, gridobj.disabled and C_2 or (is_sel and C_4 or C_3), false)
end $$

|[f_dt_browse]| function(i, is_sel)
  local numstr = tostr(g_grid_browse[1].num)
  while #numstr < 3 do numstr = "0"..numstr end
  local namestr, type1, type2 = c_pkmn_names[g_grid_browse[1].num+1], c_type_names[c_pokemon[g_grid_browse[1].num].type1+1], ""

  if c_pokemon[g_grid_browse[1].num].type2 > T_NONE then
    type2 = c_type_names[c_pokemon[g_grid_browse[1].num].type2+1]
  end

  if not g_lock_pokemon[g_grid_browse[1].num] then
    namestr, type1, type2 = f_strtoq(namestr), f_strtoq(type1), f_strtoq(type2)
  end

  local str = "\^y7\f6"..numstr.." \f7"..namestr.."\n\f1"..type1.." "..type2

  print(str, 1, 1)
end $$

|[f_dt_edit]| function()
  local num = g_cg_p.num+1
  print("\^y7\f1pLR: \f7"..gridpo[g_cg_p.num+1].text, 1, 1)
end $$

|[f_dt_league]| function()
  local num = g_cg_p.num+1
  print("\^y7\f1pLR: \f7"..gridpo[g_cg_p.num+1].text.."\f1\ncPU: \f6"..c_trnr_names[@S_STORY+1], 1, 1)
end $$

|[f_dt_versus]| function()
  local num = g_cg_p.num+1
  print("\^y7\f1pLR1: \f7"..gridpo[g_cg_p.num+1].text.."\f1\npLR2: \f6"..c_trnr_names[@S_STORY+1], 1, 1)
end $$

|[f_l_browse]| function()
  deli(g_gridstack)
end $$

|[f_s_browse]| function()
  add(g_gridstack, g_grid_pkstat)
  f_populate_stats()
end $$

|[f_dp_title]| function(i, is_sel)
  print("\^w\^tpicodex", 2, 1,  C_1)
  print("dUAL vERSION",  2, 12, C_1)

  f_draw_pkmn(254,       15-8+4, 20, C_1, C_3)
  f_draw_pkmn(t()\1%252, 32-4+4, 24-4, C_1, C_3, false)
end $$

|[f_s_title]| function()
  if g_cg_t.num == 0 then
    add(g_gridstack, g_grid_browse)
  elseif g_cg_t.num == 1 then
    add(g_gridstack, g_grid_edit)
  elseif g_cg_t.num == 2 then
    add(g_gridstack, g_grid_league)
  elseif g_cg_t.num == 3 then
    add(g_gridstack, g_grid_versus)
  end
end $$

|[f_dp_pkpreview]| function(i, is_sel)
  local pkmn_ind = g_grid_browse[1].num
  f_draw_pkmn(pkmn_ind, 13+(g_preview_timer > 0 and (rnd(3)\1-1)*2 or 0), 1+2, C_1, C_3, false, 32)
end $$

|[f_l_pkpreview]| function()
  deli(g_gridstack)
end $$

|[f_s_pkpreview]| function()
  g_preview_timer = 20
  return g_grid_browse[1].num
end $$

|[f_dp_pkstat]| function(i, is_sel, obj)
end $$

|[f_l_pkstat]| function()
  deli(g_gridstack)
end $$

|[f_s_pkstat]| function()
  add(g_gridstack, g_grid_pkpreview)
end $$

|[f_l_title]| function()
  return SFX_ERROR
end $$

-- next, implement edit.
f_zcall(f_create_gridpair, [[
  --            active  vert    w  vh x  y   cw   ch draw func        lrfunc        select func     leave func
   p_browse;    ,~c_yes ,~c_no  ,3 ,2 ,2 ,2  ,20 ,20 ,~f_dp_browse    ,~f_nf        ,~f_s_browse    ,~f_l_browse
  ;t_browse;    ,~c_no  ,~c_no  ,1 ,1 ,2 ,45 ,60 ,16 ,~f_dt_browse    ,~f_nf        ,~f_nf          ,~f_nf
  ;p_title;     ,~c_no  ,~c_no  ,1 ,1 ,2 ,2  ,60 ,40 ,~f_dp_title     ,~f_nf        ,~f_nf          ,~f_nf
  ;t_title;     ,~c_yes ,~c_no  ,2 ,2 ,2 ,44 ,30 ,9  ,~f_nf           ,~f_nf        ,~f_s_title     ,~f_l_title
  ;p_pkpreview; ,~c_yes ,~c_yes ,1 ,1 ,2 ,2  ,60 ,40 ,~f_dp_pkpreview ,~f_browselr  ,~f_s_pkpreview ,~f_l_pkpreview
  ;p_pkstat;    ,~c_yes ,~c_yes ,2 ,4 ,2 ,4  ,30 ,9  ,~f_dp_pkstat    ,~f_browselr  ,~f_s_pkstat    ,~f_l_pkstat
  ;p_teamed;    ,~c_yes ,~c_no  ,2 ,4 ,2 ,4  ,30 ,9  ,~f_nf           ,~f_nf        ,~f_nf          ,~f_l_pkstat
  ;t_versus;    ,~c_no  ,~c_no  ,1 ,1 ,2 ,45 ,60 ,16 ,~f_dt_versus    ,~f_nf        ,~f_nf          ,~f_nf
  ;t_league;    ,~c_no  ,~c_no  ,1 ,1 ,2 ,45 ,60 ,16 ,~f_dt_league    ,~f_nf        ,~f_nf          ,~f_nf
  ;t_teamed;    ,~c_no  ,~c_no  ,1 ,1 ,2 ,45 ,60 ,16 ,~f_dt_edit      ,~f_nf        ,~f_nf          ,~f_nf

  ;;,g_grid_browse    ,~p_browse    ,~t_browse ,op_browse ,op_def
  ;;,g_grid_title     ,~p_title     ,~t_title  ,op_def    ,op_title
  ;;,g_grid_pkpreview ,~p_pkpreview ,~t_browse ,op_def    ,op_def
  ;;,g_grid_pkstat    ,~p_pkstat    ,~t_browse ,op_pkstat ,op_def
  ;;,g_grid_edit      ,~p_teamed    ,~t_teamed ,op_teams  ,op_def
  ;;,g_grid_league    ,~p_teamed    ,~t_league ,op_teams  ,op_def
  ;;,g_grid_versus    ,~p_teamed    ,~t_versus ,op_teams  ,op_def
]])

-- sounds: go forward. go backward. disallow
-- how to determine disabled cell? could have a "disabled" list.
-- locked pkmn are disabled, disabled move is disabled. mean look disables switching. no pp is disabled.
-- clicking on something... does it always take me to a new place? not during battle.
-- when is something disabled? moves can be disabled...
g_gridstack = {g_grid_title}

-------------------------------------------------------
-- UPDATE AND DRAW
-------------------------------------------------------

g_preview_timer = 0
|[_update60]| function()
  g_preview_timer = max(0, g_preview_timer-1)
  g_cg_p, g_cg_t, gridpo, gridto = unpack(g_gridstack[#g_gridstack])

  gridpo = _ENV[gridpo]
  gridto = _ENV[gridto]

  f_update_grid(g_cg_p, gridpo)
  f_update_grid(g_cg_t, gridto)
end $$

|[_draw]| function()
  cls'C_0'

  f_draw_grid(g_cg_p, gridpo)
  f_draw_grid(g_cg_t, gridto)

  pal(0, 129, 1)
end $$
