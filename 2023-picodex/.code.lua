eo=setmetatable({},{__index=_ENV})
_ENV=eo
function nI(e,n,t)
if ord(e)==126then return n[sub(e,2)]
elseif e=="@"then return deli(t,1)
elseif e=="#"then return{}end
return e~=""and e or nil
end
function H(f,n,...)
local o,t,e={...},split(n,";"),f
foreach(t,function(n)
local t=split(n)
if#t>1then
if t[1]==""then
foreach(t,function(n)
add(e,nI(n,f,o))
end)
else
for n=1,#t,2do
e[t[n]]=nI(t[n+1],f,o)
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
return H(setmetatable({},{__index=eo}),...)
end
H(eo,"el,@,z,@,fk,@,L,@",true,false,"",function(...)return...end)
H(eo,"m,@,H,@,nI,@,tw,@,tp,@,Y,@,t3,@,t4,@,nC,@,J,@,eh,@,eO,@,b,@,C,@,nw,@,e4,@,e2,@,U,@,fj,@,tg,@,tb,@,eJ,@,tx,@,n_,@,na,@,nU,@,e_,@,np,@,K,@,fz,@,fq,@,fA,@,fB,@,fD,@,fF,@,Q,@,n3,@,fH,@,eg,@,fJ,@,t6,@,fK,@,fM,@,fN,@,fQ,@,n4,@,t8,@,fR,@,fS,@,ty,@,x,@,l,@,h,@,nV,@,fU,@,fV,@,t7,@,X,@,eb,@,ex,@,nd,@,fW,@,fY,@,fZ,@,oe,@,on,@,ot,@,t9,@,ni,@,nr,@,n0,@,of,@,oo,@,o_,@,n1,@,e6,@,oa,@,ng,@,f,@,nb,@,od,@,nW,@,tk,@,tj,@,ea,@,eK,@,nm,@,tz,@,oi,@,nx,@,tq,@,nY,@,nZ,@,n6,@,o0,@,te,@,nc,@,e8,@,o1,@,q,@",m,H,nI,function(e)
return H(m"n8,0,tA,0,tB,~el,T,~L,ed,~L,eG,#;",e)
end,function(_ENV,e)
if e==ey then
return ei and n8/ei or 0
end
if _ENV[e]and _ENV[e].om then
return 1
end
return 0
end,function(_ENV,e)
ny=e or next
end,function(_ENV,e)
n8,ny,tB,next,ei=0
_ENV[ey].om=true
for e,n in pairs(tD)do _ENV[e]=n end
for n,t in pairs(_ENV[e])do _ENV[n]=t end
ey=e
_ENV:T()
tA=#eG
end,function(_ENV)
n8+=1/60
if tB then _ENV:t3(ey)end
if ei and n8>=ei then
_ENV:Y()
end
while ny do
_ENV:t3(ny)
end
_ENV:ed()
end,function(_ENV,e)
while ny~=e and#eG>0do
_ENV:J()
end
end,function(_ENV)
deli(eG)
_ENV:Y(eG[#eG]or"eM")
end,function(_ENV,e)
add(eG,e)
_ENV:Y(e)
end,function()
A"153"
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
end,m"",split"missingno,bulbasaur,ivysaur,venusaur,charmander,charmeleon,charizard,squirtle,wartortle,blastoise,caterpie,metapod,butterfree,weedle,kakuna,beedrill,pidgey,pidgeotto,pidgeot,rattata,raticate,spearow,fearow,ekans,arbok,pikachu,raichu,sandshrew,sandslash,nidoran f,nidorina,nidoqueen,nidoran m,nidorino,nidoking,clefairy,clefable,vulpix,ninetales,jigglypuff,wigglytuff,zubat,golbat,oddish,gloom,vileplume,paras,parasect,venonat,venomoth,diglett,dugtrio,meowth,persian,psyduck,golduck,mankey,primeape,growlithe,arcanine,poliwag,poliwhirl,poliwrath,abra,kadabra,alakazam,machop,machoke,machamp,bellsprout,weepinbell,victreebel,tentacool,tentacruel,geodude,graveler,golem,ponyta,rapidash,slowpoke,slowbro,magnemite,magneton,farfetchd,doduo,dodrio,seel,dewgong,grimer,muk,shellder,cloyster,gastly,haunter,gengar,onix,drowzee,hypno,krabby,kingler,voltorb,electrode,exeggcute,exeggutor,cubone,marowak,hitmonlee,hitmonchan,lickitung,koffing,weezing,rhyhorn,rhydon,chansey,tangela,kangaskhan,horsea,seadra,goldeen,seaking,staryu,starmie,mr mime,scyther,jynx,electabuzz,magmar,pinsir,tauros,magikarp,gyarados,lapras,ditto,eevee,vaporeon,jolteon,flareon,porygon,omanyte,omastar,kabuto,kabutops,aerodactyl,snorlax,articuno,zapdos,moltres,dratini,dragonair,dragonite,mewtwo,mew",m"0,none;,fainted,burned,frozen,paralyzed,poisoned,sleeping",m"0, ;,FNT,BRN,FZN,PAR,PSN,SLP",m"0;c,2,n,~fk;1;c,2,n,normal,15,0,13,.5;2;c,10,n,fire,8,2,10,2,11,2,2,.5,4,.5,13,.5,14,.5;3;c,7,n,fighting,10,2,1,2,13,2,15,0,11,.5,9,.5,5,.5,12,.5;4;c,9,n,water,2,2,7,2,13,2,14,.5,8,.5,4,.5;5;c,6,n,poison,11,2,8,2,15,.5,7,.5,5,.5,13,.5;6;c,11,n,electric,9,2,4,2,7,0,14,.5,6,.5,8,.5;7;c,7,n,ground,6,2,2,2,5,2,13,2,9,0,11,.5,8,.5;8;c,8,n,grass,7,2,13,2,4,2,11,.5,14,.5,2,.5,9,.5,8,.5,5,.5;9;c,2,n,flying,11,2,3,2,8,2,6,.5,13,.5;10;c,9,n,ice,14,2,9,2,8,2,2,.5,10,.5,4,.5;11;c,8,n,bug,8,2,12,2,3,.5,2,.5,9,.5,15,.5,5,.5;12;c,6,n,psychic,3,2,5,2,12,.5;13;c,2,n,rock,11,2,2,2,9,2,10,2,3,.5,7,.5;14;c,2,n,dragon,14,2;15;c,6,n,ghost,15,2,1,0,12,2;17;c,2,n,bird;",m"V,hp,er,spc,R,att,B,def,M,spd,n7,tot,D,acc,eI,eva",m";c,13,e0,5,nu,1;;c,6,e0,13,nu,13;;c,5,e0,5,nu,1;;c,6,e0,5,nu,5;;c,1,e0,5,nu,13;;c,14,e0,4;;c,9,e0,4;;c,11,e0,3;;c,12,e0,5;;c,8,e0,2;;c,10,e0,4",m"",split"youngstr,bugcatch,junior,brock,lass,hiker,swimmer,misty,gentlman,sailor,rocker,ltsurge,channelr,gambler,beauty,erika,biker,birdkeep,juggler,koga,blckbelt,rocket,psychic,sabrina,scientst,pkmaniac,suprnerd,blaine,cooltrnr,fishrman,tamer,giovanni,lorelei,bruno,agatha,lance,blue,green,red,legendry",function(e,n)
if n.Z then
e:eh(n.Z)
else
e:J()
end
end,function(e,n)
return m("oc,@,tF,@,S,~tF,y,1,ed,~fB,e1,~fF,nl,~fq,N,~fz",e,n or 0)
end,function(e,n)
return H(np(e),"w,0,y,@,ed,~fD,tn,~fA",n or 1)
end,function(e,n,f)
while deli(e)do end
for t=1,#n do
add(e,(f or L)(n[t],t))
end
end,function(e)
e:J()
end,function(e,n,t)
if t then
local t=e.w+n*e.y
if t==mid(0,t,#e-1)then
e.w=t
if 0+n~=0then A"154"end
else
eO()
end
else
local t=e.w+n
local f=e.w-e.w%e.y
if t==mid(f,t,f+e.y-1)then
e.w=t
if 0+n~=0then A"154"end
else
eO()
end
end
e.w=mid(0,e.w,#e-1)
if e.w\e.y<e.S then e.S=e.w\e.y end
if e.w\e.y>e.S+2then e.S=e.w\e.y-2end
e.S=mid(0,e.S,(#e-1)\e.y)
end,function(n)
local e=n.a
if nT then A"154"e.nl(n)end
if e7 then n:n9()end
e.S+=nk
if nj~=0then n:tH(nj)end
local n=e.S
e.S=mid(e.tF,e.S,#e-3)
if e.S~=n then
eO()
elseif nk~=0then
A"154"
end
end,function(t)
local e=t.a
e:tn"0"
e:tn(nk,true)
e:tn(nj)
if e7 then
local n=e[e.w+1]
if n.em then
eO()
elseif n.G then
A"155"
n.G(t,n)
end
end
if nT then A"154"e.nl(t)end
end,function(n)
local e=n.a
local f=e.y>1and 10or 40
local a=20-(e.y*f)/2
C(rectfill,";,0,0,39,39,1;;,0,@,39,@,13",5-e.S*10,4+(max(ceil(#e/e.y),3)-e.S)*10)
for n=-1,e.y*5-1do
local d=(e.S-1)*e.y+n+1
local t=e[d]
if t then
local o,i,r=t.nz or 1,a+n%e.y*10,n\e.y*10
if t.em then o=3end
if d-1==e.w then o+=1end
if not t.tt then
rectfill(i,r-5,i+f-1,r+4,n_[o].c)
nw(n%e.y*f+a+f/2,n\e.y*10-3,function()
e.oc(t,n_[o])
end)
end
end
end
end,function(e,n)
if e.ee then
local n=n_[eJ[e.ee.eP].c]
C(rectfill,";,-20,-2,19,17,@;;,-20,14,19,17,@",n.c,n.e0)
e.ee:nq(0,8,n,1,1)
else
tJ(e.n,0,0,n.nu)
end
end,function(e,n)
e.ee:nq(0,3,n,.375,.375)
end,function(n)
local e=nZ(n.k)
del(e,n.o.W)
if#e>0then
return e[b(#e)+1]
end
end,function(_ENV,e)
local n=ns[e]
if e=="eI"or e=="D"then
return _ENV[e]*mid(1,1+n/3,3)/mid(1,1-n/3,3)
end
return ceil(mid(1,999,
(e=="R"and s==2and.5or e=="M"and s==4and.25or 1)*
_ENV[e]*mid(2,2+n,8)/mid(2,2-n,8)
))
end,function(_ENV)
if i.tf>0then return true end
local e=nA(i)
if#e==0then return true end
i.tf,i.eQ=b"6"+2,e[b(#e)+1].en
r(eE,"|"..i.p[i.eQ].n.."|disabled")
if i.g and i.g.en==i.eQ then
i.eT=0
end
end,function(_ENV,t,n)
local e=q(t,n)
e.e9,e.tK=5,5
p[n]=e
return e
end,function(_ENV)
local n=nA(i,true)
local t=n[b(#n)+1].d
if t==31then
return true
end
r(I,"|copies|"..t6(e,t,u.en).n)
end,function(_ENV)
if e.ou then
return true
else
r(I,"|copies|"..i.n,function()
e.ou=true
foreach(split"d,R,B,M,er,eP,eC",function(n)
e[n]=i[n]
end)
e.p={}
foreach(i.p,function(n)
t6(e,n.d,n.en)
end)
end)
end
end,function(_ENV)
H(e,"eP,@,eC,@",i.eP,i.eC)
r(I,"|copies|types")
end,function(_ENV)
foreach({eE,I},function(e)
r(e,"|resets|stats",function()
H(e.o.ns,"er,0,R,0,B,0,M,0,D,0,eI,0")
e.o.tM=false
end)
end)
end,function(_ENV,n,e)
e=min(e,n.o.V-n.o.F)
if e>0then
tk(_ENV,n,e,function()
n.o.W.F+=e
end)
else
return true
end
end,function(_ENV)
return n4(_ENV,I,e.V\2)
end,function(_ENV)
to(I,q(b(164)+1,u.en))
end,function(_ENV)
if e.t_>0then
to(I,q(e.t_,u.en))
else
return true
end
end,function(e,n)
return(sgn(e)>0and"|+"or"|-")..abs(e).." "..n.."|change"
end,function(_ENV,e,...)return e(_ENV,I,...)end,function(_ENV,e,...)return e(_ENV,eE,...)end,function(_ENV,e,n,t,o)
local f=e.o.ns[n]
if not e.o.ol or t>0then
e.o.ns[n]=mid(-6,6,f+t)
end
if f~=e.o.ns[n]then
r(e,ty(t,tx[n]),o or L)
else
return true
end
end,function(_ENV,e)
local n=fH(e)
if n then
tN(e,n)
else
return true
end
end,function(_ENV)
if X(_ENV,5)and i.s~=5then
return true
end
return l(_ENV,eb,"|badly|poisoned","nv",1,true)
end,function(_ENV)
r(I,"|does|nothing")
end,function(_ENV)
return ta(u,i)>0and u.eX~=i.eP and u.eX~=i.eC
end,function(_ENV,n)
if i.W.s==3and n==2then
r(I,"|thawed|out")
e.W.s=0
elseif i.W.s==0and(n==6or t7(_ENV))then
r(eE,"|is now|"..tg[n],function()
i.W.s=n
i.td=b"7"+1
end)
else
return true
end
end,function(_ENV,e,t,n,f,o)
if(e.o[n]or 0)==0and(not o or t7(_ENV))then
e.o[n]=f or 1
r(e,t)
else
return true
end
end,function(_ENV,e)
e.o.tQ=true
end,function(_ENV,e)
return eb(_ENV,e,"|becomes|confused","nB",b"4"+1)
end,function(_ENV)
return h(_ENV,I,"eI",1,function()
e.tM=.25
end)
end,function(_ENV)
local n=e.V\4
if n>=e.F or e.ew>0then
return true
end
eK(_ENV,n)
r(I,"|created|substitute",function()
e.ew=n
end)
end,function(_ENV)
ek(e,-1,u)
f(_ENV)
if u.e9<=0then
e.eT,e.g=0
end
end,function(_ENV)
if not e.g then
ek(e,b"2"+1,q(u.d,u.en))
r(I,"|"..u.n.."|begins")
e.nD=0
end
if e.eT==0then
if e.nD==0then
return true
end
ea(_ENV,e.nD*2)
end
end,function(_ENV)
ea(_ENV,1+b"75")
end,function(_ENV)
ea(_ENV,max(i.F\2,1))
end,function(_ENV)
ek(e,b"2"+1,q(u.d,u.en))
f(_ENV)
if e.eT==0then
x(_ENV,nd,"nB")
end
end,function(_ENV)
if not e.g then
ek(e,b"4"+1,q(u.d,u.en))
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
ek(e,1,q(u.d,u.en))
end)
end
end,function(_ENV)
if e.g then
f(_ENV)
else
r(I,"|charges|energy")
ek(e,1,u)
u.e9+=1
end
end,function(_ENV)
if e.g then
r(I,"|recharges|energy")
else
f(_ENV)
local n=q(u.d,u.en)
n.D=0
ek(e,1,n)
end
end,function(_ENV)
r(I,"|is|sleeping",function()
e.W.s,e.td,e.nv=6,2,0
n4(_ENV,I,e.V)
end)
end,function(_ENV)
if e.nF>0then
ea(_ENV,e.nF*2)
else
return true
end
end,function(_ENV,e,n,t)
if e>0then
r(I,t and"|resumes|"..u.n,function()
_ENV.i=eE.o
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
n4(_ENV,I,max(e\2,1))
end)
end,function(_ENV)
if i.s==6then
nb(_ENV)
else
return true
end
end,function(_ENV)
if e.M>=i.M then
ea(_ENV,i.F)
else
return true
end
end,function(_ENV,n,t,a,e)
local f=ty(t,"hp")
local o=e and n.o.ew+t<0
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
local o=not a and e.ew>0
tk(_ENV,t,-n,function()
e.nD+=n
if e.g and e.g.d==20then
h(_ENV,t,"R",1)
end
if f then f(n)end
if o then
e.ew=max(e.ew-n,0)
else
e.W.F=max(e.W.F-n,0)
end
end,o and"substitute")
end,function(_ENV,n,o)
local f,t=false,ta(u,i)
if not n then
n,f=tR(e,i,u)
end
if t>0then
if u.eX%2==1then
i.nF+=n
end
if t>1then r(I,"|super|effective")
elseif t<1then r(I,"|not very|effective")end
if f then r(I,"|critical|hit")end
tj(_ENV,eE,n,false,o)
else
r(eE,"|resisted|attack")
end
end,function(_ENV,e)
tj(_ENV,I,e,true,L)
end,function(e)
return ceil(e+.5*93)+5
end,function()
return m("et,~el,R,0,B,0,er,0,M,0,V,0,F,0,n7,0,D,100,eI,100,tS,0,tU,0,tV,0,ti,0,tW,0,d,-1,oT,-1,n, ,eP,0,eC,0,eR,#,eS,#,tr,#,p,@",nH())
end,function()
local e=peek2"0x8"
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
H(e,"d,@,oT,@,n,@,eP,@,eC,@,tS,@,tU,@,tV,@,ti,@,tW,@",t,
f,
fj[t+1],
unpack(n)
)
local o=e.eR
for f=8,#n do
local t=n[f]
if t==253then
o=e.eS
elseif t==252then
o=e.tr
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
H(_ENV,"R,@,B,@,er,@,M,@,V,@,F,~V",nm(tU),
nm(tV),
nm(tW),
nm(ti),
nm(tS)+55
)
n7=R+B+er+M+V
end
U[t]=e
end
end,function(e,n)
return setmetatable(m("p,@,s,0,et,~z",n),{__index=U[e]})
end,function(e)
foreach(nY(e.k),function(e)
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
return nZ(e)[1]
end,function(e)
local n=e:ej"j"
n[e:O"ec"+1]=nx(-1,nH())
e8(e:O"j",n)
e:J()
end,function(e,o,n)
local t,f=U[n],nH()
for e=1,min(4,#t.eR)do
f[e]=q(t.eR[e],e)
end
e[o]=nx(n,f)
return e
end,function(e)
local a=tY[e]
local e=m""
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
e[t]=nx(o and@f or-1,n)
end
return e
end,function(e,o)
local n=tY[e]
memset(n,0,30)
for t=1,6do
local f,e=n+(t-1)*5,o[t]
poke(f,max(0,e.d))
for n=1,4do
poke(f+n,e.p[n].d>0and e.p[n].d or 0)
end
end
end,function()
for e=-1,164do
local n,t={},deli(nJ[e],6)
for t=6,#nJ[e]do
add(n,deli(nJ[e],6))
end
na[e]=m("os,@,d,@,eU,@,n,@,eX,@,e9,@,tK,~e9,t0,@,D,@",function(e)
return t(e,unpack(n))
end,e,t,unpack(nJ[e]))
end
end,function(e,n)
return setmetatable(m("en,@",n or 0),{__index=na[e]})
end)
H(eo,"nH,@,t1,@,tm,@,tc,@,tu,@,tl,@,eV,@,ov,@,oh,@,tZ,@,eW,@,tT,@,n2,@,ts,@,fe,@,fn,@,o2,@,ft,@,eY,@,o5,@,ff,@,oP,@,oE,@,fo,@,oX,@,oL,@,f_,@,oO,@,oG,@,oI,@,oC,@,ow,@,fa,@,op,@,o3,@,o4,@,og,@,ob,@,n5,@,aO,@,ox,@,o6,@,o8,@,oy,@,o7,@,o9,@,ok,@,oj,@,oz,@,oq,@,oA,@,oB,@,oD,@,oF,@,fd,@,O,@,ep,@,oH,@,fi,@,oJ,@,fr,@,A,@,es,@,f0,@,tJ,@,eN,@,eZ,@,oK,@,f1,@,nq,@,oM,@,oN,@,oQ,@,fm,@,oR,@,oS,@,ej,@,nP,@,nK,@,nM,@,tN,@,to,@,ek,@,oU,@,nN,@,oV,@,nQ,@,ne,@,nE,@,nX,@,fc,@,fu,@,oW,@,oY,@,oZ,@,fl,@,nA,@,fT,@,ta,@,tR,@",function()
local e={}
for n=1,4do add(e,q(-1))end
return e
end,function(e)
fd(e)
tJ("team #"..e:O"j"+1,20,27,1)
end,function(_ENV)
local t,e,n=ez.o,eL.o,eq.o
local o,a=e==t,n==t
local t,f=11,11
C(rectfill,";,0,0,39,6,5;;,0,33,39,39,5")
C(rectfill,";,-1,33,@,41,1;;,-1,-2,@,6,1",max(ceil(e.F/e.V*40),0)-1,
max(ceil(n.F/n.V*40),0)-1)
C(rectfill,";,15,6,39,6,13;;,16,5,39,5,13;;,0,33,24,33,13;;,0,34,23,34,13")
C(eN,";,@,40,34,13,1;;,@,40,27,1,1;;,@,2,1,13,-1;;,@,2,7,1,-1",e.F,tb[e.s],n.F,tb[n.s])
local t,f=1,1
e:nq(10,25,n_[4],t,t,o)
n:nq(30,15,n_[4],-f,f,a)
end,function(e)oK(U[e:O"et"])end,function(e)e4("spot #"..(e:O"ec"+1))end,function(e)e4("move #"..(e:O"e5"+1))end,function(e)e4(e.nn)end,function(e)e4"match over"end,function(n)
local e=n:ep"nR"
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
f1(e:nP())
end,function(n)
local e=n:ep(n.fs).u
if e.d>=0then
e2(eJ[e.eX].n.."|"..e.e9.."/"..e.tK.."|"..(e.t0>=0and e.t0 or"??").."P "..(e.D>=0and e.D or"??").."A")
else
e2"none|n/a|"
end
end,function(e)
f1(e:ep"et".ee)
end,function(e)
e2(e:ep"eM".e3)
end,function(_ENV)
if d>-1then
e2(n.."|"..F.."/"..V.."|"..tg[s])
else
e2"none|n/a|"
end
end,function(_ENV)fn(_ENV:ep"tv".ee)end,function(_ENV)fn(v.o)end,function(e)
local n,t=0,0
foreach(e:ep().k,function(e)
if e>-1then
n+=U[e].n7
t+=1
end
end)
e2(e:ep().n.."|len "..t.."/6|tot "..n)
end,function(e)
e2(e.nt.n.."|is the|winner")
end,function(e)
e2(e.ez.n..e.ez.fv)
end,function(_ENV)
local n=ne(_ENV,nt)
nt:at(n)
a:N{}
a.nl=function(e)
e:nC"th"
end
for e in all{nt,n}do
H(a,"S,0;;ee,@;;tt,~el;;n,@,nz,5;;n,@;;n,@",e.o.W,e.n,(#nZ(e.k,true)).." live",(#nY(e.k)).." dead")
end
end,function(_ENV)
local e=0
for n=0,151do e+=U[n]:eZ()and 1or 0end
a:N(
m(";n,browse,Z,et,G,~e_,e3,@;;n,edit,Z,j,G,~e_,e3,edit|stored|teams;;n,league,Z,fh,G,~e_,e3,@;;n,versus,Z,t2,G,~e_,e3,versus|p1 vs p2|match;;n,horde,Z,f2,G,~e_,e3,@;;n,credits,Z,f5,G,~e_,e3,credits|amorg|games","browse|"..e.."/151|pokemon","league|"..(@0x5efd).."/40|trainers","horde|"..(@0x5efe).."/151|hi-score")
)
end,function(_ENV,n)
local e={}
for n=0,151do
add(e,n)
end
a:N(
e,
function(e)
return m("G,@,em,@,ee,@",n,not U[e]:eZ(),U[e])
end
)
end,function(_ENV)
fo(_ENV,function(_ENV)
_ENV:eh"fP"
end)
end,function(_ENV)
fo(_ENV,function(_ENV)
e8(_ENV:O"j",te(_ENV:ej"j",_ENV:O"ec"+1,_ENV:O"et"))
_ENV:J()
end)
end,function(_ENV)
local e=_ENV:ep"et".ee
a:N{}
H(a,";ee,@;;tt,~el;;n,lvl 50,nz,5",e)
foreach(split"V,er,R,B,M,n7",function(n)
add(a,{n=tx[n].." "..e[n]})
end)
C(function(t,n)
if#U[e.d][n]>0then
add(a,{n=t,nz=5})
foreach(U[e.d][n],function(e)
add(a,{n=na[e].n})
end)
end
end,";,learn,eR;;,teach,eS;;,event,tr")
end,function(_ENV)
a:N(
split"91,,#alanxoc3,code &,design,28,,#gr8cadet,pokemon,sprites,143,,#tigrwolf,battle,testing,129,,#wadlo,just,magikarp,127,,#tooling,px9 func,shrinko8,137,,#pkmndata,blbpedia,pokeapi,serebii,smogon,upokcntr,volvox,nintendo",
function(e)
if type(e)=="number"then
return{ee=nx(e,nH())}
end
local n=1
if sub(e,1,1)=="#"then
e,n=sub(e,2),5
end
return{n=e,nz=n,tt=e==""}
end
)
end,function(_ENV)
a:N(nU,function(e,n)
return{
n=e.n,
k=e,
em=n-1>@0x5efd,
G=function(t,e)
fE(t,e.k,e.n,function(t,e)
poke(0x5efd,mid(@0x5efd,n,40))
tq(e)
end,L)
end
}
end)
end,function(_ENV)
a:N(m";n,moves,Z,e5,G,~e_;;n,switch,Z,t5,G,~e_;;n,delete,G,~o0")
end,function(_ENV)
local n=_ENV:nP()
local e=0
for t=1,4do
if n.p[t].d>0then e+=1end
end
a:N(m(";n,change,Z,nR,G,~e_;;n,switch,Z,fX,G,~e_;;n,delete,em,@,G,~ow",e==1))
end,function(_ENV)
local e,n=_ENV:nP()
e.p[_ENV:O"e5"+1]=q(-1)
e8(_ENV:O"j",n)
_ENV:J()
end,function(_ENV,f,o)
local n,d=_ENV:nP()
a:N(m",1,2,3,4",function(e)
local t=n.p[e]
return{
u=t,
n=t.n,
G=function(_ENV)o(_ENV,e,n,d)end,
em=e==f
}
end)
end,function(_ENV)
fa(_ENV,0,function(_ENV,e,n)
_ENV:eh(n.p[e].d>0and"fL"or"nR")
end)
end,function(_ENV)
local n=_ENV:O"e5"+1
fa(_ENV,n,function(_ENV,t,e,f)
e.p[t],e.p[n]=e.p[n],e.p[t]
e8(_ENV:O"j",f)
_ENV:nC"e5"
end)
a.w=e5.a.w
end,function(_ENV)
local n=_ENV:nP()
local e=U[n.d]
local t={}
C(function(f,a)
for o=1,#f do
local e=f[o]
add(t,{n=na[e].n,em=n:oZ(e),d=e,e3=a..o})
end
end,";,@,learn #;;,@,teach #;;,@,event #",e.eR,e.eS,e.tr)
a:N(t,function(e)
return{
n=e.n,
em=e.em,
u=na[e.d],
ae=e.e3,
G=function()
local n=_ENV:ej"j"
n[_ENV:O"ec"+1].p[_ENV:O"e5"+1]=q(e.d)
e8(_ENV:O"j",n)
_ENV:nC"e5"
end
}
end)
end,function(_ENV)
local n=fT(v.o)
if v.o.g then
nQ(v,v.o.g)
_ENV:J()_ENV:J()
elseif#n==0then
nQ(v,q(0))
_ENV:J()_ENV:J()
end
a:N(v.o.p,function(e)
return m("em,@,n,@,u,@,G,@",
not n[e],
e.n,
e,
function()
_ENV:J()_ENV:J()
nQ(v,e)
end
)
end)
end,function(_ENV)
a:N(m";n,fight,G,~e_,Z,fO;;n,switch,G,~e_,Z,tv;;n,forfeit,G,~af")
end,function(_ENV)
a:N(m",1,2,3",function(e)
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
k=t,
G=function()_ENV:nL()end,
em=nO and f
}
end)
end,function(e,n)
return e[n]and e[n].d or-1
end,function(_ENV)
local e=_ENV:ej"j"
a:N(m",1,2,3,4,5,6",function(n)
return{
ee=e[n],
G=function(_ENV)
if e[_ENV:O"ec"+1]:eZ()then
_ENV:eh"fG"
else
_ENV:eh"fI"
end
end
}
end)
end,function(_ENV)
local e=_ENV:ej"j"
a:N(m",1,2,3,4,5,6",function(n)
return{
em=n==_ENV:O"ec"+1,
G=function(_ENV)
local n,t=_ENV:O"ec"+1,_ENV:O"t5"+1
e[n],e[t]=e[t],e[n]
e8(_ENV:O"j",e)
_ENV:nC"ec"
end,
ee=e[n]
}
end)
a.w=ec.a.w
end,function(_ENV)
local e=_ENV:ej"j"
a:N(m",1,2,3,4,5,6",function(e)
local n=v.k[e]:fl()or v.o.W==v.k[e]or v.k[e].s==1
return{
em=n,
G=function()
_ENV:J()_ENV:J()
tN(v,v.k[e])
end,
ee=v.k[e]
}
end)
end,function(_ENV)
local n,e=eL,eq
if n.eA==e.eA then e.eA+=sgn(rnd"2"-1)end
v=n.eA>e.eA and n or e
end,function(_ENV,e)
local n=true
for t=et.a.w+e,75.5+75.5*e,e do
if U[t]:eZ()then
et.a.w,n=t
A"154"
break
end
end
if n then eO()end
f_(_ENV)
end,function(e)A(e:O"et")end,function()A(b"152")end,function(_ENV)A(nt.o.d)end,function(_ENV)
local e={}
for t,n in pairs(split"133,7,35,1,25,4")do
te(e,t,n)
poke(0x5e5a+n,1)
end
if@0x5efc==0then
poke(0x5efc,1)
e8(0,e)
end
ef=tw"ey,eM;tD;a,~z,T,~L,tH,~eO,n9,~L,ed,~oF,fs,~z,e1,~fd,P,~L,E,~L;eM;T,~oE,P,~tZ,E,~fe;et;T,~oX,P,~tc,E,~ts;fP;T,~f_,P,~tc,E,~ts,tH,~o7,n9,~o9;ec;T,~ox,P,~tu,E,~tT,e1,~t1;t5;T,~o6,P,~tu,E,~tT,e1,~t1;fI;T,~oL,P,~tc,E,~ts;fG;T,~oI,P,~tu,E,~tT;fL;T,~oC,P,~tl,E,~n2,fs,e5;nR;T,~o4,P,~oh,E,~n2;e5;T,~op,P,~tl,E,~n2;fX;T,~o3,P,~tl,E,~n2;j;nn,player,T,~n5,P,~eV,E,~eY,nO,~z,nL,~oS;fh;nn,player,T,~n5,P,~eV,E,~eY,nO,~el,nL,~oM;t2;nn,player 1,T,~n5,P,~eV,E,~eY,nO,~el,nL,~oN;f2;nn,player,T,~n5,P,~eV,E,~eY,nO,~el,nL,~oR;tP;nn,player 2,T,~n5,P,~eV,E,~eY,nO,~el,nL,~oQ;th;nn,trainer,T,~oG,P,~eV,E,~eY;tE;T,~oP,P,~ov,E,~o5,n9,~oj;fC;T,~ob,P,~eW,E,~ft;fO;T,~og,P,~eW,E,~n2;tv;T,~o8,P,~eW,E,~o2,e1,~t1;ao;next,a_,T,~fw,fp,eL;a_;next,f3,T,~fw,fp,eq;f3;next,ao,T,~oy,ed,~oW,e1,~tm,P,~eW,E,~ff,ez,~z;aa;T,~L,ed,~fc,e1,~tm,P,~eW,E,~ft;ad;T,~L,ed,~fc,e1,~tm,P,~eW,E,~ff;f5;T,~oO,P,~tZ,E,~fe,n9,~ok;"
C(function(e,n,...)
ef[e].a=n(...)
end,";,et,~K,~n3,4;;,fP,~np,~Q;;,f5,~np,~Q;;,tE,~np,~Q;;,ec,~K,~n3,3;;,t5,~K,~n3,3;;,eM,~K,~Q;;,fG,~K,~Q;;,fL,~K,~Q;;,nR,~K,~Q;;,e5,~K,~Q;;,fX,~K,~Q;;,j,~K,~Q;;,t2,~K,~Q;;,th,~K,~Q;;,tP,~K,~Q")
H(ef,"f4,@,ai,@;eM;a;nl,~eO;f2;a,~f4;fh;a,~f4;fI;a,~ai;",ef.j.a,ef.et.a)
menuitem(1,"close picodex",function()
menuitem(1)
menuitem(2)
sfx(53,2)
_ENV:Y"tX"
end)
menuitem(2,"swap 🅾️/❎",function()
poke(0x5eff,@0x5eff==0and 1or 0)
end)
end,function(e)
e.ef:t4()
end,function()nf.ef:e1()end,function()nf.ef:P()end,function()nf.ef:E()end,function(_ENV)a.ed(_ENV)end,function(_ENV)a.e1(_ENV)end,function(_ENV,e)
return _ENV[e].a.w
end,function(_ENV,e)
local n=e and _ENV[e].a or a
return n[n.w+1]
end,function(_ENV)
menuitem(1,"factory reset",function()
memset(0x5e00,0,0x100)
_ENV:Y"fg"
end)
end,function()
return btn()&0x3f~=0
end,function(_ENV)
if not fi()and nG then
nG=false
_ENV:Y()
A"157"
sfx(-1,2)
elseif fi()then
if not nG then
A"156"
end
nG=true
menuitem(1)
end
end,0,function(e)
e+=0
if e>152then
eo.fr=e-152
end
sfx(54+e\16,e<=152and 1or 0,e%16*2,2)
end,function(_ENV)
cls"0"
nw(0,128+sin(_ENV:tp"fb"/4)*128,function()
C(eN,";,aMORG gAMES,64,-68,7,0;;,pRESENTS,64,-61,7,0;;,a pOKEMON bATTLE sIM,64,15,7,0")
C(spr,";,102,44,7,5,1")
local t,
n,
e=
ef and ef.eM.a.w,
ef and ef.tA-1,
eu=="nS"and 1
or eu=="eB"and-1
or(eu=="tL"and-1or 1)*cos(_ENV:tp(eu)/2)
nw(30-(e+1)*15+(ey=="fg"and b"3"-1or 0),27,function()
C(rectfill,";,14,18,@,87,5",63+max(0,e*54))
if eD==0then
C(rectfill,";,14,18,117,87,13")
C(function(e,n,t,f,o)
clip(-%0x5f28+e,-%0x5f2a+n,t,f)
nw(e,n,o)
clip()
end,";,14,21,40,40,@;;,71,18,46,13,@;;,71,67,46,21,@",e1,P,E)
end
C(map,";,24,0,2,1,8,3;;,8,0,2,9,8,11")
C(function(e,n,t,f,o,a)
return spr((eD<=e)and((e==0and stat"47">=0or fr==e and stat"46">=0)and f or t)or n,o,a)
end,";,0,135,133,134,6,3;;,1,132,128,131,12,3;;,2,132,129,131,17,3;;,3,132,130,131,22,3")
C(function(e,n,t,f,o)
spr(btn(e)and n or t,f,o)
end,";,0,186,154,10,77;;,1,188,156,26,77;;,2,171,139,18,73;;,3,187,155,18,81;;,4,170,138,42,77;;,5,172,140,50,77")
if e<=0then
f0(0,2+64*(1-abs(e)),abs(e))
if e==-1and nG then spr(123,6,49)end
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
if e:eZ()then
e2(e.n.."|"..eJ[e.eP].n.."|"..eJ[e.eC].n)
else
e2"none|n/a|"
end
end,function(_ENV,e,n,i,f,o,r)
local t,a=_ENV:eZ()and d or-1,8*(tM or 1)
f*=a o*=a
local a=function(n,a)
local e,d=t/8\1,t%8
if e~=fx then
eo.fx=e
memcpy(0x0000,0x8000+0x400*e,0x400)
end
sspr(d*16,0,16,16,n-f,a-o,f*2,o*2)
end
if ew and ew>0then t=152end
if not ar or s~=1and not tO and not(eT~=0and g.eU==nr)then
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
C(t,";,@,-1,~z,1,~z,1;;,1,~z,0,0,~z,1",i.e0)
pal()a(e,n)
end
end,function(e)e:eh"th"end,function(e)e:eh"tP"end,function(_ENV)
f6(_ENV,
m(",@,player 1,~z,~L",nc(_ENV:O"t2")),
m(",@,player 2,~z,~L",nc(_ENV:O"tP"))
)
end,function(_ENV)
poke(0x5efe,mid(@0x5efe,#nY(k),152))
end,function(_ENV)
local e={}
for n=1,152do add(e,n%152)end
fE(_ENV,e,"horde",function(n,e)
tq(e)
fm(e)
end,fm)
end,function(e)
e:eh"ec"
end,function(e,n)
return nc(e:O(n))
end,function(e)
local n=nc(e:O"j")
return n[e:O"ec"+1],n
end,function(e,n)
local t={}
foreach(n.p,function(e)
add(t,e)
end)
e.o=setmetatable(m("ar,~el,t_,0,D,1,eI,1,eT,0,tO,~el,nF,0,nD,0,tf,0,nB,0,td,@,ew,0,nv,0,W,@,p,@;ns;er,0,R,0,B,0,M,0,D,0,eI,0",b"7"+1,n,t),{__index=n})
return nE(e,"|enters|fight",function()
A(e.o.d)
e.o.tO=false
end)
end,function(e,n)
for t in all(split(n))do
if t==e then
return true
end
end
end,function(e,n)
nX(e,e,"|leaves|fight",function(t)
t.e.tO=true
nX(e,e,false,function()
add(e.eF,nK(e,n))
end)
end)
e.eA=3000
end,function(t,n)
local f=t.o.g and"|resumes|"or(n.eU==aG and"|begins|"or"|uses|")
nX(t,t,f..n.n,function(f)
f.u=n
local _ENV=f
if n.d>0then
n.e9-=1
end
if nM(n.d,"47,36 ")then
eK(_ENV,e.F)
end
if(function()
if n.D<=0then return false end
if(n.eU==n0 or n.eU==nr)and not e.g then return false end
if i.g and i.g.eU==nr then return true end
if e.g and e.g.eU==ni then return false end
return rnd(i:eg"eI")>n.D/100*e:eg"D"or b"256"==0and b"256"==0
end)()then
r(t,"|misses|"..n.n)
if nM(n.d,"145,73 ")then
eK(_ENV,1)
end
else
if n.os(_ENV)then
r(t,"|fails|attack")
end
end
if n.D~=0then
i.t_=n.d
end
end)
end,function(_ENV,e,n)
if not g and eT==0then
eT,g=e,n
end
end,function(n,t)
nX(n,n,false,function(f)
f.u=t
local _ENV=f
e:nN("eT",L)
if e.s==6then
e:nN("td",function()
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
elseif e.eQ==t.en then r(n,"|is|disabled")
elseif e.s==4and b"4"==0then r(n,"|fully|paralyzed")
elseif e.tQ then r(n,"|is|flinching")
else
if e.nB>0then
r(n,"|is|confused")
if b"2"==0then
r(n,"|hurt|itself")
eK(_ENV,tR(e,i,q(-1)))
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
return nE(n,false,function(_ENV)
if e.s==6
or e.s==3
or e.nh and e.nh~=i
then
e.eT=0
end
if e.eT==0then
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
if e.a0 then
f"|seed"
if i.F<i.V then
n4(_ENV,eE,t)
end
end
e:nN("nB",function()
r(n,"|confusion|ended")
end)
e:nN("tf",function()
r(n,"|"..e.p[e.eQ].n.."|enabled")
e.eQ=0
end)
end)
end,function(e,n)
e.eF={}
local t=1000
oU(e,n)
if n.d==120then t=2000end
if nM(n.d,"18,4,89,30 ")then
t=0000
end
e.eA=min(3000,t+e.o:eg"M")
end,function(e,n)
return n==e.eL and e.eq or e.eL
end,function(e,n,t,f)
return m("an,@,n,@,o,@,fv,@,a1,@",e,f or e.o.n,e.o,n or false,t or L)
end,function(e,...)
add(e.eF,nE(...))
end,function(_ENV)
if e7 then
_ENV:eh"fC"
A"155"
end
fu()
end,function()
if nT or nj|nk~=0then eO()end
end,function(e)
fu()
if e7 then A"154"end
if e7 or not e.ez then
while true do
for n in all{e.eL,e.eq}do
if not n6(n.k)then
e.nt=ne(e,n)
e:Y"tE"
return
end
end
local n=oY(e)
if n then
local f=n.o==e.eL.o and e.eL or e.eq
local t=m("u,@,I,@,eE,@,r,@",u,f,ne(e,f),function(...)
nX(f,...)
end)
t.e,t.i=t.I.o,t.eE.o
n.a1(t)
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
for t in all{n.eL,n.eq}do
if t.o.F<=0then
if t.o.s~=1then
return nE(t,"|has|fainted",function(_ENV)
e.W.s=1
end)
elseif t~=n.v then
return nK(t,n6(t.k))
end
end
end
for e in all{n.v,ne(n,n.v)}do
local t=ne(n,e)
while#e.eF>0do
local n=deli(e.eF,1)
if n.o.s~=1and(n.o==e.o or n.o==t.o)then
return n
end
end
if e.o.F<=0and e.o.s==1then
return nK(e,n6(e.k))
end
if not e.f8 then
e.f8=true
return oV(e)
end
end
end,function(_ENV,e)
for n in all(p)do
if n.d==e then
return true
end
end
end,function(_ENV)
return#nA(_ENV,true)==0
end,function(t,f)
local n={}
foreach(t.p,function(e)
if e.d>0and(f or e.e9>0and t.eQ~=e.en)then
add(n,e)
n[e]=true
end
end)
return n
end,function(_ENV)
if eT~=0then
return{g}
else
return nA(_ENV)
end
end,function(e,n)
return(eJ[e.eX][n.eP]or 1)*(eJ[e.eX][n.eC]or 1)
end,function(n,t,e)
local a,f=n:eg"er",t:eg"er"
if e.eX%2==1then
a,f=n:eg"R",t:eg"B"
if t.am then
f*=2
end
elseif t.ac then
f*=2
end
local o=1024
if nM(e.d,"107,164,57,157 ")then o*=.3end
if au then o*=.3end
local d=rnd"1"<min(.99,(n.ti+76)/o)and e.d>0and 2or 1
local o=mid(
3,997,
(100*d/5+2)/50
*e.t0
*mid(10,.2,a/f)
)+2
local a,f=o,ta(e,t)
*((e.eX==n.eP or e.eX==n.eC)and 1.5or 1)
*(rnd".15"+.85)
if f>0then
return max(1,a*f\1),d>1
end
return 0,false
end)
H(eo,"fw,@,af,@,f6,@,fE,@,tG,@,al,@,aT,@,fy,@,as,@",function(_ENV)
v=_ENV[fp]
do local _ENV=v.o
nF,tQ=0,false
end
v.f8=false
if v.av then
local e=fT(v.o)
nQ(v,e[b(#e)+1]or q(0))
_ENV:Y()
elseif#v.eF>0then
_ENV:Y()
else
fC.a,
fO.a,
tv.a,
ez,
eG[#eG]=v.f7,
v.ah,
v.a2,
nE(v,"|begins|turn"),
ey
_ENV:Y"ad"
end
end,function(_ENV)
_ENV:J()
nt=_ENV:ne(v)
_ENV:Y"tE"
end,function(_ENV,e,t)
e.tI,t.tI="eL","eq"
for n in all{e,t}do
_ENV[n.tI]=m("eF,#,eA,1,f7,@,ah,@,a2,@,k,@,n,@,av,@,at,@",K(Q),
K(Q),
K(n3,3),
unpack(n))
local e=_ENV[n.tI]
e.f7.nl=function()
_ENV:J()
_ENV:Y"aa"
end
add(e.eF,nK(e,n6(e.k)))
end
_ENV:eh"f3"
end,function(_ENV,e,t,f,o)
local n={}
for t=1,#e do
te(n,t,e[t])
end
f6(_ENV,
{_ENV:ej"j","player",false,f},
{n,t,true,o}
)
end,function(e)
fy(peek2(e),
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
function no(n)
local e=0
repeat
e+=1
local t=f9(e)
n+=t
until t<(1<<e)-1
return n
end
local i,d,f,e,o,c,u,n,t=no"1",no"0",no"1",{},{},0,0,0
for n=1,no"1"do add(e,f9(f))end
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
if e.eH then A(e.eH)end
e:tC()
end)
eo.nJ=m"-1;,none,17,0,40,0,~f;0;,struggle,17,0,50,100,~ng;;,megapnch,1,20,80,85,~f;;,razrwind,1,10,80,75,~n0;;,sworddnc,1,30,0,0,~x,~h,R,2;;,whrlwind,1,20,0,100,~l,~nV;;,megakick,1,5,120,75,~f;;,toxic,5,10,0,85,~fU;;,horndril,1,5,-5,30,~nW;;,bodyslam,1,15,85,100,~f,30,~X,4;;,takedown,1,20,90,85,~ng;;,doubedge,1,15,100,100,~ng;;,bublbeam,4,20,65,100,~f,10,~l,~h,M,-1;;,watergun,4,25,40,100,~f;;,icebeam,10,10,95,100,~f,10,~X,3;;,blizzard,10,5,120,90,~f,10,~X,3;;,hyprbeam,1,5,150,90,~of;;,payday,1,20,40,100,~f;;,submsion,3,20,80,80,~ng;;,counter,3,20,-5,100,~o_;;,seistoss,3,20,-5,100,~ea,50;;,rage,1,20,20,100,~fZ;;,megdrain,8,10,40,100,~nb;;,solrbeam,8,10,120,100,~n0;;,drgnrage,14,10,-5,100,~ea,40;;,thndrblt,6,15,95,100,~f,10,~X,4;;,thunder,6,10,120,70,~f,10,~X,4;;,earthqke,7,10,100,100,~f;;,fissure,7,5,-5,30,~nW;;,dig,7,10,100,100,~nr,|begins|digging;;,psychic,12,10,90,100,~f,30,~l,~h,er,-1;;,teleport,12,20,0,0,~x,~nV;;,mimic,1,10,0,0,~fK;;,doubteam,1,15,0,0,~x,~h,eI,1;;,reflect,12,20,0,0,~x,~eb,|raises|defense,am;;,bide,1,10,-5,100,~oe;;,metrnome,1,10,0,0,~fR;;,selfdstr,1,5,260,100,~f;;,eggbomb,1,10,100,75,~f;;,fireblst,2,5,120,85,~f,30,~X,2;;,swift,1,20,60,-5,~f;;,skulbash,1,15,100,100,~n0;;,softboil,1,10,0,0,~t8;;,dreameat,12,15,100,100,~od;;,skyattck,9,5,140,90,~n0;;,rest,12,10,0,0,~oo;;,thndrwav,6,20,0,100,~X,4;;,psywave,12,15,-5,80,~on;;,explsion,1,5,340,100,~f;;,rockslid,13,10,75,90,~f;;,triattck,1,10,80,100,~f;;,substute,1,10,0,0,~fY;;,cut,1,30,50,95,~f;;,fly,9,15,70,95,~nr,|begins|flying;;,surf,4,15,95,100,~f;;,strength,1,15,80,100,~f;;,flash,1,20,0,70,~l,~h,D,-1;;,pound,1,35,40,100,~f;;,karatchp,3,25,55,100,~f;;,doubslap,1,10,15,85,~e6;;,comtpnch,1,15,20,85,~e6;;,firepnch,2,15,75,100,~f,10,~X,2;;,icepnch,10,15,75,100,~f,10,~X,3;;,thndpnch,6,15,75,100,~f,10,~X,4;;,scratch,1,35,40,100,~f;;,vicegrip,1,30,55,100,~f;;,guilotin,1,5,-5,30,~nW;;,gust,9,35,40,100,~f;;,wingatck,9,35,35,100,~f;;,bind,1,20,15,75,~ni;;,slam,1,20,80,75,~f;;,vinewhip,8,10,35,100,~f;;,stomp,1,20,65,100,~f,30,~l,~ex;;,doubkick,3,30,30,100,~n1,2,~L;;,jumpkick,3,20,70,95,~f;;,rllngkck,3,15,60,85,~f,30,~l,~ex;;,sandatck,7,15,0,100,~l,~h,D,-1;;,headbutt,1,15,70,100,~f,30,~l,~ex;;,hornatck,1,25,65,100,~f;;,furyatck,1,20,15,85,~e6;;,tackle,1,35,35,95,~f;;,wrap,1,20,15,85,~ni;;,thrash,1,20,90,100,~t9;;,tailwhip,1,30,0,100,~l,~h,B,-1;;,psnsting,5,35,15,100,~f,20,~X,5;;,twineedl,11,20,25,100,~oa;;,pinmisil,11,20,15,85,~e6;;,leer,1,30,0,100,~l,~h,B,-1;;,bite,1,25,60,100,~f,10,~l,~ex;;,growl,1,40,0,100,~l,~h,R,-1;;,roar,1,20,0,100,~l,~nV;;,sing,1,15,0,55,~X,6;;,sprsonic,1,20,0,55,~l,~nd;;,sonicbom,1,20,-5,90,~ea,20;;,disable,1,20,0,55,~fJ;;,acid,5,30,40,100,~f,10,~l,~h,B,-1;;,ember,2,25,40,100,~f,10,~X,2;;,flamthwr,2,15,95,100,~f,10,~X,2;;,mist,10,30,0,0,~x,~eb,|stat lower|immunity,ol;;,hydropmp,4,5,120,80,~f;;,psybeam,12,20,65,100,~f,10,~l,~nd;;,aurorabm,10,20,65,100,~f,10,~l,~h,R,-1;;,peck,9,35,35,100,~f;;,drillpck,9,20,80,100,~f;;,lowkick,3,20,50,90,~f,30,~l,~ex;;,absorb,8,20,20,100,~nb;;,leechsed,8,10,0,90,~l,~eb,|is now|seeded,a0,1,~el;;,growth,1,40,0,0,~x,~h,er,1;;,razrleaf,8,25,55,95,~f;;,psnpowdr,5,35,0,75,~X,5;;,stunspor,8,30,0,75,~X,4;;,slppowdr,8,15,0,75,~X,6;;,petldanc,8,20,70,100,~t9;;,strngsht,11,40,0,95,~l,~h,M,-1;;,firespin,2,15,15,70,~ni;;,thndshck,6,30,40,100,~f,10,~X,4;;,rockthrw,13,15,50,65,~f;;,cnfusion,12,25,50,100,~f,10,~l,~nd;;,hypnosis,12,20,0,60,~X,6;;,meditate,12,40,0,0,~x,~h,R,1;;,agility,12,30,0,0,~x,~h,M,2;;,quickatk,1,30,40,100,~f;;,ngtshade,15,15,-5,100,~ea,50;;,screech,1,10,0,85,~l,~h,B,-2;;,recover,1,20,0,0,~t8;;,harden,1,30,0,0,~x,~h,B,1;;,minimize,1,20,0,0,~fW;;,smokscrn,1,20,0,100,~l,~h,D,-1;;,cnfusray,15,10,0,100,~l,~nd;;,withdraw,4,40,0,0,~x,~h,B,1;;,dfnscurl,1,40,0,0,~x,~h,B,1;;,barrier,12,30,0,0,~x,~h,B,2;;,lghtscrn,12,30,0,0,~x,~eb,|raises|spcdefense,ac;;,haze,10,30,0,-5,~fQ;;,fcsenrgy,1,30,0,0,~x,~eb,|raises|crit ratio,au;;,mirrmove,9,20,-5,0,~fS;;,lick,15,30,20,100,~f,30,~X,4;;,smog,5,20,20,100,~f,30,~X,5;;,sludge,5,20,65,100,~f,30,~X,5;;,boneclub,7,20,65,85,~f,10,~l,~ex;;,watrfall,4,15,80,100,~f;;,clamp,4,10,35,75,~ni;;,spikcann,1,15,20,100,~e6;;,constrct,1,35,10,100,~f,10,~l,~h,M,-1;;,amnesia,12,20,0,0,~x,~h,er,2;;,kinesis,12,15,0,80,~l,~h,D,-1;;,hijmpkck,3,20,85,90,~f;;,glare,1,30,0,75,~X,4;;,poisngas,5,40,0,55,~X,5;;,barrage,1,20,15,85,~e6;;,leechlif,11,15,20,100,~nb;;,lovekiss,1,10,0,75,~X,6;;,tranform,1,10,0,0,~fM;;,bubble,4,30,20,100,~f,10,~l,~h,M,-1;;,dizypnch,1,10,70,100,~f;;,spore,8,15,0,100,~X,6;;,splash,1,40,0,0,~fV;;,acidarmr,5,40,0,0,~x,~h,B,2;;,crabhamr,4,10,90,85,~f;;,furyswps,1,15,10,80,~e6;;,bonerang,7,10,50,90,~n1,2,~L;;,hyprfang,1,15,80,90,~f,10,~l,~ex;;,sharpen,1,30,0,0,~x,~h,R,1;;,convrson,1,30,0,0,~fN;;,suprfang,1,10,-5,90,~ot;;,slash,1,20,70,100,~f"
tY=m"0,0x5e00,1,0x5e1e,2,0x5e3c"
fx=16
function _init()
local _ENV=eo
memset(0x8000,0,0x7fff)
nf=tw"ey,a5,T,~as,eD,4;tD;eu,eB,eD,4,eH,~z,nG,~z,tC,~L,ed,~L,ev,~L,e1,~L,P,~L,E,~L,ef,;a5;next,fb,ei,.5,ev,~es;fb;next,eB,ei,.5,ev,~es;fg;eu,eB,next,eB,ei,.5,eH,159,ev,~es;eB;eu,eB,next,tL,tC,~oH,ev,~es,ed,~oJ;tL;eu,tL,next,aP,ei,.2,ev,~es;aP;eu,nS,next,aE,eD,3,ei,.2,eH,155,ev,~es;aE;eu,nS,next,aX,eD,2,ei,.2,eH,154,ev,~es;aX;eu,nS,next,aL,eD,1,ei,.2,eH,153,ev,~es;aL;eu,nS,next,tX,eD,0,eH,152,tC,~oz,ev,~es,ed,~oq,e1,~oA,P,~oB,E,~oD;tX;eu,tX,next,eB,ei,.25,ev,~es,ed,~L;"
es(nf)
flip()
sfx(53,2)
tG(0x0)
tG(0x2)
tG(0x4)
C(poke,";,0x5f5c,8;;,0x5f5d,2;;,0x5f56,0xe0")
fy(peek2"0x6",mget,mset)
o1()
oi()
local e=peek2"0xa"
for t,f in pairs(nU)do
local n={n=f}
for t=1,6do
add(n,peek(e))
e+=1
end
nU[t]=n
end
C(memcpy,";,0x0000,0xc000,0x2000")
end
function _update60()
local _ENV=eo
nT,e7,nj,nk=btnp"4",btnp"5",btnp"0"and btnp"1"and 0or btnp"0"and-1or btnp"1"and 1or 0,btnp"2"and btnp"3"and 0or btnp"2"and-1or btnp"3"and 1or 0
if@0x5eff==1then
nT,e7=e7,nT
end
nf:t4()
end
function _draw()
local _ENV=eo
nf:ev()
end