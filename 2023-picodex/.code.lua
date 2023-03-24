function ru(q,table,gp)
if _ord(q)==37 then return _g[_sub(q,2)]
elseif q=="~"then return table
elseif _ord(q)==126 then return table[_sub(q,2)]
elseif q=="@"then return _deli(gp,1)
elseif q=="#"then return{}end
return q ~=""and q or nil
end
function ez(table,hv,...)
local tq,px,od={...},_split(hv,";"),table
_foreach(px,function(iu)
local ic=_split(iu)
if #ic>1 then
if ic[1]==""then
_foreach(ic,function(q)
_add(od,ru(q,table,tq))
end)
else
for t=1,#ic,2 do
od[ic[t]]=ru(ic[t+1],table,tq)
end
end
od=table
else
if iu==""then iu=#od+1 end
if _type(od[iu])~="table"then
od[iu]={}
end
od=od[iu]
end
end)
return table
end
function v(...)
return ez(_setmetatable({},{__index=_g}),...)
end
ez(_g,[[ak,@,ac,@,kg,@,k,@]],true,false,"",function(...)return...end)
ez(_g,[[mp,@,kl,@,fy,@,kh,@,kr,@,bb,@,bv,@,by,@,v,@,ez,@,ru,@,ww,@,av,@,ew,@,ep,@,rm,@,fu,@,oq,@,ab,@,tb,@,kp,@,pi,@,po,@,sy,@,pt,@,kw,@,sb,@,dk,@,ao,@,rq,@,tl,@,vt,@,vo,@,ve,@,bq,@,bz,@,va,@,tf,@,ht,@,mq,@,yk,@,ie,@,bf,@,fe,@,bl,@,yq,@,bg,@,bu,@,ry,@,fo,@,bd,@,bh,@,fa,@,be,@,ds,@,ex,@,eo,@,ee,@,yz,@,bo,@,ei,@,oz,@,it,@,sn,@,ba,@,my,@,bi,@,bp,@,sr,@,ia,@,br,@,bn,@,bw,@,ft,@,ns,@,sh,@,bc,@,ss,@,rw,@,l,@,bm,@,rb,@,dt,@,bs,@,bt,@,mz,@,aa,@,nr,@,su,@,fl,@,yw,@,rj,@,yi,@,mw,@,dn,@,di,@,rv,@,yt,@,lj,@,sd,@]],function(pk)
return ez(v[[ay,%fy,uq,%kh,eb,%kr,mc,%kl,sz,0,ck,0,mi,%ak,oc,kj,ea,%k,tg,%k;oo;,;]],pk)
end,function(_ENV,eh)
if eh==oc then
return an and sz/an or 0
end
if _ENV[eh]and _ENV[eh].ku then
return 1
end
return 0
end,function(_ENV,ra)
rr=ra or tc
end,function(_ENV,ra)
sz,rr,mi,tc,an=0
_ENV[oc].ku=true
for lu,b in _pairs(fb)do _ENV[lu]=b end
for lu,b in _pairs(_ENV[ra])do _ENV[lu]=b end
oc=ra
_ENV:ea()
ck=#oo
end,function(_ENV)
sz+=1/60
if mi then _ENV:uq(oc)end
if an and sz>=an then
_ENV:ay()
end
while rr do
_ENV:uq(rr)
end
_ENV:tg()
end,function(_ENV,pw)
while rr ~=pw and #oo>0 do
_ENV:th()
end
end,function(_ENV)
_deli(oo)
_ENV:ay(oo[#oo]or "ix")
end,function(_ENV,uu)
_add(oo,uu)
_ENV:fy(uu)
end,v,ez,ru,function(ge,g,w,ap,im,...)
ap,im=ap or 1,im or 1
_spr(ge,g-ap*4,w-im*4,ap,im,...)
end,function()
tm"153"
end,function(g)
return _flr(_rnd(g))
end,function(al,am,...)
_foreach(v(am,...),function(tq)
al(_unpack(tq))
end)
end,function(gz,gq,al)
local uh,ur=%0x5f28,%0x5f2a
_camera(uh-gz,ur-gq)
al()
_camera(uh,ur)
end,function(ha,tk,hc)
return ha(tk)and ha(hc)and 0 or ha(tk)and-1 or ha(hc)and 1 or 0
end,function(aj)
na(aj or "",23,4,1,0)
end,function(hv)
ep(_rectfill,[[;,0,0,45,6,1]])
ep(na,[[;,@,23,1,13,0;;,@,23,8,1,0;;,@,23,15,1,0]],_unpack(_split(hv,"|",false)))
end,v[[]],_split"missingno,bulbasaur,ivysaur,venusaur,charmander,charmeleon,charizard,squirtle,wartortle,blastoise,caterpie,metapod,butterfree,weedle,kakuna,beedrill,pidgey,pidgeotto,pidgeot,rattata,raticate,spearow,fearow,ekans,arbok,pikachu,raichu,sandshrew,sandslash,nidoran f,nidorina,nidoqueen,nidoran m,nidorino,nidoking,clefairy,clefable,vulpix,ninetales,jigglypuff,wigglytuff,zubat,golbat,oddish,gloom,vileplume,paras,parasect,venonat,venomoth,diglett,dugtrio,meowth,persian,psyduck,golduck,mankey,primeape,growlithe,arcanine,poliwag,poliwhirl,poliwrath,abra,kadabra,alakazam,machop,machoke,machamp,bellsprout,weepinbell,victreebel,tentacool,tentacruel,geodude,graveler,golem,ponyta,rapidash,slowpoke,slowbro,magnemite,magneton,farfetchd,doduo,dodrio,seel,dewgong,grimer,muk,shellder,cloyster,gastly,haunter,gengar,onix,drowzee,hypno,krabby,kingler,voltorb,electrode,exeggcute,exeggutor,cubone,marowak,hitmonlee,hitmonchan,lickitung,koffing,weezing,rhyhorn,rhydon,chansey,tangela,kangaskhan,horsea,seadra,goldeen,seaking,staryu,starmie,mr mime,scyther,jynx,electabuzz,magmar,pinsir,tauros,magikarp,gyarados,lapras,ditto,eevee,vaporeon,jolteon,flareon,porygon,omanyte,omastar,kabuto,kabutops,aerodactyl,snorlax,articuno,zapdos,moltres,dratini,dragonair,dragonite,mewtwo,mew",v"0,none;,fainted,burned,frozen,paralyzed,poisoned,sleeping",v"0,NON;,FNT,BRN,FZN,PAR,PSN,SLP",v[[0;j,0,s,%kg;1;j,0,s,normal,15,0,13,.5;2;j,5,s,fire,8,2,10,2,11,2,2,.5,4,.5,13,.5,14,.5;3;j,2,s,fighting,10,2,1,2,13,2,15,0,11,.5,9,.5,5,.5,12,.5;4;j,4,s,water,2,2,7,2,13,2,14,.5,8,.5,4,.5;5;j,1,s,poison,11,2,8,2,15,.5,7,.5,5,.5,13,.5;6;j,6,s,electric,9,2,4,2,7,0,14,.5,6,.5,8,.5;7;j,2,s,ground,6,2,2,2,5,2,13,2,9,0,11,.5,8,.5;8;j,3,s,grass,7,2,13,2,4,2,11,.5,14,.5,2,.5,9,.5,8,.5,5,.5;9;j,0,s,flying,11,2,3,2,8,2,6,.5,13,.5;10;j,4,s,ice,14,2,9,2,8,2,2,.5,10,.5,4,.5;11;j,3,s,bug,8,2,12,2,3,.5,2,.5,9,.5,15,.5,5,.5;12;j,1,s,psychic,3,2,5,2,12,.5;13;j,0,s,rock,11,2,2,2,9,2,10,2,3,.5,7,.5;14;j,0,s,dragon,14,2;15;j,1,s,ghost,15,2,1,0,12,0;17;j,0,s,bird;]],v[[tx;ij,special,ny,spc;te;ij,attack,ny,att;em;ij,defense,ny,def;tr;ij,speed,ny,spd;sq;ny,tot;tt;ij,accuracy;ol;ij,evasion]],v[[0;j,6,om,13;;j,14,om,4;;j,9,om,4;;j,11,om,3;;j,12,om,5;;j,8,om,2;;j,10,om,4]],v[[]],_split"youngstr,bugcatch,junior,brock,lass,hiker,swimmer,misty,gentlman,sailor,rocker,ltsurge,channelr,gambler,beauty,erika,biker,birdkeep,juggler,koga,blckbelt,rocket,psychic,sabrina,scientst,pkmaniac,suprnerd,blaine,cooltrnr,fishrman,tamer,giovanni,lorelei,bruno,agatha,lance,blue,green,red,legendry",function(o,x)
if x.eb then
o:ag(x.eb)
else
o:th()
end
end,function(sp,sx)
return v([[sp,@,sx,@,b,~sx,eg,1,tg,%bq,ty,%va,nc,%vo,ta,%vt]],sp,sx or 0)
end,function(sp,eg)
return ez(rq(sp),[[ed,0,eg,@,tg,%bz,hj,%ve]],eg or 1)
end,function(e,fv,ws)
while _deli(e)do end
for t=1,#fv do
_add(e,(ws or k)(fv[t],t))
end
end,function(o)
o:th()
tm"154"
end,function(e,hi,wc)
if wc then
local oe=e.ed+hi*e.eg
if oe==_mid(0,oe,#e-1)then
e.ed=oe
if 0+hi ~=0 then tm"154" end
else
av()
end
else
local oe=e.ed+hi
local mt=e.ed-e.ed%e.eg
if oe==_mid(mt,oe,mt+e.eg-1)then
e.ed=oe
if 0+hi ~=0 then tm"154" end
else
av()
end
end
e.ed=_mid(0,e.ed,#e-1)
if e.ed\e.eg<e.b then e.b=e.ed\e.eg end
if e.ed\e.eg>e.b+2 then e.b=e.ed\e.eg-2 end
e.b=_mid(0,e.b,(#e-1)\e.eg)
end,function(o)
local e=o.e
if st then e.nc(o)end
if nt then o:sk()end
e.b+=lw
if ly ~=0 then o:ux(ly)end
local gk=e.b
e.b=_mid(e.sx,e.b,#e-3)
if e.b ~=gk then
av()
elseif lw ~=0 then
tm"154"
end
end,function(o)
local e=o.e
e:hj"0"
e:hj(lw,true)
e:hj(ly)
if nt then
local x=e[e.ed+1]
if x.tn then
av()
elseif x.el then
tm"155"
x.el(o,x)
end
end
if st then e.nc(o)end
end,function(o)
local e=o.e
local hr=e.eg>1 and 10 or 40
local nf=20-(e.eg*hr)/2
ep(_rectfill,[[;,0,0,39,39,1;;,0,@,39,@,13]],5-e.b*10,4+(_max(_ceil(#e/e.eg),3)-e.b)*10)
for t=-1,e.eg*5-1 do
local iq=(e.b-1)*e.eg+t+1
local x=e[iq]
if x then
local rt,g,w=x.ts or 1,nf+t%e.eg*10,t\e.eg*10
if x.tn then rt=3 end
if iq-1==e.ed then rt+=1 end
if not x.lg then
_rectfill(g,w-5,g+hr-1,w+4,pa[rt].j)
rm(t%e.eg*hr+nf+hr/2,t\e.eg*10-3,function()
e.sp(x,pa[rt])
end)
end
end
end
end,function(x,ts)
if x.h then
local ts=kw[sy[x.h.ot].j]
ep(_rectfill,[[;,-20,-2,19,17,@;;,-20,14,19,17,@]],ts.j,ts.om)
x.h:ti(0,8,ts.om,1,1)
else
mg(x.s,0,0,ts.sa)
end
end,function(x,ts)
x.h:ti(0,3,ts.nk,.375,.375)
end,function(u)
local d=di(u.d)
_del(d,u.c.tj)
if #d>0 then
return d[ew(#d)+1]
end
end,function(tk,oa,mh)
local ue=tk.nw[oa]
if not tk.wo or mh>0 then
tk.nw[oa]=_mid(-6,6,ue+mh)
end
return ue ~=tk.nw[oa]
end,function(tk,oa)
local oy=tk.nw[oa]
return _ceil(_mid(1,999,
tk[oa]*(
(oa=="ol"or oa=="tt")
and _mid(1,1+oy/3,3)/_mid(1,1-oy/3,3)
or _mid(2,2+oy,8)/_mid(2,2-oy,8)
)
))
end,function(_ENV)
if f.dg>0 then return true end
local aw=rk(f)
if #aw==0 then return true end
f.dg=ew"6"+2
f.nl=aw[ew(#aw)+1].ev
y(to,"|"..f.z[f.nl].s.."|disabled")
if f.ef and f.ef.ev==f.nl then
f.ae=0
end
end,function(_ENV,i,ev)
local rh=ej(i,ev)
rh.on,rh.uv=5,5
z[ev]=rh
return rh
end,function(_ENV)
local ul=rk(f,true)
y(m,"|copied|"..fe(r,ul[ew(#ul)+1].i,a.ev).s)
end,function(_ENV)
if r.pb then
return true
else
y(m,"|copied|"..f.s,function()
r.pb=true
_foreach(_split"i,te,em,tr,tx,ot,op",function(eh)
r[eh]=f[eh]
end)
r.z={}
_foreach(f.z,function(eu)
fe(r,eu.i,eu.ev)
end)
end)
end
end,function(_ENV)
ez(r,[[ot,@,op,@]],f.ot,f.op)
y(m,"|copied|types")
end,function(_ENV)
_foreach({to,m},function(u)
ez(u.c.nw,[[tx,0,te,0,em,0,tr,0,tt,0,ol,0]])
y(u,"|reset|stat mods")
end)
end,function(_ENV,u,sv)
sv=_min(sv,u.c.tu-u.c.ek)
if sv>0 then
y(u,ds(sv,"|hitpoints"),function()
u.c.tj.ek+=sv
end)
else
return true
end
end,function(_ENV)
return ry(_ENV,m,r.tu\2)
end,function(_ENV)
de(m,ej(ew(164)+1,a.ev))
end,function(_ENV)
if r.lc>0 then
de(m,ej(r.lc,a.ev))
else
return true
end
end,function(_ENV)
local h=mq(to)
if h then
lq(to,h)
else
return true
end
end,function(_ENV)
local h=mq(m)
if h then
lq(m,h)
else
return true
end
end,function(i,gr)
return(_sgn(i)>0 and "|+"or "|-").._abs(i)..gr
end,function(_ENV,al,...)return al(_ENV,m,...)end,function(_ENV,al,...)return al(_ENV,to,...)end,function(_ENV,u,eh,oy)
if yk(u.c,eh,oy)then
y(u,ds(oy,"/6|"..pt[eh].ij))
else
return true
end
end,function(_ENV)
if ei(_ENV,5)and f.er ~=5 then
return true
end
return eo(_ENV,oz,"|badly|poisoned","np",1)
end,function(_ENV)
y(m,"|does|nothing")
end,function(_ENV,uk)
if da(a,f)>0 and f.tj.er==0 then
y(to,"|is now|"..pi[uk],function()
f.tj.er=uk
my(f)
end)
else
return true
end
end,function(_ENV,u,iv,uy,q)
if(u.c[uy]or 0)==0 then
u.c[uy]=q or 1
y(u,iv)
else
return true
end
end,function(_ENV,u)
u.c.mf=true
end,function(_ENV,u)
return oz(_ENV,u,"|becomes|confused","hs",ew"4"+1)
end,function(_ENV)
local hb=r.tu\4
if hb>=r.ek or r.ow>0 then
return true
end
nr(_ENV,hb)
y(m,"|created|substitute",function()
r.ow=hb
end)
end,function(_ENV)
cj=ew"3"+2
end,function(_ENV)
r.tj.er=6
my(r)
y(m,"|is|sleeping")
ry(_ENV,m,r.tu)
r.np=0
end,function(_ENV)
if r.hn>0 then
aa(_ENV,r.hn*2)
else
return true
end
end,function(_ENV,se,ho)
if se>0 then
y(m,"|begin|hit #"..se,function()
_ENV.f=to.c
if l(_ENV)then
y(m,"|failed|hit #"..se)
end
sr(_ENV,se-1,ho)
end)
else
ho()
end
end,function(_ENV,se)
sr(_ENV,2+ew"4",k)
end,function(_ENV)
sr(_ENV,2,function()
if _rnd"100"<20 then
ei(_ENV,5)
end
end)
end,function(_ENV)
ox(r,-1,ej(a.i,a.ev))
l(_ENV)
end,function(_ENV)
if not r.ef then
ox(r,ew"2"+1,ej(a.i,a.ev))
y(m,"|"..a.s.."|begins")
r.dq=0
end
if r.ae==0 then
aa(_ENV,r.dq*2)
end
end,function(_ENV)
ox(r,ew"2"+1,ej(a.i,a.ev))
l(_ENV)
if r.ae==0 then
ex(_ENV,sn,"hs")
end
end,function(_ENV)
if not r.ef then
ox(r,ew"4"+1,ej(a.i,a.ev))
y(m,"|"..a.s.."|begins")
r.hm=f
end
if r.hm==f then
l(_ENV)
end
if r.ae==0 or r.hm ~=f then
r.ae,r.hm=0
y(m,"|"..a.s.."|ended")
end
end,function(_ENV,tp)
if r.ef then
l(_ENV)
else
y(m,"|started|"..tp,function()
ox(r,1,ej(a.i,a.ev))
end)
end
end,function(_ENV)
if r.ef then
y(m,"|recharging|energy")
else
l(_ENV)
local eu=ej(a.i,a.ev)
eu.tt=0
ox(r,1,eu)
end
end,function(_ENV)
if r.ef then
l(_ENV)
else
ox(r,1,a)
y(m,"|preparing|attack")
a.on+=1
end
end,function(_ENV)
local eq=he(r,f,a)
if aa(_ENV,eq)then
return true
else
nr(_ENV,_max(1,eq\4))
end
end,function(_ENV,gf,al,...)
if aa(_ENV,he(r,f,a))then
return true
else
if _rnd"100"<(gf or 0)then
al(_ENV,...)
end
end
end,function(_ENV)
if r.er==6 then
rb(_ENV)
else
return true
end
end,function(_ENV)
local eq=he(r,f,a)
if aa(_ENV,eq)then
return true
else
ry(_ENV,m,_max(eq\2,1))
end
end,function(_ENV)
if r.tr>=f.tr then
return aa(_ENV,f.ek)
else
return true
end
end,function(_ENV)
return aa(_ENV,1+ew"75")
end,function(_ENV)
return aa(_ENV,_max(f.ek\2,1))
end,function(_ENV,u,eq,wr)
local c=u.c
local mo=not wr and c.ow>0
y(u,ds(-eq,"|hitpoints"),function()
c.dq+=eq
if c.ef and c.ef.i==20 then
ee(_ENV,u,"te",1)
end
if mo then
c.ow=_max(c.ow-eq,0)
else
c.tj.ek=_max(c.tj.ek-eq,0)
end
end,mo and "substitute")
end,function(_ENV,eq)
if eq>0 and da(a,f)>0 then
if a.og%2==1 then
f.hn+=eq
end
mz(_ENV,to,eq)
else
return true
end
end,function(_ENV,eq)
mz(_ENV,m,eq,true)
end,function(kv)
return _ceil(kv+.5*93)+5
end,function()
return v([[tv,%ak,uz,50,te,0,em,0,tx,0,tr,0,tu,0,ek,0,sq,0,tt,100,ol,100,pr,0,pl,0,ph,0,dz,0,ps,0,i,-1,sf,-1,s, ,ot,0,op,0,iy,#,iw,#,rl,#,ti,%vj,z,@]],rz())
end,function()
local ib=_peek2"0xa"
tb[-1]=fl()
for i=0,151 do
local os,lm={},false
while@ib ~=255 do
if@ib==254 then
lm=true
elseif lm then
for t=os[#os]+1,@ib do
_add(os,t)
end
lm=false
else
_add(os,@ib)
end
ib+=1
end
ib+=1
local sf=i-_deli(os,1)
local h=fl()
ez(h,[[i,@,sf,@,s,@,ot,@,op,@,pr,@,pl,@,ph,@,dz,@,ps,@]],i,
sf,
kp[i+1],
_unpack(os)
)
local lr=h.iy
for t=8,#os do
local q=os[t]
if q==253 then
lr=h.iw
elseif q==252 then
lr=h.rl
else
_add(lr,q)
end
end
if sf<i then
_foreach(_split"iy,iw,rl",function(eh)
_foreach(tb[sf][eh],function(a)
_add(h[eh],a)
end)
end)
end
local cf,cm={},{}
_foreach(h.iw,function(a)cf[a]=true end)
for t=1,54 do
if cf[t]then _add(cm,t)end
end
h.iw=cm
do local _ENV=h
ez(_ENV,[[te,@,em,@,tx,@,tr,@,tu,@,ek,~tu,uz,50]],su(pl),
su(ph),
su(ps),
su(dz),
su(pr)+5+50
)
sq=te+em+tx+tr+tu
end
tb[i]=h
end
end,function(i,z)
return _setmetatable(v([[z,@,er,0,tv,%ac]],z),{__index=tb[i]})
end,function(ec)
local aw={}
_foreach(ec.z,function(eu)
_add(aw,eu)
end)
return _setmetatable(v([[wd,%ak,lc,0,tt,1,ol,1,ae,0,hn,0,dq,0,dg,0,hs,0,cj,@,ow,0,np,0,tj,@,z,@;nw;tx,0,te,0,em,0,tr,0,tt,0,ol,0]],ew"3"+2,ec,aw),{__index=ec})
end,function(sj)
_foreach(dn(sj.d),function(h)
_poke(0x5e5a+h.i,1)
end)
end,function(d)
local oh={}
_foreach(d,function(h)
if h.i>-1 and h.er==1 then
_add(oh,h)
end
end)
return oh
end,function(d,kd)
local oh={}
_foreach(d,function(h)
if h.i>(kd and 0 or-1)and h.er ~=1 then
_add(oh,h)
end
end)
return oh
end,function(d)
return di(d)[1]
end,function(o)
local d=o:io"ey"
d[o:et"ai"+1]=rj(-1,rz())
oj(o:et"ey",d)
o:th()
end,function(d,lp,i)
d[lp]=rj(i,vh(i))
return d
end,function(hf)
local rd=pe[hf]
local d=v[[]]
for t=1,6 do
local nq,z,ml=rd+(t-1)*5,{},false
for t=1,4 do
z[t]=ej(_peek(nq+t),t)
if z[t].i>0 then
ml=true
else
z[t]=ej(-1)
end
end
d[t]=rj(ml and@nq or-1,z)
end
return d
end)
ez(_g,[[oj,@,yy,@,vh,@,ej,@,rz,@,dd,@,wx,@,dm,@,dl,@,lx,@,ni,@,vv,@,kz,@,wz,@,fs,@,rf,@,dh,@,sl,@,du,@,fn,@,fd,@,yd,@,ym,@,no,@,vb,@,wk,@,vy,@,vs,@,ff,@,ks,@,wj,@,fm,@,kt,@,vg,@,ya,@,yj,@,yx,@,mj,@,ye,@,ys,@,wq,@,yc,@,yu,@,so,@,xe,@,vk,@,yn,@,yl,@,wv,@,kn,@,ki,@,ke,@,vw,@,vu,@,vd,@,vp,@,vf,@,vm,@,bx,@,fi,@,bj,@,bk,@,yv,@,ko,@,fw,@,ka,@,mm,@,tm,@,ad,@,mx,@,mg,@,na,@,vx,@,nn,@,vq,@,fc,@,dc,@,vj,@,wy,@,yr,@,vn,@,vi,@,vr,@,yo,@,io,@,sc,@,rg,@,lq,@,de,@,ox,@,yp,@,rx,@,yg,@,rp,@,nh,@,si,@,sm,@,wb,@,yb,@,lz,@]],function(hf,d)
local rd=pe[hf]
_memset(rd,0,30)
for t=1,6 do
local nq,h=rd+(t-1)*5,d[t]
_poke(nq,_max(0,h.i))
for t=1,4 do
_poke(nq+t,h.z[t].i>0 and h.z[t].i or 0)
end
end
end,function()
local nz=_peek2"0x8"
for t=-1,164 do
local py=_peek(nz+0)
local on=_peek(nz+1)*5-5
local eq=_peek(nz+2)*5-5
local kk=_peek(nz+3)*5-5
local s=_deli(dx[t],1)
local az=_deli(dx[t],1)
sb[t]=v([[al,@,i,@,s,@,og,@,on,@,uv,~on,dy,@,tt,@,az,@]],function(ii)
return az(ii,_unpack(dx[t]))
end,t,s,py,on,eq,kk,az)
nz+=4
end
end,function(i)
local h,nx=tb[i],rz()
for t=1,_min(4,#h.iy)do
nx[t]=ej(h.iy[t],t)
end
return nx
end,function(wm,ev)
return _setmetatable(v([[ev,@]],ev or 0),{__index=sb[wm]})
end,function()
local nx={}
for t=1,4 do _add(nx,ej(-1))end
return nx
end,function(o)
fi(o)
mg("team #"..o:et"ey"+1,20,27,1)
end,function(_ENV)
local fq,ig,ip=is.c,td.c,tz.c
local gb,gw=ig==fq,ip==fq
local un,ui=gb and 6 or 1,gw and 6 or 1
ep(_rectfill,[[;,0,0,39,6,5;;,0,33,39,39,5]])
ep(_rectfill,[[;,-1,33,@,41,@;;,40,-2,@,6,@]],-1+_max(_ceil(ig.ek/ig.tu*40),0),un,
40-_max(_ceil(ip.ek/ip.tu*40),0),ui)
ep(_rectfill,[[;,0,6,24,6,13;;,0,5,23,5,13;;,15,33,39,33,13;;,16,34,39,34,13]])
ep(na,[[;,@,2,34,13,-1;;,@,41,29,@,1;;,@,40,1,13,1;;,@,1,5,@,-1]],ig.ek,po[ig.er],un,ip.ek,po[ip.er],ui)
ig:ti(10,23,5,1)
ip:ti(30,17,5,-1)
end,function(o)vq(tb[o:et"tv"])end,function(o)oq("spot #"..(o:et"ai"+1))end,function(o)oq("move #"..(o:et"af"+1))end,function(o)oq(o.of)end,function(o)oq"match over" end,function(kx)end,function(o)
local a=o:x"re"
oq(a and a.gl)
end,function()
_rectfill(0,0,46,13,13)
_pal(7,1)
local hu=0
for t,b in _ipairs(_split"6,5,5,6,6,5,6")do
_sspr(6*8+hu,6*8,b,8,hu+3,3.5+_cos((_t()+t)/4))
hu+=b
end
_pal()
end,function(o)oq(o.is.u.s)end,function(o)
fc(o:sc())
end,function(o)
local a=o:x(o.uf).a
if a.i>=0 then
ab(sy[a.og].s.."|"..a.on.."/"..a.uv.."|"..(a.dy>=0 and a.dy or "??").."P "..(a.tt>=0 and a.tt or "??").."A")
else
ab"????|?/?|?P ?A"
end
end,function(o)
fc(o:x"tv".h)
end,function(o)ab(o:x"ix".tp)end,function(_ENV)
if i>-1 then
ab(s.."|"..ek.."/"..tu.."|"..pi[er])
else
ab"?????????|???/???|"
end
end,function(_ENV)fd(_ENV:x"hz".h)end,function(_ENV)fd(p.c)end,function(o)
local ou,ua=0,0
for t=1,6 do
local i=o:x().d[t]
if i then
ou+=1
ua+=tb[i].sq
end
end
ab(o:x().s.."|pkmn "..ou.."/6|pow "..ua)
end,function(o)
ab(o.p.s.."|is the|winner")
end,function(o)
ab(o.is.s..o.is.iv)
end,function(_ENV)
local ca,uj=p,nh(_ENV,p)
ca:pc(uj)
e:ta{}
e.nc=function(o)
o:rn"hp"
end
for u in _all{ca,uj}do
ez(e,[[b,0;;h,@;;lg,%ak;;s,@,ts,5;;s,@;;s,@]],u.c.tj,u.s,(#di(u.d,true)).." live",(#dn(u.d)).." dead")
end
end,function(_ENV)
local ou=0
for t=0,151 do ou+=tb[t]:nn()and 1 or 0 end
e:ta(
v([[;s,browse,eb,tv,el,%ao,tp,@;;s,edit,eb,ey,el,%ao,tp,edit|stored|teams;;s,league,eb,cd,el,%ao,tp,@;;s,player,eb,cc,el,%ao,tp,player|custom|battles;;s,?????,eb,cu,el,%ao,tp,?????|beat|league,tn,%ak;;s,credits,eb,fj,el,%ao,tp,credits|amorg|games]],"browse|"..ou.."/151|pokemon","league|"..(@0x5efd).."/40|trainers")
)
if@0x5efd>=40 then
ez(e[5],[[tn,%ac,s,horde,tp,@]],"horde|"..(@0x5efe).."/151|hi-score")
end
end,function(_ENV,gt)
local ng={}
for t=0,151 do
_add(ng,t)
end
e:ta(
ng,
function(i)
local h=tb[i]
return{
el=gt,
tn=not h:nn(),
h=h
}
end
)
end,function(_ENV)
ff(_ENV,function(_ENV)
_ENV:ag"pn"
end)
end,function(_ENV)
ff(_ENV,function(_ENV)
oj(_ENV:et"ey",lj(_ENV:io"ey",_ENV:et"ai"+1,_ENV:et"tv"))
_ENV:th()
end)
end,function(_ENV)
wy(e,_ENV:x"tv".h)
end,function(_ENV)
e:ta(
_split"106,,!alanxoc3,code+sfx,design,6,,!gr8cadet,graphics,playtest,129,,!wadlo,magikarp,playtest,145,,!zep,pico-8,px9 func,137,,!pkmndata,blbpedia,pokeapi,serebii,smogon,upokcntr,volvox,nintendo",
function(aj)
if _type(aj)=="number"then
return{h=rj(aj,rz())}
end
local ts=1
if _sub(aj,1,1)=="!"then
aj,ts=_sub(aj,2),5
end
return{s=aj,ts=ts,lg=aj==""}
end
)
e.b=0
end,function(_ENV)
e:ta(dk,function(sj,i)
return{
s=sj.s,
d=sj,
tn=i-1>@0x5efd,
el=function(o,x)
fp(o,x.d,x.s,function(u,to)
_poke(0x5efd,_mid(@0x5efd,i,40))
mw(to)
end)
end
}
end)
end,function(_ENV)
e:ta(v[[;s,moves,eb,af,el,%ao;;s,switch,eb,hy,el,%ao;;s,delete,el,%yt]])
end,function(_ENV)
local ec=_ENV:sc()
local ou=0
for ma=1,4 do
if ec.z[ma].i>0 then ou+=1 end
end
e:ta(v([[;s,change,eb,re,el,%ao;;s,switch,eb,cy,el,%ao;;s,delete,tn,@,el,%yx]],ou==1))
end,function(_ENV)
local ec,d=_ENV:sc()
ec.z[_ENV:et"af"+1]=ej(-1)
oj(_ENV:et"ey",d)
_ENV:th()
end,function(_ENV,sg,ob)
local ec,d=_ENV:sc()
e:ta(v[[,1,2,3,4]],function(t)
local a=ec.z[t]
return{
a=a,
s=a.s,
el=function(_ENV)ob(_ENV,t,ec,d)end,
tn=t==sg
}
end)
end,function(_ENV)
mj(_ENV,0,function(_ENV,t,ec)
_ENV:ag(ec.z[t].i>0 and "uw"or "re")
end)
end,function(_ENV)
local sg=_ENV:et"af"+1
mj(_ENV,sg,function(_ENV,t,ec,d)
ec.z[t],ec.z[sg]=ec.z[sg],ec.z[t]
oj(_ENV:et"ey",d)
_ENV:rn"af"
end)
e.ed=af.e.ed
end,function(_ENV)
local ec=_ENV:sc()
local h=tb[ec.i]
local up={}
ep(function(ug,gc)
for t=1,#ug do
local ls=ug[t]
_add(up,{s=sb[ls].s,tn=ec:lz(ls),i=ls,tp=gc..t})
end
end,[[;,@,learn #;;,@,teach #;;,@,event #]],h.iy,h.iw,h.rl)
e:ta(up,function(eu)
return{
s=eu.s,
tn=eu.tn,
a=sb[eu.i],
gl=eu.tp,
el=function()
local d=_ENV:io"ey"
d[_ENV:et"ai"+1].z[_ENV:et"af"+1]=ej(eu.i)
oj(_ENV:et"ey",d)
_ENV:rn"af"
end
}
end)
end,function(_ENV)
local nb=fh(p.c)
if p.c.ef then
rp(p,p.c.ef)
_ENV:th()_ENV:th()
elseif #nb==0 then
rp(p,ej(0))
_ENV:th()_ENV:th()
end
e:ta(p.c.z,function(a)
return v([[tn,@,s,@,a,@,el,@]],
not nb[a],
a.s,
a,
function()
_ENV:th()_ENV:th()
rp(p,a)
end
)
end)
end,function(_ENV)
e:ta(v[[;s,fight,tp,fight|select|move,el,%ao,eb,cz;;s,switch,tp,switch|active|pokemon,el,%ao,eb,hz;;s,forfeit,tp,forfeit|pokemon|battle,el,%yf]])
end,function(_ENV)
e:ta(v[[,1,2,3]],function(t)
local d=sd(t-1)
local oh={}
local mn=true
for t=1,6 do
oh[t]=d[t].i
if not d[t]:mk()then
mn=false
end
end
return{
s="team #"..t,
d=oh,
el=function()_ENV:ob()end,
tn=sw and mn
}
end)
end,function(d,t)
return d[t]and d[t].i or-1
end,function(_ENV)
local d=_ENV:io"ey"
e:ta(v[[,1,2,3,4,5,6]],function(t)
return{
h=d[t],
el=function(_ENV)
if d[_ENV:et"ai"+1]:nn()then
_ENV:ag"cl"
else
_ENV:ag"ec"
end
end
}
end)
end,function(_ENV)
local d=_ENV:io"ey"
e:ta(v[[,1,2,3,4,5,6]],function(t)
return{
tn=t==_ENV:et"ai"+1,
el=function(_ENV)
local mr,ms=_ENV:et"ai"+1,_ENV:et"hy"+1
d[mr],d[ms]=d[ms],d[mr]
oj(_ENV:et"ey",d)
_ENV:rn"ai"
end,
h=d[t]
}
end)
e.ed=ai.e.ed
end,function(_ENV)
local d=_ENV:io"ey"
e:ta(v[[,1,2,3,4,5,6]],function(t)
local tn=p.d[t]:mk()or p.c.tj==p.d[t]or p.d[t].er==1
return{
tn=tn,
el=function()
_ENV:th()_ENV:th()
lq(p,p.d[t])
end,
h=p.d[t]
}
end)
end,function(_ENV)
local td,tz=td,tz
if td.ov==tz.ov then tz.ov+=_sgn(_rnd"2"-1)end
p=td.ov>tz.ov and td or tz
end,function(_ENV,ll)
local cv=true
for t=tv.e.ed+ll,75.5+75.5*ll,ll do
if tb[t]:nn()then
tv.e.ed=t
cv=false
tm"154"
break
end
end
if cv then av()end
fm(_ENV)
end,function(o)tm(o:et"tv")end,function()tm(ew"152")end,function(_ENV)tm(p.c.i)end,function(_ENV)
local d={}
for lp,i in _pairs(_split"133,7,35,1,25,4")do
lj(d,lp,i)
_poke(0x5e5a+i,1)
end
if@0x5efc==0 then
_poke(0x5efc,1)
oj(0,d)
end
tw=mp[[et,%bj,x,%bk,ag,%by,th,%bv,rn,%bb,h,%k,tg,%k,ty,%k,es,%k,en,%k,oc,ix;fb;e,%ac,of,error,kq,%k,ea,%k,ux,%av,sk,%k,tg,%bx,uf,%ac,ty,%fi,es,%k,en,%k;ix;ea,~vs,es,~fs,en,~fn;tv;ea,%ks,es,%dm,en,%du;pn;ea,%fm,es,%dm,en,%du,ux,%kn,sk,%ki;ai;ea,%vk,es,%dl,en,%dh,ty,%dd;hy;ea,%yn,es,%dl,en,%dh,ty,%dd;ec;ea,%wj,es,%dm,en,%du;cl;ea,%ya,es,%dl,en,%dh;uw;ea,%yj,es,%lx,en,%sl,uf,af;re;ea,%wq,es,%wz,en,%sl;af;ea,%ye,es,%lx,en,%sl;cy;ea,%ys,es,%lx,en,%sl;ey;of,player,ea,%so,es,%ni,en,%no,sw,%ac,ob,%yo;cd;of,player,ea,%so,es,%ni,en,%no,sw,%ak,ob,%yr;cc;of,player 1,ea,%so,es,%ni,en,%no,sw,%ak,ob,%vn;cu;of,player,ea,%so,es,%ni,en,%no,sw,%ak,ob,%vr;hg;of,player 2,ea,%so,es,%ni,en,%no,sw,%ak,ob,%vi;hp;of,trainer,ea,%vg,es,%ni,en,%no;lb;ea,%vy,es,%vv,en,%vb,sk,%vw;le;ea,%yu,es,%rf,en,%ym;cz;ea,%yc,es,%rf,en,%sl;hz;ea,%yl,es,%rf,en,%yd,ty,%dd;gy;tc,gg,ea,%mv,tg,%k,ty,%k,us,td;gg;tc,cs,ea,%mv,tg,%k,ty,%k,us,tz;cs;tc,gy,ea,%wv,tg,%wb,ty,%wx,es,%rf,en,%wk,is,%ac;fj;ea,%kt,es,%fs,en,%fn,sk,%ke;]]
ep(function(ik,kf,...)
tw[ik].e=kf(...)
end,[[;,tv,~tl,~ht,4;;,pn,~rq,~tf;;,fj,~rq,~tf;;,lb,~rq,~tf;;,ai,~tl,~ht,3;;,hy,~tl,~ht,3;;,ix,~tl,~tf;;,cl,~tl,~tf;;,uw,~tl,~tf;;,re,~tl,~tf;;,af,~tl,~tf;;,cy,~tl,~tf;;,ey,~tl,~tf;;,hp,~tl,~tf;;,hg,~tl,~tf]])
ez(tw,[[hw,@,ky,@;ix;e;nc,%av;le;e;nc,%av;cu;e,~hw;cc;e,~hw;cd;e,~hw;ec;e,~ky;]],tw.ey.e,tw.tv.e)
tm"152"
_menuitem(1,"close picodex",function()
_menuitem(1)
_menuitem(2)
_ENV:ay"dv"
end)
_menuitem(2,"swap 🅾️/❎",function()
_poke(0x5eff,@0x5eff==0 and 1 or 0)
end)
end,function(gd)
gd.tw:eb()
end,function()ne.tw:ty()end,function()ne.tw:es()end,function()ne.tw:en()end,function(_ENV)e.tg(_ENV)end,function(_ENV)e.ty(_ENV)end,function(_ENV,ik)
return _ENV[ik].e.ed
end,function(_ENV,ik)
local e=ik and _ENV[ik].e or e
return e[e.ed+1]
end,function()
_sfx(-2,1)
end,function(_ENV)
_menuitem(1,"factory reset",function()
_memset(0x5e00,0,0x100)
_ENV:ay"cq"
end)
end,function()
return _btn()& 0x3f ~=0
end,function(_ENV)
if not fw()and hd then
hd=false
_ENV:ay()
_menuitem(1)
elseif fw()then
hd=true
_menuitem(1)
end
end,0,function(i)
_g.mm=_max(0,0+i-152)
_sfx(54+i\16,0,i%16*2,2)
end,function(_ENV)
_cls"0"
rm(0,128+_sin(_ENV:mc"um"/4)*128,function()
ep(na,[[;,aMORG gAMES,64,-68,7,0;;,pRESENTS,64,-61,7,0;;,a pICO-8 pOKEDEX sIM,64,15,7,0]])
ep(ww,[[;,102,64,11,5,1]])
local ch,
dj,
oi=
tw and tw.ix.e.ed,
tw and tw.ck-1,
at=="rs"and 1
or at=="ir"and-1
or(at=="li"and-1 or 1)*_cos(_ENV:mc(at)/2)
rm(30-(oi+1)*15+(oc=="cq"and ew"3"-1 or 0),27,function()
ep(_rectfill,[[;,14,18,@,87,5]],63+_max(0,oi*54))
if ok==0 then
ep(_rectfill,[[;,14,18,117,87,13]])
ep(vx,[[;,14,21,40,40,@;;,71,18,46,13,@;;,71,67,46,21,@]],ty,es,en)
end
ep(_map,[[;,24,0,2,1,8,3;;,8,0,2,9,8,11]])
ep(function(ah,gx,gv,wg,g,w)
return _spr((ok<=ah)and(mm==ah and _stat"46">=0 and wg or gv)or gx,g,w)
end,[[;,0,135,133,134,6,3;;,1,132,128,131,12,3;;,2,132,129,131,17,3;;,3,132,130,131,22,3]])
ep(function(hc,gs,gn,g,w)
_spr(_btn(hc)and gs or gn,g,w)
end,[[;,0,186,154,10,77;;,1,188,156,26,77;;,2,171,139,18,73;;,3,187,155,18,81;;,4,170,138,42,77;;,5,172,140,50,77]])
if oi<=0 then
mx(0,2+64*(1-_abs(oi)),_abs(oi))
if oi==-1 and hd then _spr(123,6,49)end
else
mx(16,62,oi)
if oi==1 then
if ch then _spr(153,70+ch*8,41)end
if dj and dj>=0 then _spr(153,70+dj*8,49)end
end
end
end)
end)
end,function(km,cw,ap)
ap*=64
for w=9,96 do
_tline(cw,w,cw+ap-1,w,km,w/8-1.125,8/ap,0)
end
end,function(am,g,w,nd)
local cg,cp="",""
for t=1,#am do
local me,cb=_sub(am,t,t),t%2==0
cg..=cb and " "or me
cp..=cb and me or " "
end
na(cg,g,w,nd,0)
na(cp,g,w+1,nd,0)
end,function(am,g,w,nd,pd)
am=""..am
if pd==0 then g-=#am*2
elseif pd>0 then g-=#am*4+1 end
_print(am,g,w,nd)
end,function(nf,ct,id,rc,gi)
_clip(-%0x5f28+nf,-%0x5f2a+ct,id,rc)
rm(nf,ct,gi)
_clip()
end,function(_ENV)
if i>=0 then
return not tv or@(0x5e5a+i)>0
end
end,function(h)
oq("pkmn #"..h.i)
end,function(h)
if h:nn()then
ab(h.s.."|"..sy[h.ot].s.."|"..sy[h.op].s)
else
ab"?????????|????|??????"
end
end,function(i,g,w,ap,im)
local hq,db=i/8\1,i%8
if hq ~=mu then
mu=hq
_memcpy(0x0000,0x8000+0x400*hq,0x400)
end
local id,rc=16*ap,16*im
_sspr(db*16,0,16,16,g-id/2,w-rc/2,id,rc)
end,function(_ENV,g,w,db,il,nm)
local i=_ENV:nn()and i or-1
if i==25 and _ENV:lz(53)then i=152 end
if i==54 and _ENV:lz(143)then i=153 end
if ow and ow>0 then i=154 end
if not wd or er ~=1 and not wu and not(ae ~=0 and ef.az==sh)then
if i<0 then _spr(107,g-4,w-4)return end
il,nm=il or 1,nm or 1
local nv=_max(_abs(il),1)\ 1
ep(function(nd,pg,pp,pf,pm)
for ed=1,15 do _pal(ed,nd)end
for t=-nv,nv,nv*2 do
dc(i,g+(pg or t),w+(pp or t),il,nm)
dc(i,g+(pf or t),w+(pm or t),il,nm)
end
end,[[;,@,@,%ac,@,%ac;;,1,%ac,0,0,%ac]],db,-nv,nv)
_pal()dc(i,g,w,il,nm)
end
end,function(e,h)
e:ta{}
ez(e,[[;h,@;;lg,%ak;;s,lvl 50,ts,5;;s,@]],h,(h.ek or h.tu).."/"..h.tu)
_foreach(_split"tx,te,em,tr,sq",function(eh)
_add(e,{s=pt[eh].ny.." "..h[eh]})
end)
ep(function(s,eh)
if #tb[h.i][eh]>0 then
_add(e,{s=s,ts=5})
_foreach(tb[h.i][eh],function(eu)
_add(e,{s=sb[eu].s})
end)
end
end,[[;,learn,iy;;,teach,iw;;,event,rl]])
end,function(o)o:ag"hp" end,function(o)o:ag"hg" end,function(_ENV)
fg(_ENV,
{sd(_ENV:et"ey"),"player 1",false,k},
{sd(_ENV:et"hg"),"player 2",false,k}
)
end,function(_ENV)
local uc={}
for t=1,152 do _add(uc,t%152)end
fp(_ENV,uc,"horde",function(kx,to)
mw(to)
_poke(0x5efe,_mid(@0x5efe,#dn(to.d),255))
end)
end,function(o)
o:ag"ai"
end,function(o,et)
return sd(o:et(et))
end,function(o)
local d=sd(o:et"ey")
return d[o:et"ai"+1],d
end,function(u,h)
u.c=yi(h)
return si(u,"|comes|out")
end,function(u,h)
sm(u,u,"|comes|back",function(tq)
tq.r.wu=true
sm(u,u,false,function()
_add(u.ih,rg(u,h))
end)
end)
u.ov=3000
end,function(m,a)
sm(m,m,"|uses|"..a.s,function(tq)
tq.a=a
local _ENV=tq
if a.i>0 then
a.on-=1
end
if a.i==47 or a.i==36 then
nr(_ENV,r.ek)
end
if vz(r,f,a)then
y(m,"|missed|"..a.s)
if a.i==145 or a.i==73 then
nr(_ENV,1)
end
else
if a.tt ~=0 then
f.lc=a.i
end
if a.al(_ENV)then
y(m,"|failed|"..a.s)
end
end
end)
end,function(_ENV,oe,we)
if not ef and ae==0 then
ae,ef=oe,we
end
end,function(m,a)
sm(m,m,false,function(tq)
tq.a=a
local _ENV=tq
r:rx("ae",k)
if r.er==6 then
r:rx("cj",function()
y(m,"|suddenly|woke up")
r.tj.er=0
end)
if r.er==6 then
y(m,"|fast|asleep")
return
end
end
if r.er==3 then
if _rnd"1"<.2 then
y(m,"|thawed|out")
r.tj.er=0
else
y(m,"|is|frozen")
return
end
end
if f.ef and f.ef.az==ns then
y(m,"|is|trapped")
return
end
if r.nl==a.ev then
y(m,"|is|disabled")
return
end
if r.hs>0 and ew"2"==0 then
y(m,"|confuse|damage")
nr(_ENV,he(r,f,ej(-1)))
return
end
if r.er==4 and ew"4"==0 then
y(m,"|fully|paralyzed")
return
end
if r.mf then
y(m,"|is|flinching")
return
end
de(m,a)
end)
end,function(c,eh,ho)
if c[eh]>0 then
c[eh]-=1
if c[eh]==0 then
ho()
end
end
end,function(m)
return si(m,false,function(_ENV)
if r.er==6 or r.er==3 then
r.ae=0
end
if r.ae==0 then
r.ef=nil
end
local hk=_max(r.tu\16,1)
local lf=function(pv)
y(m,pv.."|damage")
nr(_ENV,hk)
end
if r.er==5 then
if r.np>0 then
hk*=r.np
r.np+=1
end
lf"|poison"
end
if r.er==2 then lf"|burn" end
if r.ga then
lf"|seed"
if f.ek<f.tu then
y(to,"|seed|leeching")
ry(_ENV,to,hk)
end
end
r:rx("hs",function()
y(m,"|confusion|ended")
end)
r:rx("dg",function()
y(m,"|"..r.z[r.nl].s.."|enabled")
r.nl=0
end)
end)
end,function(u,a)
u.ih={}
local lt=1000
yp(u,a)
if a.i==120 then lt=2000 end
if a.i==18 or a.i==4 or a.i==89 or a.i==30 then
lt=0000
end
u.ov=_min(3000,lt+u.c:ie"tr")
end,function(o,u)
return u==o.td and o.tz or o.td
end,function(lo,iv,ld,s)
return{u=lo,s=s or lo.c.s,c=lo.c,iv=iv,ld=ld or k}
end,function(p,...)
_add(p.ih,si(...))
end,function(o)
if st then av()end
if nt then tm"154" end
if nt or not o.is then
while true do
for aq in _all{o.td,o.tz}do
if not rv(aq.d)then
o.p=nh(o,aq)
o:ay"lb"
return
end
end
local ax=yb(o)
if ax then
local ce=ax.c==o.td.c and o.td or o.tz
local ii=v([[a,@,m,@,to,@,y,@]],a,ce,nh(o,ce),function(...)
sm(ce,...)
end)
ii.r=ii.m.c
ii.f=ii.to.c
ax.ld(ii)
if ax.iv then
o.is=ax
return
else
end
else
o:ay()
return
end
end
end
end,function(o)
for aq in _all{o.td,o.tz}do
if aq.c.ek<=0 then
if aq.c.er ~=1 then
return si(aq,"|is|fainted",function(_ENV)
r.tj.er=1
end)
elseif aq ~=o.p then
return rg(aq,rv(aq.d))
end
end
end
for ar in _all{o.p,nh(o,o.p)}do
local gj=nh(o,ar)
while #ar.ih>0 do
local ax=_deli(ar.ih,1)
if ax.c.er ~=1 and(ax.c==ar.c or ax.c==gj.c)then
return ax
end
end
if ar.c.ek<=0 and ar.c.er==1 then
return rg(ar,rv(ar.d))
end
if not ar.cn then
ar.cn=true
return yg(ar)
end
end
end,function(_ENV,wt)
for eu in _all(z)do
if eu.i==wt then
return true
end
end
end)
ez(_g,[[mk,@,rk,@,fh,@,yh,@,vl,@,vz,@,fr,@,da,@,he,@,mv,@,yf,@,fg,@,fp,@,dr,@,lk,@,lv,@,mb,@,vc,@]],function(_ENV)
return #rk(_ENV,true)==0
end,function(h,wh)
local aw={}
_foreach(h.z,function(eu)
if eu.i>0 and(wh or eu.on>0 and h.nl ~=eu.ev)then
_add(aw,eu)
aw[eu]=true
end
end)
return aw
end,function(_ENV)
if ae ~=0 then
return{ef}
else
return rk(_ENV)
end
end,function(c)
local nb=fh(c)
return nb[ew(#nb)+1]or ej(0)
end,function(_ENV,nj)
local dp=1024
if nj==-1 then return 1 end
if nj==107 or nj==164 or nj==57 or nj==157 then dp*=.3 end
if wp then dp*=.3 end
return _rnd"1"<_min(.99,(dz+76)/dp)and 2 or 1
end,function(au,as,a)
if a.tt<=0 then return false end
if(a.az==ss or a.az==sh)and not au.ef then return false end
if as.ef and as.ef.az==sh then return true end
if au.ef and au.ef.az==ns then return false end
return _rnd(as:ie"ol")>a.tt/100*au:ie"tt"or ew"256"==0 and ew"256"==0
end,function(wa,gm)
return sy[wa][gm]or 1
end,function(a,as)
return fr(a.og,as.ot)*fr(a.og,as.op)
end,function(au,as,a)
local te,em=au:ie"tx",as:ie"tx"
if a.og%2==1 then
te,em=au:ie"te",as:ie"em"
if as.gh then
em*=2
end
elseif as.go then
em*=2
end
local kb=_mid(
3,997,
(2*au.uz*vl(au,a.i)/5+2)/50
*a.dy
*_mid(10,.2,te/em)
)+2
return kb
*((a.og==au.ot or a.og==au.op)and 1.5 or 1)
*da(a,as)
*(_rnd".15"+.85)\1
end,function(_ENV)
p=_ENV[us]
do local _ENV=p.c
hn,mf=0,false
end
p.cn=false
if p.wl then
rp(p,yh(p.c))
_ENV:ay()
elseif #p.ih>0 then
_ENV:ay()
else
le.e,
cz.e,
hz.e,
is,
oo[#oo]=p.ub,
p.wn,
p.wi,
si(p,""),
oc
_ENV:ag"le"
end
end,function(_ENV)
_ENV:th()
p=_ENV:nh(p)
_ENV:ay"lb"
end,function(_ENV,fx,fk)
fx.eh,fk.eh="td","tz"
for dw in _all{fx,fk}do
_ENV[dw.eh]=v([[ih,#,ov,1,ub,@,wn,@,wi,@,d,@,s,@,wl,@,pc,@]],tl(tf),
tl(tf),
tl(ht,3),
_unpack(dw))
local _ENV=_ENV[dw.eh]
ub.nc=av
_add(ih,rg(_ENV,rv(d)))
end
p=td
_ENV:ag"cs"
end,function(_ENV,uo,s,gu)
local fz={}
for t=1,#uo do
lj(fz,t,uo[t])
end
fg(_ENV,
{_ENV:io"ey","player",false,gu},
{fz,s,true,k}
)
end,function(iq)
mb(_peek2(iq),
function(...)return lk(0x8000+iq*0x1000,...)end,
function(...)return lv(0x8000+iq*0x1000,...)end)
end,function(ln,g,w)
g=_min(_max(0,g),127)\1
w=w\1
local q=_peek(w*64+ln+g\2)
if g%2==1 then return(q & 0xf0)>>>4
else return(q & 0x0f)end
end,function(ln,g,w,q)
g=_min(_max(0,g),127)\1
w=w\1
local lh=w*64+ln+g\2
local ud=_peek(lh)
if g%2==1 then _poke(lh,(ud & 0x0f)|(((q or 0)& 0x0f)<<4))
else _poke(lh,(ud & 0xf0)|(((q or 0)& 0x0f)<<0))
end
end,function(cx,lk,lv)
local function ci(ah,q)
local b,t=ah[1],1
while b!=q do
t+=1
b,ah[t]=ah[t],b
end
ah[1]=q
end
local hl,hh=0,0
function md(nu)
if hh<8 then
hh+=8
hl+=@cx>>hh
cx+=1
end
hl<<=nu
local q=hl&0xffff
hl^^=q
hh-=nu
return q
end
function iz(n)
local nu=0
repeat
nu+=1
local co=md(nu)
n+=co
until co<(1<<nu)-1
return n
end
local id,wf,kc,df,ut,g,w,hx,la=iz"1",iz"0",iz"1",{},{},0,0,0
for t=1,iz"1" do _add(df,md(kc))end
for w=0,wf do
for g=0,id-1 do
hx-=1
if(hx<1)then
hx,la=iz"1",not la
end
local tk=w>0 and lk(g,w-1)or 0
local ah=ut[tk]or{_unpack(df)}
ut[tk]=ah
local b=ah[la and 1 or iz"2"]
ci(ah,b)
ci(df,b)
lv(g,w,b)
end
end
end,function(eb)
tm(eb.ri)
eb:ro()
end)
_g.dx=v[[-1;,none,%l;0;,struggle,%rw;;,megapnch,%l;;,razrwind,%ss;;,sworddnc,%ex,%ee,te,2;;,whrlwind,%fa;;,megakick,%l;;,toxic,%yz;;,horndril,%dt;;,bodyslam,%l,30,%ei,4;;,takedown,%rw;;,doubedge,%rw;;,bublbeam,%l,10,%eo,%ee,tr,-1;;,watergun,%l;;,icebeam,%l,10,%ei,3;;,blizzard,%l,10,%ei,3;;,hyprbeam,%bc;;,payday,%l;;,submsion,%rw;;,counter,%bp;;,seistoss,%aa,50;;,rage,%bn;;,megdrain,%rb;;,solrbeam,%ss;;,drgnrage,%aa,40;;,thndrblt,%l,10,%ei,4;;,thunder,%l,10,%ei,4;;,earthqke,%l;;,fissure,%dt;;,dig,%sh,digging;;,psychic,%l,30,%eo,%ee,tx,-1;;,teleport,%be;;,mimic,%bl;;,doubteam,%ex,%ee,ol,1;;,reflect,%ex,%oz,|raises|defense,gh;;,bide,%bw;;,metrnome,%bd;;,selfdstr,%l;;,eggbomb,%l;;,fireblst,%l,30,%ei,2;;,swift,%l;;,skulbash,%ss;;,softboil,%fo;;,dreameat,%bm;;,skyattck,%ss;;,rest,%bi;;,thndrwav,%ei,4;;,psywave,%bs;;,explsion,%l;;,rockslid,%l;;,triattck,%l;;,substute,%ba;;,cut,%l;;,fly,%sh,flying;;,surf,%l;;,strength,%l;;,flash,%eo,%ee,tt,-1;;,pound,%l;;,karatchp,%l;;,doubslap,%ia;;,comtpnch,%ia;;,firepnch,%l,10,%ei,2;;,icepnch,%l,10,%ei,3;;,thndpnch,%l,10,%ei,4;;,scratch,%l;;,vicegrip,%l;;,guilotin,%dt;;,gust,%l;;,wingatck,%l;;,bind,%ns;;,slam,%l;;,vinewhip,%l;;,stomp,%l,30,%eo,%it;;,doubkick,%sr,2,%k;;,jumpkick,%l;;,rllngkck,%l,30,%eo,%it;;,sandatck,%eo,%ee,tt,-1;;,headbutt,%l,30,%eo,%it;;,hornatck,%l;;,furyatck,%ia;;,tackle,%l;;,wrap,%ns;;,thrash,%ft;;,tailwhip,%eo,%ee,em,-1;;,psnsting,%l,20,%ei,5;;,twineedl,%br;;,pinmisil,%ia;;,leer,%eo,%ee,em,-1;;,bite,%l,10,%eo,%it;;,growl,%eo,%ee,te,-1;;,roar,%fa;;,sing,%ei,6;;,sprsonic,%eo,%sn;;,sonicbom,%aa,20;;,disable,%bf;;,acid,%l,10,%eo,%ee,em,-1;;,ember,%l,10,%ei,2;;,flamthwr,%l,10,%ei,2;;,mist,%ex,%oz,|stat lower|immunity,wo;;,hydropmp,%l;;,psybeam,%l,10,%eo,%sn;;,aurorabm,%l,10,%eo,%ee,te,-1;;,peck,%l;;,drillpck,%l;;,lowkick,%l,30,%eo,%it;;,absorb,%rb;;,leechsed,%eo,%oz,|is now|seeded,ga;;,growth,%ex,%ee,tx,1;;,razrleaf,%l;;,psnpowdr,%ei,5;;,stunspor,%ei,4;;,slppowdr,%ei,6;;,petldanc,%ft;;,strngsht,%eo,%ee,tr,-1;;,firespin,%ns;;,thndshck,%l,10,%ei,4;;,rockthrw,%l;;,cnfusion,%l,10,%eo,%sn;;,hypnosis,%ei,6;;,meditate,%ex,%ee,te,1;;,agility,%ex,%ee,tr,2;;,quickatk,%l;;,ngtshade,%aa,50;;,screech,%eo,%ee,em,-2;;,recover,%fo;;,harden,%ex,%ee,em,1;;,minimize,%ex,%ee,ol,1;;,smokscrn,%eo,%ee,tt,-1;;,cnfusray,%eo,%sn;;,withdraw,%ex,%ee,em,1;;,dfnscurl,%ex,%ee,em,1;;,barrier,%ex,%ee,em,2;;,lghtscrn,%ex,%oz,|raises|spcdefense,go;;,haze,%bu;;,fcsenrgy,%ex,%oz,|raises|crit ratio,wp;;,mirrmove,%bh;;,lick,%l,30,%ei,4;;,smog,%l,30,%ei,5;;,sludge,%l,30,%ei,5;;,boneclub,%l,10,%eo,%it;;,watrfall,%l;;,clamp,%ns;;,spikcann,%ia;;,constrct,%l,10,%eo,%ee,tr,-1;;,amnesia,%ex,%ee,tx,2;;,kinesis,%eo,%ee,tt,-1;;,hijmpkck,%l;;,glare,%ei,4;;,poisngas,%ei,5;;,barrage,%ia;;,leechlif,%rb;;,lovekiss,%ei,6;;,tranform,%yq;;,bubble,%l,10,%eo,%ee,tr,-1;;,dizypnch,%l;;,spore,%ei,6;;,splash,%bo;;,acidarmr,%ex,%ee,em,2;;,crabhamr,%l;;,furyswps,%ia;;,bonerang,%sr,2,%k;;,hyprfang,%l,10,%eo,%it;;,sharpen,%ex,%ee,te,1;;,convrson,%bg;;,suprfang,%bt;;,slash,%l]]
pa=v[[;j,13,sa,1,nk,5;;j,6,sa,13,nk,13;;j,5,sa,1,nk,5;;j,6,sa,5,nk,5;;j,1,sa,13,nk,5]]
pe=v[[0,0x5e00,1,0x5e1e,2,0x5e3c]]
mu=16
function _init()
local _ENV=_g
_memset(0x8000,0,0x7fff)
ne=mp[[oc,pu;ea,%vc,ok,4;fb;at,ir,ok,4,ri,-1,hd,%ac,ro,%k,tg,%k,ti,%k,ty,%k,es,%k,en,%k,tw,;pu;tc,um,an,.5,ti,%ad;um;tc,ir,an,.5,ti,%ad,ro,%yv;cq;at,ir,tc,ir,an,.5,ti,%ad;ir;at,ir,tc,li,ro,%ko,ti,%ad,tg,%ka;li;at,li,tc,pz,an,.2,ti,%ad;pz;at,rs,tc,pq,ok,3,an,.2,ri,155,ti,%ad;pq;at,rs,tc,pj,ok,2,an,.2,ri,154,ti,%ad;pj;at,rs,tc,o,ok,1,an,.2,ri,153,ti,%ad;o;at,rs,tc,dv,ok,0,ro,%vu,ti,%ad,tg,%vd,ty,%vp,es,%vf,en,%vm;dv;at,dv,tc,ir,an,.25,ti,%ad,tg,%k;]]
ad(ne)
_flip()
tm"158"
dr(0x0)
dr(0x2)
dr(0x4)
ep(_poke,[[;,0x5f5c,8;;,0x5f5d,2;;,0x5f56,0xe0]])
mb(_peek2"0x6",_mget,_mset)
yy()
yw()
local cr=_peek2"0xc"
for t,b in _pairs(dk)do
local ng={s=b}
for ma=1,6 do
_add(ng,_peek(cr))
cr+=1
end
dk[t]=ng
end
_memcpy(0x0000,0xc000,0x2000)
end
function _update60()
local _ENV=_g
st,nt=_btnp"4",_btnp"5"
ly,lw=fu(_btnp,0,1),fu(_btnp,2,3)
if@0x5eff==1 then
st,nt=nt,st
end
ne:eb()
end
function _draw()
local _ENV=_g
ne:ti()
end