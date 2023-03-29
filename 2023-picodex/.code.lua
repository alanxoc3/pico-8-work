function rl(en,table,gm)
if _ord(en)==126 then return table[_sub(en,2)]
elseif en=="@"then return _deli(gm,1)
elseif en=="#"then return{}end
return en ~=""and en or nil
end
function ti(table,hw,...)
local tx,pk,om={...},_split(hw,";"),table
_foreach(pk,function(ip)
local im=_split(ip)
if #im>1 then
if im[1]==""then
_foreach(im,function(en)
_add(om,rl(en,table,tx))
end)
else
for t=1,#im,2 do
om[im[t]]=rl(im[t+1],table,tx)
end
end
om=table
else
if ip==""then ip=#om+1 end
if _type(om[ip])~="table"then
om[ip]={}
end
om=om[ip]
end
end)
return table
end
function w(...)
return ti(_setmetatable({},{__index=_g}),...)
end
ti(_g,[[oa,@,te,@,kd,@,et,@]],true,false,"",function(...)return...end)
ti(_g,[[ml,@,fw,@,au,@,fg,@,fp,@,rw,@,tl,@,ab,@,w,@,ti,@,rl,@,wy,@,av,@,ey,@,em,@,rd,@,oz,@,ay,@,tf,@,kl,@,po,@,pa,@,sy,@,pt,@,sv,@,sb,@,dy,@,ae,@,rj,@,ts,@,bx,@,bq,@,bk,@,bb,@,bv,@,bj,@,td,@,he,@,mv,@,yk,@,it,@,bf,@,mx,@,bl,@,yq,@,bg,@,bu,@,rp,@,fe,@,bd,@,bh,@,mz,@,be,@,fr,@,ex,@,z,@,j,@,yz,@,bo,@,ee,@,ie,@,ia,@,si,@,ba,@,bn,@,bw,@,mq,@,sn,@,sh,@,ss,@,bc,@,mm,@,bi,@,bp,@,sr,@,io,@,br,@,rf,@,h,@,bm,@,rg,@,de,@,bs,@,bt,@,mj,@,mk,@,tz,@,nh,@,su,@,fs,@,yy,@,rx,@,yn,@,mu,@,di,@,da,@,ry,@,ya,@,lj,@,sd,@]],function(pv)
return ti(w[[re,0,cw,0,uz,~oa,q,~et,tb,~et,os,#;]],pv)
end,function(_ENV,er)
if er==ir then
return aa and re/aa or 0
end
if _ENV[er]and _ENV[er].ko then
return 1
end
return 0
end,function(_ENV,ro)
rn=ro or tc
end,function(_ENV,ro)
re,rn,uz,tc,aa=0
_ENV[ir].ko=true
for lc,v in _pairs(fb)do _ENV[lc]=v end
for lc,v in _pairs(_ENV[ro])do _ENV[lc]=v end
ir=ro
_ENV:q()
cw=#os
end,function(_ENV)
re+=1/60
if uz then _ENV:fg(ir)end
if aa and re>=aa then
_ENV:au()
end
while rn do
_ENV:fg(rn)
end
_ENV:tb()
end,function(_ENV,pg)
while rn ~=pg and #os>0 do
_ENV:tl()
end
end,function(_ENV)
_deli(os)
_ENV:au(os[#os]or "iq")
end,function(_ENV,ud)
_add(os,ud)
_ENV:au(ud)
end,w,ti,rl,function(pz,p,g,ar,oy,...)
ar,oy=ar or 1,oy or 1
_spr(pz,p-ar*4,g-oy*4,ar,oy,...)
end,function()
tn"153"
end,function(p)
return _flr(_rnd(p))
end,function(tw,ap,...)
_foreach(w(ap,...),function(tx)
tw(_unpack(tx))
end)
end,function(gj,gx,tw)
local un,ui=%0x5f28,%0x5f2a
_camera(un-gj,ui-gx)
tw()
_camera(un,ui)
end,function(aj)
ni(aj or "",23,4,1,0)
end,function(hw)
em(_rectfill,[[;,0,0,45,6,1]])
em(ni,[[;,@,23,1,13,0;;,@,23,8,1,0;;,@,23,15,1,0]],_unpack(_split(hw,"|",false)))
end,w[[]],_split"missingno,bulbasaur,ivysaur,venusaur,charmander,charmeleon,charizard,squirtle,wartortle,blastoise,caterpie,metapod,butterfree,weedle,kakuna,beedrill,pidgey,pidgeotto,pidgeot,rattata,raticate,spearow,fearow,ekans,arbok,pikachu,raichu,sandshrew,sandslash,nidoran f,nidorina,nidoqueen,nidoran m,nidorino,nidoking,clefairy,clefable,vulpix,ninetales,jigglypuff,wigglytuff,zubat,golbat,oddish,gloom,vileplume,paras,parasect,venonat,venomoth,diglett,dugtrio,meowth,persian,psyduck,golduck,mankey,primeape,growlithe,arcanine,poliwag,poliwhirl,poliwrath,abra,kadabra,alakazam,machop,machoke,machamp,bellsprout,weepinbell,victreebel,tentacool,tentacruel,geodude,graveler,golem,ponyta,rapidash,slowpoke,slowbro,magnemite,magneton,farfetchd,doduo,dodrio,seel,dewgong,grimer,muk,shellder,cloyster,gastly,haunter,gengar,onix,drowzee,hypno,krabby,kingler,voltorb,electrode,exeggcute,exeggutor,cubone,marowak,hitmonlee,hitmonchan,lickitung,koffing,weezing,rhyhorn,rhydon,chansey,tangela,kangaskhan,horsea,seadra,goldeen,seaking,staryu,starmie,mr mime,scyther,jynx,electabuzz,magmar,pinsir,tauros,magikarp,gyarados,lapras,ditto,eevee,vaporeon,jolteon,flareon,porygon,omanyte,omastar,kabuto,kabutops,aerodactyl,snorlax,articuno,zapdos,moltres,dratini,dragonair,dragonite,mewtwo,mew",w"0,none;,fainted,burned,frozen,paralyzed,poisoned,sleeping",w"0, ;,FNT,BRN,FZN,PAR,PSN,SLP",w[[0;y,2,s,~kd;1;y,2,s,normal,15,0,13,.5;2;y,10,s,fire,8,2,10,2,11,2,2,.5,4,.5,13,.5,14,.5;3;y,7,s,fighting,10,2,1,2,13,2,15,0,11,.5,9,.5,5,.5,12,.5;4;y,9,s,water,2,2,7,2,13,2,14,.5,8,.5,4,.5;5;y,6,s,poison,11,2,8,2,15,.5,7,.5,5,.5,13,.5;6;y,11,s,electric,9,2,4,2,7,0,14,.5,6,.5,8,.5;7;y,7,s,ground,6,2,2,2,5,2,13,2,9,0,11,.5,8,.5;8;y,8,s,grass,7,2,13,2,4,2,11,.5,14,.5,2,.5,9,.5,8,.5,5,.5;9;y,2,s,flying,11,2,3,2,8,2,6,.5,13,.5;10;y,9,s,ice,14,2,9,2,8,2,2,.5,10,.5,4,.5;11;y,8,s,bug,8,2,12,2,3,.5,2,.5,9,.5,15,.5,5,.5;12;y,6,s,psychic,3,2,5,2,12,.5;13;y,2,s,rock,11,2,2,2,9,2,10,2,3,.5,7,.5;14;y,2,s,dragon,14,2;15;y,6,s,ghost,15,2,1,0,12,0;17;y,2,s,bird;]],w[[tu,hp,tv,spc,tt,att,ef,def,tr,spd,sz,tot,ta,acc,ou,eva]],w[[;y,13,as,5,st,1;;y,6,as,13,st,13;;y,5,as,5,st,1;;y,6,as,5,st,5;;y,1,as,5,st,13;;y,14,as,4;;y,9,as,4;;y,11,as,3;;y,12,as,5;;y,8,as,2;;y,10,as,4]],w[[]],_split"youngstr,bugcatch,junior,brock,lass,hiker,swimmer,misty,gentlman,sailor,rocker,ltsurge,channelr,gambler,beauty,erika,biker,birdkeep,juggler,koga,blckbelt,rocket,psychic,sabrina,scientst,pkmaniac,suprnerd,blaine,cooltrnr,fishrman,tamer,giovanni,lorelei,bruno,agatha,lance,blue,green,red,legendry",function(o,eu)
if eu.ej then
o:ab(eu.ej)
else
o:tl()
end
end,function(sp,sj)
return w([[sp,@,sj,@,v,~sj,ew,1,tb,~bb,ao,~bj,nc,~bq,to,~bx]],sp,sj or 0)
end,function(sp,ew)
return ti(rj(sp),[[el,0,ew,@,tb,~bv,hk,~bk]],ew or 1)
end,function(e,fv,wi)
while _deli(e)do end
for t=1,#fv do
_add(e,(wi or et)(fv[t],t))
end
end,function(o)
o:tl()
tn"154"
end,function(e,ha,wd)
if wd then
local ot=e.el+ha*e.ew
if ot==_mid(0,ot,#e-1)then
e.el=ot
if 0+ha ~=0 then tn"154" end
else
av()
end
else
local ot=e.el+ha
local uj=e.el-e.el%e.ew
if ot==_mid(uj,ot,uj+e.ew-1)then
e.el=ot
if 0+ha ~=0 then tn"154" end
else
av()
end
end
e.el=_mid(0,e.el,#e-1)
if e.el\e.ew<e.v then e.v=e.el\e.ew end
if e.el\e.ew>e.v+2 then e.v=e.el\e.ew-2 end
e.v=_mid(0,e.v,(#e-1)\e.ew)
end,function(o)
local e=o.e
if se then e.nc(o)end
if no then o:sx()end
e.v+=lw
if ly ~=0 then o:uv(ly)end
local gb=e.v
e.v=_mid(e.sj,e.v,#e-3)
if e.v ~=gb then
av()
elseif lw ~=0 then
tn"154"
end
end,function(o)
local e=o.e
e:hk"0"
e:hk(lw,true)
e:hk(ly)
if no then
local eu=e[e.el+1]
if eu.tm then
av()
elseif eu.eh then
tn"155"
eu.eh(o,eu)
end
end
if se then e.nc(o)end
end,function(o)
local e=o.e
local hn=e.ew>1 and 10 or 40
local np=20-(e.ew*hn)/2
em(_rectfill,[[;,0,0,39,39,1;;,0,@,39,@,13]],5-e.v*10,4+(_max(_ceil(#e/e.ew),3)-e.v)*10)
for t=-1,e.ew*5-1 do
local ne=(e.v-1)*e.ew+t+1
local eu=e[ne]
if eu then
local ra,p,g=eu.ev or 1,np+t%e.ew*10,t\e.ew*10
if eu.tm then ra=3 end
if ne-1==e.el then ra+=1 end
if not eu.lg then
_rectfill(p,g-5,p+hn-1,g+4,sv[ra].y)
rd(t%e.ew*hn+np+hn/2,t\e.ew*10-3,function()
e.sp(eu,sv[ra])
end)
end
end
end
end,function(eu,ev)
if eu.d then
local ev=sv[sy[eu.d.oo].y]
em(_rectfill,[[;,-20,-2,19,17,@;;,-20,14,19,17,@]],ev.y,ev.as)
eu.d:rv(0,8,ev,1,1)
else
md(eu.s,0,0,ev.st)
end
end,function(eu,ev)
eu.d:rv(0,3,ev,.375,.375)
end,function(u)
local l=da(u.l)
_del(l,u.c.tk)
if #l>0 then
return l[ey(#l)+1]
end
end,function(ax,on,mo)
local cx=ax.nb[on]
if not ax.wt or mo>0 then
ax.nb[on]=_mid(-6,6,cx+mo)
end
return cx ~=ax.nb[on]
end,function(ax,on)
local ow=ax.nb[on]
return _ceil(_mid(1,999,
ax[on]*(
(on=="ou"or on=="ta")
and _mid(1,1+ow/3,3)/_mid(1,1-ow/3,3)
or _mid(2,2+ow,8)/_mid(2,2-ow,8)
)
))
end,function(_ENV)
if f.df>0 then return true end
local aw=rb(f)
if #aw==0 then return true end
f.df=ey"6"+2
f.nd=aw[ey(#aw)+1].ek
b(th,"|"..f.x[f.nd].s.."|disabled")
if f.ep and f.ep.ek==f.nd then
f.al=0
end
end,function(_ENV,i,ek)
local rs=ez(i,ek)
rs.aq,rs.uy=5,5
x[ek]=rs
return rs
end,function(_ENV)
local ur=rb(f,true)
b(m,"|copies|"..mx(r,ur[ey(#ur)+1].i,a.ek).s)
end,function(_ENV)
if r.py then
return true
else
b(m,"|copies|"..f.s,function()
r.py=true
_foreach(_split"i,tt,ef,tr,tv,oo,op",function(er)
r[er]=f[er]
end)
r.x={}
_foreach(f.x,function(ec)
mx(r,ec.i,ec.ek)
end)
end)
end
end,function(_ENV)
ti(r,[[oo,@,op,@]],f.oo,f.op)
b(m,"|copies|types")
end,function(_ENV)
_foreach({th,m},function(u)
ti(u.c.nb,[[tv,0,tt,0,ef,0,tr,0,ta,0,ou,0]])
b(u,"|resets|stats")
end)
end,function(_ENV,u,sk)
sk=_min(sk,u.c.tu-u.c.eq)
if sk>0 then
mj(_ENV,u,sk,function()
u.c.tk.eq+=sk
end)
else
return true
end
end,function(_ENV)
return rp(_ENV,m,r.tu\2)
end,function(_ENV)
lz(m,ez(ey(164)+1,a.ek))
end,function(_ENV)
if r.ld>0 then
lz(m,ez(r.ld,a.ek))
else
return true
end
end,function(_ENV)
local d=mv(th)
if d then
lq(th,d)
else
return true
end
end,function(_ENV)
local d=mv(m)
if d then
lq(m,d)
else
return true
end
end,function(i,s)
return(_sgn(i)>0 and "|+"or "|-").._abs(i).." "..s.."|change"
end,function(_ENV,tw,...)return tw(_ENV,m,...)end,function(_ENV,tw,...)return tw(_ENV,th,...)end,function(_ENV,u,er,ow)
if yk(u.c,er,ow)then
b(u,fr(ow,pt[er]))
else
return true
end
end,function(_ENV)
if ee(_ENV,5)and f.es ~=5 then
return true
end
return z(_ENV,ie,"|badly|poisoned","nw",1)
end,function(_ENV)
b(m,"|does|nothing")
end,function(_ENV,ub)
if dt(a,f)>0 and f.tk.es==0 then
b(th,"|is now|"..po[ub],function()
f.tk.es=ub
mm(f)
end)
else
return true
end
end,function(_ENV,u,ix,ug,en)
if(u.c[ug]or 0)==0 then
u.c[ug]=en or 1
b(u,ix)
else
return true
end
end,function(_ENV,u)
u.c.mh=true
end,function(_ENV,u)
return ie(_ENV,u,"|becomes|confused","hi",ey"4"+1)
end,function(_ENV)
local hg=r.tu\4
if hg>=r.eq or r.oi>0 then
return true
end
nh(_ENV,hg)
b(m,"|created|substitute",function()
r.oi=hg
end)
end,function(_ENV)
oj(r,-1,a)
h(_ENV)
if a.aq<=0 then
r.al,r.ep=0
end
end,function(_ENV)
if not r.ep then
oj(r,ey"2"+1,ez(a.i,a.ek))
b(m,"|"..a.s.."|begins")
r.dk=0
end
if r.al==0 then
tz(_ENV,r.dk*2)
end
end,function(_ENV)
oj(r,ey"2"+1,ez(a.i,a.ek))
h(_ENV)
if r.al==0 then
ex(_ENV,si,"hi")
end
end,function(_ENV)
if not r.ep then
oj(r,ey"4"+1,ez(a.i,a.ek))
r.ng=f
end
if r.ng==f then
h(_ENV)
else
return true
end
end,function(_ENV,ai)
if r.ep then
h(_ENV)
else
b(m,ai,function()
oj(r,1,ez(a.i,a.ek))
end)
end
end,function(_ENV)
if r.ep then
h(_ENV)
else
b(m,"|charges|energy")
oj(r,1,a)
a.aq+=1
end
end,function(_ENV)
if r.ep then
b(m,"|recharges|energy")
else
h(_ENV)
local ec=ez(a.i,a.ek)
ec.ta=0
oj(r,1,ec)
end
end,function(_ENV)
cb=ey"3"+2
end,function(_ENV)
r.tk.es=6
mm(r)
b(m,"|is|sleeping")
rp(_ENV,m,r.tu)
r.nw=0
end,function(_ENV)
if r.ho>0 then
tz(_ENV,r.ho*2)
else
return true
end
end,function(_ENV,lp,ht,ws)
if lp>0 then
b(m,ws and "|resumes|"..a.s,function()
_ENV.f=th.c
if h(_ENV)then
b(m,"|fails|"..a.s)
else
sr(_ENV,lp-1,ht,true)
end
end)
else
ht()
end
end,function(_ENV,lp)
sr(_ENV,2+ey"4",et)
end,function(_ENV)
sr(_ENV,2,function()
if _rnd"100"<20 then
ee(_ENV,5)
end
end)
end,function(_ENV)
local eg=rz(r,f,a)
if tz(_ENV,eg)then
return true
else
nh(_ENV,_max(1,eg\4))
end
end,function(_ENV,gu,tw,...)
if tz(_ENV,rz(r,f,a))then
return true
else
if _rnd"100"<(gu or 0)then
tw(_ENV,...)
end
end
end,function(_ENV)
if r.es==6 then
rg(_ENV)
else
return true
end
end,function(_ENV)
local eg=rz(r,f,a)
if tz(_ENV,eg)then
return true
else
rp(_ENV,m,_max(eg\2,1))
end
end,function(_ENV)
if r.tr>=f.tr then
return tz(_ENV,f.eq)
else
return true
end
end,function(_ENV)
return tz(_ENV,1+ey"75")
end,function(_ENV)
return tz(_ENV,_max(f.eq\2,1))
end,function(_ENV,u,eg,tw,iz)
local fy=fr(eg,"hp")
if not iz or u.c.oi+eg<0 then
b(u,fy,et,iz)
end
b(u,fy,tw,iz)
end,function(_ENV,u,eg,wn)
local c=u.c
local iz=not wn and c.oi>0
mj(_ENV,u,-eg,function()
c.dk+=eg
if c.ep and c.ep.i==20 then
j(_ENV,u,"tt",1)
end
if iz then
c.oi=_max(c.oi-eg,0)
else
c.tk.eq=_max(c.tk.eq-eg,0)
end
end,iz and "substitute")
end,function(_ENV,eg)
if eg>0 and dt(a,f)>0 then
if a.og%2==1 then
f.ho+=eg
end
mk(_ENV,th,eg)
else
return true
end
end,function(_ENV,eg)
mk(_ENV,m,eg,true)
end,function(km)
return _ceil(km+.5*93)+5
end,function()
return w([[ty,~oa,uk,50,tt,0,ef,0,tv,0,tr,0,tu,0,eq,0,sz,0,ta,100,ou,100,ps,0,ph,0,pr,0,dx,0,pn,0,i,-1,sf,-1,s, ,oo,0,op,0,iv,#,ib,#,rr,#,x,@]],rq())
end,function()
local ik=_peek2"0xa"
tf[-1]=fs()
for i=0,151 do
local ol,lu={},false
while@ik ~=255 do
if@ik==254 then
lu=true
elseif lu then
for t=ol[#ol]+1,@ik do
_add(ol,t)
end
lu=false
else
_add(ol,@ik)
end
ik+=1
end
ik+=1
local sf=i-_deli(ol,1)
local d=fs()
ti(d,[[i,@,sf,@,s,@,oo,@,op,@,ps,@,ph,@,pr,@,dx,@,pn,@]],i,
sf,
kl[i+1],
_unpack(ol)
)
local ln=d.iv
for t=8,#ol do
local en=ol[t]
if en==253 then
ln=d.ib
elseif en==252 then
ln=d.rr
else
_add(ln,en)
end
end
if sf<i then
_foreach(_split"iv,ib,rr",function(er)
_foreach(tf[sf][er],function(a)
_add(d[er],a)
end)
end)
end
local cd,cl={},{}
_foreach(d.ib,function(a)cd[a]=true end)
for t=1,54 do
if cd[t]then _add(cl,t)end
end
d.ib=cl
do local _ENV=d
ti(_ENV,[[tt,@,ef,@,tv,@,tr,@,tu,@,eq,~tu,uk,50]],su(ph),
su(pr),
su(pn),
su(dx),
su(ps)+5+50
)
sz=tt+ef+tv+tr+tu
end
tf[i]=d
end
end,function(i,x)
return _setmetatable(w([[x,@,es,0,ty,~te]],x),{__index=tf[i]})
end,function(ed)
local aw={}
_foreach(ed.x,function(ec)
_add(aw,ec)
end)
return _setmetatable(w([[wl,~oa,ld,0,ta,1,ou,1,al,0,ho,0,dk,0,df,0,hi,0,cb,@,oi,0,nw,0,tk,@,x,@;nb;tv,0,tt,0,ef,0,tr,0,ta,0,ou,0]],ey"3"+2,ed,aw),{__index=ed})
end,function(sq)
_foreach(di(sq.l),function(d)
_poke(0x5e5a+d.i,1)
end)
end,function(l)
local od={}
_foreach(l,function(d)
if d.i>-1 and d.es==1 then
_add(od,d)
end
end)
return od
end,function(l,kt)
local od={}
_foreach(l,function(d)
if d.i>(kt and 0 or-1)and d.es ~=1 then
_add(od,d)
end
end)
return od
end,function(l)
return da(l)[1]
end,function(o)
local l=o:ii"eb"
l[o:ea"at"+1]=rx(-1,rq())
oq(o:ea"eb",l)
o:tl()
end,function(l,lf,i)
l[lf]=rx(i,vo(i))
return l
end,function(hc)
local rh=pe[hc]
local l=w[[]]
for t=1,6 do
local nq,x,mi=rh+(t-1)*5,{},false
for t=1,4 do
x[t]=ez(_peek(nq+t),t)
if x[t].i>0 then
mi=true
else
x[t]=ez(-1)
end
end
l[t]=rx(mi and@nq or-1,x)
end
return l
end)
ti(_g,[[oq,@,yb,@,vo,@,ez,@,rq,@,dh,@,wj,@,dc,@,dr,@,lx,@,ns,@,vp,@,kb,@,ye,@,fo,@,rc,@,ds,@,sl,@,dd,@,fa,@,fh,@,yc,@,yf,@,nn,@,vf,@,wx,@,vm,@,vt,@,fc,@,ke,@,wq,@,fd,@,vk,@,vc,@,yo,@,yj,@,yx,@,mb,@,yt,@,yr,@,wz,@,yu,@,ym,@,sa,@,kk,@,vg,@,ys,@,yd,@,wk,@,vz,@,vq,@,vv,@,vu,@,vr,@,vn,@,vd,@,vl,@,vh,@,by,@,ft,@,ea,@,oc,@,vj,@,ff,@,vx,@,mr,@,tn,@,ac,@,my,@,md,@,ni,@,vw,@,nr,@,vy,@,fl,@,dl,@,rv,@,wb,@,yh,@,ve,@,bz,@,mc,@,va,@,yi,@,ii,@,sc,@,rm,@,lq,@,lz,@,oj,@,yg,@,rk,@,yw,@,ru,@,nl,@,so,@,sm,@,wv,@,yv,@,mw,@]],function(hc,l)
local rh=pe[hc]
_memset(rh,0,30)
for t=1,6 do
local nq,d=rh+(t-1)*5,l[t]
_poke(nq,_max(0,d.i))
for t=1,4 do
_poke(nq+t,d.x[t].i>0 and d.x[t].i or 0)
end
end
end,function()
local nz=_peek2"0x8"
for t=-1,164 do
local pw=_peek(nz+0)
local aq=_peek(nz+1)*5-5
local eg=_peek(nz+2)*5-5
local kp=_peek(nz+3)*5-5
local s=_deli(db[t],1)
local oe=_deli(db[t],1)
sb[t]=w([[tw,@,i,@,s,@,og,@,aq,@,uy,~aq,dg,@,ta,@,oe,@]],function(is)
return oe(is,_unpack(db[t]))
end,t,s,pw,aq,eg,kp,oe)
nz+=4
end
end,function(i)
local d,nx=tf[i],rq()
for t=1,_min(4,#d.iv)do
nx[t]=ez(d.iv[t],t)
end
return nx
end,function(wm,ek)
return _setmetatable(w([[ek,@]],ek or 0),{__index=sb[wm]})
end,function()
local nx={}
for t=1,4 do _add(nx,ez(-1))end
return nx
end,function(o)
ft(o)
md("team #"..o:ea"eb"+1,20,27,1)
end,function(_ENV)
local fq,iy,iw=ih.c,tp.c,tj.c
local gw,gp=iy==fq,iw==fq
local ky,kw=11,11
em(_rectfill,[[;,0,0,39,6,5;;,0,33,39,39,5]])
em(_rectfill,[[;,-1,33,@,41,1;;,-1,-2,@,6,1]],_max(_ceil(iy.eq/iy.tu*40),0)-1,
_max(_ceil(iw.eq/iw.tu*40),0)-1)
em(_rectfill,[[;,15,6,39,6,13;;,16,5,39,5,13;;,0,33,24,33,13;;,0,34,23,34,13]])
em(ni,[[;,@,40,34,13,1;;,@,40,27,1,1;;,@,2,1,13,-1;;,@,2,7,1,-1]],iy.eq,pa[iy.es],iw.eq,pa[iw.es])
local ua,ut=1,1
iy:rv(10,25,sv[4],ua,ua,gw)
iw:rv(30,15,sv[4],-ut,ut,gp)
end,function(o)vy(tf[o:ea"ty"])end,function(o)oz("spot #"..(o:ea"at"+1))end,function(o)oz("move #"..(o:ea"ag"+1))end,function(o)oz(o.iu)end,function(o)oz"match over" end,function(kg)end,function(o)
local a=o:oc"rt"
oz(a and a.gr)
end,function()
_rectfill(0,0,46,13,13)
_pal(7,1)
local hl=0
for t,v in _ipairs(_split"6,5,5,6,6,5,6")do
_sspr(6*8+hl,6*8,v,8,hl+3,3.5+_cos((_t()+t)/4))
hl+=v
end
_pal()
end,function(o)oz(o.ih.u.s)end,function(o)
fl(o:sc())
end,function(o)
local a=o:oc(o.uu).a
if a.i>=0 then
ay(sy[a.og].s.."|"..a.aq.."/"..a.uy.."|"..(a.dg>=0 and a.dg or "??").."P "..(a.ta>=0 and a.ta or "??").."A")
else
ay"none|n/a|"
end
end,function(o)
fl(o:oc"ty".d)
end,function(o)ay(o:oc"iq".ai)end,function(_ENV)
if i>-1 then
ay(s.."|"..eq.."/"..tu.."|"..po[es])
else
ay"none|n/a|"
end
end,function(_ENV)fh(_ENV:oc"hj".d)end,function(_ENV)fh(k.c)end,function(o)
local cq,of=0,0
_foreach(o:oc().l,function(i)
if i>-1 then
cq+=tf[i].sz
of+=1
end
end)
ay(o:oc().s.."|len "..of.."/6|pow "..cq)
end,function(o)
ay(o.ig.s.."|is the|winner")
end,function(o)
ay(o.ih.s..o.ih.ix)
end,function(_ENV)
local cz=nl(_ENV,ig)
ig:pd(cz)
e:to{}
e.nc=function(o)
o:rw"hu"
end
for u in _all{ig,cz}do
ti(e,[[v,0;;d,@;;lg,~oa;;s,@,ev,5;;s,@;;s,@]],u.c.tk,u.s,(#da(u.l,true)).." live",(#di(u.l)).." dead")
end
end,function(_ENV)
local of=0
for t=0,151 do of+=tf[t]:nr()and 1 or 0 end
e:to(
w([[;s,browse,ej,ty,eh,~ae,ai,@;;s,edit,ej,eb,eh,~ae,ai,edit|stored|teams;;s,league,ej,cs,eh,~ae,ai,@;;s,player,ej,hf,eh,~ae,ai,player|custom|battles;;s,horde,ej,ch,eh,~ae,ai,@;;s,credits,ej,fj,eh,~ae,ai,credits|amorg|games]],"browse|"..of.."/151|pokemon","league|"..(@0x5efd).."/40|trainers","horde|"..(@0x5efe).."/151|hi-score")
)
end,function(_ENV,ge)
local ny={}
for t=0,151 do
_add(ny,t)
end
e:to(
ny,
function(i)
return w([[eh,@,tm,@,d,@]],ge,not tf[i]:nr(),tf[i])
end
)
end,function(_ENV)
fc(_ENV,function(_ENV)
_ENV:ab"pi"
end)
end,function(_ENV)
fc(_ENV,function(_ENV)
oq(_ENV:ea"eb",lj(_ENV:ii"eb",_ENV:ea"at"+1,_ENV:ea"ty"))
_ENV:tl()
end)
end,function(_ENV)
wb(e,_ENV:oc"ty".d)
end,function(_ENV)
e:to(
_split"106,,#alanxoc3,code+sfx,design,6,,#gr8cadet,graphics,playtest,129,,#wadlo,magikarp,playtest,145,,#zep,pico-8,px9 func,137,,#pkmndata,blbpedia,pokeapi,serebii,smogon,upokcntr,volvox,nintendo",
function(aj)
if _type(aj)=="number"then
return{d=rx(aj,rq())}
end
local ev=1
if _sub(aj,1,1)=="#"then
aj,ev=_sub(aj,2),5
end
return{s=aj,ev=ev,lg=aj==""}
end
)
end,function(_ENV)
e:to(dy,function(sq,i)
return{
s=sq.s,
l=sq,
tm=i-1>@0x5efd,
eh=function(o,eu)
fu(o,eu.l,eu.s,function(u,th)
_poke(0x5efd,_mid(@0x5efd,i,40))
mu(th)
end,et)
end
}
end)
end,function(_ENV)
e:to(w[[;s,moves,ej,ag,eh,~ae;;s,switch,ej,hp,eh,~ae;;s,delete,eh,~ya]])
end,function(_ENV)
local ed=_ENV:sc()
local of=0
for uq=1,4 do
if ed.x[uq].i>0 then of+=1 end
end
e:to(w([[;s,change,ej,rt,eh,~ae;;s,switch,ej,cf,eh,~ae;;s,delete,tm,@,eh,~yx]],of==1))
end,function(_ENV)
local ed,l=_ENV:sc()
ed.x[_ENV:ea"ag"+1]=ez(-1)
oq(_ENV:ea"eb",l)
_ENV:tl()
end,function(_ENV,sg,ov)
local ed,l=_ENV:sc()
e:to(w[[,1,2,3,4]],function(t)
local a=ed.x[t]
return{
a=a,
s=a.s,
eh=function(_ENV)ov(_ENV,t,ed,l)end,
tm=t==sg
}
end)
end,function(_ENV)
mb(_ENV,0,function(_ENV,t,ed)
_ENV:ab(ed.x[t].i>0 and "up"or "rt")
end)
end,function(_ENV)
local sg=_ENV:ea"ag"+1
mb(_ENV,sg,function(_ENV,t,ed,l)
ed.x[t],ed.x[sg]=ed.x[sg],ed.x[t]
oq(_ENV:ea"eb",l)
_ENV:rw"ag"
end)
e.el=ag.e.el
end,function(_ENV)
local ed=_ENV:sc()
local d=tf[ed.i]
local um={}
em(function(uf,gl)
for t=1,#uf do
local li=uf[t]
_add(um,{s=sb[li].s,tm=ed:mw(li),i=li,ai=gl..t})
end
end,[[;,@,learn #;;,@,teach #;;,@,event #]],d.iv,d.ib,d.rr)
e:to(um,function(ec)
return{
s=ec.s,
tm=ec.tm,
a=sb[ec.i],
gr=ec.ai,
eh=function()
local l=_ENV:ii"eb"
l[_ENV:ea"at"+1].x[_ENV:ea"ag"+1]=ez(ec.i)
oq(_ENV:ea"eb",l)
_ENV:rw"ag"
end
}
end)
end,function(_ENV)
local nv=fn(k.c)
if k.c.ep then
ru(k,k.c.ep)
_ENV:tl()_ENV:tl()
elseif #nv==0 then
ru(k,ez(0))
_ENV:tl()_ENV:tl()
end
e:to(k.c.x,function(a)
return w([[tm,@,s,@,a,@,eh,@]],
not nv[a],
a.s,
a,
function()
_ENV:tl()_ENV:tl()
ru(k,a)
end
)
end)
end,function(_ENV)
e:to(w[[;s,fight,eh,~ae,ej,ck;;s,switch,eh,~ae,ej,hj;;s,forfeit,eh,~yp]])
end,function(_ENV)
e:to(w[[,1,2,3]],function(t)
local l=sd(t-1)
local od={}
local me=true
for t=1,6 do
od[t]=l[t].i
if not l[t]:mg()then
me=false
end
end
return{
s="team #"..t,
l=od,
eh=function()_ENV:ov()end,
tm=sw and me
}
end)
end,function(l,t)
return l[t]and l[t].i or-1
end,function(_ENV)
local l=_ENV:ii"eb"
e:to(w[[,1,2,3,4,5,6]],function(t)
return{
d=l[t],
eh=function(_ENV)
if l[_ENV:ea"at"+1]:nr()then
_ENV:ab"cn"
else
_ENV:ab"ed"
end
end
}
end)
end,function(_ENV)
local l=_ENV:ii"eb"
e:to(w[[,1,2,3,4,5,6]],function(t)
return{
tm=t==_ENV:ea"at"+1,
eh=function(_ENV)
local ma,mt=_ENV:ea"at"+1,_ENV:ea"hp"+1
l[ma],l[mt]=l[mt],l[ma]
oq(_ENV:ea"eb",l)
_ENV:rw"at"
end,
d=l[t]
}
end)
e.el=at.e.el
end,function(_ENV)
local l=_ENV:ii"eb"
e:to(w[[,1,2,3,4,5,6]],function(t)
local tm=k.l[t]:mg()or k.c.tk==k.l[t]or k.l[t].es==1
return{
tm=tm,
eh=function()
_ENV:tl()_ENV:tl()
lq(k,k.l[t])
end,
d=k.l[t]
}
end)
end,function(_ENV)
local tp,tj=tp,tj
if tp.ok==tj.ok then tj.ok+=_sgn(_rnd"2"-1)end
k=tp.ok>tj.ok and tp or tj
end,function(_ENV,lr)
local cg=true
for t=ty.e.el+lr,75.5+75.5*lr,lr do
if tf[t]:nr()then
ty.e.el,cg=t
tn"154"
break
end
end
if cg then av()end
fd(_ENV)
end,function(o)tn(o:ea"ty")end,function()tn(ey"152")end,function(_ENV)tn(ig.c.i)end,function(_ENV)
local l={}
for lf,i in _pairs(_split"133,7,35,1,25,4")do
lj(l,lf,i)
_poke(0x5e5a+i,1)
end
if@0x5efc==0 then
_poke(0x5efc,1)
oq(0,l)
end
tg=ml[[ir,iq;fb;e,~te,q,~et,uv,~av,sx,~et,tb,~by,uu,~te,ao,~ft,ei,~et,eo,~et;iq;q,~vt,ei,~fo,eo,~fa;ty;q,~ke,ei,~dc,eo,~dd;pi;q,~fd,ei,~dc,eo,~dd,uv,~vz,sx,~vq;at;q,~vg,ei,~dr,eo,~ds,ao,~dh;hp;q,~ys,ei,~dr,eo,~ds,ao,~dh;ed;q,~wq,ei,~dc,eo,~dd;cn;q,~yo,ei,~dr,eo,~ds;up;q,~yj,ei,~lx,eo,~sl,uu,ag;rt;q,~wz,ei,~ye,eo,~sl;ag;q,~yt,ei,~lx,eo,~sl;cf;q,~yr,ei,~lx,eo,~sl;eb;iu,player,q,~sa,ei,~ns,eo,~nn,sw,~te,ov,~yi;cs;iu,player,q,~sa,ei,~ns,eo,~nn,sw,~oa,ov,~yh;hf;iu,player 1,q,~sa,ei,~ns,eo,~nn,sw,~oa,ov,~ve;ch;iu,player,q,~sa,ei,~ns,eo,~nn,sw,~oa,ov,~va;hm;iu,player 2,q,~sa,ei,~ns,eo,~nn,sw,~oa,ov,~bz;hu;iu,trainer,q,~vc,ei,~ns,eo,~nn;lb;q,~vm,ei,~vp,eo,~vf,sx,~vu;hq;q,~ym,ei,~rc,eo,~yf;ck;q,~yu,ei,~rc,eo,~sl;hj;q,~yd,ei,~rc,eo,~yc,ao,~dh;gg;tc,gf,q,~mp,tb,~et,ao,~et,uo,tp;gf;tc,ca,q,~mp,tb,~et,ao,~et,uo,tj;ca;tc,gg,q,~wk,tb,~wv,ao,~wj,ei,~rc,eo,~wx,ih,~te;fj;q,~vk,ei,~fo,eo,~fa,sx,~vv;]]
em(function(ij,ks,...)
tg[ij].e=ks(...)
end,[[;,ty,~ts,~he,4;;,pi,~rj,~td;;,fj,~rj,~td;;,lb,~rj,~td;;,at,~ts,~he,3;;,hp,~ts,~he,3;;,iq,~ts,~td;;,cn,~ts,~td;;,up,~ts,~td;;,rt,~ts,~td;;,ag,~ts,~td;;,cf,~ts,~td;;,eb,~ts,~td;;,hf,~ts,~td;;,hu,~ts,~td;;,hm,~ts,~td]])
ti(tg,[[cr,@,kc,@;iq;e;nc,~av;hq;e;nc,~av;ch;e,~cr;cs;e,~cr;ed;e,~kc;]],tg.eb.e,tg.ty.e)
_menuitem(1,"close picodex",function()
_menuitem(1)
_menuitem(2)
_ENV:au"dw"
end)
_menuitem(2,"swap 🅾️/❎",function()
_poke(0x5eff,@0x5eff==0 and 1 or 0)
end)
end,function(gh)
gh.tg:fp()
end,function()na.tg:ao()end,function()na.tg:ei()end,function()na.tg:eo()end,function(_ENV)e.tb(_ENV)end,function(_ENV)e.ao(_ENV)end,function(_ENV,ij)
return _ENV[ij].e.el
end,function(_ENV,ij)
local e=ij and _ENV[ij].e or e
return e[e.el+1]
end,function(_ENV)
_menuitem(1,"factory reset",function()
_memset(0x5e00,0,0x100)
_ENV:au"cv"
end)
end,function()
return _btn()& 0x3f ~=0
end,function(_ENV)
if not ff()and hh then
hh=false
_ENV:au()
_menuitem(1)
elseif ff()then
hh=true
_menuitem(1)
end
end,0,function(i)
_g.mr=_max(0,0+i-152)
_sfx(54+i\16,0,i%16*2,2)
end,function(_ENV)
_cls"0"
rd(0,128+_sin(_ENV:fw"uc"/4)*128,function()
em(ni,[[;,aMORG gAMES,64,-68,7,0;;,pRESENTS,64,-61,7,0;;,a pOKEMON bATTLE sIM,64,15,7,0]])
em(wy,[[;,102,64,11,5,1]])
local ci,
dv,
oh=
tg and tg.iq.e.el,
tg and tg.cw-1,
tq=="ri"and 1
or tq=="id"and-1
or(tq=="la"and-1 or 1)*_cos(_ENV:fw(tq)/2)
rd(30-(oh+1)*15+(ir=="cv"and ey"3"-1 or 0),27,function()
em(_rectfill,[[;,14,18,@,87,5]],63+_max(0,oh*54))
if ox==0 then
em(_rectfill,[[;,14,18,117,87,13]])
em(vw,[[;,14,21,40,40,@;;,71,18,46,13,@;;,71,67,46,21,@]],ao,ei,eo)
end
em(_map,[[;,24,0,2,1,8,3;;,8,0,2,9,8,11]])
em(function(ad,gv,gy,ww,p,g)
return _spr((ox<=ad)and(mr==ad and _stat"46">=0 and ww or gy)or gv,p,g)
end,[[;,0,135,133,134,6,3;;,1,132,128,131,12,3;;,2,132,129,131,17,3;;,3,132,130,131,22,3]])
em(function(kf,gn,gi,p,g)
_spr(_btn(kf)and gn or gi,p,g)
end,[[;,0,186,154,10,77;;,1,188,156,26,77;;,2,171,139,18,73;;,3,187,155,18,81;;,4,170,138,42,77;;,5,172,140,50,77]])
if oh<=0 then
my(0,2+64*(1-_abs(oh)),_abs(oh))
if oh==-1 and hh then _spr(123,6,49)end
else
my(16,62,oh)
if oh==1 then
if ci then _spr(153,70+ci*8,41)end
if dv and dv>=0 then _spr(153,70+dv*8,49)end
end
end
end)
end)
end,function(ki,cm,ar)
ar*=64
for g=9,96 do
_tline(cm,g,cm+ar-1,g,ki,g/8-1.125,8/ar,0)
end
end,function(ap,p,g,il)
local cu,cc="",""
for t=1,#ap do
local ux,cp=_sub(ap,t,t),t%2==0
cu..=cp and " "or ux
cc..=cp and ux or " "
end
ni(cu,p,g,il,0)
ni(cc,p,g+1,il,0)
end,function(ap,p,g,il,pl)
ap=""..ap
if pl==0 then p-=#ap*2
elseif pl>0 then p-=#ap*4+1 end
_print(ap,p,g,il)
end,function(np,dq,hd,wp,go)
_clip(-%0x5f28+np,-%0x5f2a+dq,hd,wp)
rd(np,dq,go)
_clip()
end,function(_ENV)
if i>=0 then
return not ty or@(0x5e5a+i)>0
end
end,function(d)
oz("pkmn #"..d.i)
end,function(d)
if d:nr()then
ay(d.s.."|"..sy[d.oo].s.."|"..sy[d.op].s)
else
ay"none|n/a|"
end
end,function(i,p,g,ar,oy)
local hx,kh=i/8\1,i%8
if hx ~=ms then
ms=hx
_memcpy(0x0000,0x8000+0x400*hx,0x400)
end
_sspr(kh*16,0,16,16,p-ar*8,g-oy*8,ar*16,oy*16)
end,function(_ENV,p,g,ev,nf,nm,wc)
local i=_ENV:nr()and i or-1
_foreach(w[[;,25,53,152;;,54,143,153]],function(ll)
if i==ll[1]and _ENV:mw(ll[2])then
i=ll[3]
end
end)
if oi and oi>0 then i=154 end
if not wl or es ~=1 and not wu and not(al ~=0 and ep.oe==sh)then
if i<0 then _spr(107,p-4,g-4)return end
nf,nm=nf or 1,nm or 1
local nk=1
local us=function(il,pp,pf,pm,pu,nk)
if il>0 then
for el=1,15 do _pal(el,il)end
for t=-1,1,2 do
dl(i,p+(pp or t*nk),g+(pf or t*nk),nf,nm)
dl(i,p+(pm or t*nk),g+(pu or t*nk),nf,nm)
end
end
end
if wc then
em(us,[[y,@;;,~y,-2,~te,2,~te,1;;,~y,~te,-2,~te,2,1;;,~y,-2,0,2,0,1;;,~y,0,-2,0,2,1]],ev.y)
end
em(us,[[;,@,-1,~te,1,~te,1;;,1,~te,0,0,~te,1]],ev.as)
_pal()dl(i,p,g,nf,nm)
end
end,function(e,d)
e:to{}
ti(e,[[;d,@;;lg,~oa;;s,lvl 50,ev,5]],d)
_foreach(_split"tu,tv,tt,ef,tr,sz",function(er)
_add(e,{s=pt[er].." "..d[er]})
end)
em(function(s,er)
if #tf[d.i][er]>0 then
_add(e,{s=s,ev=5})
_foreach(tf[d.i][er],function(ec)
_add(e,{s=sb[ec].s})
end)
end
end,[[;,learn,iv;;,teach,ib;;,event,rr]])
end,function(o)o:ab"hu" end,function(o)o:ab"hm" end,function(_ENV)
fm(_ENV,
w([[,@,player 1,~te,~et]],sd(_ENV:ea"hf")),
w([[,@,player 2,~te,~et]],sd(_ENV:ea"hm"))
)
end,function(_ENV)
_poke(0x5efe,_mid(@0x5efe,#di(l),152))
end,function(_ENV)
local ul={}
for t=1,152 do _add(ul,t%152)end
fu(_ENV,ul,"horde",function(kg,th)
mu(th)
mc(th)
end,mc)
end,function(o)
o:ab"at"
end,function(o,kn)
return sd(o:ea(kn))
end,function(o)
local l=sd(o:ea"eb")
return l[o:ea"at"+1],l
end,function(u,d)
u.c=yn(d)
return so(u,"|comes|out")
end,function(u,d)
sm(u,u,"|comes|back",function(tx)
tx.r.wu=true
sm(u,u,false,function()
_add(u.ic,rm(u,d))
end)
end)
u.ok=3000
end,function(m,a)
local ai=m.c.ep and "|resumes|"or(a.oe==kv and "|begins|"or "|uses|")
sm(m,m,ai..a.s,function(tx)
tx.a=a
local _ENV=tx
if a.i>0 then
a.aq-=1
end
if a.i==47 or a.i==36 then
nh(_ENV,r.eq)
end
if vb(r,f,a)then
b(m,"|misses|"..a.s)
if a.i==145 or a.i==73 then
nh(_ENV,1)
end
else
if a.ta ~=0 then
f.ld=a.i
end
if a.tw(_ENV)then
b(m,"|fails|"..a.s)
end
end
end)
end,function(_ENV,ot,gq)
if not ep and al==0 then
al,ep=ot,gq
end
end,function(m,a)
sm(m,m,false,function(tx)
tx.a=a
local _ENV=tx
r:rk("al",et)
if r.es==6 then
r:rk("cb",function()
b(m,"|suddenly|woke up")
r.tk.es=0
end)
if r.es==6 then
b(m,"|fast|asleep")
return
end
end
if r.es==3 then
if _rnd"1"<.2 then
b(m,"|thawed|out")
r.tk.es=0
else
b(m,"|is|frozen")
return
end
end
if f.ng==r then
b(m,"|is|trapped")
return
end
if r.nd==a.ek then
b(m,"|is|disabled")
return
end
if r.hi>0 and ey"2"==0 then
b(m,"|confuse|damage")
nh(_ENV,rz(r,f,ez(-1)))
return
end
if r.es==4 and ey"4"==0 then
b(m,"|fully|paralyzed")
return
end
if r.mh then
b(m,"|is|flinching")
return
end
lz(m,a)
end)
end,function(c,er,ht)
if c[er]>0 then
c[er]-=1
if c[er]==0 then
ht()
end
end
end,function(m)
return so(m,false,function(_ENV)
if r.es==6
or r.es==3
or r.ng and r.ng ~=f
then
r.al=0
end
if r.al==0 then
r.ng,r.ep=nil
end
local hy=_max(r.tu\16,1)
local lm=function(pb)
b(m,pb.."|damage")
nh(_ENV,hy)
end
if r.es==5 then
if r.nw>0 then
hy*=r.nw
r.nw+=1
end
lm"|poison"
end
if r.es==2 then lm"|burn" end
if r.gt then
lm"|seed"
if f.eq<f.tu then
rp(_ENV,th,hy)
end
end
r:rk("hi",function()
b(m,"|confusion|ended")
end)
r:rk("df",function()
b(m,"|"..r.x[r.nd].s.."|enabled")
r.nd=0
end)
end)
end,function(u,a)
u.ic={}
local hz=1000
yg(u,a)
if a.i==120 then hz=2000 end
if a.i==18 or a.i==4 or a.i==89 or a.i==30 then
hz=0000
end
u.ok=_min(3000,hz+u.c:it"tr")
end,function(o,u)
return u==o.tp and o.tj or o.tp
end,function(lt,ix,lh,s)
return{u=lt,s=s or lt.c.s,c=lt.c,ix=ix,lh=lh or et}
end,function(k,...)
_add(k.ic,so(...))
end,function(o)
if se then av()end
if no then tn"154" end
if no or not o.ih then
while true do
for az in _all{o.tp,o.tj}do
if not ry(az.l)then
o.ig=nl(o,az)
o:au"lb"
return
end
end
local ak=yv(o)
if ak then
local dj=ak.c==o.tp.c and o.tp or o.tj
local is=w([[a,@,m,@,th,@,b,@]],a,dj,nl(o,dj),function(...)
sm(dj,...)
end)
is.r=is.m.c
is.f=is.th.c
ak.lh(is)
if ak.ix then
o.ih=ak
return
else
end
else
o:au()
return
end
end
end
end,function(o)
for az in _all{o.tp,o.tj}do
if az.c.eq<=0 then
if az.c.es ~=1 then
return so(az,"|is|fainted",function(_ENV)
r.tk.es=1
end)
elseif az ~=o.k then
return rm(az,ry(az.l))
end
end
end
for ah in _all{o.k,nl(o,o.k)}do
local gk=nl(o,ah)
while #ah.ic>0 do
local ak=_deli(ah.ic,1)
if ak.c.es ~=1 and(ak.c==ah.c or ak.c==gk.c)then
return ak
end
end
if ah.c.eq<=0 and ah.c.es==1 then
return rm(ah,ry(ah.l))
end
if not ah.ct then
ah.ct=true
return yw(ah)
end
end
end,function(_ENV,gz)
for ec in _all(x)do
if ec.i==gz then
return true
end
end
end)
ti(_g,[[mg,@,rb,@,fn,@,yl,@,vi,@,vb,@,fi,@,dt,@,rz,@,mp,@,yp,@,fm,@,fu,@,dn,@,lk,@,lv,@,mf,@,vs,@]],function(_ENV)
return #rb(_ENV,true)==0
end,function(d,wr)
local aw={}
_foreach(d.x,function(ec)
if ec.i>0 and(wr or ec.aq>0 and d.nd ~=ec.ek)then
_add(aw,ec)
aw[ec]=true
end
end)
return aw
end,function(_ENV)
if al ~=0 then
return{ep}
else
return rb(_ENV)
end
end,function(c)
local nv=fn(c)
return nv[ey(#nv)+1]or ez(0)
end,function(_ENV,nj)
local dm=1024
if nj==-1 then return 1 end
if nj==107 or nj==164 or nj==57 or nj==157 then dm*=.3 end
if wg then dm*=.3 end
return _rnd"1"<_min(.99,(dx+76)/dm)and 2 or 1
end,function(af,an,a)
if a.ta<=0 then return false end
if(a.oe==ss or a.oe==sh)and not af.ep then return false end
if an.ep and an.ep.oe==sh then return true end
if af.ep and af.ep.oe==sn then return false end
return _rnd(an:it"ou")>a.ta/100*af:it"ta"or ey"256"==0 and ey"256"==0
end,function(we,gc)
return sy[we][gc]or 1
end,function(a,an)
return fi(a.og,an.oo)*fi(a.og,an.op)
end,function(af,an,a)
local tt,ef=af:it"tv",an:it"tv"
if a.og%2==1 then
tt,ef=af:it"tt",an:it"ef"
if an.gs then
ef*=2
end
elseif an.ga then
ef*=2
end
local ku=_mid(
3,997,
(2*af.uk*vi(af,a.i)/5+2)/50
*a.dg
*_mid(10,.2,tt/ef)
)+2
return ku
*((a.og==af.oo or a.og==af.op)and 1.5 or 1)
*dt(a,an)
*(_rnd".15"+.85)\1
end,function(_ENV)
k=_ENV[uo]
do local _ENV=k.c
ho,mh=0,false
end
k.ct=false
if k.wh then
ru(k,yl(k.c))
_ENV:au()
elseif #k.ic>0 then
_ENV:au()
else
hq.e,
ck.e,
hj.e,
ih,
os[#os]=k.uw,
k.wo,
k.wa,
so(k,""),
ir
_ENV:ab"hq"
end
end,function(_ENV)
_ENV:tl()
ig=_ENV:nl(k)
_ENV:au"lb"
end,function(_ENV,fx,fk)
fx.er,fk.er="tp","tj"
for dp in _all{fx,fk}do
_ENV[dp.er]=w([[ic,#,ok,1,uw,@,wo,@,wa,@,l,@,s,@,wh,@,pd,@]],ts(td),
ts(td),
ts(he,3),
_unpack(dp))
local _ENV=_ENV[dp.er]
uw.nc=av
_add(ic,rm(_ENV,ry(l)))
end
_ENV:ab"ca"
end,function(_ENV,ue,s,gd,kr)
local fz={}
for t=1,#ue do
lj(fz,t,ue[t])
end
fm(_ENV,
{_ENV:ii"eb","player",false,gd},
{fz,s,true,kr}
)
end,function(ne)
mf(_peek2(ne),
function(...)return lk(0x8000+ne*0x1000,...)end,
function(...)return lv(0x8000+ne*0x1000,...)end)
end,function(lo,p,g)
p=_min(_max(0,p),127)\1
g=g\1
local en=_peek(g*64+lo+p\2)
if p%2==1 then return(en & 0xf0)>>>4
else return(en & 0x0f)end
end,function(lo,p,g,en)
p=_min(_max(0,p),127)\1
g=g\1
local ls=g*64+lo+p\2
local uh=_peek(ls)
if p%2==1 then _poke(ls,(uh & 0x0f)|(((en or 0)& 0x0f)<<4))
else _poke(ls,(uh & 0xf0)|(((en or 0)& 0x0f)<<0))
end
end,function(cy,lk,lv)
local function ce(ad,en)
local v,t=ad[1],1
while v!=en do
t+=1
v,ad[t]=ad[t],v
end
ad[1]=en
end
local hr,hs=0,0
function mn(nu)
if hs<8 then
hs+=8
hr+=@cy>>hs
cy+=1
end
hr<<=nu
local en=hr&0xffff
hr^^=en
hs-=nu
return en
end
function nt(n)
local nu=0
repeat
nu+=1
local dz=mn(nu)
n+=dz
until dz<(1<<nu)-1
return n
end
local hd,wf,ka,du,cj,p,g,hb,le=nt"1",nt"0",nt"1",{},{},0,0,0
for t=1,nt"1" do _add(du,mn(ka))end
for g=0,wf do
for p=0,hd-1 do
hb-=1
if(hb<1)then
hb,le=nt"1",not le
end
local ax=g>0 and lk(p,g-1)or 0
local ad=cj[ax]or{_unpack(du)}
cj[ax]=ad
local v=ad[le and 1 or nt"2"]
ce(ad,v)
ce(du,v)
lv(p,g,v)
end
end
end,function(ej)
if ej.ob then tn(ej.ob)end
ej:hv()
end)
_g.db=w[[-1;,none,~h;0;,struggle,~rf;;,megapnch,~h;;,razrwind,~ss;;,sworddnc,~ex,~j,tt,2;;,whrlwind,~mz;;,megakick,~h;;,toxic,~yz;;,horndril,~de;;,bodyslam,~h,30,~ee,4;;,takedown,~rf;;,doubedge,~rf;;,bublbeam,~h,10,~z,~j,tr,-1;;,watergun,~h;;,icebeam,~h,10,~ee,3;;,blizzard,~h,10,~ee,3;;,hyprbeam,~bc;;,payday,~h;;,submsion,~rf;;,counter,~bp;;,seistoss,~tz,50;;,rage,~bn;;,megdrain,~rg;;,solrbeam,~ss;;,drgnrage,~tz,40;;,thndrblt,~h,10,~ee,4;;,thunder,~h,10,~ee,4;;,earthqke,~h;;,fissure,~de;;,dig,~sh,|begins|digging;;,psychic,~h,30,~z,~j,tv,-1;;,teleport,~be;;,mimic,~bl;;,doubteam,~ex,~j,ou,1;;,reflect,~ex,~ie,|raises|defense,gs;;,bide,~bw;;,metrnome,~bd;;,selfdstr,~h;;,eggbomb,~h;;,fireblst,~h,30,~ee,2;;,swift,~h;;,skulbash,~ss;;,softboil,~fe;;,dreameat,~bm;;,skyattck,~ss;;,rest,~bi;;,thndrwav,~ee,4;;,psywave,~bs;;,explsion,~h;;,rockslid,~h;;,triattck,~h;;,substute,~ba;;,cut,~h;;,fly,~sh,|begins|flying;;,surf,~h;;,strength,~h;;,flash,~z,~j,ta,-1;;,pound,~h;;,karatchp,~h;;,doubslap,~io;;,comtpnch,~io;;,firepnch,~h,10,~ee,2;;,icepnch,~h,10,~ee,3;;,thndpnch,~h,10,~ee,4;;,scratch,~h;;,vicegrip,~h;;,guilotin,~de;;,gust,~h;;,wingatck,~h;;,bind,~sn;;,slam,~h;;,vinewhip,~h;;,stomp,~h,30,~z,~ia;;,doubkick,~sr,2,~et;;,jumpkick,~h;;,rllngkck,~h,30,~z,~ia;;,sandatck,~z,~j,ta,-1;;,headbutt,~h,30,~z,~ia;;,hornatck,~h;;,furyatck,~io;;,tackle,~h;;,wrap,~sn;;,thrash,~mq;;,tailwhip,~z,~j,ef,-1;;,psnsting,~h,20,~ee,5;;,twineedl,~br;;,pinmisil,~io;;,leer,~z,~j,ef,-1;;,bite,~h,10,~z,~ia;;,growl,~z,~j,tt,-1;;,roar,~mz;;,sing,~ee,6;;,sprsonic,~z,~si;;,sonicbom,~tz,20;;,disable,~bf;;,acid,~h,10,~z,~j,ef,-1;;,ember,~h,10,~ee,2;;,flamthwr,~h,10,~ee,2;;,mist,~ex,~ie,|stat lower|immunity,wt;;,hydropmp,~h;;,psybeam,~h,10,~z,~si;;,aurorabm,~h,10,~z,~j,tt,-1;;,peck,~h;;,drillpck,~h;;,lowkick,~h,30,~z,~ia;;,absorb,~rg;;,leechsed,~z,~ie,|is now|seeded,gt;;,growth,~ex,~j,tv,1;;,razrleaf,~h;;,psnpowdr,~ee,5;;,stunspor,~ee,4;;,slppowdr,~ee,6;;,petldanc,~mq;;,strngsht,~z,~j,tr,-1;;,firespin,~sn;;,thndshck,~h,10,~ee,4;;,rockthrw,~h;;,cnfusion,~h,10,~z,~si;;,hypnosis,~ee,6;;,meditate,~ex,~j,tt,1;;,agility,~ex,~j,tr,2;;,quickatk,~h;;,ngtshade,~tz,50;;,screech,~z,~j,ef,-2;;,recover,~fe;;,harden,~ex,~j,ef,1;;,minimize,~ex,~j,ou,1;;,smokscrn,~z,~j,ta,-1;;,cnfusray,~z,~si;;,withdraw,~ex,~j,ef,1;;,dfnscurl,~ex,~j,ef,1;;,barrier,~ex,~j,ef,2;;,lghtscrn,~ex,~ie,|raises|spcdefense,ga;;,haze,~bu;;,fcsenrgy,~ex,~ie,|raises|crit ratio,wg;;,mirrmove,~bh;;,lick,~h,30,~ee,4;;,smog,~h,30,~ee,5;;,sludge,~h,30,~ee,5;;,boneclub,~h,10,~z,~ia;;,watrfall,~h;;,clamp,~sn;;,spikcann,~io;;,constrct,~h,10,~z,~j,tr,-1;;,amnesia,~ex,~j,tv,2;;,kinesis,~z,~j,ta,-1;;,hijmpkck,~h;;,glare,~ee,4;;,poisngas,~ee,5;;,barrage,~io;;,leechlif,~rg;;,lovekiss,~ee,6;;,tranform,~yq;;,bubble,~h,10,~z,~j,tr,-1;;,dizypnch,~h;;,spore,~ee,6;;,splash,~bo;;,acidarmr,~ex,~j,ef,2;;,crabhamr,~h;;,furyswps,~io;;,bonerang,~sr,2,~et;;,hyprfang,~h,10,~z,~ia;;,sharpen,~ex,~j,tt,1;;,convrson,~bg;;,suprfang,~bt;;,slash,~h]]
pe=w[[0,0x5e00,1,0x5e1e,2,0x5e3c]]
ms=16
function _init()
local _ENV=_g
_memset(0x8000,0,0x7fff)
na=ml[[ir,pc,q,~vs,ox,4;fb;tq,id,ox,4,ob,~te,hh,~te,hv,~et,tb,~et,am,~et,ao,~et,ei,~et,eo,~et,tg,;pc;tc,uc,aa,.5,am,~ac;uc;tc,id,aa,.5,am,~ac;cv;tq,id,tc,id,aa,.5,ob,159,am,~ac;id;tq,id,tc,la,hv,~vj,am,~ac,tb,~vx;la;tq,la,tc,pq,aa,.2,am,~ac;pq;tq,ri,tc,pj,ox,3,aa,.2,ob,155,am,~ac;pj;tq,ri,tc,px,ox,2,aa,.2,ob,154,am,~ac;px;tq,ri,tc,o,ox,1,aa,.2,ob,153,am,~ac;o;tq,ri,tc,dw,ox,0,ob,152,hv,~vr,am,~ac,tb,~vn,ao,~vd,ei,~vl,eo,~vh;dw;tq,dw,tc,id,aa,.25,am,~ac,tb,~et;]]
ac(na)
_flip()
tn"155" dn(0x0)
tn"154" dn(0x2)
tn"153" dn(0x4)
tn"154"
em(_poke,[[;,0x5f5c,8;;,0x5f5d,2;;,0x5f56,0xe0]])
mf(_peek2"0x6",_mget,_mset)
yb()
yy()
local co=_peek2"0xc"
for t,v in _pairs(dy)do
local ny={s=v}
for uq=1,6 do
_add(ny,_peek(co))
co+=1
end
dy[t]=ny
end
_memcpy(0x0000,0xc000,0x2000)
end
function _update60()
local _ENV=_g
se,no,ly,lw=_btnp"4",_btnp"5",_btnp"0"and _btnp"1"and 0 or _btnp"0"and-1 or _btnp"1"and 1 or 0,_btnp"2"and _btnp"3"and 0 or _btnp"2"and-1 or _btnp"3"and 1 or 0
if@0x5eff==1 then
se,no=no,se
end
na:fp()
end
function _draw()
local _ENV=_g
na:am()
end