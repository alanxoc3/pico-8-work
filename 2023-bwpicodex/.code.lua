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
f_zobj_set(_g,"c_pokemon,#,c_moves,#,c_trainers,#,c_items,#,g_init_peek_loc,0x1fff,c_yes,@,c_no,@,c_empty,@,f_nop,@,g_palette,0,g_preview_timer,0,g_title_timer,0,g_title_l,254,g_title_r,254,g_title_an_timer,70",true,false,"",function(...)return...end)
f_zobj_set(_g,"f_zobj,@,f_zobj_set,@,f_zobj_eval,@,f_zcall,@,f_refresh_top,@,f_add_to_ui_stack,@,f_pop_ui_stack,@,f_getsel,@,f_setsel,@,f_create_gridpair,@,f_update_grid,@,f_draw_grid,@,f_addop_text,@,f_minisfx,@,f_draw_pkmn,@,c_move_names,@,c_trnr_names,@,c_type_names,@,c_item_names,@,c_pkmn_names,@,c_gender_names,@,c_major_names_long,@,c_major_names_short,@,c_movemethod_names,@,c_statmod_names,@,c_palettes,@,c_palette_names,@,c_types,@,f_init_peek_inc,@,f_unlock,@,f_update_locks,@,f_create_active,@,f_create_player,@,f_start_battle,@,f_get_other_pl,@,f_set_pself,@,f_get_live_pkmn,@,f_get_next_active,@,f_end_battle,@,f_newaction,@,f_addaction,@,f_pkmn_comes_out,@,f_pop_next_action,@,f_postmove_logic,@,f_mkpkmn,@,f_team_party,@,f_fill_team,@,f_team_league,@,f_get_party_pkmn,@,f_save_party_pkmn,@,f_op_def,@,f_op_browse,@,f_op_edit,@,f_op_editteam,@,f_op_title,@,f_op_prevpk,@,f_op_teams,@,f_op_editmovebot,@,f_op_editstat,@,f_create_spot,@,f_get_edit_op_pkmn,@,f_op_editmove,@,f_op_template_edit,@,f_op_edititem,@,f_add_stat_move,@,f_add_stat_info,@,f_add_stat,@,f_op_statbrowse,@,f_dt_editteam,@,f_dt_editstat,@,f_print_top,@,f_print_bot,@,f_get_move_texts,@,f_dt_editmove_template,@,f_dt_editmove,@,f_dt_editmovebot,@,f_prefix_space,@,f_prefix_zero,@,f_dt_browse_template,@,f_dt_browse,@,f_dt_editpkmn,@,f_dt_edit,@,f_dt_league,@,f_dt_batstats,@,f_dt_switch,@,f_dt_versus,@,f_dp_title,@,f_roundrect,@,f_add_battle,@,f_op_batsel,@,f_op_movesel,@,f_op_batswitch,@,f_s_batresults,@,f_op_batresults,@,f_op_batstats,@,f_l_browse,@,f_s_browse,@,f_s_title,@,f_s_pkstat,@,f_s_statedit,@",f_zobj,f_zobj_set,f_zobj_eval,function(func,text,...)
foreach(f_zobj(text,...),function(params)
func(unpack(params))
end)
end,function()
local idk=g_gridstack[#g_gridstack]
idk.op,idk.preview_op,idk.lrlist={},{},{}
idk.gridpofunc(idk,unpack(idk.params))
end,function(_ENV)
add(g_gridstack,_ENV)
op,preview_op,lrlist={},{},{}
gridpofunc(_ENV,unpack(params))
end,function()
deli(g_gridstack)
f_refresh_top()
end,function(gridname)
return _g[gridname].g_cg_m.sel
end,function(gridname,val)
_g[gridname].g_cg_m.sel=val
end,function(name,main_grid_spec,info_grid_spec,info_grid_draw,main_op_func,main_sel_func,main_leave_func,lrbasegrid,...)
_g[name]=f_zobj("g_cg_m,@,g_cg_s,@,gridpofunc,@,params,@",
f_zobj("sel,@,view,0,name,@,selfunc,@,leavefunc,@,lrbasegrid,@,w,@,vh,@,x,@,y,@,cw,@,ch,@",lrbasegrid and-1 or 0,name,main_sel_func,main_leave_func,lrbasegrid,unpack(main_grid_spec)),
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
local prevsel=sel
if lrbasegrid then
local dir=(btnp"1" and 1 or 0)-(btnp"0" and 1 or 0)
local lst=_g[lrbasegrid].op
local cur=f_getsel(lrbasegrid)
local nxt=cur
if dir>0 then
for i=cur+2,#lst,1 do
if lst[i].lrvalid then
nxt=i-1
break
end
end
elseif dir<0 then
for i=cur-1,0,-1 do
if lst[i+1].lrvalid then
nxt=i
break
end
end
end
if nxt ~=cur then
f_minisfx(255)
f_setsel(lrbasegrid,nxt)
f_refresh_top()
elseif dir ~=0 then
f_minisfx(253)
end
else
sel=evalfunc(sel,sel\w*w,w-1,btnp"0",btnp"1",1)
end
if lrbasegrid then
sel=-1
dir=(btnp"3" and 1 or 0)-(btnp"2" and 1 or 0)
view+=dir
else
sel=evalfunc(sel,sel%w,(#gridobj-1)\w*w,btnp"2",btnp"3",w)
if sel ~=prevsel then
f_refresh_top()
end
if sel\w-vh+1>view then view=sel\w-vh+1 end
if sel\w<view then view=sel\w end
end
view=mid(0,view,(#gridobj-1)\w-vh+1)
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
local draw_cell_bg=function(j,offx,offy)
local i=j+view*w
local obj=gridobj[i+1]
if i>=#gridobj then return true end
local xloc,yloc=x+i%w*cw,y+j\w*ch
camera(-xloc-1,-yloc-1)
local l,r,u,d=0,0,0,0
if i==0 then l,u=1,1 end
if i==w-1 then r,u=1,1 end
if i==#gridobj-1 then r,d=1,1 end
if i==(#gridobj-1)\w*w then l,d=1,1 end
local c=3
if obj.disabled or obj.header then
c=2
end
rectfill(offx-1+l,offy-1,offx+cw-2-r,offy+ch-2,c)
rectfill(offx-1,offy-1+u,offx+cw-2,offy+ch-2-d,c)
end
local draw_cell_fg=function(j)
local i=j+view*w
local obj=gridobj[i+1]
if i>=#gridobj then return true end
local xloc,yloc=x+i%w*cw,y+j\w*ch
clip(xloc,yloc,cw,ch)
camera(-xloc-1,-yloc-1)
local c=2
if obj.disabled or obj.header then
c=3
end
print(obj.text or "",1,1,c)
if obj.draw then
obj.draw(i,i==num,obj)
end
clip()
end
for j=0,vh*w-1 do if draw_cell_bg(j,0,0)then break end end
for j=0,vh*w-1 do if draw_cell_fg(j)then break end end
if sel>=0 then
pal{4,4,4}
for i=-1,1 do
for j=-1,1 do
draw_cell_bg(num-view*w,i,j)
end
end
pal()
draw_cell_bg(num-view*w,0,0)
draw_cell_fg(num-view*w)
end
camera()
end,function(op,text)
add(op,{draw=function()print(text,1,1,2)end})
end,function(num)
if num<252 then
g_cur_pkmn_cry=num
end
sfx(num\4,num<252 and 0 or 1,num%4*8,8)
end,function(num,x,y,width,flip,sel,disabled,isoutline)
if not isoutline and stat"46">-1 and g_cur_pkmn_cry==num then
x+=sin(g_shake_timer/4)
end
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
end,f_zobj"0,sTRUGL;,aCID,aCIDaR,bARAGE,bONcLB,bIND,cLAMP,mOONlT,lECHsD,eXTRsP,sNCbOM,tWInDL,tHNsHK,gLARE,gILOTN,hYPfNG,jMPkCK,kINSIS,lOCKoN,lOVkIS,mACpNC,vICgRP,sPIcAN,sPIKES,sPORE,cOTsPR,pRESNT,vItHRW,cMTpNC,dRLpCK,sNDaTK,aGILTY,fRYaTK,qIKaTK,fALsWP,gROWL,hEALbL,sING,pOUND,mINMIZ,tAILwP,dBLsLP,mEGhRN,bONRNG,cONVR1,cONVR2,sPARK,mLKdRK,mORsUN,nGTsHD,oCTZOK,pINmIS,pWDsNW,sUPfNG,fIRsPN,pSNgAS,bARIER,mEDTAT,fTRsGT,hYPNOS,pSYbEM,lITsCR,sAFgRD,pETdNC,cHARM,sYNTHS,sWTsCN,rAZlEF,pSNpWD,sLPpWD,aBSORB,sTNsPR,fLAIL,cONFSN,sLAM,cONSTR,aMNESA,bUBBLE,sPLASH,hYDpMP,mNDrED,mIST,hRNaTK,sPIwEB,dBLkCK,sWTkIS,mTLcLW,tRFORM,tRIKCK,gUST,tWISTR,cRBhAM,dIZpNC,sLUDGE,pAINsP,dSTbND,hAZE,lICK,pERsNG,mEANlK,cNFrAY,cRScHP,sMOG,kARcHP,eMBER,sMKsCR,bELdRM,bEATUP,sCRTCH,sLASH,aNCpWR,lEER,bITE,oUTrGE,sCRYfC,tHRASH,sTOMP,rOKsLD,mAGTUD,rOCtHR,hARDEN,bONrSH,hIJkCK,rECOVR,aERbLS,hRNdRL,dRGrAG,sFbOIL,dRGbRE,sLFdES,eXPLSN,eGGbMB,sLGbMB,gIGdRN,mEGdRN,sWRdNC,cUT,fRYcTR,tHIEF,dIG,rOLOUT,dFNcRL,dETECT,sOLbEM,rAIdNC,fLASH,pSYCIC,pSYCuP,dRMeAT,nGTMAR,sHDbAL,zAPcAN,tHUNDR,tHNbLT,iRNtAL,sTRENG,rOCsMS,hEDbUT,mUDsLP,sUNdAY,pROTCT,dBLtEM,sLPtLK,cURSE,hIDpWR,sWAGER,fRUSTR,rETURN,tOXIC,sNORE,rEST,eNDURE,aTRACT,bIDE,mIMIC,sUBSTU,rAGE,dBLeDG,tAKdWN,sKLbAS,bODsLM,wTRgUN,bBLbEM,iCEbEM,bLIZRD,iCYwND,sURF,wRLPOL,wTRFAL,sWIFT,pAYDAY,tRIaTK,rFLECT,tHNwAV,tELPRT,pSYwAV,mETRNM,cOUNTR,mEGpNC,sEITOS,sUBMIS,mEGkCK,dYNpNC,fIRpNC,tHNpNC,iCEpNC,fIRbLS,fLMtHR,fISURE,eARTqK,sNDsTR,hYPbEM,rOAR,sTLwNG,fLY,rAZwND,wRLwND,sKYaTK,wNGaTK,pECK,mIRMOV,fNTaTK,wITdRW,rAPsPN,sUPsNC,aURbEM,mIRcOT,pSNsTG,sPITE,cRUNCH,pURSUT,sTRsHT,lECHlF,bTNpAS,dISABL,sCRECH,tACKLE,fLMwEL,rEVRSL,fRYsWP,fCSeNG,fORsGT,lOWkCK,rOLkCK,eNCORE,wRAP,gROWTH,vINwHP,sACfIR,sHRPEN,sKETCH,tM05,______",split"yOUNGS,sAGE,fALKNR,gRUNT,bUGcTR,bUGSY,pKMfAN,bEAUTY,wITNEY,kIMINO,mEDIUM,mORTY,pOLICE,kARATE,cHUCK,gENTLE,sAILOR,jASMIN,rOCKET,sKIER,pRYCE,sCIENT,tWINS,cLAIR,nERD,cAMPER,bROCK,sCHOOL,sWIMER,mISTY,jUGLER,gUITAR,lTsURG,hIKER,lASS,eRIKA,bIKER,pICNIK,jANINE,mANIAC,pSYCIC,sABRIN,fISHER,bREATH,bLAINE,bIRDkP,cOOLtR,bLUE,lEGEND,sILVER,wILL,kOGA,bRUNO,kAREN,lANCE,rED,gOLD,hORDE",f_zobj"0,nONE;,nORMAL,fIRE,fIGHTN,wATER,pOISON,eLECTR,gROUND,gRASS,fLYING,iCE,bUG,pSYCIC,rOCK,dRAGON,gHOST,dARK,sTEEL,bIRD",f_zobj"0,______;,pNKbOW,cHRcOL,bLKbLT,mYSwTR,pSNbRB,mAGNET,sOsAND,mIRAsD,sHbEAK,nVRiCE,sLVpWD,tWsPON,hRDsTN,dRAGsC,sPELtG,bLKgLS,mTLcOT,pLKbOW,bRIpWD,fOCbND,kINGrK,lEFToV,qIKcLW,sCOPlN,aMcOIN,lITbAL,lUKpNC,mTLpWD,sTICK,tHKcLB,bERSRK,bERRY,gLDbRY,bTRbRY,mNTbRY,bRNbRY,iCEbRY,pARbRY,pSNbRY,mIRbRY,mYSbRY",f_zobj"0,mISNGnO;,bULSAUR,iVYSAUR,vENSAUR,cHARMAN,cHARMEL,cHARZAR,sQUIRTL,wARTORT,bLSTOIS,cATRPIE,mETAPOD,bUTFREE,wEEDLE,kAKUNA,bEEDRIL,pIDGEY,pIDGETO,pIDGEOT,rATTATA,rATICAT,sPEAROW,fEAROW,eKANS,aRBOK,pIKACHU,rAICHU,sNDSHRW,sNDSLAS,nIDRANf,nIDRINA,nIDQUEN,nIDRANm,nIDRINO,nIDKING,cLFAIRY,cLFABLE,vULPIX,nINTALE,jIGPUFF,wIGTUFF,zUBAT,gOLBAT,oDDISH,gLOOM,vILPLUM,pARAS,pARSECT,vENONAT,vENMOTH,dIGLETT,dUGTRIO,mEOWTH,pERSIAN,pSYDUCK,gOLDUCK,mANKEY,pRIMAPE,gROWLTH,aRCANIN,pOLIWAG,pOLWIRL,pOLRATH,aBRA,kADABRA,aLKAZAM,mACHOP,mACHOKE,mACHAMP,bELSPRT,wEEPBEL,vICTBEL,tNTCOOL,tNTCRUL,gEODUDE,gRAVLER,gOLEM,pONYTA,rAPDASH,sLOWPOK,sLOWBRO,mAGNMIT,mAGNTON,fAFETCd,dODUO,dODRIO,sEEL,dEWGONG,gRIMER,mUK,sHELDER,cLYSTER,gASTLY,hAUNTER,gENGAR,oNIX,dROWZEE,hYPNO,kRABBY,kINGLER,vOLTORB,eLCRODE,eGGCUTE,eGGUTOR,cUBONE,mAROWAK,hITMLEE,hITMCHN,lIKTUNG,kOFFING,wEEZING,rHYHORN,rHYDON,cHANSEY,tANGELA,kANGKAN,hORSEA,sEADRA,gOLDEEN,sEAKING,sTARYU,sTARMIE,mRmIME,sCYTHER,jYNX,eLCABUZ,mAGMAR,pINSIR,tAUROS,mAGKARP,gYARDOS,lAPRAS,dITTO,eEVEE,vAPREON,jOLTEON,fLAREON,pORYGON,oMANYTE,oMASTAR,kABUTO,kABTOPS,aERODAC,sNORLAX,aRTCUNO,zAPDOS,mOLTRES,dRATINI,dRAGAIR,dRAGITE,mEWTWO,mEW,cHIKITA,bAYLEEF,mEGNIUM,cYNDQIL,qUILAVA,tYPHLOS,tOTODIL,cROCNAW,fRLGATR,sENTRET,fURRET,hOOTOOT,nOCTOWL,lEDYBA,lEDIAN,sPINRAK,aRIADOS,cROBAT,cHINCHU,lANTURN,pICHU,cLEFFA,iGGBUFF,tOGEPI,tOGETIC,nATU,xATU,mAREEP,fLAAFFY,aMPHROS,bELOSOM,mARILL,aZMARIL,sUDWOOD,pOLTOED,hOPPIP,sKIPLOM,jUMPLUF,aIPOM,sUNKERN,sUNFLOR,yANMA,wOOPER,qUAGSIR,eSPEON,uMBREON,mURKROW,sLOWKNG,mISDVUS,uNOWN,wOBUFET,gIFARIG,pINECO,fORTRES,dUNSPAR,gLIGAR,sTEELIX,sNUBBUL,gRANBUL,qILFISH,sCIZOR,sHUCKLE,hERCROS,sNEASEL,tEDIURS,uRSRING,sLUGMA,mACARGO,sWINUB,pILSWIN,cORSOLA,rEMRAID,oCTLERY,dELBIRD,mANTINE,sKARMRY,hONDOUR,hONDOOM,kINGDRA,pHANPY,dONPHAN,pORYGN2,sTANTLR,sMEARGL,tYROGUE,hITMTOP,sMOOCHM,eLEKID,mAGBY,mILTANK,bLISSEY,rAIKOU,eNTEI,sUICUNE,lARVTAR,pUPITAR,tYRATAR,lUGIA,hOoH,cELEBI,___,nONE,___,___",f_zobj"0,nEUTER;,mALE,fEMALE",f_zobj"0,______;,fAINT,bURN,fREEZE,pARLYZ,pOISND,sLEEP",f_zobj"0,___;,fNT,bRN,fZN,pAR,pSN,sLP",split"lEARN,tEACH,cHEAT",f_zobj"attack,aTACK,defense,dEFNS,specialattack,sPaTK,specialdefense,sPdFN,speed,sPEED,evasion,eVASN,accuracy,aCURY,crit,cRITL",f_zobj"0;,129,129,13,6,6;;,1,1,140,12,12;;,130,130,136,8,8;;,131,131,3,138,138;;,0,0,8,10,10;;,5,5,134,6,6;;,4,4,9,10,10",f_zobj"0,dUAL;,bLUE,rED,gREEN,hTdOG,sILVR,gOLD",f_zobj"0;,;;,;;,;;,;;,;;,;;,;;,;;,;;,;;,;;,;;,;;,;;,;;,;;,;;,;;,",function()
g_init_peek_loc+=1
return@g_init_peek_loc
end,function(list,ind)
list[ind].lock=true
end,function()
f_unlock(c_items,0+1)
for ind in all(split"0,252,8,104,181,247,236,112,40,111,105,61,235 ")do
f_unlock(c_moves,ind)
end
for i,ind in ipairs(split"1,4,7,152,155,158,252 ")do
f_unlock(c_pokemon,ind)
if@0x5efe==0 then
f_save_party_pkmn(f_mkpkmn(ind,c_pokemon[ind],true,rnd(2)\1,0,5,5,5,5),0,i-1)
end
end
if@0x5efe==0 then
poke(0x5efe,1)
memset(0x5e2a,252,126)
end
for i=1,min(58,@0x5eff)do
local team=f_team_league(i,i==58 and 247)
for pkmn in all(team)do
f_unlock(c_pokemon,pkmn.num)
f_unlock(c_items,pkmn.item+1)
for i=1,4 do
f_unlock(c_moves,pkmn[i].id)
end
end
end
end,function(team,ind)
return setmetatable(f_zobj("spot,@,stages,#",ind),{__index=team[ind]})
end,function(team,name)
local active=nil
for i=1,6 do
if team[i].valid then
active=f_create_active(team,i)
break
end
end
return f_zobj("active,@,team,@,name,@,turnover,~c_no,actions,#",active,team,name)
end,function(team1_name,team2_name,team1,team2)
p_1=f_create_player(team1,team1_name)
p_2=f_create_player(team2,team2_name)
f_set_pself(p_1)
end,function(player)
return player==p_1 and p_2 or p_1
end,function(player)
p_self,p_other=player,f_get_other_pl(player)
end,function(player)
local newteam={}
for i=1,6 do
local pkmn=player.team[(player.active.spot+i-1)%6+1]
if pkmn.valid and pkmn.major ~=1 then
add(newteam,pkmn)
end
end
return newteam
end,function(player)
return f_get_live_pkmn(player)[1]
end,function(player)
f_set_pself(player)
f_pop_ui_stack()
f_pop_ui_stack()
f_pop_ui_stack()
f_add_to_ui_stack(g_grid_battle_results)
end,function(player,message,logic)
return f_zobj("player,@,active,@,message,@,logic,@",player,player.active,message,logic or f_nop)
end,function(player,...)
add(player.actions,f_newaction(...))
end,function(player,pkmn)
local moves={}
foreach(pkmn,function(m)
add(moves,m)
end)
player.active=setmetatable(f_zobj("isactive,~c_yes,lastmoverecv,0,moveturn,0,invisible,~c_yes,counterdmg,0,bidedmg,0,disabledtimer,0,confused,0,sleeping,@,substitute,0,toxiced,0,base,@,mynewmoves,@;stages;attack,0,defense,0,specialattack,0,specialdefense,0,speed,0,crit,0,evasion,0,accuracy,0;",f_flr_rnd"7"+1,pkmn,moves),{__index=pkmn})
return f_newaction(player,"enters,fight",function()
player.active.invisible=false
return player.active.num
end)
end,function()
for player in all{p_first,p_last}do
if player.active.hp<=0 then
if player.active.major ~=1 then
return f_newaction(player,"has fainted",function(_ENV)
selfactive.base.major=1
end)
else
return f_pkmn_comes_out(player,f_get_next_active(player))
end
end
end
for player in all{p_first,p_last}do
local other=f_get_other_pl(player)
while #player.actions>0 do
local action=deli(player.actions,1)
if action.active.major ~=1 and(action.active==player.active or action.active==other.active)then
return action
end
end
if player.active.hp<=0 and player.active.major==1 then
return f_pkmn_comes_out(player,f_get_next_active(player.team))
end
if not player.turnover then
player.turnover=true
return f_postmove_logic(player)
end
end
end,function(self)
return f_newaction(self,false,function()
local statdmg=max(a_self_active.maxhp\16,1)
local inflictstatdmg=function(title)
f_addaction(self,title.." damage")
f_move_setdmg_self(_ENV,statdmg)
end
if a_self_active.major==5 then
if a_self_active.toxiced>0 then
statdmg*=a_self_active.toxiced
a_self_active.toxiced+=1
end
inflictstatdmg"poison"
end
end)
end,function(ind,base,respect_locks,gender_bit,item,...)
local pkmn=f_zobj("num,@,base,@,gender_bit,@,item,@,valid,@,seen_moves,#,major,0,gender,0,evasion,1,accuracy,1,crit,1;stages;attack,0,defense,0,specialattack,0,specialdefense,0,speed,0,crit,0,evasion,0,accuracy,0;",ind,base,gender_bit,item%42,ind<252)
pkmn=setmetatable(pkmn,{__index=base})
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
for spot_num=0,5 do
add(team,f_get_party_pkmn(party_num,spot_num))
end
return team
end,function(team)
local spot=false
for i=6,1,-1 do
if not team[i]then
spot=i
end
end
local pkmn_ind=team.trainer[team.fill_ind]
if spot and pkmn_ind then
local last_move=8
local possible_moves=c_pokemon[pkmn_ind].possible_moves
for i=9,#possible_moves do
if possible_moves[i]==team.trainer.move then
last_move=i
break
end
end
team[spot]=f_mkpkmn(pkmn_ind,c_pokemon[pkmn_ind],false,1,c_pokemon[pkmn_ind].default_item,5,6,7,last_move)
team.fill_ind+=1
end
end,function(trainer_num,fill_ind)
local team={fill_ind=fill_ind or 1,trainer=c_trainers[trainer_num]}
for i=1,6 do
f_fill_team(team)
end
return team
end,function(party_num,spot_num)
local num_loc=0x5e00+party_num*42+spot_num*7
local pkmn_num=min(252,@num_loc)
if pkmn_num<252 and not c_pokemon[pkmn_num].lock then pkmn_num=252 end
local pkmn=f_mkpkmn(pkmn_num,c_pokemon[pkmn_num],true,@(num_loc+1),@(num_loc+2),@(num_loc+3),@(num_loc+4),@(num_loc+5),@(num_loc+6))
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
end,function(_ENV)add(op,{})end,function(_ENV)
for i=0,251 do
local disabled=not c_pokemon[i].lock
add(op,{lrvalid=not disabled,disabled=disabled,draw=function(_,is_sel,gridobj)
f_draw_pkmn(c_pokemon[i].lock and i or 252,1,1,6,false,false,gridobj.disabled,not is_sel)
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
f_draw_pkmn(ind,(ii-1)%3+1+(ii-1)%3*9,1+(ii-1)\3*10,6,false,false,gridobj.disabled,not is_sel)
end
end})
end
end,function(_ENV)
for pkmnnum=0,5 do
local pkmn=f_get_party_pkmn(f_getsel"g_grid_pickedit",pkmnnum)
add(op,{lrvalid=pkmn.valid,draw=function(i,is_sel)
f_draw_pkmn(pkmn.num,1,1,16,false,false,false,not is_sel)
end})
end
end,function(_ENV)
foreach(split"vIEW,eDIT,lEAGUE,vERSUS",function(text)
f_addop_text(op,text)
end)
end,function(_ENV)
add(op,{draw=function()
f_draw_pkmn(c_pokemon[f_getsel"g_grid_browse"].num,30-18+1,20-18+1,32,g_title_sel,false,false,false)
end})
end,function(_ENV)
for i=1,58 do
local disabled=@0x5eff+1<i
add(op,{text=disabled and f_strtoq(c_trnr_names[i])or c_trnr_names[i],disabled=disabled})
end
end,function(_ENV)
local pkmn=f_get_party_pkmn(f_getsel"g_grid_pickedit",f_getsel"g_grid_pickspot")
for i=1,4 do
add(op,{text=c_move_names[pkmn[i].id],select=function()
f_setsel("g_grid_editmove",pkmn[i].pid-1)
f_add_to_ui_stack(g_grid_editmove)
end})
end
f_add_stat_move(preview_op,pkmn,f_getsel"g_grid_editmovebot")
end,function(_ENV)
local pkmn=f_get_party_pkmn(f_getsel"g_grid_pickedit",f_getsel"g_grid_pickspot")
f_add_stat_info(preview_op,pkmn)
add(op,{text="mOVES",select=function()
f_add_to_ui_stack(g_grid_editmovebot)
end})
add(op,{text=c_item_names[pkmn.item],select=function()
f_setsel("g_grid_edititem",pkmn.item)
f_add_to_ui_stack(g_grid_edititem)
end})
add(op,{text=c_gender_names[pkmn.gender],disabled=#pkmn.genders<2,select=function()
pkmn.gender_bit+=1
pkmn:f_save_party_pkmn(f_getsel"g_grid_pickedit",f_getsel"g_grid_pickspot")
f_refresh_top()
end})
add(op,{text="dELETE",select=function()
memset(0x5e00+f_getsel"g_grid_pickedit"*42+f_getsel"g_grid_pickspot"*7,252,7)
f_pop_ui_stack()
end})
end,function(_ENV,op,disabled)
add(op,{text=lock and name or f_strtoq(name),disabled=disabled or not lock})
end,function()return f_get_party_pkmn(f_getsel"g_grid_pickedit",f_getsel"g_grid_pickspot")end,function(_ENV)
local pkmn=f_get_edit_op_pkmn()
for i,num in ipairs(pkmn.possible_moves)do
f_create_spot(c_moves[num],op,pkmn.seen_moves[i])
end
end,function(op,list,key)
local pkmn=f_get_edit_op_pkmn()
for obj in all(list)do
f_create_spot(obj,op,pkmn[key]==obj.num)
end
end,function(_ENV)f_op_template_edit(op,c_items,"item")end,function(op,pkmn,ind)
ind=ind+1
local movenum=pkmn[ind].id
local move=c_moves[movenum]
local pp,pow,acc,typ=f_get_move_texts(move)
local method=pkmn.possible_moves_method[movenum]
add(op,{text="mOVE"..ind.." "..move.name,header=true})
add(op,{text=""..method.." "..typ})
add(op,{text="pWpNT "..pp.."/"..pp})
add(op,{text="pW/aC "..pow.."/"..acc})
end,function(op,pkmn)
add(op,{text="#"..f_prefix_zero(pkmn.num,3).." "..pkmn.name,header=true})
add(op,{text="tYPE1 "..c_type_names[pkmn.type1]})
add(op,{text="tYPE2 "..c_type_names[pkmn.type2]})
add(op,{text="pREVO "..c_pkmn_names[pkmn.prevolve]})
end,function(op,pkmn,is_battle)
local draw_preview=function(off)
f_roundrect(15,off-19,42,off+6,3)
f_draw_pkmn(pkmn.num,21,off-13,16,false,false,false,false)
end
add(op,{header=true,draw=function()draw_preview"18" end})
add(op,{header=true,draw=function()draw_preview"9" end})
add(op,{header=true,draw=function()draw_preview"0" end})
f_add_stat_info(op,pkmn)
if is_battle then
add(op,{text="pKMN sTATE",header=true})
add(op,{text="cOND "..c_major_names_long[pkmn.major]})
add(op,{text="gEND "..c_gender_names[pkmn.gender]})
add(op,{text="iTEM "..c_item_names[pkmn.item]})
end
add(op,{text="pKMN sTATS",header=true})
add(op,{text="hTpNT "..pkmn.hp.."/"..pkmn.maxhp})
for key in all(f_zobj",attack,defense,specialattack,specialdefense,speed")do
local txt=c_statmod_names[key].." "..f_prefix_zero(pkmn[key],3)
local stage=pkmn.stages[key]
txt..=(stage<0 and "-"or "+")..abs(stage)
add(op,{text=txt})
end
for key in all(f_zobj",crit,evasion,accuracy")do
local stage=pkmn.stages[key]
add(op,{text=c_statmod_names[key].." "..stage.."%"})
end
if is_battle then
add(op,{text="pKMN mOVES",header=true})
add(op,{text=f_prefix_space(c_move_names[pkmn[1].id],6).." 20/20"})
add(op,{text=f_prefix_space(c_move_names[pkmn[2].id],6).." 20/20"})
add(op,{text=f_prefix_space(c_move_names[pkmn[3].id],6).." 20/20"})
add(op,{text=f_prefix_space(c_move_names[pkmn[4].id],6).." 20/20"})
end
end,function(_ENV)f_add_stat(op,c_pokemon[f_getsel"g_grid_browse"])end,function(i,is_sel)
local spotstr="sPOT"..(f_getsel"g_grid_pickspot"+1)
f_print_top("eDIT ",spotstr)
local pkmn=f_get_party_pkmn(f_getsel"g_grid_pickedit",f_getsel"g_grid_pickspot")
f_print_bot("#",pkmn.num_str," ",pkmn.name)
end,function(i,is_sel)
local prefix="eDIT"
local pkmn=f_get_party_pkmn(f_getsel"g_grid_pickedit",f_getsel"g_grid_pickspot")
local spotstr="sPOT"..(f_getsel"g_grid_pickspot"+1)
if f_getsel"g_grid_editstat"==0 then f_print_top("vIEW: "..spotstr)
elseif f_getsel"g_grid_editstat"==1 then f_print_top("eDIT iTEM")
elseif f_getsel"g_grid_editstat"==6 then f_print_top(prefix," iTEM")
elseif f_getsel"g_grid_editstat"==7 then f_print_top(prefix," gENDER")
else f_print_top(prefix," mOVE",f_getsel"g_grid_editstat"-1)
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
local pp,pow,acc,typ=f_prefix_zero(move.pp,2),f_prefix_zero(move.pow,3),f_prefix_zero(move.acc,3),c_type_names[move.type]
if move.pow==0 then pow="___"
elseif move.pow==1 then pow="var" end
if move.acc==0 then acc="___" end
if move.num==252 then
typ,pp,pow,acc="______","__","___","___"
elseif not move.lock then
pp,pow,acc,typ=f_strtoq(pp),f_strtoq(pow),f_strtoq(acc),f_strtoq(typ)
end
return pp,pow,acc,typ
end,function(move,method)
local pp,pow,acc,typ=f_get_move_texts(move)
local ind=f_getsel"g_grid_editmovebot"+1
f_print_top("eDIT mOVE"..ind)
f_print_bot(method..": "..typ)
end,function()
local pkmn=f_get_party_pkmn(f_getsel"g_grid_pickedit",f_getsel"g_grid_pickspot")
local movenum=pkmn.possible_moves[f_getsel"g_grid_editmove"+1]
local move=c_moves[movenum]
f_dt_editmove_template(move,pkmn.possible_moves_method[movenum])
end,function()
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
local namestr=pkmn.name
if not pkmn.lock then
namestr=f_strtoq(namestr)
end
f_print_top("vIEW ",namestr)
f_print_bot("pICODEX #",f_prefix_zero(pkmn.num,3))
end,function()
f_dt_browse_template(f_getsel"g_grid_browse")
end,function()
local pkmn=c_pokemon[f_getsel"g_grid_editpkmn"]
local namestr=pkmn.name
if not pkmn.lock then
namestr=f_strtoq(namestr)
end
local spotstr="sPOT"..(f_getsel"g_grid_pickspot"+1)
f_print_top("eDIT ",spotstr)
f_print_bot("#",f_prefix_zero(pkmn.num,3)," ",namestr)
end,function()
local pkstr_arr={}
local pkstr_lens=split"2,2,2,2,1,1"
for ii=0,5 do
local pkmn=f_get_party_pkmn(f_getsel"g_grid_pickedit",ii)
add(pkstr_arr,sub(c_pkmn_names[pkmn.num],1,pkstr_lens[ii+1]))
end
f_print_top("eDIT tEAM",f_getsel"g_grid_pickedit"+1)
f_print_bot(pkstr_arr[1],"-",pkstr_arr[2],"-",pkstr_arr[3],"-",pkstr_arr[4],"-",pkstr_arr[5],pkstr_arr[6])
end,function()
local toggle=g_cg_m.name=="g_grid_pickleag"
local disabled=@0x5eff+1<f_getsel"g_grid_picktrnr"+1
local name=c_trnr_names[f_getsel"g_grid_picktrnr"+1]
name=disabled and f_strtoq(name)or name
f_print_top(toggle and "\f4"or "\f2","pLAYER tEAM",f_getsel"g_grid_pickleag"+1)
f_print_bot(toggle and "\f2"or "\f4","cOMPTR ",name)
end,function()
local ind=f_getsel"g_grid_battle_stats"
local player=ind<6 and p_self or p_other
local name=c_trnr_names[f_getsel"g_grid_picktrnr"+1]
local pkmn=player.team[ind%6+1]
f_print_bot(player.name," sPOT",ind%6+1)
f_print_top("vIEW ",pkmn.name)
end,function()
local ind=f_getsel"g_grid_battle_switch"
local name=c_trnr_names[f_getsel"g_grid_picktrnr"+1]
local pkmn=p_self.team[ind%6+1]
f_print_top("sWAP ",pkmn.name)
local player=ind<6 and p_self or p_other
f_print_bot(player.name," sPOT",ind%6+1)
end,function()
local toggle=g_cg_m.name=="g_grid_pickplr1"
f_print_top(toggle and "\f4"or "\f2","pLAYR1 tEAM",f_getsel"g_grid_pickplr1"+1)
f_print_bot(toggle and "\f2"or "\f4","pLAYR2 tEAM",f_getsel"g_grid_pickplr2"+1)
end,function()
print("\^w\^tpicodex",2,1,4)
print(c_palette_names[g_palette].." vERSION",2,12,2)
f_draw_pkmn(g_title_l,7,20,16,false,false,false,g_title_sel)
f_draw_pkmn(g_title_r,35,20,16,true,false,false,not g_title_sel)
end,function(x1,y1,x2,y2,c)
rectfill(x1,y1+1,x2,y2-1,c)
if x2-x1>2 then
rectfill(x1+1,y1,x2-1,y2,c)
end
end,function(op)
local b=function(_ENV,team,x,y,px,py,flip)
f_roundrect(x-1+1,y+1-6+1,x+35-1,y+6+6+1,3)
if hp>0 then
rectfill(x+1,y+3,x+1+mid(0,hp/maxhp*32,32),y+6,2)
pset(x+1,y+3,3)
pset(x+1,y+6,3)
pset(x+33,y+3,3)
pset(x+33,y+6,3)
end
local tx,ty=x+15,y+9
for i=0,5 do
if team[i+1].valid and team[i+1].major ~=1 then
pset(tx+i%3*2,ty+i\3*2-1+1,spot==i+1 and 4 or 2)
end
if i ~=1 then
end
end
print(name,x+2,y-5+1+1,2,-1)
print(c_major_names_short[major].."  "..f_prefix_zero(hp,3),x+1+1,y+8-1+1,2,-1)
f_draw_pkmn(num,px,py,16,flip,false,false,p_self.active ~=_ENV)
end
add(op,{draw=function()b(p_2.active,p_2.team,0,4,39,1,true)end})
add(op,{draw=function()b(p_1.active,p_1.team,23,4,3,1)end})
end,function(_ENV)
add(op,{text="fIGHT",select=function()
f_add_to_ui_stack(g_grid_battle_movesel)
end})
add(op,{text="sWAP",select=function()
f_add_to_ui_stack(g_grid_battle_switch)
end})
add(op,{text="vIEW",select=function()
f_add_to_ui_stack(g_grid_battle_stats)
end})
add(op,{text="rUN",select=function()
f_end_battle(p_self)
end})
f_add_battle(preview_op)
end,function(_ENV)
for i=1,4 do
add(op,{text=c_move_names[p_self.active[i].id]})
end
f_add_stat_move(preview_op,p_self.active,f_getsel"g_grid_battle_movesel")
end,function(_ENV)
for i=1,6 do
local pkmn=p_self.team[i]
local disabled=not pkmn.valid or i==p_self.active.spot or pkmn.major==1
add(op,{disabled=disabled,draw=function(i,is_sel)
f_draw_pkmn(pkmn.num,1,1,16,p_self==p_2,false,disabled,not disabled and not is_sel)
end})
end
end,function()
g_preview_timer=20
return p_other.team[f_getsel"g_grid_battle_results"+1].num
end,function(_ENV)
for i=1,6 do
local pkmn=p_other.team[i]
local disabled=not pkmn.valid or pkmn.major==1
add(op,{disabled=disabled,draw=function(i,is_sel)
f_draw_pkmn(pkmn.num,1,1,16,false,false,disabled,not disabled and not is_sel)
end})
end
add(preview_op,{draw=function()
f_print_top("cHAMP "..p_other.name)
f_print_bot("lOSER "..p_self.name)
end})
end,function(_ENV)
for i=1,6 do
local pkmn=p_self.team[i]
local disabled=not pkmn.valid
add(op,{lrvalid=not disabled,disabled=disabled,draw=function(i,is_sel)
f_draw_pkmn(pkmn.num,1,1,16,false,false,disabled,not disabled and not is_sel)
end})
end
for i=1,6 do
local pkmn=p_other.team[i]
local disabled=not pkmn.valid
add(op,{lrvalid=not disabled,disabled=disabled,draw=function(i,is_sel)
f_draw_pkmn(pkmn.num,1,1,16,false,false,disabled,not disabled and not is_sel)
end})
end
end,function()
f_pop_ui_stack()
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
g_title_sel=not g_title_sel
return f_getsel"g_grid_browse"
end,function()
g_preview_timer=20
g_title_sel=not g_title_sel
return f_get_party_pkmn(f_getsel"g_grid_pickedit",f_getsel"g_grid_pickspot").num
end)
f_zobj_set(_g,"f_s_versus,@,f_s_league,@,f_op_statbattle,@,f_s_batstat,@,f_s_statbat,@,f_s_versusbegin,@,f_s_batbegin,@,f_s_edit,@,f_s_editteam,@,f_s_editpkmn,@,f_s_editstat,@,f_s_editmovebot,@,f_s_battle,@,f_s_editmove,@,f_s_edititem,@,f_l_title,@,f_l_battle,@,f_s_batmove,@,f_op_bataction,@,f_s_bataction,@,f_l_bataction,@,f_strtoq,@,f_loop_through_team_pkmn,@,_update,@,_draw,@",function()
f_add_to_ui_stack(g_grid_pickplr2)
end,function()
f_add_to_ui_stack(g_grid_picktrnr)
end,function(_ENV)
local bothteams={}
for i=1,6 do add(bothteams,p_self.team[i])end
for i=1,6 do add(bothteams,p_other.team[i])end
f_add_stat(op,bothteams[f_getsel"g_grid_battle_stats"+1],true)
end,function()
f_add_to_ui_stack(g_grid_statbattle)
end,function()
g_preview_timer=20
g_title_sel=not g_title_sel
local bothteams={}
for i=1,6 do add(bothteams,p_self.team[i])end
for i=1,6 do add(bothteams,p_other.team[i])end
return bothteams[f_getsel"g_grid_battle_stats"+1].num
end,function()
f_start_battle("pLAYR1","pLAYR2",f_team_party(f_getsel"g_grid_pickplr1"),f_team_party(f_getsel"g_grid_pickplr2"))
f_add_to_ui_stack(g_grid_battle_select)
end,function()
f_start_battle("pLAYER",c_trnr_names[f_getsel"g_grid_picktrnr"+1],f_team_party(f_getsel"g_grid_pickleag"),f_team_league(f_getsel"g_grid_picktrnr"+1))
f_add_to_ui_stack(g_grid_battle_select)
end,function()
f_add_to_ui_stack(g_grid_pickspot)
end,function()
f_add_to_ui_stack(f_get_party_pkmn(f_getsel"g_grid_pickedit",f_getsel"g_grid_pickspot").valid and g_grid_editstat or g_grid_editpkmn)
end,function()
f_save_party_pkmn(f_mkpkmn(f_getsel"g_grid_editpkmn",c_pokemon[f_getsel"g_grid_editpkmn"],true,rnd(2)\1,0,5,6,7,8),f_getsel"g_grid_pickedit",f_getsel"g_grid_pickspot")
f_pop_ui_stack()
end,function()gridpo[f_getsel"g_grid_editstat"+1].select()end,function()gridpo[f_getsel"g_grid_editmovebot"+1].select()end,function()
gridpo[f_getsel"g_grid_battle_select"+1].select()
end,function()
local pkmn=f_get_party_pkmn(f_getsel"g_grid_pickedit",f_getsel"g_grid_pickspot")
pkmn[f_getsel"g_grid_editmovebot"+1].pid=f_getsel"g_grid_editmove"+1
f_save_party_pkmn(pkmn,f_getsel"g_grid_pickedit",f_getsel"g_grid_pickspot")
f_pop_ui_stack()
end,function()
local pkmn=f_get_party_pkmn(f_getsel"g_grid_pickedit",f_getsel"g_grid_pickspot")
pkmn.item=f_getsel("g_grid_edititem")
f_save_party_pkmn(pkmn,f_getsel"g_grid_pickedit",f_getsel"g_grid_pickspot")
f_pop_ui_stack()
end,function()
g_title_sel=not g_title_sel
if g_title_sel then
g_title_r=rnd"252"\1 return g_title_r
else
g_title_l=rnd"252"\1 return g_title_l
end
g_palette+=1
g_palette%=#c_palettes
end,function()return p_self.active.num end,function()
f_addaction(p_self,p_self,"uSES vINwHP",f_nop)
f_addaction(p_other,p_other,"uSES hYPfNG",f_nop)
p_first=p_self
p_last=p_other
f_pop_ui_stack()
f_pop_ui_stack()
f_add_to_ui_stack(g_grid_battle_actions)
f_s_bataction()
end,function(_ENV)
add(op,{draw=function()
f_print_top(p_self.name," ",p_self.active.name)
f_print_bot(g_bat_msg)
end})
f_add_battle(preview_op)
end,function()
while true do
for player in all{p_first,p_last}do
if not f_get_next_active(player)then
f_end_battle(player)
return
end
end
local action=f_pop_next_action()
if action then
f_set_pself(action.player)
a_self_active,a_other_active=p_self.active,p_other.active
a_addaction=function(...)f_addaction(action.player,...)end
action.logic(envparams)
if action.message then
g_bat_msg=action.message
return
end
else
f_set_pself(p_1)
f_pop_ui_stack()
f_add_to_ui_stack(g_grid_battle_select)
return
end
end
end,function()
return p_self.active.num
end,function(s)
local ns=""
for i=1,#s do ns..="?" end
return ns
end,function(party_num,callback)
for ii=0,5 do
local party_loc=0x5e00+party_num*42
local pkmn_ind=@(party_loc+ii*7)
callback(c_pokemon[pkmn_ind].lock and pkmn_ind,ii)
end
end,function()
if t()>=1.5 then
if g_title_timer==0 then
f_minisfx(254)
end
g_title_timer=min(6,(g_title_timer+1))
end
g_preview_timer=max(0,g_preview_timer-1)
top_grid=g_gridstack[#g_gridstack]
g_cg_m=top_grid.g_cg_m
g_cg_s=top_grid.g_cg_s
gridpofunc=top_grid.gridpofunc
params=top_grid.params
gridpo=top_grid.op
grid_previewop=top_grid.preview_op
if g_title_timer==6 then
f_update_grid(g_cg_m,gridpo,top_grid)
end
end,function()
cls"1 "
if g_title_timer<6 then
print("\^y7\f4aLANxOC3\n\f3pRESENTS",16,26)
for i=1,6 do
if.5<<i & btn()>0 then
g_palette=i
end
end
end
local var=1-min(6,g_title_timer)/6
local easing=var*var
if g_cg_m then
f_draw_grid(g_cg_m,gridpo,g_cg_m.sel,g_cg_m.view,g_cg_m.x,g_cg_m.y+easing*24,true)
f_draw_grid(g_cg_s,#grid_previewop>0 and grid_previewop or{{draw=g_cg_s.df}},-1,0,g_cg_s.x,g_cg_s.y-easing*45)
end
pal(c_palettes[g_palette],1)
g_shake_timer=(g_shake_timer+1)%4
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
g_cur_pkmn_cry=nil
f_zcall(poke,";,0x5f2c,3;;,0x5f5c,8;;,0x5f5d,1;;,0x5eff,58")
cls()
for i=0,360 do
c_types[i\19][i%19]=f_init_peek_inc()\2
end
for i=0,41 do add(c_items,f_zobj("lock,~c_no,num,@,name,@",i,c_item_names[i]))end
for i=0,252 do
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
pkmn.maxhp=pkmn.hp
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
for i=0,252 do
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
for i=0,252 do
c_pokemon[i].possible_moves=f_zobj",252,252,252,252"
c_pokemon[i].possible_moves_method=f_zobj"252,eMPTY"
for ii=1,3 do
foreach(c_pokemon[i].moves_grouped[ii],function(v)
add(c_pokemon[i].possible_moves,v)
c_pokemon[i].possible_moves_method[v]=c_movemethod_names[ii]
end)
end
c_pokemon[i]=f_mkpkmn(i,c_pokemon[i],false,0,0)
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
g_bat_msg=""
g_bat_func=nil
f_zcall(f_create_gridpair,"top_browse;,6,4,2,2,10,10;top_edit;,2,2,2,2,30,20;top_editteam;,3,2,2,2,20,20;top_pkstat;,1,4,2,4,60,9;top_pkstatbig;,1,6,2,5,60,9;top_text_grid;,2,4,2,4,30,9;top_title;,1,1,2,2,60,40;top_battle;,1,1,2,2,60,40;top_battle2;,1,2,2,2,60,20;bot_4x4;,2,2,2,44,30,9;bot_info;,1,1,2,45,60,16;bot_ignore;,1,1,2,200,60,16;top_newstat;,1,6,2,4,60,9;;,g_grid_title,~bot_4x4,~top_title,~f_dp_title,~f_op_title,~f_s_title,~f_l_title,~c_no;;,g_grid_browse,~top_browse,~bot_info,~f_dt_browse,~f_op_browse,~f_s_browse,~f_l_browse,~c_no;;,g_grid_editpkmn,~top_browse,~bot_info,~f_dt_editpkmn,~f_op_browse,~f_s_editpkmn,~f_l_browse,~c_no;;,g_grid_previewpkmn,~top_title,~bot_info,~f_dt_browse,~f_op_prevpk,~f_s_pkstat,~f_l_browse,g_grid_browse;;,g_grid_statbrowse,~top_pkstat,~bot_info,~f_dt_browse,~f_op_statbrowse,~f_s_pkstat,~f_l_browse,g_grid_browse;;,g_grid_statbattle,~top_pkstat,~bot_info,~f_dt_batstats,~f_op_statbattle,~f_s_statbat,~f_l_browse,g_grid_battle_stats;;,g_grid_editstat,~bot_4x4,~top_pkstat,~f_nop,~f_op_editstat,~f_s_editstat,~f_l_browse,~c_no;;,g_grid_editmovebot,~bot_4x4,~top_pkstat,~f_nop,~f_op_editmovebot,~f_s_editmovebot,~f_l_browse,~c_no;;,g_grid_editmove,~top_text_grid,~bot_info,~f_dt_editmove,~f_op_editmove,~f_s_editmove,~f_l_browse,~c_no;;,g_grid_edititem,~top_text_grid,~bot_info,~f_dt_editstat,~f_op_edititem,~f_s_edititem,~f_l_browse,~c_no;;,g_grid_pickedit,~top_edit,~bot_info,~f_dt_edit,~f_op_edit,~f_s_edit,~f_l_browse,~c_no;;,g_grid_pickleag,~top_edit,~bot_info,~f_dt_league,~f_op_edit,~f_s_league,~f_l_browse,~c_no,~c_yes;;,g_grid_pickplr1,~top_edit,~bot_info,~f_dt_versus,~f_op_edit,~f_s_versus,~f_l_browse,~c_no,~c_yes;;,g_grid_pickplr2,~top_edit,~bot_info,~f_dt_versus,~f_op_edit,~f_s_versusbegin,~f_l_browse,~c_no,~c_yes;;,g_grid_pickspot,~top_editteam,~bot_info,~f_dt_editteam,~f_op_editteam,~f_s_editteam,~f_l_browse,~c_no;;,g_grid_picktrnr,~top_text_grid,~bot_info,~f_dt_league,~f_op_teams,~f_s_batbegin,~f_l_browse,~c_no;;,g_grid_battle_select,~bot_4x4,~top_battle2,~f_nop,~f_op_batsel,~f_s_battle,~f_l_battle,~c_no;;,g_grid_battle_movesel,~bot_4x4,~top_pkstat,~f_nop,~f_op_movesel,~f_s_batmove,~f_l_browse,~c_no;;,g_grid_battle_switch,~top_editteam,,~bot_info,~f_dt_switch,~f_op_batswitch,~f_nop,~f_l_browse,~c_no;;,g_grid_battle_stats,~top_editteam,,~bot_info,~f_dt_batstats,~f_op_batstats,~f_s_batstat,~f_l_browse,~c_no;;,g_grid_battle_results,~top_editteam,~bot_info,~f_nop,~f_op_batresults,~f_s_batresults,~f_l_browse,~c_no;;,g_grid_battle_actions,~bot_info,~top_battle2,~f_nop,~f_op_bataction,~f_s_bataction,~f_l_bataction,~c_no")
g_gridstack={}
f_add_to_ui_stack(g_grid_title)
sfx"63"
g_shake_timer=0