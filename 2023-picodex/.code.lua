function rd(ei,table,gm)
if _ord(ei)==126 then return table[_sub(ei,2)]
elseif ei=="@"then return _deli(gm,1)
elseif ei=="#"then return{}end
return ei ~=""and ei or nil
end
function to(table,hw,...)
local tk,pk,oc={...},_split(hw,";"),table
_foreach(pk,function(ip)
local im=_split(ip)
if #im>1 then
if im[1]==""then
_foreach(im,function(ei)
_add(oc,rd(ei,table,tk))
end)
else
for t=1,#im,2 do
oc[im[t]]=rd(im[t+1],table,tk)
end
end
oc=table
else
if ip==""then ip=#oc+1 end
if _type(oc[ip])~="table"then
oc[ip]={}
end
oc=oc[ip]
end
end)
return table
end
function w(...)
return to(_setmetatable({},{__index=_g}),...)
end
to(_g,[[oe,@,tg,@,kr,@,er,@]],true,false,"",function(...)return...end)
to(_g,[[mc,@,fw,@,al,@,fg,@,fp,@,ry,@,th,@,ay,@,w,@,to,@,rd,@,wg,@,ab,@,ew,@,ef,@,rc,@,oq,@,aw,@,tm,@,ks,@,po,@,pa,@,sb,@,pe,@,kh,@,sv,@,dv,@,tz,@,rq,@,tn,@,bv,@,bx,@,bb,@,bw,@,by,@,bk,@,tl,@,ht,@,mx,@,yb,@,ie,@,bu,@,mq,@,br,@,yx,@,bf,@,bd,@,rg,@,ft,@,bh,@,bs,@,fe,@,yq,@,dn,@,ev,@,z,@,j,@,yj,@,bt,@,ee,@,oz,@,it,@,sn,@,be,@,bo,@,bp,@,mz,@,ss,@,sl,@,sr,@,bl,@,mp,@,ba,@,bm,@,sh,@,ia,@,bn,@,rp,@,h,@,bc,@,rw,@,de,@,bi,@,yz,@,mj,@,tq,@,nh,@,sm,@,fr,@,yg,@,rj,@,yo,@,mf,@,di,@,da,@,rb,@,ye,@,lj,@,sc,@,oj,@]],function(pv)
return to(w[[re,0,cb,0,mt,~oe,q,~er,ty,~er,oo,#;]],pv)
end,function(_ENV,es)
if es==is then
return at and re/at or 0
end
if _ENV[es]and _ENV[es].kt then
return 1
end
return 0
end,function(_ENV,ro)
rn=ro or td
end,function(_ENV,ro)
re,rn,mt,td,at=0
_ENV[is].kt=true
for lc,b in _pairs(fy)do _ENV[lc]=b end
for lc,b in _pairs(_ENV[ro])do _ENV[lc]=b end
is=ro
_ENV:q()
cb=#oo
end,function(_ENV)
re+=1/60
if mt then _ENV:fg(is)end
if at and re>=at then
_ENV:al()
end
while rn do
_ENV:fg(rn)
end
_ENV:ty()
end,function(_ENV,pg)
while rn ~=pg and #oo>0 do
_ENV:th()
end
end,function(_ENV)
_deli(oo)
_ENV:al(oo[#oo]or "iz")
end,function(_ENV,uc)
_add(oo,uc)
_ENV:al(uc)
end,w,to,rd,function(pz,p,g,af,ig,...)
af,ig=af or 1,ig or 1
_spr(pz,p-af*4,g-ig*4,af,ig,...)
end,function()
ti"153"
end,function(p)
return _flr(_rnd(p))
end,function(ar,au,...)
_foreach(w(au,...),function(tk)
ar(_unpack(tk))
end)
end,function(gj,gx,ar)
local ur,us=%0x5f28,%0x5f2a
_camera(ur-gj,us-gx)
ar()
_camera(ur,us)
end,function(ax)
ni(ax or "",23,4,1,0)
end,function(hw)
ef(_rectfill,[[;,0,0,45,6,1]])
ef(ni,[[;,@,23,1,13,0;;,@,23,8,1,0;;,@,23,15,1,0]],_unpack(_split(hw,"|",false)))
end,w[[]],_split"missingno,bulbasaur,ivysaur,venusaur,charmander,charmeleon,charizard,squirtle,wartortle,blastoise,caterpie,metapod,butterfree,weedle,kakuna,beedrill,pidgey,pidgeotto,pidgeot,rattata,raticate,spearow,fearow,ekans,arbok,pikachu,raichu,sandshrew,sandslash,nidoran f,nidorina,nidoqueen,nidoran m,nidorino,nidoking,clefairy,clefable,vulpix,ninetales,jigglypuff,wigglytuff,zubat,golbat,oddish,gloom,vileplume,paras,parasect,venonat,venomoth,diglett,dugtrio,meowth,persian,psyduck,golduck,mankey,primeape,growlithe,arcanine,poliwag,poliwhirl,poliwrath,abra,kadabra,alakazam,machop,machoke,machamp,bellsprout,weepinbell,victreebel,tentacool,tentacruel,geodude,graveler,golem,ponyta,rapidash,slowpoke,slowbro,magnemite,magneton,farfetchd,doduo,dodrio,seel,dewgong,grimer,muk,shellder,cloyster,gastly,haunter,gengar,onix,drowzee,hypno,krabby,kingler,voltorb,electrode,exeggcute,exeggutor,cubone,marowak,hitmonlee,hitmonchan,lickitung,koffing,weezing,rhyhorn,rhydon,chansey,tangela,kangaskhan,horsea,seadra,goldeen,seaking,staryu,starmie,mr mime,scyther,jynx,electabuzz,magmar,pinsir,tauros,magikarp,gyarados,lapras,ditto,eevee,vaporeon,jolteon,flareon,porygon,omanyte,omastar,kabuto,kabutops,aerodactyl,snorlax,articuno,zapdos,moltres,dratini,dragonair,dragonite,mewtwo,mew",w"0,none;,fainted,burned,frozen,paralyzed,poisoned,sleeping",w"0,NON;,FNT,BRN,FZN,PAR,PSN,SLP",w[[0;k,0,s,~kr;1;k,0,s,normal,15,0,13,.5;2;k,5,s,fire,8,2,10,2,11,2,2,.5,4,.5,13,.5,14,.5;3;k,2,s,fighting,10,2,1,2,13,2,15,0,11,.5,9,.5,5,.5,12,.5;4;k,4,s,water,2,2,7,2,13,2,14,.5,8,.5,4,.5;5;k,1,s,poison,11,2,8,2,15,.5,7,.5,5,.5,13,.5;6;k,6,s,electric,9,2,4,2,7,0,14,.5,6,.5,8,.5;7;k,2,s,ground,6,2,2,2,5,2,13,2,9,0,11,.5,8,.5;8;k,3,s,grass,7,2,13,2,4,2,11,.5,14,.5,2,.5,9,.5,8,.5,5,.5;9;k,0,s,flying,11,2,3,2,8,2,6,.5,13,.5;10;k,4,s,ice,14,2,9,2,8,2,2,.5,10,.5,4,.5;11;k,3,s,bug,8,2,12,2,3,.5,2,.5,9,.5,15,.5,5,.5;12;k,1,s,psychic,3,2,5,2,12,.5;13;k,0,s,rock,11,2,2,2,9,2,10,2,3,.5,7,.5;14;k,0,s,dragon,14,2;15;k,1,s,ghost,15,2,1,0,12,0;17;k,0,s,bird;]],w[[tc,hp,tb,spc,ez,att,em,def,tr,spd,sz,tot,te,acc,od,eva]],w[[0;k,6,om,13;;k,14,om,4;;k,9,om,4;;k,11,om,3;;k,12,om,5;;k,8,om,2;;k,10,om,4]],w[[]],_split"youngstr,bugcatch,junior,brock,lass,hiker,swimmer,misty,gentlman,sailor,rocker,ltsurge,channelr,gambler,beauty,erika,biker,birdkeep,juggler,koga,blckbelt,rocket,psychic,sabrina,scientst,pkmaniac,suprnerd,blaine,cooltrnr,fishrman,tamer,giovanni,lorelei,bruno,agatha,lance,blue,green,red,legendry",function(o,eu)
if eu.ej then
o:ay(eu.ej)
else
o:th()
end
end,function(sg,sj)
return w([[sg,@,sj,@,b,~sj,eg,1,ty,~bw,aa,~bk,nu,~bx,tt,~bv]],sg,sj or 0)
end,function(sg,eg)
return to(rq(sg),[[el,0,eg,@,ty,~by,hk,~bb]],eg or 1)
end,function(e,fb,wi)
while _deli(e)do end
for t=1,#fb do
_add(e,(wi or er)(fb[t],t))
end
end,function(o)
o:th()
ti"154"
end,function(e,ho,wd)
if wd then
local az=e.el+ho*e.eg
if az==_mid(0,az,#e-1)then
e.el=az
if 0+ho ~=0 then ti"154" end
else
ab()
end
else
local az=e.el+ho
local uq=e.el-e.el%e.eg
if az==_mid(uq,az,uq+e.eg-1)then
e.el=az
if 0+ho ~=0 then ti"154" end
else
ab()
end
end
e.el=_mid(0,e.el,#e-1)
if e.el\e.eg<e.b then e.b=e.el\e.eg end
if e.el\e.eg>e.b+2 then e.b=e.el\e.eg-2 end
e.b=_mid(0,e.b,(#e-1)\e.eg)
end,function(o)
local e=o.e
if st then e.nu(o)end
if no then o:sx()end
e.b+=lw
if ly ~=0 then o:uk(ly)end
local gb=e.b
e.b=_mid(e.sj,e.b,#e-3)
if e.b ~=gb then
ab()
elseif lw ~=0 then
ti"154"
end
end,function(o)
local e=o.e
e:hk"0"
e:hk(lw,true)
e:hk(ly)
if no then
local eu=e[e.el+1]
if eu.tu then
ab()
elseif eu.eh then
ti"155"
eu.eh(o,eu)
end
end
if st then e.nu(o)end
end,function(o)
local e=o.e
local hs=e.eg>1 and 10 or 40
local np=20-(e.eg*hs)/2
ef(_rectfill,[[;,0,0,39,39,1;;,0,@,39,@,13]],5-e.b*10,4+(_max(_ceil(#e/e.eg),3)-e.b)*10)
for t=-1,e.eg*5-1 do
local ne=(e.b-1)*e.eg+t+1
local eu=e[ne]
if eu then
local ra,p,g=eu.ts or 1,np+t%e.eg*10,t\e.eg*10
if eu.tu then ra=3 end
if ne-1==e.el then ra+=1 end
if not eu.lg then
_rectfill(p,g-5,p+hs-1,g+4,pt[ra].k)
rc(t%e.eg*hs+np+hs/2,t\e.eg*10-3,function()
e.sg(eu,pt[ra])
end)
end
end
end
end,function(eu,ts)
if eu.d then
local ts=kh[sb[eu.d.ot].k]
ef(_rectfill,[[;,-20,-2,19,17,@;;,-20,14,19,17,@]],ts.k,ts.om)
eu.d:rk(0,8,ts.om,1,1)
else
mu(eu.s,0,0,ts.sa)
end
end,function(eu,ts)
eu.d:rk(0,3,ts.nx,.375,.375)
end,function(u)
local l=da(u.l)
_del(l,u.c.tv)
if #l>0 then
return l[ew(#l)+1]
end
end,function(ak,oa,mn)
local cq=ak.nb[oa]
if not ak.wt or mn>0 then
ak.nb[oa]=_mid(-6,6,cq+mn)
end
return cq ~=ak.nb[oa]
end,function(ak,oa)
local ow=ak.nb[oa]
return _ceil(_mid(1,999,
ak[oa]*(
(oa=="od"or oa=="te")
and _mid(1,1+ow/3,3)/_mid(1,1-ow/3,3)
or _mid(2,2+ow,8)/_mid(2,2-ow,8)
)
))
end,function(_ENV)
if f.dp>0 then return true end
local ag=rv(f)
if #ag==0 then return true end
f.dp=ew"6"+2
f.nd=ag[ew(#ag)+1].ey
y(ta,"|"..f.x[f.nd].s.."|disabled")
if f.ep and f.ep.ey==f.nd then
f.ap=0
end
end,function(_ENV,i,ey)
local rs=ek(i,ey)
rs.on,rs.ub=5,5
x[ey]=rs
return rs
end,function(_ENV)
local uh=rv(f,true)
y(m,"|copies|"..mq(r,uh[ew(#uh)+1].i,a.ey).s)
end,function(_ENV)
if r.py then
return true
else
y(m,"|copies|"..f.s,function()
r.py=true
_foreach(_split"i,ez,em,tr,tb,ot,of",function(es)
r[es]=f[es]
end)
r.x={}
_foreach(f.x,function(ec)
mq(r,ec.i,ec.ey)
end)
end)
end
end,function(_ENV)
to(r,[[ot,@,of,@]],f.ot,f.of)
y(m,"|copies|types")
end,function(_ENV)
_foreach({ta,m},function(u)
to(u.c.nb,[[tb,0,ez,0,em,0,tr,0,te,0,od,0]])
y(u,"|resets|stats")
end)
end,function(_ENV,u,sk)
sk=_min(sk,u.c.tc-u.c.eq)
if sk>0 then
y(u,dn(sk,"hp"),function()
u.c.tv.eq+=sk
end)
else
return true
end
end,function(_ENV)
return rg(_ENV,m,r.tc\2)
end,function(_ENV)
lz(m,ek(ew(164)+1,a.ey))
end,function(_ENV)
if r.ld>0 then
lz(m,ek(r.ld,a.ey))
else
return true
end
end,function(_ENV)
local d=mx(ta)
if d then
lq(ta,d)
else
return true
end
end,function(_ENV)
local d=mx(m)
if d then
lq(m,d)
else
return true
end
end,function(i,s)
return(_sgn(i)>0 and "|+"or "|-").._abs(i).." "..s.."|change"
end,function(_ENV,ar,...)return ar(_ENV,m,...)end,function(_ENV,ar,...)return ar(_ENV,ta,...)end,function(_ENV,u,es,ow)
if yb(u.c,es,ow)then
y(u,dn(ow,pe[es]))
else
return true
end
end,function(_ENV)
if ee(_ENV,5)and f.en ~=5 then
return true
end
return z(_ENV,oz,"|badly|poisoned","nw",1)
end,function(_ENV)
y(m,"|does|nothing")
end,function(_ENV,uv)
if dt(a,f)>0 and f.tv.en==0 then
y(ta,"|is now|"..po[uv],function()
f.tv.en=uv
mp(f)
end)
else
return true
end
end,function(_ENV,u,ij,uw,ei)
if(u.c[uw]or 0)==0 then
u.c[uw]=ei or 1
y(u,ij)
else
return true
end
end,function(_ENV,u)
u.c.md=true
end,function(_ENV,u)
return oz(_ENV,u,"|becomes|confused","hn",ew"4"+1)
end,function(_ENV)
local hg=r.tc\4
if hg>=r.eq or r.og>0 then
return true
end
nh(_ENV,hg)
y(m,"|created|substitute",function()
r.og=hg
end)
end,function(_ENV)
ox(r,-1,ek(a.i,a.ey))
h(_ENV)
end,function(_ENV)
if not r.ep then
ox(r,ew"2"+1,ek(a.i,a.ey))
y(m,"|"..a.s.."|begins")
r.dj=0
end
if r.ap==0 then
tq(_ENV,r.dj*2)
end
end,function(_ENV)
ox(r,ew"2"+1,ek(a.i,a.ey))
h(_ENV)
if r.ap==0 then
ev(_ENV,sn,"hn")
end
end,function(_ENV)
if not r.ep then
ox(r,ew"4"+1,ek(a.i,a.ey))
r.ng=f
end
if r.ng==f then
h(_ENV)
else
return true
end
end,function(_ENV,ao)
if r.ep then
h(_ENV)
else
y(m,ao,function()
ox(r,1,ek(a.i,a.ey))
end)
end
end,function(_ENV)
if r.ep then
h(_ENV)
else
y(m,"|charges|energy")
ox(r,1,a)
a.on+=1
end
end,function(_ENV)
if r.ep then
y(m,"|recharges|energy")
else
h(_ENV)
local ec=ek(a.i,a.ey)
ec.te=0
ox(r,1,ec)
end
end,function(_ENV)
ck=ew"3"+2
end,function(_ENV)
r.tv.en=6
mp(r)
y(m,"|is|sleeping")
rg(_ENV,m,r.tc)
r.nw=0
end,function(_ENV)
if r.hi>0 then
tq(_ENV,r.hi*2)
else
return true
end
end,function(_ENV,lp,ha,ws)
if lp>0 then
y(m,ws and "|resumes|"..a.s,function()
_ENV.f=ta.c
if h(_ENV)then
y(m,"|fails|"..a.s)
else
sh(_ENV,lp-1,ha,true)
end
end)
else
ha()
end
end,function(_ENV,lp)
sh(_ENV,2+ew"4",er)
end,function(_ENV)
sh(_ENV,2,function()
if _rnd"100"<20 then
ee(_ENV,5)
end
end)
end,function(_ENV)
local ex=he(r,f,a)
if tq(_ENV,ex)then
return true
else
nh(_ENV,_max(1,ex\4))
end
end,function(_ENV,gu,ar,...)
if tq(_ENV,he(r,f,a))then
return true
else
if _rnd"100"<(gu or 0)then
ar(_ENV,...)
end
end
end,function(_ENV)
if r.en==6 then
rw(_ENV)
else
return true
end
end,function(_ENV)
local ex=he(r,f,a)
if tq(_ENV,ex)then
return true
else
rg(_ENV,m,_max(ex\2,1))
end
end,function(_ENV)
if r.tr>=f.tr then
return tq(_ENV,f.eq)
else
return true
end
end,function(_ENV)
return tq(_ENV,1+ew"75")
end,function(_ENV)
return tq(_ENV,_max(f.eq\2,1))
end,function(_ENV,u,ex,wn)
local c=u.c
local me=not wn and c.og>0
y(u,dn(-ex,"hp"),function()
c.dj+=ex
if c.ep and c.ep.i==20 then
j(_ENV,u,"ez",1)
end
if me then
c.og=_max(c.og-ex,0)
else
c.tv.eq=_max(c.tv.eq-ex,0)
end
end,me and "substitute")
end,function(_ENV,ex)
if ex>0 and dt(a,f)>0 then
if a.op%2==1 then
f.hi+=ex
end
mj(_ENV,ta,ex)
else
return true
end
end,function(_ENV,ex)
mj(_ENV,m,ex,true)
end,function(kc)
return _ceil(kc+.5*93)+5
end,function()
return w([[tw,~oe,ux,50,ez,0,em,0,tb,0,tr,0,tc,0,eq,0,sz,0,te,100,od,100,ps,0,ph,0,pr,0,dq,0,pn,0,i,-1,sp,-1,s, ,ot,0,of,0,ik,#,iv,#,rr,#,x,@]],rz())
end,function()
local ix=_peek2"0xa"
tm[-1]=fr()
for i=0,151 do
local os,lu={},false
while@ix ~=255 do
if@ix==254 then
lu=true
elseif lu then
for t=os[#os]+1,@ix do
_add(os,t)
end
lu=false
else
_add(os,@ix)
end
ix+=1
end
ix+=1
local sp=i-_deli(os,1)
local d=fr()
to(d,[[i,@,sp,@,s,@,ot,@,of,@,ps,@,ph,@,pr,@,dq,@,pn,@]],i,
sp,
ks[i+1],
_unpack(os)
)
local ln=d.ik
for t=8,#os do
local ei=os[t]
if ei==253 then
ln=d.iv
elseif ei==252 then
ln=d.rr
else
_add(ln,ei)
end
end
if sp<i then
_foreach(_split"ik,iv,rr",function(es)
_foreach(tm[sp][es],function(a)
_add(d[es],a)
end)
end)
end
local cu,cc={},{}
_foreach(d.iv,function(a)cu[a]=true end)
for t=1,54 do
if cu[t]then _add(cc,t)end
end
d.iv=cc
do local _ENV=d
to(_ENV,[[ez,@,em,@,tb,@,tr,@,tc,@,eq,~tc,ux,50]],sm(ph),
sm(pr),
sm(pn),
sm(dq),
sm(ps)+5+50
)
sz=ez+em+tb+tr+tc
end
tm[i]=d
end
end,function(i,x)
return _setmetatable(w([[x,@,en,0,tw,~tg]],x),{__index=tm[i]})
end,function(ed)
local ag={}
_foreach(ed.x,function(ec)
_add(ag,ec)
end)
return _setmetatable(w([[wl,~oe,ld,0,te,1,od,1,ap,0,hi,0,dj,0,dp,0,hn,0,ck,@,og,0,nw,0,tv,@,x,@;nb;tb,0,ez,0,em,0,tr,0,te,0,od,0]],ew"3"+2,ed,ag),{__index=ed})
end,function(sq)
_foreach(di(sq.l),function(d)
_poke(0x5e5a+d.i,1)
end)
end,function(l)
local oh={}
_foreach(l,function(d)
if d.i>-1 and d.en==1 then
_add(oh,d)
end
end)
return oh
end,function(l,vz)
local oh={}
_foreach(l,function(d)
if d.i>(vz and 0 or-1)and d.en ~=1 then
_add(oh,d)
end
end)
return oh
end,function(l)
return da(l)[1]
end,function(o)
local l=o:io"eb"
l[o:et"ae"+1]=rj(-1,rz())
oj(o:et"eb",l)
o:th()
end,function(l,lf,i)
l[lf]=rj(i,vt(i))
return l
end,function(hc)
local rh=fz[hc]
local l=w[[]]
for t=1,6 do
local nz,x,ms=rh+(t-1)*5,{},false
for t=1,4 do
x[t]=ek(_peek(nz+t),t)
if x[t].i>0 then
ms=true
else
x[t]=ek(-1)
end
end
l[t]=rj(ms and@nz or-1,x)
end
return l
end,function(hc,l)
local rh=fz[hc]
_memset(rh,0,30)
for t=1,6 do
local nz,d=rh+(t-1)*5,l[t]
_poke(nz,_max(0,d.i))
for t=1,4 do
_poke(nz+t,d.x[t].i>0 and d.x[t].i or 0)
end
end
end)
to(_g,[[yw,@,vt,@,ek,@,rz,@,dl,@,wk,@,du,@,dh,@,lx,@,ns,@,vm,@,kp,@,wq,@,fi,@,ru,@,dr,@,sd,@,dc,@,fo,@,fh,@,yl,@,yu,@,nn,@,vu,@,wv,@,vc,@,bz,@,fc,@,vq,@,wx,@,fd,@,vb,@,vl,@,yt,@,yk,@,yv,@,mk,@,wz,@,yn,@,wj,@,yd,@,yc,@,so,@,kw,@,vf,@,yi,@,yh,@,wb,@,vj,@,vx,@,vy,@,vd,@,vn,@,vo,@,vh,@,vr,@,vs,@,bg,@,fa,@,et,@,ol,@,vk,@,ff,@,vv,@,ml,@,ti,@,ah,@,mv,@,mu,@,ni,@,vp,@,nr,@,vg,@,fl,@,dd,@,rk,@,ww,@,ys,@,bq,@,bj,@,mm,@,ve,@,ya,@,io,@,su,@,rf,@,lq,@,lz,@,ox,@,yf,@,rx,@,yp,@,rm,@,nl,@,si,@,sf,@,wy,@,yy,@,mb,@,my,@]],function()
local se=_peek2"0x8"
for t=-1,164 do
local pw=_peek(se+0)
local on=_peek(se+1)*5-5
local ex=_peek(se+2)*5-5
local km=_peek(se+3)*5-5
local s=_deli(dk[t],1)
local aq=_deli(dk[t],1)
sv[t]=w([[ar,@,i,@,s,@,op,@,on,@,ub,~on,dw,@,te,@,aq,@]],function(ii)
return aq(ii,_unpack(dk[t]))
end,t,s,pw,on,ex,km,aq)
se+=4
end
end,function(i)
local d,nj=tm[i],rz()
for t=1,_min(4,#d.ik)do
nj[t]=ek(d.ik[t],t)
end
return nj
end,function(wu,ey)
return _setmetatable(w([[ey,@]],ey or 0),{__index=sv[wu]})
end,function()
local nj={}
for t=1,4 do _add(nj,ek(-1))end
return nj
end,function(o)
fa(o)
mu("team #"..o:et"eb"+1,20,27,1)
end,function(_ENV)
local fj,ib,iy=ir.c,tf.c,tx.c
local gw,gp=ib==fj,iy==fj
local ui,uo=gw and 6 or 1,gp and 6 or 1
ef(_rectfill,[[;,0,0,39,6,5;;,0,33,39,39,5]])
ef(_rectfill,[[;,-1,33,@,41,@;;,-1,-2,@,6,@]],_max(_ceil(ib.eq/ib.tc*40),0)-1,ui,
_max(_ceil(iy.eq/iy.tc*40),0)-1,uo)
ef(_rectfill,[[;,0,6,24,6,13;;,0,5,23,5,13;;,15,33,39,33,13;;,16,34,39,34,13]])
ef(ni,[[;,@,2,34,13,-1;;,@,41,29,@,1;;,@,40,1,13,1;;,@,1,5,@,-1]],ib.eq,pa[ib.en],ui,iy.eq,pa[iy.en],uo)
ib:rk(10,23,5,1)
iy:rk(30,17,5,-1)
end,function(o)vg(tm[o:et"tw"])end,function(o)oq("spot #"..(o:et"ae"+1))end,function(o)oq("move #"..(o:et"am"+1))end,function(o)oq(o.iu)end,function(o)oq"match over" end,function(kf)end,function(o)
local a=o:ol"rt"
oq(a and a.gr)
end,function()
_rectfill(0,0,46,13,13)
_pal(7,1)
local hd=0
for t,b in _ipairs(_split"6,5,5,6,6,5,6")do
_sspr(6*8+hd,6*8,b,8,hd+3,3.5+_cos((_t()+t)/4))
hd+=b
end
_pal()
end,function(o)oq(o.ir.u.s)end,function(o)
fl(o:su())
end,function(o)
local a=o:ol(o.um).a
if a.i>=0 then
aw(sb[a.op].s.."|"..a.on.."/"..a.ub.."|"..(a.dw>=0 and a.dw or "??").."P "..(a.te>=0 and a.te or "??").."A")
else
aw"none|n/a|"
end
end,function(o)
fl(o:ol"tw".d)
end,function(o)aw(o:ol"iz".ao)end,function(_ENV)
if i>-1 then
aw(s.."|"..eq.."/"..tc.."|"..po[en])
else
aw"none|n/a|"
end
end,function(_ENV)fh(_ENV:ol"hj".d)end,function(_ENV)fh(v.c)end,function(o)
local ue,ou=0,0
_foreach(o:ol().l,function(i)
if i>-1 then
ue+=tm[i].sz
ou+=1
end
end)
aw(o:ol().s.."|len "..ou.."/6|pow "..ue)
end,function(o)
aw(o.iw.s.."|is the|winner")
end,function(o)
aw(o.ir.s..o.ir.ij)
end,function(_ENV)
local ut=nl(_ENV,iw)
iw:pd(ut)
e:tt{}
e.nu=function(o)
o:ry"hu"
end
for u in _all{iw,ut}do
to(e,[[b,0;;d,@;;lg,~oe;;s,@,ts,5;;s,@;;s,@]],u.c.tv,u.s,(#da(u.l,true)).." live",(#di(u.l)).." dead")
end
end,function(_ENV)
local ou=0
for t=0,151 do ou+=tm[t]:nr()and 1 or 0 end
e:tt(
w([[;s,browse,ej,tw,eh,~tz,ao,@;;s,edit,ej,eb,eh,~tz,ao,edit|stored|teams;;s,league,ej,ch,eh,~tz,ao,@;;s,player,ej,hf,eh,~tz,ao,player|custom|battles;;s,horde,ej,cd,eh,~tz,ao,@;;s,credits,ej,fx,eh,~tz,ao,credits|amorg|games]],"browse|"..ou.."/151|pokemon","league|"..(@0x5efd).."/40|trainers","horde|"..(@0x5efe).."/151|hi-score")
)
end,function(_ENV,ge)
local ny={}
for t=0,151 do
_add(ny,t)
end
e:tt(
ny,
function(i)
return w([[eh,@,tu,@,d,@]],ge,not tm[i]:nr(),tm[i])
end
)
end,function(_ENV)
fc(_ENV,function(_ENV)
_ENV:ay"pi"
end)
end,function(_ENV)
fc(_ENV,function(_ENV)
oj(_ENV:et"eb",lj(_ENV:io"eb",_ENV:et"ae"+1,_ENV:et"tw"))
_ENV:th()
end)
end,function(_ENV)
ww(e,_ENV:ol"tw".d)
end,function(_ENV)
e:tt(
_split"106,,#alanxoc3,code+sfx,design,6,,#gr8cadet,graphics,playtest,129,,#wadlo,magikarp,playtest,145,,#zep,pico-8,px9 func,137,,#pkmndata,blbpedia,pokeapi,serebii,smogon,upokcntr,volvox,nintendo",
function(ax)
if _type(ax)=="number"then
return{d=rj(ax,rz())}
end
local ts=1
if _sub(ax,1,1)=="#"then
ax,ts=_sub(ax,2),5
end
return{s=ax,ts=ts,lg=ax==""}
end
)
end,function(_ENV)
e:tt(dv,function(sq,i)
return{
s=sq.s,
l=sq,
tu=i-1>@0x5efd,
eh=function(o,eu)
fu(o,eu.l,eu.s,function(u,ta)
_poke(0x5efd,_mid(@0x5efd,i,40))
mf(ta)
end,er)
end
}
end)
end,function(_ENV)
e:tt(w[[;s,moves,ej,am,eh,~tz;;s,switch,ej,hp,eh,~tz;;s,delete,eh,~ye]])
end,function(_ENV)
local ed=_ENV:su()
local ou=0
for uz=1,4 do
if ed.x[uz].i>0 then ou+=1 end
end
e:tt(w([[;s,change,ej,rt,eh,~tz;;s,switch,ej,cg,eh,~tz;;s,delete,tu,@,eh,~yv]],ou==1))
end,function(_ENV)
local ed,l=_ENV:su()
ed.x[_ENV:et"am"+1]=ek(-1)
oj(_ENV:et"eb",l)
_ENV:th()
end,function(_ENV,sw,ob)
local ed,l=_ENV:su()
e:tt(w[[,1,2,3,4]],function(t)
local a=ed.x[t]
return{
a=a,
s=a.s,
eh=function(_ENV)ob(_ENV,t,ed,l)end,
tu=t==sw
}
end)
end,function(_ENV)
mk(_ENV,0,function(_ENV,t,ed)
_ENV:ay(ed.x[t].i>0 and "ug"or "rt")
end)
end,function(_ENV)
local sw=_ENV:et"am"+1
mk(_ENV,sw,function(_ENV,t,ed,l)
ed.x[t],ed.x[sw]=ed.x[sw],ed.x[t]
oj(_ENV:et"eb",l)
_ENV:ry"am"
end)
e.el=am.e.el
end,function(_ENV)
local ed=_ENV:su()
local d=tm[ed.i]
local uf={}
ef(function(up,gl)
for t=1,#up do
local li=up[t]
_add(uf,{s=sv[li].s,tu=ed:mb(li),i=li,ao=gl..t})
end
end,[[;,@,learn #;;,@,teach #;;,@,event #]],d.ik,d.iv,d.rr)
e:tt(uf,function(ec)
return{
s=ec.s,
tu=ec.tu,
a=sv[ec.i],
gr=ec.ao,
eh=function()
local l=_ENV:io"eb"
l[_ENV:et"ae"+1].x[_ENV:et"am"+1]=ek(ec.i)
oj(_ENV:et"eb",l)
_ENV:ry"am"
end
}
end)
end,function(_ENV)
local nv=fs(v.c)
if v.c.ep then
rm(v,v.c.ep)
_ENV:th()_ENV:th()
elseif #nv==0 then
rm(v,ek(0))
_ENV:th()_ENV:th()
end
e:tt(v.c.x,function(a)
return w([[tu,@,s,@,a,@,eh,@]],
not nv[a],
a.s,
a,
function()
_ENV:th()_ENV:th()
rm(v,a)
end
)
end)
end,function(_ENV)
e:tt(w[[;s,fight,eh,~tz,ej,cj;;s,switch,eh,~tz,ej,hj;;s,forfeit,eh,~ym]])
end,function(_ENV)
e:tt(w[[,1,2,3]],function(t)
local l=sc(t-1)
local oh={}
local ma=true
for t=1,6 do
oh[t]=l[t].i
if not l[t]:my()then
ma=false
end
end
return{
s="team #"..t,
l=oh,
eh=function()_ENV:ob()end,
tu=sy and ma
}
end)
end,function(l,t)
return l[t]and l[t].i or-1
end,function(_ENV)
local l=_ENV:io"eb"
e:tt(w[[,1,2,3,4,5,6]],function(t)
return{
d=l[t],
eh=function(_ENV)
if l[_ENV:et"ae"+1]:nr()then
_ENV:ay"cr"
else
_ENV:ay"ed"
end
end
}
end)
end,function(_ENV)
local l=_ENV:io"eb"
e:tt(w[[,1,2,3,4,5,6]],function(t)
return{
tu=t==_ENV:et"ae"+1,
eh=function(_ENV)
local mi,mo=_ENV:et"ae"+1,_ENV:et"hp"+1
l[mi],l[mo]=l[mo],l[mi]
oj(_ENV:et"eb",l)
_ENV:ry"ae"
end,
d=l[t]
}
end)
e.el=ae.e.el
end,function(_ENV)
local l=_ENV:io"eb"
e:tt(w[[,1,2,3,4,5,6]],function(t)
local tu=v.l[t]:my()or v.c.tv==v.l[t]or v.l[t].en==1
return{
tu=tu,
eh=function()
_ENV:th()_ENV:th()
lq(v,v.l[t])
end,
d=v.l[t]
}
end)
end,function(_ENV)
local tf,tx=tf,tx
if tf.ov==tx.ov then tx.ov+=_sgn(_rnd"2"-1)end
v=tf.ov>tx.ov and tf or tx
end,function(_ENV,lr)
local cy=true
for t=tw.e.el+lr,75.5+75.5*lr,lr do
if tm[t]:nr()then
tw.e.el,cy=t
ti"154"
break
end
end
if cy then ab()end
fd(_ENV)
end,function(o)ti(o:et"tw")end,function()ti(ew"152")end,function(_ENV)ti(iw.c.i)end,function(_ENV)
local l={}
for lf,i in _pairs(_split"133,7,35,1,25,4")do
lj(l,lf,i)
_poke(0x5e5a+i,1)
end
if@0x5efc==0 then
_poke(0x5efc,1)
oj(0,l)
end
tp=mc[[is,iz;fy;e,~tg,q,~er,uk,~ab,sx,~er,ty,~bg,um,~tg,aa,~fa,eo,~er,ea,~er;iz;q,~bz,eo,~fi,ea,~fo;tw;q,~vq,eo,~du,ea,~dc;pi;q,~fd,eo,~du,ea,~dc,uk,~vj,sx,~vx;ae;q,~vf,eo,~dh,ea,~dr,aa,~dl;hp;q,~yi,eo,~dh,ea,~dr,aa,~dl;ed;q,~wx,eo,~du,ea,~dc;cr;q,~yt,eo,~dh,ea,~dr;ug;q,~yk,eo,~lx,ea,~sd,um,am;rt;q,~wj,eo,~wq,ea,~sd;am;q,~wz,eo,~lx,ea,~sd;cg;q,~yn,eo,~lx,ea,~sd;eb;iu,player,q,~so,eo,~ns,ea,~nn,sy,~tg,ob,~ya;ch;iu,player,q,~so,eo,~ns,ea,~nn,sy,~oe,ob,~ys;hf;iu,player 1,q,~so,eo,~ns,ea,~nn,sy,~oe,ob,~bq;cd;iu,player,q,~so,eo,~ns,ea,~nn,sy,~oe,ob,~ve;hm;iu,player 2,q,~so,eo,~ns,ea,~nn,sy,~oe,ob,~bj;hu;iu,trainer,q,~vl,eo,~ns,ea,~nn;lb;q,~vc,eo,~vm,ea,~vu,sx,~vd;hq;q,~yc,eo,~ru,ea,~yu;cj;q,~yd,eo,~ru,ea,~sd;hj;q,~yh,eo,~ru,ea,~yl,aa,~dl;gg;td,gf,q,~mw,ty,~er,aa,~er,un,tf;gf;td,ci,q,~mw,ty,~er,aa,~er,un,tx;ci;td,gg,q,~wb,ty,~wy,aa,~wk,eo,~ru,ea,~wv,ir,~tg;fx;q,~vb,eo,~fi,ea,~fo,sx,~vy;]]
ef(function(iq,ki,...)
tp[iq].e=ki(...)
end,[[;,tw,~tn,~ht,4;;,pi,~rq,~tl;;,fx,~rq,~tl;;,lb,~rq,~tl;;,ae,~tn,~ht,3;;,hp,~tn,~ht,3;;,iz,~tn,~tl;;,cr,~tn,~tl;;,ug,~tn,~tl;;,rt,~tn,~tl;;,am,~tn,~tl;;,cg,~tn,~tl;;,eb,~tn,~tl;;,hf,~tn,~tl;;,hu,~tn,~tl;;,hm,~tn,~tl]])
to(tp,[[cl,@,kl,@;iz;e;nu,~ab;hq;e;nu,~ab;cd;e,~cl;ch;e,~cl;ed;e,~kl;]],tp.eb.e,tp.tw.e)
_menuitem(1,"close picodex",function()
_menuitem(1)
_menuitem(2)
_ENV:al"db"
end)
_menuitem(2,"swap 🅾️/❎",function()
_poke(0x5eff,@0x5eff==0 and 1 or 0)
end)
end,function(gh)
gh.tp:fp()
end,function()na.tp:aa()end,function()na.tp:eo()end,function()na.tp:ea()end,function(_ENV)e.ty(_ENV)end,function(_ENV)e.aa(_ENV)end,function(_ENV,iq)
return _ENV[iq].e.el
end,function(_ENV,iq)
local e=iq and _ENV[iq].e or e
return e[e.el+1]
end,function(_ENV)
_menuitem(1,"factory reset",function()
_memset(0x5e00,0,0x100)
_ENV:al"cx"
end)
end,function()
return _btn()& 0x3f ~=0
end,function(_ENV)
if not ff()and hl then
hl=false
_ENV:al()
_menuitem(1)
elseif ff()then
hl=true
_menuitem(1)
end
end,0,function(i)
_g.ml=_max(0,0+i-152)
_sfx(54+i\16,0,i%16*2,2)
end,function(_ENV)
_cls"0"
rc(0,128+_sin(_ENV:fw"uu"/4)*128,function()
ef(ni,[[;,aMORG gAMES,64,-68,7,0;;,pRESENTS,64,-61,7,0;;,a pOKEMON bATTLE sIM,64,15,7,0]])
ef(wg,[[;,102,64,11,5,1]])
local cs,
dx,
oi=
tp and tp.iz.e.el,
tp and tp.cb-1,
tj=="ri"and 1
or tj=="ih"and-1
or(tj=="la"and-1 or 1)*_cos(_ENV:fw(tj)/2)
rc(30-(oi+1)*15+(is=="cx"and ew"3"-1 or 0),27,function()
ef(_rectfill,[[;,14,18,@,87,5]],63+_max(0,oi*54))
if ok==0 then
ef(_rectfill,[[;,14,18,117,87,13]])
ef(vp,[[;,14,21,40,40,@;;,71,18,46,13,@;;,71,67,46,21,@]],aa,eo,ea)
end
ef(_map,[[;,24,0,2,1,8,3;;,8,0,2,9,8,11]])
ef(function(as,gv,gy,wp,p,g)
return _spr((ok<=as)and(ml==as and _stat"46">=0 and wp or gy)or gv,p,g)
end,[[;,0,135,133,134,6,3;;,1,132,128,131,12,3;;,2,132,129,131,17,3;;,3,132,130,131,22,3]])
ef(function(ku,gn,gi,p,g)
_spr(_btn(ku)and gn or gi,p,g)
end,[[;,0,186,154,10,77;;,1,188,156,26,77;;,2,171,139,18,73;;,3,187,155,18,81;;,4,170,138,42,77;;,5,172,140,50,77]])
if oi<=0 then
mv(0,2+64*(1-_abs(oi)),_abs(oi))
if oi==-1 and hl then _spr(123,6,49)end
else
mv(16,62,oi)
if oi==1 then
if cs then _spr(153,70+cs*8,41)end
if dx and dx>=0 then _spr(153,70+dx*8,49)end
end
end
end)
end)
end,function(ka,cp,af)
af*=64
for g=9,96 do
_tline(cp,g,cp+af-1,g,ka,g/8-1.125,8/af,0)
end
end,function(au,p,g,nc)
local cf,cm="",""
for t=1,#au do
local uj,cw=_sub(au,t,t),t%2==0
cf..=cw and " "or uj
cm..=cw and uj or " "
end
ni(cf,p,g,nc,0)
ni(cm,p,g+1,nc,0)
end,function(au,p,g,nc,pl)
au=""..au
if pl==0 then p-=#au*2
elseif pl>0 then p-=#au*4+1 end
_print(au,p,g,nc)
end,function(np,ce,ic,rl,go)
_clip(-%0x5f28+np,-%0x5f2a+ce,ic,rl)
rc(np,ce,go)
_clip()
end,function(_ENV)
if i>=0 then
return not tw or@(0x5e5a+i)>0
end
end,function(d)
oq("pkmn #"..d.i)
end,function(d)
if d:nr()then
aw(d.s.."|"..sb[d.ot].s.."|"..sb[d.of].s)
else
aw"none|n/a|"
end
end,function(i,p,g,af,ig)
local hx,dy=i/8\1,i%8
if hx ~=mh then
mh=hx
_memcpy(0x0000,0x8000+0x400*hx,0x400)
end
local ic,rl=16*af,16*ig
_sspr(dy*16,0,16,16,p-ic/2,g-rl/2,ic,rl)
end,function(_ENV,p,g,dy,id,nf)
local i=_ENV:nr()and i or-1
_foreach(w[[;,25,53,152;;,54,143,153]],function(ll)
if i==ll[1]and _ENV:mb(ll[2])then
i=ll[3]
end
end)
if og and og>0 then i=154 end
if not wl or en ~=1 and not wc and not(ap ~=0 and ep.aq==sl)then
if i<0 then _spr(107,p-4,g-4)return end
id,nf=id or 1,nf or 1
local nk=_max(_abs(id),1)\ 1
ef(function(nc,pp,pf,pm,pu)
for el=1,15 do _pal(el,nc)end
for t=-nk,nk,nk*2 do
dd(i,p+(pp or t),g+(pf or t),id,nf)
dd(i,p+(pm or t),g+(pu or t),id,nf)
end
end,[[;,@,@,~tg,@,~tg;;,1,~tg,0,0,~tg]],dy,-nk,nk)
_pal()dd(i,p,g,id,nf)
end
end,function(e,d)
e:tt{}
to(e,[[;d,@;;lg,~oe;;s,lvl 50,ts,5]],d)
_foreach(_split"tc,tb,ez,em,tr,sz",function(es)
_add(e,{s=pe[es].." "..d[es]})
end)
ef(function(s,es)
if #tm[d.i][es]>0 then
_add(e,{s=s,ts=5})
_foreach(tm[d.i][es],function(ec)
_add(e,{s=sv[ec].s})
end)
end
end,[[;,learn,ik;;,teach,iv;;,event,rr]])
end,function(o)o:ay"hu" end,function(o)o:ay"hm" end,function(_ENV)
fm(_ENV,
w([[,@,player 1,~tg,~er]],sc(_ENV:et"hf")),
w([[,@,player 2,~tg,~er]],sc(_ENV:et"hm"))
)
end,function(_ENV)
_poke(0x5efe,_mid(@0x5efe,#di(l),152))
end,function(_ENV)
local ud={}
for t=1,152 do _add(ud,t%152)end
fu(_ENV,ud,"horde",function(kf,ta)
mf(ta)
mm(ta)
end,mm)
end,function(o)
o:ay"ae"
end,function(o,ko)
return sc(o:et(ko))
end,function(o)
local l=sc(o:et"eb")
return l[o:et"ae"+1],l
end,function(u,d)
u.c=yo(d)
return si(u,"|comes|out")
end,function(u,d)
sf(u,u,"|comes|back",function(tk)
tk.r.wc=true
sf(u,u,false,function()
_add(u.il,rf(u,d))
end)
end)
u.ov=3000
end,function(m,a)
local ao=m.c.ep and "|resumes|"or(a.aq==kg and "|begins|"or "|uses|")
sf(m,m,ao..a.s,function(tk)
tk.a=a
local _ENV=tk
if a.i>0 then
a.on-=1
end
if a.i==47 or a.i==36 then
nh(_ENV,r.eq)
end
if vw(r,f,a)then
y(m,"|misses|"..a.s)
if a.i==145 or a.i==73 then
nh(_ENV,1)
end
else
if a.te ~=0 then
f.ld=a.i
end
if a.ar(_ENV)then
y(m,"|fails|"..a.s)
end
end
end)
end,function(_ENV,az,gq)
if not ep and ap==0 then
ap,ep=az,gq
end
end,function(m,a)
sf(m,m,false,function(tk)
tk.a=a
local _ENV=tk
r:rx("ap",er)
if r.en==6 then
r:rx("ck",function()
y(m,"|suddenly|woke up")
r.tv.en=0
end)
if r.en==6 then
y(m,"|fast|asleep")
return
end
end
if r.en==3 then
if _rnd"1"<.2 then
y(m,"|thawed|out")
r.tv.en=0
else
y(m,"|is|frozen")
return
end
end
if f.ng==r then
y(m,"|is|trapped")
return
end
if r.nd==a.ey then
y(m,"|is|disabled")
return
end
if r.hn>0 and ew"2"==0 then
y(m,"|confuse|damage")
nh(_ENV,he(r,f,ek(-1)))
return
end
if r.en==4 and ew"4"==0 then
y(m,"|fully|paralyzed")
return
end
if r.md then
y(m,"|is|flinching")
return
end
lz(m,a)
end)
end,function(c,es,ha)
if c[es]>0 then
c[es]-=1
if c[es]==0 then
ha()
end
end
end,function(m)
return si(m,false,function(_ENV)
if r.en==6
or r.en==3
or r.ng and r.ng ~=f
then
r.ap=0
end
if r.ap==0 then
r.ng,r.ep=nil
end
local hy=_max(r.tc\16,1)
local lm=function(pb)
y(m,pb.."|damage")
nh(_ENV,hy)
end
if r.en==5 then
if r.nw>0 then
hy*=r.nw
r.nw+=1
end
lm"|poison"
end
if r.en==2 then lm"|burn" end
if r.gt then
lm"|seed"
if f.eq<f.tc then
y(ta,"|seed|leeching")
rg(_ENV,ta,hy)
end
end
r:rx("hn",function()
y(m,"|confusion|ended")
end)
r:rx("dp",function()
y(m,"|"..r.x[r.nd].s.."|enabled")
r.nd=0
end)
end)
end,function(u,a)
u.il={}
local hz=1000
yf(u,a)
if a.i==120 then hz=2000 end
if a.i==18 or a.i==4 or a.i==89 or a.i==30 then
hz=0000
end
u.ov=_min(3000,hz+u.c:ie"tr")
end,function(o,u)
return u==o.tf and o.tx or o.tf
end,function(lt,ij,lh,s)
return{u=lt,s=s or lt.c.s,c=lt.c,ij=ij,lh=lh or er}
end,function(v,...)
_add(v.il,si(...))
end,function(o)
if st then ab()end
if no then ti"154" end
if no or not o.ir then
while true do
for aj in _all{o.tf,o.tx}do
if not rb(aj.l)then
o.iw=nl(o,aj)
o:al"lb"
return
end
end
local av=yy(o)
if av then
local dz=av.c==o.tf.c and o.tf or o.tx
local ii=w([[a,@,m,@,ta,@,y,@]],a,dz,nl(o,dz),function(...)
sf(dz,...)
end)
ii.r=ii.m.c
ii.f=ii.ta.c
av.lh(ii)
if av.ij then
o.ir=av
return
else
end
else
o:al()
return
end
end
end
end,function(o)
for aj in _all{o.tf,o.tx}do
if aj.c.eq<=0 then
if aj.c.en ~=1 then
return si(aj,"|is|fainted",function(_ENV)
r.tv.en=1
end)
elseif aj ~=o.v then
return rf(aj,rb(aj.l))
end
end
end
for an in _all{o.v,nl(o,o.v)}do
local gk=nl(o,an)
while #an.il>0 do
local av=_deli(an.il,1)
if av.c.en ~=1 and(av.c==an.c or av.c==gk.c)then
return av
end
end
if an.c.eq<=0 and an.c.en==1 then
return rf(an,rb(an.l))
end
if not an.co then
an.co=true
return yp(an)
end
end
end,function(_ENV,gz)
for ec in _all(x)do
if ec.i==gz then
return true
end
end
end,function(_ENV)
return #rv(_ENV,true)==0
end)
to(_g,[[rv,@,fs,@,yr,@,va,@,vw,@,fn,@,dt,@,he,@,mw,@,ym,@,fm,@,fu,@,ds,@,lk,@,lv,@,mg,@,vi,@]],function(d,wr)
local ag={}
_foreach(d.x,function(ec)
if ec.i>0 and(wr or ec.on>0 and d.nd ~=ec.ey)then
_add(ag,ec)
ag[ec]=true
end
end)
return ag
end,function(_ENV)
if ap ~=0 then
return{ep}
else
return rv(_ENV)
end
end,function(c)
local nv=fs(c)
return nv[ew(#nv)+1]or ek(0)
end,function(_ENV,nq)
local df=1024
if nq==-1 then return 1 end
if nq==107 or nq==164 or nq==57 or nq==157 then df*=.3 end
if wf then df*=.3 end
return _rnd"1"<_min(.99,(dq+76)/df)and 2 or 1
end,function(ac,ai,a)
if a.te<=0 then return false end
if(a.aq==sr or a.aq==sl)and not ac.ep then return false end
if ai.ep and ai.ep.aq==sl then return true end
if ac.ep and ac.ep.aq==ss then return false end
return _rnd(ai:ie"od")>a.te/100*ac:ie"te"or ew"256"==0 and ew"256"==0
end,function(we,gc)
return sb[we][gc]or 1
end,function(a,ai)
return fn(a.op,ai.ot)*fn(a.op,ai.of)
end,function(ac,ai,a)
local ez,em=ac:ie"tb",ai:ie"tb"
if a.op%2==1 then
ez,em=ac:ie"ez",ai:ie"em"
if ai.gs then
em*=2
end
elseif ai.ga then
em*=2
end
local kd=_mid(
3,997,
(2*ac.ux*va(ac,a.i)/5+2)/50
*a.dw
*_mid(10,.2,ez/em)
)+2
return kd
*((a.op==ac.ot or a.op==ac.of)and 1.5 or 1)
*dt(a,ai)
*(_rnd".15"+.85)\1
end,function(_ENV)
v=_ENV[un]
do local _ENV=v.c
hi,md=0,false
end
v.co=false
if v.wh then
rm(v,yr(v.c))
_ENV:al()
elseif #v.il>0 then
_ENV:al()
else
hq.e,
cj.e,
hj.e,
ir,
oo[#oo]=v.uy,
v.wo,
v.wa,
si(v,""),
is
_ENV:ay"hq"
end
end,function(_ENV)
_ENV:th()
iw=_ENV:nl(v)
_ENV:al"lb"
end,function(_ENV,fk,fv)
fk.es,fv.es="tf","tx"
for dg in _all{fk,fv}do
_ENV[dg.es]=w([[il,#,ov,1,uy,@,wo,@,wa,@,l,@,s,@,wh,@,pd,@]],tn(tl),
tn(tl),
tn(ht,3),
_unpack(dg))
local _ENV=_ENV[dg.es]
uy.nu=ab
_add(il,rf(_ENV,rb(l)))
end
_ENV:ay"ci"
end,function(_ENV,ua,s,gd,kn)
local fq={}
for t=1,#ua do
lj(fq,t,ua[t])
end
fm(_ENV,
{_ENV:io"eb","player",false,gd},
{fq,s,true,kn}
)
end,function(ne)
mg(_peek2(ne),
function(...)return lk(0x8000+ne*0x1000,...)end,
function(...)return lv(0x8000+ne*0x1000,...)end)
end,function(lo,p,g)
p=_min(_max(0,p),127)\1
g=g\1
local ei=_peek(g*64+lo+p\2)
if p%2==1 then return(ei & 0xf0)>>>4
else return(ei & 0x0f)end
end,function(lo,p,g,ei)
p=_min(_max(0,p),127)\1
g=g\1
local ls=g*64+lo+p\2
local ul=_peek(ls)
if p%2==1 then _poke(ls,(ul & 0x0f)|(((ei or 0)& 0x0f)<<4))
else _poke(ls,(ul & 0xf0)|(((ei or 0)& 0x0f)<<0))
end
end,function(cv,lk,lv)
local function ca(as,ei)
local b,t=as[1],1
while b!=ei do
t+=1
b,as[t]=as[t],b
end
as[1]=ei
end
local hh,hr=0,0
function mr(nm)
if hr<8 then
hr+=8
hh+=@cv>>hr
cv+=1
end
hh<<=nm
local ei=hh&0xffff
hh^^=ei
hr-=nm
return ei
end
function nt(n)
local nm=0
repeat
nm+=1
local ct=mr(nm)
n+=ct
until ct<(1<<nm)-1
return n
end
local ic,wm,ke,dm,cz,p,g,hb,le=nt"1",nt"0",nt"1",{},{},0,0,0
for t=1,nt"1" do _add(dm,mr(ke))end
for g=0,wm do
for p=0,ic-1 do
hb-=1
if(hb<1)then
hb,le=nt"1",not le
end
local ak=g>0 and lk(p,g-1)or 0
local as=cz[ak]or{_unpack(dm)}
cz[ak]=as
local b=as[le and 1 or nt"2"]
ca(as,b)
ca(dm,b)
lv(p,g,b)
end
end
end,function(ej)
if ej.oy then ti(ej.oy)end
ej:hv()
end)
_g.dk=w[[-1;,none,~h;0;,struggle,~rp;;,megapnch,~h;;,razrwind,~sr;;,sworddnc,~ev,~j,ez,2;;,whrlwind,~fe;;,megakick,~h;;,toxic,~yj;;,horndril,~de;;,bodyslam,~h,30,~ee,4;;,takedown,~rp;;,doubedge,~rp;;,bublbeam,~h,10,~z,~j,tr,-1;;,watergun,~h;;,icebeam,~h,10,~ee,3;;,blizzard,~h,10,~ee,3;;,hyprbeam,~bl;;,payday,~h;;,submsion,~rp;;,counter,~bm;;,seistoss,~tq,50;;,rage,~bo;;,megdrain,~rw;;,solrbeam,~sr;;,drgnrage,~tq,40;;,thndrblt,~h,10,~ee,4;;,thunder,~h,10,~ee,4;;,earthqke,~h;;,fissure,~de;;,dig,~sl,|begins|digging;;,psychic,~h,30,~z,~j,tb,-1;;,teleport,~yq;;,mimic,~br;;,doubteam,~ev,~j,od,1;;,reflect,~ev,~oz,|raises|defense,gs;;,bide,~bp;;,metrnome,~bh;;,selfdstr,~h;;,eggbomb,~h;;,fireblst,~h,30,~ee,2;;,swift,~h;;,skulbash,~sr;;,softboil,~ft;;,dreameat,~bc;;,skyattck,~sr;;,rest,~ba;;,thndrwav,~ee,4;;,psywave,~bi;;,explsion,~h;;,rockslid,~h;;,triattck,~h;;,substute,~be;;,cut,~h;;,fly,~sl,|begins|flying;;,surf,~h;;,strength,~h;;,flash,~z,~j,te,-1;;,pound,~h;;,karatchp,~h;;,doubslap,~ia;;,comtpnch,~ia;;,firepnch,~h,10,~ee,2;;,icepnch,~h,10,~ee,3;;,thndpnch,~h,10,~ee,4;;,scratch,~h;;,vicegrip,~h;;,guilotin,~de;;,gust,~h;;,wingatck,~h;;,bind,~ss;;,slam,~h;;,vinewhip,~h;;,stomp,~h,30,~z,~it;;,doubkick,~sh,2,~er;;,jumpkick,~h;;,rllngkck,~h,30,~z,~it;;,sandatck,~z,~j,te,-1;;,headbutt,~h,30,~z,~it;;,hornatck,~h;;,furyatck,~ia;;,tackle,~h;;,wrap,~ss;;,thrash,~mz;;,tailwhip,~z,~j,em,-1;;,psnsting,~h,20,~ee,5;;,twineedl,~bn;;,pinmisil,~ia;;,leer,~z,~j,em,-1;;,bite,~h,10,~z,~it;;,growl,~z,~j,ez,-1;;,roar,~fe;;,sing,~ee,6;;,sprsonic,~z,~sn;;,sonicbom,~tq,20;;,disable,~bu;;,acid,~h,10,~z,~j,em,-1;;,ember,~h,10,~ee,2;;,flamthwr,~h,10,~ee,2;;,mist,~ev,~oz,|stat lower|immunity,wt;;,hydropmp,~h;;,psybeam,~h,10,~z,~sn;;,aurorabm,~h,10,~z,~j,ez,-1;;,peck,~h;;,drillpck,~h;;,lowkick,~h,30,~z,~it;;,absorb,~rw;;,leechsed,~z,~oz,|is now|seeded,gt;;,growth,~ev,~j,tb,1;;,razrleaf,~h;;,psnpowdr,~ee,5;;,stunspor,~ee,4;;,slppowdr,~ee,6;;,petldanc,~mz;;,strngsht,~z,~j,tr,-1;;,firespin,~ss;;,thndshck,~h,10,~ee,4;;,rockthrw,~h;;,cnfusion,~h,10,~z,~sn;;,hypnosis,~ee,6;;,meditate,~ev,~j,ez,1;;,agility,~ev,~j,tr,2;;,quickatk,~h;;,ngtshade,~tq,50;;,screech,~z,~j,em,-2;;,recover,~ft;;,harden,~ev,~j,em,1;;,minimize,~ev,~j,od,1;;,smokscrn,~z,~j,te,-1;;,cnfusray,~z,~sn;;,withdraw,~ev,~j,em,1;;,dfnscurl,~ev,~j,em,1;;,barrier,~ev,~j,em,2;;,lghtscrn,~ev,~oz,|raises|spcdefense,ga;;,haze,~bd;;,fcsenrgy,~ev,~oz,|raises|crit ratio,wf;;,mirrmove,~bs;;,lick,~h,30,~ee,4;;,smog,~h,30,~ee,5;;,sludge,~h,30,~ee,5;;,boneclub,~h,10,~z,~it;;,watrfall,~h;;,clamp,~ss;;,spikcann,~ia;;,constrct,~h,10,~z,~j,tr,-1;;,amnesia,~ev,~j,tb,2;;,kinesis,~z,~j,te,-1;;,hijmpkck,~h;;,glare,~ee,4;;,poisngas,~ee,5;;,barrage,~ia;;,leechlif,~rw;;,lovekiss,~ee,6;;,tranform,~yx;;,bubble,~h,10,~z,~j,tr,-1;;,dizypnch,~h;;,spore,~ee,6;;,splash,~bt;;,acidarmr,~ev,~j,em,2;;,crabhamr,~h;;,furyswps,~ia;;,bonerang,~sh,2,~er;;,hyprfang,~h,10,~z,~it;;,sharpen,~ev,~j,ez,1;;,convrson,~bf;;,suprfang,~yz;;,slash,~h]]
pt=w[[;k,13,sa,1,nx,5;;k,6,sa,13,nx,13;;k,5,sa,1,nx,5;;k,6,sa,5,nx,5;;k,1,sa,13,nx,5]]
fz=w[[0,0x5e00,1,0x5e1e,2,0x5e3c]]
mh=16
function _init()
local _ENV=_g
_memset(0x8000,0,0x7fff)
na=mc[[is,pc,q,~vi,ok,4;fy;tj,ih,ok,4,oy,~tg,hl,~tg,hv,~er,ty,~er,ad,~er,aa,~er,eo,~er,ea,~er,tp,;pc;td,uu,at,.5,ad,~ah;uu;td,ih,at,.5,ad,~ah;cx;tj,ih,td,ih,at,.5,oy,159,ad,~ah;ih;tj,ih,td,la,hv,~vk,ad,~ah,ty,~vv;la;tj,la,td,pq,at,.2,ad,~ah;pq;tj,ri,td,pj,ok,3,at,.2,oy,155,ad,~ah;pj;tj,ri,td,px,ok,2,at,.2,oy,154,ad,~ah;px;tj,ri,td,o,ok,1,at,.2,oy,153,ad,~ah;o;tj,ri,td,db,ok,0,oy,152,hv,~vn,ad,~ah,ty,~vo,aa,~vh,eo,~vr,ea,~vs;db;tj,db,td,ih,at,.25,ad,~ah,ty,~er;]]
ah(na)
_flip()
ti"155" ds(0x0)
ti"154" ds(0x2)
ti"153" ds(0x4)
ti"154"
ef(_poke,[[;,0x5f5c,8;;,0x5f5d,2;;,0x5f56,0xe0]])
mg(_peek2"0x6",_mget,_mset)
yw()
yg()
local cn=_peek2"0xc"
for t,b in _pairs(dv)do
local ny={s=b}
for uz=1,6 do
_add(ny,_peek(cn))
cn+=1
end
dv[t]=ny
end
_memcpy(0x0000,0xc000,0x2000)
end
function _update60()
local _ENV=_g
st,no,ly,lw=_btnp"4",_btnp"5",_btnp"0"and _btnp"1"and 0 or _btnp"0"and-1 or _btnp"1"and 1 or 0,_btnp"2"and _btnp"3"and 0 or _btnp"2"and-1 or _btnp"3"and 1 or 0
if@0x5eff==1 then
st,no=no,st
end
na:fp()
end
function _draw()
local _ENV=_g
na:ad()
end