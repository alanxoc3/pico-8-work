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
f_zobj_set(_g,"c_pokemon,#,c_moves,#,c_trainers,#,g_lock_pokemon,#,g_lock_move,#,g_lock_item,#,g_init_peek_loc,0x1fff,c_yes,@,c_no,@,c_empty,@,f_nop,@",true,false,"",function(...)return...end)
f_zobj_set(_g,"f_zobj,@,f_zobj_set,@,f_zobj_eval,@,f_zcall,@,f_create_gridpair,@,f_update_grid,@,f_draw_grid,@,f_minisfx,@,f_draw_pkmn,@,c_move_names,@,c_trnr_names,@,c_type_names,@,c_item_names,@,c_pkmn_names,@,f_init_peek_inc,@,c_types,@,f_can_pokemon_teach_move,@,f_op_def,@,f_op_browse,@,f_update_locks,@,f_get_party_pkmn,@,f_op_edit,@,f_op_editparty,@,f_strtoq,@,f_op_title,@,f_op_teams,@,f_op_editstat,@,f_op_editmove,@,f_op_pkstat,@,f_dp_browse,@,f_loop_through_team_pkmn,@,f_dp_edit,@,f_dt_edit2,@,f_dt_editstat,@,f_dp_edit2,@,f_dt_browse,@,f_dt_edit,@,f_dt_league,@,f_dt_versus,@,f_l_browse,@,f_s_browse,@,f_dp_title,@,f_dp_title_update,@,f_s_title,@,f_dp_pkpreview,@,f_l_pkpreview,@,f_s_pkpreview,@,f_dp_pkstat,@,f_l_pkstat,@,f_s_pkstat,@,f_s_versus,@,f_s_league,@,f_s_edit,@,f_s_edit2,@,f_s_editstat,@,f_s_editmove,@,f_l_title,@,_update60,@,_draw,@",f_zobj,f_zobj_set,f_zobj_eval,function(func,text,...)
foreach(f_zobj(text,...),function(params)
func(unpack(params))
end)
end,function(name,mem,first,second,first_obj_func,selfunc,leavefunc,lrfunc,...)
local pair={}
for tab in all{first,second}do
add(pair,f_zobj("name,@,mem,@,memview,@,selfunc,@,leavefunc,@,lrfunc,@,w,@,vh,@,x,@,y,@,cw,@,ch,@,df,@,updatefunc,@",name,mem,mem+1,selfunc,leavefunc,lrfunc,unpack(tab)))
end
add(pair,first_obj_func)
add(pair,{...})
_g[name]=pair
end,function(_ENV,gridobj)
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
local num,view=@mem,@memview
if lrfunc then
local off=(btnp"3" and 1 or 0)-(btnp"2" and 1 or 0)
local prevview=view
view=mid(0,view+off,(#gridobj-1)\w-vh+1)
if view==prevview and off ~=0 then
f_minisfx(253)
elseif off ~=0 then
f_minisfx(255)
end
lrfunc((btnp"1" and 1 or 0)-(btnp"0" and 1 or 0))
else
num=evalfunc(num,0,#gridobj-1,btnp"0",btnp"1",1)
num=evalfunc(num,num%w,(#gridobj-1)\w*w,btnp"2",btnp"3",w)
if num\w-vh+1>view then view=num\w-vh+1 end
if num\w<view then view=num\w end
view=mid(0,view,(#gridobj-1)\w-vh+1)
end
if btnp"4" then
f_minisfx(leavefunc()or 254)
elseif btnp"5" then
if(num<0 or not gridobj[num+1].disabled)then
f_minisfx(selfunc()or 252)
else
f_minisfx(253)
end
end
poke(mem,num,view)
end,function(_ENV,gridobj,num,view,x,y,active)
clip(x,y,w*cw,vh*ch)
for j=0,vh*w-1 do
local i=j+view*w
local isheader=gridobj[i\w*w+1].header
local isnumheader=isheader and(num\w==i\w)
local obj=gridobj[i+1]
if i>=#gridobj then break end
local xloc,yloc=x+i%w*cw,y+j\w*ch
camera(-xloc-1,-yloc-1)
local l,r,u,d=0,0,0,0
if i==0 then l=1 u=1 end
if i==w-1 then r=1 u=1 end
if i==#gridobj-1 then r=1 d=1 end
if i==(#gridobj-1)\w*w then l=1 d=1 end
local c=2
if i ~=num and(obj.disabled or isheader)then
c=1
end
if not lrfunc and active and(i==num or isnumheader)then
if obj.disabled or isnumheader then
c=3
else
c=4
end
end
rectfill(-1+l,-1,cw-2-r,ch-2,c)
rectfill(-1,-1+u,cw-2,ch-2-d,c)
end
for j=0,vh*w-1 do
local i=j+view*w
local obj=gridobj[i+1]
local isheader=gridobj[i\w*w+1].header
local isnumheader=isheader and(num\w==i\w)
if i>=#gridobj then break end
local xloc,yloc=x+i%w*cw,y+j\w*ch
camera(-xloc-1,-yloc-1)
local c=1
if i==num and not isnumheader then
c=2
end
if(obj.disabled or isheader)then
if isnumheader or i==num then
c=2
else
c=2
end
end
print(obj.text or "",1,1,c)
df(i,i==num,obj)
end
clip()
camera()
end,function(num)
sfx(num\4,num<252 and 0 or 1,num%4*8,8)
end,function(num,x,y,width,flip,sel,disabled)
local in_c=sel and(disabled and 3 or 4)or disabled and 1 or c_pokemon[mid(1,num,252)].color
local out_c=(sel or disabled)and 2 or 1
if num==0 then
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
end,split"___,aCID,aCIDaR,bARAGE,bONcLB,bIND,cLAMP,mOONlT,lECHsD,eXTRsP,sNCbOM,tWInDL,tHNsHK,gLARE,gILOTN,hYPfNG,jMPkCK,kINSIS,lOCKoN,lOVkIS,mACpNC,vICgRP,sPIcAN,sPIKES,sPORE,cOTsPR,pRESNT,vItHRW,cMTpNC,dRLpCK,sNDaTK,aGILTY,fRYaTK,qIKaTK,fALsWP,gROWL,hEALbL,sING,pOUND,mINMIZ,tAILwP,dBLsLP,mEGhRN,bONRNG,cONVR1,cONVR2,sPARK,mLKdRK,mORsUN,nGTsHD,oCTZOK,pINmIS,pWDsNW,sUPfNG,fIRsPN,pSNgAS,bARIER,mEDTAT,fTRsGT,hYPNOS,pSYbEM,lITsCR,sAFgRD,pETdNC,cHARM,sYNTHS,sWTsCN,rAZlEF,pSNpWD,sLPpWD,aBSORB,sTNsPR,fLAIL,cONFSN,sLAM,cONSTR,aMNESA,bUBBLE,sPLASH,hYDpMP,mNDrED,mIST,hRNaTK,sPIwEB,dBLkCK,sWTkIS,mTLcLW,tRFORM,tRIKCK,gUST,tWISTR,cRBhAM,dIZpNC,sLUDGE,pAINsP,dSTbND,hAZE,lICK,pERsNG,mEANlK,cNFrAY,cRScHP,sMOG,kARcHP,eMBER,sMKsCR,bELdRM,bEATUP,sCRTCH,sLASH,aNCpWR,lEER,bITE,oUTrGE,sCRYfC,tHRASH,sTOMP,rOKsLD,mAGTUD,rOCtHR,hARDEN,bONrSH,hIJkCK,rECOVR,aERbLS,hRNdRL,dRGrGE,sFbOIL,dRGbRt,sLFdES,eXPLSN,eGGbMB,sLGbMB,gIGdRN,mEGdRN,sWRdNC,cUT,fRYcTR,tHIEF,dIG,rOLOUT,dFNcRL,dETECT,sOLbEM,rAIdNC,fLASH,pSYCIC,pSYCuP,dRMeAT,nGTMAR,sHDbAL,zAPcAN,tHUNDR,tHNbLT,iRNtAL,sTRENG,rOCsMS,hEDbUT,mUDsLP,sUNdAY,pROTCT,dBLtEM,sLPtLK,cURSE,hIDpWR,sWAGER,fRUSTR,rETURN,tOXIC,sNORE,rEST,eNDURE,aTRACT,bIDE,mIMIC,sUBSTU,rAGE,dBLeDG,tAKdWN,sKLbAS,bODsLM,wTRgUN,bBLbEM,iCEbEM,bLIZRD,iCYwND,sURF,wRLPOL,wTRFAL,sWIFT,pAYDAY,tRIaTK,rFLECT,tHNwAV,tELPRT,pSYwAV,mETRNM,cOUNTR,mEGpNC,sEITOS,sUBMIS,mEGkCK,dYNpNC,fIRpNC,tHNpNC,iCEpNC,fIRbLS,fLMtHR,fISURE,eARTqK,sNDsTR,hYPbEM,rOAR,sTLwNG,fLY,rAZwND,wRLwND,sKYaTK,wNGaTK,pECK,mIRMOV,fNTaTK,wITdRW,rAPsPN,sUPsNC,aURbEM,mIRcOT,pSNsTG,sPITE,cRUNCH,pURSUT,sTRsHT,lECHlF,bTNpAS,dISABL,sCRECH,tACKLE,fLMwEL,rEVERS,fRYsWP,fCSeNG,fORsGT,lOWkCK,rOLkCK,eNCORE,wRAP,gROWTH,vINwHP,sACfIR,sHRPEN,sKETCH,tM05,sTRUGL,nONE,nONE,nONE",split"yOUNGS,sAGE,fALKNR,gRUNT,bUGcTR,bUGSY,pKMfAN,bEAUTY,wITNEY,kIMINO,mEDIUM,mORTY,pOLICE,kARATE,cHUCK,gENTLE,sAILOR,jASMIN,rOCKET,sKIER,pRYCE,sCIENT,tWINS,cLAIR,nERD,cAMPER,bROCK,sCHOOL,sWIMER,mISTY,jUGLER,gUITAR,lTsURG,hIKER,lASS,eRIKA,bIKER,pICNIK,jANINE,mANIAC,pSYCIC,sABRIN,fISHER,bREATH,bLAINE,bIRDkP,cOOLtR,bLUE,sILVER,wILL,kOGA,bRUNO,kAREN,lANCE,eUSINE,lAWRNC,rED,hORDE",split"bIRD,nORMAL,fIRE,fIGHTN,wATER,pOISON,eLECTR,gROUND,gRASS,fLYING,iCE,bUG,pSYCIC,rOCK,dRAGON,gHOST,dARK,sTEEL",split"nONE,pNKBOW,cHRCOL,bLKbLT,mYwATR,pSNbRB,mAGNET,sOsAND,mIRACL,sHbEAK,nVRiCE,sLVpWD,tWsPON,hSTONE,dRAGsC,sPELtG,bLKgLS,mTLcOT,bRIpWD,fOCbND,kINGrK,lEFToV,qIKcLW,sCOPlN,aMcOIN,lITbAL,lUKpNC,mTLpWD,sTICK,tHKcLB,bERSRK,bERRY,bTRbRY,bRNbRY,gLDbRY,iCEbRY,mNTbRY,mIRbRY,mYSbRY,pARbRY,pSNbRY",split"___,bULSAUR,iVYSAUR,vENSAUR,cHARMAN,cHARMEL,cHARZAR,sQUIRTL,wARTORT,bLSTOIS,cATRPIE,mETAPOD,bUTFREE,wEEDLE,kAKUNA,bEEDRIL,pIDGEY,pIDGETO,pIDGEOT,rATTATA,rATICAT,sPEAROW,fEAROW,eKANS,aRBOK,pIKACHU,rAICHU,sNDSHRW,sNDSLAS,nIDRANf,nIDRINA,nIDQUEN,nIDRANm,nIDRINO,nIDKING,cLFAIRY,cLFABLE,vULPIX,nINTALE,jIGPUFF,wIGTUFF,zUBAT,gOLBAT,oDDISH,gLOOM,vILPLUM,pARAS,pARSECT,vENONAT,vENMOTH,dIGLETT,dUGTRIO,mEOWTH,pERSIAN,pSYDUCK,gOLDUCK,mANKEY,pRIMAPE,gROWLTH,aRCANIN,pOLIWAG,pOLWIRL,pOLRATH,aBRA,kADABRA,aLKAZAM,mACHOP,mACHOKE,mACHAMP,bELSPRT,wEEPBEL,vICTBEL,tNTCOOL,tNTCRUL,gEODUDE,gRAVLER,gOLEM,pONYTA,rAPDASH,sLOWPOK,sLOWBRO,mAGNMIT,mAGNTON,fAFETCd,dODUO,dODRIO,sEEL,dEWGONG,gRIMER,mUK,sHELDER,cLYSTER,gASTLY,hAUNTER,gENGAR,oNIX,dROWZEE,hYPNO,kRABBY,kINGLER,vOLTORB,eLCRODE,eGGCUTE,eGGUTOR,cUBONE,mAROWAK,hITMLEE,hITMCHN,lIKTUNG,kOFFING,wEEZING,rHYHORN,rHYDON,cHANSEY,tANGELA,kANGKAN,hORSEA,sEADRA,gOLDEEN,sEAKING,sTARYU,sTARMIE,mRmIME,sCYTHER,jYNX,eLCABUZ,mAGMAR,pINSIR,tAUROS,mAGKARP,gYARDOS,lAPRAS,dITTO,eEVEE,vAPREON,jOLTEON,fLAREON,pORYGON,oMANYTE,oMASTAR,kABUTO,kABTOPS,aERODAC,sNORLAX,aRTCUNO,zAPDOS,mOLTRES,dRATINI,dRAGAIR,dRAGITE,mEWTWO,mEW,cHIKITA,bAYLEEF,mEGNIUM,cYNDQIL,qUILAVA,tYPHLOS,tOTODIL,cROCNAW,fRLGATR,sENTRET,fURRET,hOOTOOT,nOCTOWL,lEDYBA,lEDIAN,sPINRAK,aRIADOS,cROBAT,cHINCHU,lANTURN,pICHU,cLEFFA,iGGBUFF,tOGEPI,tOGETIC,nATU,xATU,mAREEP,fLAAFFY,aMPHROS,bELOSOM,mARILL,aZMARIL,sUDWOOD,pOLTOED,hOPPIP,sKIPLOM,jUMPLUF,aIPOM,sUNKERN,sUNFLOR,yANMA,wOOPER,qUAGSIR,eSPEON,uMBREON,mURKROW,sLOWKNG,mISDVUS,uNOWN,wOBUFET,gIFARIG,pINECO,fORTRES,dUNSPAR,gLIGAR,sTEELIX,sNUBBUL,gRANBUL,qILFISH,sCIZOR,sHUCKLE,hERCROS,sNEASEL,tEDIURS,uRSRING,sLUGMA,mACARGO,sWINUB,pILSWIN,cORSOLA,rEMRAID,oCTLERY,dELBIRD,mANTINE,sKARMRY,hONDOUR,hONDOOM,kINGDRA,pHANPY,dONPHAN,pORYGN2,sTANTLR,sMEARGL,tYROGUE,hITMTOP,sMOOCHM,eLEKID,mAGBY,mILTANK,bLISSEY,rAIKOU,eNTEI,sUICUNE,lARVTAR,pUPITAR,tYRATAR,lUGIA,hOoH,cELEBI,mISNGnO,___,___,___",function()
g_init_peek_loc+=1
return@g_init_peek_loc
end,f_zobj"0;,;;,;;,;;,;;,;;,;;,;;,;;,;;,;;,;;,;;,;;,;;,;;,;;,;;,",function(pkmn_ind,move_ind)
for l in all(split"teach,event")do
for ind in all(c_pokemon[pkmn_ind][l])do
if ind==move_ind then
return true
end
end
end
end,function()
return{{}}
end,function()
local op={}
for i=1,252 do
add(op,{data=g_lock_pokemon[i]and i or 0,disabled=not g_lock_pokemon[i]})
end
return op
end,function()
for ind in all(split"1,4,7,152,155,158")do
g_lock_pokemon[ind]=true
end
if@0x5efe==0 then
poke(0x5efe,1)
memcpy(0x5e00,0x4286,42)
end
for i=1,min(58,@0x5eff)do
for pkmn in all(c_trainers[i])do
g_lock_pokemon[pkmn.ind]=true
for i=1,4 do
if pkmn[i]then
g_lock_move[pkmn[i]]=true
end
end
g_lock_pokemon[pkmn.ind]=true
g_lock_item[c_pokemon[pkmn.ind].item]=true
end
end
end,function(party_num,pkmn_num)
local _ENV=f_zobj""
for i,key in ipairs(split"num,gender,item,level,0,1,2,3")do
_ENV[key]=@(0x5e00+party_num*42+pkmn_num*7+i-1)
end
return _ENV
end,function(sumdisable)
local op={}
for partynum=0,3 do
local sumind=0
local inds={}
for pkmnnum=0,5 do
local party_loc=0x5e00+partynum*42
local pkmn_ind=@(party_loc+pkmnnum*7)
sumind+=pkmn_ind
add(inds,pkmn_ind)
end
add(op,{data=inds,disabled=sumdisable and sumind==0})
end
return op
end,function()
local op={}
for pkmnnum=0,5 do
local party_loc=0x5e00+(@0x5eb0)*42
local pkmn_ind=@(party_loc+pkmnnum*7)
add(op,{data=pkmn_ind})
end
return op
end,function(s)
local ns=""
for i=1,#s do ns..="?" end
return ns
end,function()return{{text="bROWSE"},{text="eDIT"},{text="lEAGUE"},{text="vERSUS"}}end,function()
local op={}
for i=1,58 do
add(op,{text=c_trnr_names[i],disabled=@0x5eff+1<i})
end
return op
end,function()
local op={}
for i=0,3 do
local move_ind=@(0x5e00+@0x5eb0*42+@0x5eb6*7+3+i)
add(op,{text=c_move_names[move_ind+1],select=function()
add(g_gridstack,g_grid_editmove)
end})
end
add(op,{text="pNKBOW",select=function()end})
add(op,{text="nEUTER",disabled=true,select=function()end})
add(op,{text="lV 5",select=function()end})
add(op,{text="dELETE",select=function()
memset(0x5e00+@0x5eb0*42+@0x5eb6*7,0,7)
deli(g_gridstack)
end})
return op
end,function()
local op={}
local pkmn_ind=@(0x5e00+@0x5eb0*42+@0x5eb6*7)
local pkmn=c_pokemon[pkmn_ind+1]
printh(pkmn_ind)
printh(pkmn_ind)
for i=0,3 do add(op,{text="nONE"})end
for m in all(pkmn.learn)do add(op,{text=c_move_names[m+1]})end
for m in all(pkmn.teach)do add(op,{text=c_move_names[m+1]})end
for m in all(pkmn.event)do add(op,{text=c_move_names[m+1]})end
if #op%2==1 then add(op,{text="",disabled=true})end
return op
end,function()
local op={}
local pkmn=c_pokemon[@g_grid_browse[1].mem]
local genders=""
return op
end,function(i,is_sel,gridobj)
f_draw_pkmn(gridobj.data,1,1,6,false,is_sel,gridobj.disabled)
end,function(party_num,callback)
for ii=0,5 do
local party_loc=0x5e00+party_num*42
local pkmn_ind=@(party_loc+ii*7)
callback(g_lock_pokemon[pkmn_ind]and pkmn_ind,ii)
end
end,function(i,is_sel,gridobj)
for ii,ind in ipairs(gridobj.data)do
f_draw_pkmn(ind,(ii-1)%3+1+(ii-1)%3*9,1+(ii-1)\3*10,6,false,is_sel,gridobj.disabled)
end
end,function(i,is_sel)
local pkstr_arr={}
local pkstr_lens=split"3,3,3,2"
local party_loc=0x5e00+(@0x5eb0)*42
local pkmn_loc=party_loc+(@0x5eb6)*7
for move_i=0,3 do
local move_ind=@(pkmn_loc+3+move_i)
add(pkstr_arr,sub(c_move_names[(move_ind+1)],1,pkstr_lens[move_i+1]))
end
local pkstr=pkstr_arr[1].."-"..pkstr_arr[2].."-"..pkstr_arr[3].."-"..pkstr_arr[4]
print("\^y7\f3#"..(@0x5eb6+1).." \f4"..(c_pkmn_names[@pkmn_loc+1]).."\n\f1"..pkstr,1,1,1)
end,function(i,is_sel)
if@0x5eb8<4 then
print("\f4mOVE #"..@0x5eb8,1,1)
end
end,function(i,is_sel,gridobj)
f_draw_pkmn(gridobj.data,1,1,16,false,is_sel)
end,function(i,is_sel)
local numstr=tostr((@0x5ea8+1)%252)
local pkmn=c_pokemon[@0x5ea8+1]
while #numstr<3 do numstr="0"..numstr end
local namestr,type1,type2=pkmn.name,c_type_names[pkmn.type1+1],""
if pkmn.type2>0 then
type2=c_type_names[pkmn.type2+1]
end
if not g_lock_pokemon[@0x5ea8+1]then
namestr,type1,type2=f_strtoq(namestr),f_strtoq(type1),f_strtoq(type2)
end
local str="\^y7\f3#"..numstr.." \f4"..namestr.."\n\f1"..type1.." "..type2
print(str,1,1)
end,function(i,is_sel)
local pkstr_arr={}
local pkstr_lens=split"3,3,1,1,1,2"
f_loop_through_team_pkmn(@g_cg_m.mem,function(ind,ii)
add(pkstr_arr,sub(c_pkmn_names[(ind or 255)+1],1,pkstr_lens[ii+1]))
end)
local pkstr=pkstr_arr[1].."-"..pkstr_arr[2].."-"..pkstr_arr[3]..pkstr_arr[4]..pkstr_arr[5].."-"..pkstr_arr[6]
print("\^y7\f4tEAM #"..(@g_cg_m.mem+1).." \f1\n"..pkstr,1,1,1)
end,function()
if g_cg_m.name=="g_grid_league" then
print("\^y7\f1pLR: \f4tEAM "..(@0x5eb0+1).."\f1\ncPU: \f3"..c_trnr_names[@0x5eb4+1],1,1)
else
print("\^y7\f1pLR: \f3tEAM "..(@0x5eb0+1).."\f1\ncPU: \f4"..c_trnr_names[@0x5eb4+1],1,1)
end
end,function()
if g_cg_m.name=="g_grid_versus" then
print("\^y7\f1pLR1: \f4tEAM "..(@0x5eb0+1).."\f1\npLR2: \f3tEAM "..(@0x5eb2+1),1,1)
else
print("\^y7\f1pLR1: \f3tEAM "..(@0x5eb0+1).."\f1\npLR2: \f4tEAM "..(@0x5eb2+1),1,1)
end
end,function()
deli(g_gridstack)
end,function()
add(g_gridstack,g_grid_pkstat)
end,function(i,is_sel)
print("\^w\^tpicodex",2,1,4)
print("dUAL vERSION",2,12,1)
f_draw_pkmn(g_title_l,-8+15+(mid(-1,-.75,cos(0+g_title_an_timer/300))+.75)*4*26+(g_title_an_timer>190 and g_title_an_timer<220 and(rnd(3)\1-1)or 0),20,16)
f_draw_pkmn(g_title_r,50-15-(mid(-1,-.75,cos(.5+g_title_an_timer/300))+.75)*4*26+(g_title_an_timer>40 and g_title_an_timer<70 and(rnd(3)\1-1)or 0),20,16,true)
end,function()
g_title_an_timer=(g_title_an_timer+1)%300
if g_title_an_timer==0 then
g_title_r=rnd"252"\1+1
elseif g_title_an_timer==150 then
g_title_l=rnd"252"\1+1
elseif g_title_an_timer==50-10 then f_minisfx(g_title_r-1)
elseif g_title_an_timer==200-10 then f_minisfx(g_title_l-1)
end
end,function()
if@g_cg_m.mem==0 then
add(g_gridstack,g_grid_browse)
elseif@g_cg_m.mem==1 then
add(g_gridstack,g_grid_edit)
elseif@g_cg_m.mem==2 then
add(g_gridstack,g_grid_league)
elseif@g_cg_m.mem==3 then
add(g_gridstack,g_grid_versus)
end
end,function(i,is_sel)
local pkmn_ind=@0x5ea8+1
f_draw_pkmn(pkmn_ind,13+(g_preview_timer>0 and(rnd(3)\1-1)or 0),1+2,32)
end,function()
deli(g_gridstack)
end,function()
g_preview_timer=20
return@g_grid_browse[1].mem
end,function(i,is_sel,obj)
end,function()
deli(g_gridstack)
end,function()
add(g_gridstack,g_grid_pkpreview)
end,function()
add(g_gridstack,g_grid_versus2)
end,function()
add(g_gridstack,g_grid_league2)
end,function()
add(g_gridstack,g_grid_edit2)
end,function()
local party_loc=0x5e00+(@0x5eb0)*42
local pkmn_loc=party_loc+@0x5eb6*7
if@pkmn_loc>0 then
add(g_gridstack,g_grid_edit3)
else
add(g_gridstack,g_grid_editpkmn)
end
end,function()
gridpo[@0x5eb8+1].select()
end,function()
end,function()
return 253
end,function()
g_title_timer=min(80,(g_title_timer+1))
g_preview_timer=max(0,g_preview_timer-1)
g_cg_m,g_cg_s,gridpo,params=unpack(g_gridstack[#g_gridstack])
gridpo=gridpo(unpack(params))
if g_title_timer==80 then
g_cg_m.updatefunc()
g_cg_s.updatefunc()
f_update_grid(g_cg_m,gridpo)
elseif g_title_timer<80 then
local b=bitmaskToIndex(btnp())
if b then
g_palette=b
end
end
end,function()
cls"0 "
print("\^y7\f4aLANxOC3\n\-d \f2pRESENTS",32-4*4,32-6)
local easing=sin(max(60,g_title_timer)/80)
f_draw_grid(g_cg_m,gridpo,@g_cg_m.mem,@g_cg_m.memview,g_cg_m.x,g_cg_m.y+easing*20,true)
f_draw_grid(g_cg_s,{{}},-1,0,g_cg_s.x,g_cg_s.y-easing*45)
pal(g_palettes[g_palette+1],1)
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
f_zcall(poke,";,0x5f2c,3;;,0x5f5c,8;;,0x5f5d,1")
for i=0,323 do
c_types[i\18][i%18]=f_init_peek_inc()\2
end
for i=1,252 do
local pkmn=f_zobj"old;learn,#,teach,#,event,#;learn;,;teach;,;event;,"
cur_list,c_moves[i-1],c_pokemon[i]=pkmn.old.learn,{},pkmn
foreach(split"pow,type,acc,pp",function(key)
c_moves[i-1][key]=f_init_peek_inc()
end)
foreach(split"prevolve,type1,type2,hp,att,def,spd,sat,sdf,item,color",function(key)
pkmn[key]=f_init_peek_inc()
end)
for k,v in pairs(f_zobj"192;,m,f;0;,n;64;,m;128;,f")do
if pkmn.color & 192==k then
pkmn.genders=v
end
end
f_zobj_set(pkmn,"name,@,num,@",c_pkmn_names[i+1],i%252)
while f_init_peek_inc()<255 do
if@g_init_peek_loc==252 then cur_list=pkmn.old.teach
elseif@g_init_peek_loc==253 then cur_list=pkmn.old.event
elseif@g_init_peek_loc==254 then
for j=cur_list[#cur_list-1]+1,cur_list[#cur_list]-1 do
add(cur_list,j)
end
else
add(cur_list,@g_init_peek_loc)
end
end
end
for i=1,252 do
local sub=c_pokemon[i]
while sub do
foreach(split"learn,teach,event",function(key)
foreach(sub.old[key],function(v)
add(c_pokemon[i][key],v)
end)
end)
sub=c_pokemon[sub.prevolve]
end
end
for i=0,56 do
local trainer,move={},f_init_peek_inc()
for j=1,6 do
local pkmn={ind=f_init_peek_inc()}
for i=1,min(4,#c_pokemon[pkmn.ind].learn)do
pkmn[i]=c_pokemon[pkmn.ind].learn[i]
end
if f_can_pokemon_teach_move(pkmn.ind,move)then
pkmn[4]=move
end
add(trainer,pkmn)
end
add(c_trainers,trainer)
end
local horde={}
for i=1,252 do
local pkmn={ind=i}
for i=1,min(4,#c_pokemon[i].learn)do
pkmn[i]=c_pokemon[i].learn[i]
end
if pkmn.ind==252 then pkmn[4]=251 end
add(horde,pkmn)
end
add(c_trainers,horde)
menuitem(1,"swap 🅾️/❎",function()
end)
menuitem(2,"factory reset",function()
cls()flip()
memset(0x5e00,0,256)
run()
end)
poke(0x5eff,58)
f_update_locks()
for iloc=0x3200,0x4278,68 do
for loc=iloc,iloc+63,2 do
poke2(loc,%loc & 0x70df|0x0a00)
end
poke4(iloc+64,0x.07d7)
end
f_nf=function()end
f_browselr=function(dir)
local prev=@0x5ea8
local next=prev+1
if dir>0 then
for i=next+1,252,1 do
if g_lock_pokemon[i]then
next=i
break
end
end
elseif dir<0 then
for i=prev,0,-1 do
if g_lock_pokemon[i]then
next=i
break
end
end
end
poke(0x5ea8,next-1)
if prev ~=@0x5ea8 then
f_minisfx(255)
elseif dir ~=0 then
f_minisfx(253)
end
end
g_title_an_timer=70
g_palettes={
{[0]=1,129,13,6,7,139,141,14,6,143,142,12,9,8,4,5},
{[0]=131,129,3,11,10,139,141,14,6,143,142,12,9,8,4,5},
{[0]=129,1,140,12,6,139,141,14,6,143,142,12,9,8,4,5},
{[0]=8,0,10,136,9,139,141,14,6,143,142,12,9,8,4,5},
{[0]=7,6,0,134,5,139,141,14,6,143,2,12,1,8,4,5},
{[0]=128,130,141,134,135,139,141,14,6,143,142,12,9,8,4,5},
}
g_palette=0
f_zcall(f_create_gridpair,"p_browse;,6,4,2,2,10,10,~f_dp_browse,~f_nf;t_browse;,1,1,2,45,60,16,~f_dt_browse,~f_nf;p_title;,1,1,2,2,60,40,~f_dp_title,~f_dp_title_update;t_title;,2,2,2,44,30,9,~f_nf,~f_nf;p_pkpreview;,1,1,2,2,60,40,~f_dp_pkpreview,~f_nf;p_pkstat;,2,4,2,4,30,9,~f_dp_pkstat,~f_nf;t_edit;,1,1,2,45,60,16,~f_dt_edit,~f_nf;p_edit;,2,2,2,2,30,20,~f_dp_edit,~f_nf;t_edit2;,1,1,2,45,60,16,~f_dt_edit2,~f_nf;p_edit2;,3,2,2,2,20,20,~f_dp_edit2,~f_nf;t_edit3;,1,1,2,45,60,16,~f_dt_editstat,~f_nf;p_edit3;,2,4,2,4,30,9,~f_nf,~f_nf;t_edit4;,1,1,2,45,60,16,~f_dt_editstat,~f_nf;p_edit4;,2,4,2,4,30,9,~f_nf,~f_nf;t_versus;,1,1,2,45,60,16,~f_dt_versus,~f_nf;t_league;,1,1,2,45,60,16,~f_dt_league,~f_nf;p_teamed;,2,4,2,4,30,9,~f_nf,~f_nf;t_teamed;,1,1,2,45,60,16,~f_dt_edit,~f_nf;;,g_grid_browse,0x5ea8,~p_browse,~t_browse,~f_op_browse,~f_s_pkstat,~f_l_browse,,~c_no;;,g_grid_title,0x5eaa,~t_title,~p_title,~f_op_title,~f_s_title,~f_l_title,,~c_no;;,g_grid_pkpreview,0x5eac,~p_pkpreview,~t_browse,~f_op_def,~f_s_pkpreview,~f_l_pkpreview,~f_browselr;;,g_grid_pkstat,0x5eae,~p_pkstat,~t_browse,~f_op_pkstat,~f_s_pkstat,~f_l_pkstat,,~c_no;;,g_grid_edit,0x5eb0,~p_edit,~t_edit,~f_op_edit,~f_s_edit,~f_l_browse,,~c_no;;,g_grid_edit2,0x5eb6,~p_edit2,~t_edit2,~f_op_editparty,~f_s_edit2,~f_l_browse,,~c_no;;,g_grid_edit3,0x5eb8,~p_edit3,~t_edit3,~f_op_editstat,~f_s_editstat,~f_l_browse,,~c_no;;,g_grid_editmove,0x5eba,~p_edit4,~t_edit4,~f_op_editmove,~f_s_editmove,~f_l_browse,,~c_no;;,g_grid_editpkmn,0x5ea8,~p_browse,~t_browse,~f_op_browse,~f_nf,~f_l_browse,,~c_no;;,g_grid_league,0x5eb0,~p_edit,~t_league,~f_op_edit,~f_s_league,~f_l_browse,,~c_no,~c_yes;;,g_grid_league2,0x5eb4,~p_teamed,~t_league,~f_op_teams,~f_nf,~f_l_browse,,~c_no;;,g_grid_versus,0x5eb0,~p_edit,~t_versus,~f_op_edit,~f_s_versus,~f_l_browse,,~c_no,~c_yes;;,g_grid_versus2,0x5eb2,~p_edit,~t_versus,~f_op_edit,~f_nf,~f_l_browse,,~c_no,~c_yes")
g_gridstack={g_grid_title}
g_preview_timer=0
g_title_timer=0
g_title_l=254
g_title_r=254
sfx"63"
function bitmaskToIndex(bitmask)
for i=0,5 do
if bitmask &(1<<i)~=0 then
return i
end
end
return nil
end