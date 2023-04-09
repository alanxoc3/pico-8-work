ea=setmetatable({},{__index=_ENV})
_ENV=ea
function nC(e,n,t)
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
add(e,nC(n,f,o))
end)
else
for n=1,#t,2do
e[t[n]]=nC(t[n+1],f,o)
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
function m(...)
return F(setmetatable({},{__index=ea}),...)
end
F(ea,"es,@,z,@,fq,@,L,@",true,false,"",function(...)return...end)
F(ea,"m,@,F,@,nC,@,t3,@,t4,@,Y,@,tg,@,tb,@,np,@,H,@,eh,@,eG,@,b,@,C,@,nw,@,eb,@,e2,@,U,@,fA,@,tx,@,t6,@,eJ,@,t8,@,n_,@,na,@,nV,@,ed,@,n3,@,J,@,fB,@,fD,@,fF,@,fH,@,fJ,@,fK,@,Q,@,n4,@,fM,@,ex,@,fN,@,ty,@,fQ,@,fR,@,fS,@,fU,@,ng,@,t7,@,fV,@,fW,@,t9,@,x,@,l,@,h,@,nW,@,fY,@,fZ,@,tk,@,X,@,e6,@,e8,@,nd,@,oe,@,on,@,ot,@,of,@,oo,@,o_,@,tj,@,ni,@,nr,@,n0,@,oa,@,od,@,oi,@,n1,@,ey,@,o0,@,nb,@,f,@,nx,@,o1,@,nY,@,tz,@,tq,@,ei,@,eK,@,nm,@,tA,@,om,@,n6,@,tB,@,nZ,@,te,@,n8,@,oc,@,tn,@,nc,@,e7,@,ou,@,q,@",m,F,nC,function(e)
return F(m"ny,0,tD,0,tF,~es,T,~L,er,~L,eI,#;",e)
end,function(_ENV,e)
if e==eC then
return Z and ny/Z or 0
end
if _ENV[e]and _ENV[e].ol then
return 1
end
return 0
end,function(_ENV,e)
n7=e or next
end,function(_ENV,e)
ny,n7,tF,next,Z=0
_ENV[eC].ol=true
for e,n in pairs(tH)do _ENV[e]=n end
for n,t in pairs(_ENV[e])do _ENV[n]=t end
eC=e
_ENV:T()
tD=#eI
end,function(_ENV)
ny+=1/60
if tF then _ENV:tg(eC)end
if Z and ny>=Z then
_ENV:Y()
end
while n7 do
_ENV:tg(n7)
end
_ENV:er()
end,function(_ENV,e)
while n7~=e and#eI>0do
_ENV:H()
end
end,function(_ENV)
deli(eI)
_ENV:Y(eI[#eI]or"eM")
end,function(_ENV,e)
add(eI,e)
_ENV:Y(e)
end,function()
K"153"
end,function(e)
return flr(rnd(e))
end,function(e,n,...)
foreach(m(n,...),function(n)
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
end,m"",split"missingno,bulbasaur,ivysaur,venusaur,charmander,charmeleon,charizard,squirtle,wartortle,blastoise,caterpie,metapod,butterfree,weedle,kakuna,beedrill,pidgey,pidgeotto,pidgeot,rattata,raticate,spearow,fearow,ekans,arbok,pikachu,raichu,sandshrew,sandslash,nidoran f,nidorina,nidoqueen,nidoran m,nidorino,nidoking,clefairy,clefable,vulpix,ninetales,jigglypuff,wigglytuff,zubat,golbat,oddish,gloom,vileplume,paras,parasect,venonat,venomoth,diglett,dugtrio,meowth,persian,psyduck,golduck,mankey,primeape,growlithe,arcanine,poliwag,poliwhirl,poliwrath,abra,kadabra,alakazam,machop,machoke,machamp,bellsprout,weepinbell,victreebel,tentacool,tentacruel,geodude,graveler,golem,ponyta,rapidash,slowpoke,slowbro,magnemite,magneton,farfetchd,doduo,dodrio,seel,dewgong,grimer,muk,shellder,cloyster,gastly,haunter,gengar,onix,drowzee,hypno,krabby,kingler,voltorb,electrode,exeggcute,exeggutor,cubone,marowak,hitmonlee,hitmonchan,lickitung,koffing,weezing,rhyhorn,rhydon,chansey,tangela,kangaskhan,horsea,seadra,goldeen,seaking,staryu,starmie,mr mime,scyther,jynx,electabuzz,magmar,pinsir,tauros,magikarp,gyarados,lapras,ditto,eevee,vaporeon,jolteon,flareon,porygon,omanyte,omastar,kabuto,kabutops,aerodactyl,snorlax,articuno,zapdos,moltres,dratini,dragonair,dragonite,mewtwo,mew",m"0,none;,fainted,burned,frozen,paralyzed,poisoned,sleeping",m"0, ;,FNT,BRN,FZN,PAR,PSN,SLP",m"0;c,2,n,~fq;1;c,2,n,normal,15,0,13,.5;2;c,10,n,fire,8,2,10,2,11,2,2,.5,4,.5,13,.5,14,.5;3;c,7,n,fighting,10,2,1,2,13,2,15,0,11,.5,9,.5,5,.5,12,.5;4;c,9,n,water,2,2,7,2,13,2,14,.5,8,.5,4,.5;5;c,6,n,poison,11,2,8,2,15,.5,7,.5,5,.5,13,.5;6;c,11,n,electric,9,2,4,2,7,0,14,.5,6,.5,8,.5;7;c,7,n,ground,6,2,2,2,5,2,13,2,9,0,11,.5,8,.5;8;c,8,n,grass,7,2,13,2,4,2,11,.5,14,.5,2,.5,9,.5,8,.5,5,.5;9;c,2,n,flying,11,2,3,2,8,2,6,.5,13,.5;10;c,9,n,ice,14,2,9,2,8,2,2,.5,10,.5,4,.5;11;c,8,n,bug,8,2,12,2,3,.5,2,.5,9,.5,15,.5,5,.5;12;c,6,n,psychic,3,2,5,2,12,.5;13;c,2,n,rock,11,2,2,2,9,2,10,2,3,.5,7,.5;14;c,2,n,dragon,14,2;15;c,6,n,ghost,15,2,1,0,12,2;17;c,2,n,bird;",m"V,hp,e0,spc,R,att,A,def,M,spd,n9,tot,B,acc,ep,eva",m";c,13,e1,5,nu,1;;c,6,e1,13,nu,13;;c,5,e1,5,nu,1;;c,6,e1,5,nu,5;;c,1,e1,5,nu,13;;c,14,e1,4;;c,9,e1,4;;c,11,e1,3;;c,12,e1,5;;c,8,e1,2;;c,10,e1,4",m"",split"youngstr,bugcatch,junior,brock,lass,hiker,swimmer,misty,gentlman,sailor,rocker,ltsurge,channelr,gambler,beauty,erika,biker,birdkeep,juggler,koga,blckbelt,rocket,psychic,sabrina,scientst,pkmaniac,suprnerd,blaine,cooltrnr,fishrman,tamer,giovanni,lorelei,bruno,agatha,lance,blue,green,red,legendry",function(e,n)
if n.ee then
e:eh(n.ee)
else
e:H()
end
end,function(e,n)
return m("oT,@,tJ,@,S,~tJ,y,1,er,~fH,em,~fK,nl,~fD,N,~fB",e,n or 0)
end,function(e,n)
return F(n3(e),"p,0,y,@,er,~fJ,tt,~fF",n or 1)
end,function(e,n,f)
while deli(e)do end
for t=1,#n do
add(e,(f or L)(n[t],t))
end
end,function(e)
e:H()
end,function(e,n,t)
if t then
local t=e.p+n*e.y
if t==mid(0,t,#e-1)then
e.p=t
if 0+n~=0then K"154"end
else
eG()
end
else
local t=e.p+n
local f=e.p-e.p%e.y
if t==mid(f,t,f+e.y-1)then
e.p=t
if 0+n~=0then K"154"end
else
eG()
end
end
e.p=mid(0,e.p,#e-1)
if e.p\e.y<e.S then e.S=e.p\e.y end
if e.p\e.y>e.S+2then e.S=e.p\e.y-2end
e.S=mid(0,e.S,(#e-1)\e.y)
end,function(n)
local e=n.a
if nT then K"154"e.nl(n)end
if e9 then n:nk()end
e.S+=nj
if nz~=0then n:tK(nz)end
local n=e.S
e.S=mid(e.tJ,e.S,#e-3)
if e.S~=n then
eG()
elseif nj~=0then
K"154"
end
end,function(t)
local e=t.a
e:tt"0"
e:tt(nj,true)
e:tt(nz)
if e9 then
local n=e[e.p+1]
if n.ec then
eG()
elseif n.G then
K"155"
n.G(t,n)
end
end
if nT then K"154"e.nl(t)end
end,function(n)
local e=n.a
local f=e.y>1and 10or 40
local a=20-(e.y*f)/2
C(rectfill,";,0,0,39,39,1;;,0,@,39,@,13",5-e.S*10,4+(max(ceil(#e/e.y),3)-e.S)*10)
for n=-1,e.y*5-1do
local d=(e.S-1)*e.y+n+1
local t=e[d]
if t then
local o,i,r=t.nq or 1,a+n%e.y*10,n\e.y*10
if t.ec then o=3end
if d-1==e.p then o+=1end
if not t.tf then
rectfill(i,r-5,i+f-1,r+4,n_[o].c)
nw(n%e.y*f+a+f/2,n\e.y*10-3,function()
e.oT(t,n_[o])
end)
end
end
end
end,function(e,n)
if e.en then
local n=n_[eJ[e.en.eE].c]
C(rectfill,";,-20,-2,19,17,@;;,-20,14,19,17,@",n.c,n.e1)
e.en:nA(0,8,n,1,1)
else
tM(e.n,0,0,n.nu)
end
end,function(e,n)
e.en:nA(0,3,n,.375,.375)
end,function(n)
local e=te(n.k)
del(e,n.o.W)
if#e>0then
return e[b(#e)+1]
end
end,function(_ENV,e)
local n=ns[e]
if e=="ep"or e=="B"then
return _ENV[e]*mid(1,1+n/3,3)/mid(1,1-n/3,3)
end
return ceil(mid(1,999,
(e=="R"and s==2and.5or e=="M"and s==4and.25or 1)*
_ENV[e]*mid(2,2+n,8)/mid(2,2-n,8)
))
end,function(_ENV)
if i.to>0then return true end
local e=nB(i)
if#e==0then return true end
i.to,i.eQ=b"6"+2,e[b(#e)+1].et
r(eX,"|"..i.w[i.eQ].n.."|disabled")
if i.g and i.g.et==i.eQ then
i.ev=0
end
end,function(_ENV,t,n)
local e=q(t,n)
e.ek,e.tN=5,5
w[n]=e
return e
end,function(_ENV)
local n=nB(i,true)
local t=n[b(#n)+1].d
if t==31then
return true
end
r(I,"|copies|"..ty(e,t,u.et).n)
end,function(_ENV)
if e.os then
return true
else
r(I,"|copies|"..i.n,function()
e.os=true
foreach(split"d,R,A,M,e0,eE,ew",function(n)
e[n]=i[n]
end)
e.w={}
foreach(i.w,function(n)
ty(e,n.d,n.et)
end)
end)
end
end,function(_ENV)
F(e,"eE,@,ew,@",i.eE,i.ew)
r(I,"|copies|types")
end,function(_ENV)
foreach({eX,I},function(e)
r(e,"|resets|stats",function()
F(e.o.ns,"e0,0,R,0,A,0,M,0,B,0,ep,0")
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
return ng(_ENV,I,e.V\2)
end,function(_ENV)
t_(I,q(b(164)+1,u.et))
end,function(_ENV)
if e.ta>0then
t_(I,q(e.ta,u.et))
else
return true
end
end,function(e,n)
return(sgn(e)>0and"|+"or"|-")..abs(e).." "..n.."|change"
end,function(_ENV,e,...)return e(_ENV,I,...)end,function(_ENV,e,...)return e(_ENV,eX,...)end,function(_ENV,e,n,t,o)
local f=e.o.ns[n]
if not e.o.ov or t>0then
e.o.ns[n]=mid(-6,6,f+t)
end
if f~=e.o.ns[n]then
r(e,t9(t,t8[n]),o or L)
else
return true
end
end,function(_ENV,e)
local n=fM(e)
if n then
tR(e,n)
else
return true
end
end,function(_ENV)
if X(_ENV,5)and i.s~=5then
return true
end
return l(_ENV,e6,"|badly|poisoned","nv",1,true)
end,function(_ENV)
r(I,"|does|nothing")
end,function(_ENV)
return td(u,i)>0and u.eL~=i.eE and u.eL~=i.ew
end,function(_ENV,n)
if i.W.s==3and n==2then
r(I,"|thawed|out")
e.W.s=0
elseif i.W.s==0and(n==6or tk(_ENV))then
r(eX,"|is now|"..tx[n],function()
i.W.s=n
i.ti=b"7"+1
end)
else
return true
end
end,function(_ENV,e,t,n,f,o)
if(e.o[n]or 0)==0and(not o or tk(_ENV))then
e.o[n]=f or 1
r(e,t)
else
return true
end
end,function(_ENV,e)
e.o.tS=true
end,function(_ENV,e)
return e6(_ENV,e,"|becomes|confused","nD",b"4"+1)
end,function(_ENV)
return h(_ENV,I,"ep",1,function()
e.tQ=.25
end)
end,function(_ENV)
local n=e.V\4
if n>=e.D or e.e3>0then
return true
end
eK(_ENV,n)
r(I,"|created|substitute",function()
e.e3=n
end)
end,function(_ENV)
ej(e,-1,u)
f(_ENV)
if u.ek<=0then
e.ev,e.g=0
end
end,function(_ENV)
if not e.g then
ej(e,b"2"+1,q(u.d,u.et))
r(I,"|"..u.n.."|begins")
e.nF=0
end
if e.ev==0then
if e.nF==0then
return true
end
ei(_ENV,e.nF*2)
end
end,function(_ENV)
ei(_ENV,1+b"75")
end,function(_ENV)
ei(_ENV,max(i.D\2,1))
end,function(_ENV)
ej(e,b"2"+1,q(u.d,u.et))
f(_ENV)
if e.ev==0then
x(_ENV,nd,"nD")
end
end,function(_ENV)
if not e.g then
ej(e,b"4"+1,q(u.d,u.et))
e.nh=i
end
if e.nh==i then
f(_ENV)
else
return true
end
end,function(_ENV,n)
if e.g then
f(_ENV)
else
r(I,n,function()
ej(e,1,q(u.d,u.et))
end)
end
end,function(_ENV)
if e.g then
f(_ENV)
else
r(I,"|charges|energy")
ej(e,1,u)
u.ek+=1
end
end,function(_ENV)
if e.g then
r(I,"|recharges|energy")
else
f(_ENV)
local n=q(u.d,u.et)
n.B=0
ej(e,1,n)
end
end,function(_ENV)
r(I,"|is|sleeping",function()
e.W.s,e.ti,e.nv=6,2,0
ng(_ENV,I,e.V)
end)
end,function(_ENV)
if e.nH>0then
ei(_ENV,e.nH*2)
else
return true
end
end,function(_ENV,e,n,t)
if e>0then
r(I,t and"|resumes|"..u.n,function()
_ENV.i=eX.o
f(_ENV,100,function()
n1(_ENV,e-1,n,true)
end)
end)
else
n()
end
end,function(_ENV)
n1(_ENV,2+b"4",L)
end,function(_ENV)
n1(_ENV,2,function()
if rnd"100"<20then
X(_ENV,5)
end
end)
end,function(_ENV)
ei(_ENV,false,function(e)
eK(_ENV,max(1,e\4))
end)
end,function(_ENV,e,n,...)
local t={...}
ei(_ENV,false,function()
if rnd"100"<(e or 0)then
n(_ENV,unpack(t))
end
end)
end,function(_ENV)
ei(_ENV,false,function(e)
ng(_ENV,I,max(e\2,1))
end)
end,function(_ENV)
if i.s==6then
nx(_ENV)
else
return true
end
end,function(_ENV)
if e.M>=i.M then
ei(_ENV,i.D)
else
return true
end
end,function(_ENV,n,t,a,e)
local f=t9(t,"hp")
local o=e and n.o.e3+t<0
if not e or o then
r(n,f,L,e)
end
r(n,
o and"|substitute|broke"or f,
a,
e
)
end,function(_ENV,t,n,a,f)
local e=t.o
local o=not a and e.e3>0
tz(_ENV,t,-n,function()
e.nF+=n
if e.g and e.g.d==20then
h(_ENV,t,"R",1)
end
if f then f(n)end
if o then
e.e3=max(e.e3-n,0)
else
e.W.D=max(e.W.D-n,0)
end
end,o and"substitute")
end,function(_ENV,n,o)
local f,t=false,td(u,i)
if not n then
n,f=tU(e,i,u)
end
if t>0then
if u.eL%2==1then
i.nH+=n
end
if t>1then r(I,"|super|effective")
elseif t<1then r(I,"|not very|effective")end
if f then r(I,"|critical|hit")end
tq(_ENV,eX,n,false,o)
else
r(eX,"|resisted|attack")
end
end,function(_ENV,e)
tq(_ENV,I,e,true,L)
end,function(e)
return ceil(e+.5*93)+5
end,function()
return m("ef,~es,R,0,A,0,e0,0,M,0,V,0,D,0,n9,0,B,100,ep,100,tV,0,tW,0,tY,0,tr,0,tZ,0,d,-1,oh,-1,n, ,eE,0,ew,0,eR,#,eS,#,t0,#,w,@",nJ())
end,function()
local e=peek2"0x8"
U[-1]=tA()
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
F(e,"d,@,oh,@,n,@,eE,@,ew,@,tV,@,tW,@,tY,@,tr,@,tZ,@",t,
f,
fA[t+1],
unpack(n)
)
local o=e.eR
for f=8,#n do
local t=n[f]
if t==253then
o=e.eS
elseif t==252then
o=e.t0
else
add(o,t)
end
end
if f<t then
foreach(split"eR,eS",function(n)
foreach(U[f][n],function(t)
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
F(_ENV,"R,@,A,@,e0,@,M,@,V,@,D,~V",nm(tW),
nm(tY),
nm(tZ),
nm(tr),
nm(tV)+55
)
n9=R+A+e0+M+V
end
U[t]=e
end
end,function(e,n)
return setmetatable(m("w,@,s,0,ef,~z",n),{__index=U[e]})
end,function(e)
foreach(nZ(e.k),function(e)
poke(0x5e5a+e.d,1)
end)
end,function(e)
local n={}
foreach(e,function(e)
if e.d>-1and e.s==1then
add(n,e)
end
end)
return n
end,function(e,t)
local n={}
foreach(e,function(e)
if e.d>(t and 0or-1)and e.s~=1then
add(n,e)
end
end)
return n
end,function(e)
return te(e)[1]
end,function(e)
local n=e:ez"j"
n[e:O"eu"+1]=n6(-1,nJ())
e7(e:O"j",n)
e:H()
end,function(e,o,n)
local t,f=U[n],nJ()
for e=1,min(4,#t.eR)do
f[e]=q(t.eR[e],e)
end
e[o]=n6(n,f)
return e
end,function(n)
local a,e=fe[n],m""
for t=1,6do
local f,n,o=a+(t-1)*5,{},false
for e=1,4do
n[e]=q(peek(f+e),e)
if n[e].d>0then
o=true
else
n[e]=q(-1)
end
end
e[t]=n6(o and@f or-1,n)
end
return e
end,function(e,o)
local n=fe[e]
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
local n,t={},deli(nK[e],6)
for t=6,#nK[e]do
add(n,deli(nK[e],6))
end
na[e]=m("o2,@,d,@,eU,@,n,@,eL,@,ek,@,tN,~ek,t1,@,B,@",function(e)
return t(e,unpack(n))
end,e,t,unpack(nK[e]))
end
end,function(e,n)
return setmetatable(m("et,@",n or 0),{__index=na[e]})
end)
F(ea,"nJ,@,tm,@,tc,@,tu,@,tl,@,tT,@,eV,@,o5,@,oP,@,fn,@,eW,@,ts,@,n2,@,tv,@,ft,@,ff,@,oE,@,fo,@,eY,@,oX,@,f_,@,oL,@,oO,@,fa,@,oG,@,oI,@,fd,@,oC,@,op,@,ow,@,o3,@,o4,@,fi,@,og,@,ob,@,ox,@,o6,@,o8,@,n5,@,aC,@,oy,@,o7,@,o9,@,ok,@,oj,@,oz,@,oq,@,oA,@,oB,@,oD,@,oF,@,oH,@,oJ,@,oK,@,fr,@,O,@,e4,@,oM,@,f0,@,oN,@,f1,@,K,@,nM,@,el,@,fm,@,tM,@,eN,@,eZ,@,oQ,@,fc,@,nA,@,oR,@,oS,@,oU,@,fu,@,oV,@,oW,@,ez,@,nP,@,nN,@,nQ,@,tR,@,t_,@,ej,@,oY,@,nR,@,oZ,@,nS,@,ne,@,nE,@,nX,@,fl,@,fT,@,ae,@,an,@,at,@,fs,@,nB,@,fv,@,td,@",function()
local e={}
for n=1,4do add(e,q(-1))end
return e
end,function(e)
fr(e)
tM("team #"..e:O"j"+1,20,27,1)
end,function(_ENV)
local t,e,n=eq.o,eO.o,eA.o
local o,a=e==t,n==t
local t,f=11,11
C(rectfill,";,0,0,39,6,5;;,0,33,39,39,5")
C(rectfill,";,-1,33,@,41,1;;,-1,-2,@,6,1",max(ceil(e.D/e.V*40),0)-1,
max(ceil(n.D/n.V*40),0)-1)
C(rectfill,";,15,6,39,6,13;;,16,5,39,5,13;;,0,33,24,33,13;;,0,34,23,34,13")
C(eN,";,@,40,34,13,1;;,@,40,27,1,1;;,@,2,1,13,-1;;,@,2,7,1,-1",e.D,t6[e.s],n.D,t6[n.s])
local t,f=1,1
e:nA(10,25,n_[4],t,t,o)
n:nA(30,15,n_[4],-f,f,a)
end,function(e)oQ(U[e:O"ef"])end,function(e)eb("spot #"..(e:O"eu"+1))end,function(e)eb("move #"..(e:O"e5"+1))end,function(e)eb(e.nn)end,function(e)eb"match over"end,function(n)
local e=n:e4"nU"
eb(e and e.af)
end,function()
rectfill(0,0,46,13,13)
pal(7,1)
local e=0
for f,n in ipairs(split"6,5,5,6,6,5,6")do
sspr(6*8+e,6*8,n,8,e+3,3.5+cos((t()+f)/4))
e+=n
end
pal()
end,function(e)eb(e.eq.ao.n)end,function(e)
fc(e:nP())
end,function(n)
local e=n:e4(n.fh).u
if e.d>=0then
e2(eJ[e.eL].n.."|"..e.ek.."/"..e.tN.."|"..(e.t1>=0and e.t1 or"??").."P "..(e.B>=0and e.B or"??").."A")
else
e2"none|n/a|"
end
end,function(e)
fc(e:e4"ef".en)
end,function(e)
e2(e:e4"eM".eg)
end,function(_ENV)
if d>-1then
e2(n.."|"..D.."/"..V.."|"..tx[s])
else
e2"none|n/a|"
end
end,function(_ENV)ff(_ENV:e4"th".en)end,function(_ENV)ff(v.o)end,function(e)
local n,t=0,0
foreach(e:e4().k,function(e)
if e>-1then
n+=U[e].n9
t+=1
end
end)
e2(e:e4().n.."|len "..t.."/6|tot "..n)
end,function(e)
e2(e.nt.n.."|is the|winner")
end,function(e)
e2(e.eq.n..e.eq.f2)
end,function(_ENV)
local n=ne(_ENV,nt)
nt:a_(n)
a:N{}
a.nl=function(e)
e:np"t2"
end
for e in all{nt,n}do
F(a,"S,0;;en,@;;tf,~es;;n,@,nq,5;;n,@;;n,@",e.o.W,e.n,(#te(e.k,true)).." live",(#nZ(e.k)).." dead")
end
end,function(_ENV)
local e=0
for n=0,151do e+=U[n]:eZ()and 1or 0end
a:N(
m(";n,browse,ee,ef,G,~ed,eg,@;;n,edit,ee,j,G,~ed,eg,edit|stored|teams;;n,league,ee,f5,G,~ed,eg,@;;n,versus,ee,t5,G,~ed,eg,versus|p1 vs p2|match;;n,horde,ee,fP,G,~ed,eg,@;;n,credits,ee,fE,G,~ed,eg,credits|amorg|games","browse|"..e.."/151|pokemon","league|"..(@0x5efd).."/40|trainers","horde|"..(@0x5efe).."/151|hi-score")
)
end,function(_ENV,n)
local e={}
for n=0,151do
add(e,n)
end
a:N(
e,
function(e)
return m("G,@,ec,@,en,@",n,not U[e]:eZ(),U[e])
end
)
end,function(_ENV)
fa(_ENV,function(_ENV)
_ENV:eh"fX"
end)
end,function(_ENV)
fa(_ENV,function(_ENV)
e7(_ENV:O"j",tn(_ENV:ez"j",_ENV:O"eu"+1,_ENV:O"ef"))
_ENV:H()
end)
end,function(_ENV)
local e=_ENV:e4"ef".en
a:N{}
F(a,";en,@;;tf,~es;;n,lvl 50,nq,5",e)
foreach(split"V,e0,R,A,M,n9",function(n)
add(a,{n=t8[n].." "..e[n]})
end)
C(function(t,n)
if#U[e.d][n]>0then
add(a,{n=t,nq=5})
foreach(U[e.d][n],function(e)
add(a,{n=na[e].n})
end)
end
end,";,learn,eR;;,teach,eS;;,event,t0")
end,function(_ENV)
a:N(
split"91,,#alanxoc3,code &,design,28,,#gr8cadet,pokemon,sprites,143,,#tigrwolf,battle,testing,129,,#wadlo,just,magikarp,127,,#tooling,px9 func,shrinko8,137,,#pkmndata,blbpedia,pokeapi,serebii,smogon,upokcntr,volvox,nintendo",
function(e)
if type(e)=="number"then
return{en=n6(e,nJ())}
end
local n=1
if sub(e,1,1)=="#"then
e,n=sub(e,2),5
end
return{n=e,nq=n,tf=e==""}
end
)
end,function(_ENV)
a:N(nV,function(e,n)
return{
n=e.n,
k=e,
ec=n-1>@0x5efd,
G=function(t,e)
fL(t,e.k,e.n,function(t,e)
poke(0x5efd,mid(@0x5efd,n,40))
tB(e)
end,L)
end
}
end)
end,function(_ENV)
a:N(m";n,moves,ee,e5,G,~ed;;n,switch,ee,tP,G,~ed;;n,delete,G,~oc")
end,function(_ENV)
local n=_ENV:nP()
local e=0
for t=1,4do
if n.w[t].d>0then e+=1end
end
a:N(m(";n,change,ee,nU,G,~ed;;n,switch,ee,fO,G,~ed;;n,delete,ec,@,G,~o4",e==1))
end,function(_ENV)
local e,n=_ENV:nP()
e.w[_ENV:O"e5"+1]=q(-1)
e7(_ENV:O"j",n)
_ENV:H()
end,function(_ENV,f,o)
local n,d=_ENV:nP()
a:N(m",1,2,3,4",function(e)
local t=n.w[e]
return{
u=t,
n=t.n,
G=function(_ENV)o(_ENV,e,n,d)end,
ec=e==f
}
end)
end,function(_ENV)
fi(_ENV,0,function(_ENV,e,n)
_ENV:eh(n.w[e].d>0and"fG"or"nU")
end)
end,function(_ENV)
local n=_ENV:O"e5"+1
fi(_ENV,n,function(_ENV,t,e,f)
e.w[t],e.w[n]=e.w[n],e.w[t]
e7(_ENV:O"j",f)
_ENV:np"e5"
end)
a.p=e5.a.p
end,function(_ENV)
local n=_ENV:nP()
local e=U[n.d]
local t={}
C(function(f,a)
for o=1,#f do
local e=f[o]
add(t,{n=na[e].n,ec=n:at(e),d=e,eg=a..o})
end
end,";,@,learn #;;,@,teach #;;,@,event #",e.eR,e.eS,e.t0)
a:N(t,function(e)
return{
n=e.n,
ec=e.ec,
u=na[e.d],
af=e.eg,
G=function()
local n=_ENV:ez"j"
n[_ENV:O"eu"+1].w[_ENV:O"e5"+1]=q(e.d)
e7(_ENV:O"j",n)
_ENV:np"e5"
end
}
end)
end,function(_ENV)
local n=fv(v.o)
if v.o.g then
nS(v,v.o.g)
_ENV:H()_ENV:H()
elseif#n==0then
nS(v,q(0))
_ENV:H()_ENV:H()
end
a:N(v.o.w,function(e)
return m("ec,@,n,@,u,@,G,@",
not n[e],
e.n,
e,
function()
_ENV:H()_ENV:H()
nS(v,e)
end
)
end)
end,function(_ENV)
a:N(m";n,fight,G,~ed,ee,fI;;n,switch,G,~ed,ee,th;;n,forfeit,G,~aa")
end,function(_ENV)
a:N(m",1,2,3",function(e)
local n=nc(e-1)
local t={}
local f=true
for e=1,6do
t[e]=n[e].d
if not n[e]:fs()then
f=false
end
end
return{
n="team #"..e,
k=t,
G=function()_ENV:nL()end,
ec=nO and f
}
end)
end,function(e,n)
return e[n]and e[n].d or-1
end,function(_ENV)
local e=_ENV:ez"j"
a:N(m",1,2,3,4,5,6",function(n)
return{
en=e[n],
G=function(_ENV)
if e[_ENV:O"eu"+1]:eZ()then
_ENV:eh"fC"
else
_ENV:eh"fp"
end
end
}
end)
end,function(_ENV)
local e=_ENV:ez"j"
a:N(m",1,2,3,4,5,6",function(n)
return{
ec=n==_ENV:O"eu"+1,
G=function(_ENV)
local n,t=_ENV:O"eu"+1,_ENV:O"tP"+1
e[n],e[t]=e[t],e[n]
e7(_ENV:O"j",e)
_ENV:np"eu"
end,
en=e[n]
}
end)
a.p=eu.a.p
end,function(_ENV)
local e=_ENV:ez"j"
a:N(m",1,2,3,4,5,6",function(e)
local n=v.k[e]:fs()or v.o.W==v.k[e]or v.k[e].s==1
return{
ec=n,
G=function()
_ENV:H()_ENV:H()
tR(v,v.k[e])
end,
en=v.k[e]
}
end)
end,function(_ENV)
local n,e=eO,eA
if n.eB==e.eB then e.eB+=sgn(rnd"2"-1)end
v=n.eB>e.eB and n or e
end,function(_ENV,e)
local n=true
for t=ef.a.p+e,75.5+75.5*e,e do
if U[t]:eZ()then
ef.a.p,n=t
K"154"
break
end
end
if n then eG()end
fd(_ENV)
end,function(e)K(e:O"ef")end,function()K(b"152")end,function(_ENV)K(nt.o.d)end,function(_ENV)
local e={}
for t,n in pairs(split"133,7,35,1,25,4")do
tn(e,t,n)
poke(0x5e5a+n,1)
end
if@0x5efc==0then
poke(0x5efc,1)
e7(0,e)
end
eo=t3"eC,eM;tH;a,~z,T,~L,tK,~eG,nk,~L,er,~oK,fh,~z,em,~fr,P,~L,E,~L;eM;T,~oO,P,~fn,E,~ft;ef;T,~oG,P,~tu,E,~tv;fX;T,~fd,P,~tu,E,~tv,tK,~oj,nk,~oz;eu;T,~oy,P,~tl,E,~ts,em,~tm;tP;T,~o7,P,~tl,E,~ts,em,~tm;fp;T,~oI,P,~tu,E,~tv;fC;T,~ow,P,~tl,E,~ts;fG;T,~o3,P,~tT,E,~n2,fh,e5;nU;T,~ox,P,~oP,E,~n2;e5;T,~og,P,~tT,E,~n2;fO;T,~ob,P,~tT,E,~n2;j;nn,player,T,~n5,P,~eV,E,~eY,nO,~z,nL,~oW;f5;nn,player,T,~n5,P,~eV,E,~eY,nO,~es,nL,~oR;t5;nn,player 1,T,~n5,P,~eV,E,~eY,nO,~es,nL,~oS;fP;nn,player,T,~n5,P,~eV,E,~eY,nO,~es,nL,~oV;tE;nn,player 2,T,~n5,P,~eV,E,~eY,nO,~es,nL,~oU;t2;nn,trainer,T,~op,P,~eV,E,~eY;tX;T,~oL,P,~o5,E,~oX,nk,~oA;fw;T,~o8,P,~eW,E,~fo;fI;T,~o6,P,~eW,E,~n2;th;T,~o9,P,~eW,E,~oE,em,~tm;ad;next,ai,T,~f3,f4,eO;ai;next,fg,T,~f3,f4,eA;fg;next,ad,T,~ok,er,~ae,em,~tc,P,~eW,E,~f_,eq,~z;ar;T,~L,er,~fl,em,~tc,P,~eW,E,~fo;a0;T,~L,er,~fl,em,~tc,P,~eW,E,~f_;fE;T,~oC,P,~fn,E,~ft,nk,~oq;"
C(function(e,n,...)
eo[e].a=n(...)
end,";,ef,~J,~n4,4;;,fX,~n3,~Q;;,fE,~n3,~Q;;,tX,~n3,~Q;;,eu,~J,~n4,3;;,tP,~J,~n4,3;;,eM,~J,~Q;;,fC,~J,~Q;;,fG,~J,~Q;;,nU,~J,~Q;;,e5,~J,~Q;;,fO,~J,~Q;;,j,~J,~Q;;,t5,~J,~Q;;,t2,~J,~Q;;,tE,~J,~Q")
F(eo,"fb,@,a1,@;eM;a;nl,~eG;fP;a,~fb;f5;a,~fb;fp;a,~a1;",eo.j.a,eo.ef.a)
menuitem(1,"close picodex",function()
menuitem(1)
menuitem(2)
_ENV:Y"tL"
end)
menuitem(2,"swap 🅾️/❎",function()
poke(0x5eff,@0x5eff==0and 1or 0)
end)
end,function(e)
e.eo:tb()
end,function()nf.eo:em()end,function()nf.eo:P()end,function()nf.eo:E()end,function(_ENV)a.er(_ENV)end,function(_ENV)a.em(_ENV)end,function(_ENV,e)
return _ENV[e].a.p
end,function(_ENV,e)
local n=e and _ENV[e].a or a
return n[n.p+1]
end,function(_ENV)
menuitem(1,"factory reset",function()
memset(0x5e00,0,0x100)
_ENV:Y"fx"
end)
end,function()
return btn()&0x3f~=0
end,function(_ENV)
if not f0()and nG then
nG=false
_ENV:Y()
elseif f0()then
if not nG then
K"156"
end
nG=true
menuitem(1)
end
end,0,function(e)
tO=e
end,function(e)
e+=0
if e>152then
ea.f1=e-152
end
sfx(54+e\16,e<=152and 1or 0,e%16*2,2)
end,function(_ENV)
cls"0"
nw(0,128+sin(_ENV:t4"f6"/4)*128,function()
C(eN,";,aMORG gAMES,64,-68,7,0;;,pRESENTS,64,-61,7,0;;,a pOKEMON bATTLE sIM,64,15,7,0")
C(spr,";,102,44,7,5,1")
local t,
n,
e=
eo and eo.eM.a.p,
eo and eo.tD-1,
e_=="nI"and 1
or e_=="eD"and-1
or(e_=="tG"and-1or 1)*cos(_ENV:t4(e_)/2)
nw(30-(e+1)*15+(eC=="fx"and b"3"-1or 0),27,function()
C(rectfill,";,14,18,@,87,5",63+max(0,e*54))
if eF==0then
C(rectfill,";,14,18,117,87,13")
C(function(e,n,t,f,o)
clip(-%0x5f28+e,-%0x5f2a+n,t,f)
nw(e,n,o)
clip()
end,";,14,21,40,40,@;;,71,18,46,13,@;;,71,67,46,21,@",em,P,E)
end
C(map,";,24,0,2,1,8,3;;,8,0,2,9,8,11")
C(function(e,n,t,f,o,a)
return spr((eF<=e)and((e==0and stat"47">=0or f1==e and stat"46">=0)and f or t)or n,o,a)
end,";,0,135,133,134,6,3;;,1,132,128,131,12,3;;,2,132,129,131,17,3;;,3,132,130,131,22,3")
C(function(e,n,t,f,o)
spr(btn(e)and n or t,f,o)
end,";,0,186,154,10,77;;,1,188,156,26,77;;,2,171,139,18,73;;,3,187,155,18,81;;,4,170,138,42,77;;,5,172,140,50,77")
if e<=0then
fm(0,2+64*(1-abs(e)),abs(e))
if e==-1and nG then spr(123,6,49)end
else
fm(16,62,e)
if e==1and eC=="f8"then
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
return not ef or@(0x5e5a+d)>0
end
end,function(e)
eb("pkmn #"..e.d)
end,function(e)
if e:eZ()then
e2(e.n.."|"..eJ[e.eE].n.."|"..eJ[e.ew].n)
else
e2"none|n/a|"
end
end,function(_ENV,e,n,i,f,o,r)
local t,a=_ENV:eZ()and d or-1,8*(tQ or 1)
f*=a o*=a
local a=function(n,a)
local e,d=t/8\1,t%8
if e~=fy then
ea.fy=e
memcpy(0x0000,0x8000+0x400*e,0x400)
end
sspr(d*16,0,16,16,n-f,a-o,f*2,o*2)
end
if e3 and e3>0then t=152end
if not am or s~=1and not tI and not(ev~=0and g.eU==nr)then
if t<0then spr(107,e-4,n-4)return end
local t=1
local t=function(f,o,d,i,r,t)
if f>0then
for e=1,15do pal(e,f)end
for f=-1,1,2do
a(e+(o or f*t),n+(d or f*t))
a(e+(i or f*t),n+(r or f*t))
end
end
end
if r then
C(t,"c,@;;,~c,-2,~z,2,~z,1;;,~c,~z,-2,~z,2,1;;,~c,-2,0,2,0,1;;,~c,0,-2,0,2,1",i.c)
end
C(t,";,@,-1,~z,1,~z,1;;,1,~z,0,0,~z,1",i.e1)
pal()a(e,n)
end
end,function(e)e:eh"t2"end,function(e)e:eh"tE"end,function(_ENV)
f7(_ENV,
m(",@,player 1,~z,~L",nc(_ENV:O"t5")),
m(",@,player 2,~z,~L",nc(_ENV:O"tE"))
)
end,function(_ENV)
poke(0x5efe,mid(@0x5efe,#nZ(k),152))
end,function(_ENV)
local e={}
for n=1,152do add(e,n%152)end
fL(_ENV,e,"horde",function(n,e)
tB(e)
fu(e)
end,fu)
end,function(e)
e:eh"eu"
end,function(e,n)
return nc(e:O(n))
end,function(e)
local n=nc(e:O"j")
return n[e:O"eu"+1],n
end,function(e,n)
local t={}
foreach(n.w,function(e)
add(t,e)
end)
e.o=setmetatable(m("am,~es,ta,0,B,1,ep,1,ev,0,tI,~es,nH,0,nF,0,to,0,nD,0,ti,@,e3,0,nv,0,W,@,w,@;ns;e0,0,R,0,A,0,M,0,B,0,ep,0",b"7"+1,n,t),{__index=n})
return nE(e,"|enters|fight",function()
K(e.o.d)
e.o.tI=false
end)
end,function(e,n)
for t in all(split(n))do
if t==e then
return true
end
end
end,function(e,n)
nX(e,e,"|leaves|fight",function(t)
t.e.tI=true
nX(e,e,false,function()
add(e.eH,nN(e,n))
end)
end)
e.eB=3000
end,function(t,n)
local f=t.o.g and"|resumes|"or(n.eU==ap and"|begins|"or"|uses|")
nX(t,t,f..n.n,function(f)
f.u=n
local _ENV=f
if n.d>0then
n.ek-=1
end
if nQ(n.d,"47,36 ")then
eK(_ENV,e.D)
end
if(function()
if n.B<=0then return false end
if(n.eU==n0 or n.eU==nr)and not e.g then return false end
if i.g and i.g.eU==nr then return true end
if e.g and e.g.eU==ni then return false end
return rnd(i:ex"ep")>n.B/100*e:ex"B"or b"256"==0and b"256"==0
end)()then
r(t,"|misses|"..n.n)
if nQ(n.d,"145,73 ")then
eK(_ENV,1)
end
else
if n.o2(_ENV)then
r(t,"|fails|attack")
end
end
if n.B~=0then
i.ta=n.d
end
end)
end,function(_ENV,e,n)
if not g and ev==0then
ev,g=e,n
end
end,function(n,t)
nX(n,n,false,function(f)
f.u=t
local _ENV=f
e:nR("ev",L)
if e.s==6then
e:nR("ti",function()
r(n,"|suddenly|woke up")
e.W.s=0
end)
if e.s==6then
r(n,"|fast|asleep")
return
end
end
if e.s==3then
if rnd"1"<.2then
r(n,"|thawed|out")
e.W.s=0
else
r(n,"|is|frozen")
return
end
end
if i.nh==e then r(n,"|is|trapped")
elseif e.eQ==t.et then r(n,"|is|disabled")
elseif e.s==4and b"4"==0then r(n,"|fully|paralyzed")
elseif e.tS then r(n,"|is|flinching")
else
if e.nD>0then
r(n,"|is|confused")
if b"2"==0then
r(n,"|hurt|itself")
eK(_ENV,tU(e,i,q(-1)))
return
end
end
t_(n,t)
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
return nE(n,false,function(_ENV)
if e.s==6
or e.s==3
or e.nh and e.nh~=i
then
e.ev=0
end
if e.ev==0then
e.nh,e.g=nil
end
local t=max(e.V\16,1)
local f=function(e)
r(n,e.."|damage")
eK(_ENV,t)
end
if e.s==5then
if e.nv>0then
t*=e.nv
e.nv+=1
end
f"|poison"
end
if e.s==2then f"|burn"end
if e.ac then
f"|seed"
if i.D<i.V then
ng(_ENV,eX,t)
end
end
e:nR("nD",function()
r(n,"|confusion|ended")
end)
e:nR("to",function()
r(n,"|"..e.w[e.eQ].n.."|enabled")
e.eQ=0
end)
end)
end,function(e,n)
e.eH={}
local t=1000
oY(e,n)
if n.d==120then t=2000end
if nQ(n.d,"18,4,89,30 ")then
t=0000
end
e.eB=min(3000,t+e.o:ex"M")
end,function(e,n)
return n==e.eO and e.eA or e.eO
end,function(e,n,t,f)
return m("ao,@,n,@,o,@,f2,@,au,@",e,f or e.o.n,e.o,n or false,t or L)
end,function(e,...)
add(e.eH,nE(...))
end,function(_ENV)
if e9 then
_ENV:eh"fw"
K"155"
end
fT()
end,function()
if nT or nz|nj~=0then eG()end
end,function(e)
fT()
if e9 then K"154"end
if e9 or not e.eq then
while true do
for n in all{e.eO,e.eA}do
if not n8(n.k)then
e.nt=ne(e,n)
e:Y"tX"
return
end
end
local n=an(e)
if n then
local f=n.o==e.eO.o and e.eO or e.eA
local t=m("u,@,I,@,eX,@,r,@",u,f,ne(e,f),function(...)
nX(f,...)
end)
t.e,t.i=t.I.o,t.eX.o
n.au(t)
if n.f2 then
e.eq=n
return
else
end
else
e:Y()
return
end
end
end
end,function(n)
for t in all{n.eO,n.eA}do
if t.o.D<=0then
if t.o.s~=1then
return nE(t,"|has|fainted",function(_ENV)
e.W.s=1
end)
elseif t~=n.v then
return nN(t,n8(t.k))
end
end
end
for e in all{n.v,ne(n,n.v)}do
local t=ne(n,e)
while#e.eH>0do
local n=deli(e.eH,1)
if n.o.s~=1and(n.o==e.o or n.o==t.o)then
return n
end
end
if e.o.D<=0and e.o.s==1then
return nN(e,n8(e.k))
end
if not e.f9 then
e.f9=true
return oZ(e)
end
end
end,function(_ENV,e)
for n in all(w)do
if n.d==e then
return true
end
end
end,function(_ENV)
return#nB(_ENV,true)==0
end,function(t,f)
local n={}
foreach(t.w,function(e)
if e.d>0and(f or e.ek>0and t.eQ~=e.et)then
add(n,e)
n[e]=true
end
end)
return n
end,function(_ENV)
if ev~=0then
return{g}
else
return nB(_ENV)
end
end,function(e,n)
return(eJ[e.eL][n.eE]or 1)*(eJ[e.eL][n.ew]or 1)
end)
F(ea,"tU,@,f3,@,aa,@,f7,@,fL,@,tC,@,al,@,aT,@,fk,@,as,@",function(n,t,e)
local a,f=n:ex"e0",t:ex"e0"
if e.eL%2==1then
a,f=n:ex"R",t:ex"A"
if t.av then
f*=2
end
elseif t.ah then
f*=2
end
local o=1024
if nQ(e.d,"107,164,57,157 ")then o*=.3end
if a2 then o*=.3end
local d=rnd"1"<min(.99,(n.tr+76)/o)and e.d>0and 2or 1
local o=mid(
3,997,
(100*d/5+2)/50
*e.t1
*mid(10,.2,a/f)
)+2
local a,f=o,td(e,t)
*((e.eL==n.eE or e.eL==n.ew)and 1.5or 1)
*(rnd".15"+.85)
if f>0then
return mid(1,999,a*f\1),d>1
end
return 0,false
end,function(_ENV)
v=_ENV[f4]
do local _ENV=v.o
nH,tS=0,false
end
v.f9=false
if v.a5 then
local e=fv(v.o)
nS(v,e[b(#e)+1]or q(0))
_ENV:Y()
elseif#v.eH>0then
_ENV:Y()
else
fw.a,
fI.a,
th.a,
eq,
eI[#eI]=v.fj,
v.aP,
v.aE,
nE(v,"|begins|turn"),
eC
_ENV:Y"a0"
end
end,function(_ENV)
_ENV:H()
nt=_ENV:ne(v)
_ENV:Y"tX"
end,function(_ENV,e,t)
e.tp,t.tp="eO","eA"
for n in all{e,t}do
_ENV[n.tp]=m("eH,#,eB,1,fj,@,aP,@,aE,@,k,@,n,@,a5,@,a_,@",J(Q),
J(Q),
J(n4,3),
unpack(n))
local e=_ENV[n.tp]
e.fj.nl=function()
_ENV:H()
_ENV:Y"ar"
end
add(e.eH,nN(e,n8(e.k)))
end
_ENV:eh"fg"
end,function(_ENV,e,t,f,o)
local n={}
for t=1,#e do
tn(n,t,e[t])
end
f7(_ENV,
{_ENV:ez"j","player",false,f},
{n,t,true,o}
)
end,function(e)
fk(peek2(e),
function(...)return al(0x8000+e*0x1000,...)end,
function(...)return aT(0x8000+e*0x1000,...)end)
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
function fz(f)
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
local t=fz(e)
n+=t
until t<(1<<e)-1
return n
end
local i,d,f,e,o,c,u,n,t=no"1",no"0",no"1",{},{},0,0,0
for n=1,no"1"do add(e,fz(f))end
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
if e.eP then K(e.eP)end
e:tw()
end)
ea.nK=m"-1;,none,17,0,40,0,~f;0;,struggle,17,0,50,100,~nb;;,megapnch,1,20,80,85,~f;;,razrwind,1,10,80,75,~n0;;,sworddnc,1,30,0,0,~x,~h,R,2;;,whrlwind,1,20,0,100,~l,~nW;;,megakick,1,5,120,75,~f;;,toxic,5,10,0,85,~fY;;,horndril,1,5,-5,30,~nY;;,bodyslam,1,15,85,100,~f,30,~X,4;;,takedown,1,20,90,85,~nb;;,doubedge,1,15,100,100,~nb;;,bublbeam,4,20,65,100,~f,10,~l,~h,M,-1;;,watergun,4,25,40,100,~f;;,icebeam,10,10,95,100,~f,10,~X,3;;,blizzard,10,5,120,90,~f,10,~X,3;;,hyprbeam,1,5,150,90,~oa;;,payday,1,20,40,100,~f;;,submsion,3,20,80,80,~nb;;,counter,3,20,-5,100,~oi;;,seistoss,3,20,-5,100,~ei,50;;,rage,1,20,20,100,~ot;;,megdrain,8,10,40,100,~nx;;,solrbeam,8,10,120,100,~n0;;,drgnrage,14,10,-5,100,~ei,40;;,thndrblt,6,15,95,100,~f,10,~X,4;;,thunder,6,10,120,70,~f,10,~X,4;;,earthqke,7,10,100,100,~f;;,fissure,7,5,-5,30,~nY;;,dig,7,10,100,100,~nr,|begins|digging;;,psychic,12,10,90,100,~f,30,~l,~h,e0,-1;;,teleport,12,20,0,0,~x,~nW;;,mimic,1,10,0,0,~fQ;;,doubteam,1,15,0,0,~x,~h,ep,1;;,reflect,12,20,0,0,~x,~e6,|raises|defense,av;;,bide,1,10,-5,100,~of;;,metrnome,1,10,0,0,~fV;;,selfdstr,1,5,260,100,~f;;,eggbomb,1,10,100,75,~f;;,fireblst,2,5,120,85,~f,30,~X,2;;,swift,1,20,60,-5,~f;;,skulbash,1,15,100,100,~n0;;,softboil,1,10,0,0,~t7;;,dreameat,12,15,100,100,~o1;;,skyattck,9,5,140,90,~n0;;,rest,12,10,0,0,~od;;,thndrwav,6,20,0,100,~X,4;;,psywave,12,15,-5,80,~oo;;,explsion,1,5,340,100,~f;;,rockslid,13,10,75,90,~f;;,triattck,1,10,80,100,~f;;,substute,1,10,0,0,~on;;,cut,1,30,50,95,~f;;,fly,9,15,70,95,~nr,|begins|flying;;,surf,4,15,95,100,~f;;,strength,1,15,80,100,~f;;,flash,1,20,0,70,~l,~h,B,-1;;,pound,1,35,40,100,~f;;,karatchp,3,25,55,100,~f;;,doubslap,1,10,15,85,~ey;;,comtpnch,1,15,20,85,~ey;;,firepnch,2,15,75,100,~f,10,~X,2;;,icepnch,10,15,75,100,~f,10,~X,3;;,thndpnch,6,15,75,100,~f,10,~X,4;;,scratch,1,35,40,100,~f;;,vicegrip,1,30,55,100,~f;;,guilotin,1,5,-5,30,~nY;;,gust,9,35,40,100,~f;;,wingatck,9,35,35,100,~f;;,bind,1,20,15,75,~ni;;,slam,1,20,80,75,~f;;,vinewhip,8,10,35,100,~f;;,stomp,1,20,65,100,~f,30,~l,~e8;;,doubkick,3,30,30,100,~n1,2,~L;;,jumpkick,3,20,70,95,~f;;,rllngkck,3,15,60,85,~f,30,~l,~e8;;,sandatck,7,15,0,100,~l,~h,B,-1;;,headbutt,1,15,70,100,~f,30,~l,~e8;;,hornatck,1,25,65,100,~f;;,furyatck,1,20,15,85,~ey;;,tackle,1,35,35,95,~f;;,wrap,1,20,15,85,~ni;;,thrash,1,20,90,100,~tj;;,tailwhip,1,30,0,100,~l,~h,A,-1;;,psnsting,5,35,15,100,~f,20,~X,5;;,twineedl,11,20,25,100,~o0;;,pinmisil,11,20,15,85,~ey;;,leer,1,30,0,100,~l,~h,A,-1;;,bite,1,25,60,100,~f,10,~l,~e8;;,growl,1,40,0,100,~l,~h,R,-1;;,roar,1,20,0,100,~l,~nW;;,sing,1,15,0,55,~X,6;;,sprsonic,1,20,0,55,~l,~nd;;,sonicbom,1,20,-5,90,~ei,20;;,disable,1,20,0,55,~fN;;,acid,5,30,40,100,~f,10,~l,~h,A,-1;;,ember,2,25,40,100,~f,10,~X,2;;,flamthwr,2,15,95,100,~f,10,~X,2;;,mist,10,30,0,0,~x,~e6,|stat lower|immunity,ov;;,hydropmp,4,5,120,80,~f;;,psybeam,12,20,65,100,~f,10,~l,~nd;;,aurorabm,10,20,65,100,~f,10,~l,~h,R,-1;;,peck,9,35,35,100,~f;;,drillpck,9,20,80,100,~f;;,lowkick,3,20,50,90,~f,30,~l,~e8;;,absorb,8,20,20,100,~nx;;,leechsed,8,10,0,90,~l,~e6,|is now|seeded,ac,1,~es;;,growth,1,40,0,0,~x,~h,e0,1;;,razrleaf,8,25,55,95,~f;;,psnpowdr,5,35,0,75,~X,5;;,stunspor,8,30,0,75,~X,4;;,slppowdr,8,15,0,75,~X,6;;,petldanc,8,20,70,100,~tj;;,strngsht,11,40,0,95,~l,~h,M,-1;;,firespin,2,15,15,70,~ni;;,thndshck,6,30,40,100,~f,10,~X,4;;,rockthrw,13,15,50,65,~f;;,cnfusion,12,25,50,100,~f,10,~l,~nd;;,hypnosis,12,20,0,60,~X,6;;,meditate,12,40,0,0,~x,~h,R,1;;,agility,12,30,0,0,~x,~h,M,2;;,quickatk,1,30,40,100,~f;;,ngtshade,15,15,-5,100,~ei,50;;,screech,1,10,0,85,~l,~h,A,-2;;,recover,1,20,0,0,~t7;;,harden,1,30,0,0,~x,~h,A,1;;,minimize,1,20,0,0,~oe;;,smokscrn,1,20,0,100,~l,~h,B,-1;;,cnfusray,15,10,0,100,~l,~nd;;,withdraw,4,40,0,0,~x,~h,A,1;;,dfnscurl,1,40,0,0,~x,~h,A,1;;,barrier,12,30,0,0,~x,~h,A,2;;,lghtscrn,12,30,0,0,~x,~e6,|raises|spcdefense,ah;;,haze,10,30,0,-5,~fU;;,fcsenrgy,1,30,0,0,~x,~e6,|raises|crit ratio,a2;;,mirrmove,9,20,-5,0,~fW;;,lick,15,30,20,100,~f,30,~X,4;;,smog,5,20,20,100,~f,30,~X,5;;,sludge,5,20,65,100,~f,30,~X,5;;,boneclub,7,20,65,85,~f,10,~l,~e8;;,watrfall,4,15,80,100,~f;;,clamp,4,10,35,75,~ni;;,spikcann,1,15,20,100,~ey;;,constrct,1,35,10,100,~f,10,~l,~h,M,-1;;,amnesia,12,20,0,0,~x,~h,e0,2;;,kinesis,12,15,0,80,~l,~h,B,-1;;,hijmpkck,3,20,85,90,~f;;,glare,1,30,0,75,~X,4;;,poisngas,5,40,0,55,~X,5;;,barrage,1,20,15,85,~ey;;,leechlif,11,15,20,100,~nx;;,lovekiss,1,10,0,75,~X,6;;,tranform,1,10,0,0,~fR;;,bubble,4,30,20,100,~f,10,~l,~h,M,-1;;,dizypnch,1,10,70,100,~f;;,spore,8,15,0,100,~X,6;;,splash,1,40,0,0,~fZ;;,acidarmr,5,40,0,0,~x,~h,A,2;;,crabhamr,4,10,90,85,~f;;,furyswps,1,15,10,80,~ey;;,bonerang,7,10,50,90,~n1,2,~L;;,hyprfang,1,15,80,90,~f,10,~l,~e8;;,sharpen,1,30,0,0,~x,~h,R,1;;,convrson,1,30,0,0,~fS;;,suprfang,1,10,-5,90,~o_;;,slash,1,20,70,100,~f"
fe=m"0,0x5e00,1,0x5e1e,2,0x5e3c"
fy=16
function _init()
local _ENV=ea
memset(0x8000,0,0x7fff)
nf=t3"eC,aX,T,~as,eF,4;tH;e_,eD,eF,4,eP,~z,nG,~z,tw,~L,er,~L,eT,~L,em,~L,P,~L,E,~L,eo,;aX;next,f6,Z,.3,eT,~el;f6;next,eD,Z,.3,eT,~el,eP,157;fx;e_,eD,next,eD,Z,.3,eP,158,eT,~el;eD;e_,eD,next,tG,tw,~oM,eT,~el,er,~oN;tG;e_,tG,next,aL,Z,.3,eP,159,eT,~el;aL;e_,nI,next,aO,Z,.2,eT,~el;aO;e_,nI,next,aG,eF,3,Z,.3,eP,155,eT,~el;aG;e_,nI,next,aI,eF,2,Z,.2,eP,154,eT,~el;aI;e_,nI,next,f8,eF,1,Z,.4,eP,153,eT,~el;f8;e_,nI,next,tL,eF,0,eP,152,tw,~oB,eT,~el,er,~oD,em,~oF,P,~oH,E,~oJ;tL;e_,tL,next,eD,eP,159,Z,.3,eT,~el,er,~L;"
el(nf)
flip()
nM"153"tC(0x0)
nM"154"tC(0x2)
nM"155"tC(0x4)
C(poke,";,0x5f5c,8;;,0x5f5d,2;;,0x5f56,0xe0")
fk(peek2"0x6",mget,mset)
ou()
om()
local e=peek2"0xa"
for t,f in pairs(nV)do
local n={n=f}
for t=1,6do
add(n,peek(e))
e+=1
end
nV[t]=n
end
C(memcpy,";,0x0000,0xc000,0x2000")
end
function _update60()
local _ENV=ea
nT,e9,nz,nj=btnp"4",btnp"5",btnp"0"and btnp"1"and 0or btnp"0"and-1or btnp"1"and 1or 0,btnp"2"and btnp"3"and 0or btnp"2"and-1or btnp"3"and 1or 0
if@0x5eff==1then
nT,e9=e9,nT
end
nf:tb()
if tO then
tO=nM(tO)
end
end
function _draw()
local _ENV=ea
nf:eT()
end