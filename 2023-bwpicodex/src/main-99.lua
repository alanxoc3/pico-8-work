-------------------------------------------------------
-- GLOBALS USED IN INIT
-------------------------------------------------------

-- during battle when selecting a pkmn, you can:
-- view stats, switch out
-- split"sTRUGGL,aCID,aCIDARM,bARRAGE,bONCLUB,bIND,cLAMP,mOONLIT,lECHSED,eXTRSPD,sONCBOM,tWINEED,tHNSHCK,gLARE,gILOTIN,hYPFANG,jMPKICK,kINESIS,lOCKON,lOVKISS,mACPNCH,vICEGRP,sPKCANN,sPIKES,sPORE,cOTSPOR,pRESENT,vITTHRW,cMTPNCH,dRLPECK,sANDATK,aGILITY,fURYATK,qUIKATK,fALSWIP,gROWL,hEALBEL,sING,pOUND,mINIMIZ,tAILWHP,dBLSLAP,mEGHORN,bONRANG,cONVER,cONVER2,sPARK,mLKDRNK,mORNSUN,nGTSHAD,oCTZOOK,pINMISS,pOWDSNW,sUPFANG,tM05,fIRSPIN,pSNGAS,bARRIER,mEDITAT,fUTSIGT,hYPNOSI,pSYBEAM,lITSCRN,sAFEGRD,pETLDNC,cHARM,sYNTHES,sWTSCEN,rAZLEAF,pSNPOWD,sLPPOWD,aBSORB,sTNSPOR,fLAIL,cNFSION,sLAM,cONSTRI,aMNESIA,bUBBLE,sPLASH,hYDRPMP,mNDREAD,mIST,hORNATK,sPDRWEB,dBLKICK,sWTKISS,mTLCLAW,tRNFORM,tRIKICK,gUST,tWISTER,cRABHAM,dIZPNCH,sLUDGE,pAINSPL,dSTBOND,hAZE,lICK,pERSONG,mEANLOK,cNFSRAY,cROSCHP,sMOG,kARACHP,eMBER,sMKSCRN,bELDRUM,bEATUP,sCRATCH,sLASH,aNCPOWR,lEER,bITE,oUTRAGE,sCARFAC,tHRASH,sTOMP,rOCSLID,mAGNTUD,rOCTHRW,hARDEN,bONRUSH,hIJKICK,rECOVER,aERBLST,hORNDRL,dRGRAGE,sOFBOIL,dRGBREA,sELFDES,eXPLOSI,eGGBOMB,sLGBOMB,gIGDRAI,mEGDRAI,sWORDNC,cUT,fURYCUT,tHIEF,dIG,rOLLOUT,dEFCURL,dETECT,sOLBEAM,rAINDNC,fLASH,pSYCHIC,pSYCHUP,dRMEATR,nGTMARE,sHADBAL,zAPCANN,tHUNDER,tHNBOLT,iRNTAIL,sTRNGTH,rOCSMAS,hEADBUT,mUDSLAP,sUNYDAY,pROTECT,dBLTEAM,sLPTALK,cURSE,hIDPOWR,sWAGGER,fRUSTRA,rETURN,tOXIC,sNORE,rEST,eNDURE,aTTRACT,bIDE,mIMIC,sUBSTIT,rAGE,dBLEDGE,tAKDOWN,sKLBASH,bODSLAM,wATRGUN,bBLBEAM,iCEBEAM,bLIZARD,iCYWIND,sURF,wRLPOOL,wATRFAL,sWIFT,pAYDAY,tRIATK,rEFLECT,tHNWAVE,tELPORT,pSYWAVE,mETRNOM,cOUNTER,mEGPNCH,sEITOSS,sUBMISS,mEGKICK,dYNPNCH,fIRPNCH,tHNPNCH,iCEPNCH,fIRBLST,fLMTHRW,fISSURE,eARQUAK,sANDSTO,hYPBEAM,rOAR,sTLWING,fLY,rAZWIND,wRLWIND,sKYATK,wINGATK,pECK,mIRMOVE,fAINATK,wITHDRW,rAPSPIN,sUPSONC,aURBEAM,mIRCOAT,pSNSTNG,sPITE,cRUNCH,pURSUIT,sTRSHOT,lECHLIF,bTNPASS,dISABLE,sCREECH,tACKLE,fLMWEEL,rEVERSL,fURYWIP,fCSNRGY,fORSIGT,lOWKICK,rOLKICK,eNCORE,wRAP,gROWTH,vINWHIP,sACRFIR,sHARPEN,sKETCH"
|[c_move_names]| split"sTRUGL,aCID,aCIDaR,bARAGE,bONcLB,bIND,cLAMP,mOONlT,lECHsD,eXTRsP,sNCbOM,tWInDL,tHNsHK,gLARE,gILOTN,hYPfNG,jMPkCK,kINSIS,lOCKoN,lOVkIS,mACpNC,vICgRP,sPIcAN,sPIKES,sPORE,cOTsPR,pRESNT,vItHRW,cMTpNC,dRLpCK,sNDaTK,aGILTY,fRYaTK,qIKaTK,fALsWP,gROWL,hEALbL,sING,pOUND,mINMIZ,tAILwP,dBLsLP,mEGhRN,bONRNG,cONVR1,cONVR2,sPARK,mLKdRK,mORsUN,nGTsHD,oCTZOK,pINmIS,pWDsNW,sUPfNG,tM05,fIRsPN,pSNgAS,bARIER,mEDTAT,fTRsGT,hYPNOS,pSYbEM,lITsCR,sAFgRD,pETdNC,cHARM,sYNTHS,sWTsCN,rAZlEF,pSNpWD,sLPpWD,aBSORB,sTNsPR,fLAIL,cONFSN,sLAM,cONSTR,aMNESA,bUBBLE,sPLASH,hYDpMP,mNDrED,mIST,hRNATK,sPIwEB,dBLkCK,sWTkIS,mTLcLW,tRFORM,tRIKCK,gUST,tWISTR,cRBhAM,dIZpNC,sLUDGE,pAINsP,dSTbND,hAZE,lICK,pERsNG,mEANlK,cNFrAY,cRScHP,sMOG,kARcHP,eMBER,sMKsCR,bELdRM,bEATUP,sCRTCH,sLASH,aNCpWR,lEER,bITE,oUTrGE,sCRYfC,tHRASH,sTOMP,rOKsLD,mAGTUD,rOCtHR,hARDEN,bONrSH,hIJkCK,rECOVR,aERbLS,hRNdRL,dRGrGE,sFbOIL,dRGbRt,sLFdES,eXPLSN,eGGbMB,sLGbMB,gIGdRN,mEGdRN,sWRdNC,cUT,fRYcTR,tHIEF,dIG,rOLOUT,dFNcRL,dETECT,sOLbEM,rAIdNC,fLASH,pSYCIC,pSYCuP,dRMeAT,nGTMAR,sHDbAL,zAPcAN,tHUNDR,tHNbLT,iRNtAL,sTRENG,rOCsMS,hEDbUT,mUDsLP,sUNdAY,pROTCT,dBLtEM,sLPtLK,cURSE,hIDpWR,sWAGER,fRUSTR,rETURN,tOXIC,sNORE,rEST,eNDURE,aTRACT,bIDE,mIMIC,sUBSTU,rAGE,dBLeDG,tAKdWN,sKLbAS,bODsLM,wTRgUN,bBLbEM,iCEbEM,bLIZRD,iCYwND,sURF,wRLPOL,wTRFAL,sWIFT,pAYDAY,tRIATK,rFLECT,tHNwAV,tELPRT,pSYwAV,mETRNM,cOUNTR,mEGpNC,sEITOS,sUBMIS,mEGkCK,dYNpNC,fIRpNC,tHNpNC,iCEpNC,fIRbLS,fLMtHR,fISURE,eARTqK,sNDsTR,hYPbEM,rOAR,sTLwNG,fLY,rAZwND,wRLwND,sKYaTK,wNGaTK,pECK,mIRMOV,fNTaTK,wITdRW,rAPsPN,sUPsNC,aURbEM,mIRcOT,pSNsTG,sPITE,cRUNCH,pURSUT,sTRsHT,lECHlF,bTNpAS,dISABL,sCRECH,tACKLE,fLMwEL,rEVERS,fRYsWP,fCSeNG,fORsGT,lOWkCK,rOLkCK,eNCORE,wRAP,gROWTH,vINwHP,sACfIR,sHRPEN,sKETCH" $$
|[c_pkmn_names]| split"mISSING,bULSAUR,iVYSAUR,vENSAUR,cHARMAN,cHARMEL,cHARZAR,sQUIRTL,wARTORT,bLSTOIS,cATRPIE,mETAPOD,bUTFREE,wEEDLE,kAKUNA,bEEDRIL,pIDGEY,pIDGETO,pIDGEOT,rATTATA,rATICAT,sPEAROW,fEAROW,eKANS,aRBOK,pIKACHU,rAICHU,sNDSHRW,sNDSLAS,nIDRANf,nIDRINA,nIDQUEN,nIDRANm,nIDRINO,nIDKING,cLFAIRY,cLFABLE,vULPIX,nINTALE,jIGPUFF,wIGTUFF,zUBAT,gOLBAT,oDDISH,gLOOM,vILPLUM,pARAS,pARSECT,vENONAT,vENMOTH,dIGLETT,dUGTRIO,mEOWTH,pERSIAN,pSYDUCK,gOLDUCK,mANKEY,pRIMAPE,gROWLTH,aRCANIN,pOLIWAG,pOLWIRL,pOLRATH,aBRA,kADABRA,aLKAZAM,mACHOP,mACHOKE,mACHAMP,bELSPRT,wEEPBEL,vICTBEL,tNTCOOL,tNTCRUL,gEODUDE,gRAVLER,gOLEM,pONYTA,rAPDASH,sLOWPOK,sLOWBRO,mAGNMIT,mAGNTON,fAFETCd,dODUO,dODRIO,sEEL,dEWGONG,gRIMER,mUK,sHELDER,cLYSTER,gASTLY,hAUNTER,gENGAR,oNIX,dROWZEE,hYPNO,kRABBY,kINGLER,vOLTORB,eLCRODE,eGGCUTE,eGGUTOR,cUBONE,mAROWAK,hITMLEE,hITMCHN,lIKTUNG,kOFFING,wEEZING,rHYHORN,rHYDON,cHANSEY,tANGELA,kANGKAN,hORSEA,sEADRA,gOLDEEN,sEAKING,sTARYU,sTARMIE,mRmIME,sCYTHER,jYNX,eLCABUZ,mAGMAR,pINSIR,tAUROS,mAGKARP,gYARDOS,lAPRAS,dITTO,eEVEE,vAPREON,jOLTEON,fLAREON,pORYGON,oMANYTE,oMASTAR,kABUTO,kABTOPS,aERODAC,sNORLAX,aRTCUNO,zAPDOS,mOLTRES,dRATINI,dRAGAIR,dRAGITE,mEWTWO,mEW,cHIKITA,bAYLEEF,mEGNIUM,cYNDQIL,qUILAVA,tYPHLOS,tOTODIL,cROCNAW,fRLGATR,sENTRET,fURRET,hOOTOOT,nOCTOWL,lEDYBA,lEDIAN,sPINRAK,aRIADOS,cROBAT,cHINCHU,lANTURN,pICHU,cLEFFA,iGGBUFF,tOGEPI,tOGETIC,nATU,xATU,mAREEP,fLAAFFY,aMPHROS,bELOSOM,mARILL,aZMARIL,sUDWOOD,pOLTOED,hOPPIP,sKIPLOM,jUMPLUF,aIPOM,sUNKERN,sUNFLOR,yANMA,wOOPER,qUAGSIR,eSPEON,uMBREON,mURKROW,sLOWKNG,mISDVUS,uNOWN,wOBUFET,gIFARIG,pINECO,fORTRES,dUNSPAR,gLIGAR,sTEELIX,sNUBBUL,gRANBUL,qILFISH,sCIZOR,sHUCKLE,hERCROS,sNEASEL,tEDIURS,uRSRING,sLUGMA,mACARGO,sWINUB,pILSWIN,cORSOLA,rEMRAID,oCTLERY,dELBIRD,mANTINE,sKARMRY,hONDOUR,hONDOOM,kINGDRA,pHANPY,dONPHAN,pORYGN2,sTANTLR,sMEARGL,tYROGUE,hITMTOP,sMOOCHM,eLEKID,mAGBY,mILTANK,bLISSEY,rAIKOU,eNTEI,sUICUNE,lARVTAR,pUPITAR,tYRATAR,lUGIA,hOoH,cELEBI" $$
|[c_trnr_names]| split"yOUNGS,sAGE,fALKNR,gRUNT,bUGCTR,bUGSY,pKMFAN,bEAUTY,wITNEY,kIMINO,mEDIUM,mORTY,pOLICE,kARATE,cHUCK,gENTLE,sAILOR,jASMIN,rOCKET,sKIER,pRYCE,sCIENT,tWINS,cLAIR,nERD,cAMPER,bROCK,sCHOOL,sWIMER,mISTY,jUGLER,gUITAR,lTSURG,hIKER,lASS,eRIKA,bIKER,pICNIK,jANINE,mANIAC,pSYCIC,sABRIN,fISHER,bREATH,bLAINE,bIRDKP,cOOLTR,bLUE,sILVER,wILL,kOGA,bRUNO,kAREN,lANCE,eUSINE,lAWREN,rED,hORDE" $$
|[c_type_names]| split"bIRD,nORMAL,fIRE,fIGHTN,wATER,pOISON,eLECTR,gROUND,gRASS,fLYING,iCE,bUG,pSYCIC,rOCK,dRAGON,gHOST,dARK,sTEEL" $$
|[c_item_names]| split"pINKBOW,cHRCOL,bLKbLT,mYwATR,pSNbRB,mAGNET,sOsAND,mIRACL,sHbEAK,nVRiCE,sLVpWD,tWsPON,hSTONE,dRAGsC,sPELtG,bLKgLS,mTLcOT,bRIpWD,fOCbND,kINGrK,lEFToV,qIKcLW,sCOPlN,aMcOIN,lITbAL,lUKpNC,mTLpWD,sTICK,tHKcLB,bERSRK,bERRY,bTRbRY,bRNbRY,gLDbRY,iCEbRY,mNTbRY,mIRbRY,mYSbRY,pARbRY,pSNbRY" $$

|[c_trainers]| f_zobj[[]] $$

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

for i=0,251 do
  local sub = c_pokemon[i]

  while sub.prevolve > 0 do
    sub = c_pokemon[sub.prevolve]

    foreach(split'learn,teach,event', function(key)
      foreach(sub[key], function(v)
        add(c_pokemon[i][key], v)
      end)
    end)
  end
end

for i=0,56 do
  c_trainers[i] = {move=f_init_peek_inc()}
  for j=1,6 do
    add(c_trainers[i], f_init_peek_inc)
  end
end

-- after we have read all the bytes, we can now apply filters to the sfx for the cool sounding pkmn cries.
-- sfx starts at 0x3200. each sfx are 68 bytes. 64 for notes then 4 for effects.
-- 0x4278 = 0x3200+62*68 (0 to 62, only modify 63/64 sfx, because 63*4 = 252, which is how many pkmn there are)
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

f_zcall(f_create_gridpair, [[
   p_browse;    ,~c_yes ,3 ,252 ,2 ,2 ,2  ,20 ,20 ,C_2 ,C_1 ,@
  ;t_browse;    ,~c_no  ,1 ,1   ,1 ,2 ,45 ,60 ,16 ,C_1 ,C_1 ,@
  ;p_title;     ,~c_no  ,1 ,1   ,1 ,2 ,2  ,60 ,40 ,C_1 ,C_1 ,@
  ;t_title;     ,~c_yes ,2 ,4   ,2 ,2 ,44 ,30 ,9  ,C_2 ,C_1 ,@
  ;p_pkpreview; ,~c_no  ,1 ,1   ,1 ,2 ,2  ,60 ,40 ,C_2 ,C_1 ,@ -- same as p_title
  ;p_pkstat;    ,~c_yes  ,2 ,264  ,4 ,2 ,4  ,30 ,9  ,C_1 ,C_1 ,@ -- same as p_title

  ;;,g_grid_browse     ,~p_browse    ,~t_browse ,@ ,@
  ;;,g_grid_title      ,~p_title     ,~t_title  ,@ ,@
  ;;,g_grid_pkpreview  ,~p_pkpreview ,~t_browse ,@ ,@
  ;;,g_grid_pkstat     ,~p_pkstat    ,~t_browse ,@ ,@
]], function(i, is_sel) -- p_browse
  f_draw_pkmn(i, 1, 1, is_sel and C_0 or C_0, is_sel and C_3 or C_1, false)
end, function(i, is_sel) -- t_browse
  local numstr = tostr(g_grid_browse[1].num)
  while #numstr < 3 do numstr = "0"..numstr end

  local str = "\^y7\f1"..numstr.." \f4"..c_pkmn_names[g_grid_browse[1].num+1].."\n\f1"..c_type_names[c_pokemon[g_grid_browse[1].num].type1+1]
  if c_pokemon[g_grid_browse[1].num].type2 > T_NONE then
    str ..= "/"..c_type_names[c_pokemon[g_grid_browse[1].num].type2+1]
  end

  print(str, 1, 1)
end, function(i, is_sel) -- p_title
  print("\^w\^tpicodex", 2, 1,  C_0)
  print("dUAL vERSION",  2, 12, C_0)

  -- f_draw_pkmn((t()+.5)\2, 32-8- sin(t()/2)*4\1, 24+sin(t()/2)*4\1, C_0, C_3, false, 8-sin(t()/2)*8\1)
  f_draw_pkmn(t()\1%252, 32-4, 24-4, C_0, C_3, false)
  f_draw_pkmn(254, 15-8, 20, C_0, C_2)
end, function(i, is_sel) -- t_title
  if i > 0 and not is_sel then
    rectfill(-1,-1,28,7,C_4)
  end
  print(split"bROWSE,eDIT,lEAGUE,vERSUS"[i+1], 1, 1, is_sel and i == 0 and C_3 or C_0)
end, function(i, is_sel) -- p_pkpreview
  local pkmn_ind = g_grid_browse[1].num
  f_draw_pkmn(pkmn_ind, 2+1+2*4+2+(t()%1<.25 and (rnd(3)\1-1)*2 or 0), 1+2,    C_0, C_3, false, 32)

end, function(i, is_sel) -- p_pkstat
  local pkmn_ind = g_grid_browse[1].num
  local pkmn = c_pokemon[pkmn_ind]

  local genders = ""
  local pkmn = c_pokemon[g_grid_browse[1].num]
  if pkmn.gender_item & G_MALE > 0 then genders ..= "M" end
  if pkmn.gender_item & G_FEMA > 0 then
    if #genders > 0 then genders ..= "/" end
    genders ..= "F" end
  if #genders == 0 then genders ..= "U" end

  if i == 1 then
    rectfill(1-32, -1, 28, 7, C_2)
    pset(1-32, -1, C_0)
    pset(28, -1, C_0)
    print("\f4bASE sTATS", 1-30, 1) -- base stats | learn moves | teach moves | event moves | battle stats | move stats
  elseif i == 11 then
    rectfill(1-32, -1, 28, 7, C_2)
    print("\f4"..c_pkmn_names[pkmn_ind+1].." mOVES", 1-30, 1)

  elseif i > 11 then
    local move_name = c_move_names[i-11]
    if i % 3 == 0 then
      local l = #move_name
      move_name = ""
      for i=1,l do move_name ..= "?" end
    end
    print(move_name, 1, 1, C_0)

  elseif i == 2 then print("hP:"..pkmn.hp , 1, 1, C_0)
  elseif i == 3 then print("sP:"..pkmn.spd, 1, 1, C_0)
  elseif i == 4 then print("aT:"..pkmn.att, 1, 1, C_0)
  elseif i == 5 then print("dF:"..pkmn.def, 1, 1, C_0)
  elseif i == 6 then print("sA:"..pkmn.sat, 1, 1, C_0)
  elseif i == 7 then print("sD:"..pkmn.sdf, 1, 1, C_0)
  elseif i == 8 then print("gD:"..genders, 1, 1, C_0)
  elseif i == 9 then print("lV:50", 1, 1, C_0)
  end

end, function() -- browse if select
  add(g_gridstack, g_grid_pkpreview)
  return g_cg_p.num

end, function() -- browse if leave
  deli(g_gridstack)

end, function() -- title if select
  if g_cg_t.num == 0 then
    add(g_gridstack, g_grid_browse)
  end
end, function() -- title if leave
  g_col += 1
  g_col %= 8
end, function() -- pkpreview if select
  if g_cg_t.num == 0 then
    add(g_gridstack, g_grid_pkstat)
  end

  -- return g_grid_browse[1].num
end, function() -- pkpreview if leave
  deli(g_gridstack)
end, function() -- pkstat if select
  --if g_cg_t.num == 0 then
    --add(g_gridstack, g_grid_pkstat)
  --end

  return g_grid_browse[1].num
end, function() -- pkstat if leave
  deli(g_gridstack)
end)

-- sounds: go forward. go backward. disallow
-- how to determine disabled cell? could have a "disabled" list.
-- locked pkmn are disabled, disabled move is disabled. mean look disables switching. no pp is disabled.
-- clicking on something... does it always take me to a new place? not during battle.
-- when is something disabled? moves can be disabled...

g_gridstack = {g_grid_title}
g_col = 0
c_cols = f_zobj[[
  0; ,1   ,13  ,6   ,7, 5   -- default
  ;; ,132 ,4   ,143 ,15  -- sand
  ;; ,131 ,3   ,139 ,138 -- green
  ;; ,130 ,2   ,136 ,8   -- red
  ;; ,129 ,140   ,12 ,7  -- blue
  ;; ,133 ,13 ,14  ,7 -- pink
  ;; ,0   ,5   ,6   ,7   -- black & white
  ;; ,128 ,5   ,134 ,135 -- dark yellow
]]

-------------------------------------------------------
-- UPDATE AND DRAW
-------------------------------------------------------

|[_update60]| function()
  g_cg_p, g_cg_t, g_cg_s, g_cg_l = unpack(g_gridstack[#g_gridstack])

  f_update_grid(g_cg_p)
  f_update_grid(g_cg_t)

  if btnp'4' then
    f_minisfx(g_cg_l() or SFX_LEAVE)
  elseif btnp'5' then
    f_minisfx(g_cg_s() or SFX_SELECT)
  end
end $$

|[_draw]| function()
  cls'C_0'

  f_draw_grid(g_cg_p)
  f_draw_grid(g_cg_t)

  pal(c_cols[g_col], 1)
end $$
