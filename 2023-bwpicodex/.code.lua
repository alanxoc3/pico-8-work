_g=setmetatable({},{__index=_ENV})
_ENV=_g
function f_zobj_eval(val,table,parameters)
if ord(val)==126 then return table[sub(val,2)]
elseif val=="@" then return deli(parameters,1)
elseif val=="#" then return{}end
return val ~="" and val or nil
end
function f_zobj_set(table,str,...)
local params,statements,dest={...},split(str,";"),table
foreach(statements,function(statement)
local tokens=split(statement)
if #tokens>1 then
if tokens[1]=="" then
foreach(tokens,function(val)
add(dest,f_zobj_eval(val,table,params))
end)
else
for i=1,#tokens,2 do
dest[tokens[i]]=f_zobj_eval(tokens[i+1],table,params)
end
end
dest=table
else
if statement=="" then statement=#dest+1 end
if type(dest[statement])~="table"then
dest[statement]={}
end
dest=dest[statement]
end
end)
return table
end
function f_zobj(...)
return f_zobj_set(setmetatable({},{__index=_g}),...)
end
f_zobj_set(_g,"c_pokemon,#,c_moves,#,c_trainers,#,c_items,#,g_init_peek_loc,0x1fff,c_yes,@,c_no,@,c_empty,@,f_nop,@,g_palette,5,g_preview_timer,0,g_title_timer,0,g_title_l,254,g_title_r,254,g_title_an_timer,70",true,false,"",function(...)return...end)
f_zobj_set(_g,"f_zobj,@,f_zobj_set,@,f_zobj_eval,@,f_zcall,@,f_create_gridpair,@,f_update_grid,@,f_draw_grid,@,f_addop_text,@,f_minisfx,@,f_draw_pkmn,@,c_move_names,@,c_trnr_names,@,c_type_names,@,c_item_names,@,c_pkmn_names,@,c_gender_names,@,c_movemethod_names,@,c_palettes,@,c_types,@,f_init_peek_inc,@,f_unlock,@,f_update_locks,@,f_mkpkmn,@,f_team_party,@,f_team_league,@,f_get_party_pkmn,@,f_save_party_pkmn,@,f_add_to_ui_stack,@,f_getsel,@,f_op_def,@,f_op_browse,@,f_op_edit,@,f_op_editteam,@,f_op_title,@,f_op_teams,@,f_op_editstat,@,f_create_spot,@,f_get_edit_op_pkmn,@,f_op_editmove,@,f_op_template_edit,@,f_op_edititem,@,f_add_stat_move,@,f_add_stat,@,f_op_statbrowse,@,f_op_statbattle,@,f_op_statedit,@,f_dt_editteam,@,f_dt_editstat,@,f_print_top,@,f_print_bot,@,f_get_move_texts,@,f_dt_editmove_template,@,f_dt_editmove,@,f_dt_edititem,@,f_prefix_space,@,f_prefix_zero,@,f_dt_browse_template,@,f_dt_browse,@,f_dt_editpkmn,@,f_dt_edit,@,f_dt_league,@,f_dt_versus,@,f_dp_title,@,f_dp_battle,@,f_op_batsel,@,f_l_browse,@,f_s_browse,@,f_s_title,@,f_s_pkstat,@,f_s_statedit,@,f_s_versus,@,f_s_league,@,f_s_batbegin,@,f_s_edit,@,f_s_editteam,@,f_s_editpkmn,@,f_s_editstat,@,f_s_battle,@,f_s_editmove,@,f_s_edititem,@,f_l_title,@,f_browselr,@,f_lr_statedit,@,f_strtoq,@,f_nf,@,f_loop_through_team_pkmn,@,_update60,@,_draw,@",f_zobj,f_zobj_set,f_zobj_eval,function(func,text,...)
foreach(f_zobj(text,...),function(params)
func(unpack(params))
end)
end,function(name,main_grid_spec,info_grid_spec,info_grid_draw,main_op_func,main_sel_func,main_leave_func,main_lr_func,...)
_g[name]=f_zobj("g_cg_m,@,g_cg_s,@,gridpofunc,@,params,@",
f_zobj("sel,0,view,0,name,@,selfunc,@,leavefunc,@,lrfunc,@,w,@,vh,@,x,@,y,@,cw,@,ch,@",name,main_sel_func,main_leave_func,main_lr_func,unpack(main_grid_spec)),
f_zobj("sel,-1,view,-1,name,@,df,@,w,@,vh,@,x,@,y,@,cw,@,ch,@",name,info_grid_draw,unpack(info_grid_spec)),
main_op_func,
{...}
)
end,function(_ENV,gridobj,top_grid)
local evalfunc=function(num,mmin,mmax,b0,b1,l)
local off=(b1 and l or 0)-(b0 and l or 0)
local newnum=mid(mmin,min(#gridobj-1,mmin+mmax),num+off)
if newnum==num and off ~=0 then
f_minisfx(253)
elseif newnum ~=num then
f_minisfx(255)
end
return newnum
end
if lrfunc then
local off=(btnp"3" and 1 or 0)-(btnp"2" and 1 or 0)
local prevview=view
view=mid(0,view+off,(#gridobj-1)\w-vh+1)
if view==prevview and off ~=0 then
f_minisfx(253)
elseif off ~=0 then
f_minisfx(255)
end
if lrfunc then lrfunc((btnp"1" and 1 or 0)-(btnp"0" and 1 or 0))end
else
sel=evalfunc(sel,0,#gridobj-1,btnp"0",btnp"1",1)
sel=evalfunc(sel,sel%w,(#gridobj-1)\w*w,btnp"2",btnp"3",w)
if sel\w-vh+1>view then view=sel\w-vh+1 end
if sel\w<view then view=sel\w end
view=mid(0,view,(#gridobj-1)\w-vh+1)
end
if btnp"4" then
f_minisfx(leavefunc()or 254)
elseif btnp"5" then
if(sel<0 or lrfunc or not gridobj[sel+1].disabled)then
f_minisfx(selfunc()or 252)
else
f_minisfx(253)
end
end
end,function(_ENV,gridobj,num,view,x,y,active)
clip(x,y,w*cw,vh*ch)
for j=0,vh*w-1 do
local i=j+view*w
local obj=gridobj[i+1]
if i>=#gridobj then break end
local xloc,yloc=x+i%w*cw,y+j\w*ch
camera(-xloc-1,-yloc-1)
local l,r,u,d=0,0,0,0
if i==0 then l,u=1,1 end
if i==w-1 then r,u=1,1 end
if i==#gridobj-1 then r,d=1,1 end
if i==(#gridobj-1)\w*w then l,d=1,1 end
local c=3
if(lrfunc or i ~=num)and obj.disabled then
c=2
end
if not lrfunc and active and i==num then
c=4
end
rectfill(-1+l,-1,cw-2-r,ch-2,c)
rectfill(-1,-1+u,cw-2,ch-2-d,c)
end
for j=0,vh*w-1 do
local i=j+view*w
local obj=gridobj[i+1]
if i>=#gridobj then break end
local xloc,yloc=x+i%w*cw,y+j\w*ch
camera(-xloc-1,-yloc-1)
local c=2
if i==num and not lrfunc then
c=3
end
if obj.disabled then
if i==num and not lrfunc then
c=2
else
c=3
end
end
print(obj.text or "",1,1,c)
if obj.draw then
obj.draw(i,i==num,obj)
end
end
clip()
camera()
end,function(op,text)
add(op,{draw=function()print(text,1,1,2)end})
end,function(num)
sfx(num\4,num<252 and 0 or 1,num%4*8,8)
end,function(num,x,y,width,flip,sel,disabled,isoutline)
local in_c=isoutline and 3 or sel and 4 or disabled and 2 or 4
local out_c=disabled and(sel and 2 or 3)or sel and 3 or 2
if num==252 then
rectfill(x+width/2-1,y+width/2-1,x+width/2,y+width/2,out_c)
return
end
local row=num/8\1
local col=num%8
local scale=max(width\16,1)
local masks={8,4,2,1}
local colordrawfunc=function(ix,iy,c)
local mask=masks[num\64+1]
for i=1,15 do
if i & mask==0 then
palt(i,true)
else
pal(i,c)
end
end
palt(mask,false)
pal(mask,c)
sspr(col*16,row%8*16,16,16,ix,iy,width,width,flip,false)
palt()
pal()
end
for yy=-scale,scale,scale do
for xx=-scale,scale,scale do
if not(xx==0 and yy==0)then
colordrawfunc(x+xx,y+yy,out_c)
end
end
end
colordrawfunc(x,y,in_c)
end,f_zobj"0,______;,aCID,aCIDaR,bARAGE,bONcLB,bIND,cLAMP,mOONlT,lECHsD,eXTRsP,sNCbOM,tWInDL,tHNsHK,gLARE,gILOTN,hYPfNG,jMPkCK,kINSIS,lOCKoN,lOVkIS,mACpNC,vICgRP,sPIcAN,sPIKES,sPORE,cOTsPR,pRESNT,vItHRW,cMTpNC,dRLpCK,sNDaTK,aGILTY,fRYaTK,qIKaTK,fALsWP,gROWL,hEALbL,sING,pOUND,mINMIZ,tAILwP,dBLsLP,mEGhRN,bONRNG,cONVR1,cONVR2,sPARK,mLKdRK,mORsUN,nGTsHD,oCTZOK,pINmIS,pWDsNW,sUPfNG,fIRsPN,pSNgAS,bARIER,mEDTAT,fTRsGT,hYPNOS,pSYbEM,lITsCR,sAFgRD,pETdNC,cHARM,sYNTHS,sWTsCN,rAZlEF,pSNpWD,sLPpWD,aBSORB,sTNsPR,fLAIL,cONFSN,sLAM,cONSTR,aMNESA,bUBBLE,sPLASH,hYDpMP,mNDrED,mIST,hRNaTK,sPIwEB,dBLkCK,sWTkIS,mTLcLW,tRFORM,tRIKCK,gUST,tWISTR,cRBhAM,dIZpNC,sLUDGE,pAINsP,dSTbND,hAZE,lICK,pERsNG,mEANlK,cNFrAY,cRScHP,sMOG,kARcHP,eMBER,sMKsCR,bELdRM,bEATUP,sCRTCH,sLASH,aNCpWR,lEER,bITE,oUTrGE,sCRYfC,tHRASH,sTOMP,rOKsLD,mAGTUD,rOCtHR,hARDEN,bONrSH,hIJkCK,rECOVR,aERbLS,hRNdRL,dRGrAG,sFbOIL,dRGbRE,sLFdES,eXPLSN,eGGbMB,sLGbMB,gIGdRN,mEGdRN,sWRdNC,cUT,fRYcTR,tHIEF,dIG,rOLOUT,dFNcRL,dETECT,sOLbEM,rAIdNC,fLASH,pSYCIC,pSYCuP,dRMeAT,nGTMAR,sHDbAL,zAPcAN,tHUNDR,tHNbLT,iRNtAL,sTRENG,rOCsMS,hEDbUT,mUDsLP,sUNdAY,pROTCT,dBLtEM,sLPtLK,cURSE,hIDpWR,sWAGER,fRUSTR,rETURN,tOXIC,sNORE,rEST,eNDURE,aTRACT,bIDE,mIMIC,sUBSTU,rAGE,dBLeDG,tAKdWN,sKLbAS,bODsLM,wTRgUN,bBLbEM,iCEbEM,bLIZRD,iCYwND,sURF,wRLPOL,wTRFAL,sWIFT,pAYDAY,tRIaTK,rFLECT,tHNwAV,tELPRT,pSYwAV,mETRNM,cOUNTR,mEGpNC,sEITOS,sUBMIS,mEGkCK,dYNpNC,fIRpNC,tHNpNC,iCEpNC,fIRbLS,fLMtHR,fISURE,eARTqK,sNDsTR,hYPbEM,rOAR,sTLwNG,fLY,rAZwND,wRLwND,sKYaTK,wNGaTK,pECK,mIRMOV,fNTaTK,wITdRW,rAPsPN,sUPsNC,aURbEM,mIRcOT,pSNsTG,sPITE,cRUNCH,pURSUT,sTRsHT,lECHlF,bTNpAS,dISABL,sCRECH,tACKLE,fLMwEL,rEVRSL,fRYsWP,fCSeNG,fORsGT,lOWkCK,rOLkCK,eNCORE,wRAP,gROWTH,vINwHP,sACfIR,sHRPEN,sKETCH,tM05,sTRUGL,nONE,nONE,nONE",split"yOUNGS,sAGE,fALKNR,gRUNT,bUGcTR,bUGSY,pKMfAN,bEAUTY,wITNEY,kIMINO,mEDIUM,mORTY,pOLICE,kARATE,cHUCK,gENTLE,sAILOR,jASMIN,rOCKET,sKIER,pRYCE,sCIENT,tWINS,cLAIR,nERD,cAMPER,bROCK,sCHOOL,sWIMER,mISTY,jUGLER,gUITAR,lTsURG,hIKER,lASS,eRIKA,bIKER,pICNIK,jANINE,mANIAC,pSYCIC,sABRIN,fISHER,bREATH,bLAINE,bIRDkP,cOOLtR,bLUE,lEGEND,sILVER,wILL,kOGA,bRUNO,kAREN,lANCE,rED,gOLD,hORDE",split"bIRD,nORMAL,fIRE,fIGHTN,wATER,pOISON,eLECTR,gROUND,gRASS,fLYING,iCE,bUG,pSYCIC,rOCK,dRAGON,gHOST,dARK,sTEEL,nONE",f_zobj"0,nONE;,pNKbOW,cHRcOL,bLKbLT,mYSwTR,pSNbRB,mAGNET,sOsAND,mIRACL,sHbEAK,nVRiCE,sLVpWD,tWsPON,hRDsTN,dRAGsC,sPELtG,bLKgLS,mTLcOT,pLKbOW,bRIpWD,fOCbND,kINGrK,lEFToV,qIKcLW,sCOPlN,aMcOIN,lITbAL,lUKpNC,mTLpWD,sTICK,tHKcLB,bERSRK,bERRY,gLDbRY,bTRbRY,mNTbRY,bRNbRY,iCEbRY,pARbRY,pSNbRY,mIRbRY,mYSbRY",f_zobj"0,mISNGnO;,bULSAUR,iVYSAUR,vENSAUR,cHARMAN,cHARMEL,cHARZAR,sQUIRTL,wARTORT,bLSTOIS,cATRPIE,mETAPOD,bUTFREE,wEEDLE,kAKUNA,bEEDRIL,pIDGEY,pIDGETO,pIDGEOT,rATTATA,rATICAT,sPEAROW,fEAROW,eKANS,aRBOK,pIKACHU,rAICHU,sNDSHRW,sNDSLAS,nIDRANf,nIDRINA,nIDQUEN,nIDRANm,nIDRINO,nIDKING,cLFAIRY,cLFABLE,vULPIX,nINTALE,jIGPUFF,wIGTUFF,zUBAT,gOLBAT,oDDISH,gLOOM,vILPLUM,pARAS,pARSECT,vENONAT,vENMOTH,dIGLETT,dUGTRIO,mEOWTH,pERSIAN,pSYDUCK,gOLDUCK,mANKEY,pRIMAPE,gROWLTH,aRCANIN,pOLIWAG,pOLWIRL,pOLRATH,aBRA,kADABRA,aLKAZAM,mACHOP,mACHOKE,mACHAMP,bELSPRT,wEEPBEL,vICTBEL,tNTCOOL,tNTCRUL,gEODUDE,gRAVLER,gOLEM,pONYTA,rAPDASH,sLOWPOK,sLOWBRO,mAGNMIT,mAGNTON,fAFETCd,dODUO,dODRIO,sEEL,dEWGONG,gRIMER,mUK,sHELDER,cLYSTER,gASTLY,hAUNTER,gENGAR,oNIX,dROWZEE,hYPNO,kRABBY,kINGLER,vOLTORB,eLCRODE,eGGCUTE,eGGUTOR,cUBONE,mAROWAK,hITMLEE,hITMCHN,lIKTUNG,kOFFING,wEEZING,rHYHORN,rHYDON,cHANSEY,tANGELA,kANGKAN,hORSEA,sEADRA,gOLDEEN,sEAKING,sTARYU,sTARMIE,mRmIME,sCYTHER,jYNX,eLCABUZ,mAGMAR,pINSIR,tAUROS,mAGKARP,gYARDOS,lAPRAS,dITTO,eEVEE,vAPREON,jOLTEON,fLAREON,pORYGON,oMANYTE,oMASTAR,kABUTO,kABTOPS,aERODAC,sNORLAX,aRTCUNO,zAPDOS,mOLTRES,dRATINI,dRAGAIR,dRAGITE,mEWTWO,mEW,cHIKITA,bAYLEEF,mEGNIUM,cYNDQIL,qUILAVA,tYPHLOS,tOTODIL,cROCNAW,fRLGATR,sENTRET,fURRET,hOOTOOT,nOCTOWL,lEDYBA,lEDIAN,sPINRAK,aRIADOS,cROBAT,cHINCHU,lANTURN,pICHU,cLEFFA,iGGBUFF,tOGEPI,tOGETIC,nATU,xATU,mAREEP,fLAAFFY,aMPHROS,bELOSOM,mARILL,aZMARIL,sUDWOOD,pOLTOED,hOPPIP,sKIPLOM,jUMPLUF,aIPOM,sUNKERN,sUNFLOR,yANMA,wOOPER,qUAGSIR,eSPEON,uMBREON,mURKROW,sLOWKNG,mISDVUS,uNOWN,wOBUFET,gIFARIG,pINECO,fORTRES,dUNSPAR,gLIGAR,sTEELIX,sNUBBUL,gRANBUL,qILFISH,sCIZOR,sHUCKLE,hERCROS,sNEASEL,tEDIURS,uRSRING,sLUGMA,mACARGO,sWINUB,pILSWIN,cORSOLA,rEMRAID,oCTLERY,dELBIRD,mANTINE,sKARMRY,hONDOUR,hONDOOM,kINGDRA,pHANPY,dONPHAN,pORYGN2,sTANTLR,sMEARGL,tYROGUE,hITMTOP,sMOOCHM,eLEKID,mAGBY,mILTANK,bLISSEY,rAIKOU,eNTEI,sUICUNE,lARVTAR,pUPITAR,tYRATAR,lUGIA,hOoH,cELEBI,___,nONE,___,___",f_zobj"0,nEUTER;,mALE,fEMALE",split"lEARN,tEACH,eVENT",f_zobj";,136,0,10,8,8;;,132,128,4,9,9;;,131,129,3,138,138;;,128,130,141,14,14;;,134,7,5,0,0;;,129,1,13,6,6",f_zobj"0;,;;,;;,;;,;;,;;,;;,;;,;;,;;,;;,;;,;;,;;,;;,;;,;;,;;,",function()
g_init_peek_loc+=1
return@g_init_peek_loc
end,function(list,ind)
list[ind].lock=true
end,function()
f_unlock(c_items,0+1)
for ind in all(split"0,8,104,181,247,236,112,40,111,105,61,235 ")do
f_unlock(c_moves,ind)
end
for i,ind in ipairs(split"1,4,7,152,155,158,252 ")do
f_unlock(c_pokemon,ind)
if@0x5efe==0 then
f_save_party_pkmn(f_mkpkmn(ind,true,rnd(2)\1,0,5,5,5,5),0,i-1)
end
end
if@0x5efe==0 then
poke(0x5efe,1)
memset(0x5e2a,252,126)
end
for i=1,min(58,@0x5eff)do
local team=f_team_league(i)
for pkmn in all(team)do
f_unlock(c_pokemon,pkmn.num)
f_unlock(c_items,pkmn.item+1)
for i=1,4 do
f_unlock(c_moves,pkmn[i].id)
end
end
end
end,function(ind,respect_locks,gender_bit,item,...)
local pkmn=f_zobj("num,@,gender_bit,@,item,@,valid,@,seen_moves,#,major,0,gender,0,evasion,1,accuracy,1,crit,1;stages;attack,0,defense,0,specialattack,0,specialdefense,0,speed,0,crit,0,evasion,0,accuracy,0;",ind,gender_bit,item%42,ind<252)
pkmn=setmetatable(pkmn,{__index=c_pokemon[ind]})
pkmn.gender=pkmn.genders[pkmn.gender_bit%#pkmn.genders+1]
local moves={...}
for i=1,4 do
local move=mid(1,moves[i],#pkmn.possible_moves)
while pkmn.seen_moves[move]or respect_locks and not c_moves[pkmn.possible_moves[move]].lock do
move=move%#pkmn.possible_moves+1
end
pkmn.seen_moves[move]=true
pkmn[i]={id=pkmn.possible_moves[move],pid=move}
end
return pkmn
end,function(party_num)
local team={}
for i=0,5 do
add(team,f_get_party_pkmn(party_num,spot_num))
end
return team
end,function(trainer_num)
local team={}
local trainer=c_trainers[trainer_num]
for pkmn_ind in all(trainer)do
local last_move=8
local possible_moves=c_pokemon[pkmn_ind].possible_moves
for i=9,#possible_moves do
if possible_moves[i]==trainer.move then
last_move=i
break
end
end
add(team,f_mkpkmn(pkmn_ind,false,1,c_pokemon[pkmn_ind].default_item,5,6,7,last_move))
end
return team
end,function(party_num,spot_num)
local num_loc=0x5e00+party_num*42+spot_num*7
local pkmn_num=min(252,@num_loc)
if pkmn_num<252 and not c_pokemon[pkmn_num].lock then pkmn_num=252 end
local pkmn=f_mkpkmn(pkmn_num,true,@(num_loc+1),@(num_loc+2),@(num_loc+3),@(num_loc+4),@(num_loc+5),@(num_loc+6))
f_save_party_pkmn(pkmn,party_num,spot_num)
return pkmn
end,function(_ENV,party_num,spot_num)
local num_loc=0x5e00+party_num*42+spot_num*7
poke(num_loc,num)
poke(num_loc+1,gender_bit)
poke(num_loc+2,item)
poke(num_loc+3,_ENV[1].pid)
poke(num_loc+4,_ENV[2].pid)
poke(num_loc+5,_ENV[3].pid)
poke(num_loc+6,_ENV[4].pid)
end,function(_ENV)
add(g_gridstack,_ENV)
op,pkmnlist={},{}
gridpofunc(_ENV,unpack(params))
end,function(gridname)
return _g[gridname].g_cg_m.sel
end,function(_ENV)add(op,{})end,function(_ENV)
for i=0,251 do
local disabled=not c_pokemon[i].lock
if not disabled then
add(pkmnlist,c_pokemon[i])
end
add(op,{disabled=disabled,draw=function(_,is_sel,gridobj)
f_draw_pkmn(c_pokemon[i].lock and i or 252,1,1,6,false,is_sel,gridobj.disabled)
end})
end
end,function(_ENV,sumdisable)
for partynum=0,3 do
local valid=true
local inds={}
for pkmnnum=0,5 do
local pkmn=f_get_party_pkmn(partynum,pkmnnum)
if pkmn.valid then
valid=false
end
add(inds,pkmn.num)
end
add(op,{data=inds,disabled=sumdisable and valid,draw=function(i,is_sel,gridobj)
for ii,ind in ipairs(gridobj.data)do
f_draw_pkmn(ind,(ii-1)%3+1+(ii-1)%3*9,1+(ii-1)\3*10,6,false,is_sel,gridobj.disabled)
end
end})
end
end,function(_ENV)
for pkmnnum=0,5 do
local pkmn=f_get_party_pkmn(f_getsel"g_grid_pickedit",pkmnnum)
add(op,{draw=function(i,is_sel)
f_draw_pkmn(pkmn.num,1,1,16,false,is_sel)
end})
end
end,function(_ENV)
foreach(split"bROWSE,eDIT,lEAGUE,vERSUS",function(text)
f_addop_text(op,text)
end)
end,function(_ENV)
for i=1,58 do
local disabled=@0x5eff+1<i
add(op,{text=disabled and f_strtoq(c_trnr_names[i])or c_trnr_names[i],disabled=disabled})
end
end,function(_ENV)
local pkmn=f_get_party_pkmn(f_getsel"g_grid_pickedit",f_getsel"g_grid_pickspot")
for i=1,4 do
add(op,{text=c_move_names[pkmn[i].id],select=function()
f_add_to_ui_stack(g_grid_editmove)
end})
end
add(op,{text=c_item_names[pkmn.item],select=function()
f_add_to_ui_stack(g_grid_edititem)
end})
add(op,{text=c_gender_names[pkmn.gender],disabled=#pkmn.genders<2,select=function()
pkmn.gender_bit+=1
pkmn:f_save_party_pkmn(f_getsel"g_grid_pickedit",f_getsel"g_grid_pickspot")
end})
add(op,{text="vIEW",select=function()
f_add_to_ui_stack(g_grid_statedit)
end})
add(op,{text="dELETE",select=function()
memset(0x5e00+f_getsel"g_grid_pickedit"*42+f_getsel"g_grid_pickspot"*7,252,7)
deli(g_gridstack)
end})
end,function(_ENV,op,disabled)
add(op,{text=lock and name or f_strtoq(name),disabled=disabled or not lock})
end,function()return f_get_party_pkmn(f_getsel"g_grid_pickedit",f_getsel"g_grid_pickspot")end,function(_ENV)
local pkmn=f_get_edit_op_pkmn()
for i,num in ipairs(pkmn.possible_moves)do
f_create_spot(c_moves[num],op,pkmn.seen_moves[i])
end
end,function(_ENV,list,key)
local pkmn=f_get_edit_op_pkmn()
for obj in all(list)do
f_create_spot(obj,op,pkmn[key]==obj.num)
end
end,function(_ENV)f_op_template_edit(op,c_items,"item")end,function(op,pkmn,ind)
local m=pkmn[ind]
local pp,pow,acc,typ=f_get_move_texts(c_moves[m.id])
add(op,{text="mOVE"..ind..": "..c_move_names[m.id],disabled=true})
add(op,{text="tYPE:  "..typ})
add(op,{text="pWpNT: "..pp.."/"..pp})
add(op,{text="pW/aC: "..pow.."/"..acc})
end,function(op,pkmn,mode)
local genders=""
if #pkmn.genders==1 then
genders=c_gender_names[pkmn.genders[1]].."/"
else
for g in all(pkmn.genders)do
genders..=sub(c_gender_names[g],1,2).."/"
end
end
genders=sub(genders,1,#genders-1)
add(op,{text="#"..f_prefix_zero(pkmn.num,3).." "..pkmn.name,disabled=true})
add(op,{text="       tYPE:"})
add(op,{text="        "..c_type_names[pkmn.type1+1]})
local t2text="        "
if pkmn.type2 ~=0 then
t2text..=c_type_names[pkmn.type2+1]
end
add(op,{text=t2text,draw=function()
f_draw_pkmn(pkmn.num,2-8-20+(g_preview_timer>0 and(rnd(3)\1-1)or 0)+30,-8+1-10-1-1+6+3-3,16)
rectfill(-9+4+30,-18,-9+4+30,6,2)
end})
add(op,{text="pOKEMON sTATS",disabled=true})
if mode>=2 then
add(op,{text="mAJOR: nONE"})
end
if mode>=1 then
add(op,{text="iTEM:  nONE"})
end
add(op,{text="gENDR: "..genders})
add(op,{text="pREVO: "..c_pkmn_names[pkmn.prevolve]})
add(op,{text="hEALT: "..pkmn.hp.."/"..pkmn.hp})
for stat in all(f_zobj";name,aTACK,key,attack;;name,dEFNS,key,defense;;name,sPaTK,key,specialattack;;name,sPdFN,key,specialdefense;;name,sPEED,key,speed")do
local text=stat.name..": "..f_prefix_zero(pkmn[stat.key],3)
if pkmn.stages then
text..=" "..(pkmn.stages[stat.key]>0 and "+"..pkmn.stages[stat.key]or(pkmn.stages[stat.key]<0 and "-"..pkmn.stages[stat.key])or "")
end
add(op,{text=text})
end
if mode>=3 then
add(op,{text="eVASN: "..f_prefix_zero(pkmn.evasion*100\1,3).."%"})
add(op,{text="aCURY: "..f_prefix_zero(pkmn.accuracy*100\1,3).."%"})
add(op,{text="cRITL: "..f_prefix_zero(pkmn.crit/16*100\1,3).."%"})
end
if mode>=1 then
f_add_stat_move(op,pkmn,1)
f_add_stat_move(op,pkmn,2)
f_add_stat_move(op,pkmn,3)
f_add_stat_move(op,pkmn,4)
end
if mode>=3 then
add(op,{text="bATTLE fLAGS",disabled=true})
local prev=""
for i,x in ipairs(split"aCTIVE,bENCHD,nONE,mVlOCK,bIDE,dFNcRL,dISABL,cONFUS,rOLOUT,dSTbND,lOCKoN,dIG,fLY,fRYcTR,rAGE,tOXIC,pERsNG,pDEcNT,sUBSTU,nGTMAR,tRFORM,lECHsD,cURSE,mIST,tRAPPD,mEANlK,aTRACT,fORsGT,fTRsGT,sAFgRD,lITsCR,rFLECT,sPIKES,sNDsTR,rAIdNC,sUNdAY")do
if i%2==1 do
prev=x
while #prev<6 do
prev=prev.." "
end
else
add(op,{text=prev.." "..x})
prev=""
end
end
if prev ~=""then
add(op,{text=prev})
end
end
end,function(_ENV)f_add_stat(op,c_pokemon[f_getsel"g_grid_browse"],0)end,function(_ENV)f_add_stat(op,f_get_party_pkmn(f_getsel"g_grid_pickedit",f_getsel"g_grid_pickspot"),1)end,function(_ENV)f_add_stat(op,f_get_party_pkmn(f_getsel"g_grid_pickedit",f_getsel"g_grid_pickspot"),1)end,function(i,is_sel)
f_print_top("tEAM",f_getsel"g_grid_pickedit"+1,": sPOT",f_getsel"g_grid_pickspot"+1)
local pkmn=f_get_party_pkmn(f_getsel"g_grid_pickedit",f_getsel"g_grid_pickspot")
f_print_bot("#",pkmn.num_str," ",pkmn.name)
end,function(i,is_sel)
local prefix="sPOT"..f_getsel"g_grid_pickspot"+1
local pkmn=f_get_party_pkmn(f_getsel"g_grid_pickedit",f_getsel"g_grid_pickspot")
if f_getsel"g_grid_editstat"<4 then f_print_top(prefix,": mOVE",f_getsel"g_grid_editstat"+1)
elseif f_getsel"g_grid_editstat"==4 then f_print_top(prefix,": iTEM")
elseif f_getsel"g_grid_editstat"==5 then f_print_top(prefix,": gENDER")
elseif f_getsel"g_grid_editstat"==6 then f_print_top(prefix,": vIEW")
elseif f_getsel"g_grid_editstat"==7 then f_print_top(prefix,": dELETE")
end
local pkmn=f_get_party_pkmn(f_getsel"g_grid_pickedit",f_getsel"g_grid_pickspot")
f_print_bot("#",pkmn.num_str," ",pkmn.name)
end,function(...)
local text=""
for x in all{...}do
text..=x
end
print("\f4"..text,1,1)
end,function(...)
local text=""
for x in all{...}do
text..=x
end
print("\f2"..text,1,8)
end,function(move)
local pp,pow,acc,typ=f_prefix_zero(move.pp,2),f_prefix_zero(move.pow,3),f_prefix_zero(move.acc,3),c_type_names[move.type+1]
if move.pow==0 then pow="___"
elseif move.pow==1 then pow="var" end
if move.acc==0 then acc="___" end
if move.num==0 then
typ,pp,pow,acc="______","__","___","___"
elseif not move.lock then
pp,pow,acc,typ=f_strtoq(pp),f_strtoq(pow),f_strtoq(acc),f_strtoq(typ)
end
return pp,pow,acc,typ
end,function(move,method)
local pp,pow,acc,typ=f_get_move_texts(move)
f_print_top(method,": ",typ)
f_print_bot(pp,"PP ",pow,"P ",acc,"A")
end,function()
local pkmn=f_get_party_pkmn(f_getsel"g_grid_pickedit",f_getsel"g_grid_pickspot")
local movenum=pkmn.possible_moves[f_getsel"g_grid_editmove"+1]
local move=c_moves[movenum]
f_dt_editmove_template(move,pkmn.possible_moves_method[movenum])
end,function(i,is_sel)
print("\f4hello",1,1)
end,function(num,len)
local numstr=tostr(num)
while #numstr<len do numstr=" "..numstr end
return numstr
end,function(num,len)
local numstr=tostr(num)
while #numstr<len do numstr="0"..numstr end
return numstr
end,function(pkmn_ind)
local pkmn=c_pokemon[pkmn_ind]
local namestr,type1,type2=pkmn.name,c_type_names[pkmn.type1+1],""
if pkmn.type2>0 then
type2=c_type_names[pkmn.type2+1]
end
if not pkmn.lock then
namestr,type1,type2=f_strtoq(namestr),f_strtoq(type1),f_strtoq(type2)
end
f_print_top("#",f_prefix_zero(pkmn.num,3)," ",namestr)
f_print_bot(type1," ",type2)
end,function()
f_dt_browse_template(f_getsel"g_grid_browse")
end,function()
local pkmn=c_pokemon[f_getsel"g_grid_browse"]
local namestr=pkmn.name
if not pkmn.lock then
namestr=f_strtoq(namestr)
end
f_print_top("tEAM",f_getsel"g_grid_pickedit"+1,": sPOT",f_getsel"g_grid_pickspot"+1)
f_print_bot("#",f_prefix_zero(pkmn.num,3)," ",namestr)
end,function()
local pkstr_arr={}
local pkstr_lens=split"2,2,2,2,1,1"
for ii=0,5 do
local pkmn=f_get_party_pkmn(f_getsel"g_grid_pickedit",ii)
add(pkstr_arr,sub(c_pkmn_names[pkmn.num],1,pkstr_lens[ii+1]))
end
f_print_top("eDIT: tEAM",1)
f_print_bot(pkstr_arr[1],"-",pkstr_arr[2],"-",pkstr_arr[3],"-",pkstr_arr[4],"-",pkstr_arr[5],pkstr_arr[6])
end,function()
local toggle=g_cg_m.name=="g_grid_pickleag"
local disabled=@0x5eff+1<f_getsel"g_grid_picktrnr"+1
local name=c_trnr_names[f_getsel"g_grid_picktrnr"+1]
name=disabled and f_strtoq(name)or name
f_print_top(toggle and "\f4"or "\f2","pLR: tEAM",f_getsel"g_grid_pickedit"+1)
f_print_bot(toggle and "\f2"or "\f4","cPU: ",name)
end,function()
local toggle=g_cg_m.name=="g_grid_pickplr1"
f_print_top(toggle and "\f4"or "\f2","pLR1: tEAM",f_getsel"g_grid_pickedit"+1)
f_print_bot(toggle and "\f2"or "\f4","pLR2: tEAM",f_getsel"g_grid_pickplr2"+1)
end,function()
print("\^w\^tpicodex",2,1,4)
print("dUAL vERSION",2,12,2)
f_draw_pkmn(g_title_l,-8+15+(mid(-1,-.75,cos(0+g_title_an_timer/300))+.75)*4*26+(g_title_an_timer>190 and g_title_an_timer<220 and(rnd(3)\1-1)or 0),20,16)
f_draw_pkmn(g_title_r,50-15-(mid(-1,-.75,cos(.5+g_title_an_timer/300))+.75)*4*26+(g_title_an_timer>40 and g_title_an_timer<70 and(rnd(3)\1-1)or 0),20,16,true)
end,function()
local b=function(name,status,x,y,bx,by,hp,hpmax,sel)
local col=sel and 2 or 2
local boxcol=sel and 3 or 3
roundrect_r(bx-1+1,by+1-6+1,bx+35-1,by+6+6+1,boxcol)
if hp>0 then
rectfill(bx+1,by+3,bx+1+mid(0,hp/hpmax*32,32),by+6,col)
pset(bx+1,by+3,boxcol)
pset(bx+1,by+6,boxcol)
pset(bx+33,by+3,boxcol)
pset(bx+33,by+6,boxcol)
end
local tx,ty=x+15,y+9
for i=0,5 do
if i ~=1 then
pset(tx+i%3*2,ty+i%2*2-1+1,i==3 and 4 or 2)
end
end
print(name,x+2,y-5+1+1,col,-1)
print(status.."  "..f_prefix_zero(hp,3),x+1+1,y+8-1+1,col,-1)
end
b("vENUSAUR","bRN",0,4,0,4,1,100,false)f_draw_pkmn(3,39,1,16,true,false,false,true)
b("cHARMAND","fZN",23,24,23,24,60+cos(t())*50\1,80,true)f_draw_pkmn(9,3,21,16,false,false,false,false)
end,function(_ENV)
add(op,{text="fIGHT"})
add(op,{text="sTATS",select=function()
f_add_to_ui_stack(g_grid_battle_stat)
end})
add(op,{text="sWITCH"})
add(op,{text="gIVEuP"})
end,function()
deli(g_gridstack)
end,function()
f_add_to_ui_stack(g_grid_statbrowse)
end,function()
if f_getsel"g_grid_title"==0 then
f_add_to_ui_stack(g_grid_browse)
elseif f_getsel"g_grid_title"==1 then
f_add_to_ui_stack(g_grid_pickedit)
elseif f_getsel"g_grid_title"==2 then
f_add_to_ui_stack(g_grid_pickleag)
elseif f_getsel"g_grid_title"==3 then
f_add_to_ui_stack(g_grid_pickplr1)
end
end,function()
g_preview_timer=20
return f_getsel"g_grid_browse"
end,function()
g_preview_timer=20
return f_get_party_pkmn(f_getsel"g_grid_pickedit",f_getsel"g_grid_pickspot").num
end,function()
f_add_to_ui_stack(g_grid_pickplr2)
end,function()
f_add_to_ui_stack(g_grid_picktrnr)
end,function()
f_add_to_ui_stack(g_grid_battle_select)
end,function()
f_add_to_ui_stack(g_grid_pickspot)
end,function()
f_add_to_ui_stack(f_get_party_pkmn(f_getsel"g_grid_pickedit",f_getsel"g_grid_pickspot").valid and g_grid_editstat or g_grid_editpkmn)
end,function()
f_save_party_pkmn(f_mkpkmn(f_getsel"g_grid_browse",true,rnd(2)\1,0,5,6,7,8),f_getsel"g_grid_pickedit",f_getsel"g_grid_pickspot")
deli(g_gridstack)
end,function()gridpo[f_getsel"g_grid_editstat"+1].select()end,function()gridpo[f_getsel"g_grid_battle_select"+1].select()end,function()
local pkmn=f_get_party_pkmn(f_getsel"g_grid_pickedit",f_getsel"g_grid_pickspot")
pkmn[f_getsel"g_grid_editstat"+1].pid=f_getsel"g_grid_editmove"
f_save_party_pkmn(pkmn,f_getsel"g_grid_pickedit",f_getsel"g_grid_pickspot")
deli(g_gridstack)
end,function()
local pkmn=f_get_party_pkmn(f_getsel"g_grid_pickedit",f_getsel"g_grid_pickspot")
pkmn.item=f_getsel("g_grid_edititem")
f_save_party_pkmn(pkmn,f_getsel"g_grid_pickedit",f_getsel"g_grid_pickspot")
deli(g_gridstack)
end,function()
return 253
end,function(dir)
local prev=f_getsel"g_grid_browse"
local next=prev+1
if dir>0 then
for i=next+1,252,1 do
if c_pokemon[i-1].lock then
next=i
break
end
end
elseif dir<0 then
for i=prev-1,0,-1 do
if c_pokemon[i].lock then
next=i+1
break
end
end
end
if prev ~=f_getsel"g_grid_browse" then
f_minisfx(255)
elseif dir ~=0 then
f_minisfx(253)
end
end,function(dir)
local prev=f_getsel"g_grid_pickspot"
local next=prev+1
if dir>0 then
for i=next+1,6,1 do
local pkmn=f_get_party_pkmn(f_getsel"g_grid_pickedit",i-1)
if pkmn.num ~=252 then
next=i
break
end
end
elseif dir<0 then
for i=prev-1,0,-1 do
local pkmn=f_get_party_pkmn(f_getsel"g_grid_pickedit",i)
if pkmn.num ~=252 then
next=i+1
break
end
end
end
if prev ~=f_getsel"g_grid_pickspot" then
f_minisfx(255)
elseif dir ~=0 then
f_minisfx(253)
end
end,function(s)
local ns=""
for i=1,#s do ns..="?" end
return ns
end,function()end,function(party_num,callback)
for ii=0,5 do
local party_loc=0x5e00+party_num*42
local pkmn_ind=@(party_loc+ii*7)
callback(c_pokemon[pkmn_ind].lock and pkmn_ind,ii)
end
end,function()
g_title_timer=min(100,(g_title_timer+1))
g_preview_timer=max(0,g_preview_timer-1)
top_grid=g_gridstack[#g_gridstack]
g_cg_m=top_grid.g_cg_m
g_cg_s=top_grid.g_cg_s
gridpofunc=top_grid.gridpofunc
params=top_grid.params
gridpo=top_grid.op
if g_title_timer==100 then
f_update_grid(g_cg_m,gridpo,top_grid)
if g_cg_m.name=="g_grid_title" then
g_title_an_timer=(g_title_an_timer+1)%300
if g_title_an_timer==0 then g_title_r=rnd"252"\1
elseif g_title_an_timer==150 then g_title_l=rnd"252"\1
elseif g_title_an_timer==40 then f_minisfx(g_title_r-1)
elseif g_title_an_timer==190 then f_minisfx(g_title_l-1)end
end
elseif g_title_timer<100 then
local b=bitmaskToIndex(btnp())
if b then
g_palette=b
end
end
end,function()
cls"1 "
if g_title_timer<100 then
print("\^y7\f4aLANxOC3\n\-d \f3pRESENTS",32-4*4,32-6)
end
local easing=sin(max(.75*100,g_title_timer)/100)
if g_cg_m then
f_draw_grid(g_cg_m,gridpo,g_cg_m.sel,g_cg_m.view,g_cg_m.x,g_cg_m.y+easing*20,true)
f_draw_grid(g_cg_s,{{draw=g_cg_s.df}},-1,0,g_cg_s.x,g_cg_s.y-easing*45)
end
pal(c_palettes[g_palette+1],1)
end)
function debug_sort(t,compare_func)
compare_func=compare_func or function(a,b)return tostr(a)<tostr(b)end
if t then
for n=2,#t do
local i=n
while i>1 and compare_func(t[i],t[i-1])do
t[i],t[i-1]=t[i-1],t[i]
i=i-1
end
end
end
end
function debug(any)
if type(any)~="table"then return tostr(any)end
local str="{"
local keys={}
for i=1,#any do
if str~="{"then str=str.."," end
keys[i]=true
str=str..debug(any[i])
end
local sortedkeys={}
for k,v in pairs(any)do
if not keys[k]then
add(sortedkeys,k)
end
end
debug_sort(sortedkeys)
for k in all(sortedkeys)do
if str~="{"then str=str.."," end
str=str..debug(k).."="..debug(any[k])
end
return str.."}"
end
f_zcall(poke,";,0x5f2c,3;;,0x5f5c,8;;,0x5f5d,1;;,0x5eff,2")
cls()
for i=0,323 do
c_types[i\18][i%18]=f_init_peek_inc()\2
end
for i=0,41 do add(c_items,f_zobj("lock,~c_no,num,@,name,@",i,c_item_names[i]))end
c_pokemon[252]={num_str="___",num=252,name="eMPTY",type1=18,type2=0,genders={0},possible_moves=f_zobj",0,0,0,0"}
for i=0,251 do
local pkmn=f_zobj("moves_progress;,#,#,#;moves_grouped;,#,#,#;lock,~c_no,name,@,num,@,num_str,@",c_pkmn_names[i],i,f_prefix_zero(i,3))
cur_list,c_moves[i],c_pokemon[i]=pkmn.moves_progress[1],f_zobj("lock,~c_no,num,@,name,@",i,c_move_names[i]),pkmn
foreach(split"pow,type,acc,pp",function(key)
c_moves[i][key]=f_init_peek_inc()
end)
foreach(split"prevolve,type1,type2,hp,attack,defense,speed,specialattack,specialdefense,default_item",function(key)
pkmn[key]=f_init_peek_inc()
end)
foreach(split"hp,attack,defense,speed,specialattack,specialdefense",function(key)
pkmn[key]+=52
end)
pkmn.hp+=55
for k,v in pairs(f_zobj"192;,1,2;0;,0;64;,1;128;,2")do
if pkmn.default_item & 192==k then
pkmn.genders=v
pkmn.default_item &=0x3f
end
end
while f_init_peek_inc()<255 do
if@g_init_peek_loc==252 then cur_list=pkmn.moves_progress[2]
elseif@g_init_peek_loc==253 then cur_list=pkmn.moves_progress[3]
elseif@g_init_peek_loc==254 then
for j=cur_list[#cur_list-1]+1,cur_list[#cur_list]-1 do
add(cur_list,j)
end
else
add(cur_list,@g_init_peek_loc)
end
end
end
for i=0,251 do
local sub=c_pokemon[i]
while sub do
for ii=1,3 do
foreach(sub.moves_progress[ii],function(v)
add(c_pokemon[i].moves_grouped[ii],v)
end)
end
sub=c_pokemon[sub.prevolve]
end
end
for i=0,251 do
c_pokemon[i].possible_moves=f_zobj",0,0,0,0"
c_pokemon[i].possible_moves_method=f_zobj"0,eMPTY"
for ii=1,3 do
foreach(c_pokemon[i].moves_grouped[ii],function(v)
add(c_pokemon[i].possible_moves,v)
c_pokemon[i].possible_moves_method[v]=c_movemethod_names[ii]
end)
end
end
for i=1,57 do
local trainer={move=f_init_peek_inc()}
for j=1,6 do add(trainer,f_init_peek_inc())end
add(c_trainers,trainer)
end
local horde={move=251}
for i=1,252 do add(horde,i%252)end
add(c_trainers,horde)
menuitem(1,"factory reset",function()
cls()flip()
memset(0x5e00,0,256)
run()
end)
f_update_locks()
for iloc=0x3200,0x4278,68 do
for loc=iloc,iloc+63,2 do
poke2(loc,%loc & 0x70df|0x0a00)
end
poke4(iloc+64,0x.07d7)
end
function roundrect_r(x1,y1,x2,y2,c)
rectfill(x1,y1+1,x2,y2-1,c)
if x2-x1>2 then
rectfill(x1+1,y1,x2-1,y2,c)
end
end
f_zcall(f_create_gridpair,"top_browse;,6,4,2,2,10,10;top_edit;,2,2,2,2,30,20;top_editteam;,3,2,2,2,20,20;top_pkstat;,1,4,2,4,60,9;top_text_grid;,2,4,2,4,30,9;top_title;,1,1,2,2,60,40;top_battle;,1,1,2,2,60,40;bot_4x4;,2,2,2,44,30,9;bot_info;,1,1,2,45,60,16;;,g_grid_title,~bot_4x4,~top_title,~f_dp_title,~f_op_title,~f_s_title,~f_l_title,~c_no;;,g_grid_browse,~top_browse,~bot_info,~f_dt_browse,~f_op_browse,~f_s_browse,~f_l_browse,~c_no;;,g_grid_editpkmn,~top_browse,~bot_info,~f_dt_editpkmn,~f_op_browse,~f_s_editpkmn,~f_l_browse,~c_no;;,g_grid_statbrowse,~top_pkstat,~bot_info,~f_dt_browse,~f_op_statbrowse,~f_s_pkstat,~f_l_browse,~f_browselr;;,g_grid_statedit,~top_pkstat,~bot_info,~f_dt_editstat,~f_op_statedit,~f_s_statedit,~f_l_browse,~f_lr_statedit;;,g_grid_battle_stat,~top_pkstat,~bot_info,~f_dt_browse,~f_op_statbattle,~f_nf,~f_l_browse,~f_lr_statedit;;,g_grid_editstat,~top_text_grid,~bot_info,~f_dt_editstat,~f_op_editstat,~f_s_editstat,~f_l_browse,~c_no;;,g_grid_editmove,~top_text_grid,~bot_info,~f_dt_editmove,~f_op_editmove,~f_s_editmove,~f_l_browse,~c_no;;,g_grid_edititem,~top_text_grid,~bot_info,~f_dt_editstat,~f_op_edititem,~f_s_edititem,~f_l_browse,~c_no;;,g_grid_pickedit,~top_edit,~bot_info,~f_dt_edit,~f_op_edit,~f_s_edit,~f_l_browse,~c_no;;,g_grid_pickleag,~top_edit,~bot_info,~f_dt_league,~f_op_edit,~f_s_league,~f_l_browse,~c_no,~c_yes;;,g_grid_pickplr1,~top_edit,~bot_info,~f_dt_versus,~f_op_edit,~f_s_versus,~f_l_browse,~c_no,~c_yes;;,g_grid_pickplr2,~top_edit,~bot_info,~f_dt_versus,~f_op_edit,~f_nf,~f_l_browse,~c_no,~c_yes;;,g_grid_pickspot,~top_editteam,~bot_info,~f_dt_editteam,~f_op_editteam,~f_s_editteam,~f_l_browse,~c_no;;,g_grid_picktrnr,~top_text_grid,~bot_info,~f_dt_league,~f_op_teams,~f_s_batbegin,~f_l_browse,~c_no;;,g_grid_battle_select,,~bot_4x4,~top_battle,~f_dp_battle,~f_op_batsel,~f_s_battle,~f_nf,~c_no")
g_gridstack={}
f_add_to_ui_stack(g_grid_title)
function bitmaskToIndex(bitmask)
for i=0,5 do
if bitmask &(1<<i)~=0 then
return i
end
end
return nil
end
sfx"63"