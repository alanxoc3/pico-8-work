eo=setmetatable({},{__index=_ENV})
_ENV=eo
function nO(e,n,t)
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
add(e,nO(n,f,o))
end)
else
for n=1,#t,2do
e[t[n]]=nO(t[n+1],f,o)
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
return F(setmetatable({},{__index=eo}),...)
end
F(eo,"el,@,j,@,fk,@,L,@",true,false,"",function(...)return...end)
F(eo,"m,@,F,@,nO,@,tC,@,tp,@,Y,@,tw,@,t3,@,nG,@,H,@,e2,@,eE,@,b,@,C,@,nI,@,e4,@,e5,@,U,@,fj,@,t4,@,tg,@,eJ,@,tb,@,na,@,nd,@,nS,@,e_,@,nC,@,J,@,fz,@,fq,@,fA,@,fB,@,fD,@,fF,@,Q,@,np,@,tx,@,eg,@,fH,@,t6,@,fJ,@,fK,@,fM,@,fN,@,nw,@,t8,@,fQ,@,fR,@,ty,@,fS,@,t7,@,z,@,E,@,v,@,fU,@,fV,@,t9,@,X,@,eb,@,ex,@,ni,@,fW,@,fY,@,fZ,@,oe,@,on,@,ot,@,tk,@,nr,@,n0,@,n1,@,of,@,oo,@,o_,@,nm,@,e6,@,oa,@,n3,@,f,@,n4,@,od,@,nU,@,tj,@,tz,@,ea,@,eK,@,nc,@,tq,@,oi,@,ng,@,tA,@,nV,@,nW,@,nb,@,o0,@,nY,@,nu,@,e8,@,o1,@",m,F,nO,function(e)
return F(m"nx,0,tB,0,tD,~el,l,~L,ed,~L,eG,#;",e)
end,function(_ENV,e)
if e==ey then
return ei and nx/ei or 0
end
if _ENV[e]and _ENV[e].om then
return 1
end
return 0
end,function(_ENV,e)
n6=e or next
end,function(_ENV,e)
nx,n6,tD,next,ei=0
_ENV[ey].om=true
for e,n in pairs(tF)do _ENV[e]=n end
for n,t in pairs(_ENV[e])do _ENV[n]=t end
ey=e
_ENV:l()
tB=#eG
end,function(_ENV)
nx+=1/60
if tD then _ENV:tw(ey)end
if ei and nx>=ei then
_ENV:Y()
end
while n6 do
_ENV:tw(n6)
end
_ENV:ed()
end,function(_ENV,e)
while n6~=e and#eG>0do
_ENV:H()
end
end,function(_ENV)
deli(eG)
_ENV:Y(eG[#eG]or"eM")
end,function(_ENV,e)
add(eG,e)
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
end,m"",split"missingno,bulbasaur,ivysaur,venusaur,charmander,charmeleon,charizard,squirtle,wartortle,blastoise,caterpie,metapod,butterfree,weedle,kakuna,beedrill,pidgey,pidgeotto,pidgeot,rattata,raticate,spearow,fearow,ekans,arbok,pikachu,raichu,sandshrew,sandslash,nidoran f,nidorina,nidoqueen,nidoran m,nidorino,nidoking,clefairy,clefable,vulpix,ninetales,jigglypuff,wigglytuff,zubat,golbat,oddish,gloom,vileplume,paras,parasect,venonat,venomoth,diglett,dugtrio,meowth,persian,psyduck,golduck,mankey,primeape,growlithe,arcanine,poliwag,poliwhirl,poliwrath,abra,kadabra,alakazam,machop,machoke,machamp,bellsprout,weepinbell,victreebel,tentacool,tentacruel,geodude,graveler,golem,ponyta,rapidash,slowpoke,slowbro,magnemite,magneton,farfetchd,doduo,dodrio,seel,dewgong,grimer,muk,shellder,cloyster,gastly,haunter,gengar,onix,drowzee,hypno,krabby,kingler,voltorb,electrode,exeggcute,exeggutor,cubone,marowak,hitmonlee,hitmonchan,lickitung,koffing,weezing,rhyhorn,rhydon,chansey,tangela,kangaskhan,horsea,seadra,goldeen,seaking,staryu,starmie,mr mime,scyther,jynx,electabuzz,magmar,pinsir,tauros,magikarp,gyarados,lapras,ditto,eevee,vaporeon,jolteon,flareon,porygon,omanyte,omastar,kabuto,kabutops,aerodactyl,snorlax,articuno,zapdos,moltres,dratini,dragonair,dragonite,mewtwo,mew",m"0,none;,fainted,burned,frozen,paralyzed,poisoned,sleeping",m"0, ;,FNT,BRN,FZN,PAR,PSN,SLP",m"0;c,2,n,~fk;1;c,2,n,normal,15,0,13,.5;2;c,10,n,fire,8,2,10,2,11,2,2,.5,4,.5,13,.5,14,.5;3;c,7,n,fighting,10,2,1,2,13,2,15,0,11,.5,9,.5,5,.5,12,.5;4;c,9,n,water,2,2,7,2,13,2,14,.5,8,.5,4,.5;5;c,6,n,poison,11,2,8,2,15,.5,7,.5,5,.5,13,.5;6;c,11,n,electric,9,2,4,2,7,0,14,.5,6,.5,8,.5;7;c,7,n,ground,6,2,2,2,5,2,13,2,9,0,11,.5,8,.5;8;c,8,n,grass,7,2,13,2,4,2,11,.5,14,.5,2,.5,9,.5,8,.5,5,.5;9;c,2,n,flying,11,2,3,2,8,2,6,.5,13,.5;10;c,9,n,ice,14,2,9,2,8,2,2,.5,10,.5,4,.5;11;c,8,n,bug,8,2,12,2,3,.5,2,.5,9,.5,15,.5,5,.5;12;c,6,n,psychic,3,2,5,2,12,.5;13;c,2,n,rock,11,2,2,2,9,2,10,2,3,.5,7,.5;14;c,2,n,dragon,14,2;15;c,6,n,ghost,15,2,1,0,12,2;17;c,2,n,bird;",m"V,hp,er,spc,R,att,q,def,M,spd,n8,tot,A,acc,eI,eva",m";c,13,e0,5,nl,1;;c,6,e0,13,nl,13;;c,5,e0,5,nl,1;;c,6,e0,5,nl,5;;c,1,e0,5,nl,13;;c,14,e0,4;;c,9,e0,4;;c,11,e0,3;;c,12,e0,5;;c,8,e0,2;;c,10,e0,4",m"",split"youngstr,bugcatch,junior,brock,lass,hiker,swimmer,misty,gentlman,sailor,rocker,ltsurge,channelr,gambler,beauty,erika,biker,birdkeep,juggler,koga,blckbelt,rocket,psychic,sabrina,scientst,pkmaniac,suprnerd,blaine,cooltrnr,fishrman,tamer,giovanni,lorelei,bruno,agatha,lance,blue,green,red,legendry",function(e,n)
if n.Z then
e:e2(n.Z)
else
e:H()
end
end,function(e,n)
return m("oc,@,tH,@,S,~tH,x,1,ed,~fB,e1,~fF,nT,~fq,N,~fz",e,n or 0)
end,function(e,n)
return F(nC(e),"p,0,x,@,ed,~fD,nZ,~fA",n or 1)
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
if 0+n~=0then K"154"end
else
eE()
end
else
local t=e.p+n
local f=e.p-e.p%e.x
if t==mid(f,t,f+e.x-1)then
e.p=t
if 0+n~=0then K"154"end
else
eE()
end
end
e.p=mid(0,e.p,#e-1)
if e.p\e.x<e.S then e.S=e.p\e.x end
if e.p\e.x>e.S+2then e.S=e.p\e.x-2end
e.S=mid(0,e.S,(#e-1)\e.x)
end,function(n)
local e=n.a
if eQ then K"154"e.nT(n)end
if e7 then n:ny()end
e.S+=te
if tn~=0then n:tJ(tn)end
local n=e.S
e.S=mid(e.tH,e.S,#e-3)
if e.S~=n then
eE()
elseif te~=0then
K"154"
end
end,function(t)
local e=t.a
e:nZ"0"
e:nZ(te,true)
e:nZ(tn)
if e7 then
local n=e[e.p+1]
if n.em then
eE()
elseif n.I then
K"155"
n.I(t,n)
end
end
if eQ then K"154"e.nT(t)end
end,function(n)
local e=n.a
local f=e.x>1and 10or 40
local a=20-(e.x*f)/2
C(rectfill,";,0,0,39,39,1;;,0,@,39,@,13",5-e.S*10,4+(max(ceil(#e/e.x),3)-e.S)*10)
for n=-1,e.x*5-1do
local d=(e.S-1)*e.x+n+1
local t=e[d]
if t then
local o,i,r=t.n7 or 1,a+n%e.x*10,n\e.x*10
if t.em then o=3end
if d-1==e.p then o+=1end
if not t.tt then
rectfill(i,r-5,i+f-1,r+4,na[o].c)
nI(n%e.x*f+a+f/2,n\e.x*10-3,function()
e.oc(t,na[o])
end)
end
end
end
end,function(e,n)
if e.ee then
local n=na[eJ[e.ee.eX].c]
C(rectfill,";,-20,-2,19,17,@;;,-20,14,19,17,@",n.c,n.e0)
e.ee:n9(0,8,n,1,1)
else
tK(e.n,0,0,n.nl)
end
end,function(e,n)
e.ee:n9(0,3,n,.375,.375)
end,function(n)
local e=nW(n.y)
del(e,n.o.W)
if#e>0then
return e[b(#e)+1]
end
end,function(_ENV,e)
local n=ns[e]
if e=="eI"or e=="A"then
return _ENV[e]*mid(1,1+n/3,3)/mid(1,1-n/3,3)
end
return ceil(mid(1,999,
(e=="R"and T==2and.5or e=="M"and T==4and.25or 1)*
_ENV[e]*mid(2,2+n,8)/mid(2,2-n,8)
))
end,function(_ENV)
if i.tf>0then return true end
local e=nk(i)
if#e==0then return true end
i.tf,i.eR=b"6"+2,e[b(#e)+1].en
r(eT,"|"..i.w[i.eR].n.."|disabled")
if i.g and i.g.en==i.eR then
i.es=0
end
end,function(_ENV,t,n)
local e=B(t,n)
e.e9,e.tM=5,5
w[n]=e
return e
end,function(_ENV)
local n=nk(i,true)
r(O,"|copies|"..t6(e,n[b(#n)+1].d,u.en).n)
end,function(_ENV)
if e.ou then
return true
else
r(O,"|copies|"..i.n,function()
e.ou=true
foreach(split"d,R,q,M,er,eX,eC",function(n)
e[n]=i[n]
end)
e.w={}
foreach(i.w,function(n)
t6(e,n.d,n.en)
end)
end)
end
end,function(_ENV)
F(e,"eX,@,eC,@",i.eX,i.eC)
r(O,"|copies|types")
end,function(_ENV)
foreach({eT,O},function(e)
r(e,"|resets|stats",function()
F(e.o.ns,"er,0,R,0,q,0,M,0,A,0,eI,0")
e.o.tN=false
end)
end)
end,function(_ENV,n,e)
e=min(e,n.o.V-n.o.D)
if e>0then
tj(_ENV,n,e,function()
n.o.W.D+=e
end)
else
return true
end
end,function(_ENV)
return nw(_ENV,O,e.V\2)
end,function(_ENV)
to(O,B(b(164)+1,u.en))
end,function(_ENV)
if e.t_>0then
to(O,B(e.t_,u.en))
else
return true
end
end,function(_ENV)
local e=tx(eT)
if e then
ta(eT,e)
else
return true
end
end,function(_ENV)
local e=tx(O)
if e then
ta(O,e)
else
return true
end
end,function(e,n)
return(sgn(e)>0and"|+"or"|-")..abs(e).." "..n.."|change"
end,function(_ENV,e,...)return e(_ENV,O,...)end,function(_ENV,e,...)return e(_ENV,eT,...)end,function(_ENV,e,n,t,o)
local f=e.o.ns[n]
if not e.o.ol or t>0then
e.o.ns[n]=mid(-6,6,f+t)
end
if f~=e.o.ns[n]then
r(e,t7(t,tb[n]),o or L)
else
return true
end
end,function(_ENV)
if X(_ENV,5)and i.T~=5then
return true
end
return E(_ENV,eb,"|badly|poisoned","nj",1,true)
end,function(_ENV)
r(O,"|does|nothing")
end,function(_ENV)
return td(u,i)>0and u.eL~=i.eX and u.eL~=i.eC
end,function(_ENV,n)
if i.W.T==3and n==2then
r(O,"|thawed|out")
e.W.T=0
elseif i.W.T==0and(n==6or t9(_ENV))then
r(eT,"|is now|"..t4[n],function()
i.W.T=n
i.ti=b"7"+1
end)
else
return true
end
end,function(_ENV,e,t,n,f,o)
if(e.o[n]or 0)==0and(not o or t9(_ENV))then
e.o[n]=f or 1
r(e,t)
else
return true
end
end,function(_ENV,e)
e.o.tQ=true
end,function(_ENV,e)
return eb(_ENV,e,"|becomes|confused","nz",b"4"+1)
end,function(_ENV)
return v(_ENV,O,"eI",1,function()
e.tN=.25
end)
end,function(_ENV)
local n=e.V\4
if n>=e.D or e.ep>0then
return true
end
eK(_ENV,n)
r(O,"|created|substitute",function()
e.ep=n
end)
end,function(_ENV)
ek(e,-1,u)
f(_ENV)
if u.e9<=0then
e.es,e.g=0
end
end,function(_ENV)
if not e.g then
ek(e,b"2"+1,B(u.d,u.en))
r(O,"|"..u.n.."|begins")
e.nq=0
end
if e.es==0then
if e.nq==0then
return true
end
ea(_ENV,e.nq*2)
end
end,function(_ENV)
ea(_ENV,1+b"75")
end,function(_ENV)
ea(_ENV,max(i.D\2,1))
end,function(_ENV)
ek(e,b"2"+1,B(u.d,u.en))
f(_ENV)
if e.es==0then
z(_ENV,ni,"nz")
end
end,function(_ENV)
if not e.g then
ek(e,b"4"+1,B(u.d,u.en))
e.nv=i
end
if e.nv==i then
f(_ENV)
else
return true
end
end,function(_ENV,n)
if e.g then
f(_ENV)
else
r(O,n,function()
ek(e,1,B(u.d,u.en))
end)
end
end,function(_ENV)
if e.g then
f(_ENV)
else
r(O,"|charges|energy")
ek(e,1,u)
u.e9+=1
end
end,function(_ENV)
if e.g then
r(O,"|recharges|energy")
else
f(_ENV)
local n=B(u.d,u.en)
n.A=0
ek(e,1,n)
end
end,function(_ENV)
r(O,"|is|sleeping",function()
e.W.T,e.ti=6,2
nw(_ENV,O,e.V)
end)
end,function(_ENV)
if e.nA>0then
ea(_ENV,e.nA*2)
else
return true
end
end,function(_ENV,e,n,t)
if e>0then
r(O,t and"|resumes|"..u.n,function()
_ENV.i=eT.o
f(_ENV,100,function()
nm(_ENV,e-1,n,true)
end)
end)
else
n()
end
end,function(_ENV,e)
nm(_ENV,2+b"4",L)
end,function(_ENV)
nm(_ENV,2,function()
if rnd"100"<20then
X(_ENV,5)
end
end)
end,function(_ENV)
ea(_ENV,false,function(e)
eK(_ENV,max(1,e\4))
end)
end,function(_ENV,e,n,...)
local t={...}
ea(_ENV,false,function()
if rnd"100"<(e or 0)then
n(_ENV,unpack(t))
end
end)
end,function(_ENV)
ea(_ENV,false,function(e)
nw(_ENV,O,max(e\2,1))
end)
end,function(_ENV)
if i.T==6then
n4(_ENV)
else
return true
end
end,function(_ENV)
if e.M>=i.M then
ea(_ENV,i.D)
else
return true
end
end,function(_ENV,n,t,a,e)
local f=t7(t,"hp")
local o=e and n.o.ep+t<0
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
local o=not a and e.ep>0
tj(_ENV,t,-n,function()
e.nq+=n
if e.g and e.g.d==20then
v(_ENV,t,"R",1)
end
if f then f(n)end
if o then
e.ep=max(e.ep-n,0)
else
e.W.D=max(e.W.D-n,0)
end
end,o and"substitute")
end,function(_ENV,n,o)
local f,t=false,td(u,i)
if not n then
n,f=tR(e,i,u)
end
if t>0then
if u.eL%2==1then
i.nA+=n
end
if t>1then r(O,"|super|effective")
elseif t<1then r(O,"|not very|effective")end
if f then r(O,"|critical|hit")end
tz(_ENV,eT,n,false,o)
else
r(eT,"|resisted|attack")
end
end,function(_ENV,e)
tz(_ENV,O,e,true,L)
end,function(e)
return ceil(e+.5*93)+5
end,function()
return m("et,~el,R,0,q,0,er,0,M,0,V,0,D,0,n8,0,A,100,eI,100,tS,0,tU,0,tV,0,tr,0,tW,0,d,-1,oT,-1,n, ,eX,0,eC,0,eS,#,eU,#,nB,#,w,@",nD())
end,function()
local e=peek2"0x8"
U[-1]=tq()
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
local e=tq()
F(e,"d,@,oT,@,n,@,eX,@,eC,@,tS,@,tU,@,tV,@,tr,@,tW,@",t,
f,
fj[t+1],
unpack(n)
)
local o=e.eS
for f=8,#n do
local t=n[f]
if t==253then
o=e.eU
elseif t==252then
o=e.nB
else
add(o,t)
end
end
if f<t then
foreach(split"eS,eU,nB",function(n)
foreach(U[f][n],function(t)
add(e[n],t)
end)
end)
end
local n,f={},{}
foreach(e.eU,function(e)n[e]=true end)
for e=1,54do
if n[e]then add(f,e)end
end
e.eU=f
do local _ENV=e
F(_ENV,"R,@,q,@,er,@,M,@,V,@,D,~V",nc(tU),
nc(tV),
nc(tW),
nc(tr),
nc(tS)+55
)
n8=R+q+er+M+V
end
U[t]=e
end
end,function(e,n)
return setmetatable(m("w,@,T,0,et,~j",n),{__index=U[e]})
end,function(e)
foreach(nV(e.y),function(e)
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
return nW(e)[1]
end,function(e)
local n=e:ej"k"
n[e:G"ec"+1]=ng(-1,nD())
e8(e:G"k",n)
e:H()
end,function(e,o,n)
local t,f=U[n],nD()
for e=1,min(4,#t.eS)do
f[e]=B(t.eS[e],e)
end
e[o]=ng(n,f)
return e
end,function(e)
local a=tY[e]
local e=m""
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
e[t]=ng(o and@f or-1,n)
end
return e
end,function(e,o)
local n=tY[e]
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
local n,t={},deli(nF[e],6)
for t=6,#nF[e]do
add(n,deli(nF[e],6))
end
nd[e]=m("os,@,d,@,eV,@,n,@,eL,@,e9,@,tM,~e9,t0,@,A,@",function(e)
return t(e,unpack(n))
end,e,t,unpack(nF[e]))
end
end)
F(eo,"B,@,nD,@,t1,@,tm,@,tc,@,tu,@,tl,@,eW,@,ov,@,oh,@,tZ,@,eY,@,tT,@,nh,@,ts,@,fe,@,fn,@,o2,@,ft,@,eZ,@,o5,@,ff,@,oP,@,oE,@,fo,@,oX,@,oL,@,f_,@,oO,@,oG,@,oI,@,oC,@,op,@,fa,@,ow,@,o3,@,o4,@,og,@,ob,@,n2,@,aO,@,ox,@,o6,@,o8,@,oy,@,o7,@,o9,@,ok,@,oj,@,oz,@,oq,@,oA,@,oB,@,oD,@,oF,@,fd,@,G,@,ew,@,oH,@,fi,@,oJ,@,fr,@,K,@,ev,@,f0,@,tK,@,eN,@,ne,@,oK,@,f1,@,n9,@,oM,@,oN,@,oQ,@,fm,@,oR,@,oS,@,ej,@,n5,@,nH,@,nJ,@,ta,@,to,@,ek,@,oU,@,nK,@,oV,@,nM,@,nn,@,nP,@,nE,@,oW,@,oY,@,fc,@,fu,@,nk,@,fl,@,td,@,tR,@,fT,@",function(e,n)
return setmetatable(m("en,@",n or 0),{__index=nd[e]})
end,function()
local e={}
for n=1,4do add(e,B(-1))end
return e
end,function(e)
fd(e)
tK("team #"..e:G"k"+1,20,27,1)
end,function(_ENV)
local t,e,n=ez.o,eO.o,eq.o
local o,a=e==t,n==t
local t,f=11,11
C(rectfill,";,0,0,39,6,5;;,0,33,39,39,5")
C(rectfill,";,-1,33,@,41,1;;,-1,-2,@,6,1",max(ceil(e.D/e.V*40),0)-1,
max(ceil(n.D/n.V*40),0)-1)
C(rectfill,";,15,6,39,6,13;;,16,5,39,5,13;;,0,33,24,33,13;;,0,34,23,34,13")
C(eN,";,@,40,34,13,1;;,@,40,27,1,1;;,@,2,1,13,-1;;,@,2,7,1,-1",e.D,tg[e.T],n.D,tg[n.T])
local t,f=1,1
e:n9(10,25,na[4],t,t,o)
n:n9(30,15,na[4],-f,f,a)
end,function(e)oK(U[e:G"et"])end,function(e)e4("spot #"..(e:G"ec"+1))end,function(e)e4("move #"..(e:G"eP"+1))end,function(e)e4(e.nt)end,function(e)e4"match over"end,function(n)
local e=n:ew"nN"
e4(e and e.oZ)
end,function()
rectfill(0,0,46,13,13)
pal(7,1)
local e=0
for f,n in ipairs(split"6,5,5,6,6,5,6")do
sspr(6*8+e,6*8,n,8,e+3,3.5+cos((t()+f)/4))
e+=n
end
pal()
end,function(e)e4(e.ez.ae.n)end,function(e)
f1(e:n5())
end,function(n)
local e=n:ew(n.fs).u
if e.d>=0then
e5(eJ[e.eL].n.."|"..e.e9.."/"..e.tM.."|"..(e.t0>=0and e.t0 or"??").."P "..(e.A>=0and e.A or"??").."A")
else
e5"none|n/a|"
end
end,function(e)
f1(e:ew"et".ee)
end,function(e)
e5(e:ew"eM".e3)
end,function(_ENV)
if d>-1then
e5(n.."|"..D.."/"..V.."|"..t4[T])
else
e5"none|n/a|"
end
end,function(_ENV)fn(_ENV:ew"tv".ee)end,function(_ENV)fn(s.o)end,function(e)
local n,t=0,0
foreach(e:ew().y,function(e)
if e>-1then
n+=U[e].n8
t+=1
end
end)
e5(e:ew().n.."|len "..t.."/6|tot "..n)
end,function(e)
e5(e.nf.n.."|is the|winner")
end,function(e)
e5(e.ez.n..e.ez.fv)
end,function(_ENV)
local n=nn(_ENV,nf)
nf:an(n)
a:N{}
a.nT=function(e)
e:nG"th"
end
for e in all{nf,n}do
F(a,"S,0;;ee,@;;tt,~el;;n,@,n7,5;;n,@;;n,@",e.o.W,e.n,(#nW(e.y,true)).." live",(#nV(e.y)).." dead")
end
end,function(_ENV)
local e=0
for n=0,151do e+=U[n]:ne()and 1or 0end
a:N(
m(";n,browse,Z,et,I,~e_,e3,@;;n,edit,Z,k,I,~e_,e3,edit|stored|teams;;n,league,Z,fh,I,~e_,e3,@;;n,versus,Z,t2,I,~e_,e3,versus|p1 vs p2|match;;n,horde,Z,f2,I,~e_,e3,@;;n,credits,Z,f5,I,~e_,e3,credits|amorg|games","browse|"..e.."/151|pokemon","league|"..(@0x5efd).."/40|trainers","horde|"..(@0x5efe).."/151|hi-score")
)
end,function(_ENV,n)
local e={}
for n=0,151do
add(e,n)
end
a:N(
e,
function(e)
return m("I,@,em,@,ee,@",n,not U[e]:ne(),U[e])
end
)
end,function(_ENV)
fo(_ENV,function(_ENV)
_ENV:e2"fP"
end)
end,function(_ENV)
fo(_ENV,function(_ENV)
e8(_ENV:G"k",nY(_ENV:ej"k",_ENV:G"ec"+1,_ENV:G"et"))
_ENV:H()
end)
end,function(_ENV)
local e=_ENV:ew"et".ee
a:N{}
F(a,";ee,@;;tt,~el;;n,lvl 50,n7,5",e)
foreach(split"V,er,R,q,M,n8",function(n)
add(a,{n=tb[n].." "..e[n]})
end)
C(function(t,n)
if#U[e.d][n]>0then
add(a,{n=t,n7=5})
foreach(U[e.d][n],function(e)
add(a,{n=nd[e].n})
end)
end
end,";,learn,eS;;,teach,eU;;,event,nB")
end,function(_ENV)
a:N(
split"91,,#alanxoc3,code &,design,28,,#gr8cadet,pokemon,sprites,143,,#tigrwolf,battle,testing,127,,#tooling,px9 func,shrinko8,137,,#pkmndata,blbpedia,pokeapi,serebii,smogon,upokcntr,volvox,nintendo",
function(e)
if type(e)=="number"then
return{ee=ng(e,nD())}
end
local n=1
if sub(e,1,1)=="#"then
e,n=sub(e,2),5
end
return{n=e,n7=n,tt=e==""}
end
)
end,function(_ENV)
a:N(nS,function(e,n)
return{
n=e.n,
y=e,
em=n-1>@0x5efd,
I=function(t,e)
fE(t,e.y,e.n,function(t,e)
poke(0x5efd,mid(@0x5efd,n,40))
tA(e)
end,L)
end
}
end)
end,function(_ENV)
a:N(m";n,moves,Z,eP,I,~e_;;n,switch,Z,t5,I,~e_;;n,delete,I,~o0")
end,function(_ENV)
local n=_ENV:n5()
local e=0
for t=1,4do
if n.w[t].d>0then e+=1end
end
a:N(m(";n,change,Z,nN,I,~e_;;n,switch,Z,fX,I,~e_;;n,delete,em,@,I,~op",e==1))
end,function(_ENV)
local e,n=_ENV:n5()
e.w[_ENV:G"eP"+1]=B(-1)
e8(_ENV:G"k",n)
_ENV:H()
end,function(_ENV,f,o)
local n,d=_ENV:n5()
a:N(m",1,2,3,4",function(e)
local t=n.w[e]
return{
u=t,
n=t.n,
I=function(_ENV)o(_ENV,e,n,d)end,
em=e==f
}
end)
end,function(_ENV)
fa(_ENV,0,function(_ENV,e,n)
_ENV:e2(n.w[e].d>0and"fL"or"nN")
end)
end,function(_ENV)
local n=_ENV:G"eP"+1
fa(_ENV,n,function(_ENV,t,e,f)
e.w[t],e.w[n]=e.w[n],e.w[t]
e8(_ENV:G"k",f)
_ENV:nG"eP"
end)
a.p=eP.a.p
end,function(_ENV)
local n=_ENV:n5()
local e=U[n.d]
local t={}
C(function(f,a)
for o=1,#f do
local e=f[o]
add(t,{n=nd[e].n,em=n:fc(e),d=e,e3=a..o})
end
end,";,@,learn #;;,@,teach #;;,@,event #",e.eS,e.eU,e.nB)
a:N(t,function(e)
return{
n=e.n,
em=e.em,
u=nd[e.d],
oZ=e.e3,
I=function()
local n=_ENV:ej"k"
n[_ENV:G"ec"+1].w[_ENV:G"eP"+1]=B(e.d)
e8(_ENV:G"k",n)
_ENV:nG"eP"
end
}
end)
end,function(_ENV)
local n=fl(s.o)
if s.o.g then
nM(s,s.o.g)
_ENV:H()_ENV:H()
elseif#n==0then
nM(s,B(0))
_ENV:H()_ENV:H()
end
a:N(s.o.w,function(e)
return m("em,@,n,@,u,@,I,@",
not n[e],
e.n,
e,
function()
_ENV:H()_ENV:H()
nM(s,e)
end
)
end)
end,function(_ENV)
a:N(m";n,fight,I,~e_,Z,fO;;n,switch,I,~e_,Z,tv;;n,forfeit,I,~at")
end,function(_ENV)
a:N(m",1,2,3",function(e)
local n=nu(e-1)
local t={}
local f=true
for e=1,6do
t[e]=n[e].d
if not n[e]:fu()then
f=false
end
end
return{
n="team #"..e,
y=t,
I=function()_ENV:nX()end,
em=nL and f
}
end)
end,function(e,n)
return e[n]and e[n].d or-1
end,function(_ENV)
local e=_ENV:ej"k"
a:N(m",1,2,3,4,5,6",function(n)
return{
ee=e[n],
I=function(_ENV)
if e[_ENV:G"ec"+1]:ne()then
_ENV:e2"fG"
else
_ENV:e2"fI"
end
end
}
end)
end,function(_ENV)
local e=_ENV:ej"k"
a:N(m",1,2,3,4,5,6",function(n)
return{
em=n==_ENV:G"ec"+1,
I=function(_ENV)
local n,t=_ENV:G"ec"+1,_ENV:G"t5"+1
e[n],e[t]=e[t],e[n]
e8(_ENV:G"k",e)
_ENV:nG"ec"
end,
ee=e[n]
}
end)
a.p=ec.a.p
end,function(_ENV)
local e=_ENV:ej"k"
a:N(m",1,2,3,4,5,6",function(e)
local n=s.y[e]:fu()or s.o.W==s.y[e]or s.y[e].T==1
return{
em=n,
I=function()
_ENV:H()_ENV:H()
ta(s,s.y[e])
end,
ee=s.y[e]
}
end)
end,function(_ENV)
local n,e=eO,eq
if n.eA==e.eA then e.eA+=sgn(rnd"2"-1)end
s=n.eA>e.eA and n or e
end,function(_ENV,e)
local n=true
for t=et.a.p+e,75.5+75.5*e,e do
if U[t]:ne()then
et.a.p,n=t
K"154"
break
end
end
if n then eE()end
f_(_ENV)
end,function(e)K(e:G"et")end,function()K(b"152")end,function(_ENV)K(nf.o.d)end,function(_ENV)
local e={}
for t,n in pairs(split"133,7,35,1,25,4")do
nY(e,t,n)
poke(0x5e5a+n,1)
end
if@0x5efc==0then
poke(0x5efc,1)
e8(0,e)
end
ef=tC"ey,eM;tF;a,~j,l,~L,tJ,~eE,ny,~L,ed,~oF,fs,~j,e1,~fd,h,~L,P,~L;eM;l,~oE,h,~tZ,P,~fe;et;l,~oX,h,~tc,P,~ts;fP;l,~f_,h,~tc,P,~ts,tJ,~o7,ny,~o9;ec;l,~ox,h,~tu,P,~tT,e1,~t1;t5;l,~o6,h,~tu,P,~tT,e1,~t1;fI;l,~oL,h,~tc,P,~ts;fG;l,~oI,h,~tu,P,~tT;fL;l,~oC,h,~tl,P,~nh,fs,eP;nN;l,~o4,h,~oh,P,~nh;eP;l,~ow,h,~tl,P,~nh;fX;l,~o3,h,~tl,P,~nh;k;nt,player,l,~n2,h,~eW,P,~eZ,nL,~j,nX,~oS;fh;nt,player,l,~n2,h,~eW,P,~eZ,nL,~el,nX,~oM;t2;nt,player 1,l,~n2,h,~eW,P,~eZ,nL,~el,nX,~oN;f2;nt,player,l,~n2,h,~eW,P,~eZ,nL,~el,nX,~oR;tP;nt,player 2,l,~n2,h,~eW,P,~eZ,nL,~el,nX,~oQ;th;nt,trainer,l,~oG,h,~eW,P,~eZ;tE;l,~oP,h,~ov,P,~o5,ny,~oj;fC;l,~ob,h,~eY,P,~ft;fO;l,~og,h,~eY,P,~nh;tv;l,~o8,h,~eY,P,~o2,e1,~t1;af;next,ao,l,~fT,fp,eO;ao;next,fw,l,~fT,fp,eq;fw;next,af,l,~oy,ed,~oW,e1,~tm,h,~eY,P,~ff,ez,~j;a_;l,~L,ed,~f3,e1,~tm,h,~eY,P,~ft;aa;l,~L,ed,~f3,e1,~tm,h,~eY,P,~ff;f5;l,~oO,h,~tZ,P,~fe,ny,~ok;"
C(function(e,n,...)
ef[e].a=n(...)
end,";,et,~J,~np,4;;,fP,~nC,~Q;;,f5,~nC,~Q;;,tE,~nC,~Q;;,ec,~J,~np,3;;,t5,~J,~np,3;;,eM,~J,~Q;;,fG,~J,~Q;;,fL,~J,~Q;;,nN,~J,~Q;;,eP,~J,~Q;;,fX,~J,~Q;;,k,~J,~Q;;,t2,~J,~Q;;,th,~J,~Q;;,tP,~J,~Q")
F(ef,"f4,@,ad,@;eM;a;nT,~eE;f2;a,~f4;fh;a,~f4;fI;a,~ad;",ef.k.a,ef.et.a)
menuitem(1,"close picodex",function()
menuitem(1)
menuitem(2)
_ENV:Y"tX"
end)
menuitem(2,"swap 🅾️/❎",function()
poke(0x5eff,@0x5eff==0and 1or 0)
end)
end,function(e)
e.ef:t3()
end,function()no.ef:e1()end,function()no.ef:h()end,function()no.ef:P()end,function(_ENV)a.ed(_ENV)end,function(_ENV)a.e1(_ENV)end,function(_ENV,e)
return _ENV[e].a.p
end,function(_ENV,e)
local n=e and _ENV[e].a or a
return n[n.p+1]
end,function(_ENV)
menuitem(1,"factory reset",function()
memset(0x5e00,0,0x100)
_ENV:Y"fg"
end)
end,function()
return btn()&0x3f~=0
end,function(_ENV)
if not fi()and nQ then
nQ=false
_ENV:Y()
menuitem(1)
elseif fi()then
nQ=true
menuitem(1)
end
end,0,function(e)
eo.fr=max(0,0+e-152)
sfx(54+e\16,0,e%16*2,2)
end,function(_ENV)
cls"0"
nI(0,128+sin(_ENV:tp"fb"/4)*128,function()
C(eN,";,aMORG gAMES,64,-68,7,0;;,pRESENTS,64,-61,7,0;;,a pOKEMON bATTLE sIM,64,15,7,0")
C(spr,";,102,44,7,5,1")
local t,
n,
e=
ef and ef.eM.a.p,
ef and ef.tB-1,
eu=="nR"and 1
or eu=="eB"and-1
or(eu=="tL"and-1or 1)*cos(_ENV:tp(eu)/2)
nI(30-(e+1)*15+(ey=="fg"and b"3"-1or 0),27,function()
C(rectfill,";,14,18,@,87,5",63+max(0,e*54))
if eD==0then
C(rectfill,";,14,18,117,87,13")
C(function(e,n,t,f,o)
clip(-%0x5f28+e,-%0x5f2a+n,t,f)
nI(e,n,o)
clip()
end,";,14,21,40,40,@;;,71,18,46,13,@;;,71,67,46,21,@",e1,h,P)
end
C(map,";,24,0,2,1,8,3;;,8,0,2,9,8,11")
C(function(e,n,t,f,o,a)
return spr((eD<=e)and(fr==e and stat"46">=0and f or t)or n,o,a)
end,";,0,135,133,134,6,3;;,1,132,128,131,12,3;;,2,132,129,131,17,3;;,3,132,130,131,22,3")
C(function(e,n,t,f,o)
spr(btn(e)and n or t,f,o)
end,";,0,186,154,10,77;;,1,188,156,26,77;;,2,171,139,18,73;;,3,187,155,18,81;;,4,170,138,42,77;;,5,172,140,50,77")
if e<=0then
f0(0,2+64*(1-abs(e)),abs(e))
if e==-1and nQ then spr(123,6,49)end
else
f0(16,62,e)
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
if e:ne()then
e5(e.n.."|"..eJ[e.eX].n.."|"..eJ[e.eC].n)
else
e5"none|n/a|"
end
end,function(_ENV,n,t,i,f,o,r)
local e,a=_ENV:ne()and d or-1,8*(tN or 1)
f*=a o*=a
local a=function(t,a)
local n,d=e/8\1,e%8
if n~=fx then
eo.fx=n
memcpy(0x0000,0x8000+0x400*n,0x400)
end
sspr(d*16,0,16,16,t-f,a-o,f*2,o*2)
end
foreach(m";,25,53,152;;,54,143,153",function(n)
if e==n[1]and _ENV:fc(n[2])then
e=n[3]
end
end)
if ep and ep>0then e=154end
if not ai or T~=1and not tO and not(es~=0and g.eV==n0)then
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
if r then
C(e,"c,@;;,~c,-2,~j,2,~j,1;;,~c,~j,-2,~j,2,1;;,~c,-2,0,2,0,1;;,~c,0,-2,0,2,1",i.c)
end
C(e,";,@,-1,~j,1,~j,1;;,1,~j,0,0,~j,1",i.e0)
pal()a(n,t)
end
end,function(e)e:e2"th"end,function(e)e:e2"tP"end,function(_ENV)
f6(_ENV,
m(",@,player 1,~j,~L",nu(_ENV:G"t2")),
m(",@,player 2,~j,~L",nu(_ENV:G"tP"))
)
end,function(_ENV)
poke(0x5efe,mid(@0x5efe,#nV(y),152))
end,function(_ENV)
local e={}
for n=1,152do add(e,n%152)end
fE(_ENV,e,"horde",function(n,e)
tA(e)
fm(e)
end,fm)
end,function(e)
e:e2"ec"
end,function(e,n)
return nu(e:G(n))
end,function(e)
local n=nu(e:G"k")
return n[e:G"ec"+1],n
end,function(e,n)
local f,t="|enters|fight",{}
foreach(n.w,function(e)
add(t,e)
end)
e.o=setmetatable(m("ai,~el,t_,0,A,1,eI,1,es,0,tO,~el,nA,0,nq,0,tf,0,nz,0,ti,@,ep,0,nj,0,W,@,w,@;ns;er,0,R,0,q,0,M,0,A,0,eI,0",b"7"+1,n,t),{__index=n})
return nP(e,f,function()
e.o.tO=false
end)
end,function(e,n)
for t in all(split(n))do
if t==e then
return true
end
end
end,function(e,n)
nE(e,e,"|leaves|fight",function(t)
t.e.tO=true
nE(e,e,false,function()
add(e.eF,nH(e,n))
end)
end)
e.eA=3000
end,function(t,n)
local f=t.o.g and"|resumes|"or(n.eV==aG and"|begins|"or"|uses|")
nE(t,t,f..n.n,function(f)
f.u=n
local _ENV=f
if n.d>0then
n.e9-=1
end
if nJ(n.d,"47,36 ")then
eK(_ENV,e.D)
end
if(function()
if n.A<=0then return false end
if(n.eV==n1 or n.eV==n0)and not e.g then return false end
if i.g and i.g.eV==n0 then return true end
if e.g and e.g.eV==nr then return false end
return rnd(i:eg"eI")>n.A/100*e:eg"A"or b"256"==0and b"256"==0
end)()then
r(t,"|misses|"..n.n)
if nJ(n.d,"145,73 ")then
eK(_ENV,1)
end
else
if n.os(_ENV)then
r(t,"|fails|attack")
end
end
if n.A~=0then
i.t_=n.d
end
end)
end,function(_ENV,e,n)
if not g and es==0then
es,g=e,n
end
end,function(n,t)
nE(n,n,false,function(f)
f.u=t
local _ENV=f
e:nK("es",L)
if e.T==6then
e:nK("ti",function()
r(n,"|suddenly|woke up")
e.W.T=0
end)
if e.T==6then
r(n,"|fast|asleep")
return
end
end
if e.T==3then
if rnd"1"<.2then
r(n,"|thawed|out")
e.W.T=0
else
r(n,"|is|frozen")
return
end
end
if i.nv==e then r(n,"|is|trapped")
elseif e.eR==t.en then r(n,"|is|disabled")
elseif e.T==4and b"4"==0then r(n,"|fully|paralyzed")
elseif e.tQ then r(n,"|is|flinching")
else
if e.nz>0then
r(n,"|is|confused")
if b"2"==0then
r(n,"|hurt|itself")
eK(_ENV,tR(e,i,B(-1)))
return
end
end
to(n,t)
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
return nP(n,false,function(_ENV)
if e.T==6
or e.T==3
or e.nv and e.nv~=i
then
e.es=0
end
if e.es==0then
e.nv,e.g=nil
end
local t=max(e.V\16,1)
local f=function(e)
r(n,e.."|damage")
eK(_ENV,t)
end
if e.T==5then
if e.nj>0then
t*=e.nj
e.nj+=1
end
f"|poison"
end
if e.T==2then f"|burn"end
if e.ar then
f"|seed"
if i.D<i.V then
nw(_ENV,eT,t)
end
end
e:nK("nz",function()
r(n,"|confusion|ended")
end)
e:nK("tf",function()
r(n,"|"..e.w[e.eR].n.."|enabled")
e.eR=0
end)
end)
end,function(e,n)
e.eF={}
local t=1000
oU(e,n)
if n.d==120then t=2000end
if nJ(n.d,"18,4,89,30 ")then
t=0000
end
e.eA=min(3000,t+e.o:eg"M")
end,function(e,n)
return n==e.eO and e.eq or e.eO
end,function(e,n,t,f)
return{ae=e,n=f or e.o.n,o=e.o,fv=n,a0=t or L}
end,function(e,...)
add(e.eF,nP(...))
end,function(e)
if eQ then eE()end
if e7 then K"154"end
if e7 or not e.ez then
while true do
for n in all{e.eO,e.eq}do
if not nb(n.y)then
e.nf=nn(e,n)
e:Y"tE"
return
end
end
local n=oY(e)
if n then
local f=n.o==e.eO.o and e.eO or e.eq
local t=m("u,@,O,@,eT,@,r,@",u,f,nn(e,f),function(...)
nE(f,...)
end)
t.e=t.O.o
t.i=t.eT.o
n.a0(t)
if n.fv then
e.ez=n
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
for t in all{n.eO,n.eq}do
if t.o.D<=0then
if t.o.T~=1then
return nP(t,"|has|fainted",function(_ENV)
e.W.T=1
end)
elseif t~=n.s then
return nH(t,nb(t.y))
end
end
end
for e in all{n.s,nn(n,n.s)}do
local t=nn(n,e)
while#e.eF>0do
local n=deli(e.eF,1)
if n.o.T~=1and(n.o==e.o or n.o==t.o)then
return n
end
end
if e.o.D<=0and e.o.T==1then
return nH(e,nb(e.y))
end
if not e.f8 then
e.f8=true
return oV(e)
end
end
end,function(_ENV,e)
for n in all(w)do
if n.d==e then
return true
end
end
end,function(_ENV)
return#nk(_ENV,true)==0
end,function(t,f)
local n={}
foreach(t.w,function(e)
if e.d>0and(f or e.e9>0and t.eR~=e.en)then
add(n,e)
n[e]=true
end
end)
return n
end,function(_ENV)
if es~=0then
return{g}
else
return nk(_ENV)
end
end,function(e,n)
return(eJ[e.eL][n.eX]or 1)*(eJ[e.eL][n.eC]or 1)
end,function(n,t,e)
local a,f=n:eg"er",t:eg"er"
if e.eL%2==1then
a,f=n:eg"R",t:eg"q"
if t.a1 then
f*=2
end
elseif t.am then
f*=2
end
local o=1024
if nJ(e.d,"107,164,57,157 ")then o*=.3end
if ac then o*=.3end
local d=rnd"1"<min(.99,(n.tr+76)/o)and e.d>0and 2or 1
local o=mid(
3,997,
(100*d/5+2)/50
*e.t0
*mid(10,.2,a/f)
)+2
local a,f=o,td(e,t)
*((e.eL==n.eX or e.eL==n.eC)and 1.5or 1)
*(rnd".15"+.85)
if f>0then
return max(1,a*f\1),d>1
end
return 0,false
end,function(_ENV)
s=_ENV[fp]
do local _ENV=s.o
nA,tQ=0,false
end
s.f8=false
if s.au then
local e=fl(s.o)
nM(s,e[b(#e)+1]or B(0))
_ENV:Y()
elseif#s.eF>0then
_ENV:Y()
else
fC.a,
fO.a,
tv.a,
ez,
eG[#eG]=s.fy,
s.al,
s.aT,
nP(s,"|begins|turn"),
ey
_ENV:Y"aa"
end
end)
F(eo,"f3,@,at,@,f6,@,fE,@,as,@,av,@,ah,@,f7,@,a2,@",function(_ENV)
if e7 then
_ENV:e2"fC"
K"155"
end
if eQ then eE()end
end,function(_ENV)
_ENV:H()
nf=_ENV:nn(s)
_ENV:Y"tE"
end,function(_ENV,e,t)
e.tG,t.tG="eO","eq"
for n in all{e,t}do
_ENV[n.tG]=m("eF,#,eA,1,fy,@,al,@,aT,@,y,@,n,@,au,@,an,@",J(Q),
J(Q),
J(np,3),
unpack(n))
local e=_ENV[n.tG]
e.fy.nT=function()
_ENV:H()
_ENV:Y"a_"
end
add(e.eF,nH(e,nb(e.y)))
end
_ENV:e2"fw"
end,function(_ENV,e,t,f,o)
local n={}
for t=1,#e do
nY(n,t,e[t])
end
f6(_ENV,
{_ENV:ej"k","player",false,f},
{n,t,true,o}
)
end,function(e)
f7(peek2(e),
function(...)return av(0x8000+e*0x1000,...)end,
function(...)return ah(0x8000+e*0x1000,...)end)
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
function f9(f)
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
function n_(n)
local e=0
repeat
e+=1
local t=f9(e)
n+=t
until t<(1<<e)-1
return n
end
local i,d,f,e,o,c,u,n,t=n_"1",n_"0",n_"1",{},{},0,0,0
for n=1,n_"1"do add(e,f9(f))end
for f=0,d do
for d=0,i-1do
n-=1
if(n<1)then
n,t=n_"1",not t
end
local i=f>0and r(d,f-1)or 0
local n=o[i]or{unpack(e)}
o[i]=n
local o=n[t and 1or n_"2"]
a(n,o)
a(e,o)
m(d,f,o)
end
end
end,function(e)
if e.eH then K(e.eH)end
e:tI()
end)
eo.nF=m"-1;,none,17,0,40,0,~f;0;,struggle,17,0,50,100,~n3;;,megapnch,1,20,80,85,~f;;,razrwind,1,10,80,75,~n1;;,sworddnc,1,30,0,0,~z,~v,R,2;;,whrlwind,1,20,0,100,~ty;;,megakick,1,5,120,75,~f;;,toxic,5,10,0,85,~fU;;,horndril,1,5,-5,30,~nU;;,bodyslam,1,15,85,100,~f,30,~X,4;;,takedown,1,20,90,85,~n3;;,doubedge,1,15,100,100,~n3;;,bublbeam,4,20,65,100,~f,10,~E,~v,M,-1;;,watergun,4,25,40,100,~f;;,icebeam,10,10,95,100,~f,10,~X,3;;,blizzard,10,5,120,90,~f,10,~X,3;;,hyprbeam,1,5,150,90,~of;;,payday,1,20,40,100,~f;;,submsion,3,20,80,80,~n3;;,counter,3,20,-5,100,~o_;;,seistoss,3,20,-5,100,~ea,50;;,rage,1,20,20,100,~fZ;;,megdrain,8,10,40,100,~n4;;,solrbeam,8,10,120,100,~n1;;,drgnrage,14,10,-5,100,~ea,40;;,thndrblt,6,15,95,100,~f,10,~X,4;;,thunder,6,10,120,70,~f,10,~X,4;;,earthqke,7,10,100,100,~f;;,fissure,7,5,-5,30,~nU;;,dig,7,10,100,100,~n0,|begins|digging;;,psychic,12,10,90,100,~f,30,~E,~v,er,-1;;,teleport,12,20,0,0,~fS;;,mimic,1,10,0,100,~fJ;;,doubteam,1,15,0,0,~z,~v,eI,1;;,reflect,12,20,0,0,~z,~eb,|raises|defense,a1;;,bide,1,10,-5,100,~oe;;,metrnome,1,10,0,0,~fQ;;,selfdstr,1,5,260,100,~f;;,eggbomb,1,10,100,75,~f;;,fireblst,2,5,120,85,~f,30,~X,2;;,swift,1,20,60,-5,~f;;,skulbash,1,15,100,100,~n1;;,softboil,1,10,0,0,~t8;;,dreameat,12,15,100,100,~od;;,skyattck,9,5,140,90,~n1;;,rest,12,10,0,0,~oo;;,thndrwav,6,20,0,100,~X,4;;,psywave,12,15,-5,80,~on;;,explsion,1,5,340,100,~f;;,rockslid,13,10,75,90,~f;;,triattck,1,10,80,100,~f;;,substute,1,10,0,0,~fY;;,cut,1,30,50,95,~f;;,fly,9,15,70,95,~n0,|begins|flying;;,surf,4,15,95,100,~f;;,strength,1,15,80,100,~f;;,flash,1,20,0,70,~E,~v,A,-1;;,pound,1,35,40,100,~f;;,karatchp,3,25,55,100,~f;;,doubslap,1,10,15,85,~e6;;,comtpnch,1,15,20,85,~e6;;,firepnch,2,15,75,100,~f,10,~X,2;;,icepnch,10,15,75,100,~f,10,~X,3;;,thndpnch,6,15,75,100,~f,10,~X,4;;,scratch,1,35,40,100,~f;;,vicegrip,1,30,55,100,~f;;,guilotin,1,5,-5,30,~nU;;,gust,9,35,40,100,~f;;,wingatck,9,35,35,100,~f;;,bind,1,20,15,75,~nr;;,slam,1,20,80,75,~f;;,vinewhip,8,10,35,100,~f;;,stomp,1,20,65,100,~f,30,~E,~ex;;,doubkick,3,30,30,100,~nm,2,~L;;,jumpkick,3,20,70,95,~f;;,rllngkck,3,15,60,85,~f,30,~E,~ex;;,sandatck,7,15,0,100,~E,~v,A,-1;;,headbutt,1,15,70,100,~f,30,~E,~ex;;,hornatck,1,25,65,100,~f;;,furyatck,1,20,15,85,~e6;;,tackle,1,35,35,95,~f;;,wrap,1,20,15,85,~nr;;,thrash,1,20,90,100,~tk;;,tailwhip,1,30,0,100,~E,~v,q,-1;;,psnsting,5,35,15,100,~f,20,~X,5;;,twineedl,11,20,25,100,~oa;;,pinmisil,11,20,15,85,~e6;;,leer,1,30,0,100,~E,~v,q,-1;;,bite,1,25,60,100,~f,10,~E,~ex;;,growl,1,40,0,100,~E,~v,R,-1;;,roar,1,20,0,100,~ty;;,sing,1,15,0,55,~X,6;;,sprsonic,1,20,0,55,~E,~ni;;,sonicbom,1,20,-5,90,~ea,20;;,disable,1,20,0,55,~fH;;,acid,5,30,40,100,~f,10,~E,~v,q,-1;;,ember,2,25,40,100,~f,10,~X,2;;,flamthwr,2,15,95,100,~f,10,~X,2;;,mist,10,30,0,0,~z,~eb,|stat lower|immunity,ol;;,hydropmp,4,5,120,80,~f;;,psybeam,12,20,65,100,~f,10,~E,~ni;;,aurorabm,10,20,65,100,~f,10,~E,~v,R,-1;;,peck,9,35,35,100,~f;;,drillpck,9,20,80,100,~f;;,lowkick,3,20,50,90,~f,30,~E,~ex;;,absorb,8,20,20,100,~n4;;,leechsed,8,10,0,90,~E,~eb,|is now|seeded,ar,1,~el;;,growth,1,40,0,0,~z,~v,er,1;;,razrleaf,8,25,55,95,~f;;,psnpowdr,5,35,0,75,~X,5;;,stunspor,8,30,0,75,~X,4;;,slppowdr,8,15,0,75,~X,6;;,petldanc,8,20,70,100,~tk;;,strngsht,11,40,0,95,~E,~v,M,-1;;,firespin,2,15,15,70,~nr;;,thndshck,6,30,40,100,~f,10,~X,4;;,rockthrw,13,15,50,65,~f;;,cnfusion,12,25,50,100,~f,10,~E,~ni;;,hypnosis,12,20,0,60,~X,6;;,meditate,12,40,0,0,~z,~v,R,1;;,agility,12,30,0,0,~z,~v,M,2;;,quickatk,1,30,40,100,~f;;,ngtshade,15,15,-5,100,~ea,50;;,screech,1,10,0,85,~E,~v,q,-2;;,recover,1,20,0,0,~t8;;,harden,1,30,0,0,~z,~v,q,1;;,minimize,1,20,0,0,~fW;;,smokscrn,1,20,0,100,~E,~v,A,-1;;,cnfusray,15,10,0,100,~E,~ni;;,withdraw,4,40,0,0,~z,~v,q,1;;,dfnscurl,1,40,0,0,~z,~v,q,1;;,barrier,12,30,0,0,~z,~v,q,2;;,lghtscrn,12,30,0,0,~z,~eb,|raises|spcdefense,am;;,haze,10,30,0,-5,~fN;;,fcsenrgy,1,30,0,0,~z,~eb,|raises|crit ratio,ac;;,mirrmove,9,20,-5,0,~fR;;,lick,15,30,20,100,~f,30,~X,4;;,smog,5,20,20,100,~f,30,~X,5;;,sludge,5,20,65,100,~f,30,~X,5;;,boneclub,7,20,65,85,~f,10,~E,~ex;;,watrfall,4,15,80,100,~f;;,clamp,4,10,35,75,~nr;;,spikcann,1,15,20,100,~e6;;,constrct,1,35,10,100,~f,10,~E,~v,M,-1;;,amnesia,12,20,0,0,~z,~v,er,2;;,kinesis,12,15,0,80,~E,~v,A,-1;;,hijmpkck,3,20,85,90,~f;;,glare,1,30,0,75,~X,4;;,poisngas,5,40,0,55,~X,5;;,barrage,1,20,15,85,~e6;;,leechlif,11,15,20,100,~n4;;,lovekiss,1,10,0,75,~X,6;;,tranform,1,10,0,0,~fK;;,bubble,4,30,20,100,~f,10,~E,~v,M,-1;;,dizypnch,1,10,70,100,~f;;,spore,8,15,0,100,~X,6;;,splash,1,40,0,0,~fV;;,acidarmr,5,40,0,0,~z,~v,q,2;;,crabhamr,4,10,90,85,~f;;,furyswps,1,15,10,80,~e6;;,bonerang,7,10,50,90,~nm,2,~L;;,hyprfang,1,15,80,90,~f,10,~E,~ex;;,sharpen,1,30,0,0,~z,~v,R,1;;,convrson,1,30,0,0,~fM;;,suprfang,1,10,-5,90,~ot;;,slash,1,20,70,100,~f"
tY=m"0,0x5e00,1,0x5e1e,2,0x5e3c"
fx=16
function _init()
local _ENV=eo
memset(0x8000,0,0x7fff)
no=tC"ey,a5,l,~a2,eD,4;tF;eu,eB,eD,4,eH,~j,nQ,~j,tI,~L,ed,~L,eh,~L,e1,~L,h,~L,P,~L,ef,;a5;next,fb,ei,.5,eh,~ev;fb;next,eB,ei,.5,eh,~ev;fg;eu,eB,next,eB,ei,.5,eH,159,eh,~ev;eB;eu,eB,next,tL,tI,~oH,eh,~ev,ed,~oJ;tL;eu,tL,next,aP,ei,.2,eh,~ev;aP;eu,nR,next,aE,eD,3,ei,.2,eH,155,eh,~ev;aE;eu,nR,next,aX,eD,2,ei,.2,eH,154,eh,~ev;aX;eu,nR,next,aL,eD,1,ei,.2,eH,153,eh,~ev;aL;eu,nR,next,tX,eD,0,eH,152,tI,~oz,eh,~ev,ed,~oq,e1,~oA,h,~oB,P,~oD;tX;eu,tX,next,eB,ei,.25,eh,~ev,ed,~L;"
ev(no)
flip()
C(function(e,n)
K(e)
as(n)
end,";,155,0x0;;,154,0x2;;,153,0x4")
K"154"
C(poke,";,0x5f5c,8;;,0x5f5d,2;;,0x5f56,0xe0")
f7(peek2"0x6",mget,mset)
o1()
oi()
local e=peek2"0xa"
for t,f in pairs(nS)do
local n={n=f}
for t=1,6do
add(n,peek(e))
e+=1
end
nS[t]=n
end
C(memcpy,";,0x0000,0xc000,0x2000")
end
function _update60()
local _ENV=eo
eQ,e7,tn,te=btnp"4",btnp"5",btnp"0"and btnp"1"and 0or btnp"0"and-1or btnp"1"and 1or 0,btnp"2"and btnp"3"and 0or btnp"2"and-1or btnp"3"and 1or 0
if@0x5eff==1then
eQ,e7=e7,eQ
end
no:t3()
end
function _draw()
local _ENV=eo
no:eh()
end