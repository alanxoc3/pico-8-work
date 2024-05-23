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
f_zobj_set(_g,"f_zobj,@,f_zobj_set,@,f_zobj_eval,@,f_zcall,@,f_refresh_top,@,f_add_to_ui_stack,@,f_pop_ui_stack,@,f_getsel,@,f_setsel,@,f_create_gridpair,@,f_update_grid,@,f_draw_grid,@,f_addop_text,@,f_minisfx,@,f_draw_pkmn,@,c_move_names,@,c_trnr_names,@,c_type_names,@,c_item_names,@,c_pkmn_names,@,c_gender_names,@,c_movemethod_names,@,c_palettes,@,c_palette_names,@,c_types,@,f_init_peek_inc,@,f_unlock,@,f_update_locks,@,f_create_active,@,f_create_player,@,f_start_battle,@,f_mkpkmn,@,f_team_party,@,f_team_league,@,f_get_party_pkmn,@,f_save_party_pkmn,@,f_op_def,@,f_op_browse,@,f_op_edit,@,f_op_editteam,@,f_op_title,@,f_op_teams,@,f_op_editstat,@,f_create_spot,@,f_get_edit_op_pkmn,@,f_op_editmove,@,f_op_template_edit,@,f_op_edititem,@,f_add_stat_move,@,f_add_stat,@,f_op_statbrowse,@,f_op_statedit,@,f_dt_editteam,@,f_dt_editstat,@,f_print_top,@,f_print_bot,@,f_get_move_texts,@,f_dt_editmove_template,@,f_dt_editmove,@,f_prefix_space,@,f_prefix_zero,@,f_dt_browse_template,@,f_dt_browse,@,f_dt_editpkmn,@,f_dt_edit,@,f_dt_league,@,f_dt_batstats,@,f_dt_switch,@,f_dt_versus,@,f_dp_title,@,f_op_batsel,@,f_op_movesel,@,f_op_batswitch,@,f_s_batresults,@,f_op_batresults,@,f_op_batstats,@,f_l_browse,@,f_s_browse,@,f_s_title,@,f_s_pkstat,@,f_s_statedit,@,f_s_versus,@,f_s_league,@,f_op_statbattle,@,f_s_batstat,@,f_s_statbat,@,f_s_versusbegin,@,f_s_batbegin,@,f_s_edit,@,f_s_editteam,@,f_s_editpkmn,@,f_s_editstat,@,f_s_battle,@,f_s_editmove,@,f_s_edititem,@,f_l_title,@,f_l_battle,@,f_strtoq,@,f_nf,@,f_loop_through_team_pkmn,@",f_zobj,f_zobj_set,f_zobj_eval,function(func,text,...)
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
sel=evalfunc(sel,sel%w,(#gridobj-1)\w*w,btnp"2",btnp"3",w)
if sel ~=prevsel then
f_refresh_top()
end
if sel\w-vh+1>view then view=sel\w-vh+1 end
if sel\w<view then view=sel\w end
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
end,f_zobj"0,______;,aCID,aCIDaR,bARAGE,bONcLB,bIND,cLAMP,mOONlT,lECHsD,eXTRsP,sNCbOM,tWInDL,tHNsHK,gLARE,gILOTN,hYPfNG,jMPkCK,kINSIS,lOCKoN,lOVkIS,mACpNC,vICgRP,sPIcAN,sPIKES,sPORE,cOTsPR,pRESNT,vItHRW,cMTpNC,dRLpCK,sNDaTK,aGILTY,fRYaTK,qIKaTK,fALsWP,gROWL,hEALbL,sING,pOUND,mINMIZ,tAILwP,dBLsLP,mEGhRN,bONRNG,cONVR1,cONVR2,sPARK,mLKdRK,mORsUN,nGTsHD,oCTZOK,pINmIS,pWDsNW,sUPfNG,fIRsPN,pSNgAS,bARIER,mEDTAT,fTRsGT,hYPNOS,pSYbEM,lITsCR,sAFgRD,pETdNC,cHARM,sYNTHS,sWTsCN,rAZlEF,pSNpWD,sLPpWD,aBSORB,sTNsPR,fLAIL,cONFSN,sLAM,cONSTR,aMNESA,bUBBLE,sPLASH,hYDpMP,mNDrED,mIST,hRNaTK,sPIwEB,dBLkCK,sWTkIS,mTLcLW,tRFORM,tRIKCK,gUST,tWISTR,cRBhAM,dIZpNC,sLUDGE,pAINsP,dSTbND,hAZE,lICK,pERsNG,mEANlK,cNFrAY,cRScHP,sMOG,kARcHP,eMBER,sMKsCR,bELdRM,bEATUP,sCRTCH,sLASH,aNCpWR,lEER,bITE,oUTrGE,sCRYfC,tHRASH,sTOMP,rOKsLD,mAGTUD,rOCtHR,hARDEN,bONrSH,hIJkCK,rECOVR,aERbLS,hRNdRL,dRGrAG,sFbOIL,dRGbRE,sLFdES,eXPLSN,eGGbMB,sLGbMB,gIGdRN,mEGdRN,sWRdNC,cUT,fRYcTR,tHIEF,dIG,rOLOUT,dFNcRL,dETECT,sOLbEM,rAIdNC,fLASH,pSYCIC,pSYCuP,dRMeAT,nGTMAR,sHDbAL,zAPcAN,tHUNDR,tHNbLT,iRNtAL,sTRENG,rOCsMS,hEDbUT,mUDsLP,sUNdAY,pROTCT,dBLtEM,sLPtLK,cURSE,hIDpWR,sWAGER,fRUSTR,rETURN,tOXIC,sNORE,rEST,eNDURE,aTRACT,bIDE,mIMIC,sUBSTU,rAGE,dBLeDG,tAKdWN,sKLbAS,bODsLM,wTRgUN,bBLbEM,iCEbEM,bLIZRD,iCYwND,sURF,wRLPOL,wTRFAL,sWIFT,pAYDAY,tRIaTK,rFLECT,tHNwAV,tELPRT,pSYwAV,mETRNM,cOUNTR,mEGpNC,sEITOS,sUBMIS,mEGkCK,dYNpNC,fIRpNC,tHNpNC,iCEpNC,fIRbLS,fLMtHR,fISURE,eARTqK,sNDsTR,hYPbEM,rOAR,sTLwNG,fLY,rAZwND,wRLwND,sKYaTK,wNGaTK,pECK,mIRMOV,fNTaTK,wITdRW,rAPsPN,sUPsNC,aURbEM,mIRcOT,pSNsTG,sPITE,cRUNCH,pURSUT,sTRsHT,lECHlF,bTNpAS,dISABL,sCRECH,tACKLE,fLMwEL,rEVRSL,fRYsWP,fCSeNG,fORsGT,lOWkCK,rOLkCK,eNCORE,wRAP,gROWTH,vINwHP,sACfIR,sHRPEN,sKETCH,tM05,sTRUGL,nONE,nONE,nONE",split"yOUNGS,sAGE,fALKNR,gRUNT,bUGcTR,bUGSY,pKMfAN,bEAUTY,wITNEY,kIMINO,mEDIUM,mORTY,pOLICE,kARATE,cHUCK,gENTLE,sAILOR,jASMIN,rOCKET,sKIER,pRYCE,sCIENT,tWINS,cLAIR,nERD,cAMPER,bROCK,sCHOOL,sWIMER,mISTY,jUGLER,gUITAR,lTsURG,hIKER,lASS,eRIKA,bIKER,pICNIK,jANINE,mANIAC,pSYCIC,sABRIN,fISHER,bREATH,bLAINE,bIRDkP,cOOLtR,bLUE,lEGEND,sILVER,wILL,kOGA,bRUNO,kAREN,lANCE,rED,gOLD,hORDE",split"bIRD,nORMAL,fIRE,fIGHTN,wATER,pOISON,eLECTR,gROUND,gRASS,fLYING,iCE,bUG,pSYCIC,rOCK,dRAGON,gHOST,dARK,sTEEL,nONE",f_zobj"0,nONE;,pNKbOW,cHRcOL,bLKbLT,mYSwTR,pSNbRB,mAGNET,sOsAND,mIRAsD,sHbEAK,nVRiCE,sLVpWD,tWsPON,hRDsTN,dRAGsC,sPELtG,bLKgLS,mTLcOT,pLKbOW,bRIpWD,fOCbND,kINGrK,lEFToV,qIKcLW,sCOPlN,aMcOIN,lITbAL,lUKpNC,mTLpWD,sTICK,tHKcLB,bERSRK,bERRY,gLDbRY,bTRbRY,mNTbRY,bRNbRY,iCEbRY,pARbRY,pSNbRY,mIRbRY,mYSbRY",f_zobj"0,mISINGNO;,bULBSAUR,iVYSAUR,vENUSAUR,cHARMAND,cHARMELN,cHARZARD,sQUIRTLE,wARTORTL,bLASTOIS,cATERPIE,mETAPOD,bUTRFREE,wEEDLE,kAKUNA,bEEDRILL,pIDGEY,pIDGEOTO,pIDGEOT,rATTATA,rATICATE,sPEAROW,fEAROW,eKANS,aRBOK,pIKACHU,rAICHU,sNDSHREW,sNDSLASH,nIDORANF,nIDORINA,nIDOQUEN,nIDORANM,nIDORINO,nIDOKING,cLEFAIRY,cLEFABLE,vULPIX,nINETALE,jIGLYPUF,wIGLYTUF,zUBAT,gOLBAT,oDDISH,gLOOM,vILEPLUM,pARAS,pARASECT,vENONAT,vENOMOTH,dIGLETT,dUGTRIO,mEOWTH,pERSIAN,pSYDUCK,gOLDUCK,mANKEY,pRIMEAPE,gROWLITH,aRCANINE,pOLIWAG,pOLWHIRL,pOLWRATH,aBRA,kADABRA,aLAKAZAM,mACHOP,mACHOKE,mACHAMP,bELSPROT,wEEPNBEL,vICTRBEL,tNTACOOL,tNTCRUEL,gEODUDE,gRAVELER,gOLEM,pONYTA,rAPIDASH,sLOWPOKE,sLOWBRO,mAGNEMIT,mAGNETON,fAFETCHd,dODUO,dODRIO,sEEL,dEWGONG,gRIMER,mUK,sHELLDER,cLOYSTER,gASTLY,hAUNTER,gENGAR,oNIX,dROWZEE,hYPNO,kRABBY,kINGLER,vOLTORB,eLECTROD,eXEGCUTE,eXEGUTOR,cUBONE,mAROWAK,hITMNLEE,hITMNCHN,lICKTUNG,kOFFING,wEEZING,rHYHORN,rHYDON,cHANSEY,tANGELA,kANGAKAN,hORSEA,sEADRA,gOLDEEN,sEAKING,sTARYU,sTARMIE,mRmIME,sCYTHER,jYNX,eLECABUZ,mAGMAR,pINSIR,tAUROS,mAGIKARP,gYARADOS,lAPRAS,dITTO,eEVEE,vAPOREON,jOLTEON,fLAREON,pORYGON,oMANYTE,oMASTAR,kABUTO,kABUTOPS,aERODACT,sNORLAX,aRTICUNO,zAPDOS,mOLTRES,dRATINI,dRAGNAIR,dRAGNITE,mEWTWO,mEW,cHIKRITA,bAYLEEF,mEGANIUM,cYNDQUIL,qUILAVA,tYPHLOSN,tOTODILE,cROCONAW,fRALGATR,sENTRET,fURRET,hOOTHOOT,nOCTOWL,lEDYBA,lEDIAN,sPINARAK,aRIADOS,cROBAT,cHINCHOU,lANTURN,pICHU,cLEFFA,iGGLYBUF,tOGEPI,tOGETIC,nATU,xATU,mAREEP,fLAAFFY,aMPHAROS,bELOSSOM,mARILL,aZUMARIL,sUDWOODO,pOLITOED,hOPPIP,sKIPLOOM,jUMPLUFF,aIPOM,sUNKERN,sUNFLORA,yANMA,wOOPER,qUAGSIRE,eSPEON,uMBREON,mURKROW,sLOWKING,mISDRVUS,uNOWN,wOBBUFET,gIRAFRIG,pINECO,fORETRES,dUNSPARC,gLIGAR,sTEELIX,sNUBBULL,gRANBULL,qWILFISH,sCIZOR,sHUCKLE,hERACROS,sNEASEL,tEDIURSA,uRSARING,sLUGMA,mAGCARGO,sWINUB,pILOSWIN,cORSOLA,rEMORAID,oCTILERY,dELIBIRD,mANTINE,sKARMORY,hOUNDOUR,hOUNDOOM,kINGDRA,pHANPY,dONPHAN,pORYGON2,sTANTLER,sMEARGLE,tYROGUE,hITMNTOP,sMOOCHUM,eLEKID,mAGBY,mILTANK,bLISSEY,rAIKOU,eNTEI,sUICUNE,lARVITAR,pUPITAR,tYRNITAR,lUGIA,hOoH,cELEBI,___,nONE,___,___",f_zobj"0,nEUTER;,mALE,fEMALE",split"lEARN,tEACH,eVENT",f_zobj"0;,129,129,13,6,6;;,1,1,140,12,12;;,130,130,136,8,8;;,131,131,3,138,138;;,0,0,8,10,10;;,5,5,134,6,6;;,4,4,9,10,10",f_zobj"0,dUAL;,bLUE,rED,gREEN,hTdOG,sILVR,gOLD",f_zobj"0;,;;,;;,;;,;;,;;,;;,;;,;;,;;,;;,;;,;;,;;,;;,;;,;;,;;,",function()
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
return f_zobj("active,@,team,@,name,@",active,team,name)
end,function(team1_name,team2_name,team1,team2)
p1=f_create_player(team1,team1_name)
p2=f_create_player(team2,team2_name)
p0=p1
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
for spot_num=0,5 do
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
f_setsel("g_grid_editmove",pkmn[i].pid-1)
f_add_to_ui_stack(g_grid_editmove)
end})
end
add(op,{text=c_item_names[pkmn.item],select=function()
f_setsel("g_grid_edititem",pkmn.item)
f_add_to_ui_stack(g_grid_edititem)
end})
add(op,{text=c_gender_names[pkmn.gender],disabled=#pkmn.genders<2,select=function()
pkmn.gender_bit+=1
pkmn:f_save_party_pkmn(f_getsel"g_grid_pickedit",f_getsel"g_grid_pickspot")
f_refresh_top()
end})
add(op,{text="vIEW",select=function()
f_add_to_ui_stack(g_grid_statedit)
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
local m=pkmn[ind]
local pp,pow,acc,typ=f_get_move_texts(c_moves[m.id])
add(op,{text="mOVE"..ind..": "..c_move_names[m.id],header=true})
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
local draw_preview=function(off)
f_draw_pkmn(pkmn.num,2-8-20+30,-8+1-10-1-1+6+3-3-off,16)
rectfill(-9+4+30,-18-off-1,-9+4+30,6-off+1,2)
end
add(op,{text="#"..f_prefix_zero(pkmn.num,3).." "..pkmn.name,header=true})
add(op,{text="       tYPE:",draw=function()draw_preview(-18)end})
add(op,{text="        "..c_type_names[pkmn.type1+1],draw=function()draw_preview(-9)end})
local t2text="        "
if pkmn.type2 ~=0 then
t2text..=c_type_names[pkmn.type2+1]
end
add(op,{text=t2text,draw=function()draw_preview(0)end})
add(op,{text="pOKEMON iNFO",header=true})
if mode>=2 then
add(op,{text="mAJR: nONE"})
end
if mode>=1 then
add(op,{text="iTEM: "..c_item_names[pkmn.item]})
end
add(op,{text="hITp: "..pkmn.hp.."/"..pkmn.hp})
add(op,{text="gEND: "..genders})
add(op,{text="pREV: "..c_pkmn_names[pkmn.prevolve]})
add(op,{text="pOKEMON sTATS",header=true})
for stat in all(f_zobj";name,aTACK,key,attack;;name,dEFNS,key,defense;;name,sPaTK,key,specialattack;;name,sPdFN,key,specialdefense;;name,sPEED,key,speed")do
local text=stat.name..": "..f_prefix_zero(pkmn[stat.key],3).." +1"
if pkmn.stages then
text..=" "..(pkmn.stages[stat.key]>0 and "+"..pkmn.stages[stat.key]or(pkmn.stages[stat.key]<0 and "-"..pkmn.stages[stat.key])or "")
end
add(op,{text=text})
end
if mode>=3 then
add(op,{text="eVAS: "..f_prefix_zero(pkmn.evasion*100\1,3).."%"})
add(op,{text="aCUR: "..f_prefix_zero(pkmn.accuracy*100\1,3).."%"})
add(op,{text="cRIT: "..f_prefix_zero(pkmn.crit/16*100\1,3).."%"})
end
if mode>=1 then
add(op,{text="pOKEMON mOVES",header=true})
add(op,{text="mOVE1: "..c_move_names[pkmn[1].id]})
add(op,{text="mOVE2: "..c_move_names[pkmn[2].id]})
add(op,{text="mOVE3: "..c_move_names[pkmn[3].id]})
add(op,{text="mOVE4: "..c_move_names[pkmn[4].id]})
f_add_stat_move(op,pkmn,1)
f_add_stat_move(op,pkmn,2)
f_add_stat_move(op,pkmn,3)
f_add_stat_move(op,pkmn,4)
end
if mode>=3 then
add(op,{text="bATTLE fLAGS",header=true})
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
end,function(_ENV)f_add_stat(op,c_pokemon[f_getsel"g_grid_browse"],0)end,function(_ENV)f_add_stat(op,f_get_party_pkmn(f_getsel"g_grid_pickedit",f_getsel"g_grid_pickspot"),1)end,function(i,is_sel)
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
local pkmn=c_pokemon[f_getsel"g_grid_editpkmn"]
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
f_print_top("eDIT: tEAM",f_getsel"g_grid_pickedit"+1)
f_print_bot(pkstr_arr[1],"-",pkstr_arr[2],"-",pkstr_arr[3],"-",pkstr_arr[4],"-",pkstr_arr[5],pkstr_arr[6])
end,function()
local toggle=g_cg_m.name=="g_grid_pickleag"
local disabled=@0x5eff+1<f_getsel"g_grid_picktrnr"+1
local name=c_trnr_names[f_getsel"g_grid_picktrnr"+1]
name=disabled and f_strtoq(name)or name
f_print_top(toggle and "\f4"or "\f2","pLR: tEAM",f_getsel"g_grid_pickedit"+1)
f_print_bot(toggle and "\f2"or "\f4","cPU: ",name)
end,function()
local ind=f_getsel"g_grid_battle_stats"
local p=ind<6 and p0 or p1==p0 and p2 or p1
local name=c_trnr_names[f_getsel"g_grid_picktrnr"+1]
local pkmn=p.team[ind%6+1]
f_print_top(p.name,": sPOT",ind%6+1)
f_print_bot("#",f_prefix_zero(pkmn.num,3)," ",pkmn.name)
end,function()
local ind=f_getsel"g_grid_battle_switch"
local name=c_trnr_names[f_getsel"g_grid_picktrnr"+1]
local pkmn=p0.team[ind%6+1]
f_print_top("sWITCH: sPOT",ind%6+1)
f_print_bot("#",f_prefix_zero(pkmn.num,3)," ",pkmn.name)
end,function()
local toggle=g_cg_m.name=="g_grid_pickplr1"
f_print_top(toggle and "\f4"or "\f2","pLR1: tEAM",f_getsel"g_grid_pickplr1"+1)
f_print_bot(toggle and "\f2"or "\f4","pLR2: tEAM",f_getsel"g_grid_pickplr2"+1)
end,function()
print("\^w\^tpicodex",2,1,4)
print(c_palette_names[g_palette].." vERSION",2,12,2)
f_draw_pkmn(g_title_l,7,20,16,false,false,false,g_title_sel)
f_draw_pkmn(g_title_r,35,20,16,true,false,false,not g_title_sel)
end,function(_ENV)
add(op,{text="fIGHT",select=function()
f_add_to_ui_stack(g_grid_battle_movesel)
end})
add(op,{text="sTATS",select=function()
f_add_to_ui_stack(g_grid_battle_stats)
end})
add(op,{text="sWITCH",select=function()
f_add_to_ui_stack(g_grid_battle_switch)
end})
add(op,{text="gIVEuP",select=function()
f_pop_ui_stack()f_pop_ui_stack()f_pop_ui_stack()
f_add_to_ui_stack(g_grid_battle_results)
end})
local b=function(_ENV,team,x,y,px,py,flip)
roundrect_r(x-1+1,y+1-6+1,x+35-1,y+6+6+1,3)
if hp>0 then
rectfill(x+1,y+3,x+1+mid(0,hp/hp*32,32),y+6,2)
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
print("fZN".."  "..f_prefix_zero(hp,3),x+1+1,y+8-1+1,2,-1)
f_draw_pkmn(num,px,py,16,flip,false,false,p0.active ~=_ENV)
end
add(preview_op,{draw=function()b(p2.active,p2.team,0,4,39,1,true)end})
add(preview_op,{draw=function()b(p1.active,p1.team,23,4,3,1)end})
end,function(_ENV)
for i=1,4 do
add(op,{text=c_move_names[p0.active[i].id]})
end
f_add_stat_move(preview_op,p0.active,f_getsel"g_grid_battle_movesel"+1)
end,function(_ENV)
for i=1,6 do
local pkmn=p0.team[i]
local disabled=not pkmn.valid or i==p0.active.spot or pkmn.major==1
add(op,{disabled=disabled,draw=function(i,is_sel)
f_draw_pkmn(pkmn.num,1,1,16,p0==p2,false,disabled,not disabled and not is_sel)
end})
end
end,function()
g_preview_timer=20
local otherteam=p1==p0 and p2 or p1
return otherteam.team[f_getsel"g_grid_battle_results"+1].num
end,function(_ENV)
local otherteam=p1==p0 and p2 or p1
for i=1,6 do
local pkmn=otherteam.team[i]
local disabled=not pkmn.valid or pkmn.major==1
add(op,{disabled=disabled,draw=function(i,is_sel)
f_draw_pkmn(pkmn.num,1,1,16,otherteam==p2,false,disabled,not disabled and not is_sel)
end})
end
add(preview_op,{draw=function()
f_print_top("cHAMP: "..otherteam.name)
f_print_bot("lOSER: "..p0.name)
end})
end,function(_ENV)
for i=1,6 do
local pkmn=p0.team[i]
local disabled=not pkmn.valid
add(op,{lrvalid=not disabled,disabled=disabled,draw=function(i,is_sel)
f_draw_pkmn(pkmn.num,1,1,16,false,false,disabled,not disabled and not is_sel)
end})
end
local otherteam=p1==p0 and p2 or p1
for i=1,6 do
local pkmn=otherteam.team[i]
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
return f_getsel"g_grid_browse"
end,function()
g_preview_timer=20
return f_get_party_pkmn(f_getsel"g_grid_pickedit",f_getsel"g_grid_pickspot").num
end,function()
f_add_to_ui_stack(g_grid_pickplr2)
end,function()
f_add_to_ui_stack(g_grid_picktrnr)
end,function(_ENV)
local otherpl=p1==p0 and p2 or p1
local bothteams={}
for i=1,6 do add(bothteams,p0.team[i])end
for i=1,6 do add(bothteams,otherpl.team[i])end
f_add_stat(op,bothteams[f_getsel"g_grid_battle_stats"+1],2)
end,function()
f_add_to_ui_stack(g_grid_statbattle)
end,function()
g_preview_timer=20
local otherpl=p1==p0 and p2 or p1
local bothteams={}
for i=1,6 do add(bothteams,p0.team[i])end
for i=1,6 do add(bothteams,otherpl.team[i])end
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
f_save_party_pkmn(f_mkpkmn(f_getsel"g_grid_editpkmn",true,rnd(2)\1,0,5,6,7,8),f_getsel"g_grid_pickedit",f_getsel"g_grid_pickspot")
f_pop_ui_stack()
end,function()gridpo[f_getsel"g_grid_editstat"+1].select()end,function()
gridpo[f_getsel"g_grid_battle_select"+1].select()
end,function()
local pkmn=f_get_party_pkmn(f_getsel"g_grid_pickedit",f_getsel"g_grid_pickspot")
pkmn[f_getsel"g_grid_editstat"+1].pid=f_getsel"g_grid_editmove"+1
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
end,function()return p0.active.num end,function(s)
local ns=""
for i=1,#s do ns..="?" end
return ns
end,function()end,function(party_num,callback)
for ii=0,5 do
local party_loc=0x5e00+party_num*42
local pkmn_ind=@(party_loc+ii*7)
callback(c_pokemon[pkmn_ind].lock and pkmn_ind,ii)
end
end)
f_zobj_set(_g,"_update,@,_draw,@",function()
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
f_zcall(f_create_gridpair,"top_browse;,6,4,2,2,10,10;top_edit;,2,2,2,2,30,20;top_editteam;,3,2,2,2,20,20;top_pkstat;,1,4,2,4,60,9;top_text_grid;,2,4,2,4,30,9;top_title;,1,1,2,2,60,40;top_battle;,1,1,2,2,60,40;top_battle2;,1,2,2,2,60,20;bot_4x4;,2,2,2,44,30,9;bot_info;,1,1,2,45,60,16;;,g_grid_title,~bot_4x4,~top_title,~f_dp_title,~f_op_title,~f_s_title,~f_l_title,~c_no;;,g_grid_browse,~top_browse,~bot_info,~f_dt_browse,~f_op_browse,~f_s_browse,~f_l_browse,~c_no;;,g_grid_editpkmn,~top_browse,~bot_info,~f_dt_editpkmn,~f_op_browse,~f_s_editpkmn,~f_l_browse,~c_no;;,g_grid_statbrowse,~top_pkstat,~bot_info,~f_dt_browse,~f_op_statbrowse,~f_s_pkstat,~f_l_browse,g_grid_browse;;,g_grid_statedit,~top_pkstat,~bot_info,~f_dt_editstat,~f_op_statedit,~f_s_statedit,~f_l_browse,g_grid_pickspot;;,g_grid_statbattle,~top_pkstat,~bot_info,~f_dt_batstats,~f_op_statbattle,~f_s_statbat,~f_l_browse,g_grid_battle_stats;;,g_grid_editstat,~top_text_grid,~bot_info,~f_dt_editstat,~f_op_editstat,~f_s_editstat,~f_l_browse,~c_no;;,g_grid_editmove,~top_text_grid,~bot_info,~f_dt_editmove,~f_op_editmove,~f_s_editmove,~f_l_browse,~c_no;;,g_grid_edititem,~top_text_grid,~bot_info,~f_dt_editstat,~f_op_edititem,~f_s_edititem,~f_l_browse,~c_no;;,g_grid_pickedit,~top_edit,~bot_info,~f_dt_edit,~f_op_edit,~f_s_edit,~f_l_browse,~c_no;;,g_grid_pickleag,~top_edit,~bot_info,~f_dt_league,~f_op_edit,~f_s_league,~f_l_browse,~c_no,~c_yes;;,g_grid_pickplr1,~top_edit,~bot_info,~f_dt_versus,~f_op_edit,~f_s_versus,~f_l_browse,~c_no,~c_yes;;,g_grid_pickplr2,~top_edit,~bot_info,~f_dt_versus,~f_op_edit,~f_s_versusbegin,~f_l_browse,~c_no,~c_yes;;,g_grid_pickspot,~top_editteam,~bot_info,~f_dt_editteam,~f_op_editteam,~f_s_editteam,~f_l_browse,~c_no;;,g_grid_picktrnr,~top_text_grid,~bot_info,~f_dt_league,~f_op_teams,~f_s_batbegin,~f_l_browse,~c_no;;,g_grid_battle_select,~bot_4x4,~top_battle2,~f_nf,~f_op_batsel,~f_s_battle,~f_l_battle,~c_no;;,g_grid_battle_movesel,~bot_4x4,~top_pkstat,~f_nf,~f_op_movesel,~f_s_battle,~f_l_browse,~c_no;;,g_grid_battle_switch,~top_editteam,,~bot_info,~f_dt_switch,~f_op_batswitch,~f_nf,~f_l_browse,~c_no;;,g_grid_battle_stats,~top_editteam,,~bot_info,~f_dt_batstats,~f_op_batstats,~f_s_batstat,~f_l_browse,~c_no;;,g_grid_battle_results,~top_editteam,~bot_info,~f_nf,~f_op_batresults,~f_s_batresults,~f_l_browse,~c_no")
g_gridstack={}
f_add_to_ui_stack(g_grid_title)
sfx"63"
g_shake_timer=0