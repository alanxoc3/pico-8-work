eo=setmetatable({},{__index=_ENV})
_ENV=eo
function nG(e,n,t)
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
add(e,nG(n,f,o))
end)
else
for n=1,#t,2do
e[t[n]]=nG(t[n+1],f,o)
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
F(eo,"es,@,x,@,f7,@,L,@",true,false,"",function(...)return...end)
F(eo,"m,@,F,@,nG,@,t2,@,tp,@,Y,@,tw,@,t5,@,nI,@,H,@,eP,@,eL,@,b,@,C,@,nC,@,eg,@,eE,@,U,@,f9,@,t3,@,tg,@,eH,@,tb,@,n_,@,na,@,nQ,@,e_,@,n2,@,J,@,fj,@,fz,@,fq,@,fA,@,fB,@,fD,@,Q,@,np,@,t4,@,eb,@,fF,@,tx,@,fH,@,fJ,@,fK,@,fM,@,nw,@,ty,@,fN,@,fQ,@,t6,@,fR,@,tk,@,z,@,E,@,v,@,fS,@,fU,@,t8,@,X,@,e4,@,ex,@,nd,@,fV,@,fW,@,fY,@,fZ,@,oe,@,on,@,t7,@,ni,@,nr,@,nm,@,ot,@,of,@,oo,@,nc,@,ey,@,o_,@,n5,@,f,@,n3,@,oa,@,nR,@,t9,@,tj,@,ea,@,eJ,@,nu,@,tz,@,od,@,ng,@,tq,@,nS,@,nU,@,nb,@,oi,@,nV,@,nl,@,e6,@,om,@",m,F,nG,function(e)
return F(m"n4,0,tA,0,tB,~es,l,~L,ed,~L,eC,#;",e)
end,function(_ENV,e)
if e==ek then
return ei and n4/ei or 0
end
if _ENV[e]and _ENV[e].oc then
return 1
end
return 0
end,function(_ENV,e)
nx=e or next
end,function(_ENV,e)
n4,nx,tB,next,ei=0
_ENV[ek].oc=true
for e,n in pairs(tD)do _ENV[e]=n end
for n,t in pairs(_ENV[e])do _ENV[n]=t end
ek=e
_ENV:l()
tA=#eC
end,function(_ENV)
n4+=1/60
if tB then _ENV:tw(ek)end
if ei and n4>=ei then
_ENV:Y()
end
while nx do
_ENV:tw(nx)
end
_ENV:ed()
end,function(_ENV,e)
while nx~=e and#eC>0do
_ENV:H()
end
end,function(_ENV)
deli(eC)
_ENV:Y(eC[#eC]or"eK")
end,function(_ENV,e)
add(eC,e)
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
eM(e or"",23,4,1,0)
end,function(e)
C(rectfill,";,0,0,45,6,1")
C(eM,";,@,23,1,13,0;;,@,23,8,1,0;;,@,23,15,1,0",unpack(split(e,"|",false)))
end,m"",split"missingno,bulbasaur,ivysaur,venusaur,charmander,charmeleon,charizard,squirtle,wartortle,blastoise,caterpie,metapod,butterfree,weedle,kakuna,beedrill,pidgey,pidgeotto,pidgeot,rattata,raticate,spearow,fearow,ekans,arbok,pikachu,raichu,sandshrew,sandslash,nidoran f,nidorina,nidoqueen,nidoran m,nidorino,nidoking,clefairy,clefable,vulpix,ninetales,jigglypuff,wigglytuff,zubat,golbat,oddish,gloom,vileplume,paras,parasect,venonat,venomoth,diglett,dugtrio,meowth,persian,psyduck,golduck,mankey,primeape,growlithe,arcanine,poliwag,poliwhirl,poliwrath,abra,kadabra,alakazam,machop,machoke,machamp,bellsprout,weepinbell,victreebel,tentacool,tentacruel,geodude,graveler,golem,ponyta,rapidash,slowpoke,slowbro,magnemite,magneton,farfetchd,doduo,dodrio,seel,dewgong,grimer,muk,shellder,cloyster,gastly,haunter,gengar,onix,drowzee,hypno,krabby,kingler,voltorb,electrode,exeggcute,exeggutor,cubone,marowak,hitmonlee,hitmonchan,lickitung,koffing,weezing,rhyhorn,rhydon,chansey,tangela,kangaskhan,horsea,seadra,goldeen,seaking,staryu,starmie,mr mime,scyther,jynx,electabuzz,magmar,pinsir,tauros,magikarp,gyarados,lapras,ditto,eevee,vaporeon,jolteon,flareon,porygon,omanyte,omastar,kabuto,kabutops,aerodactyl,snorlax,articuno,zapdos,moltres,dratini,dragonair,dragonite,mewtwo,mew",m"0,none;,fainted,burned,frozen,paralyzed,poisoned,sleeping",m"0, ;,FNT,BRN,FZN,PAR,PSN,SLP",m"0;c,2,n,~f7;1;c,2,n,normal,15,0,13,.5;2;c,10,n,fire,8,2,10,2,11,2,2,.5,4,.5,13,.5,14,.5;3;c,7,n,fighting,10,2,1,2,13,2,15,0,11,.5,9,.5,5,.5,12,.5;4;c,9,n,water,2,2,7,2,13,2,14,.5,8,.5,4,.5;5;c,6,n,poison,11,2,8,2,15,.5,7,.5,5,.5,13,.5;6;c,11,n,electric,9,2,4,2,7,0,14,.5,6,.5,8,.5;7;c,7,n,ground,6,2,2,2,5,2,13,2,9,0,11,.5,8,.5;8;c,8,n,grass,7,2,13,2,4,2,11,.5,14,.5,2,.5,9,.5,8,.5,5,.5;9;c,2,n,flying,11,2,3,2,8,2,6,.5,13,.5;10;c,9,n,ice,14,2,9,2,8,2,2,.5,10,.5,4,.5;11;c,8,n,bug,8,2,12,2,3,.5,2,.5,9,.5,15,.5,5,.5;12;c,6,n,psychic,3,2,5,2,12,.5;13;c,2,n,rock,11,2,2,2,9,2,10,2,3,.5,7,.5;14;c,2,n,dragon,14,2;15;c,6,n,ghost,15,2,1,0,12,2;17;c,2,n,bird;",m"V,hp,er,spc,R,att,q,def,M,spd,ny,tot,A,acc,e2,eva",m";c,13,em,5,nT,1;;c,6,em,13,nT,13;;c,5,em,5,nT,1;;c,6,em,5,nT,5;;c,1,em,5,nT,13;;c,14,em,4;;c,9,em,4;;c,11,em,3;;c,12,em,5;;c,8,em,2;;c,10,em,4",m"",split"youngstr,bugcatch,junior,brock,lass,hiker,swimmer,misty,gentlman,sailor,rocker,ltsurge,channelr,gambler,beauty,erika,biker,birdkeep,juggler,koga,blckbelt,rocket,psychic,sabrina,scientst,pkmaniac,suprnerd,blaine,cooltrnr,fishrman,tamer,giovanni,lorelei,bruno,agatha,lance,blue,green,red,legendry",function(e,n)
if n.Z then
e:eP(n.Z)
else
e:H()
end
end,function(e,n)
return m("ou,@,tF,@,S,~tF,y,1,ed,~fA,ec,~fD,ns,~fz,N,~fj",e,n or 0)
end,function(e,n)
return F(n2(e),"p,0,y,@,ed,~fB,nW,~fq",n or 1)
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
eL()
end
else
local t=e.p+n
local f=e.p-e.p%e.y
if t==mid(f,t,f+e.y-1)then
e.p=t
if 0+n~=0then K"154"end
else
eL()
end
end
e.p=mid(0,e.p,#e-1)
if e.p\e.y<e.S then e.S=e.p\e.y end
if e.p\e.y>e.S+2then e.S=e.p\e.y-2end
e.S=mid(0,e.S,(#e-1)\e.y)
end,function(n)
local e=n.o
if eN then K"154"e.ns(n)end
if e8 then n:n6()end
e.S+=nY
if nZ~=0then n:tH(nZ)end
local n=e.S
e.S=mid(e.tF,e.S,#e-3)
if e.S~=n then
eL()
elseif nY~=0then
K"154"
end
end,function(t)
local e=t.o
e:nW"0"
e:nW(nY,true)
e:nW(nZ)
if e8 then
local n=e[e.p+1]
if n.eu then
eL()
elseif n.I then
K"155"
n.I(t,n)
end
end
if eN then K"154"e.ns(t)end
end,function(n)
local e=n.o
local f=e.y>1and 10or 40
local a=20-(e.y*f)/2
C(rectfill,";,0,0,39,39,1;;,0,@,39,@,13",5-e.S*10,4+(max(ceil(#e/e.y),3)-e.S)*10)
for n=-1,e.y*5-1do
local d=(e.S-1)*e.y+n+1
local t=e[d]
if t then
local o,i,r=t.nk or 1,a+n%e.y*10,n\e.y*10
if t.eu then o=3end
if d-1==e.p then o+=1end
if not t.te then
rectfill(i,r-5,i+f-1,r+4,n_[o].c)
nC(n%e.y*f+a+f/2,n\e.y*10-3,function()
e.ou(t,n_[o])
end)
end
end
end
end,function(e,n)
if e.ee then
local n=n_[eH[e.ee.eO].c]
C(rectfill,";,-20,-2,19,17,@;;,-20,14,19,17,@",n.c,n.em)
e.ee:n8(0,8,n,1,1)
else
tJ(e.n,0,0,n.nT)
end
end,function(e,n)
e.ee:n8(0,3,n,.375,.375)
end,function(n)
local e=nU(n.k)
del(e,n.a.W)
if#e>0then
return e[b(#e)+1]
end
end,function(_ENV,e)
local n=n1[e]
if e=="e2"or e=="A"then
return _ENV[e]*mid(1,1+n/3,3)/mid(1,1-n/3,3)
end
return ceil(mid(1,999,
(e=="R"and T==2and.5or e=="M"and T==4and.25or 1)*
_ENV[e]*mid(2,2+n,8)/mid(2,2-n,8)
))
end,function(_ENV)
if i.tn>0then return true end
local e=n7(i)
if#e==0then return true end
i.tn,i.eQ=b"6"+2,e[b(#e)+1].en
r(e1,"|"..i.w[i.eQ].n.."|disabled")
if i.g and i.g.en==i.eQ then
i.e0=0
end
end,function(_ENV,t,n)
local e=B(t,n)
e.e7,e.tK=5,5
w[n]=e
return e
end,function(_ENV)
local n=n7(i,true)
r(O,"|copies|"..tx(e,n[b(#n)+1].d,u.en).n)
end,function(_ENV)
if e.ol then
return true
else
r(O,"|copies|"..i.n,function()
e.ol=true
foreach(split"d,R,q,M,er,eO,ep",function(n)
e[n]=i[n]
end)
e.w={}
foreach(i.w,function(n)
tx(e,n.d,n.en)
end)
end)
end
end,function(_ENV)
F(e,"eO,@,ep,@",i.eO,i.ep)
r(O,"|copies|types")
end,function(_ENV)
foreach({e1,O},function(e)
F(e.a.n1,"er,0,R,0,q,0,M,0,A,0,e2,0,tM,~x")
r(e,"|resets|stats")
end)
end,function(_ENV,n,e)
e=min(e,n.a.V-n.a.D)
if e>0then
t9(_ENV,n,e,function()
n.a.W.D+=e
end)
else
return true
end
end,function(_ENV)
return nw(_ENV,O,e.V\2)
end,function(_ENV)
tt(O,B(b(164)+1,u.en))
end,function(_ENV)
if e.tf>0then
tt(O,B(e.tf,u.en))
else
return true
end
end,function(_ENV)
local e=t4(e1)
if e then
to(e1,e)
else
return true
end
end,function(_ENV)
local e=t4(O)
if e then
to(O,e)
else
return true
end
end,function(e,n)
return(sgn(e)>0and"|+"or"|-")..abs(e).." "..n.."|change"
end,function(_ENV,e,...)return e(_ENV,O,...)end,function(_ENV,e,...)return e(_ENV,e1,...)end,function(_ENV,e,n,t,o)
local f=e.a.n1[n]
if not e.a.oT or t>0then
e.a.n1[n]=mid(-6,6,f+t)
end
if f~=e.a.n1[n]then
r(e,tk(t,tb[n]),o or L)
else
return true
end
end,function(_ENV)
if X(_ENV,5)and i.T~=5then
return true
end
return E(_ENV,e4,"|badly|poisoned","n9",1,true)
end,function(_ENV)
r(O,"|does|nothing")
end,function(_ENV)
return t_(u,i)>0and u.eG~=i.eO and u.eG~=i.ep
end,function(_ENV,n)
if i.W.T==3and n==2then
r(O,"|thawed|out")
e.W.T=0
elseif i.W.T==0and(n==6or t8(_ENV))then
r(e1,"|is now|"..t3[n],function()
i.W.T=n
ta=b"8"
end)
else
return true
end
end,function(_ENV,e,t,n,f,o)
if(e.a[n]or 0)==0and(not o or t8(_ENV))then
e.a[n]=f or 1
r(e,t)
else
return true
end
end,function(_ENV,e)
e.a.tN=true
end,function(_ENV,e)
return e4(_ENV,e,"|becomes|confused","nj",b"4"+1)
end,function(_ENV)
return v(_ENV,O,"e2",1,function()
e.tM=.25
end)
end,function(_ENV)
local n=e.V\4
if n>=e.D or e.ew>0then
return true
end
eJ(_ENV,n)
r(O,"|created|substitute",function()
e.ew=n
end)
end,function(_ENV)
e9(e,-1,u)
f(_ENV)
if u.e7<=0then
e.e0,e.g=0
end
end,function(_ENV)
if not e.g then
e9(e,b"2"+1,B(u.d,u.en))
r(O,"|"..u.n.."|begins")
e.nz=0
end
if e.e0==0then
if e.nz==0then
return true
end
ea(_ENV,e.nz*2)
end
end,function(_ENV)
ea(_ENV,1+b"75")
end,function(_ENV)
ea(_ENV,max(i.D\2,1))
end,function(_ENV)
e9(e,b"2"+1,B(u.d,u.en))
f(_ENV)
if e.e0==0then
z(_ENV,nd,"nj")
end
end,function(_ENV)
if not e.g then
e9(e,b"4"+1,B(u.d,u.en))
e.n0=i
end
if e.n0==i then
f(_ENV)
else
return true
end
end,function(_ENV,n)
if e.g then
f(_ENV)
else
r(O,n,function()
e9(e,1,B(u.d,u.en))
end)
end
end,function(_ENV)
if e.g then
f(_ENV)
else
r(O,"|charges|energy")
e9(e,1,u)
u.e7+=1
end
end,function(_ENV)
if e.g then
r(O,"|recharges|energy")
else
f(_ENV)
local n=B(u.d,u.en)
n.A=0
e9(e,1,n)
end
end,function(_ENV)
r(O,"|is|sleeping",function()
e.W.T,e.ta=6,2
nw(_ENV,O,e.V)
end)
end,function(_ENV)
if e.nq>0then
ea(_ENV,e.nq*2)
else
return true
end
end,function(_ENV,e,n,t)
if e>0then
r(O,t and"|resumes|"..u.n,function()
_ENV.i=e1.a
f(_ENV,100,function()
nc(_ENV,e-1,n,true)
end)
end)
else
n()
end
end,function(_ENV,e)
nc(_ENV,2+b"4",L)
end,function(_ENV)
nc(_ENV,2,function()
if rnd"100"<20then
X(_ENV,5)
end
end)
end,function(_ENV)
ea(_ENV,false,function(e)
eJ(_ENV,max(1,e\4))
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
n3(_ENV)
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
local f=tk(t,"hp")
local o=e and n.a.ew+t<0
if not e or o then
r(n,f,L,e)
end
r(n,
o and"|substitute|broke"or f,
a,
e
)
end,function(_ENV,t,n,a,f)
local e=t.a
local o=not a and e.ew>0
t9(_ENV,t,-n,function()
e.nz+=n
if e.g and e.g.d==20then
v(_ENV,t,"R",1)
end
if f then f(n)end
if o then
e.ew=max(e.ew-n,0)
else
e.W.D=max(e.W.D-n,0)
end
end,o and"substitute")
end,function(_ENV,n,o)
local f,t=false,t_(u,i)
if not n then
n,f=tQ(e,i,u)
end
if t>0then
if u.eG%2==1then
i.nq+=n
end
if t>1then r(O,"|super|effective")
elseif t<1then r(O,"|not very|effective")end
if f then r(O,"|critical|hit")end
tj(_ENV,e1,n,false,o)
else
r(e1,"|resisted|attack")
end
end,function(_ENV,e)
tj(_ENV,O,e,true,L)
end,function(e)
return ceil(e+.5*93)+5
end,function()
return m("et,~es,R,0,q,0,er,0,M,0,V,0,D,0,ny,0,A,100,e2,100,tR,0,tS,0,tU,0,td,0,tV,0,d,-1,os,-1,n, ,eO,0,ep,0,eR,#,eS,#,nA,#,w,@",nB())
end,function()
local e=peek2"0xa"
U[-1]=tz()
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
local e=tz()
F(e,"d,@,os,@,n,@,eO,@,ep,@,tR,@,tS,@,tU,@,td,@,tV,@",t,
f,
f9[t+1],
unpack(n)
)
local o=e.eR
for f=8,#n do
local t=n[f]
if t==253then
o=e.eS
elseif t==252then
o=e.nA
else
add(o,t)
end
end
if f<t then
foreach(split"eR,eS,nA",function(n)
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
F(_ENV,"R,@,q,@,er,@,M,@,V,@,D,~V",nu(tS),
nu(tU),
nu(tV),
nu(td),
nu(tR)+55
)
ny=R+q+er+M+V
end
U[t]=e
end
end,function(e,n)
return setmetatable(m("w,@,T,0,et,~x",n),{__index=U[e]})
end,function(e)
foreach(nS(e.k),function(e)
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
local n=e:ej"j"
n[e:G"el"+1]=ng(-1,nB())
e6(e:G"j",n)
e:H()
end,function(e,o,n)
local t,f=U[n],nB()
for e=1,min(4,#t.eR)do
f[e]=B(t.eR[e],e)
end
e[o]=ng(n,f)
return e
end,function(e)
local a=tW[e]
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
local n=tW[e]
memset(n,0,30)
for t=1,6do
local f,e=n+(t-1)*5,o[t]
poke(f,max(0,e.d))
for n=1,4do
poke(f+n,e.w[n].d>0and e.w[n].d or 0)
end
end
end,function()
local e=peek2"0x8"
for n=-1,164do
local f,o,a,d,i=peek(e+0),peek(e+1)*5-5,peek(e+2)*5-5,peek(e+3)*5-5,deli(ti[n],1)
local t=deli(ti[n],1)
na[n]=m("o1,@,d,@,n,@,eG,@,e7,@,tK,~e7,tr,@,A,@,eU,@",function(e)
return t(e,unpack(ti[n]))
end,n,i,f,o,a,d,t)
e+=4
end
end)
F(eo,"B,@,nB,@,tm,@,tc,@,tu,@,tl,@,tT,@,eV,@,o0,@,ov,@,tY,@,eW,@,ts,@,nv,@,t1,@,tZ,@,fe,@,oh,@,fn,@,eY,@,oP,@,ft,@,oE,@,oX,@,ff,@,oL,@,oO,@,fo,@,oG,@,oI,@,oC,@,o2,@,op,@,f_,@,ow,@,o5,@,o3,@,og,@,ob,@,nh,@,aI,@,o4,@,ox,@,oy,@,o6,@,ok,@,o8,@,o7,@,o9,@,oj,@,oz,@,oq,@,oA,@,oB,@,oD,@,fa,@,G,@,e5,@,oF,@,fd,@,oH,@,fi,@,K,@,ev,@,fr,@,tJ,@,eM,@,eZ,@,oJ,@,fm,@,n8,@,oK,@,oM,@,oN,@,fc,@,oQ,@,oR,@,ej,@,nP,@,nD,@,nF,@,to,@,tt,@,e9,@,oS,@,nH,@,oU,@,nJ,@,ne,@,nE,@,nX,@,oV,@,oW,@,fu,@,fl,@,n7,@,fT,@,t_,@,tQ,@,fs,@",function(e,n)
return setmetatable(m("en,@",n or 0),{__index=na[e]})
end,function()
local e={}
for n=1,4do add(e,B(-1))end
return e
end,function(e)
fa(e)
tJ("team #"..e:G"j"+1,20,27,1)
end,function(_ENV)
local t,e,n=ez.a,eI.a,eq.a
local o,a=e==t,n==t
local t,f=11,11
C(rectfill,";,0,0,39,6,5;;,0,33,39,39,5")
C(rectfill,";,-1,33,@,41,1;;,-1,-2,@,6,1",max(ceil(e.D/e.V*40),0)-1,
max(ceil(n.D/n.V*40),0)-1)
C(rectfill,";,15,6,39,6,13;;,16,5,39,5,13;;,0,33,24,33,13;;,0,34,23,34,13")
C(eM,";,@,40,34,13,1;;,@,40,27,1,1;;,@,2,1,13,-1;;,@,2,7,1,-1",e.D,tg[e.T],n.D,tg[n.T])
local t,f=1,1
e:n8(10,25,n_[4],t,t,o)
n:n8(30,15,n_[4],-f,f,a)
end,function(e)oJ(U[e:G"et"])end,function(e)eg("spot #"..(e:G"el"+1))end,function(e)eg("move #"..(e:G"eX"+1))end,function(e)eg(e.nn)end,function(e)eg"match over"end,function(n)
local e=n:e5"nK"
eg(e and e.oY)
end,function()
rectfill(0,0,46,13,13)
pal(7,1)
local e=0
for f,n in ipairs(split"6,5,5,6,6,5,6")do
sspr(6*8+e,6*8,n,8,e+3,3.5+cos((t()+f)/4))
e+=n
end
pal()
end,function(e)eg(e.ez.oZ.n)end,function(e)
fm(e:nP())
end,function(n)
local e=n:e5(n.f1).u
if e.d>=0then
eE(eH[e.eG].n.."|"..e.e7.."/"..e.tK.."|"..(e.tr>=0and e.tr or"??").."P "..(e.A>=0and e.A or"??").."A")
else
eE"none|n/a|"
end
end,function(e)
fm(e:e5"et".ee)
end,function(e)
eE(e:e5"eK".e3)
end,function(_ENV)
if d>-1then
eE(n.."|"..D.."/"..V.."|"..t3[T])
else
eE"none|n/a|"
end
end,function(_ENV)fe(_ENV:e5"t0".ee)end,function(_ENV)fe(s.a)end,function(e)
local n,t=0,0
foreach(e:e5().k,function(e)
if e>-1then
n+=U[e].ny
t+=1
end
end)
eE(e:e5().n.."|len "..t.."/6|pow "..n\10)
end,function(e)
eE(e.nt.n.."|is the|winner")
end,function(e)
eE(e.ez.n..e.ez.f0)
end,function(_ENV)
local n=ne(_ENV,nt)
nt:ae(n)
o:N{}
o.ns=function(e)
e:nI"tv"
end
for e in all{nt,n}do
F(o,"S,0;;ee,@;;te,~es;;n,@,nk,5;;n,@;;n,@",e.a.W,e.n,(#nU(e.k,true)).." live",(#nS(e.k)).." dead")
end
end,function(_ENV)
local e=0
for n=0,151do e+=U[n]:eZ()and 1or 0end
o:N(
m(";n,browse,Z,et,I,~e_,e3,@;;n,edit,Z,j,I,~e_,e3,edit|stored|teams;;n,league,Z,fv,I,~e_,e3,@;;n,versus,Z,th,I,~e_,e3,versus|p1 vs p2|match;;n,horde,Z,fh,I,~e_,e3,@;;n,credits,Z,fP,I,~e_,e3,credits|amorg|games","browse|"..e.."/151|pokemon","league|"..(@0x5efd).."/40|trainers","horde|"..(@0x5efe).."/151|hi-score")
)
end,function(_ENV,n)
local e={}
for n=0,151do
add(e,n)
end
o:N(
e,
function(e)
return m("I,@,eu,@,ee,@",n,not U[e]:eZ(),U[e])
end
)
end,function(_ENV)
ff(_ENV,function(_ENV)
_ENV:eP"fE"
end)
end,function(_ENV)
ff(_ENV,function(_ENV)
e6(_ENV:G"j",nV(_ENV:ej"j",_ENV:G"el"+1,_ENV:G"et"))
_ENV:H()
end)
end,function(_ENV)
local e=_ENV:e5"et".ee
o:N{}
F(o,";ee,@;;te,~es;;n,lvl 50,nk,5",e)
foreach(split"V,er,R,q,M,ny",function(n)
add(o,{n=tb[n].." "..e[n]})
end)
C(function(t,n)
if#U[e.d][n]>0then
add(o,{n=t,nk=5})
foreach(U[e.d][n],function(e)
add(o,{n=na[e].n})
end)
end
end,";,learn,eR;;,teach,eS;;,event,nA")
end,function(_ENV)
o:N(
split"91,,#alanxoc3,code &,design,28,,#gr8cadet,pokemon,sprites,143,,#tigrwolf,battle,testing,127,,#tooling,px9 func,shrinko8,137,,#pkmndata,blbpedia,pokeapi,serebii,smogon,upokcntr,volvox,nintendo",
function(e)
if type(e)=="number"then
return{ee=ng(e,nB())}
end
local n=1
if sub(e,1,1)=="#"then
e,n=sub(e,2),5
end
return{n=e,nk=n,te=e==""}
end
)
end,function(_ENV)
o:N(nQ,function(e,n)
return{
n=e.n,
k=e,
eu=n-1>@0x5efd,
I=function(t,e)
fX(t,e.k,e.n,function(t,e)
poke(0x5efd,mid(@0x5efd,n,40))
tq(e)
end,L)
end
}
end)
end,function(_ENV)
o:N(m";n,moves,Z,eX,I,~e_;;n,switch,Z,tP,I,~e_;;n,delete,I,~oi")
end,function(_ENV)
local n=_ENV:nP()
local e=0
for t=1,4do
if n.w[t].d>0then e+=1end
end
o:N(m(";n,change,Z,nK,I,~e_;;n,switch,Z,fL,I,~e_;;n,delete,eu,@,I,~op",e==1))
end,function(_ENV)
local e,n=_ENV:nP()
e.w[_ENV:G"eX"+1]=B(-1)
e6(_ENV:G"j",n)
_ENV:H()
end,function(_ENV,f,a)
local n,d=_ENV:nP()
o:N(m",1,2,3,4",function(e)
local t=n.w[e]
return{
u=t,
n=t.n,
I=function(_ENV)a(_ENV,e,n,d)end,
eu=e==f
}
end)
end,function(_ENV)
f_(_ENV,0,function(_ENV,e,n)
_ENV:eP(n.w[e].d>0and"fO"or"nK")
end)
end,function(_ENV)
local n=_ENV:G"eX"+1
f_(_ENV,n,function(_ENV,t,e,f)
e.w[t],e.w[n]=e.w[n],e.w[t]
e6(_ENV:G"j",f)
_ENV:nI"eX"
end)
o.p=eX.o.p
end,function(_ENV)
local n=_ENV:nP()
local e=U[n.d]
local t={}
C(function(f,a)
for o=1,#f do
local e=f[o]
add(t,{n=na[e].n,eu=n:fu(e),d=e,e3=a..o})
end
end,";,@,learn #;;,@,teach #;;,@,event #",e.eR,e.eS,e.nA)
o:N(t,function(e)
return{
n=e.n,
eu=e.eu,
u=na[e.d],
oY=e.e3,
I=function()
local n=_ENV:ej"j"
n[_ENV:G"el"+1].w[_ENV:G"eX"+1]=B(e.d)
e6(_ENV:G"j",n)
_ENV:nI"eX"
end
}
end)
end,function(_ENV)
local n=fT(s.a)
if s.a.g then
nJ(s,s.a.g)
_ENV:H()_ENV:H()
elseif#n==0then
nJ(s,B(0))
_ENV:H()_ENV:H()
end
o:N(s.a.w,function(e)
return m("eu,@,n,@,u,@,I,@",
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
o:N(m";n,fight,I,~e_,Z,fG;;n,switch,I,~e_,Z,t0;;n,forfeit,I,~an")
end,function(_ENV)
o:N(m",1,2,3",function(e)
local n=nl(e-1)
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
k=t,
I=function()_ENV:nL()end,
eu=nO and f
}
end)
end,function(e,n)
return e[n]and e[n].d or-1
end,function(_ENV)
local e=_ENV:ej"j"
o:N(m",1,2,3,4,5,6",function(n)
return{
ee=e[n],
I=function(_ENV)
if e[_ENV:G"el"+1]:eZ()then
_ENV:eP"fI"
else
_ENV:eP"fC"
end
end
}
end)
end,function(_ENV)
local e=_ENV:ej"j"
o:N(m",1,2,3,4,5,6",function(n)
return{
eu=n==_ENV:G"el"+1,
I=function(_ENV)
local n,t=_ENV:G"el"+1,_ENV:G"tP"+1
e[n],e[t]=e[t],e[n]
e6(_ENV:G"j",e)
_ENV:nI"el"
end,
ee=e[n]
}
end)
o.p=el.o.p
end,function(_ENV)
local e=_ENV:ej"j"
o:N(m",1,2,3,4,5,6",function(e)
local n=s.k[e]:fl()or s.a.W==s.k[e]or s.k[e].T==1
return{
eu=n,
I=function()
_ENV:H()_ENV:H()
to(s,s.k[e])
end,
ee=s.k[e]
}
end)
end,function(_ENV)
local n,e=eI,eq
if n.eA==e.eA then e.eA+=sgn(rnd"2"-1)end
s=n.eA>e.eA and n or e
end,function(_ENV,e)
local n=true
for t=et.o.p+e,75.5+75.5*e,e do
if U[t]:eZ()then
et.o.p,n=t
K"154"
break
end
end
if n then eL()end
fo(_ENV)
end,function(e)K(e:G"et")end,function()K(b"152")end,function(_ENV)K(nt.a.d)end,function(_ENV)
local e={}
for t,n in pairs(split"133,7,35,1,25,4")do
nV(e,t,n)
poke(0x5e5a+n,1)
end
if@0x5efc==0then
poke(0x5efc,1)
e6(0,e)
end
ef=t2"ek,eK;tD;o,~x,l,~L,tH,~eL,n6,~L,ed,~oD,f1,~x,ec,~fa,h,~L,P,~L;eK;l,~oX,h,~tY,P,~tZ;et;l,~oL,h,~tu,P,~t1;fE;l,~fo,h,~tu,P,~t1,tH,~ok,n6,~o8;el;l,~o4,h,~tl,P,~ts,ec,~tm;tP;l,~ox,h,~tl,P,~ts,ec,~tm;fC;l,~oO,h,~tu,P,~t1;fI;l,~oC,h,~tl,P,~ts;fO;l,~o2,h,~tT,P,~nv,f1,eX;nK;l,~o3,h,~ov,P,~nv;eX;l,~ow,h,~tT,P,~nv;fL;l,~o5,h,~tT,P,~nv;j;nn,player,l,~nh,h,~eV,P,~eY,nO,~x,nL,~oR;fv;nn,player,l,~nh,h,~eV,P,~eY,nO,~es,nL,~oK;th;nn,player 1,l,~nh,h,~eV,P,~eY,nO,~es,nL,~oM;fh;nn,player,l,~nh,h,~eV,P,~eY,nO,~es,nL,~oQ;tE;nn,player 2,l,~nh,h,~eV,P,~eY,nO,~es,nL,~oN;tv;nn,trainer,l,~oI,h,~eV,P,~eY;tX;l,~oE,h,~o0,P,~oP,n6,~o9;f2;l,~ob,h,~eW,P,~fn;fG;l,~og,h,~eW,P,~nv;t0;l,~oy,h,~eW,P,~oh,ec,~tm;at;next,af,l,~fs,fp,eI;af;next,fw,l,~fs,fp,eq;fw;next,at,l,~o6,ed,~oV,ec,~tc,h,~eW,P,~ft,ez,~x;ao;l,~L,ed,~f5,ec,~tc,h,~eW,P,~fn;a_;l,~L,ed,~f5,ec,~tc,h,~eW,P,~ft;fP;l,~oG,h,~tY,P,~tZ,n6,~o7;"
C(function(e,n,...)
ef[e].o=n(...)
end,";,et,~J,~np,4;;,fE,~n2,~Q;;,fP,~n2,~Q;;,tX,~n2,~Q;;,el,~J,~np,3;;,tP,~J,~np,3;;,eK,~J,~Q;;,fI,~J,~Q;;,fO,~J,~Q;;,nK,~J,~Q;;,eX,~J,~Q;;,fL,~J,~Q;;,j,~J,~Q;;,th,~J,~Q;;,tv,~J,~Q;;,tE,~J,~Q")
F(ef,"f3,@,aa,@;eK;o;ns,~eL;fh;o,~f3;fv;o,~f3;fC;o,~aa;",ef.j.o,ef.et.o)
menuitem(1,"close picodex",function()
menuitem(1)
menuitem(2)
_ENV:Y"tL"
end)
menuitem(2,"swap 🅾️/❎",function()
poke(0x5eff,@0x5eff==0and 1or 0)
end)
end,function(e)
e.ef:t5()
end,function()nf.ef:ec()end,function()nf.ef:h()end,function()nf.ef:P()end,function(_ENV)o.ed(_ENV)end,function(_ENV)o.ec(_ENV)end,function(_ENV,e)
return _ENV[e].o.p
end,function(_ENV,e)
local n=e and _ENV[e].o or o
return n[n.p+1]
end,function(_ENV)
menuitem(1,"factory reset",function()
memset(0x5e00,0,0x100)
_ENV:Y"fg"
end)
end,function()
return btn()&0x3f~=0
end,function(_ENV)
if not fd()and nM then
nM=false
_ENV:Y()
menuitem(1)
elseif fd()then
nM=true
menuitem(1)
end
end,0,function(e)
eo.fi=max(0,0+e-152)
sfx(54+e\16,0,e%16*2,2)
end,function(_ENV)
cls"0"
nC(0,128+sin(_ENV:tp"fb"/4)*128,function()
C(eM,";,aMORG gAMES,64,-68,7,0;;,pRESENTS,64,-61,7,0;;,a pOKEMON bATTLE sIM,64,15,7,0")
C(spr,";,102,44,7,5,1")
local t,
n,
e=
ef and ef.eK.o.p,
ef and ef.tA-1,
eT=="nN"and 1
or eT=="eB"and-1
or(eT=="tO"and-1or 1)*cos(_ENV:tp(eT)/2)
nC(30-(e+1)*15+(ek=="fg"and b"3"-1or 0),27,function()
C(rectfill,";,14,18,@,87,5",63+max(0,e*54))
if eD==0then
C(rectfill,";,14,18,117,87,13")
C(function(e,n,t,f,o)
clip(-%0x5f28+e,-%0x5f2a+n,t,f)
nC(e,n,o)
clip()
end,";,14,21,40,40,@;;,71,18,46,13,@;;,71,67,46,21,@",ec,h,P)
end
C(map,";,24,0,2,1,8,3;;,8,0,2,9,8,11")
C(function(e,n,t,f,o,a)
return spr((eD<=e)and(fi==e and stat"46">=0and f or t)or n,o,a)
end,";,0,135,133,134,6,3;;,1,132,128,131,12,3;;,2,132,129,131,17,3;;,3,132,130,131,22,3")
C(function(e,n,t,f,o)
spr(btn(e)and n or t,f,o)
end,";,0,186,154,10,77;;,1,188,156,26,77;;,2,171,139,18,73;;,3,187,155,18,81;;,4,170,138,42,77;;,5,172,140,50,77")
if e<=0then
fr(0,2+64*(1-abs(e)),abs(e))
if e==-1and nM then spr(123,6,49)end
else
fr(16,62,e)
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
eM(o,e,t,f,0)
eM(a,e,t+1,f,0)
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
eg("pkmn #"..e.d)
end,function(e)
if e:eZ()then
eE(e.n.."|"..eH[e.eO].n.."|"..eH[e.ep].n)
else
eE"none|n/a|"
end
end,function(_ENV,n,t,i,f,o,r)
local e,a=_ENV:eZ()and d or-1,8*(tM or 1)
f*=a o*=a
local a=function(t,a)
local n,d=e/8\1,e%8
if n~=f4 then
eo.f4=n
memcpy(0x0000,0x8000+0x400*n,0x400)
end
sspr(d*16,0,16,16,t-f,a-o,f*2,o*2)
end
foreach(m";,25,53,152;;,54,143,153",function(n)
if e==n[1]and _ENV:fu(n[2])then
e=n[3]
end
end)
if ew and ew>0then e=154end
if not ad or T~=1and not tG and not(e0~=0and g.eU==nr)then
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
C(e,"c,@;;,~c,-2,~x,2,~x,1;;,~c,~x,-2,~x,2,1;;,~c,-2,0,2,0,1;;,~c,0,-2,0,2,1",i.c)
end
C(e,";,@,-1,~x,1,~x,1;;,1,~x,0,0,~x,1",i.em)
pal()a(n,t)
end
end,function(e)e:eP"tv"end,function(e)e:eP"tE"end,function(_ENV)
fx(_ENV,
m(",@,player 1,~x,~L",nl(_ENV:G"th")),
m(",@,player 2,~x,~L",nl(_ENV:G"tE"))
)
end,function(_ENV)
poke(0x5efe,mid(@0x5efe,#nS(k),152))
end,function(_ENV)
local e={}
for n=1,152do add(e,n%152)end
fX(_ENV,e,"horde",function(n,e)
tq(e)
fc(e)
end,fc)
end,function(e)
e:eP"el"
end,function(e,n)
return nl(e:G(n))
end,function(e)
local n=nl(e:G"j")
return n[e:G"el"+1],n
end,function(e,n)
local f,t="|enters|fight",{}
foreach(n.w,function(e)
add(t,e)
end)
e.a=setmetatable(m("ad,~es,tf,0,A,1,e2,1,e0,0,tG,~es,nq,0,nz,0,tn,0,nj,0,ta,@,ew,0,n9,0,W,@,w,@;n1;er,0,R,0,q,0,M,0,A,0,e2,0",b"8",n,t),{__index=n})
return nE(e,f,function()
e.a.tG=false
end)
end,function(e,n)
for t in all(split(n))do
if t==e then
return true
end
end
end,function(e,n)
nX(e,e,"|leaves|fight",function(t)
t.e.tG=true
nX(e,e,false,function()
add(e.eF,nD(e,n))
end)
end)
e.eA=3000
end,function(t,n)
local f=t.a.g and"|resumes|"or(n.eU==aC and"|begins|"or"|uses|")
nX(t,t,f..n.n,function(f)
f.u=n
local _ENV=f
if n.d>0then
n.e7-=1
end
if nF(n.d,"47,36 ")then
eJ(_ENV,e.D)
end
if(function()
if n.A<=0then return false end
if(n.eU==nm or n.eU==nr)and not e.g then return false end
if i.g and i.g.eU==nr then return true end
if e.g and e.g.eU==ni then return false end
return rnd(i:eb"e2")>n.A/100*e:eb"A"or b"256"==0and b"256"==0
end)()then
r(t,"|misses|"..n.n)
if nF(n.d,"145,73 ")then
eJ(_ENV,1)
end
else
if n.o1(_ENV)then
r(t,"|fails|attack")
end
end
if n.A~=0then
i.tf=n.d
end
end)
end,function(_ENV,e,n)
if not g and e0==0then
e0,g=e,n
end
end,function(n,t)
nX(n,n,false,function(f)
f.u=t
local _ENV=f
e:nH("e0",L)
if e.T==6then
e:nH("ta",function()
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
if i.n0==e then
r(n,"|is|trapped")
elseif e.eQ==t.en then
r(n,"|is|disabled")
elseif e.nj>0and b"2"==0then
r(n,"|confuse|damage")
eJ(_ENV,tQ(e,i,B(-1)))
elseif e.T==4and b"4"==0then
r(n,"|fully|paralyzed")
elseif e.tN then
r(n,"|is|flinching")
else
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
return nE(n,false,function(_ENV)
if e.T==6
or e.T==3
or e.n0 and e.n0~=i
then
e.e0=0
end
if e.e0==0then
e.n0,e.g=nil
end
local t=max(e.V\16,1)
local f=function(e)
r(n,e.."|damage")
eJ(_ENV,t)
end
if e.T==5then
if e.n9>0then
t*=e.n9
e.n9+=1
end
f"|poison"
end
if e.T==2then f"|burn"end
if e.ai then
f"|seed"
if i.D<i.V then
nw(_ENV,e1,t)
end
end
e:nH("nj",function()
r(n,"|confusion|ended")
end)
e:nH("tn",function()
r(n,"|"..e.w[e.eQ].n.."|enabled")
e.eQ=0
end)
end)
end,function(e,n)
e.eF={}
local t=1000
oS(e,n)
if n.d==120then t=2000end
if nF(n.d,"18,4,89,30 ")then
t=0000
end
e.eA=min(3000,t+e.a:eb"M")
end,function(e,n)
return n==e.eI and e.eq or e.eI
end,function(e,n,t,f)
return{oZ=e,n=f or e.a.n,a=e.a,f0=n,ar=t or L}
end,function(e,...)
add(e.eF,nE(...))
end,function(e)
if eN then eL()end
if e8 then K"154"end
if e8 or not e.ez then
while true do
for n in all{e.eI,e.eq}do
if not nb(n.k)then
e.nt=ne(e,n)
e:Y"tX"
return
end
end
local n=oW(e)
if n then
local f=n.a==e.eI.a and e.eI or e.eq
local t=m("u,@,O,@,e1,@,r,@",u,f,ne(e,f),function(...)
nX(f,...)
end)
t.e=t.O.a
t.i=t.e1.a
n.ar(t)
if n.f0 then
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
for t in all{n.eI,n.eq}do
if t.a.D<=0then
if t.a.T~=1then
return nE(t,"|has|fainted",function(_ENV)
e.W.T=1
end)
elseif t~=n.s then
return nD(t,nb(t.k))
end
end
end
for e in all{n.s,ne(n,n.s)}do
local t=ne(n,e)
while#e.eF>0do
local n=deli(e.eF,1)
if n.a.T~=1and(n.a==e.a or n.a==t.a)then
return n
end
end
if e.a.D<=0and e.a.T==1then
return nD(e,nb(e.k))
end
if not e.fy then
e.fy=true
return oU(e)
end
end
end,function(_ENV,e)
for n in all(w)do
if n.d==e then
return true
end
end
end,function(_ENV)
return#n7(_ENV,true)==0
end,function(t,f)
local n={}
foreach(t.w,function(e)
if e.d>0and(f or e.e7>0and t.eQ~=e.en)then
add(n,e)
n[e]=true
end
end)
return n
end,function(_ENV)
if e0~=0then
return{g}
else
return n7(_ENV)
end
end,function(e,n)
return(eH[e.eG][n.eO]or 1)*(eH[e.eG][n.ep]or 1)
end,function(n,t,e)
local a,f=n:eb"er",t:eb"er"
if e.eG%2==1then
a,f=n:eb"R",t:eb"q"
if t.am then
f*=2
end
elseif t.ac then
f*=2
end
local o=1024
if nF(e.d,"107,164,57,157 ")then o*=.3end
if au then o*=.3end
local d=rnd"1"<min(.99,(n.td+76)/o)and e.d>0and 2or 1
local o=mid(
3,997,
(100*d/5+2)/50
*e.tr
*mid(10,.2,a/f)
)+2
local a,f=o,t_(e,t)
*((e.eG==n.eO or e.eG==n.ep)and 1.5or 1)
*(rnd".15"+.85)
if f>0then
return max(1,a*f\1),d>1
end
return 0,false
end,function(_ENV)
s=_ENV[fp]
do local _ENV=s.a
nq,tN=0,false
end
s.fy=false
if s.al then
local e=fT(s.a)
nJ(s,e[b(#e)+1]or B(0))
_ENV:Y()
elseif#s.eF>0then
_ENV:Y()
else
f2.o,
fG.o,
t0.o,
ez,
eC[#eC]=s.f6,
s.aT,
s.as,
nE(s,"|begins|turn"),
ek
_ENV:Y"a_"
end
end)
F(eo,"f5,@,an,@,fx,@,fX,@,a1,@,a0,@,av,@,fk,@,ah,@",function(_ENV)
if e8 then
_ENV:eP"f2"
K"155"
end
if eN then eL()end
end,function(_ENV)
_ENV:H()
nt=_ENV:ne(s)
_ENV:Y"tX"
end,function(_ENV,e,t)
e.tI,t.tI="eI","eq"
for n in all{e,t}do
_ENV[n.tI]=m("eF,#,eA,1,f6,@,aT,@,as,@,k,@,n,@,al,@,ae,@",J(Q),
J(Q),
J(np,3),
unpack(n))
local e=_ENV[n.tI]
e.f6.ns=function()
_ENV:H()
_ENV:Y"ao"
end
add(e.eF,nD(e,nb(e.k)))
end
_ENV:eP"fw"
end,function(_ENV,e,t,f,o)
local n={}
for t=1,#e do
nV(n,t,e[t])
end
fx(_ENV,
{_ENV:ej"j","player",false,f},
{n,t,true,o}
)
end,function(e)
fk(peek2(e),
function(...)return a0(0x8000+e*0x1000,...)end,
function(...)return av(0x8000+e*0x1000,...)end)
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
function f8(f)
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
local t=f8(e)
n+=t
until t<(1<<e)-1
return n
end
local i,d,f,e,o,c,u,n,t=no"1",no"0",no"1",{},{},0,0,0
for n=1,no"1"do add(e,f8(f))end
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
if e.aP then K(e.aP)end
e:tC()
end)
eo.ti=m"-1;,none,~f;0;,struggle,~n5;;,megapnch,~f;;,razrwind,~nm;;,sworddnc,~z,~v,R,2;;,whrlwind,~t6;;,megakick,~f;;,toxic,~fS;;,horndril,~nR;;,bodyslam,~f,30,~X,4;;,takedown,~n5;;,doubedge,~n5;;,bublbeam,~f,10,~E,~v,M,-1;;,watergun,~f;;,icebeam,~f,10,~X,3;;,blizzard,~f,10,~X,3;;,hyprbeam,~ot;;,payday,~f;;,submsion,~n5;;,counter,~oo;;,seistoss,~ea,50;;,rage,~fY;;,megdrain,~n3;;,solrbeam,~nm;;,drgnrage,~ea,40;;,thndrblt,~f,10,~X,4;;,thunder,~f,10,~X,4;;,earthqke,~f;;,fissure,~nR;;,dig,~nr,|begins|digging;;,psychic,~f,30,~E,~v,er,-1;;,teleport,~fR;;,mimic,~fH;;,doubteam,~z,~v,e2,1;;,reflect,~z,~e4,|raises|defense,am;;,bide,~fZ;;,metrnome,~fN;;,selfdstr,~f;;,eggbomb,~f;;,fireblst,~f,30,~X,2;;,swift,~f;;,skulbash,~nm;;,softboil,~ty;;,dreameat,~oa;;,skyattck,~nm;;,rest,~of;;,thndrwav,~X,4;;,psywave,~oe;;,explsion,~f;;,rockslid,~f;;,triattck,~f;;,substute,~fW;;,cut,~f;;,fly,~nr,|begins|flying;;,surf,~f;;,strength,~f;;,flash,~E,~v,A,-1;;,pound,~f;;,karatchp,~f;;,doubslap,~ey;;,comtpnch,~ey;;,firepnch,~f,10,~X,2;;,icepnch,~f,10,~X,3;;,thndpnch,~f,10,~X,4;;,scratch,~f;;,vicegrip,~f;;,guilotin,~nR;;,gust,~f;;,wingatck,~f;;,bind,~ni;;,slam,~f;;,vinewhip,~f;;,stomp,~f,30,~E,~ex;;,doubkick,~nc,2,~L;;,jumpkick,~f;;,rllngkck,~f,30,~E,~ex;;,sandatck,~E,~v,A,-1;;,headbutt,~f,30,~E,~ex;;,hornatck,~f;;,furyatck,~ey;;,tackle,~f;;,wrap,~ni;;,thrash,~t7;;,tailwhip,~E,~v,q,-1;;,psnsting,~f,20,~X,5;;,twineedl,~o_;;,pinmisil,~ey;;,leer,~E,~v,q,-1;;,bite,~f,10,~E,~ex;;,growl,~E,~v,R,-1;;,roar,~t6;;,sing,~X,6;;,sprsonic,~E,~nd;;,sonicbom,~ea,20;;,disable,~fF;;,acid,~f,10,~E,~v,q,-1;;,ember,~f,10,~X,2;;,flamthwr,~f,10,~X,2;;,mist,~z,~e4,|stat lower|immunity,oT;;,hydropmp,~f;;,psybeam,~f,10,~E,~nd;;,aurorabm,~f,10,~E,~v,R,-1;;,peck,~f;;,drillpck,~f;;,lowkick,~f,30,~E,~ex;;,absorb,~n3;;,leechsed,~E,~e4,|is now|seeded,ai,1,~es;;,growth,~z,~v,er,1;;,razrleaf,~f;;,psnpowdr,~X,5;;,stunspor,~X,4;;,slppowdr,~X,6;;,petldanc,~t7;;,strngsht,~E,~v,M,-1;;,firespin,~ni;;,thndshck,~f,10,~X,4;;,rockthrw,~f;;,cnfusion,~f,10,~E,~nd;;,hypnosis,~X,6;;,meditate,~z,~v,R,1;;,agility,~z,~v,M,2;;,quickatk,~f;;,ngtshade,~ea,50;;,screech,~E,~v,q,-2;;,recover,~ty;;,harden,~z,~v,q,1;;,minimize,~fV;;,smokscrn,~E,~v,A,-1;;,cnfusray,~E,~nd;;,withdraw,~z,~v,q,1;;,dfnscurl,~z,~v,q,1;;,barrier,~z,~v,q,2;;,lghtscrn,~z,~e4,|raises|spcdefense,ac;;,haze,~fM;;,fcsenrgy,~z,~e4,|raises|crit ratio,au;;,mirrmove,~fQ;;,lick,~f,30,~X,4;;,smog,~f,30,~X,5;;,sludge,~f,30,~X,5;;,boneclub,~f,10,~E,~ex;;,watrfall,~f;;,clamp,~ni;;,spikcann,~ey;;,constrct,~f,10,~E,~v,M,-1;;,amnesia,~z,~v,er,2;;,kinesis,~E,~v,A,-1;;,hijmpkck,~f;;,glare,~X,4;;,poisngas,~X,5;;,barrage,~ey;;,leechlif,~n3;;,lovekiss,~X,6;;,tranform,~fJ;;,bubble,~f,10,~E,~v,M,-1;;,dizypnch,~f;;,spore,~X,6;;,splash,~fU;;,acidarmr,~z,~v,q,2;;,crabhamr,~f;;,furyswps,~ey;;,bonerang,~nc,2,~L;;,hyprfang,~f,10,~E,~ex;;,sharpen,~z,~v,R,1;;,convrson,~fK;;,suprfang,~on;;,slash,~f"
tW=m"0,0x5e00,1,0x5e1e,2,0x5e3c"
f4=16
function _init()
local _ENV=eo
memset(0x8000,0,0x7fff)
nf=t2"ek,aE,l,~ah,eD,4;tD;eT,eB,eD,4,sfx,~x,nM,~x,tC,~L,ed,~L,eh,~L,ec,~L,h,~L,P,~L,ef,;aE;next,fb,ei,.5,eh,~ev;fb;next,eB,ei,.5,eh,~ev;fg;eT,eB,next,eB,ei,.5,sfx,159,eh,~ev;eB;eT,eB,next,tO,tC,~oF,eh,~ev,ed,~oH;tO;eT,tO,next,aX,ei,.2,eh,~ev;aX;eT,nN,next,aL,eD,3,ei,.2,sfx,155,eh,~ev;aL;eT,nN,next,aO,eD,2,ei,.2,sfx,154,eh,~ev;aO;eT,nN,next,aG,eD,1,ei,.2,sfx,153,eh,~ev;aG;eT,nN,next,tL,eD,0,sfx,152,tC,~oj,eh,~ev,ed,~oz,ec,~oq,h,~oA,P,~oB;tL;eT,tL,next,eB,ei,.25,eh,~ev,ed,~L;"
ev(nf)
flip()
C(function(e,n)
K(e)
a1(n)
end,";,155,0x0;;,154,0x2;;,153,0x4")
K"154"
C(poke,";,0x5f5c,8;;,0x5f5d,2;;,0x5f56,0xe0")
fk(peek2"0x6",mget,mset)
om()
od()
local e=peek2"0xc"
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
function _update60()
local _ENV=eo
eN,e8,nZ,nY=btnp"4",btnp"5",btnp"0"and btnp"1"and 0or btnp"0"and-1or btnp"1"and 1or 0,btnp"2"and btnp"3"and 0or btnp"2"and-1or btnp"3"and 1or 0
if@0x5eff==1then
eN,e8=e8,eN
end
nf:t5()
end
function _draw()
local _ENV=eo
nf:eh()
end