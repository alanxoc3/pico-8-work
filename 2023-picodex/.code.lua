Y=setmetatable({},{__index=_ENV})
_ENV=Y
function nL(e,n,t)
if ord(e)==126then return n[sub(e,2)]
elseif e=="@"then return deli(t,1)
elseif e=="#"then return{}end
return e~=""and e or nil
end
function F(f,n,...)
local o,t,e={...},split(n,";"),f
foreach(t,function(n)
local t=split(n)
if#t>1then
if t[1]==""then
foreach(t,function(n)
add(e,nL(n,f,o))
end)
else
for n=1,#t,2do
e[t[n]]=nL(t[n+1],f,o)
end
end
e=f
else
if n==""then n=#e+1end
if type(e[n])~="table"then
e[n]={}
end
e=e[n]
end
end)
return f
end
function r(...)
return F(setmetatable({},{__index=Y}),...)
end
F(Y,"eu,@,j,@,fj,@,L,@",true,false,"",function(...)return...end)
F(Y,"r,@,F,@,nL,@,tp,@,tw,@,Z,@,t3,@,t4,@,nO,@,H,@,ev,@,eE,@,b,@,C,@,nG,@,e4,@,eh,@,S,@,fz,@,tg,@,tb,@,eJ,@,tx,@,n_,@,na,@,nQ,@,eo,@,nI,@,J,@,fq,@,fA,@,fB,@,fD,@,fF,@,fH,@,N,@,nC,@,t6,@,eg,@,fJ,@,t8,@,fK,@,fM,@,fN,@,fQ,@,np,@,ty,@,fR,@,fS,@,t7,@,fU,@,t9,@,z,@,E,@,v,@,fV,@,fW,@,tk,@,X,@,eb,@,ex,@,nd,@,fY,@,fZ,@,oe,@,on,@,ot,@,of,@,tj,@,ni,@,nr,@,n0,@,oo,@,o_,@,oa,@,n1,@,e6,@,od,@,nw,@,f,@,n3,@,oi,@,nR,@,tz,@,tq,@,e_,@,eK,@,nm,@,tA,@,o0,@,n4,@,tB,@,nS,@,nU,@,ng,@,o1,@,nV,@,nc,@,e8,@,om,@",r,F,nL,function(e)
return F(r"nb,0,tD,0,tF,~eu,l,~L,ea,~L,eG,#;",e)
end,function(_ENV,e)
if e==ey then
return ed and nb/ed or 0
end
if _ENV[e]and _ENV[e].oc then
return 1
end
return 0
end,function(_ENV,e)
nx=e or next
end,function(_ENV,e)
nb,nx,tF,next,ed=0
_ENV[ey].oc=true
for e,n in pairs(tH)do _ENV[e]=n end
for n,t in pairs(_ENV[e])do _ENV[n]=t end
ey=e
_ENV:l()
tD=#eG
end,function(_ENV)
nb+=1/60
if tF then _ENV:t3(ey)end
if ed and nb>=ed then
_ENV:Z()
end
while nx do
_ENV:t3(nx)
end
_ENV:ea()
end,function(_ENV,e)
while nx~=e and#eG>0do
_ENV:H()
end
end,function(_ENV)
deli(eG)
_ENV:Z(eG[#eG]or"eM")
end,function(_ENV,e)
add(eG,e)
_ENV:Z(e)
end,function()
U"153"
end,function(e)
return flr(rnd(e))
end,function(e,n,...)
foreach(r(n,...),function(n)
e(unpack(n))
end)
end,function(t,f,o)
local e,n=%0x5f28,%0x5f2a
camera(e-t,n-f)
o()
camera(e,n)
end,function(e)
eN(e or"",23,4,1,0)
end,function(e)
C(rectfill,";,0,0,45,6,1")
C(eN,";,@,23,1,13,0;;,@,23,8,1,0;;,@,23,15,1,0",unpack(split(e,"|",false)))
end,r"",split"missingno,bulbasaur,ivysaur,venusaur,charmander,charmeleon,charizard,squirtle,wartortle,blastoise,caterpie,metapod,butterfree,weedle,kakuna,beedrill,pidgey,pidgeotto,pidgeot,rattata,raticate,spearow,fearow,ekans,arbok,pikachu,raichu,sandshrew,sandslash,nidoran f,nidorina,nidoqueen,nidoran m,nidorino,nidoking,clefairy,clefable,vulpix,ninetales,jigglypuff,wigglytuff,zubat,golbat,oddish,gloom,vileplume,paras,parasect,venonat,venomoth,diglett,dugtrio,meowth,persian,psyduck,golduck,mankey,primeape,growlithe,arcanine,poliwag,poliwhirl,poliwrath,abra,kadabra,alakazam,machop,machoke,machamp,bellsprout,weepinbell,victreebel,tentacool,tentacruel,geodude,graveler,golem,ponyta,rapidash,slowpoke,slowbro,magnemite,magneton,farfetchd,doduo,dodrio,seel,dewgong,grimer,muk,shellder,cloyster,gastly,haunter,gengar,onix,drowzee,hypno,krabby,kingler,voltorb,electrode,exeggcute,exeggutor,cubone,marowak,hitmonlee,hitmonchan,lickitung,koffing,weezing,rhyhorn,rhydon,chansey,tangela,kangaskhan,horsea,seadra,goldeen,seaking,staryu,starmie,mr mime,scyther,jynx,electabuzz,magmar,pinsir,tauros,magikarp,gyarados,lapras,ditto,eevee,vaporeon,jolteon,flareon,porygon,omanyte,omastar,kabuto,kabutops,aerodactyl,snorlax,articuno,zapdos,moltres,dratini,dragonair,dragonite,mewtwo,mew",r"0,none;,fainted,burned,frozen,paralyzed,poisoned,sleeping",r"0, ;,FNT,BRN,FZN,PAR,PSN,SLP",r"0;m,2,n,~fj;1;m,2,n,normal,15,0,13,.5;2;m,10,n,fire,8,2,10,2,11,2,2,.5,4,.5,13,.5,14,.5;3;m,7,n,fighting,10,2,1,2,13,2,15,0,11,.5,9,.5,5,.5,12,.5;4;m,9,n,water,2,2,7,2,13,2,14,.5,8,.5,4,.5;5;m,6,n,poison,11,2,8,2,15,.5,7,.5,5,.5,13,.5;6;m,11,n,electric,9,2,4,2,7,0,14,.5,6,.5,8,.5;7;m,7,n,ground,6,2,2,2,5,2,13,2,9,0,11,.5,8,.5;8;m,8,n,grass,7,2,13,2,4,2,11,.5,14,.5,2,.5,9,.5,8,.5,5,.5;9;m,2,n,flying,11,2,3,2,8,2,6,.5,13,.5;10;m,9,n,ice,14,2,9,2,8,2,2,.5,10,.5,4,.5;11;m,8,n,bug,8,2,12,2,3,.5,2,.5,9,.5,15,.5,5,.5;12;m,6,n,psychic,3,2,5,2,12,.5;13;m,2,n,rock,11,2,2,2,9,2,10,2,3,.5,7,.5;14;m,2,n,dragon,14,2;15;m,6,n,ghost,15,2,1,0,12,2;17;m,2,n,bird;",r"V,hp,ei,spc,Q,att,q,def,K,spd,n6,tot,A,acc,eI,eva",r";m,13,er,5,nu,1;;m,6,er,13,nu,13;;m,5,er,5,nu,1;;m,6,er,5,nu,5;;m,1,er,5,nu,13;;m,14,er,4;;m,9,er,4;;m,11,er,3;;m,12,er,5;;m,8,er,2;;m,10,er,4",r"",split"youngstr,bugcatch,junior,brock,lass,hiker,swimmer,misty,gentlman,sailor,rocker,ltsurge,channelr,gambler,beauty,erika,biker,birdkeep,juggler,koga,blckbelt,rocket,psychic,sabrina,scientst,pkmaniac,suprnerd,blaine,cooltrnr,fishrman,tamer,giovanni,lorelei,bruno,agatha,lance,blue,green,red,legendry",function(e,n)
if n.ee then
e:ev(n.ee)
else
e:H()
end
end,function(e,n)
return r("ou,@,tJ,@,R,~tJ,x,1,ea,~fD,e0,~fH,nl,~fA,M,~fq",e,n or 0)
end,function(e,n)
return F(nI(e),"p,0,x,@,ea,~fF,nW,~fB",n or 1)
end,function(e,n,f)
while deli(e)do end
for t=1,#n do
add(e,(f or L)(n[t],t))
end
end,function(e)
e:H()
end,function(e,n,t)
if t then
local t=e.p+n*e.x
if t==mid(0,t,#e-1)then
e.p=t
if 0+n~=0then U"154"end
else
eE()
end
else
local t=e.p+n
local f=e.p-e.p%e.x
if t==mid(f,t,f+e.x-1)then
e.p=t
if 0+n~=0then U"154"end
else
eE()
end
end
e.p=mid(0,e.p,#e-1)
if e.p\e.x<e.R then e.R=e.p\e.x end
if e.p\e.x>e.R+2then e.R=e.p\e.x-2end
e.R=mid(0,e.R,(#e-1)\e.x)
end,function(n)
local e=n.a
if eQ then U"154"e.nl(n)end
if e7 then n:n8()end
e.R+=nY
if nZ~=0then n:tK(nZ)end
local n=e.R
e.R=mid(e.tJ,e.R,#e-3)
if e.R~=n then
eE()
elseif nY~=0then
U"154"
end
end,function(t)
local e=t.a
e:nW"0"
e:nW(nY,true)
e:nW(nZ)
if e7 then
local n=e[e.p+1]
if n.e1 then
eE()
elseif n.I then
U"155"
n.I(t,n)
end
end
if eQ then U"154"e.nl(t)end
end,function(n)
local e=n.a
local f=e.x>1and 10or 40
local a=20-(e.x*f)/2
C(rectfill,";,0,0,39,39,1;;,0,@,39,@,13",5-e.R*10,4+(max(ceil(#e/e.x),3)-e.R)*10)
for n=-1,e.x*5-1do
local d=(e.R-1)*e.x+n+1
local t=e[d]
if t then
local o,i,r=t.ny or 1,a+n%e.x*10,n\e.x*10
if t.e1 then o=3end
if d-1==e.p then o+=1end
if not t.te then
rectfill(i,r-5,i+f-1,r+4,n_[o].m)
nG(n%e.x*f+a+f/2,n\e.x*10-3,function()
e.ou(t,n_[o])
end)
end
end
end
end,function(e,n)
if e.en then
local n=n_[eJ[e.en.eX].m]
C(rectfill,";,-20,-2,19,17,@;;,-20,14,19,17,@",n.m,n.er)
e.en:n7(0,8,n,1,1)
else
tM(e.n,0,0,n.nu)
end
end,function(e,n)
e.en:n7(0,3,n,.375,.375)
end,function(n)
local e=nU(n.y)
del(e,n.o.W)
if#e>0then
return e[b(#e)+1]
end
end,function(_ENV,e)
local n=nT[e]
if e=="eI"or e=="A"then
return _ENV[e]*mid(1,1+n/3,3)/mid(1,1-n/3,3)
end
return ceil(mid(1,999,
(e=="Q"and T==2and.5or e=="K"and T==4and.25or 1)*
_ENV[e]*mid(2,2+n,8)/mid(2,2-n,8)
))
end,function(_ENV)
end,function(_ENV,t,n)
local e=B(t,n)
e.e9,e.tN=5,5
w[n]=e
return e
end,function(_ENV)
local n=tn(c,true)
local t=n[b(#n)+1].d
if t==31then
return true
end
i(O,"|copies|"..t8(e,t,u.el).n)
end,function(_ENV)
if e.ol then
return true
else
i(O,"|copies|"..c.n,function()
e.ol=true
foreach(split"d,Q,q,K,ei,eX,eC",function(n)
e[n]=c[n]
end)
e.w={}
foreach(c.w,function(n)
t8(e,n.d,n.el)
end)
end)
end
end,function(_ENV)
F(e,"eX,@,eC,@",c.eX,c.eC)
i(O,"|copies|types")
end,function(_ENV)
foreach({e2,O},function(e)
i(e,"|resets|stats",function()
F(e.o.nT,"ei,0,Q,0,q,0,K,0,A,0,eI,0")
e.o.tQ=false
end)
end)
end,function(_ENV,n,e)
e=min(e,n.o.V-n.o.D)
if e>0then
tz(_ENV,n,e,function()
n.o.W.D+=e
end)
else
return true
end
end,function(_ENV)
return np(_ENV,O,e.V\2)
end,function(_ENV)
tt(O,B(b(164)+1,u.el))
end,function(_ENV)
if e.tf>0then
tt(O,B(e.tf,u.el))
else
return true
end
end,function(_ENV)
local e=t6(e2)
if e then
to(e2,e)
else
return true
end
end,function(_ENV)
local e=t6(O)
if e then
to(O,e)
else
return true
end
end,function(e,n)
return(sgn(e)>0and"|+"or"|-")..abs(e).." "..n.."|change"
end,function(_ENV,e,...)return e(_ENV,O,...)end,function(_ENV,e,...)return e(_ENV,e2,...)end,function(_ENV,e,n,t,o)
local f=e.o.nT[n]
if not e.o.oT or t>0then
e.o.nT[n]=mid(-6,6,f+t)
end
if f~=e.o.nT[n]then
i(e,t9(t,tx[n]),o or L)
else
return true
end
end,function(_ENV)
if X(_ENV,5)and c.T~=5then
return true
end
return E(_ENV,eb,"|badly|poisoned","n9",1,true)
end,function(_ENV)
i(O,"|does|nothing")
end,function(_ENV)
return t_(u,c)>0and u.eL~=c.eX and u.eL~=c.eC
end,function(_ENV,n)
if c.W.T==3and n==2then
i(O,"|thawed|out")
e.W.T=0
elseif c.W.T==0and(n==6or tk(_ENV))then
i(e2,"|is now|"..tg[n],function()
c.W.T=n
c.ta=b"7"+1
end)
else
return true
end
end,function(_ENV,e,t,n,f,o)
if(e.o[n]or 0)==0and(not o or tk(_ENV))then
e.o[n]=f or 1
i(e,t)
else
return true
end
end,function(_ENV,e)
e.o.tR=true
end,function(_ENV,e)
return eb(_ENV,e,"|becomes|confused","nk",b"4"+1)
end,function(_ENV)
return v(_ENV,O,"eI",1,function()
e.tQ=.25
end)
end,function(_ENV)
local n=e.V\4
if n>=e.D or e.ep>0then
return true
end
eK(_ENV,n)
i(O,"|created|substitute",function()
e.ep=n
end)
end,function(_ENV)
ek(e,-1,u)
f(_ENV)
if u.e9<=0then
e.e5,e.g=0
end
end,function(_ENV)
if not e.g then
ek(e,b"2"+1,B(u.d,u.el))
i(O,"|"..u.n.."|begins")
e.nj=0
end
if e.e5==0then
if e.nj==0then
return true
end
e_(_ENV,e.nj*2)
end
end,function(_ENV)
e_(_ENV,1+b"75")
end,function(_ENV)
e_(_ENV,max(c.D\2,1))
end,function(_ENV)
ek(e,b"2"+1,B(u.d,u.el))
f(_ENV)
if e.e5==0then
z(_ENV,nd,"nk")
end
end,function(_ENV)
if not e.g then
ek(e,b"4"+1,B(u.d,u.el))
e.ns=c
end
if e.ns==c then
f(_ENV)
else
return true
end
end,function(_ENV,n)
if e.g then
f(_ENV)
else
i(O,n,function()
ek(e,1,B(u.d,u.el))
end)
end
end,function(_ENV)
if e.g then
f(_ENV)
else
i(O,"|charges|energy")
ek(e,1,u)
u.e9+=1
end
end,function(_ENV)
if e.g then
i(O,"|recharges|energy")
else
f(_ENV)
local n=B(u.d,u.el)
n.A=0
ek(e,1,n)
end
end,function(_ENV)
i(O,"|is|sleeping",function()
e.W.T,e.ta=6,2
np(_ENV,O,e.V)
end)
end,function(_ENV)
if e.nz>0then
e_(_ENV,e.nz*2)
else
return true
end
end,function(_ENV,e,n,t)
if e>0then
i(O,t and"|resumes|"..u.n,function()
_ENV.c=e2.o
f(_ENV,100,function()
n1(_ENV,e-1,n,true)
end)
end)
else
n()
end
end,function(_ENV,e)
n1(_ENV,2+b"4",L)
end,function(_ENV)
n1(_ENV,2,function()
if rnd"100"<20then
X(_ENV,5)
end
end)
end,function(_ENV)
e_(_ENV,false,function(e)
eK(_ENV,max(1,e\4))
end)
end,function(_ENV,e,n,...)
local t={...}
e_(_ENV,false,function()
if rnd"100"<(e or 0)then
n(_ENV,unpack(t))
end
end)
end,function(_ENV)
e_(_ENV,false,function(e)
np(_ENV,O,max(e\2,1))
end)
end,function(_ENV)
if c.T==6then
n3(_ENV)
else
return true
end
end,function(_ENV)
if e.K>=c.K then
e_(_ENV,c.D)
else
return true
end
end,function(_ENV,n,t,a,e)
local f=t9(t,"hp")
local o=e and n.o.ep+t<0
if not e or o then
i(n,f,L,e)
end
i(n,
o and"|substitute|broke"or f,
a,
e
)
end,function(_ENV,t,n,a,f)
local e=t.o
local o=not a and e.ep>0
tz(_ENV,t,-n,function()
e.nj+=n
if e.g and e.g.d==20then
v(_ENV,t,"Q",1)
end
if f then f(n)end
if o then
e.ep=max(e.ep-n,0)
else
e.W.D=max(e.W.D-n,0)
end
end,o and"substitute")
end,function(_ENV,n,o)
local f,t=false,t_(u,c)
if not n then
n,f=tS(e,c,u)
end
if t>0then
if u.eL%2==1then
c.nz+=n
end
if t>1then i(O,"|super|effective")
elseif t<1then i(O,"|not very|effective")end
if f then i(O,"|critical|hit")end
tq(_ENV,e2,n,false,o)
else
i(e2,"|resisted|attack")
end
end,function(_ENV,e)
tq(_ENV,O,e,true,L)
end,function(e)
return ceil(e+.5*93)+5
end,function()
return r("et,~eu,Q,0,q,0,ei,0,K,0,V,0,D,0,n6,0,A,100,eI,100,tU,0,tV,0,tW,0,td,0,tY,0,d,-1,os,-1,n, ,eX,0,eC,0,eR,#,eS,#,nq,#,w,@",nA())
end,function()
local e=peek2"0x8"
S[-1]=tA()
for t=0,151do
local n,f={},false
while@e~=255do
if@e==254then
f=true
elseif f then
for t=n[#n]+1,@e do
add(n,t)
end
f=false
else
add(n,@e)
end
e+=1
end
e+=1
local f=t-deli(n,1)
local e=tA()
F(e,"d,@,os,@,n,@,eX,@,eC,@,tU,@,tV,@,tW,@,td,@,tY,@",t,
f,
fz[t+1],
unpack(n)
)
local o=e.eR
for f=8,#n do
local t=n[f]
if t==253then
o=e.eS
elseif t==252then
o=e.nq
else
add(o,t)
end
end
if f<t then
foreach(split"eR,eS,nq",function(n)
foreach(S[f][n],function(t)
add(e[n],t)
end)
end)
end
local n,f={},{}
foreach(e.eS,function(e)n[e]=true end)
for e=1,54do
if n[e]then add(f,e)end
end
e.eS=f
do local _ENV=e
F(_ENV,"Q,@,q,@,ei,@,K,@,V,@,D,~V",nm(tV),
nm(tW),
nm(tY),
nm(td),
nm(tU)+55
)
n6=Q+q+ei+K+V
end
S[t]=e
end
end,function(e,n)
return setmetatable(r("w,@,T,0,et,~j",n),{__index=S[e]})
end,function(e)
foreach(nS(e.y),function(e)
poke(0x5e5a+e.d,1)
end)
end,function(e)
local n={}
foreach(e,function(e)
if e.d>-1and e.T==1then
add(n,e)
end
end)
return n
end,function(e,t)
local n={}
foreach(e,function(e)
if e.d>(t and 0or-1)and e.T~=1then
add(n,e)
end
end)
return n
end,function(e)
return nU(e)[1]
end,function(e)
local n=e:ej"k"
n[e:G"em"+1]=n4(-1,nA())
e8(e:G"k",n)
e:H()
end,function(e,o,n)
local t,f=S[n],nA()
for e=1,min(4,#t.eR)do
f[e]=B(t.eR[e],e)
end
e[o]=n4(n,f)
return e
end,function(e)
local a=tZ[e]
local e=r""
for t=1,6do
local f,n,o=a+(t-1)*5,{},false
for e=1,4do
n[e]=B(peek(f+e),e)
if n[e].d>0then
o=true
else
n[e]=B(-1)
end
end
e[t]=n4(o and@f or-1,n)
end
return e
end,function(e,o)
local n=tZ[e]
memset(n,0,30)
for t=1,6do
local f,e=n+(t-1)*5,o[t]
poke(f,max(0,e.d))
for n=1,4do
poke(f+n,e.w[n].d>0and e.w[n].d or 0)
end
end
end,function()
for e=-1,164do
local n,t={},deli(nB[e],6)
for t=6,#nB[e]do
add(n,deli(nB[e],6))
end
na[e]=r("ov,@,d,@,eU,@,n,@,eL,@,e9,@,tN,~e9,ti,@,A,@",function(e)
return t(e,unpack(n))
end,e,t,unpack(nB[e]))
end
end)
F(Y,"B,@,nA,@,tr,@,t0,@,t1,@,tm,@,tc,@,eV,@,oh,@,o2,@,fe,@,eW,@,tu,@,nv,@,tl,@,fn,@,ft,@,o5,@,ff,@,eY,@,oP,@,fo,@,oE,@,oX,@,f_,@,oL,@,oO,@,fa,@,oG,@,oI,@,oC,@,op,@,ow,@,fd,@,o3,@,o4,@,og,@,ob,@,ox,@,nh,@,aG,@,o6,@,o8,@,oy,@,o7,@,o9,@,ok,@,oj,@,oz,@,oq,@,oA,@,oB,@,oD,@,oF,@,oH,@,fi,@,G,@,ew,@,oJ,@,fr,@,oK,@,f0,@,U,@,eT,@,f1,@,tM,@,eN,@,eZ,@,oM,@,fm,@,n7,@,oN,@,oQ,@,oR,@,fc,@,oS,@,oU,@,ej,@,n2,@,nD,@,nF,@,to,@,tt,@,ek,@,oV,@,nH,@,oW,@,nJ,@,ne,@,n5,@,nP,@,oY,@,oZ,@,fu,@,fl,@,tn,@,fT,@,t_,@,tS,@,fs,@",function(e,n)
return setmetatable(r("el,@",n or 0),{__index=na[e]})
end,function()
local e={}
for n=1,4do add(e,B(-1))end
return e
end,function(e)
fi(e)
tM("team #"..e:G"k"+1,20,27,1)
end,function(_ENV)
local t,e,n=ez.o,eO.o,eq.o
local o,a=e==t,n==t
local t,f=11,11
C(rectfill,";,0,0,39,6,5;;,0,33,39,39,5")
C(rectfill,";,-1,33,@,41,1;;,-1,-2,@,6,1",max(ceil(e.D/e.V*40),0)-1,
max(ceil(n.D/n.V*40),0)-1)
C(rectfill,";,15,6,39,6,13;;,16,5,39,5,13;;,0,33,24,33,13;;,0,34,23,34,13")
C(eN,";,@,40,34,13,1;;,@,40,27,1,1;;,@,2,1,13,-1;;,@,2,7,1,-1",e.D,tb[e.T],n.D,tb[n.T])
local t,f=1,1
e:n7(10,25,n_[4],t,t,o)
n:n7(30,15,n_[4],-f,f,a)
end,function(e)oM(S[e:G"et"])end,function(e)e4("spot #"..(e:G"em"+1))end,function(e)e4("move #"..(e:G"eP"+1))end,function(e)e4(e.nn)end,function(e)e4"match over"end,function(n)
local e=n:ew"nK"
e4(e and e.ae)
end,function()
rectfill(0,0,46,13,13)
pal(7,1)
local e=0
for f,n in ipairs(split"6,5,5,6,6,5,6")do
sspr(6*8+e,6*8,n,8,e+3,3.5+cos((t()+f)/4))
e+=n
end
pal()
end,function(e)e4(e.ez.an.n)end,function(e)
fm(e:n2())
end,function(n)
local e=n:ew(n.fv).u
if e.d>=0then
eh(eJ[e.eL].n.."|"..e.e9.."/"..e.tN.."|"..(e.ti>=0and e.ti or"??").."P "..(e.A>=0and e.A or"??").."A")
else
eh"none|n/a|"
end
end,function(e)
fm(e:ew"et".en)
end,function(e)
eh(e:ew"eM".e3)
end,function(_ENV)
if d>-1then
eh(n.."|"..D.."/"..V.."|"..tg[T])
else
eh"none|n/a|"
end
end,function(_ENV)ft(_ENV:ew"tT".en)end,function(_ENV)ft(s.o)end,function(e)
local n,t=0,0
foreach(e:ew().y,function(e)
if e>-1then
n+=S[e].n6
t+=1
end
end)
eh(e:ew().n.."|len "..t.."/6|tot "..n)
end,function(e)
eh(e.nt.n.."|is the|winner")
end,function(e)
eh(e.ez.n..e.ez.fh)
end,function(_ENV)
local n=ne(_ENV,nt)
nt:at(n)
a:M{}
a.nl=function(e)
e:nO"ts"
end
for e in all{nt,n}do
F(a,"R,0;;en,@;;te,~eu;;n,@,ny,5;;n,@;;n,@",e.o.W,e.n,(#nU(e.y,true)).." live",(#nS(e.y)).." dead")
end
end,function(_ENV)
local e=0
for n=0,151do e+=S[n]:eZ()and 1or 0end
a:M(
r(";n,browse,ee,et,I,~eo,e3,@;;n,edit,ee,k,I,~eo,e3,edit|stored|teams;;n,league,ee,f2,I,~eo,e3,@;;n,versus,ee,tv,I,~eo,e3,versus|p1 vs p2|match;;n,horde,ee,f5,I,~eo,e3,@;;n,credits,ee,fP,I,~eo,e3,credits|amorg|games","browse|"..e.."/151|pokemon","league|"..(@0x5efd).."/40|trainers","horde|"..(@0x5efe).."/151|hi-score")
)
end,function(_ENV,n)
local e={}
for n=0,151do
add(e,n)
end
a:M(
e,
function(e)
return r("I,@,e1,@,en,@",n,not S[e]:eZ(),S[e])
end
)
end,function(_ENV)
f_(_ENV,function(_ENV)
_ENV:ev"fE"
end)
end,function(_ENV)
f_(_ENV,function(_ENV)
e8(_ENV:G"k",nV(_ENV:ej"k",_ENV:G"em"+1,_ENV:G"et"))
_ENV:H()
end)
end,function(_ENV)
local e=_ENV:ew"et".en
a:M{}
F(a,";en,@;;te,~eu;;n,lvl 50,ny,5",e)
foreach(split"V,ei,Q,q,K,n6",function(n)
add(a,{n=tx[n].." "..e[n]})
end)
C(function(t,n)
if#S[e.d][n]>0then
add(a,{n=t,ny=5})
foreach(S[e.d][n],function(e)
add(a,{n=na[e].n})
end)
end
end,";,learn,eR;;,teach,eS;;,event,nq")
end,function(_ENV)
a:M(
split"91,,#alanxoc3,code &,design,28,,#gr8cadet,pokemon,sprites,143,,#tigrwolf,battle,testing,127,,#tooling,px9 func,shrinko8,137,,#pkmndata,blbpedia,pokeapi,serebii,smogon,upokcntr,volvox,nintendo",
function(e)
if type(e)=="number"then
return{en=n4(e,nA())}
end
local n=1
if sub(e,1,1)=="#"then
e,n=sub(e,2),5
end
return{n=e,ny=n,te=e==""}
end
)
end,function(_ENV)
a:M(nQ,function(e,n)
return{
n=e.n,
y=e,
e1=n-1>@0x5efd,
I=function(t,e)
fX(t,e.y,e.n,function(t,e)
poke(0x5efd,mid(@0x5efd,n,40))
tB(e)
end,L)
end
}
end)
end,function(_ENV)
a:M(r";n,moves,ee,eP,I,~eo;;n,switch,ee,th,I,~eo;;n,delete,I,~o1")
end,function(_ENV)
local n=_ENV:n2()
local e=0
for t=1,4do
if n.w[t].d>0then e+=1end
end
a:M(r(";n,change,ee,nK,I,~eo;;n,switch,ee,fL,I,~eo;;n,delete,e1,@,I,~ow",e==1))
end,function(_ENV)
local e,n=_ENV:n2()
e.w[_ENV:G"eP"+1]=B(-1)
e8(_ENV:G"k",n)
_ENV:H()
end,function(_ENV,f,o)
local n,d=_ENV:n2()
a:M(r",1,2,3,4",function(e)
local t=n.w[e]
return{
u=t,
n=t.n,
I=function(_ENV)o(_ENV,e,n,d)end,
e1=e==f
}
end)
end,function(_ENV)
fd(_ENV,0,function(_ENV,e,n)
_ENV:ev(n.w[e].d>0and"fO"or"nK")
end)
end,function(_ENV)
local n=_ENV:G"eP"+1
fd(_ENV,n,function(_ENV,t,e,f)
e.w[t],e.w[n]=e.w[n],e.w[t]
e8(_ENV:G"k",f)
_ENV:nO"eP"
end)
a.p=eP.a.p
end,function(_ENV)
local n=_ENV:n2()
local e=S[n.d]
local t={}
C(function(f,a)
for o=1,#f do
local e=f[o]
add(t,{n=na[e].n,e1=n:fu(e),d=e,e3=a..o})
end
end,";,@,learn #;;,@,teach #;;,@,event #",e.eR,e.eS,e.nq)
a:M(t,function(e)
return{
n=e.n,
e1=e.e1,
u=na[e.d],
ae=e.e3,
I=function()
local n=_ENV:ej"k"
n[_ENV:G"em"+1].w[_ENV:G"eP"+1]=B(e.d)
e8(_ENV:G"k",n)
_ENV:nO"eP"
end
}
end)
end,function(_ENV)
local n=fT(s.o)
if s.o.g then
nJ(s,s.o.g)
_ENV:H()_ENV:H()
elseif#n==0then
nJ(s,B(0))
_ENV:H()_ENV:H()
end
a:M(s.o.w,function(e)
return r("e1,@,n,@,u,@,I,@",
not n[e],
e.n,
e,
function()
_ENV:H()_ENV:H()
nJ(s,e)
end
)
end)
end,function(_ENV)
a:M(r";n,fight,I,~eo,ee,fG;;n,switch,I,~eo,ee,tT;;n,forfeit,I,~af")
end,function(_ENV)
a:M(r",1,2,3",function(e)
local n=nc(e-1)
local t={}
local f=true
for e=1,6do
t[e]=n[e].d
if not n[e]:fl()then
f=false
end
end
return{
n="team #"..e,
y=t,
I=function()_ENV:nE()end,
e1=nX and f
}
end)
end,function(e,n)
return e[n]and e[n].d or-1
end,function(_ENV)
local e=_ENV:ej"k"
a:M(r",1,2,3,4,5,6",function(n)
return{
en=e[n],
I=function(_ENV)
if e[_ENV:G"em"+1]:eZ()then
_ENV:ev"fI"
else
_ENV:ev"fC"
end
end
}
end)
end,function(_ENV)
local e=_ENV:ej"k"
a:M(r",1,2,3,4,5,6",function(n)
return{
e1=n==_ENV:G"em"+1,
I=function(_ENV)
local n,t=_ENV:G"em"+1,_ENV:G"th"+1
e[n],e[t]=e[t],e[n]
e8(_ENV:G"k",e)
_ENV:nO"em"
end,
en=e[n]
}
end)
a.p=em.a.p
end,function(_ENV)
local e=_ENV:ej"k"
a:M(r",1,2,3,4,5,6",function(e)
local n=s.y[e]:fl()or s.o.W==s.y[e]or s.y[e].T==1
return{
e1=n,
I=function()
_ENV:H()_ENV:H()
to(s,s.y[e])
end,
en=s.y[e]
}
end)
end,function(_ENV)
local n,e=eO,eq
if n.eA==e.eA then e.eA+=sgn(rnd"2"-1)end
s=n.eA>e.eA and n or e
end,function(_ENV,e)
local n=true
for t=et.a.p+e,75.5+75.5*e,e do
if S[t]:eZ()then
et.a.p,n=t
U"154"
break
end
end
if n then eE()end
fa(_ENV)
end,function(e)U(e:G"et")end,function()U(b"152")end,function(_ENV)U(nt.o.d)end,function(_ENV)
local e={}
for t,n in pairs(split"133,7,35,1,25,4")do
nV(e,t,n)
poke(0x5e5a+n,1)
end
if@0x5efc==0then
poke(0x5efc,1)
e8(0,e)
end
ef=tp"ey,eM;tH;a,~j,l,~L,tK,~eE,n8,~L,ea,~oH,fv,~j,e0,~fi,h,~L,P,~L;eM;l,~oX,h,~fe,P,~fn;et;l,~oL,h,~t1,P,~tl;fE;l,~fa,h,~t1,P,~tl,tK,~o9,n8,~ok;em;l,~o6,h,~tm,P,~tu,e0,~tr;th;l,~o8,h,~tm,P,~tu,e0,~tr;fC;l,~oO,h,~t1,P,~tl;fI;l,~oC,h,~tm,P,~tu;fO;l,~op,h,~tc,P,~nv,fv,eP;nK;l,~og,h,~o2,P,~nv;eP;l,~o3,h,~tc,P,~nv;fL;l,~o4,h,~tc,P,~nv;k;nn,player,l,~nh,h,~eV,P,~eY,nX,~j,nE,~oU;f2;nn,player,l,~nh,h,~eV,P,~eY,nX,~eu,nE,~oN;tv;nn,player 1,l,~nh,h,~eV,P,~eY,nX,~eu,nE,~oQ;f5;nn,player,l,~nh,h,~eV,P,~eY,nX,~eu,nE,~oS;t2;nn,player 2,l,~nh,h,~eV,P,~eY,nX,~eu,nE,~oR;ts;nn,trainer,l,~oI,h,~eV,P,~eY;t5;l,~oE,h,~oh,P,~oP,n8,~oz;fp;l,~ox,h,~eW,P,~ff;fG;l,~ob,h,~eW,P,~nv;tT;l,~oy,h,~eW,P,~o5,e0,~tr;ao;next,a_,l,~fs,fw,eO;a_;next,f3,l,~fs,fw,eq;f3;next,ao,l,~o7,ea,~oY,e0,~t0,h,~eW,P,~fo,ez,~j;aa;l,~L,ea,~f4,e0,~t0,h,~eW,P,~ff;ad;l,~L,ea,~f4,e0,~t0,h,~eW,P,~fo;fP;l,~oG,h,~fe,P,~fn,n8,~oj;"
C(function(e,n,...)
ef[e].a=n(...)
end,";,et,~J,~nC,4;;,fE,~nI,~N;;,fP,~nI,~N;;,t5,~nI,~N;;,em,~J,~nC,3;;,th,~J,~nC,3;;,eM,~J,~N;;,fI,~J,~N;;,fO,~J,~N;;,nK,~J,~N;;,eP,~J,~N;;,fL,~J,~N;;,k,~J,~N;;,tv,~J,~N;;,ts,~J,~N;;,t2,~J,~N")
F(ef,"fg,@,ai,@;eM;a;nl,~eE;f5;a,~fg;f2;a,~fg;fC;a,~ai;",ef.k.a,ef.et.a)
menuitem(1,"close picodex",function()
menuitem(1)
menuitem(2)
_ENV:Z"tP"
end)
menuitem(2,"swap 🅾️/❎",function()
poke(0x5eff,@0x5eff==0and 1or 0)
end)
end,function(e)
e.ef:t4()
Y.tE\=2
end,function()nf.ef:e0()end,function()nf.ef:h()end,function()nf.ef:P()end,function(_ENV)a.ea(_ENV)end,function(_ENV)a.e0(_ENV)end,function(_ENV,e)
return _ENV[e].a.p
end,function(_ENV,e)
local n=e and _ENV[e].a or a
return n[n.p+1]
end,function(_ENV)
menuitem(1,"factory reset",function()
memset(0x5e00,0,0x100)
_ENV:Z"fb"
end)
end,function()
return btn()&0x3f~=0
end,function(_ENV)
if not fr()and nM then
nM=false
_ENV:Z()
menuitem(1)
elseif fr()then
nM=true
menuitem(1)
end
end,0,function(e)
Y.f0=max(0,0+e-152)
sfx(54+e\16,0,e%16*2,2)
end,function(_ENV)
cls"0"
nG(0,128+sin(_ENV:tw"fx"/4)*128,function()
C(eN,";,aMORG gAMES,64,-68,7,0;;,pRESENTS,64,-61,7,0;;,a pOKEMON bATTLE sIM,64,15,7,0")
C(spr,";,102,44,7,5,1")
local t,
n,
e=
ef and ef.eM.a.p,
ef and ef.tD-1,
ec=="nN"and 1
or ec=="eB"and-1
or(ec=="tX"and-1or 1)*cos(_ENV:tw(ec)/2)
nG(30-(e+1)*15+(ey=="fb"and b"3"-1or 0),27,function()
C(rectfill,";,14,18,@,87,5",63+max(0,e*54))
if eD==0then
C(rectfill,";,14,18,117,87,13")
C(function(e,n,t,f,o)
clip(-%0x5f28+e,-%0x5f2a+n,t,f)
nG(e,n,o)
clip()
end,";,14,21,40,40,@;;,71,18,46,13,@;;,71,67,46,21,@",e0,h,P)
end
C(map,";,24,0,2,1,8,3;;,8,0,2,9,8,11")
C(function(e,n,t,f,o,a)
return spr((eD<=e)and(f0==e and stat"46">=0and f or t)or n,o,a)
end,";,0,135,133,134,6,3;;,1,132,128,131,12,3;;,2,132,129,131,17,3;;,3,132,130,131,22,3")
C(function(e,n,t,f,o)
spr(btn(e)and n or t,f,o)
end,";,0,186,154,10,77;;,1,188,156,26,77;;,2,171,139,18,73;;,3,187,155,18,81;;,4,170,138,42,77;;,5,172,140,50,77")
if e<=0then
f1(0,2+64*(1-abs(e)),abs(e))
if e==-1and nM then spr(123,6,49)end
else
f1(16,62,e)
if e==1then
if t then spr(153,70+t*8,41)end
if n and n>=0then spr(153,70+n*8,49)end
end
end
end)
end)
end,function(f,t,e)
e*=64
for n=9,96do
tline(t,n,t+e-1,n,f,n/8-1.125,8/e,0)
end
end,function(n,e,t,f)
local o,a="",""
for e=1,#n do
local t,f=sub(n,e,e),e%2==0
o..=f and" "or t
a..=f and t or" "
end
eN(o,e,t,f,0)
eN(a,e,t+1,f,0)
end,function(e,n,f,o,t)
e=""..e
if t==0then n-=#e*2
elseif t>0then n-=#e*4+1end
print(e,n,f,o)
end,function(_ENV)
if d>=0then
return not et or@(0x5e5a+d)>0
end
end,function(e)
e4("pkmn #"..e.d)
end,function(e)
if e:eZ()then
eh(e.n.."|"..eJ[e.eX].n.."|"..eJ[e.eC].n)
else
eh"none|n/a|"
end
end,function(_ENV,n,t,i,f,o,m)
local e,a=_ENV:eZ()and d or-1,8*(tQ or 1)
f*=a o*=a
local a=function(t,a)
local n,d=e/8\1,e%8
if n~=f6 then
Y.f6=n
memcpy(0x0000,0x8000+0x400*n,0x400)
end
sspr(d*16,0,16,16,t-f,a-o,f*2,o*2)
end
foreach(r";,25,53,152;;,54,143,153",function(n)
if e==n[1]and _ENV:fu(n[2])then
e=n[3]
end
end)
if ep and ep>0then e=152end
if not ar or T~=1and not tL and not(e5~=0and g.eU==nr)then
if e<0then spr(107,n-4,t-4)return end
local e=1
local e=function(f,o,d,i,r,e)
if f>0then
for e=1,15do pal(e,f)end
for f=-1,1,2do
a(n+(o or f*e),t+(d or f*e))
a(n+(i or f*e),t+(r or f*e))
end
end
end
if m then
C(e,"m,@;;,~m,-2,~j,2,~j,1;;,~m,~j,-2,~j,2,1;;,~m,-2,0,2,0,1;;,~m,0,-2,0,2,1",i.m)
end
C(e,";,@,-1,~j,1,~j,1;;,1,~j,0,0,~j,1",i.er)
pal()a(n,t)
end
end,function(e)e:ev"ts"end,function(e)e:ev"t2"end,function(_ENV)
f8(_ENV,
r(",@,player 1,~j,~L",nc(_ENV:G"tv")),
r(",@,player 2,~j,~L",nc(_ENV:G"t2"))
)
end,function(_ENV)
poke(0x5efe,mid(@0x5efe,#nS(y),152))
end,function(_ENV)
local e={}
for n=1,152do add(e,n%152)end
fX(_ENV,e,"horde",function(n,e)
tB(e)
fc(e)
end,fc)
end,function(e)
e:ev"em"
end,function(e,n)
return nc(e:G(n))
end,function(e)
local n=nc(e:G"k")
return n[e:G"em"+1],n
end,function(e,n)
local f,t="|enters|fight",{}
foreach(n.w,function(e)
add(t,e)
end)
e.o=setmetatable(r("ar,~eu,tf,0,A,1,eI,1,e5,0,tL,~eu,nz,0,nj,0,a0,0,nk,0,ta,@,ep,0,n9,0,W,@,w,@;nT;ei,0,Q,0,q,0,K,0,A,0,eI,0",b"7"+1,n,t),{__index=n})
return n5(e,f,function()
e.o.tL=false
end)
end,function(e,n)
for t in all(split(n))do
if t==e then
return true
end
end
end,function(e,n)
nP(e,e,"|leaves|fight",function(t)
t.e.tL=true
nP(e,e,false,function()
add(e.eF,nD(e,n))
end)
end)
e.eA=3000
end,function(t,n)
local f=t.o.g and"|resumes|"or(n.eU==aI and"|begins|"or"|uses|")
nP(t,t,f..n.n,function(f)
f.u=n
local _ENV=f
if n.d>0then
n.e9-=1
end
if nF(n.d,"47,36 ")then
eK(_ENV,e.D)
end
if(function()
if n.A<=0then return false end
if(n.eU==n0 or n.eU==nr)and not e.g then return false end
if c.g and c.g.eU==nr then return true end
if e.g and e.g.eU==ni then return false end
return rnd(c:eg"eI")>n.A/100*e:eg"A"or b"256"==0and b"256"==0
end)()then
i(t,"|misses|"..n.n)
if nF(n.d,"145,73 ")then
eK(_ENV,1)
end
else
if n.ov(_ENV)then
i(t,"|fails|attack")
end
end
if n.A~=0then
c.tf=n.d
end
end)
end,function(_ENV,e,n)
if not g and e5==0then
e5,g=e,n
end
end,function(n,t)
nP(n,n,false,function(f)
f.u=t
local _ENV=f
e:nH("e5",L)
if e.T==6then
e:nH("ta",function()
i(n,"|suddenly|woke up")
e.W.T=0
end)
if e.T==6then
i(n,"|fast|asleep")
return
end
end
if e.T==3then
if rnd"1"<.2then
i(n,"|thawed|out")
e.W.T=0
else
i(n,"|is|frozen")
return
end
end
if c.ns==e then i(n,"|is|trapped")
elseif e.tO==t.el then i(n,"|is|disabled")
elseif e.T==4and b"4"==0then i(n,"|fully|paralyzed")
elseif e.tR then i(n,"|is|flinching")
else
if e.nk>0then
i(n,"|is|confused")
if b"2"==0then
i(n,"|hurt|itself")
eK(_ENV,tS(e,c,B(-1)))
return
end
end
tt(n,t)
end
end)
end,function(e,n,t)
if e[n]>0then
e[n]-=1
if e[n]==0then
t()
end
end
end,function(n)
return n5(n,false,function(_ENV)
if e.T==6
or e.T==3
or e.ns and e.ns~=c
then
e.e5=0
end
if e.e5==0then
e.ns,e.g=nil
end
local t=max(e.V\16,1)
local f=function(e)
i(n,e.."|damage")
eK(_ENV,t)
end
if e.T==5then
if e.n9>0then
t*=e.n9
e.n9+=1
end
f"|poison"
end
if e.T==2then f"|burn"end
if e.a1 then
f"|seed"
if c.D<c.V then
np(_ENV,e2,t)
end
end
e:nH("nk",function()
i(n,"|confusion|ended")
end)
e:nH("a0",function()
i(n,"|"..e.w[e.tO].n.."|enabled")
e.tO=0
end)
end)
end,function(e,n)
e.eF={}
local t=1000
oV(e,n)
if n.d==120then t=2000end
if nF(n.d,"18,4,89,30 ")then
t=0000
end
e.eA=min(3000,t+e.o:eg"K")
end,function(e,n)
return n==e.eO and e.eq or e.eO
end,function(e,n,t,f)
return{an=e,n=f or e.o.n,o=e.o,fh=n,am=t or L}
end,function(e,...)
add(e.eF,n5(...))
end,function(e)
if eQ then eE()end
if e7 then U"154"end
if e7 or not e.ez then
while true do
for n in all{e.eO,e.eq}do
if not ng(n.y)then
e.nt=ne(e,n)
e:Z"t5"
return
end
end
local n=oZ(e)
if n then
local f=n.o==e.eO.o and e.eO or e.eq
local t=r("u,@,O,@,e2,@,i,@",u,f,ne(e,f),function(...)
nP(f,...)
end)
t.e=t.O.o
t.c=t.e2.o
n.am(t)
if n.fh then
e.ez=n
return
else
end
else
e:Z()
return
end
end
end
end,function(n)
for t in all{n.eO,n.eq}do
if t.o.D<=0then
if t.o.T~=1then
return n5(t,"|has|fainted",function(_ENV)
e.W.T=1
end)
elseif t~=n.s then
return nD(t,ng(t.y))
end
end
end
for e in all{n.s,ne(n,n.s)}do
local t=ne(n,e)
while#e.eF>0do
local n=deli(e.eF,1)
if n.o.T~=1and(n.o==e.o or n.o==t.o)then
return n
end
end
if e.o.D<=0and e.o.T==1then
return nD(e,ng(e.y))
end
if not e.fy then
e.fy=true
return oW(e)
end
end
end,function(_ENV,e)
for n in all(w)do
if n.d==e then
return true
end
end
end,function(_ENV)
return#tn(_ENV,true)==0
end,function(t,f)
local n={}
foreach(t.w,function(e)
if e.d>0and(f or e.e9>0and t.tO~=e.el)then
add(n,e)
n[e]=true
end
end)
return n
end,function(_ENV)
if e5~=0then
return{g}
else
return tn(_ENV)
end
end,function(e,n)
return(eJ[e.eL][n.eX]or 1)*(eJ[e.eL][n.eC]or 1)
end,function(n,t,e)
local a,f=n:eg"ei",t:eg"ei"
if e.eL%2==1then
a,f=n:eg"Q",t:eg"q"
if t.ac then
f*=2
end
elseif t.au then
f*=2
end
local o=1024
if nF(e.d,"107,164,57,157 ")then o*=.3end
if al then o*=.3end
local d=rnd"1"<min(.99,(n.td+76)/o)and e.d>0and 2or 1
local o=mid(
3,997,
(100*d/5+2)/50
*e.ti
*mid(10,.2,a/f)
)+2
local a,f=o,t_(e,t)
*((e.eL==n.eX or e.eL==n.eC)and 1.5or 1)
*(rnd".15"+.85)
if f>0then
return max(1,a*f\1),d>1
end
return 0,false
end,function(_ENV)
s=_ENV[fw]
do local _ENV=s.o
nz,tR=0,false
end
s.fy=false
if s.aT then
local e=fT(s.o)
nJ(s,e[b(#e)+1]or B(0))
_ENV:Z()
elseif#s.eF>0then
_ENV:Z()
else
fp.a,
fG.a,
tT.a,
ez,
eG[#eG]=s.f7,
s.as,
s.av,
n5(s,"|begins|turn"),
ey
_ENV:Z"ad"
end
end)
F(Y,"f4,@,af,@,f8,@,fX,@,tG,@,ah,@,a2,@,f9,@,a5,@",function(_ENV)
if e7 then
_ENV:ev"fp"
U"155"
end
if eQ then eE()end
end,function(_ENV)
_ENV:H()
nt=_ENV:ne(s)
_ENV:Z"t5"
end,function(_ENV,e,t)
e.tI,t.tI="eO","eq"
for n in all{e,t}do
_ENV[n.tI]=r("eF,#,eA,1,f7,@,as,@,av,@,y,@,n,@,aT,@,at,@",J(N),
J(N),
J(nC,3),
unpack(n))
local e=_ENV[n.tI]
e.f7.nl=function()
_ENV:H()
_ENV:Z"aa"
end
add(e.eF,nD(e,ng(e.y)))
end
_ENV:ev"f3"
end,function(_ENV,e,t,f,o)
local n={}
for t=1,#e do
nV(n,t,e[t])
end
f8(_ENV,
{_ENV:ej"k","player",false,f},
{n,t,true,o}
)
end,function(e)
f9(peek2(e),
function(...)return ah(0x8000+e*0x1000,...)end,
function(...)return a2(0x8000+e*0x1000,...)end)
end,function(t,e,f)
e=min(max(0,e),127)\1
local n=peek(f\1*64+t+e\2)
if e%2==1then return(n&0xf0)>>>4
else return(n&0x0f)end
end,function(f,e,o,t)
e=min(max(0,e),127)\1
local n=o\1*64+f+e\2
local f=peek(n)
if e%2==1then poke(n,(f&0x0f)|(((t or 0)&0x0f)<<4))
else poke(n,(f&0xf0)|(((t or 0)&0x0f)<<0))
end
end,function(t,r,m)
local function a(e,f)
local n,t=e[1],1
while n!=f do
t+=1
n,e[t]=e[t],n
end
e[1]=f
end
local e,n=0,0
function fk(f)
if n<8then
n+=8
e+=@t>>n
t+=1
end
e<<=f
local t=e&0xffff
e^^=t
n-=f
return t
end
function no(n)
local e=0
repeat
e+=1
local t=fk(e)
n+=t
until t<(1<<e)-1
return n
end
local i,d,f,e,o,c,u,n,t=no"1",no"0",no"1",{},{},0,0,0
for n=1,no"1"do add(e,fk(f))end
for f=0,d do
for d=0,i-1do
n-=1
if(n<1)then
n,t=no"1",not t
end
local i=f>0and r(d,f-1)or 0
local n=o[i]or{unpack(e)}
o[i]=n
local o=n[t and 1or no"2"]
a(n,o)
a(e,o)
m(d,f,o)
end
end
end,function(e)
if e.eH then U(e.eH)end
e:tC()
end)
Y.nB=r"-1;,none,17,0,40,0,~f;0;,struggle,17,0,50,100,~nw;;,megapnch,1,20,80,85,~f;;,razrwind,1,10,80,75,~n0;;,sworddnc,1,30,0,0,~z,~v,Q,2;;,whrlwind,1,20,0,100,~t7;;,megakick,1,5,120,75,~f;;,toxic,5,10,0,85,~fV;;,horndril,1,5,-5,30,~nR;;,bodyslam,1,15,85,100,~f,30,~X,4;;,takedown,1,20,90,85,~nw;;,doubedge,1,15,100,100,~nw;;,bublbeam,4,20,65,100,~f,10,~E,~v,K,-1;;,watergun,4,25,40,100,~f;;,icebeam,10,10,95,100,~f,10,~X,3;;,blizzard,10,5,120,90,~f,10,~X,3;;,hyprbeam,1,5,150,90,~oo;;,payday,1,20,40,100,~f;;,submsion,3,20,80,80,~nw;;,counter,3,20,-5,100,~oa;;,seistoss,3,20,-5,100,~e_,50;;,rage,1,20,20,100,~oe;;,megdrain,8,10,40,100,~n3;;,solrbeam,8,10,120,100,~n0;;,drgnrage,14,10,-5,100,~e_,40;;,thndrblt,6,15,95,100,~f,10,~X,4;;,thunder,6,10,120,70,~f,10,~X,4;;,earthqke,7,10,100,100,~f;;,fissure,7,5,-5,30,~nR;;,dig,7,10,100,100,~nr,|begins|digging;;,psychic,12,10,90,100,~f,30,~E,~v,ei,-1;;,teleport,12,20,0,0,~fU;;,mimic,1,10,0,0,~fK;;,doubteam,1,15,0,0,~z,~v,eI,1;;,reflect,12,20,0,0,~z,~eb,|raises|defense,ac;;,bide,1,10,-5,100,~on;;,metrnome,1,10,0,0,~fR;;,selfdstr,1,5,260,100,~f;;,eggbomb,1,10,100,75,~f;;,fireblst,2,5,120,85,~f,30,~X,2;;,swift,1,20,60,-5,~f;;,skulbash,1,15,100,100,~n0;;,softboil,1,10,0,0,~ty;;,dreameat,12,15,100,100,~oi;;,skyattck,9,5,140,90,~n0;;,rest,12,10,0,0,~o_;;,thndrwav,6,20,0,100,~X,4;;,psywave,12,15,-5,80,~ot;;,explsion,1,5,340,100,~f;;,rockslid,13,10,75,90,~f;;,triattck,1,10,80,100,~f;;,substute,1,10,0,0,~fZ;;,cut,1,30,50,95,~f;;,fly,9,15,70,95,~nr,|begins|flying;;,surf,4,15,95,100,~f;;,strength,1,15,80,100,~f;;,flash,1,20,0,70,~E,~v,A,-1;;,pound,1,35,40,100,~f;;,karatchp,3,25,55,100,~f;;,doubslap,1,10,15,85,~e6;;,comtpnch,1,15,20,85,~e6;;,firepnch,2,15,75,100,~f,10,~X,2;;,icepnch,10,15,75,100,~f,10,~X,3;;,thndpnch,6,15,75,100,~f,10,~X,4;;,scratch,1,35,40,100,~f;;,vicegrip,1,30,55,100,~f;;,guilotin,1,5,-5,30,~nR;;,gust,9,35,40,100,~f;;,wingatck,9,35,35,100,~f;;,bind,1,20,15,75,~ni;;,slam,1,20,80,75,~f;;,vinewhip,8,10,35,100,~f;;,stomp,1,20,65,100,~f,30,~E,~ex;;,doubkick,3,30,30,100,~n1,2,~L;;,jumpkick,3,20,70,95,~f;;,rllngkck,3,15,60,85,~f,30,~E,~ex;;,sandatck,7,15,0,100,~E,~v,A,-1;;,headbutt,1,15,70,100,~f,30,~E,~ex;;,hornatck,1,25,65,100,~f;;,furyatck,1,20,15,85,~e6;;,tackle,1,35,35,95,~f;;,wrap,1,20,15,85,~ni;;,thrash,1,20,90,100,~tj;;,tailwhip,1,30,0,100,~E,~v,q,-1;;,psnsting,5,35,15,100,~f,20,~X,5;;,twineedl,11,20,25,100,~od;;,pinmisil,11,20,15,85,~e6;;,leer,1,30,0,100,~E,~v,q,-1;;,bite,1,25,60,100,~f,10,~E,~ex;;,growl,1,40,0,100,~E,~v,Q,-1;;,roar,1,20,0,100,~t7;;,sing,1,15,0,55,~X,6;;,sprsonic,1,20,0,55,~E,~nd;;,sonicbom,1,20,-5,90,~e_,20;;,disable,1,20,0,55,~fJ;;,acid,5,30,40,100,~f,10,~E,~v,q,-1;;,ember,2,25,40,100,~f,10,~X,2;;,flamthwr,2,15,95,100,~f,10,~X,2;;,mist,10,30,0,0,~z,~eb,|stat lower|immunity,oT;;,hydropmp,4,5,120,80,~f;;,psybeam,12,20,65,100,~f,10,~E,~nd;;,aurorabm,10,20,65,100,~f,10,~E,~v,Q,-1;;,peck,9,35,35,100,~f;;,drillpck,9,20,80,100,~f;;,lowkick,3,20,50,90,~f,30,~E,~ex;;,absorb,8,20,20,100,~n3;;,leechsed,8,10,0,90,~E,~eb,|is now|seeded,a1,1,~eu;;,growth,1,40,0,0,~z,~v,ei,1;;,razrleaf,8,25,55,95,~f;;,psnpowdr,5,35,0,75,~X,5;;,stunspor,8,30,0,75,~X,4;;,slppowdr,8,15,0,75,~X,6;;,petldanc,8,20,70,100,~tj;;,strngsht,11,40,0,95,~E,~v,K,-1;;,firespin,2,15,15,70,~ni;;,thndshck,6,30,40,100,~f,10,~X,4;;,rockthrw,13,15,50,65,~f;;,cnfusion,12,25,50,100,~f,10,~E,~nd;;,hypnosis,12,20,0,60,~X,6;;,meditate,12,40,0,0,~z,~v,Q,1;;,agility,12,30,0,0,~z,~v,K,2;;,quickatk,1,30,40,100,~f;;,ngtshade,15,15,-5,100,~e_,50;;,screech,1,10,0,85,~E,~v,q,-2;;,recover,1,20,0,0,~ty;;,harden,1,30,0,0,~z,~v,q,1;;,minimize,1,20,0,0,~fY;;,smokscrn,1,20,0,100,~E,~v,A,-1;;,cnfusray,15,10,0,100,~E,~nd;;,withdraw,4,40,0,0,~z,~v,q,1;;,dfnscurl,1,40,0,0,~z,~v,q,1;;,barrier,12,30,0,0,~z,~v,q,2;;,lghtscrn,12,30,0,0,~z,~eb,|raises|spcdefense,au;;,haze,10,30,0,-5,~fQ;;,fcsenrgy,1,30,0,0,~z,~eb,|raises|crit ratio,al;;,mirrmove,9,20,-5,0,~fS;;,lick,15,30,20,100,~f,30,~X,4;;,smog,5,20,20,100,~f,30,~X,5;;,sludge,5,20,65,100,~f,30,~X,5;;,boneclub,7,20,65,85,~f,10,~E,~ex;;,watrfall,4,15,80,100,~f;;,clamp,4,10,35,75,~ni;;,spikcann,1,15,20,100,~e6;;,constrct,1,35,10,100,~f,10,~E,~v,K,-1;;,amnesia,12,20,0,0,~z,~v,ei,2;;,kinesis,12,15,0,80,~E,~v,A,-1;;,hijmpkck,3,20,85,90,~f;;,glare,1,30,0,75,~X,4;;,poisngas,5,40,0,55,~X,5;;,barrage,1,20,15,85,~e6;;,leechlif,11,15,20,100,~n3;;,lovekiss,1,10,0,75,~X,6;;,tranform,1,10,0,0,~fM;;,bubble,4,30,20,100,~f,10,~E,~v,K,-1;;,dizypnch,1,10,70,100,~f;;,spore,8,15,0,100,~X,6;;,splash,1,40,0,0,~fW;;,acidarmr,5,40,0,0,~z,~v,q,2;;,crabhamr,4,10,90,85,~f;;,furyswps,1,15,10,80,~e6;;,bonerang,7,10,50,90,~n1,2,~L;;,hyprfang,1,15,80,90,~f,10,~E,~ex;;,sharpen,1,30,0,0,~z,~v,Q,1;;,convrson,1,30,0,0,~fN;;,suprfang,1,10,-5,90,~of;;,slash,1,20,70,100,~f"
tZ=r"0,0x5e00,1,0x5e1e,2,0x5e3c"
f6=16
function _init()
local _ENV=Y
memset(0x8000,0,0x7fff)
nf=tp"ey,aP,l,~a5,eD,4;tH;ec,eB,eD,4,eH,~j,nM,~j,tC,~L,ea,~L,es,~L,e0,~L,h,~L,P,~L,ef,;aP;next,fx,ed,.5,es,~eT;fx;next,eB,ed,.5,es,~eT;fb;ec,eB,next,eB,ed,.5,eH,159,es,~eT;eB;ec,eB,next,tX,tC,~oJ,es,~eT,ea,~oK;tX;ec,tX,next,aE,ed,.2,es,~eT;aE;ec,nN,next,aX,eD,3,ed,.2,eH,155,es,~eT;aX;ec,nN,next,aL,eD,2,ed,.2,eH,154,es,~eT;aL;ec,nN,next,aO,eD,1,ed,.2,eH,153,es,~eT;aO;ec,nN,next,tP,eD,0,eH,152,tC,~oq,es,~eT,ea,~oA,e0,~oB,h,~oD,P,~oF;tP;ec,tP,next,eB,ed,.25,es,~eT,ea,~L;"
eT(nf)
flip()
sfx(53,3)
tG(0x0)
tG(0x2)
tG(0x4)
C(poke,";,0x5f5c,8;;,0x5f5d,2;;,0x5f56,0xe0")
f9(peek2"0x6",mget,mset)
om()
o0()
local e=peek2"0xa"
for t,f in pairs(nQ)do
local n={n=f}
for t=1,6do
add(n,peek(e))
e+=1
end
nQ[t]=n
end
C(memcpy,";,0x0000,0xc000,0x2000")
end
tE=96
function _update60()
local _ENV=Y
tE,eQ,e7,nZ,nY=96,btnp"4",btnp"5",btnp"0"and btnp"1"and 0or btnp"0"and-1or btnp"1"and 1or 0,btnp"2"and btnp"3"and 0or btnp"2"and-1or btnp"3"and 1or 0
if@0x5eff==1then
eQ,e7=e7,eQ
end
nf:t4()
poke(0x4055,tE)
end
function _draw()
local _ENV=Y
nf:es()
end