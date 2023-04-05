eT=setmetatable({},{__index=_ENV})
_ENV=eT
function nO(e,n,t)
if ord(e)==126then return n[sub(e,2)]
elseif e=="@"then return deli(t,1)
elseif e=="#"then return{}end
return e~=""and e or nil
end
function F(o,n,...)
local f,t,e={...},split(n,";"),o
foreach(t,function(n)
local t=split(n)
if#t>1then
if t[1]==""then
foreach(t,function(n)
add(e,nO(n,o,f))
end)
else
for n=1,#t,2do
e[t[n]]=nO(t[n+1],o,f)
end
end
e=o
else
if n==""then n=#e+1end
if type(e[n])~="table"then
e[n]={}
end
e=e[n]
end
end)
return o
end
function m(...)
return F(setmetatable({},{__index=eT}),...)
end
F(eT,"eL,@,z,@,ok,@,v,@",true,false,"",function(...)return...end)
F(eT,"m,@,F,@,nO,@,t2,@,tp,@,es,@,tw,@,t5,@,nG,@,N,@,eh,@,eP,@,b,@,p,@,nI,@,eg,@,eE,@,U,@,o8,@,t3,@,tg,@,eF,@,tb,@,nf,@,n_,@,nQ,@,eo,@,nC,@,H,@,o7,@,o9,@,oj,@,oz,@,oq,@,oA,@,Q,@,n2,@,t4,@,eb,@,oB,@,tx,@,oD,@,oF,@,oH,@,oJ,@,np,@,ty,@,oK,@,oM,@,t6,@,oN,@,tk,@,x,@,h,@,s,@,oQ,@,oR,@,t8,@,P,@,e4,@,ex,@,na,@,oS,@,oU,@,oV,@,oW,@,oY,@,t7,@,nd,@,ni,@,nr,@,oZ,@,t9,@,fe,@,fn,@,nm,@,ey,@,ft,@,nw,@,o,@,n5,@,fo,@,nR,@,tj,@,tz,@,ef,@,eH,@,nc,@,tq,@,ff,@,n3,@,tA,@,nS,@,nU,@,ng,@,f_,@,nV,@,nl,@,e6,@,fa,@",m,F,nO,function(e)
return F(m"nb,0,tB,0,tD,~eL,E,~v,e_,~v,eC,#;",e)
end,function(_ENV,e)
if e==ek then
return ea and nb/ea or 0
end
if _ENV[e]and _ENV[e].fd then
return 1
end
return 0
end,function(_ENV,e)
n4=e or next
end,function(_ENV,e)
nb,n4,tD,next,ea=0
_ENV[ek].fd=true
for e,n in pairs(tF)do _ENV[e]=n end
for n,t in pairs(_ENV[e])do _ENV[n]=t end
ek=e
_ENV:E()
tB=#eC
end,function(_ENV)
nb+=1/60
if tD then _ENV:tw(ek)end
if ea and nb>=ea then
_ENV:es()
end
while n4 do
_ENV:tw(n4)
end
_ENV:e_()
end,function(_ENV,e)
while n4~=e and#eC>0do
_ENV:N()
end
end,function(_ENV)
deli(eC)
_ENV:es(eC[#eC]or"eJ")
end,function(_ENV,e)
add(eC,e)
_ENV:es(e)
end,function()
J"153"
end,function(e)
return flr(rnd(e))
end,function(e,n,...)
foreach(m(n,...),function(n)
e(unpack(n))
end)
end,function(t,o,f)
local e,n=%0x5f28,%0x5f2a
camera(e-t,n-o)
f()
camera(e,n)
end,function(e)
eK(e or"",23,4,1,0)
end,function(e)
p(rectfill,";,0,0,45,6,1")
p(eK,";,@,23,1,13,0;;,@,23,8,1,0;;,@,23,15,1,0",unpack(split(e,"|",false)))
end,m"",split"missingno,bulbasaur,ivysaur,venusaur,charmander,charmeleon,charizard,squirtle,wartortle,blastoise,caterpie,metapod,butterfree,weedle,kakuna,beedrill,pidgey,pidgeotto,pidgeot,rattata,raticate,spearow,fearow,ekans,arbok,pikachu,raichu,sandshrew,sandslash,nidoran f,nidorina,nidoqueen,nidoran m,nidorino,nidoking,clefairy,clefable,vulpix,ninetales,jigglypuff,wigglytuff,zubat,golbat,oddish,gloom,vileplume,paras,parasect,venonat,venomoth,diglett,dugtrio,meowth,persian,psyduck,golduck,mankey,primeape,growlithe,arcanine,poliwag,poliwhirl,poliwrath,abra,kadabra,alakazam,machop,machoke,machamp,bellsprout,weepinbell,victreebel,tentacool,tentacruel,geodude,graveler,golem,ponyta,rapidash,slowpoke,slowbro,magnemite,magneton,farfetchd,doduo,dodrio,seel,dewgong,grimer,muk,shellder,cloyster,gastly,haunter,gengar,onix,drowzee,hypno,krabby,kingler,voltorb,electrode,exeggcute,exeggutor,cubone,marowak,hitmonlee,hitmonchan,lickitung,koffing,weezing,rhyhorn,rhydon,chansey,tangela,kangaskhan,horsea,seadra,goldeen,seaking,staryu,starmie,mr mime,scyther,jynx,electabuzz,magmar,pinsir,tauros,magikarp,gyarados,lapras,ditto,eevee,vaporeon,jolteon,flareon,porygon,omanyte,omastar,kabuto,kabutops,aerodactyl,snorlax,articuno,zapdos,moltres,dratini,dragonair,dragonite,mewtwo,mew",m"0,none;,fainted,burned,frozen,paralyzed,poisoned,sleeping",m"0, ;,FNT,BRN,FZN,PAR,PSN,SLP",m"0;c,2,n,~ok;1;c,2,n,normal,15,0,13,.5;2;c,10,n,fire,8,2,10,2,11,2,2,.5,4,.5,13,.5,14,.5;3;c,7,n,fighting,10,2,1,2,13,2,15,0,11,.5,9,.5,5,.5,12,.5;4;c,9,n,water,2,2,7,2,13,2,14,.5,8,.5,4,.5;5;c,6,n,poison,11,2,8,2,15,.5,7,.5,5,.5,13,.5;6;c,11,n,electric,9,2,4,2,7,0,14,.5,6,.5,8,.5;7;c,7,n,ground,6,2,2,2,5,2,13,2,9,0,11,.5,8,.5;8;c,8,n,grass,7,2,13,2,4,2,11,.5,14,.5,2,.5,9,.5,8,.5,5,.5;9;c,2,n,flying,11,2,3,2,8,2,6,.5,13,.5;10;c,9,n,ice,14,2,9,2,8,2,2,.5,10,.5,4,.5;11;c,8,n,bug,8,2,12,2,3,.5,2,.5,9,.5,15,.5,5,.5;12;c,6,n,psychic,3,2,5,2,12,.5;13;c,2,n,rock,11,2,2,2,9,2,10,2,3,.5,7,.5;14;c,2,n,dragon,14,2;15;c,6,n,ghost,15,2,1,0,12,2;17;c,2,n,bird;",m"V,hp,ed,spc,R,att,q,def,K,spd,nx,tot,A,acc,e2,eva",m";c,13,ei,5,nu,1;;c,6,ei,13,nu,13;;c,5,ei,5,nu,1;;c,6,ei,5,nu,5;;c,1,ei,5,nu,13;;c,14,ei,4;;c,9,ei,4;;c,11,ei,3;;c,12,ei,5;;c,8,ei,2;;c,10,ei,4",m"",split"youngstr,bugcatch,junior,brock,lass,hiker,swimmer,misty,gentlman,sailor,rocker,ltsurge,channelr,gambler,beauty,erika,biker,birdkeep,juggler,koga,blckbelt,rocket,psychic,sabrina,scientst,pkmaniac,suprnerd,blaine,cooltrnr,fishrman,tamer,giovanni,lorelei,bruno,agatha,lance,blue,green,red,legendry",function(e,n)
if n.Y then
e:eh(n.Y)
else
e:N()
end
end,function(e,n)
return m("fi,@,tH,@,S,~tH,y,1,e_,~oz,er,~oA,eM,~o9,M,~o7",e,n or 0)
end,function(e,n)
return F(nC(e),"C,0,y,@,e_,~oq,nW,~oj",n or 1)
end,function(e,n,o)
while deli(e)do end
for t=1,#n do
add(e,(o or v)(n[t],t))
end
end,function(e)
e:N()
J"154"
end,function(e,n,t)
if t then
local t=e.C+n*e.y
if t==mid(0,t,#e-1)then
e.C=t
if 0+n~=0then J"154"end
else
eP()
end
else
local t=e.C+n
local o=e.C-e.C%e.y
if t==mid(o,t,o+e.y-1)then
e.C=t
if 0+n~=0then J"154"end
else
eP()
end
end
e.C=mid(0,e.C,#e-1)
if e.C\e.y<e.S then e.S=e.C\e.y end
if e.C\e.y>e.S+2then e.S=e.C\e.y-2end
e.S=mid(0,e.S,(#e-1)\e.y)
end,function(n)
local e=n.f
if nT then e.eM(n)end
if eN then n:ny()end
e.S+=nY
if nZ~=0then n:tJ(nZ)end
local n=e.S
e.S=mid(e.tH,e.S,#e-3)
if e.S~=n then
eP()
elseif nY~=0then
J"154"
end
end,function(t)
local e=t.f
e:nW"0"
e:nW(nY,true)
e:nW(nZ)
if eN then
local n=e[e.C+1]
if n.em then
eP()
printh"me"
elseif n.I then
J"155"
printh"test"
n.I(t,n)
end
printh"end"
end
if nT then e.eM(t)end
end,function(n)
local e=n.f
local o=e.y>1and 10or 40
local a=20-(e.y*o)/2
p(rectfill,";,0,0,39,39,1;;,0,@,39,@,13",5-e.S*10,4+(max(ceil(#e/e.y),3)-e.S)*10)
for n=-1,e.y*5-1do
local d=(e.S-1)*e.y+n+1
local t=e[d]
if t then
local f,i,r=t.n6 or 1,a+n%e.y*10,n\e.y*10
if t.em then f=3end
if d-1==e.C then f+=1end
if not t.te then
rectfill(i,r-5,i+o-1,r+4,nf[f].c)
nI(n%e.y*o+a+o/2,n\e.y*10-3,function()
e.fi(t,nf[f])
end)
end
end
end
end,function(e,n)
if e.Z then
local n=nf[eF[e.Z.eO].c]
p(rectfill,";,-20,-2,19,17,@;;,-20,14,19,17,@",n.c,n.ei)
e.Z:nk(0,8,n,1,1)
else
tK(e.n,0,0,n.nu)
end
end,function(e,n)
e.Z:nk(0,3,n,.375,.375)
end,function(n)
local e=nU(n.k)
del(e,n.a.W)
if#e>0then
return e[b(#e)+1]
end
end,function(n,e)
local t=n.ns[e]
return ceil(mid(1,999,
(e=="R"and n.u==2and.5or e=="K"and n.u==4and.25or 1)*
n[e]*(
(e=="e2"or e=="A")
and mid(1,1+t/3,3)/mid(1,1-t/3,3)
or mid(2,2+t,8)/mid(2,2-t,8)
)
))
end,function(_ENV)
if i.tn>0then return true end
local e=n8(i)
if#e==0then return true end
i.tn,i.eQ=b"6"+2,e[b(#e)+1].ee
r(ec,"|"..i.w[i.eQ].n.."|disabled")
if i.g and i.g.ee==i.eQ then
i.e1=0
end
end,function(_ENV,t,n)
local e=B(t,n)
e.e8,e.tM=5,5
w[n]=e
return e
end,function(_ENV)
local n=n8(i,true)
r(G,"|copies|"..tx(e,n[b(#n)+1].d,l.ee).n)
end,function(_ENV)
if e.fr then
return true
else
r(G,"|copies|"..i.n,function()
e.fr=true
foreach(split"d,R,q,K,ed,eO,ep",function(n)
e[n]=i[n]
end)
e.w={}
foreach(i.w,function(n)
tx(e,n.d,n.ee)
end)
end)
end
end,function(_ENV)
F(e,"eO,@,ep,@",i.eO,i.ep)
r(G,"|copies|types")
end,function(_ENV)
foreach({ec,G},function(e)
F(e.a.ns,"ed,0,R,0,q,0,K,0,A,0,e2,0")
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
return np(_ENV,G,e.V\2)
end,function(_ENV)
tt(G,B(b(164)+1,l.ee))
end,function(_ENV)
if e.to>0then
tt(G,B(e.to,l.ee))
else
return true
end
end,function(_ENV)
local e=t4(ec)
if e then
tf(ec,e)
else
return true
end
end,function(_ENV)
local e=t4(G)
if e then
tf(G,e)
else
return true
end
end,function(e,n)
return(sgn(e)>0and"|+"or"|-")..abs(e).." "..n.."|change"
end,function(_ENV,e,...)return e(_ENV,G,...)end,function(_ENV,e,...)return e(_ENV,ec,...)end,function(_ENV,e,n,t)
local o=e.a.ns[n]
if not e.a.fm or t>0then
e.a.ns[n]=mid(-6,6,o+t)
end
if o~=e.a.ns[n]then
r(e,tk(t,tb[n]))
else
return true
end
end,function(_ENV)
if P(_ENV,5)and i.u~=5then
return true
end
return h(_ENV,e4,"|badly|poisoned","n7",1)
end,function(_ENV)
r(G,"|does|nothing")
end,function(_ENV)
return t_(l,i)>0and l.eG~=i.eO and l.eG~=i.ep
end,function(_ENV,n)
if i.W.u==3and n==2then
r(G,"|thawed|out")
e.W.u=0
elseif t8(_ENV)and i.W.u==0then
r(ec,"|is now|"..t3[n],function()
i.W.u=n
t9(i)
end)
else
return true
end
end,function(_ENV,e,t,n,o)
if(e.a[n]or 0)==0and(e~=ec or t8(_ENV))then
e.a[n]=o or 1
r(e,t)
else
return true
end
end,function(_ENV,e)
e.a.tN=true
end,function(_ENV,e)
return e4(_ENV,e,"|becomes|confused","n9",b"4"+1)
end,function(_ENV)
local n=e.V\4
if n>=e.D or e.ew>0then
return true
end
eH(_ENV,n)
r(G,"|created|substitute",function()
e.ew=n
end)
end,function(_ENV)
e7(e,-1,l)
o(_ENV)
if l.e8<=0then
e.e1,e.g=0
end
end,function(_ENV)
if not e.g then
e7(e,b"2"+1,B(l.d,l.ee))
r(G,"|"..l.n.."|begins")
e.nj=0
end
if e.e1==0then
if e.nj==0then
return true
end
ef(_ENV,e.nj*2)
end
end,function(_ENV)
ef(_ENV,1+b"75")
end,function(_ENV)
ef(_ENV,max(i.D\2,1))
end,function(_ENV)
e7(e,b"2"+1,B(l.d,l.ee))
o(_ENV)
if e.e1==0then
x(_ENV,na,"n9")
end
end,function(_ENV)
if not e.g then
e7(e,b"4"+1,B(l.d,l.ee))
e.n1=i
end
if e.n1==i then
o(_ENV)
else
return true
end
end,function(_ENV,n)
if e.g then
o(_ENV)
else
r(G,n,function()
e7(e,1,B(l.d,l.ee))
end)
end
end,function(_ENV)
if e.g then
o(_ENV)
else
r(G,"|charges|energy")
e7(e,1,l)
l.e8+=1
end
end,function(_ENV)
if e.g then
r(G,"|recharges|energy")
else
o(_ENV)
local n=B(l.d,l.ee)
n.A=0
e7(e,1,n)
end
end,function(_ENV)
tQ=b"3"+2
end,function(_ENV)
e.W.u=6
t9(e)
r(G,"|is|sleeping")
np(_ENV,G,e.V)
end,function(_ENV)
if e.nz>0then
ef(_ENV,e.nz*2)
else
return true
end
end,function(_ENV,e,n,t)
if e>0then
r(G,t and"|resumes|"..l.n,function()
_ENV.i=ec.a
o(_ENV,100,function()
nm(_ENV,e-1,n,true)
end)
end)
else
n()
end
end,function(_ENV,e)
nm(_ENV,2+b"4",v)
end,function(_ENV)
nm(_ENV,2,function()
if rnd"100"<20then
P(_ENV,5)
end
end)
end,function(_ENV)
ef(_ENV,false,function(e)
eH(_ENV,max(1,e\4))
end)
end,function(_ENV,e,n,...)
local t={...}
ef(_ENV,false,function()
if rnd"100"<(e or 0)then
n(_ENV,unpack(t))
end
end)
end,function(_ENV)
ef(_ENV,false,function(e)
np(_ENV,G,max(e\2,1))
end)
end,function(_ENV)
if i.u==6then
n5(_ENV)
else
return true
end
end,function(_ENV)
if e.K>=i.K then
ef(_ENV,i.D)
else
return true
end
end,function(_ENV,n,t,a,e)
local o=tk(t,"hp")
local f=e and n.a.ew+t<0
if not e or f then
r(n,o,v,e)
end
r(n,
f and"|substitute|broke"or o,
a,
e
)
end,function(_ENV,t,n,a,o)
local e=t.a
local f=not a and e.ew>0
tj(_ENV,t,-n,function()
e.nj+=n
if e.g and e.g.d==20then
s(_ENV,t,"R",1)
end
if o then o(n)end
if f then
e.ew=max(e.ew-n,0)
else
e.W.D=max(e.W.D-n,0)
end
end,f and"substitute")
end,function(_ENV,n,f)
local o,t=false,t_(l,i)
if not n then
n,o=tR(e,i,l)
end
if t>0then
if l.eG%2==1then
i.nz+=n
end
if t>1then r(G,"|super|effective")
elseif t<1then r(G,"|not very|effective")end
if o then r(G,"|critical|hit")end
tz(_ENV,ec,n,false,f)
else
r(ec,"|resisted|attack")
end
end,function(_ENV,e)
tz(_ENV,G,e,true,v)
end,function(e)
return ceil(e+.5*93)+5
end,function()
return m("en,~eL,R,0,q,0,ed,0,K,0,V,0,D,0,nx,0,A,100,e2,100,tS,0,tU,0,tV,0,ta,0,tW,0,d,-1,fc,-1,n, ,eO,0,ep,0,eR,#,eS,#,nq,#,w,@",nA())
end,function()
local e=peek2"0xa"
U[-1]=tq()
for t=0,151do
local n,o={},false
while@e~=255do
if@e==254then
o=true
elseif o then
for t=n[#n]+1,@e do
add(n,t)
end
o=false
else
add(n,@e)
end
e+=1
end
e+=1
local o=t-deli(n,1)
local e=tq()
F(e,"d,@,fc,@,n,@,eO,@,ep,@,tS,@,tU,@,tV,@,ta,@,tW,@",t,
o,
o8[t+1],
unpack(n)
)
local f=e.eR
for o=8,#n do
local t=n[o]
if t==253then
f=e.eS
elseif t==252then
f=e.nq
else
add(f,t)
end
end
if o<t then
foreach(split"eR,eS,nq",function(n)
foreach(U[o][n],function(t)
add(e[n],t)
end)
end)
end
local n,o={},{}
foreach(e.eS,function(e)n[e]=true end)
for e=1,54do
if n[e]then add(o,e)end
end
e.eS=o
do local _ENV=e
F(_ENV,"R,@,q,@,ed,@,K,@,V,@,D,~V",nc(tU),
nc(tV),
nc(tW),
nc(ta),
nc(tS)+55
)
nx=R+q+ed+K+V
end
U[t]=e
end
end,function(e,n)
return setmetatable(m("w,@,u,0,en,~z",n),{__index=U[e]})
end,function(e)
foreach(nS(e.k),function(e)
poke(0x5e5a+e.d,1)
end)
end,function(e)
local n={}
foreach(e,function(e)
if e.d>-1and e.u==1then
add(n,e)
end
end)
return n
end,function(e,t)
local n={}
foreach(e,function(e)
if e.d>(t and 0or-1)and e.u~=1then
add(n,e)
end
end)
return n
end,function(e)
return nU(e)[1]
end,function(e)
local n=e:e9"j"
n[e:X"el"+1]=n3(-1,nA())
e6(e:X"j",n)
e:N()
end,function(e,f,n)
local t,o=U[n],nA()
for e=1,min(4,#t.eR)do
o[e]=B(t.eR[e],e)
end
e[f]=n3(n,o)
return e
end,function(e)
local a=tY[e]
local e=m""
for t=1,6do
local o,n,f=a+(t-1)*5,{},false
for e=1,4do
n[e]=B(peek(o+e),e)
if n[e].d>0then
f=true
else
n[e]=B(-1)
end
end
e[t]=n3(f and@o or-1,n)
end
return e
end,function(e,f)
local n=tY[e]
memset(n,0,30)
for t=1,6do
local o,e=n+(t-1)*5,f[t]
poke(o,max(0,e.d))
for n=1,4do
poke(o+n,e.w[n].d>0and e.w[n].d or 0)
end
end
end,function()
local e=peek2"0x8"
for n=-1,164do
local o,f,a,d,i=peek(e+0),peek(e+1)*5-5,peek(e+2)*5-5,peek(e+3)*5-5,deli(td[n],1)
local t=deli(td[n],1)
n_[n]=m("fl,@,d,@,n,@,eG,@,e8,@,tM,~e8,ti,@,A,@,eU,@",function(e)
return t(e,unpack(td[n]))
end,n,i,o,f,a,d,t)
e+=4
end
end)
F(eT,"B,@,nA,@,tr,@,fu,@,tm,@,tc,@,tl,@,eV,@,fT,@,fs,@,tZ,@,nB,@,tu,@,n0,@,tT,@,oe,@,on,@,f1,@,f0,@,eW,@,fv,@,fh,@,fP,@,fE,@,ot,@,fX,@,fL,@,oo,@,fO,@,fG,@,fI,@,fC,@,f2,@,of,@,fp,@,fw,@,f5,@,f3,@,fg,@,nv,@,aG,@,fb,@,f4,@,fx,@,fy,@,f6,@,fk,@,f8,@,f7,@,f9,@,fj,@,fz,@,fq,@,fA,@,fB,@,o_,@,X,@,e5,@,fD,@,oa,@,fF,@,od,@,J,@,e0,@,oi,@,tK,@,eK,@,eY,@,fH,@,om,@,ts,@,nk,@,fJ,@,fK,@,fM,@,oc,@,fN,@,fQ,@,e9,@,nh,@,nD,@,nF,@,tf,@,tt,@,e7,@,fR,@,nH,@,fS,@,nJ,@,eZ,@,nP,@,nE,@,fU,@,fV,@,ol,@,ou,@,n8,@,oT,@,fW,@,fY,@",function(e,n)
return setmetatable(m("ee,@",n or 0),{__index=n_[e]})
end,function()
local e={}
for n=1,4do add(e,B(-1))end
return e
end,function(e)
o_(e)
tK("team #"..e:X"j"+1,20,27,1)
end,function(_ENV)
local t,e,n=ej.a,eI.a,ez.a
local f,a=e==t,n==t
local t,o=11,11
p(rectfill,";,0,0,39,6,5;;,0,33,39,39,5")
p(rectfill,";,-1,33,@,41,1;;,-1,-2,@,6,1",max(ceil(e.D/e.V*40),0)-1,
max(ceil(n.D/n.V*40),0)-1)
p(rectfill,";,15,6,39,6,13;;,16,5,39,5,13;;,0,33,24,33,13;;,0,34,23,34,13")
p(eK,";,@,40,34,13,1;;,@,40,27,1,1;;,@,2,1,13,-1;;,@,2,7,1,-1",e.D,tg[e.u],n.D,tg[n.u])
local t,o=1,1
e:nk(10,25,nf[4],t,t,f)
n:nk(30,15,nf[4],-o,o,a)
end,function(e)fH(U[e:X"en"])end,function(e)eg("spot #"..(e:X"el"+1))end,function(e)eg("move #"..(e:X"eX"+1))end,function(e)eg(e.ne)end,function(e)eg"match over"end,function(n)
local e=n:e5"nK"
eg(e and e.fZ)
end,function()
rectfill(0,0,46,13,13)
pal(7,1)
local e=0
for o,n in ipairs(split"6,5,5,6,6,5,6")do
sspr(6*8+e,6*8,n,8,e+3,3.5+cos((t()+o)/4))
e+=n
end
pal()
end,function(e)eg(e.ej.ae.n)end,function(e)
om(e:nh())
end,function(n)
local e=n:e5(n.os).l
if e.d>=0then
eE(eF[e.eG].n.."|"..e.e8.."/"..e.tM.."|"..(e.ti>=0and e.ti or"??").."P "..(e.A>=0and e.A or"??").."A")
else
eE"none|n/a|"
end
end,function(e)
om(e:e5"en".Z)
end,function(e)eE(e:e5"eJ".e3)end,function(_ENV)
if d>-1then
eE(n.."|"..D.."/"..V.."|"..t3[u])
else
eE"none|n/a|"
end
end,function(_ENV)on(_ENV:e5"t1".Z)end,function(_ENV)on(T.a)end,function(e)
local n,t=0,0
foreach(e:e5().k,function(e)
if e>-1then
n+=U[e].nx
t+=1
end
end)
eE(e:e5().n.."|len "..t.."/6|pow "..n)
end,function(e)
eE(e.nn.n.."|is the|winner")
end,function(e)
eE(e.ej.n..e.ej.o1)
end,function(_ENV)
local n=eZ(_ENV,nn)
nn:an(n)
f:M{}
f.eM=function(e)
e:nG"t0"
end
for e in all{nn,n}do
F(f,"S,0;;Z,@;;te,~eL;;n,@,n6,5;;n,@;;n,@",e.a.W,e.n,(#nU(e.k,true)).." live",(#nS(e.k)).." dead")
end
end,function(_ENV)
local e=0
for n=0,151do e+=U[n]:eY()and 1or 0end
f:M(
m(";n,browse,Y,en,I,~eo,e3,@;;n,edit,Y,j,I,~eo,e3,edit|stored|teams;;n,league,Y,o0,I,~eo,e3,@;;n,player,Y,tv,I,~eo,e3,player|custom|battles;;n,horde,Y,ov,I,~eo,e3,@;;n,credits,Y,oh,I,~eo,e3,credits|amorg|games","browse|"..e.."/151|pokemon","league|"..(@0x5efd).."/40|trainers","horde|"..(@0x5efe).."/151|hi-score")
)
end,function(_ENV,n)
local e={}
for n=0,151do
add(e,n)
end
f:M(
e,
function(e)
return m("I,@,em,@,Z,@",n,not U[e]:eY(),U[e])
end
)
end,function(_ENV)
ot(_ENV,function(_ENV)
_ENV:eh"oP"
end)
end,function(_ENV)
ot(_ENV,function(_ENV)
e6(_ENV:X"j",nV(_ENV:e9"j",_ENV:X"el"+1,_ENV:X"en"))
_ENV:N()
end)
end,function(_ENV)
local e=_ENV:e5"en".Z
f:M{}
F(f,";Z,@;;te,~eL;;n,lvl 50,n6,5",e)
foreach(split"V,ed,R,q,K,nx",function(n)
add(f,{n=tb[n].." "..e[n]})
end)
p(function(t,n)
if#U[e.d][n]>0then
add(f,{n=t,n6=5})
foreach(U[e.d][n],function(e)
add(f,{n=n_[e].n})
end)
end
end,";,learn,eR;;,teach,eS;;,event,nq")
end,function(_ENV)
f:M(
split"106,,#alanxoc3,code+sfx,design,6,,#gr8cadet,graphics,playtest,129,,#wadlo,magikarp,playtest,145,,#zep,pico-8,px9 func,137,,#pkmndata,blbpedia,pokeapi,serebii,smogon,upokcntr,volvox,nintendo",
function(e)
if type(e)=="number"then
return{Z=n3(e,nA())}
end
local n=1
if sub(e,1,1)=="#"then
e,n=sub(e,2),5
end
return{n=e,n6=n,te=e==""}
end
)
end,function(_ENV)
f:M(nQ,function(e,n)
return{
n=e.n,
k=e,
em=n-1>@0x5efd,
I=function(t,e)
oE(t,e.k,e.n,function(t,e)
poke(0x5efd,mid(@0x5efd,n,40))
tA(e)
end,v)
end
}
end)
end,function(_ENV)
f:M(m";n,moves,Y,eX,I,~eo;;n,switch,Y,th,I,~eo;;n,delete,I,~f_")
end,function(_ENV)
local n=_ENV:nh()
local e=0
for t=1,4do
if n.w[t].d>0then e+=1end
end
f:M(m(";n,change,Y,nK,I,~eo;;n,switch,Y,oX,I,~eo;;n,delete,em,@,I,~f2",e==1))
end,function(_ENV)
local e,n=_ENV:nh()
e.w[_ENV:X"eX"+1]=B(-1)
e6(_ENV:X"j",n)
_ENV:N()
end,function(_ENV,o,a)
local n,d=_ENV:nh()
f:M(m",1,2,3,4",function(e)
local t=n.w[e]
return{
l=t,
n=t.n,
I=function(_ENV)a(_ENV,e,n,d)end,
em=e==o
}
end)
end,function(_ENV)
of(_ENV,0,function(_ENV,e,n)
_ENV:eh(n.w[e].d>0and"oL"or"nK")
end)
end,function(_ENV)
local n=_ENV:X"eX"+1
of(_ENV,n,function(_ENV,t,e,o)
e.w[t],e.w[n]=e.w[n],e.w[t]
e6(_ENV:X"j",o)
_ENV:nG"eX"
end)
f.C=eX.f.C
end,function(_ENV)
local n=_ENV:nh()
local e=U[n.d]
local t={}
p(function(o,a)
for f=1,#o do
local e=o[f]
add(t,{n=n_[e].n,em=n:ol(e),d=e,e3=a..f})
end
end,";,@,learn #;;,@,teach #;;,@,event #",e.eR,e.eS,e.nq)
f:M(t,function(e)
return{
n=e.n,
em=e.em,
l=n_[e.d],
fZ=e.e3,
I=function()
local n=_ENV:e9"j"
n[_ENV:X"el"+1].w[_ENV:X"eX"+1]=B(e.d)
e6(_ENV:X"j",n)
_ENV:nG"eX"
end
}
end)
end,function(_ENV)
local n=oT(T.a)
if T.a.g then
nJ(T,T.a.g)
_ENV:N()_ENV:N()
elseif#n==0then
nJ(T,B(0))
_ENV:N()_ENV:N()
end
f:M(T.a.w,function(e)
return m("em,@,n,@,l,@,I,@",
not n[e],
e.n,
e,
function()
_ENV:N()_ENV:N()
nJ(T,e)
end
)
end)
end,function(_ENV)
f:M(m";n,fight,I,~eo,Y,oO;;n,switch,I,~eo,Y,t1;;n,forfeit,I,~at")
end,function(_ENV)
f:M(m",1,2,3",function(e)
local n=nl(e-1)
local t={}
local o=true
for e=1,6do
t[e]=n[e].d
if not n[e]:ou()then
o=false
end
end
return{
n="team #"..e,
k=t,
I=function()_ENV:nX()end,
em=nL and o
}
end)
end,function(e,n)
return e[n]and e[n].d or-1
end,function(_ENV)
local e=_ENV:e9"j"
f:M(m",1,2,3,4,5,6",function(n)
return{
Z=e[n],
I=function(_ENV)
if e[_ENV:X"el"+1]:eY()then
_ENV:eh"oG"
else
_ENV:eh"oI"
end
end
}
end)
end,function(_ENV)
local e=_ENV:e9"j"
f:M(m",1,2,3,4,5,6",function(n)
return{
em=n==_ENV:X"el"+1,
I=function(_ENV)
local n,t=_ENV:X"el"+1,_ENV:X"th"+1
e[n],e[t]=e[t],e[n]
e6(_ENV:X"j",e)
_ENV:nG"el"
end,
Z=e[n]
}
end)
f.C=el.f.C
end,function(_ENV)
local e=_ENV:e9"j"
f:M(m",1,2,3,4,5,6",function(e)
local n=T.k[e]:ou()or T.a.W==T.k[e]or T.k[e].u==1
return{
em=n,
I=function()
_ENV:N()_ENV:N()
tf(T,T.k[e])
end,
Z=T.k[e]
}
end)
end,function(_ENV)
local n,e=eI,ez
if n.eq==e.eq then e.eq+=sgn(rnd"2"-1)end
T=n.eq>e.eq and n or e
end,function(_ENV,e)
local n=true
for t=en.f.C+e,75.5+75.5*e,e do
if U[t]:eY()then
en.f.C,n=t
J"154"
break
end
end
if n then eP()end
oo(_ENV)
end,function(e)J(e:X"en")end,function()J(b"152")end,function(_ENV)J(nn.a.d)end,function(_ENV)
local e={}
for t,n in pairs(split"133,7,35,1,25,4")do
nV(e,t,n)
poke(0x5e5a+n,1)
end
if@0x5efc==0then
poke(0x5efc,1)
e6(0,e)
end
et=t2"ek,eJ;tF;f,~z,E,~v,tJ,~eP,ny,~v,e_,~fB,os,~z,er,~o_,L,~v,O,~v;eJ;E,~fE,L,~tZ,O,~oe;en;E,~fX,L,~tm,O,~tT;oP;E,~oo,L,~tm,O,~tT,tJ,~f6,ny,~fk;el;E,~fb,L,~tc,O,~tu,er,~tr;th;E,~f4,L,~tc,O,~tu,er,~tr;oI;E,~fL,L,~tm,O,~tT;oG;E,~fI,L,~tc,O,~tu;oL;E,~fC,L,~tl,O,~n0,os,eX;nK;E,~f5,L,~fs,O,~n0;eX;E,~fp,L,~tl,O,~n0;oX;E,~fw,L,~tl,O,~n0;j;ne,player,E,~nv,L,~eV,O,~eW,nL,~z,nX,~fQ;o0;ne,player,E,~nv,L,~eV,O,~eW,nL,~eL,nX,~fJ;tv;ne,player 1,E,~nv,L,~eV,O,~eW,nL,~eL,nX,~fK;ov;ne,player,E,~nv,L,~eV,O,~eW,nL,~eL,nX,~fN;tP;ne,player 2,E,~nv,L,~eV,O,~eW,nL,~eL,nX,~fM;t0;ne,trainer,E,~fG,L,~eV,O,~eW;tE;E,~fP,L,~fT,O,~fv,ny,~f7;tX;E,~fg,L,~nB,O,~f0;oO;E,~f3,L,~nB,O,~n0;t1;E,~fx,L,~nB,O,~f1,er,~tr;ao;next,af,E,~oC,e_,~v,er,~v,o2,eI;af;next,op,E,~oC,e_,~v,er,~v,o2,ez;op;next,ao,E,~fy,e_,~fU,er,~fu,L,~nB,O,~fh,ej,~z;oh;E,~fO,L,~tZ,O,~oe,ny,~f8;"
p(function(e,n,...)
et[e].f=n(...)
end,";,en,~H,~n2,4;;,oP,~nC,~Q;;,oh,~nC,~Q;;,tE,~nC,~Q;;,el,~H,~n2,3;;,th,~H,~n2,3;;,eJ,~H,~Q;;,oG,~H,~Q;;,oL,~H,~Q;;,nK,~H,~Q;;,eX,~H,~Q;;,oX,~H,~Q;;,j,~H,~Q;;,tv,~H,~Q;;,t0,~H,~Q;;,tP,~H,~Q")
F(et,"ow,@,a_,@;eJ;f;eM,~eP;tX;f;eM,~eP;ov;f,~ow;o0;f,~ow;oI;f,~a_;",et.j.f,et.en.f)
menuitem(1,"close picodex",function()
menuitem(1)
menuitem(2)
_ENV:es"tL"
end)
menuitem(2,"swap 🅾️/❎",function()
poke(0x5eff,@0x5eff==0and 1or 0)
end)
end,function(e)
e.et:t5()
end,function()nt.et:er()end,function()nt.et:L()end,function()nt.et:O()end,function(_ENV)f.e_(_ENV)end,function(_ENV)f.er(_ENV)end,function(_ENV,e)
return _ENV[e].f.C
end,function(_ENV,e)
local n=e and _ENV[e].f or f
return n[n.C+1]
end,function(_ENV)
menuitem(1,"factory reset",function()
memset(0x5e00,0,0x100)
_ENV:es"o5"
end)
end,function()
return btn()&0x3f~=0
end,function(_ENV)
if not oa()and nM then
nM=false
_ENV:es()
menuitem(1)
elseif oa()then
nM=true
menuitem(1)
end
end,0,function(e)
eT.od=max(0,0+e-152)
sfx(54+e\16,0,e%16*2,2)
end,function(_ENV)
cls"0"
nI(0,128+sin(_ENV:tp"o3"/4)*128,function()
p(eK,";,aMORG gAMES,64,-68,7,0;;,pRESENTS,64,-61,7,0;;,a pOKEMON bATTLE sIM,64,15,7,0")
p(spr,";,102,44,7,5,1")
local t,
n,
e=
et and et.eJ.f.C,
et and et.tB-1,
eu=="nN"and 1
or eu=="eA"and-1
or(eu=="tO"and-1or 1)*cos(_ENV:tp(eu)/2)
nI(30-(e+1)*15+(ek=="o5"and b"3"-1or 0),27,function()
p(rectfill,";,14,18,@,87,5",63+max(0,e*54))
if eB==0then
p(rectfill,";,14,18,117,87,13")
p(function(e,n,t,o,f)
clip(-%0x5f28+e,-%0x5f2a+n,t,o)
nI(e,n,f)
clip()
end,";,14,21,40,40,@;;,71,18,46,13,@;;,71,67,46,21,@",er,L,O)
end
p(map,";,24,0,2,1,8,3;;,8,0,2,9,8,11")
p(function(e,n,t,o,f,a)
return spr((eB<=e)and(od==e and stat"46">=0and o or t)or n,f,a)
end,";,0,135,133,134,6,3;;,1,132,128,131,12,3;;,2,132,129,131,17,3;;,3,132,130,131,22,3")
p(function(e,n,t,o,f)
spr(btn(e)and n or t,o,f)
end,";,0,186,154,10,77;;,1,188,156,26,77;;,2,171,139,18,73;;,3,187,155,18,81;;,4,170,138,42,77;;,5,172,140,50,77")
if e<=0then
oi(0,2+64*(1-abs(e)),abs(e))
if e==-1and nM then spr(123,6,49)end
else
oi(16,62,e)
if e==1then
if t then spr(153,70+t*8,41)end
if n and n>=0then spr(153,70+n*8,49)end
end
end
end)
end)
end,function(o,t,e)
e*=64
for n=9,96do
tline(t,n,t+e-1,n,o,n/8-1.125,8/e,0)
end
end,function(n,e,t,o)
local f,a="",""
for e=1,#n do
local t,o=sub(n,e,e),e%2==0
f..=o and" "or t
a..=o and t or" "
end
eK(f,e,t,o,0)
eK(a,e,t+1,o,0)
end,function(e,n,o,f,t)
e=""..e
if t==0then n-=#e*2
elseif t>0then n-=#e*4+1end
print(e,n,o,f)
end,function(_ENV)
if d>=0then
return not en or@(0x5e5a+d)>0
end
end,function(e)
eg("pkmn #"..e.d)
end,function(e)
if e:eY()then
eE(e.n.."|"..eF[e.eO].n.."|"..eF[e.ep].n)
else
eE"none|n/a|"
end
end,function(n,f,a,t,o)
local e,d=n/8\1,n%8
if e~=og then
og=e
memcpy(0x0000,0x8000+0x400*e,0x400)
end
sspr(d*16,0,16,16,f-t*8,a-o*8,t*16,o*16)
end,function(_ENV,o,f,a,n,t,i)
local e=_ENV:eY()and d or-1
foreach(m";,25,53,152;;,54,143,153",function(n)
if e==n[1]and _ENV:ol(n[2])then
e=n[3]
end
end)
if ew and ew>0then e=154end
if not aa or u~=1and not ad and not(e1~=0and g.eU==ni)then
if e<0then spr(107,o-4,f-4)return end
n,t=n or 1,t or 1
local d=1
local d=function(d,i,r,m,c,a)
if d>0then
for e=1,15do pal(e,d)end
for d=-1,1,2do
ts(e,o+(i or d*a),f+(r or d*a),n,t)
ts(e,o+(m or d*a),f+(c or d*a),n,t)
end
end
end
if i then
p(d,"c,@;;,~c,-2,~z,2,~z,1;;,~c,~z,-2,~z,2,1;;,~c,-2,0,2,0,1;;,~c,0,-2,0,2,1",a.c)
end
p(d,";,@,-1,~z,1,~z,1;;,1,~z,0,0,~z,1",a.ei)
pal()ts(e,o,f,n,t)
end
end,function(e)e:eh"t0"end,function(e)e:eh"tP"end,function(_ENV)
ob(_ENV,
m(",@,player 1,~z,~v",nl(_ENV:X"tv")),
m(",@,player 2,~z,~v",nl(_ENV:X"tP"))
)
end,function(_ENV)
poke(0x5efe,mid(@0x5efe,#nS(k),152))
end,function(_ENV)
local e={}
for n=1,152do add(e,n%152)end
oE(_ENV,e,"horde",function(n,e)
tA(e)
oc(e)
end,oc)
end,function(e)
e:eh"el"
end,function(e,n)
return nl(e:X(n))
end,function(e)
local n=nl(e:X"j")
return n[e:X"el"+1],n
end,function(n,e)
local t={}
foreach(e.w,function(e)
add(t,e)
end)
n.a=setmetatable(m("aa,~eL,to,0,A,1,e2,1,e1,0,nz,0,nj,0,tn,0,n9,0,tQ,@,ew,0,n7,0,W,@,w,@;ns;ed,0,R,0,q,0,K,0,A,0,e2,0",b"3"+2,e,t),{__index=e})
return nP(n,"|comes|out")
end,function(e,n)
for t in all(split(n))do
if t==e then
return true
end
end
end,function(e,n)
nE(e,e,"|comes|back",function(t)
t.e.ad=true
nE(e,e,false,function()
add(e.eD,nD(e,n))
end)
end)
e.eq=3000
end,function(t,n)
local o=t.a.g and"|resumes|"or(n.eU==aI and"|begins|"or"|uses|")
nE(t,t,o..n.n,function(o)
o.l=n
local _ENV=o
if n.d>0then
n.e8-=1
end
if nF(n.d,"47,36 ")then
eH(_ENV,e.D)
end
if fY(e,i,n)then
r(t,"|misses|"..n.n)
if nF(n.d,"145,73 ")then
eH(_ENV,1)
end
else
if n.A~=0then
i.to=n.d
end
if n.fl(_ENV)then
r(t,"|fails|attack")
end
end
end)
end,function(_ENV,e,n)
if not g and e1==0then
e1,g=e,n
end
end,function(n,t)
nE(n,n,false,function(o)
o.l=t
local _ENV=o
e:nH("e1",v)
if e.u==6then
e:nH("tQ",function()
r(n,"|suddenly|woke up")
e.W.u=0
end)
if e.u==6then
r(n,"|fast|asleep")
return
end
end
if e.u==3then
if rnd"1"<.2then
r(n,"|thawed|out")
e.W.u=0
else
r(n,"|is|frozen")
return
end
end
if i.n1==e then
r(n,"|is|trapped")
elseif e.eQ==t.ee then
r(n,"|is|disabled")
elseif e.n9>0and b"2"==0then
r(n,"|confuse|damage")
eH(_ENV,tR(e,i,B(-1)))
elseif e.u==4and b"4"==0then
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
return nP(n,false,function(_ENV)
if e.u==6
or e.u==3
or e.n1 and e.n1~=i
then
e.e1=0
end
if e.e1==0then
e.n1,e.g=nil
end
local t=max(e.V\16,1)
local o=function(e)
r(n,e.."|damage")
eH(_ENV,t)
end
if e.u==5then
if e.n7>0then
t*=e.n7
e.n7+=1
end
o"|poison"
end
if e.u==2then o"|burn"end
if e.ai then
o"|seed"
if i.D<i.V then
np(_ENV,ec,t)
end
end
e:nH("n9",function()
r(n,"|confusion|ended")
end)
e:nH("tn",function()
r(n,"|"..e.w[e.eQ].n.."|enabled")
e.eQ=0
end)
end)
end,function(e,n)
e.eD={}
local t=1000
fR(e,n)
if n.d==120then t=2000end
if nF(n.d,"18,4,89,30 ")then
t=0000
end
e.eq=min(3000,t+e.a:eb"K")
end,function(e,n)
return n==e.eI and e.ez or e.eI
end,function(e,n,t,o)
return{ae=e,n=o or e.a.n,a=e.a,o1=n,ar=t or v}
end,function(e,...)
add(e.eD,nP(...))
end,function(e)
if nT then eP()end
if eN then J"154"end
if eN or not e.ej then
while true do
for n in all{e.eI,e.ez}do
if not ng(n.k)then
e.nn=eZ(e,n)
e:es"tE"
return
end
end
local n=fV(e)
if n then
local o=n.a==e.eI.a and e.eI or e.ez
local t=m("l,@,G,@,ec,@,r,@",l,o,eZ(e,o),function(...)
nE(o,...)
end)
t.e=t.G.a
t.i=t.ec.a
n.ar(t)
if n.o1 then
e.ej=n
return
else
end
else
e:es()
return
end
end
end
end,function(n)
for t in all{n.eI,n.ez}do
if t.a.D<=0then
if t.a.u~=1then
return nP(t,"|is|fainted",function(_ENV)
e.W.u=1
end)
elseif t~=n.T then
return nD(t,ng(t.k))
end
end
end
for e in all{n.T,eZ(n,n.T)}do
local t=eZ(n,e)
while#e.eD>0do
local n=deli(e.eD,1)
if n.a.u~=1and(n.a==e.a or n.a==t.a)then
return n
end
end
if e.a.D<=0and e.a.u==1then
return nD(e,ng(e.k))
end
if not e.o4 then
e.o4=true
return fS(e)
end
end
end,function(_ENV,e)
for n in all(w)do
if n.d==e then
return true
end
end
end,function(_ENV)
return#n8(_ENV,true)==0
end,function(t,o)
local n={}
foreach(t.w,function(e)
if e.d>0and(o or e.e8>0and t.eQ~=e.ee)then
add(n,e)
n[e]=true
end
end)
return n
end,function(_ENV)
if e1~=0then
return{g}
else
return n8(_ENV)
end
end,function(n)
local e=oT(n)
return e[b(#e)+1]or B(0)
end,function(e,t,n)
if n.A<=0then return false end
if(n.eU==nr or n.eU==ni)and not e.g then return false end
if t.g and t.g.eU==ni then return true end
if e.g and e.g.eU==nd then return false end
return rnd(t:eb"e2")>n.A/100*e:eb"A"or b"256"==0and b"256"==0
end)
F(eT,"t_,@,tR,@,oC,@,at,@,ob,@,oE,@,tG,@,am,@,ac,@,ox,@,al,@",function(e,n)
return(eF[e.eG][n.eO]or 1)*(eF[e.eG][n.ep]or 1)
end,function(n,t,e)
local a,o=n:eb"ed",t:eb"ed"
if e.eG%2==1then
a,o=n:eb"R",t:eb"q"
if t.au then
o*=2
end
elseif t.aT then
o*=2
end
local f=1024
if nF(e.d,"107,164,57,157 ")then f*=.3end
if as then f*=.3end
local d=rnd"1"<min(.99,(n.ta+76)/f)and e.d>0and 2or 1
local f=mid(
3,997,
(100*d/5+2)/50
*e.ti
*mid(10,.2,a/o)
)+2
local a,o=f,t_(e,t)
*((e.eG==n.eO or e.eG==n.ep)and 1.5or 1)
*(rnd".15"+.85)
if o>0then
return max(1,a*o\1),d>1
end
return 0,false
end,function(_ENV)
T=_ENV[o2]
do local _ENV=T.a
nz,tN=0,false
end
T.o4=false
if T.a1 then
nJ(T,fW(T.a))
_ENV:es()
elseif#T.eD>0then
_ENV:es()
else
tX.f,
oO.f,
t1.f,
ej,
eC[#eC]=T.oy,
T.a0,
T.av,
nP(T,""),
ek
_ENV:eh"tX"
end
end,function(_ENV)
_ENV:N()
nn=_ENV:eZ(T)
_ENV:es"tE"
end,function(_ENV,n,t)
n.tI,t.tI="eI","ez"
for e in all{n,t}do
_ENV[e.tI]=m("eD,#,eq,1,oy,@,a0,@,av,@,k,@,n,@,a1,@,an,@",H(Q),
H(Q),
H(n2,3),
unpack(e))
local _ENV=_ENV[e.tI]
oy.eM=eP
add(eD,nD(_ENV,ng(k)))
end
_ENV:eh"op"
end,function(_ENV,e,t,o,f)
local n={}
for t=1,#e do
nV(n,t,e[t])
end
ob(_ENV,
{_ENV:e9"j","player",false,o},
{n,t,true,f}
)
end,function(e)
ox(peek2(e),
function(...)return am(0x8000+e*0x1000,...)end,
function(...)return ac(0x8000+e*0x1000,...)end)
end,function(o,e,n)
e=min(max(0,e),127)\1
n=n\1
local t=peek(n*64+o+e\2)
if e%2==1then return(t&0xf0)>>>4
else return(t&0x0f)end
end,function(f,e,n,o)
e=min(max(0,e),127)\1
n=n\1
local t=n*64+f+e\2
local n=peek(t)
if e%2==1then poke(t,(n&0x0f)|(((o or 0)&0x0f)<<4))
else poke(t,(n&0xf0)|(((o or 0)&0x0f)<<0))
end
end,function(t,r,m)
local function a(e,o)
local n,t=e[1],1
while n!=o do
t+=1
n,e[t]=e[t],n
end
e[1]=o
end
local e,n=0,0
function o6(o)
if n<8then
n+=8
e+=@t>>n
t+=1
end
e<<=o
local t=e&0xffff
e^^=t
n-=o
return t
end
function no(n)
local e=0
repeat
e+=1
local t=o6(e)
n+=t
until t<(1<<e)-1
return n
end
local i,d,o,e,f,c,l,n,t=no"1",no"0",no"1",{},{},0,0,0
for n=1,no"1"do add(e,o6(o))end
for o=0,d do
for d=0,i-1do
n-=1
if(n<1)then
n,t=no"1",not t
end
local i=o>0and r(d,o-1)or 0
local n=f[i]or{unpack(e)}
f[i]=n
local f=n[t and 1or no"2"]
a(n,f)
a(e,f)
m(d,o,f)
end
end
end,function(e)
if e.ah then J(e.ah)end
e:tC()
end)
eT.td=m"-1;,none,~o;0;,struggle,~nw;;,megapnch,~o;;,razrwind,~nr;;,sworddnc,~x,~s,R,2;;,whrlwind,~t6;;,megakick,~o;;,toxic,~oQ;;,horndril,~nR;;,bodyslam,~o,30,~P,4;;,takedown,~nw;;,doubedge,~nw;;,bublbeam,~o,10,~h,~s,K,-1;;,watergun,~o;;,icebeam,~o,10,~P,3;;,blizzard,~o,10,~P,3;;,hyprbeam,~oZ;;,payday,~o;;,submsion,~nw;;,counter,~fn;;,seistoss,~ef,50;;,rage,~oU;;,megdrain,~n5;;,solrbeam,~nr;;,drgnrage,~ef,40;;,thndrblt,~o,10,~P,4;;,thunder,~o,10,~P,4;;,earthqke,~o;;,fissure,~nR;;,dig,~ni,|begins|digging;;,psychic,~o,30,~h,~s,ed,-1;;,teleport,~oN;;,mimic,~oD;;,doubteam,~x,~s,e2,1;;,reflect,~x,~e4,|raises|defense,au;;,bide,~oV;;,metrnome,~oK;;,selfdstr,~o;;,eggbomb,~o;;,fireblst,~o,30,~P,2;;,swift,~o;;,skulbash,~nr;;,softboil,~ty;;,dreameat,~fo;;,skyattck,~nr;;,rest,~fe;;,thndrwav,~P,4;;,psywave,~oW;;,explsion,~o;;,rockslid,~o;;,triattck,~o;;,substute,~oS;;,cut,~o;;,fly,~ni,|begins|flying;;,surf,~o;;,strength,~o;;,flash,~h,~s,A,-1;;,pound,~o;;,karatchp,~o;;,doubslap,~ey;;,comtpnch,~ey;;,firepnch,~o,10,~P,2;;,icepnch,~o,10,~P,3;;,thndpnch,~o,10,~P,4;;,scratch,~o;;,vicegrip,~o;;,guilotin,~nR;;,gust,~o;;,wingatck,~o;;,bind,~nd;;,slam,~o;;,vinewhip,~o;;,stomp,~o,30,~h,~ex;;,doubkick,~nm,2,~v;;,jumpkick,~o;;,rllngkck,~o,30,~h,~ex;;,sandatck,~h,~s,A,-1;;,headbutt,~o,30,~h,~ex;;,hornatck,~o;;,furyatck,~ey;;,tackle,~o;;,wrap,~nd;;,thrash,~t7;;,tailwhip,~h,~s,q,-1;;,psnsting,~o,20,~P,5;;,twineedl,~ft;;,pinmisil,~ey;;,leer,~h,~s,q,-1;;,bite,~o,10,~h,~ex;;,growl,~h,~s,R,-1;;,roar,~t6;;,sing,~P,6;;,sprsonic,~h,~na;;,sonicbom,~ef,20;;,disable,~oB;;,acid,~o,10,~h,~s,q,-1;;,ember,~o,10,~P,2;;,flamthwr,~o,10,~P,2;;,mist,~x,~e4,|stat lower|immunity,fm;;,hydropmp,~o;;,psybeam,~o,10,~h,~na;;,aurorabm,~o,10,~h,~s,R,-1;;,peck,~o;;,drillpck,~o;;,lowkick,~o,30,~h,~ex;;,absorb,~n5;;,leechsed,~h,~e4,|is now|seeded,ai;;,growth,~x,~s,ed,1;;,razrleaf,~o;;,psnpowdr,~P,5;;,stunspor,~P,4;;,slppowdr,~P,6;;,petldanc,~t7;;,strngsht,~h,~s,K,-1;;,firespin,~nd;;,thndshck,~o,10,~P,4;;,rockthrw,~o;;,cnfusion,~o,10,~h,~na;;,hypnosis,~P,6;;,meditate,~x,~s,R,1;;,agility,~x,~s,K,2;;,quickatk,~o;;,ngtshade,~ef,50;;,screech,~h,~s,q,-2;;,recover,~ty;;,harden,~x,~s,q,1;;,minimize,~x,~s,e2,1;;,smokscrn,~h,~s,A,-1;;,cnfusray,~h,~na;;,withdraw,~x,~s,q,1;;,dfnscurl,~x,~s,q,1;;,barrier,~x,~s,q,2;;,lghtscrn,~x,~e4,|raises|spcdefense,aT;;,haze,~oJ;;,fcsenrgy,~x,~e4,|raises|crit ratio,as;;,mirrmove,~oM;;,lick,~o,30,~P,4;;,smog,~o,30,~P,5;;,sludge,~o,30,~P,5;;,boneclub,~o,10,~h,~ex;;,watrfall,~o;;,clamp,~nd;;,spikcann,~ey;;,constrct,~o,10,~h,~s,K,-1;;,amnesia,~x,~s,ed,2;;,kinesis,~h,~s,A,-1;;,hijmpkck,~o;;,glare,~P,4;;,poisngas,~P,5;;,barrage,~ey;;,leechlif,~n5;;,lovekiss,~P,6;;,tranform,~oF;;,bubble,~o,10,~h,~s,K,-1;;,dizypnch,~o;;,spore,~P,6;;,splash,~oR;;,acidarmr,~x,~s,q,2;;,crabhamr,~o;;,furyswps,~ey;;,bonerang,~nm,2,~v;;,hyprfang,~o,10,~h,~ex;;,sharpen,~x,~s,R,1;;,convrson,~oH;;,suprfang,~oY;;,slash,~o"
tY=m"0,0x5e00,1,0x5e1e,2,0x5e3c"
og=16
function _init()
local _ENV=eT
memset(0x8000,0,0x7fff)
nt=t2"ek,aP,E,~al,eB,4;tF;eu,eA,eB,4,sfx,~z,nM,~z,tC,~v,e_,~v,ev,~v,er,~v,L,~v,O,~v,et,;aP;next,o3,ea,.5,ev,~e0;o3;next,eA,ea,.5,ev,~e0;o5;eu,eA,next,eA,ea,.5,sfx,159,ev,~e0;eA;eu,eA,next,tO,tC,~fD,ev,~e0,e_,~fF;tO;eu,tO,next,aE,ea,.2,ev,~e0;aE;eu,nN,next,aX,eB,3,ea,.2,sfx,155,ev,~e0;aX;eu,nN,next,aL,eB,2,ea,.2,sfx,154,ev,~e0;aL;eu,nN,next,aO,eB,1,ea,.2,sfx,153,ev,~e0;aO;eu,nN,next,tL,eB,0,sfx,152,tC,~f9,ev,~e0,e_,~fj,er,~fz,L,~fq,O,~fA;tL;eu,tL,next,eA,ea,.25,ev,~e0,e_,~v;"
e0(nt)
flip()
J"155"tG(0x0)
J"154"tG(0x2)
J"153"tG(0x4)
J"154"
p(poke,";,0x5f5c,8;;,0x5f5d,2;;,0x5f56,0xe0")
ox(peek2"0x6",mget,mset)
fa()
ff()
local e=peek2"0xc"
for t,o in pairs(nQ)do
local n={n=o}
for t=1,6do
add(n,peek(e))
e+=1
end
nQ[t]=n
end
memcpy(0x0000,0xc000,0x2000)
end
function _update60()
local _ENV=eT
nT,eN,nZ,nY=btnp"4",btnp"5",btnp"0"and btnp"1"and 0or btnp"0"and-1or btnp"1"and 1or 0,btnp"2"and btnp"3"and 0or btnp"2"and-1or btnp"3"and 1or 0
if@0x5eff==1then
nT,eN=eN,nT
end
nt:t5()
end
function _draw()
local _ENV=eT
nt:ev()
end