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
f_zobj_set(_g,"f_zobj,@,f_zobj_set,@,f_zobj_eval,@,f_zcall,@,f_create_cell,@,f_create_gridpair,@,f_update_grid,@,f_draw_grid,@,f_minisfx,@,f_draw_pkmn,@,c_move_names,@,c_pkmn_names,@,c_trnr_names,@,c_type_names,@,c_item_names,@,f_init_peek_inc,@,c_types,@,f_can_pokemon_teach_move,@,f_update_locks,@,f_strtoq,@,_update60,@,_draw,@",f_zobj,f_zobj_set,f_zobj_eval,function(func,text,...)
foreach(f_zobj(text,...),function(params)
func(unpack(params))
end)
end,function(...)
return f_zobj("disabled,@",...)
end,function(name,first,second,selfunc,leavefunc)
pair={}
for tab in all{first,second}do
add(pair,f_zobj("num,0,view,0,active,@,w,@,len,@,vh,@,x,@,y,@,cw,@,ch,@,selbg,@,bg,@,df,@",unpack(tab)))
end
add(pair,selfunc)
add(pair,leavefunc)
_g[name]=pair
end,function(_ENV)
if active then
local evalfunc=function(num,mmin,mmax,b0,b1,l)
local off=(b1 and l or 0)-(b0 and l or 0)
local newnum=mid(mmin,min(len-1,mmin+mmax),num+off)
if newnum==num and off ~=0 then
f_minisfx(253)
elseif newnum ~=num then
f_minisfx(255)
end
return newnum
end
local prevnum=num
num=evalfunc(num,0,len-1,btnp"0",btnp"1",1)
num=evalfunc(num,num%w,(len-1)\w*w,btnp"2",btnp"3",w)
if num\w-vh+1>view then view=(view+1)%((len-vh+1)\w)end
if num\w<view then view=(view-1)%((len-vh+1)\w)end
end
end,function(_ENV)
for j=0,vh*w-1 do
local i=j+view*w
if i>=len then return end
local xloc,yloc=x+i%w*cw,y+j\w*ch
camera(-xloc-1,-yloc-1)
local l,r,u,d=0,0,0,0
if i==0 then l=1 u=1 end
if i==w-1 then r=1 u=1 end
if i==len-1 then r=1 d=1 end
if i==(len-1)\w*w then l=1 d=1 end
rectfill(-1+l,-1,cw-2-r,ch-2,i==num and selbg or bg)
rectfill(-1,-1+u,cw-2,ch-2-d,i==num and selbg or bg)
df(i,i==num)
camera()
end
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
end,split"sTRUGL,aCID,aCIDaR,bARAGE,bONcLB,bIND,cLAMP,mOONlT,lECHsD,eXTRsP,sNCbOM,tWInDL,tHNsHK,gLARE,gILOTN,hYPfNG,jMPkCK,kINSIS,lOCKoN,lOVkIS,mACpNC,vICgRP,sPIcAN,sPIKES,sPORE,cOTsPR,pRESNT,vItHRW,cMTpNC,dRLpCK,sNDaTK,aGILTY,fRYaTK,qIKaTK,fALsWP,gROWL,hEALbL,sING,pOUND,mINMIZ,tAILwP,dBLsLP,mEGhRN,bONRNG,cONVR1,cONVR2,sPARK,mLKdRK,mORsUN,nGTsHD,oCTZOK,pINmIS,pWDsNW,sUPfNG,tM05,fIRsPN,pSNgAS,bARIER,mEDTAT,fTRsGT,hYPNOS,pSYbEM,lITsCR,sAFgRD,pETdNC,cHARM,sYNTHS,sWTsCN,rAZlEF,pSNpWD,sLPpWD,aBSORB,sTNsPR,fLAIL,cONFSN,sLAM,cONSTR,aMNESA,bUBBLE,sPLASH,hYDpMP,mNDrED,mIST,hRNATK,sPIwEB,dBLkCK,sWTkIS,mTLcLW,tRFORM,tRIKCK,gUST,tWISTR,cRBhAM,dIZpNC,sLUDGE,pAINsP,dSTbND,hAZE,lICK,pERsNG,mEANlK,cNFrAY,cRScHP,sMOG,kARcHP,eMBER,sMKsCR,bELdRM,bEATUP,sCRTCH,sLASH,aNCpWR,lEER,bITE,oUTrGE,sCRYfC,tHRASH,sTOMP,rOKsLD,mAGTUD,rOCtHR,hARDEN,bONrSH,hIJkCK,rECOVR,aERbLS,hRNdRL,dRGrGE,sFbOIL,dRGbRt,sLFdES,eXPLSN,eGGbMB,sLGbMB,gIGdRN,mEGdRN,sWRdNC,cUT,fRYcTR,tHIEF,dIG,rOLOUT,dFNcRL,dETECT,sOLbEM,rAIdNC,fLASH,pSYCIC,pSYCuP,dRMeAT,nGTMAR,sHDbAL,zAPcAN,tHUNDR,tHNbLT,iRNtAL,sTRENG,rOCsMS,hEDbUT,mUDsLP,sUNdAY,pROTCT,dBLtEM,sLPtLK,cURSE,hIDpWR,sWAGER,fRUSTR,rETURN,tOXIC,sNORE,rEST,eNDURE,aTRACT,bIDE,mIMIC,sUBSTU,rAGE,dBLeDG,tAKdWN,sKLbAS,bODsLM,wTRgUN,bBLbEM,iCEbEM,bLIZRD,iCYwND,sURF,wRLPOL,wTRFAL,sWIFT,pAYDAY,tRIATK,rFLECT,tHNwAV,tELPRT,pSYwAV,mETRNM,cOUNTR,mEGpNC,sEITOS,sUBMIS,mEGkCK,dYNpNC,fIRpNC,tHNpNC,iCEpNC,fIRbLS,fLMtHR,fISURE,eARTqK,sNDsTR,hYPbEM,rOAR,sTLwNG,fLY,rAZwND,wRLwND,sKYaTK,wNGaTK,pECK,mIRMOV,fNTaTK,wITdRW,rAPsPN,sUPsNC,aURbEM,mIRcOT,pSNsTG,sPITE,cRUNCH,pURSUT,sTRsHT,lECHlF,bTNpAS,dISABL,sCRECH,tACKLE,fLMwEL,rEVERS,fRYsWP,fCSeNG,fORsGT,lOWkCK,rOLkCK,eNCORE,wRAP,gROWTH,vINwHP,sACfIR,sHRPEN,sKETCH",split"mISSING,bULSAUR,iVYSAUR,vENSAUR,cHARMAN,cHARMEL,cHARZAR,sQUIRTL,wARTORT,bLSTOIS,cATRPIE,mETAPOD,bUTFREE,wEEDLE,kAKUNA,bEEDRIL,pIDGEY,pIDGETO,pIDGEOT,rATTATA,rATICAT,sPEAROW,fEAROW,eKANS,aRBOK,pIKACHU,rAICHU,sNDSHRW,sNDSLAS,nIDRANf,nIDRINA,nIDQUEN,nIDRANm,nIDRINO,nIDKING,cLFAIRY,cLFABLE,vULPIX,nINTALE,jIGPUFF,wIGTUFF,zUBAT,gOLBAT,oDDISH,gLOOM,vILPLUM,pARAS,pARSECT,vENONAT,vENMOTH,dIGLETT,dUGTRIO,mEOWTH,pERSIAN,pSYDUCK,gOLDUCK,mANKEY,pRIMAPE,gROWLTH,aRCANIN,pOLIWAG,pOLWIRL,pOLRATH,aBRA,kADABRA,aLKAZAM,mACHOP,mACHOKE,mACHAMP,bELSPRT,wEEPBEL,vICTBEL,tNTCOOL,tNTCRUL,gEODUDE,gRAVLER,gOLEM,pONYTA,rAPDASH,sLOWPOK,sLOWBRO,mAGNMIT,mAGNTON,fAFETCd,dODUO,dODRIO,sEEL,dEWGONG,gRIMER,mUK,sHELDER,cLYSTER,gASTLY,hAUNTER,gENGAR,oNIX,dROWZEE,hYPNO,kRABBY,kINGLER,vOLTORB,eLCRODE,eGGCUTE,eGGUTOR,cUBONE,mAROWAK,hITMLEE,hITMCHN,lIKTUNG,kOFFING,wEEZING,rHYHORN,rHYDON,cHANSEY,tANGELA,kANGKAN,hORSEA,sEADRA,gOLDEEN,sEAKING,sTARYU,sTARMIE,mRmIME,sCYTHER,jYNX,eLCABUZ,mAGMAR,pINSIR,tAUROS,mAGKARP,gYARDOS,lAPRAS,dITTO,eEVEE,vAPREON,jOLTEON,fLAREON,pORYGON,oMANYTE,oMASTAR,kABUTO,kABTOPS,aERODAC,sNORLAX,aRTCUNO,zAPDOS,mOLTRES,dRATINI,dRAGAIR,dRAGITE,mEWTWO,mEW,cHIKITA,bAYLEEF,mEGNIUM,cYNDQIL,qUILAVA,tYPHLOS,tOTODIL,cROCNAW,fRLGATR,sENTRET,fURRET,hOOTOOT,nOCTOWL,lEDYBA,lEDIAN,sPINRAK,aRIADOS,cROBAT,cHINCHU,lANTURN,pICHU,cLEFFA,iGGBUFF,tOGEPI,tOGETIC,nATU,xATU,mAREEP,fLAAFFY,aMPHROS,bELOSOM,mARILL,aZMARIL,sUDWOOD,pOLTOED,hOPPIP,sKIPLOM,jUMPLUF,aIPOM,sUNKERN,sUNFLOR,yANMA,wOOPER,qUAGSIR,eSPEON,uMBREON,mURKROW,sLOWKNG,mISDVUS,uNOWN,wOBUFET,gIFARIG,pINECO,fORTRES,dUNSPAR,gLIGAR,sTEELIX,sNUBBUL,gRANBUL,qILFISH,sCIZOR,sHUCKLE,hERCROS,sNEASEL,tEDIURS,uRSRING,sLUGMA,mACARGO,sWINUB,pILSWIN,cORSOLA,rEMRAID,oCTLERY,dELBIRD,mANTINE,sKARMRY,hONDOUR,hONDOOM,kINGDRA,pHANPY,dONPHAN,pORYGN2,sTANTLR,sMEARGL,tYROGUE,hITMTOP,sMOOCHM,eLEKID,mAGBY,mILTANK,bLISSEY,rAIKOU,eNTEI,sUICUNE,lARVTAR,pUPITAR,tYRATAR,lUGIA,hOoH,cELEBI",split"yOUNGS,sAGE,fALKNR,gRUNT,bUGCTR,bUGSY,pKMFAN,bEAUTY,wITNEY,kIMINO,mEDIUM,mORTY,pOLICE,kARATE,cHUCK,gENTLE,sAILOR,jASMIN,rOCKET,sKIER,pRYCE,sCIENT,tWINS,cLAIR,nERD,cAMPER,bROCK,sCHOOL,sWIMER,mISTY,jUGLER,gUITAR,lTSURG,hIKER,lASS,eRIKA,bIKER,pICNIK,jANINE,mANIAC,pSYCIC,sABRIN,fISHER,bREATH,bLAINE,bIRDKP,cOOLTR,bLUE,sILVER,wILL,kOGA,bRUNO,kAREN,lANCE,eUSINE,lAWREN,rED,hORDE",split"bIRD,nORMAL,fIRE,fIGHTN,wATER,pOISON,eLECTR,gROUND,gRASS,fLYING,iCE,bUG,pSYCIC,rOCK,dRAGON,gHOST,dARK,sTEEL",split"pNKBOW,cHRCOL,bLKbLT,mYwATR,pSNbRB,mAGNET,sOsAND,mIRACL,sHbEAK,nVRiCE,sLVpWD,tWsPON,hSTONE,dRAGsC,sPELtG,bLKgLS,mTLcOT,bRIpWD,fOCbND,kINGrK,lEFToV,qIKcLW,sCOPlN,aMcOIN,lITbAL,lUKpNC,mTLpWD,sTICK,tHKcLB,bERSRK,bERRY,bTRbRY,bRNbRY,gLDbRY,iCEbRY,mNTbRY,mIRbRY,mYSbRY,pARbRY,pSNbRY",function()
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
end
for ind in all(split"1,4,7,152,155,158")do
g_lock_pokemon[ind]=true
end
for i=1,min(57,57)do
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
end,function(s)
local ns=""
for i=1,#s do ns..="?" end
return ns
end,function()
g_cg_p,g_cg_t,g_cg_s,g_cg_l=unpack(g_gridstack[#g_gridstack])
f_update_grid(g_cg_p)
f_update_grid(g_cg_t)
if btnp"4" then
f_minisfx(g_cg_l()or 254)
elseif btnp"5" then
f_minisfx(g_cg_s()or 252)
end
end,function()
cls"0 "
f_draw_grid(g_cg_p)
f_draw_grid(g_cg_t)
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
local pkmn=f_zobj"learn;,;teach;,;event;,"
cur_list,c_moves[i],c_pokemon[i]=pkmn.learn,{},pkmn
foreach(split"pow,type,acc,pp",function(key)
c_moves[i][key]=f_init_peek_inc()
end)
foreach(split"prevolve,type1,type2,hp,att,def,spd,sat,sdf,gender_item",function(key)
pkmn[key]=f_init_peek_inc()
end)
while f_init_peek_inc()<255 do
if@g_init_peek_loc==252 then cur_list=pkmn.teach
elseif@g_init_peek_loc==253 then cur_list=pkmn.event
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
while sub.prevolve>0 do
sub=c_pokemon[sub.prevolve]
foreach(split"learn,teach,event",function(key)
foreach(sub[key],function(v)
add(c_pokemon[i][key],v)
end)
end)
end
end
printh(#c_trainers)
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
printh(i.." | "..debug(trainer))
end
f_update_locks()
for iloc=0x3200,0x4278,68 do
for loc=iloc,iloc+63,2 do
poke2(loc,%loc & 0x70df|0x0800)
end
poke4(iloc+64,0x.07d7)
end
f_zcall(f_create_gridpair,"p_browse;,~c_yes,3,252,2,2,2,20,20,6,13,@;t_browse;,~c_no,1,1,1,2,45,60,16,13,13,@;p_title;,~c_no,1,1,1,2,2,60,40,13,13,@;t_title;,~c_yes,2,4,2,2,44,30,9,6,13,@;p_pkpreview;,~c_no,1,1,1,2,2,60,40,13,13,@;p_pkstat;,~c_yes,2,264,4,2,4,30,9,13,13,@;;,g_grid_browse,~p_browse,~t_browse,@,@;;,g_grid_title,~p_title,~t_title,@,@;;,g_grid_pkpreview,~p_pkpreview,~t_browse,@,@;;,g_grid_pkstat,~p_pkstat,~t_browse,@,@",function(i,is_sel)
if not g_lock_pokemon[i]then
if not is_sel then
rectfill(-1,-1,18,18,1)
end
f_draw_pkmn(255,1,1,1,is_sel and 13 or 13,false)
else
f_draw_pkmn(i,1,1,is_sel and 13 or 1,is_sel and 7 or 6,false)
end
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
end,function(i,is_sel)
print("\^w\^tpicodex",2,1,1)
print("dUAL vERSION",2,12,1)
f_draw_pkmn(254,15-8,20,1,6)
f_draw_pkmn(t()\1%252,32-4,24-4,1,6,false)
end,function(i,is_sel)
if i>0 and not is_sel then
rectfill(-1,-1,28,7,1)
end
print(split"bROWSE,eDIT,lEAGUE,vERSUS"[i+1],1,1,is_sel and(i==0 and 13 or 1)or(i==0 and 1 or 13))
end,function(i,is_sel)
local pkmn_ind=g_grid_browse[1].num
f_draw_pkmn(pkmn_ind,13+(t()%1<.25 and(rnd(3)\1-1)*2 or 0),1+2,1,6,false,32)
end,function(i,is_sel)
local pkmn_ind=g_grid_browse[1].num
local pkmn=c_pokemon[pkmn_ind]
local genders=""
local pkmn=c_pokemon[g_grid_browse[1].num]
if pkmn.gender_item & 64>0 then genders..="M" end
if pkmn.gender_item & 128>0 then
if #genders>0 then genders..="/" end
genders..="F" end
if #genders==0 then genders..="U" end
if i==1 then
rectfill(1-32,-1,28,6,1)
pset(1-32,-1,0)
pset(28,-1,0)
print("\fdbASE sTATS",1-30,1)
elseif i==11 then
rectfill(1-32,-1,28,7,1)
print("\fdlEARN mOVES",1-30,1)
elseif i>11 then
local move_name=c_move_names[i-11]
if i%3==0 then
move_name=f_strtoq(move_name)
end
print(move_name,1,1,1)
elseif i==2 then print("hP:"..pkmn.hp,1,1,1)
elseif i==3 then print("sP:"..pkmn.spd,1,1,1)
elseif i==4 then print("aT:"..pkmn.att,1,1,1)
elseif i==5 then print("dF:"..pkmn.def,1,1,1)
elseif i==6 then print("sA:"..pkmn.sat,1,1,1)
elseif i==7 then print("sD:"..pkmn.sdf,1,1,1)
elseif i==8 then print("gD:"..genders,1,1,1)
elseif i==9 then print("lV:50",1,1,1)
end
end,function()
add(g_gridstack,g_grid_pkpreview)
return g_cg_p.num
end,function()
deli(g_gridstack)
end,function()
if g_cg_t.num==0 then
add(g_gridstack,g_grid_browse)
end
end,function()
end,function()
if g_cg_t.num==0 then
add(g_gridstack,g_grid_pkstat)
end
end,function()
deli(g_gridstack)
end,function()
return g_grid_browse[1].num
end,function()
deli(g_gridstack)
end)
g_gridstack={g_grid_title}