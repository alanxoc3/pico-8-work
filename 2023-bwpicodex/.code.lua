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
f_zobj_set(_g,"f_zobj,@,f_zobj_set,@,f_zobj_eval,@,f_zcall,@,f_create_gridpair,@,f_update_grid,@,f_draw_grid,@,f_minisfx,@,f_draw_pkmn,@,c_move_names,@,c_pkmn_names,@,c_trnr_names,@,c_type_names,@,c_item_names,@,f_init_peek_inc,@,c_types,@,f_can_pokemon_teach_move,@,f_update_locks,@,f_strtoq,@,f_dp_browse,@,f_dt_browse,@,f_dt_edit,@,f_dt_league,@,f_dt_versus,@,f_l_browse,@,f_s_browse,@,f_dp_title,@,f_s_title,@,f_dp_pkpreview,@,f_l_pkpreview,@,f_s_pkpreview,@,f_dp_pkstat,@,f_l_pkstat,@,f_s_pkstat,@,f_l_title,@,_update60,@,_draw,@",f_zobj,f_zobj_set,f_zobj_eval,function(func,text,...)
foreach(f_zobj(text,...),function(params)
func(unpack(params))
end)
end,function(name,first,second,first_obj,second_obj)
local pair={}
for tab in all{first,second}do
add(pair,f_zobj("num,0,view,0,active,@,vert,@,w,@,vh,@,x,@,y,@,cw,@,ch,@,df,@,lrfunc,@,selfunc,@,leavefunc,@",unpack(tab)))
end
add(pair,first_obj)
add(pair,second_obj)
_g[name]=pair
end,function(_ENV,gridobj)
if active then
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
local prevnum=num
if vert then
num=-1
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
end
end,function(_ENV,gridobj)
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
local c=13
if i ~=num and(obj.disabled or isheader)then
c=1
end
if active and(i==num or isnumheader)then
if obj.disabled or isnumheader then
c=6
else
c=6
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
c=13
end
if(obj.disabled or isheader)then
if isnumheader or i==num then
c=7
else
c=13
end
end
print(obj.text or "",1,1,c)
df(i,i==num,obj)
end
camera()
end,function(num)
sfx(num\4,num<252 and 0 or 1,num%4*8,8)
end,function(num,x,y,out_c,in_c,flip,width)
local row=num/8\1
local col=num%8
width=width or 16
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
end,split"sTRUGL,aCID,aCIDaR,bARAGE,bONcLB,bIND,cLAMP,mOONlT,lECHsD,eXTRsP,sNCbOM,tWInDL,tHNsHK,gLARE,gILOTN,hYPfNG,jMPkCK,kINSIS,lOCKoN,lOVkIS,mACpNC,vICgRP,sPIcAN,sPIKES,sPORE,cOTsPR,pRESNT,vItHRW,cMTpNC,dRLpCK,sNDaTK,aGILTY,fRYaTK,qIKaTK,fALsWP,gROWL,hEALbL,sING,pOUND,mINMIZ,tAILwP,dBLsLP,mEGhRN,bONRNG,cONVR1,cONVR2,sPARK,mLKdRK,mORsUN,nGTsHD,oCTZOK,pINmIS,pWDsNW,sUPfNG,fIRsPN,pSNgAS,bARIER,mEDTAT,fTRsGT,hYPNOS,pSYbEM,lITsCR,sAFgRD,pETdNC,cHARM,sYNTHS,sWTsCN,rAZlEF,pSNpWD,sLPpWD,aBSORB,sTNsPR,fLAIL,cONFSN,sLAM,cONSTR,aMNESA,bUBBLE,sPLASH,hYDpMP,mNDrED,mIST,hRNATK,sPIwEB,dBLkCK,sWTkIS,mTLcLW,tRFORM,tRIKCK,gUST,tWISTR,cRBhAM,dIZpNC,sLUDGE,pAINsP,dSTbND,hAZE,lICK,pERsNG,mEANlK,cNFrAY,cRScHP,sMOG,kARcHP,eMBER,sMKsCR,bELdRM,bEATUP,sCRTCH,sLASH,aNCpWR,lEER,bITE,oUTrGE,sCRYfC,tHRASH,sTOMP,rOKsLD,mAGTUD,rOCtHR,hARDEN,bONrSH,hIJkCK,rECOVR,aERbLS,hRNdRL,dRGrGE,sFbOIL,dRGbRt,sLFdES,eXPLSN,eGGbMB,sLGbMB,gIGdRN,mEGdRN,sWRdNC,cUT,fRYcTR,tHIEF,dIG,rOLOUT,dFNcRL,dETECT,sOLbEM,rAIdNC,fLASH,pSYCIC,pSYCuP,dRMeAT,nGTMAR,sHDbAL,zAPcAN,tHUNDR,tHNbLT,iRNtAL,sTRENG,rOCsMS,hEDbUT,mUDsLP,sUNdAY,pROTCT,dBLtEM,sLPtLK,cURSE,hIDpWR,sWAGER,fRUSTR,rETURN,tOXIC,sNORE,rEST,eNDURE,aTRACT,bIDE,mIMIC,sUBSTU,rAGE,dBLeDG,tAKdWN,sKLbAS,bODsLM,wTRgUN,bBLbEM,iCEbEM,bLIZRD,iCYwND,sURF,wRLPOL,wTRFAL,sWIFT,pAYDAY,tRIATK,rFLECT,tHNwAV,tELPRT,pSYwAV,mETRNM,cOUNTR,mEGpNC,sEITOS,sUBMIS,mEGkCK,dYNpNC,fIRpNC,tHNpNC,iCEpNC,fIRbLS,fLMtHR,fISURE,eARTqK,sNDsTR,hYPbEM,rOAR,sTLwNG,fLY,rAZwND,wRLwND,sKYaTK,wNGaTK,pECK,mIRMOV,fNTaTK,wITdRW,rAPsPN,sUPsNC,aURbEM,mIRcOT,pSNsTG,sPITE,cRUNCH,pURSUT,sTRsHT,lECHlF,bTNpAS,dISABL,sCRECH,tACKLE,fLMwEL,rEVERS,fRYsWP,fCSeNG,fORsGT,lOWkCK,rOLkCK,eNCORE,wRAP,gROWTH,vINwHP,sACfIR,sHRPEN,sKETCH,tM05",split"mISSING,bULSAUR,iVYSAUR,vENSAUR,cHARMAN,cHARMEL,cHARZAR,sQUIRTL,wARTORT,bLSTOIS,cATRPIE,mETAPOD,bUTFREE,wEEDLE,kAKUNA,bEEDRIL,pIDGEY,pIDGETO,pIDGEOT,rATTATA,rATICAT,sPEAROW,fEAROW,eKANS,aRBOK,pIKACHU,rAICHU,sNDSHRW,sNDSLAS,nIDRANf,nIDRINA,nIDQUEN,nIDRANm,nIDRINO,nIDKING,cLFAIRY,cLFABLE,vULPIX,nINTALE,jIGPUFF,wIGTUFF,zUBAT,gOLBAT,oDDISH,gLOOM,vILPLUM,pARAS,pARSECT,vENONAT,vENMOTH,dIGLETT,dUGTRIO,mEOWTH,pERSIAN,pSYDUCK,gOLDUCK,mANKEY,pRIMAPE,gROWLTH,aRCANIN,pOLIWAG,pOLWIRL,pOLRATH,aBRA,kADABRA,aLKAZAM,mACHOP,mACHOKE,mACHAMP,bELSPRT,wEEPBEL,vICTBEL,tNTCOOL,tNTCRUL,gEODUDE,gRAVLER,gOLEM,pONYTA,rAPDASH,sLOWPOK,sLOWBRO,mAGNMIT,mAGNTON,fAFETCd,dODUO,dODRIO,sEEL,dEWGONG,gRIMER,mUK,sHELDER,cLYSTER,gASTLY,hAUNTER,gENGAR,oNIX,dROWZEE,hYPNO,kRABBY,kINGLER,vOLTORB,eLCRODE,eGGCUTE,eGGUTOR,cUBONE,mAROWAK,hITMLEE,hITMCHN,lIKTUNG,kOFFING,wEEZING,rHYHORN,rHYDON,cHANSEY,tANGELA,kANGKAN,hORSEA,sEADRA,gOLDEEN,sEAKING,sTARYU,sTARMIE,mRmIME,sCYTHER,jYNX,eLCABUZ,mAGMAR,pINSIR,tAUROS,mAGKARP,gYARDOS,lAPRAS,dITTO,eEVEE,vAPREON,jOLTEON,fLAREON,pORYGON,oMANYTE,oMASTAR,kABUTO,kABTOPS,aERODAC,sNORLAX,aRTCUNO,zAPDOS,mOLTRES,dRATINI,dRAGAIR,dRAGITE,mEWTWO,mEW,cHIKITA,bAYLEEF,mEGNIUM,cYNDQIL,qUILAVA,tYPHLOS,tOTODIL,cROCNAW,fRLGATR,sENTRET,fURRET,hOOTOOT,nOCTOWL,lEDYBA,lEDIAN,sPINRAK,aRIADOS,cROBAT,cHINCHU,lANTURN,pICHU,cLEFFA,iGGBUFF,tOGEPI,tOGETIC,nATU,xATU,mAREEP,fLAAFFY,aMPHROS,bELOSOM,mARILL,aZMARIL,sUDWOOD,pOLTOED,hOPPIP,sKIPLOM,jUMPLUF,aIPOM,sUNKERN,sUNFLOR,yANMA,wOOPER,qUAGSIR,eSPEON,uMBREON,mURKROW,sLOWKNG,mISDVUS,uNOWN,wOBUFET,gIFARIG,pINECO,fORTRES,dUNSPAR,gLIGAR,sTEELIX,sNUBBUL,gRANBUL,qILFISH,sCIZOR,sHUCKLE,hERCROS,sNEASEL,tEDIURS,uRSRING,sLUGMA,mACARGO,sWINUB,pILSWIN,cORSOLA,rEMRAID,oCTLERY,dELBIRD,mANTINE,sKARMRY,hONDOUR,hONDOOM,kINGDRA,pHANPY,dONPHAN,pORYGN2,sTANTLR,sMEARGL,tYROGUE,hITMTOP,sMOOCHM,eLEKID,mAGBY,mILTANK,bLISSEY,rAIKOU,eNTEI,sUICUNE,lARVTAR,pUPITAR,tYRATAR,lUGIA,hOoH,cELEBI",split"yOUNGS,sAGE,fALKNR,gRUNT,bUGcTR,bUGSY,pKMfAN,bEAUTY,wITNEY,kIMINO,mEDIUM,mORTY,pOLICE,kARATE,cHUCK,gENTLE,sAILOR,jASMIN,rOCKET,sKIER,pRYCE,sCIENT,tWINS,cLAIR,nERD,cAMPER,bROCK,sCHOOL,sWIMER,mISTY,jUGLER,gUITAR,lTsURG,hIKER,lASS,eRIKA,bIKER,pICNIK,jANINE,mANIAC,pSYCIC,sABRIN,fISHER,bREATH,bLAINE,bIRDkP,cOOLtR,bLUE,sILVER,wILL,kOGA,bRUNO,kAREN,lANCE,eUSINE,lAWREN,rED",split"bIRD,nORMAL,fIRE,fIGHTN,wATER,pOISON,eLECTR,gROUND,gRASS,fLYING,iCE,bUG,pSYCIC,rOCK,dRAGON,gHOST,dARK,sTEEL",split"pNKBOW,cHRCOL,bLKbLT,mYwATR,pSNbRB,mAGNET,sOsAND,mIRACL,sHbEAK,nVRiCE,sLVpWD,tWsPON,hSTONE,dRAGsC,sPELtG,bLKgLS,mTLcOT,bRIpWD,fOCbND,kINGrK,lEFToV,qIKcLW,sCOPlN,aMcOIN,lITbAL,lUKpNC,mTLpWD,sTICK,tHKcLB,bERSRK,bERRY,bTRbRY,bRNbRY,gLDbRY,iCEbRY,mNTbRY,mIRbRY,mYSbRY,pARbRY,pSNbRY",function()
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
if@0x5eff==0 then
memset(0x5e00,0,256)
g_lock_pokemon={}
g_lock_move={}
g_lock_item={}
poke(0x5eff,1)
end
op_browse={}
for ind in all(split"1,4,7,152,155,158")do
g_lock_pokemon[ind]=true
end
for i=1,min(57,@0x5efe)do
for pkmn in all(c_trainers[i])do
g_lock_pokemon[pkmn.ind]=true
for i=1,4 do
if pkmn[i]then
g_lock_move[pkmn[i]]=true
end
end
g_lock_pokemon[pkmn.ind]=true
g_lock_item[c_pokemon[pkmn.ind].gender_item & 0b00111111]=true
end
end
for i=0,251 do
add(op_browse,{data=g_lock_pokemon[i]and i or 255,disabled=not g_lock_pokemon[i]})
end
end,function(s)
local ns=""
for i=1,#s do ns..="?" end
return ns
end,function(i,is_sel,gridobj)
f_draw_pkmn(gridobj.data,1,1,is_sel and(gridobj.disabled and 1 or 13)or 1,gridobj.disabled and 13 or(is_sel and 7 or 6),false)
end,function(i,is_sel)
local numstr=tostr(g_grid_browse[1].num)
while #numstr<3 do numstr="0"..numstr end
local namestr,type1,type2=c_pkmn_names[g_grid_browse[1].num+1],c_type_names[c_pokemon[g_grid_browse[1].num].type1+1],""
if c_pokemon[g_grid_browse[1].num].type2>0 then
type2=c_type_names[c_pokemon[g_grid_browse[1].num].type2+1]
end
if not g_lock_pokemon[g_grid_browse[1].num]then
namestr,type1,type2=f_strtoq(namestr),f_strtoq(type1),f_strtoq(type2)
end
local str="\^y7\f6"..numstr.." \f7"..namestr.."\n\f1"..type1.." "..type2
print(str,1,1)
end,function()
local num=g_cg_p.num+1
print("\^y7\f1pLR: \f7"..gridpo[g_cg_p.num+1].text,1,1)
end,function()
local num=g_cg_p.num+1
print("\^y7\f1pLR: \f7"..gridpo[g_cg_p.num+1].text.."\f1\ncPU: \f6"..c_trnr_names[@0x5efe+1],1,1)
end,function()
local num=g_cg_p.num+1
print("\^y7\f1pLR1: \f7"..gridpo[g_cg_p.num+1].text.."\f1\npLR2: \f6"..c_trnr_names[@0x5efe+1],1,1)
end,function()
deli(g_gridstack)
end,function()
add(g_gridstack,g_grid_pkstat)
f_populate_stats()
end,function(i,is_sel)
print("\^w\^tpicodex",2,1,1)
print("dUAL vERSION",2,12,1)
f_draw_pkmn(254,15-8+4,20,1,6)
f_draw_pkmn(t()\1%252,32-4+4,24-4,1,6,false)
end,function()
if g_cg_t.num==0 then
add(g_gridstack,g_grid_browse)
elseif g_cg_t.num==1 then
add(g_gridstack,g_grid_edit)
elseif g_cg_t.num==2 then
add(g_gridstack,g_grid_league)
elseif g_cg_t.num==3 then
add(g_gridstack,g_grid_versus)
end
end,function(i,is_sel)
local pkmn_ind=g_grid_browse[1].num
f_draw_pkmn(pkmn_ind,13+(g_preview_timer>0 and(rnd(3)\1-1)*2 or 0),1+2,1,6,false,32)
end,function()
deli(g_gridstack)
end,function()
g_preview_timer=20
return g_grid_browse[1].num
end,function(i,is_sel,obj)
end,function()
deli(g_gridstack)
end,function()
add(g_gridstack,g_grid_pkpreview)
end,function()
return 253
end,function()
g_preview_timer=max(0,g_preview_timer-1)
g_cg_p,g_cg_t,gridpo,gridto=unpack(g_gridstack[#g_gridstack])
gridpo=_ENV[gridpo]
gridto=_ENV[gridto]
f_update_grid(g_cg_p,gridpo)
f_update_grid(g_cg_t,gridto)
end,function()
cls"0 "
f_draw_grid(g_cg_p,gridpo)
f_draw_grid(g_cg_t,gridto)
pal(0,129,1)
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
for i=0,251 do
local pkmn=f_zobj"old;learn,#,teach,#,event,#;learn;,;teach;,;event;,"
cur_list,c_moves[i],c_pokemon[i]=pkmn.old.learn,{},pkmn
foreach(split"pow,type,acc,pp",function(key)
c_moves[i][key]=f_init_peek_inc()
end)
foreach(split"prevolve,type1,type2,hp,att,def,spd,sat,sdf,gender_item",function(key)
pkmn[key]=f_init_peek_inc()
end)
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
for i=0,251 do
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
local trainer={move=f_init_peek_inc()}
for j=1,6 do
local pkmn={ind=f_init_peek_inc()}
for i=1,min(4,#c_pokemon[pkmn.ind].learn)do
pkmn[i]=c_pokemon[pkmn.ind].learn[i]
end
if f_can_pokemon_teach_move(pkmn.ind,trainer.move)then
pkmn[4]=trainer.move
end
add(trainer,pkmn)
end
add(c_trainers,trainer)
end
poke(0x5efe,20)
f_update_locks()
for iloc=0x3200,0x4278,68 do
for loc=iloc,iloc+63,2 do
poke2(loc,%loc & 0x70df|0x0800)
end
poke4(iloc+64,0x.07d7)
end
op_def={{}}
op_title={{text="bROWSE"},{text="eDIT"},{text="lEAGUE"},{text="vERSUS"}}
op_teams={}
for i=1,6 do
add(op_teams,{text="tEAM "..i})
end
add(op_teams,{text="sTARTR"})
for i=1,57 do
add(op_teams,{text=c_trnr_names[i],disabled=@0x5efe<i})
end
f_nf=function()end
f_populate_stats=function()
op_pkstat={}
local pkmn=c_pokemon[g_grid_browse[1].num]
local genders=""
if pkmn.gender_item & 64>0 then genders..="M" end
if pkmn.gender_item & 128>0 then
if #genders>0 then genders..="/" end
genders..="F" end
if #genders==0 then genders..="U" end
add(op_pkstat,{text="bASE sTATS",header=true})
add(op_pkstat,{text=""})
add(op_pkstat,{text="hP:"..pkmn.hp})
add(op_pkstat,{text="sP:"..pkmn.spd})
add(op_pkstat,{text="aT:"..pkmn.att})
add(op_pkstat,{text="dF:"..pkmn.def})
add(op_pkstat,{text="sA:"..pkmn.sat})
add(op_pkstat,{text="sD:"..pkmn.sdf})
add(op_pkstat,{text="gD:"..genders})
add(op_pkstat,{text="lV:50"})
if #pkmn.learn>0 then
add(op_pkstat,{text="lEARN mOVES",disabled=true,header=true})
add(op_pkstat,{text="",disabled=true,header=true})
for m in all(pkmn.learn)do
add(op_pkstat,{text=c_move_names[m+1]})
end
if #op_pkstat%2==1 then add(op_pkstat,{text="",disabled=true})end
end
if #pkmn.teach>0 then
add(op_pkstat,{text="tEACH mOVES",header=true,disabled=true})
add(op_pkstat,{text="",disabled=true})
for m in all(pkmn.teach)do
local movename=c_move_names[m+1]
if not g_lock_move[m]then
movename=f_strtoq(movename)
end
add(op_pkstat,{text=movename})
end
if #op_pkstat%2==1 then add(op_pkstat,{text="",disabled=true})end
end
if #pkmn.event>0 then
add(op_pkstat,{text="eVENT mOVES",header=true,disabled=true})
add(op_pkstat,{text="",disabled=true})
for m in all(pkmn.event)do
local movename=c_move_names[m+1]
if not g_lock_move[m]then
movename=f_strtoq(movename)
end
add(op_pkstat,{text=movename})
end
if #op_pkstat%2==1 then add(op_pkstat,{text="",disabled=true})end
end
end
f_browselr=function(dir)
local prev=g_grid_browse[1].num
local next=prev
if dir>0 then
for i=prev+1,251,1 do
if g_lock_pokemon[i]then
next=i
break
end
end
elseif dir<0 then
for i=prev-1,0,-1 do
if g_lock_pokemon[i]then
next=i
break
end
end
end
g_grid_browse[1].num=next
if prev ~=g_grid_browse[1].num then
f_minisfx(255)
f_populate_stats()
elseif dir ~=0 then
f_minisfx(253)
end
end
f_zcall(f_create_gridpair,"p_browse;,~c_yes,~c_no,3,2,2,2,20,20,~f_dp_browse,~f_nf,~f_s_browse,~f_l_browse;t_browse;,~c_no,~c_no,1,1,2,45,60,16,~f_dt_browse,~f_nf,~f_nf,~f_nf;p_title;,~c_no,~c_no,1,1,2,2,60,40,~f_dp_title,~f_nf,~f_nf,~f_nf;t_title;,~c_yes,~c_no,2,2,2,44,30,9,~f_nf,~f_nf,~f_s_title,~f_l_title;p_pkpreview;,~c_yes,~c_yes,1,1,2,2,60,40,~f_dp_pkpreview,~f_browselr,~f_s_pkpreview,~f_l_pkpreview;p_pkstat;,~c_yes,~c_yes,2,4,2,4,30,9,~f_dp_pkstat,~f_browselr,~f_s_pkstat,~f_l_pkstat;p_teamed;,~c_yes,~c_no,2,4,2,4,30,9,~f_nf,~f_nf,~f_nf,~f_l_pkstat;t_versus;,~c_no,~c_no,1,1,2,45,60,16,~f_dt_versus,~f_nf,~f_nf,~f_nf;t_league;,~c_no,~c_no,1,1,2,45,60,16,~f_dt_league,~f_nf,~f_nf,~f_nf;t_teamed;,~c_no,~c_no,1,1,2,45,60,16,~f_dt_edit,~f_nf,~f_nf,~f_nf;;,g_grid_browse,~p_browse,~t_browse,op_browse,op_def;;,g_grid_title,~p_title,~t_title,op_def,op_title;;,g_grid_pkpreview,~p_pkpreview,~t_browse,op_def,op_def;;,g_grid_pkstat,~p_pkstat,~t_browse,op_pkstat,op_def;;,g_grid_edit,~p_teamed,~t_teamed,op_teams,op_def;;,g_grid_league,~p_teamed,~t_league,op_teams,op_def;;,g_grid_versus,~p_teamed,~t_versus,op_teams,op_def")
g_gridstack={g_grid_title}
g_preview_timer=0