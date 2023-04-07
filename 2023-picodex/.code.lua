eo=setmetatable({},{__index=_ENV})
_ENV=eo
function nI(e,n,t)
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
return F(setmetatable({},{__index=eo}),...)
end
F(eo,"es,@,x,@,f9,@,L,@",true,false,"",function(...)return...end)
F(eo,"m,@,F,@,nI,@,tp,@,tw,@,Y,@,t5,@,t3,@,nC,@,H,@,eP,@,eL,@,b,@,C,@,n2,@,eg,@,eE,@,U,@,fj,@,tg,@,tb,@,eJ,@,t4,@,na,@,nd,@,nR,@,e_,@,np,@,J,@,fz,@,fq,@,fA,@,fB,@,fD,@,fF,@,Q,@,nw,@,tx,@,eb,@,fH,@,ty,@,fJ,@,fK,@,fM,@,fN,@,n5,@,t6,@,fQ,@,fR,@,tk,@,fS,@,t8,@,z,@,E,@,v,@,fU,@,fV,@,t7,@,X,@,e4,@,ex,@,ni,@,fW,@,fY,@,fZ,@,oe,@,on,@,ot,@,t9,@,nr,@,nm,@,nc,@,of,@,oo,@,o_,@,nu,@,ey,@,oa,@,n3,@,f,@,ng,@,od,@,nS,@,tj,@,tz,@,ea,@,eK,@,nl,@,tq,@,oi,@,nb,@,tA,@,nU,@,nV,@,n4,@,om,@,nW,@,nT,@,e6,@,oc,@",m,F,nI,function(e)
return F(m"nx,0,tB,0,tD,~es,l,~L,ed,~L,eC,#;",e)
end,function(_ENV,e)
if e==ek then
return ei and nx/ei or 0
end
if _ENV[e]and _ENV[e].ou then
return 1
end
return 0
end,function(_ENV,e)
ny=e or next
end,function(_ENV,e)
nx,ny,tD,next,ei=0
_ENV[ek].ou=true
for e,n in pairs(tF)do _ENV[e]=n end
for n,t in pairs(_ENV[e])do _ENV[n]=t end
ek=e
_ENV:l()
tB=#eC
end,function(_ENV)
nx+=1/60
if tD then _ENV:t5(ek)end
if ei and nx>=ei then
_ENV:Y()
end
while ny do
_ENV:t5(ny)
end
_ENV:ed()
end,function(_ENV,e)
while ny~=e and#eC>0do
_ENV:H()
end
end,function(_ENV)
deli(eC)
_ENV:Y(eC[#eC]or"eM")
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
eN(e or"",23,4,1,0)
end,function(e)
C(rectfill,";,0,0,45,6,1")
C(eN,";,@,23,1,13,0;;,@,23,8,1,0;;,@,23,15,1,0",unpack(split(e,"|",false)))
end,m"",split"missingno,bulbasaur,ivysaur,venusaur,charmander,charmeleon,charizard,squirtle,wartortle,blastoise,caterpie,metapod,butterfree,weedle,kakuna,beedrill,pidgey,pidgeotto,pidgeot,rattata,raticate,spearow,fearow,ekans,arbok,pikachu,raichu,sandshrew,sandslash,nidoran f,nidorina,nidoqueen,nidoran m,nidorino,nidoking,clefairy,clefable,vulpix,ninetales,jigglypuff,wigglytuff,zubat,golbat,oddish,gloom,vileplume,paras,parasect,venonat,venomoth,diglett,dugtrio,meowth,persian,psyduck,golduck,mankey,primeape,growlithe,arcanine,poliwag,poliwhirl,poliwrath,abra,kadabra,alakazam,machop,machoke,machamp,bellsprout,weepinbell,victreebel,tentacool,tentacruel,geodude,graveler,golem,ponyta,rapidash,slowpoke,slowbro,magnemite,magneton,farfetchd,doduo,dodrio,seel,dewgong,grimer,muk,shellder,cloyster,gastly,haunter,gengar,onix,drowzee,hypno,krabby,kingler,voltorb,electrode,exeggcute,exeggutor,cubone,marowak,hitmonlee,hitmonchan,lickitung,koffing,weezing,rhyhorn,rhydon,chansey,tangela,kangaskhan,horsea,seadra,goldeen,seaking,staryu,starmie,mr mime,scyther,jynx,electabuzz,magmar,pinsir,tauros,magikarp,gyarados,lapras,ditto,eevee,vaporeon,jolteon,flareon,porygon,omanyte,omastar,kabuto,kabutops,aerodactyl,snorlax,articuno,zapdos,moltres,dratini,dragonair,dragonite,mewtwo,mew",m"0,none;,fainted,burned,frozen,paralyzed,poisoned,sleeping",m"0, ;,FNT,BRN,FZN,PAR,PSN,SLP",m"0;c,2,n,~f9;1;c,2,n,normal,15,0,13,.5;2;c,10,n,fire,8,2,10,2,11,2,2,.5,4,.5,13,.5,14,.5;3;c,7,n,fighting,10,2,1,2,13,2,15,0,11,.5,9,.5,5,.5,12,.5;4;c,9,n,water,2,2,7,2,13,2,14,.5,8,.5,4,.5;5;c,6,n,poison,11,2,8,2,15,.5,7,.5,5,.5,13,.5;6;c,11,n,electric,9,2,4,2,7,0,14,.5,6,.5,8,.5;7;c,7,n,ground,6,2,2,2,5,2,13,2,9,0,11,.5,8,.5;8;c,8,n,grass,7,2,13,2,4,2,11,.5,14,.5,2,.5,9,.5,8,.5,5,.5;9;c,2,n,flying,11,2,3,2,8,2,6,.5,13,.5;10;c,9,n,ice,14,2,9,2,8,2,2,.5,10,.5,4,.5;11;c,8,n,bug,8,2,12,2,3,.5,2,.5,9,.5,15,.5,5,.5;12;c,6,n,psychic,3,2,5,2,12,.5;13;c,2,n,rock,11,2,2,2,9,2,10,2,3,.5,7,.5;14;c,2,n,dragon,14,2;15;c,6,n,ghost,15,2,1,0,12,2;17;c,2,n,bird;",m"V,hp,er,spc,R,att,q,def,M,spd,n6,tot,A,acc,e2,eva",m";c,13,em,5,ns,1;;c,6,em,13,ns,13;;c,5,em,5,ns,1;;c,6,em,5,ns,5;;c,1,em,5,ns,13;;c,14,em,4;;c,9,em,4;;c,11,em,3;;c,12,em,5;;c,8,em,2;;c,10,em,4",m"",split"youngstr,bugcatch,junior,brock,lass,hiker,swimmer,misty,gentlman,sailor,rocker,ltsurge,channelr,gambler,beauty,erika,biker,birdkeep,juggler,koga,blckbelt,rocket,psychic,sabrina,scientst,pkmaniac,suprnerd,blaine,cooltrnr,fishrman,tamer,giovanni,lorelei,bruno,agatha,lance,blue,green,red,legendry",function(e,n)
if n.Z then
e:eP(n.Z)
else
e:H()
end
end,function(e,n)
return m("ol,@,tH,@,S,~tH,y,1,ed,~fB,ec,~fF,n1,~fq,N,~fz",e,n or 0)
end,function(e,n)
return F(np(e),"p,0,y,@,ed,~fD,nY,~fA",n or 1)
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
if eQ then K"154"e.n1(n)end
if e8 then n:nk()end
e.S+=nZ
if te~=0then n:tJ(te)end
local n=e.S
e.S=mid(e.tH,e.S,#e-3)
if e.S~=n then
eL()
elseif nZ~=0then
K"154"
end
end,function(t)
local e=t.o
e:nY"0"
e:nY(nZ,true)
e:nY(te)
if e8 then
local n=e[e.p+1]
if n.eu then
eL()
elseif n.I then
K"155"
n.I(t,n)
end
end
if eQ then K"154"e.n1(t)end
end,function(n)
local e=n.o
local f=e.y>1and 10or 40
local a=20-(e.y*f)/2
C(rectfill,";,0,0,39,39,1;;,0,@,39,@,13",5-e.S*10,4+(max(ceil(#e/e.y),3)-e.S)*10)
for n=-1,e.y*5-1do
local d=(e.S-1)*e.y+n+1
local t=e[d]
if t then
local o,i,r=t.n8 or 1,a+n%e.y*10,n\e.y*10
if t.eu then o=3end
if d-1==e.p then o+=1end
if not t.tn then
rectfill(i,r-5,i+f-1,r+4,na[o].c)
n2(n%e.y*f+a+f/2,n\e.y*10-3,function()
e.ol(t,na[o])
end)
end
end
end
end,function(e,n)
if e.ee then
local n=na[eJ[e.ee.eO].c]
C(rectfill,";,-20,-2,19,17,@;;,-20,14,19,17,@",n.c,n.em)
e.ee:n7(0,8,n,1,1)
else
tK(e.n,0,0,n.ns)
end
end,function(e,n)
e.ee:n7(0,3,n,.375,.375)
end,function(n)
local e=nV(n.k)
del(e,n.a.W)
if#e>0then
return e[b(#e)+1]
end
end,function(_ENV,e)
local n=n0[e]
if e=="e2"or e=="A"then
return _ENV[e]*mid(1,1+n/3,3)/mid(1,1-n/3,3)
end
return ceil(mid(1,999,
(e=="R"and T==2and.5or e=="M"and T==4and.25or 1)*
_ENV[e]*mid(2,2+n,8)/mid(2,2-n,8)
))
end,function(_ENV)
if i.tt>0then return true end
local e=n9(i)
if#e==0then return true end
i.tt,i.eR=b"6"+2,e[b(#e)+1].en
r(e1,"|"..i.w[i.eR].n.."|disabled")
if i.g and i.g.en==i.eR then
i.e0=0
end
end,function(_ENV,t,n)
local e=B(t,n)
e.e7,e.tM=5,5
w[n]=e
return e
end,function(_ENV)
local n=n9(i,true)
r(O,"|copies|"..ty(e,n[b(#n)+1].d,u.en).n)
end,function(_ENV)
if e.oT then
return true
else
r(O,"|copies|"..i.n,function()
e.oT=true
foreach(split"d,R,q,M,er,eO,ep",function(n)
e[n]=i[n]
end)
e.w={}
foreach(i.w,function(n)
ty(e,n.d,n.en)
end)
end)
end
end,function(_ENV)
F(e,"eO,@,ep,@",i.eO,i.ep)
r(O,"|copies|types")
end,function(_ENV)
foreach({e1,O},function(e)
F(e.a.n0,"er,0,R,0,q,0,M,0,A,0,e2,0,tN,~x")
r(e,"|resets|stats")
end)
end,function(_ENV,n,e)
e=min(e,n.a.V-n.a.D)
if e>0then
tj(_ENV,n,e,function()
n.a.W.D+=e
end)
else
return true
end
end,function(_ENV)
return n5(_ENV,O,e.V\2)
end,function(_ENV)
tf(O,B(b(164)+1,u.en))
end,function(_ENV)
if e.to>0then
tf(O,B(e.to,u.en))
else
return true
end
end,function(_ENV)
local e=tx(e1)
if e then
t_(e1,e)
else
return true
end
end,function(_ENV)
local e=tx(O)
if e then
t_(O,e)
else
return true
end
end,function(e,n)
return(sgn(e)>0and"|+"or"|-")..abs(e).." "..n.."|change"
end,function(_ENV,e,...)return e(_ENV,O,...)end,function(_ENV,e,...)return e(_ENV,e1,...)end,function(_ENV,e,n,t,o)
local f=e.a.n0[n]
if not e.a.os or t>0then
e.a.n0[n]=mid(-6,6,f+t)
end
if f~=e.a.n0[n]then
r(e,t8(t,t4[n]),o or L)
else
return true
end
end,function(_ENV)
if X(_ENV,5)and i.T~=5then
return true
end
return E(_ENV,e4,"|badly|poisoned","nj",1,true)
end,function(_ENV)
r(O,"|does|nothing")
end,function(_ENV)
return ta(u,i)>0and u.eG~=i.eO and u.eG~=i.ep
end,function(_ENV,n)
if i.W.T==3and n==2then
r(O,"|thawed|out")
e.W.T=0
elseif i.W.T==0and(n==6or t7(_ENV))then
r(e1,"|is now|"..tg[n],function()
i.W.T=n
td=b"8"
end)
else
return true
end
end,function(_ENV,e,t,n,f,o)
if(e.a[n]or 0)==0and(not o or t7(_ENV))then
e.a[n]=f or 1
r(e,t)
else
return true
end
end,function(_ENV,e)
e.a.tQ=true
end,function(_ENV,e)
return e4(_ENV,e,"|becomes|confused","nz",b"4"+1)
end,function(_ENV)
return v(_ENV,O,"e2",1,function()
e.tN=.25
end)
end,function(_ENV)
local n=e.V\4
if n>=e.D or e.ew>0then
return true
end
eK(_ENV,n)
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
e.nq=0
end
if e.e0==0then
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
e9(e,b"2"+1,B(u.d,u.en))
f(_ENV)
if e.e0==0then
z(_ENV,ni,"nz")
end
end,function(_ENV)
if not e.g then
e9(e,b"4"+1,B(u.d,u.en))
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
e.W.T,e.td=6,2
n5(_ENV,O,e.V)
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
_ENV.i=e1.a
f(_ENV,100,function()
nu(_ENV,e-1,n,true)
end)
end)
else
n()
end
end,function(_ENV,e)
nu(_ENV,2+b"4",L)
end,function(_ENV)
nu(_ENV,2,function()
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
n5(_ENV,O,max(e\2,1))
end)
end,function(_ENV)
if i.T==6then
ng(_ENV)
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
local f=t8(t,"hp")
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
tj(_ENV,t,-n,function()
e.nq+=n
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
local f,t=false,ta(u,i)
if not n then
n,f=tR(e,i,u)
end
if t>0then
if u.eG%2==1then
i.nA+=n
end
if t>1then r(O,"|super|effective")
elseif t<1then r(O,"|not very|effective")end
if f then r(O,"|critical|hit")end
tz(_ENV,e1,n,false,o)
else
r(e1,"|resisted|attack")
end
end,function(_ENV,e)
tz(_ENV,O,e,true,L)
end,function(e)
return ceil(e+.5*93)+5
end,function()
return m("et,~es,R,0,q,0,er,0,M,0,V,0,D,0,n6,0,A,100,e2,100,tS,0,tU,0,tV,0,ti,0,tW,0,d,-1,o1,-1,n, ,eO,0,ep,0,eS,#,eU,#,nB,#,w,@",nD())
end,function()
local e=peek2"0xa"
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
F(e,"d,@,o1,@,n,@,eO,@,ep,@,tS,@,tU,@,tV,@,ti,@,tW,@",t,
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
F(_ENV,"R,@,q,@,er,@,M,@,V,@,D,~V",nl(tU),
nl(tV),
nl(tW),
nl(ti),
nl(tS)+55
)
n6=R+q+er+M+V
end
U[t]=e
end
end,function(e,n)
return setmetatable(m("w,@,T,0,et,~x",n),{__index=U[e]})
end,function(e)
foreach(nU(e.k),function(e)
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
return nV(e)[1]
end,function(e)
local n=e:ej"j"
n[e:G"el"+1]=nb(-1,nD())
e6(e:G"j",n)
e:H()
end,function(e,o,n)
local t,f=U[n],nD()
for e=1,min(4,#t.eS)do
f[e]=B(t.eS[e],e)
end
e[o]=nb(n,f)
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
e[t]=nb(o and@f or-1,n)
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
local e=peek2"0x8"
for n=-1,164do
local f,o,a,d,i=peek(e+0),peek(e+1)*5-5,peek(e+2)*5-5,peek(e+3)*5-5,deli(tr[n],1)
local t=deli(tr[n],1)
nd[n]=m("o0,@,d,@,n,@,eG,@,e7,@,tM,~e7,tm,@,A,@,eV,@",function(e)
return t(e,unpack(tr[n]))
end,n,i,f,o,a,d,t)
e+=4
end
end)
F(eo,"B,@,nD,@,tc,@,tu,@,tl,@,tT,@,ts,@,eW,@,ov,@,oh,@,tZ,@,eY,@,t1,@,nh,@,t0,@,fe,@,fn,@,oP,@,ft,@,eZ,@,oE,@,ff,@,oX,@,oL,@,fo,@,oO,@,oG,@,f_,@,oI,@,oC,@,o2,@,op,@,ow,@,fa,@,o5,@,o3,@,og,@,ob,@,o4,@,nP,@,aI,@,ox,@,oy,@,o6,@,ok,@,o8,@,o7,@,o9,@,oj,@,oz,@,oq,@,oA,@,oB,@,oD,@,oF,@,fd,@,G,@,e5,@,oH,@,fi,@,oJ,@,fr,@,K,@,ev,@,fm,@,tK,@,eN,@,ne,@,oK,@,fc,@,n7,@,oM,@,oN,@,oQ,@,fu,@,oR,@,oS,@,ej,@,nE,@,nF,@,nH,@,t_,@,tf,@,e9,@,oU,@,nJ,@,oV,@,nK,@,nn,@,nX,@,nL,@,oW,@,oY,@,fl,@,fT,@,n9,@,fs,@,ta,@,tR,@,f1,@",function(e,n)
return setmetatable(m("en,@",n or 0),{__index=nd[e]})
end,function()
local e={}
for n=1,4do add(e,B(-1))end
return e
end,function(e)
fd(e)
tK("team #"..e:G"j"+1,20,27,1)
end,function(_ENV)
local t,e,n=ez.a,eI.a,eq.a
local o,a=e==t,n==t
local t,f=11,11
C(rectfill,";,0,0,39,6,5;;,0,33,39,39,5")
C(rectfill,";,-1,33,@,41,1;;,-1,-2,@,6,1",max(ceil(e.D/e.V*40),0)-1,
max(ceil(n.D/n.V*40),0)-1)
C(rectfill,";,15,6,39,6,13;;,16,5,39,5,13;;,0,33,24,33,13;;,0,34,23,34,13")
C(eN,";,@,40,34,13,1;;,@,40,27,1,1;;,@,2,1,13,-1;;,@,2,7,1,-1",e.D,tb[e.T],n.D,tb[n.T])
local t,f=1,1
e:n7(10,25,na[4],t,t,o)
n:n7(30,15,na[4],-f,f,a)
end,function(e)oK(U[e:G"et"])end,function(e)eg("spot #"..(e:G"el"+1))end,function(e)eg("move #"..(e:G"eX"+1))end,function(e)eg(e.nt)end,function(e)eg"match over"end,function(n)
local e=n:e5"nM"
eg(e and e.oZ)
end,function()
rectfill(0,0,46,13,13)
pal(7,1)
local e=0
for f,n in ipairs(split"6,5,5,6,6,5,6")do
sspr(6*8+e,6*8,n,8,e+3,3.5+cos((t()+f)/4))
e+=n
end
pal()
end,function(e)eg(e.ez.ae.n)end,function(e)
fc(e:nE())
end,function(n)
local e=n:e5(n.f0).u
if e.d>=0then
eE(eJ[e.eG].n.."|"..e.e7.."/"..e.tM.."|"..(e.tm>=0and e.tm or"??").."P "..(e.A>=0and e.A or"??").."A")
else
eE"none|n/a|"
end
end,function(e)
fc(e:e5"et".ee)
end,function(e)
eE(e:e5"eM".e3)
end,function(_ENV)
if d>-1then
eE(n.."|"..D.."/"..V.."|"..tg[T])
else
eE"none|n/a|"
end
end,function(_ENV)fn(_ENV:e5"tv".ee)end,function(_ENV)fn(s.a)end,function(e)
local n,t=0,0
foreach(e:e5().k,function(e)
if e>-1then
n+=U[e].n6
t+=1
end
end)
eE(e:e5().n.."|len "..t.."/6|pow "..n\10)
end,function(e)
eE(e.nf.n.."|is the|winner")
end,function(e)
eE(e.ez.n..e.ez.fv)
end,function(_ENV)
local n=nn(_ENV,nf)
nf:an(n)
o:N{}
o.n1=function(e)
e:nC"th"
end
for e in all{nf,n}do
F(o,"S,0;;ee,@;;tn,~es;;n,@,n8,5;;n,@;;n,@",e.a.W,e.n,(#nV(e.k,true)).." live",(#nU(e.k)).." dead")
end
end,function(_ENV)
local e=0
for n=0,151do e+=U[n]:ne()and 1or 0end
o:N(
m(";n,browse,Z,et,I,~e_,e3,@;;n,edit,Z,j,I,~e_,e3,edit|stored|teams;;n,league,Z,fh,I,~e_,e3,@;;n,versus,Z,tP,I,~e_,e3,versus|p1 vs p2|match;;n,horde,Z,fP,I,~e_,e3,@;;n,credits,Z,fE,I,~e_,e3,credits|amorg|games","browse|"..e.."/151|pokemon","league|"..(@0x5efd).."/40|trainers","horde|"..(@0x5efe).."/151|hi-score")
)
end,function(_ENV,n)
local e={}
for n=0,151do
add(e,n)
end
o:N(
e,
function(e)
return m("I,@,eu,@,ee,@",n,not U[e]:ne(),U[e])
end
)
end,function(_ENV)
fo(_ENV,function(_ENV)
_ENV:eP"fX"
end)
end,function(_ENV)
fo(_ENV,function(_ENV)
e6(_ENV:G"j",nW(_ENV:ej"j",_ENV:G"el"+1,_ENV:G"et"))
_ENV:H()
end)
end,function(_ENV)
local e=_ENV:e5"et".ee
o:N{}
F(o,";ee,@;;tn,~es;;n,lvl 50,n8,5",e)
foreach(split"V,er,R,q,M,n6",function(n)
add(o,{n=t4[n].." "..e[n]})
end)
C(function(t,n)
if#U[e.d][n]>0then
add(o,{n=t,n8=5})
foreach(U[e.d][n],function(e)
add(o,{n=nd[e].n})
end)
end
end,";,learn,eS;;,teach,eU;;,event,nB")
end,function(_ENV)
o:N(
split"91,,#alanxoc3,code &,design,28,,#gr8cadet,pokemon,sprites,143,,#tigrwolf,battle,testing,127,,#tooling,px9 func,shrinko8,137,,#pkmndata,blbpedia,pokeapi,serebii,smogon,upokcntr,volvox,nintendo",
function(e)
if type(e)=="number"then
return{ee=nb(e,nD())}
end
local n=1
if sub(e,1,1)=="#"then
e,n=sub(e,2),5
end
return{n=e,n8=n,tn=e==""}
end
)
end,function(_ENV)
o:N(nR,function(e,n)
return{
n=e.n,
k=e,
eu=n-1>@0x5efd,
I=function(t,e)
fL(t,e.k,e.n,function(t,e)
poke(0x5efd,mid(@0x5efd,n,40))
tA(e)
end,L)
end
}
end)
end,function(_ENV)
o:N(m";n,moves,Z,eX,I,~e_;;n,switch,Z,tE,I,~e_;;n,delete,I,~om")
end,function(_ENV)
local n=_ENV:nE()
local e=0
for t=1,4do
if n.w[t].d>0then e+=1end
end
o:N(m(";n,change,Z,nM,I,~e_;;n,switch,Z,fO,I,~e_;;n,delete,eu,@,I,~ow",e==1))
end,function(_ENV)
local e,n=_ENV:nE()
e.w[_ENV:G"eX"+1]=B(-1)
e6(_ENV:G"j",n)
_ENV:H()
end,function(_ENV,f,a)
local n,d=_ENV:nE()
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
fa(_ENV,0,function(_ENV,e,n)
_ENV:eP(n.w[e].d>0and"fG"or"nM")
end)
end,function(_ENV)
local n=_ENV:G"eX"+1
fa(_ENV,n,function(_ENV,t,e,f)
e.w[t],e.w[n]=e.w[n],e.w[t]
e6(_ENV:G"j",f)
_ENV:nC"eX"
end)
o.p=eX.o.p
end,function(_ENV)
local n=_ENV:nE()
local e=U[n.d]
local t={}
C(function(f,a)
for o=1,#f do
local e=f[o]
add(t,{n=nd[e].n,eu=n:fl(e),d=e,e3=a..o})
end
end,";,@,learn #;;,@,teach #;;,@,event #",e.eS,e.eU,e.nB)
o:N(t,function(e)
return{
n=e.n,
eu=e.eu,
u=nd[e.d],
oZ=e.e3,
I=function()
local n=_ENV:ej"j"
n[_ENV:G"el"+1].w[_ENV:G"eX"+1]=B(e.d)
e6(_ENV:G"j",n)
_ENV:nC"eX"
end
}
end)
end,function(_ENV)
local n=fs(s.a)
if s.a.g then
nK(s,s.a.g)
_ENV:H()_ENV:H()
elseif#n==0then
nK(s,B(0))
_ENV:H()_ENV:H()
end
o:N(s.a.w,function(e)
return m("eu,@,n,@,u,@,I,@",
not n[e],
e.n,
e,
function()
_ENV:H()_ENV:H()
nK(s,e)
end
)
end)
end,function(_ENV)
o:N(m";n,fight,I,~e_,Z,fI;;n,switch,I,~e_,Z,tv;;n,forfeit,I,~at")
end,function(_ENV)
o:N(m",1,2,3",function(e)
local n=nT(e-1)
local t={}
local f=true
for e=1,6do
t[e]=n[e].d
if not n[e]:fT()then
f=false
end
end
return{
n="team #"..e,
k=t,
I=function()_ENV:nO()end,
eu=nG and f
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
if e[_ENV:G"el"+1]:ne()then
_ENV:eP"fC"
else
_ENV:eP"f2"
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
local n,t=_ENV:G"el"+1,_ENV:G"tE"+1
e[n],e[t]=e[t],e[n]
e6(_ENV:G"j",e)
_ENV:nC"el"
end,
ee=e[n]
}
end)
o.p=el.o.p
end,function(_ENV)
local e=_ENV:ej"j"
o:N(m",1,2,3,4,5,6",function(e)
local n=s.k[e]:fT()or s.a.W==s.k[e]or s.k[e].T==1
return{
eu=n,
I=function()
_ENV:H()_ENV:H()
t_(s,s.k[e])
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
if U[t]:ne()then
et.o.p,n=t
K"154"
break
end
end
if n then eL()end
f_(_ENV)
end,function(e)K(e:G"et")end,function()K(b"152")end,function(_ENV)K(nf.a.d)end,function(_ENV)
local e={}
for t,n in pairs(split"133,7,35,1,25,4")do
nW(e,t,n)
poke(0x5e5a+n,1)
end
if@0x5efc==0then
poke(0x5efc,1)
e6(0,e)
end
ef=tp"ek,eM;tF;o,~x,l,~L,tJ,~eL,nk,~L,ed,~oF,f0,~x,ec,~fd,h,~L,P,~L;eM;l,~oL,h,~tZ,P,~fe;et;l,~oO,h,~tl,P,~t0;fX;l,~f_,h,~tl,P,~t0,tJ,~o8,nk,~o7;el;l,~ox,h,~tT,P,~t1,ec,~tc;tE;l,~oy,h,~tT,P,~t1,ec,~tc;f2;l,~oG,h,~tl,P,~t0;fC;l,~o2,h,~tT,P,~t1;fG;l,~op,h,~ts,P,~nh,f0,eX;nM;l,~og,h,~oh,P,~nh;eX;l,~o5,h,~ts,P,~nh;fO;l,~o3,h,~ts,P,~nh;j;nt,player,l,~nP,h,~eW,P,~eZ,nG,~x,nO,~oS;fh;nt,player,l,~nP,h,~eW,P,~eZ,nG,~es,nO,~oM;tP;nt,player 1,l,~nP,h,~eW,P,~eZ,nG,~es,nO,~oN;fP;nt,player,l,~nP,h,~eW,P,~eZ,nG,~es,nO,~oR;tX;nt,player 2,l,~nP,h,~eW,P,~eZ,nG,~es,nO,~oQ;th;nt,trainer,l,~oC,h,~eW,P,~eZ;tL;l,~oX,h,~ov,P,~oE,nk,~oj;fp;l,~o4,h,~eY,P,~ft;fI;l,~ob,h,~eY,P,~nh;tv;l,~o6,h,~eY,P,~oP,ec,~tc;af;next,ao,l,~f1,fw,eI;ao;next,f5,l,~f1,fw,eq;f5;next,af,l,~ok,ed,~oW,ec,~tu,h,~eY,P,~ff,ez,~x;a_;l,~L,ed,~f3,ec,~tu,h,~eY,P,~ft;aa;l,~L,ed,~f3,ec,~tu,h,~eY,P,~ff;fE;l,~oI,h,~tZ,P,~fe,nk,~o9;"
C(function(e,n,...)
ef[e].o=n(...)
end,";,et,~J,~nw,4;;,fX,~np,~Q;;,fE,~np,~Q;;,tL,~np,~Q;;,el,~J,~nw,3;;,tE,~J,~nw,3;;,eM,~J,~Q;;,fC,~J,~Q;;,fG,~J,~Q;;,nM,~J,~Q;;,eX,~J,~Q;;,fO,~J,~Q;;,j,~J,~Q;;,tP,~J,~Q;;,th,~J,~Q;;,tX,~J,~Q")
F(ef,"fg,@,ad,@;eM;o;n1,~eL;fP;o,~fg;fh;o,~fg;f2;o,~ad;",ef.j.o,ef.et.o)
menuitem(1,"close picodex",function()
menuitem(1)
menuitem(2)
_ENV:Y"tO"
end)
menuitem(2,"swap 🅾️/❎",function()
poke(0x5eff,@0x5eff==0and 1or 0)
end)
end,function(e)
e.ef:t3()
end,function()no.ef:ec()end,function()no.ef:h()end,function()no.ef:P()end,function(_ENV)o.ed(_ENV)end,function(_ENV)o.ec(_ENV)end,function(_ENV,e)
return _ENV[e].o.p
end,function(_ENV,e)
local n=e and _ENV[e].o or o
return n[n.p+1]
end,function(_ENV)
menuitem(1,"factory reset",function()
memset(0x5e00,0,0x100)
_ENV:Y"fb"
end)
end,function()
return btn()&0x3f~=0
end,function(_ENV)
if not fi()and nN then
nN=false
_ENV:Y()
menuitem(1)
elseif fi()then
nN=true
menuitem(1)
end
end,0,function(e)
eo.fr=max(0,0+e-152)
sfx(54+e\16,0,e%16*2,2)
end,function(_ENV)
cls"0"
n2(0,128+sin(_ENV:tw"f4"/4)*128,function()
C(eN,";,aMORG gAMES,64,-68,7,0;;,pRESENTS,64,-61,7,0;;,a pOKEMON bATTLE sIM,64,15,7,0")
C(spr,";,102,44,7,5,1")
local t,
n,
e=
ef and ef.eM.o.p,
ef and ef.tB-1,
eT=="nQ"and 1
or eT=="eB"and-1
or(eT=="tG"and-1or 1)*cos(_ENV:tw(eT)/2)
n2(30-(e+1)*15+(ek=="fb"and b"3"-1or 0),27,function()
C(rectfill,";,14,18,@,87,5",63+max(0,e*54))
if eD==0then
C(rectfill,";,14,18,117,87,13")
C(function(e,n,t,f,o)
clip(-%0x5f28+e,-%0x5f2a+n,t,f)
n2(e,n,o)
clip()
end,";,14,21,40,40,@;;,71,18,46,13,@;;,71,67,46,21,@",ec,h,P)
end
C(map,";,24,0,2,1,8,3;;,8,0,2,9,8,11")
C(function(e,n,t,f,o,a)
return spr((eD<=e)and(fr==e and stat"46">=0and f or t)or n,o,a)
end,";,0,135,133,134,6,3;;,1,132,128,131,12,3;;,2,132,129,131,17,3;;,3,132,130,131,22,3")
C(function(e,n,t,f,o)
spr(btn(e)and n or t,f,o)
end,";,0,186,154,10,77;;,1,188,156,26,77;;,2,171,139,18,73;;,3,187,155,18,81;;,4,170,138,42,77;;,5,172,140,50,77")
if e<=0then
fm(0,2+64*(1-abs(e)),abs(e))
if e==-1and nN then spr(123,6,49)end
else
fm(16,62,e)
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
eg("pkmn #"..e.d)
end,function(e)
if e:ne()then
eE(e.n.."|"..eJ[e.eO].n.."|"..eJ[e.ep].n)
else
eE"none|n/a|"
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
if e==n[1]and _ENV:fl(n[2])then
e=n[3]
end
end)
if ew and ew>0then e=154end
if not ai or T~=1and not tI and not(e0~=0and g.eV==nm)then
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
end,function(e)e:eP"th"end,function(e)e:eP"tX"end,function(_ENV)
fy(_ENV,
m(",@,player 1,~x,~L",nT(_ENV:G"tP")),
m(",@,player 2,~x,~L",nT(_ENV:G"tX"))
)
end,function(_ENV)
poke(0x5efe,mid(@0x5efe,#nU(k),152))
end,function(_ENV)
local e={}
for n=1,152do add(e,n%152)end
fL(_ENV,e,"horde",function(n,e)
tA(e)
fu(e)
end,fu)
end,function(e)
e:eP"el"
end,function(e,n)
return nT(e:G(n))
end,function(e)
local n=nT(e:G"j")
return n[e:G"el"+1],n
end,function(e,n)
local f,t="|enters|fight",{}
foreach(n.w,function(e)
add(t,e)
end)
e.a=setmetatable(m("ai,~es,to,0,A,1,e2,1,e0,0,tI,~es,nA,0,nq,0,tt,0,nz,0,td,@,ew,0,nj,0,W,@,w,@;n0;er,0,R,0,q,0,M,0,A,0,e2,0",b"8",n,t),{__index=n})
return nX(e,f,function()
e.a.tI=false
end)
end,function(e,n)
for t in all(split(n))do
if t==e then
return true
end
end
end,function(e,n)
nL(e,e,"|leaves|fight",function(t)
t.e.tI=true
nL(e,e,false,function()
add(e.eF,nF(e,n))
end)
end)
e.eA=3000
end,function(t,n)
local f=t.a.g and"|resumes|"or(n.eV==aC and"|begins|"or"|uses|")
nL(t,t,f..n.n,function(f)
f.u=n
local _ENV=f
if n.d>0then
n.e7-=1
end
if nH(n.d,"47,36 ")then
eK(_ENV,e.D)
end
if(function()
if n.A<=0then return false end
if(n.eV==nc or n.eV==nm)and not e.g then return false end
if i.g and i.g.eV==nm then return true end
if e.g and e.g.eV==nr then return false end
return rnd(i:eb"e2")>n.A/100*e:eb"A"or b"256"==0and b"256"==0
end)()then
r(t,"|misses|"..n.n)
if nH(n.d,"145,73 ")then
eK(_ENV,1)
end
else
if n.o0(_ENV)then
r(t,"|fails|attack")
end
end
if n.A~=0then
i.to=n.d
end
end)
end,function(_ENV,e,n)
if not g and e0==0then
e0,g=e,n
end
end,function(n,t)
nL(n,n,false,function(f)
f.u=t
local _ENV=f
e:nJ("e0",L)
if e.T==6then
e:nJ("td",function()
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
if i.nv==e then
r(n,"|is|trapped")
elseif e.eR==t.en then
r(n,"|is|disabled")
elseif e.nz>0and b"2"==0then
r(n,"|confuse|damage")
eK(_ENV,tR(e,i,B(-1)))
elseif e.T==4and b"4"==0then
r(n,"|fully|paralyzed")
elseif e.tQ then
r(n,"|is|flinching")
else
tf(n,t)
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
return nX(n,false,function(_ENV)
if e.T==6
or e.T==3
or e.nv and e.nv~=i
then
e.e0=0
end
if e.e0==0then
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
n5(_ENV,e1,t)
end
end
e:nJ("nz",function()
r(n,"|confusion|ended")
end)
e:nJ("tt",function()
r(n,"|"..e.w[e.eR].n.."|enabled")
e.eR=0
end)
end)
end,function(e,n)
e.eF={}
local t=1000
oU(e,n)
if n.d==120then t=2000end
if nH(n.d,"18,4,89,30 ")then
t=0000
end
e.eA=min(3000,t+e.a:eb"M")
end,function(e,n)
return n==e.eI and e.eq or e.eI
end,function(e,n,t,f)
return{ae=e,n=f or e.a.n,a=e.a,fv=n,am=t or L}
end,function(e,...)
add(e.eF,nX(...))
end,function(e)
if eQ then eL()end
if e8 then K"154"end
if e8 or not e.ez then
while true do
for n in all{e.eI,e.eq}do
if not n4(n.k)then
e.nf=nn(e,n)
e:Y"tL"
return
end
end
local n=oY(e)
if n then
local f=n.a==e.eI.a and e.eI or e.eq
local t=m("u,@,O,@,e1,@,r,@",u,f,nn(e,f),function(...)
nL(f,...)
end)
t.e=t.O.a
t.i=t.e1.a
n.am(t)
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
for t in all{n.eI,n.eq}do
if t.a.D<=0then
if t.a.T~=1then
return nX(t,"|has|fainted",function(_ENV)
e.W.T=1
end)
elseif t~=n.s then
return nF(t,n4(t.k))
end
end
end
for e in all{n.s,nn(n,n.s)}do
local t=nn(n,e)
while#e.eF>0do
local n=deli(e.eF,1)
if n.a.T~=1and(n.a==e.a or n.a==t.a)then
return n
end
end
if e.a.D<=0and e.a.T==1then
return nF(e,n4(e.k))
end
if not e.f6 then
e.f6=true
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
return#n9(_ENV,true)==0
end,function(t,f)
local n={}
foreach(t.w,function(e)
if e.d>0and(f or e.e7>0and t.eR~=e.en)then
add(n,e)
n[e]=true
end
end)
return n
end,function(_ENV)
if e0~=0then
return{g}
else
return n9(_ENV)
end
end,function(e,n)
return(eJ[e.eG][n.eO]or 1)*(eJ[e.eG][n.ep]or 1)
end,function(n,t,e)
local a,f=n:eb"er",t:eb"er"
if e.eG%2==1then
a,f=n:eb"R",t:eb"q"
if t.ac then
f*=2
end
elseif t.au then
f*=2
end
local o=1024
if nH(e.d,"107,164,57,157 ")then o*=.3end
if al then o*=.3end
local d=rnd"1"<min(.99,(n.ti+76)/o)and e.d>0and 2or 1
local o=mid(
3,997,
(100*d/5+2)/50
*e.tm
*mid(10,.2,a/f)
)+2
local a,f=o,ta(e,t)
*((e.eG==n.eO or e.eG==n.ep)and 1.5or 1)
*(rnd".15"+.85)
if f>0then
return max(1,a*f\1),d>1
end
return 0,false
end,function(_ENV)
s=_ENV[fw]
do local _ENV=s.a
nA,tQ=0,false
end
s.f6=false
if s.aT then
local e=fs(s.a)
nK(s,e[b(#e)+1]or B(0))
_ENV:Y()
elseif#s.eF>0then
_ENV:Y()
else
fp.o,
fI.o,
tv.o,
ez,
eC[#eC]=s.fk,
s.as,
s.a1,
nX(s,"|begins|turn"),
ek
_ENV:Y"aa"
end
end)
F(eo,"f3,@,at,@,fy,@,fL,@,a0,@,av,@,ah,@,f8,@,aP,@",function(_ENV)
if e8 then
_ENV:eP"fp"
K"155"
end
if eQ then eL()end
end,function(_ENV)
_ENV:H()
nf=_ENV:nn(s)
_ENV:Y"tL"
end,function(_ENV,e,t)
e.tC,t.tC="eI","eq"
for n in all{e,t}do
_ENV[n.tC]=m("eF,#,eA,1,fk,@,as,@,a1,@,k,@,n,@,aT,@,an,@",J(Q),
J(Q),
J(nw,3),
unpack(n))
local e=_ENV[n.tC]
e.fk.n1=function()
_ENV:H()
_ENV:Y"a_"
end
add(e.eF,nF(e,n4(e.k)))
end
_ENV:eP"f5"
end,function(_ENV,e,t,f,o)
local n={}
for t=1,#e do
nW(n,t,e[t])
end
fy(_ENV,
{_ENV:ej"j","player",false,f},
{n,t,true,o}
)
end,function(e)
f8(peek2(e),
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
function f7(f)
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
local t=f7(e)
n+=t
until t<(1<<e)-1
return n
end
local i,d,f,e,o,c,u,n,t=n_"1",n_"0",n_"1",{},{},0,0,0
for n=1,n_"1"do add(e,f7(f))end
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
e:t2()
end)
eo.tr=m"-1;,none,~f;0;,struggle,~n3;;,megapnch,~f;;,razrwind,~nc;;,sworddnc,~z,~v,R,2;;,whrlwind,~tk;;,megakick,~f;;,toxic,~fU;;,horndril,~nS;;,bodyslam,~f,30,~X,4;;,takedown,~n3;;,doubedge,~n3;;,bublbeam,~f,10,~E,~v,M,-1;;,watergun,~f;;,icebeam,~f,10,~X,3;;,blizzard,~f,10,~X,3;;,hyprbeam,~of;;,payday,~f;;,submsion,~n3;;,counter,~o_;;,seistoss,~ea,50;;,rage,~fZ;;,megdrain,~ng;;,solrbeam,~nc;;,drgnrage,~ea,40;;,thndrblt,~f,10,~X,4;;,thunder,~f,10,~X,4;;,earthqke,~f;;,fissure,~nS;;,dig,~nm,|begins|digging;;,psychic,~f,30,~E,~v,er,-1;;,teleport,~fS;;,mimic,~fJ;;,doubteam,~z,~v,e2,1;;,reflect,~z,~e4,|raises|defense,ac;;,bide,~oe;;,metrnome,~fQ;;,selfdstr,~f;;,eggbomb,~f;;,fireblst,~f,30,~X,2;;,swift,~f;;,skulbash,~nc;;,softboil,~t6;;,dreameat,~od;;,skyattck,~nc;;,rest,~oo;;,thndrwav,~X,4;;,psywave,~on;;,explsion,~f;;,rockslid,~f;;,triattck,~f;;,substute,~fY;;,cut,~f;;,fly,~nm,|begins|flying;;,surf,~f;;,strength,~f;;,flash,~E,~v,A,-1;;,pound,~f;;,karatchp,~f;;,doubslap,~ey;;,comtpnch,~ey;;,firepnch,~f,10,~X,2;;,icepnch,~f,10,~X,3;;,thndpnch,~f,10,~X,4;;,scratch,~f;;,vicegrip,~f;;,guilotin,~nS;;,gust,~f;;,wingatck,~f;;,bind,~nr;;,slam,~f;;,vinewhip,~f;;,stomp,~f,30,~E,~ex;;,doubkick,~nu,2,~L;;,jumpkick,~f;;,rllngkck,~f,30,~E,~ex;;,sandatck,~E,~v,A,-1;;,headbutt,~f,30,~E,~ex;;,hornatck,~f;;,furyatck,~ey;;,tackle,~f;;,wrap,~nr;;,thrash,~t9;;,tailwhip,~E,~v,q,-1;;,psnsting,~f,20,~X,5;;,twineedl,~oa;;,pinmisil,~ey;;,leer,~E,~v,q,-1;;,bite,~f,10,~E,~ex;;,growl,~E,~v,R,-1;;,roar,~tk;;,sing,~X,6;;,sprsonic,~E,~ni;;,sonicbom,~ea,20;;,disable,~fH;;,acid,~f,10,~E,~v,q,-1;;,ember,~f,10,~X,2;;,flamthwr,~f,10,~X,2;;,mist,~z,~e4,|stat lower|immunity,os;;,hydropmp,~f;;,psybeam,~f,10,~E,~ni;;,aurorabm,~f,10,~E,~v,R,-1;;,peck,~f;;,drillpck,~f;;,lowkick,~f,30,~E,~ex;;,absorb,~ng;;,leechsed,~E,~e4,|is now|seeded,ar,1,~es;;,growth,~z,~v,er,1;;,razrleaf,~f;;,psnpowdr,~X,5;;,stunspor,~X,4;;,slppowdr,~X,6;;,petldanc,~t9;;,strngsht,~E,~v,M,-1;;,firespin,~nr;;,thndshck,~f,10,~X,4;;,rockthrw,~f;;,cnfusion,~f,10,~E,~ni;;,hypnosis,~X,6;;,meditate,~z,~v,R,1;;,agility,~z,~v,M,2;;,quickatk,~f;;,ngtshade,~ea,50;;,screech,~E,~v,q,-2;;,recover,~t6;;,harden,~z,~v,q,1;;,minimize,~fW;;,smokscrn,~E,~v,A,-1;;,cnfusray,~E,~ni;;,withdraw,~z,~v,q,1;;,dfnscurl,~z,~v,q,1;;,barrier,~z,~v,q,2;;,lghtscrn,~z,~e4,|raises|spcdefense,au;;,haze,~fN;;,fcsenrgy,~z,~e4,|raises|crit ratio,al;;,mirrmove,~fR;;,lick,~f,30,~X,4;;,smog,~f,30,~X,5;;,sludge,~f,30,~X,5;;,boneclub,~f,10,~E,~ex;;,watrfall,~f;;,clamp,~nr;;,spikcann,~ey;;,constrct,~f,10,~E,~v,M,-1;;,amnesia,~z,~v,er,2;;,kinesis,~E,~v,A,-1;;,hijmpkck,~f;;,glare,~X,4;;,poisngas,~X,5;;,barrage,~ey;;,leechlif,~ng;;,lovekiss,~X,6;;,tranform,~fK;;,bubble,~f,10,~E,~v,M,-1;;,dizypnch,~f;;,spore,~X,6;;,splash,~fV;;,acidarmr,~z,~v,q,2;;,crabhamr,~f;;,furyswps,~ey;;,bonerang,~nu,2,~L;;,hyprfang,~f,10,~E,~ex;;,sharpen,~z,~v,R,1;;,convrson,~fM;;,suprfang,~ot;;,slash,~f"
tY=m"0,0x5e00,1,0x5e1e,2,0x5e3c"
fx=16
function _init()
local _ENV=eo
memset(0x8000,0,0x7fff)
no=tp"ek,aE,l,~aP,eD,4;tF;eT,eB,eD,4,eH,~x,nN,~x,t2,~L,ed,~L,eh,~L,ec,~L,h,~L,P,~L,ef,;aE;next,f4,ei,.5,eh,~ev;f4;next,eB,ei,.5,eh,~ev;fb;eT,eB,next,eB,ei,.5,eH,159,eh,~ev;eB;eT,eB,next,tG,t2,~oH,eh,~ev,ed,~oJ;tG;eT,tG,next,aX,ei,.2,eh,~ev;aX;eT,nQ,next,aL,eD,3,ei,.2,eH,155,eh,~ev;aL;eT,nQ,next,aO,eD,2,ei,.2,eH,154,eh,~ev;aO;eT,nQ,next,aG,eD,1,ei,.2,eH,153,eh,~ev;aG;eT,nQ,next,tO,eD,0,eH,152,t2,~oz,eh,~ev,ed,~oq,ec,~oA,h,~oB,P,~oD;tO;eT,tO,next,eB,ei,.25,eh,~ev,ed,~L;"
ev(no)
flip()
C(function(e,n)
K(e)
a0(n)
end,";,155,0x0;;,154,0x2;;,153,0x4")
K"154"
C(poke,";,0x5f5c,8;;,0x5f5d,2;;,0x5f56,0xe0")
f8(peek2"0x6",mget,mset)
oc()
oi()
local e=peek2"0xc"
for t,f in pairs(nR)do
local n={n=f}
for t=1,6do
add(n,peek(e))
e+=1
end
nR[t]=n
end
C(memcpy,";,0x0000,0xc000,0x2000")
end
function _update60()
local _ENV=eo
eQ,e8,te,nZ=btnp"4",btnp"5",btnp"0"and btnp"1"and 0or btnp"0"and-1or btnp"1"and 1or 0,btnp"2"and btnp"3"and 0or btnp"2"and-1or btnp"3"and 1or 0
if@0x5eff==1then
eQ,e8=e8,eQ
end
no:t3()
end
function _draw()
local _ENV=eo
no:eh()
end