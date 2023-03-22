function ru(q,table,gm)
if _ord(q)==37 then return _g[_sub(q,2)]
elseif q=="~"then return table
elseif _ord(q)==126 then return table[_sub(q,2)]
elseif q=="@"then return _deli(gm,1)
elseif q=="#"then return{}end
return q ~=""and q or nil
end
function ex(table,hb,...)
local tv,pj,ou={...},_split(hb,";"),table
_foreach(pj,function(ig)
local ip=_split(ig)
if #ip>1 then
if ip[1]==""then
_foreach(ip,function(q)
_add(ou,ru(q,table,tv))
end)
else
for t=1,#ip,2 do
ou[ip[t]]=ru(ip[t+1],table,tv)
end
end
ou=table
else
if ig==""then ig=#ou+1 end
if _type(ou[ig])~="table"then
ou[ig]={}
end
ou=ou[ig]
end
end)
return table
end
function b(...)
return ex(_setmetatable({},{__index=_g}),...)
end
ex(_g,[[au,@,am,@,km,@,y,@]],true,false,"",function(...)return...end)
ex(_g,[[my,@,ko,@,fv,@,ka,@,kt,@,bu,@,bm,@,bc,@,b,@,ex,@,ru,@,wc,@,aj,@,ta,@,ep,@,rm,@,ff,@,ie,@,ax,@,td,@,po,@,ps,@,pn,@,sk,@,xl,@,ku,@,kf,@,xh,@,nf,@,hh,@,ai,@,rq,@,th,@,bv,@,bx,@,bb,@,bw,@,by,@,bk,@,tg,@,ht,@,fe,@,yf,@,nr,@,bi,@,bh,@,ft,@,ba,@,yw,@,bd,@,bs,@,ry,@,fi,@,bo,@,bt,@,fo,@,yb,@,rx,@,ek,@,ei,@,eo,@,yy,@,yx,@,en,@,ia,@,io,@,sh,@,yk,@,yj,@,bl,@,sd,@,ii,@,be,@,yq,@,fa,@,nh,@,sc,@,bn,@,sl,@,rw,@,h,@,br,@,rb,@,de,@,yz,@,yv,@,ad,@,nl,@,sp,@,fc,@,yd,@,rj,@,rp,@,mv,@,di,@,da,@,rv,@,wk,@,lx,@,sm,@]],function(px)
return ex(b[[ak,%fv,me,%ka,ey,%kt,mf,%ko,re,0,cv,0,mn,%au,om,kj,ea,%y,ty,%y;oi;,;]],px)
end,function(_ENV,et)
if et==om then
return as and re/as or 0
end
if _ENV[et]and _ENV[et].ks then
return 1
end
return 0
end,function(_ENV,ra)
rr=ra or tm
end,function(_ENV,ra)
re,rr,mn,tm,as=0
_ENV[om].ks=true
for ld,k in _pairs(fk)do _ENV[ld]=k end
for ld,k in _pairs(_ENV[ra])do _ENV[ld]=k end
om=ra
_ENV:ea()
cv=#oi
end,function(_ENV)
re+=1/60
if mn then _ENV:me(om)end
if as and re>=as then
_ENV:ak()
end
while rr do
_ENV:me(rr)
end
_ENV:ty()
end,function(_ENV,pb)
while rr ~=pb and #oi>0 do
_ENV:ts()
end
end,function(_ENV)
_deli(oi)
_ENV:ak(oi[#oi]or "ij")
end,function(_ENV,um)
_add(oi,um)
_ENV:fv(um)
end,b,ex,ru,function(gt,g,w,tz,on,...)
tz,on=tz or 1,on or 1
_spr(gt,g-tz*4,w-on*4,tz,on,...)
end,function()
tp"153"
end,function(g)
return _flr(_rnd(g))
end,function(al,ap,...)
_foreach(b(ap,...),function(tv)
al(_unpack(tv))
end)
end,function(gj,gx,al)
local ul,uh=%0x5f28,%0x5f2a
_camera(ul-gj,uh-gx)
al()
_camera(ul,uh)
end,function(ha,tq,hd)
return ha(tq)and ha(hd)and 0 or ha(tq)and-1 or ha(hd)and 1 or 0
end,function(az)
na(az or "",23,4,1,0)
end,function(hb)
ep(_rectfill,[[;,0,0,45,6,1]])
ep(na,[[;,@,23,1,13,0;;,@,23,8,1,0;;,@,23,15,1,0]],_unpack(_split(hb,"|",false)))
end,b[[]],_split"missingno,bulbasaur,ivysaur,venusaur,charmander,charmeleon,charizard,squirtle,wartortle,blastoise,caterpie,metapod,butterfree,weedle,kakuna,beedrill,pidgey,pidgeotto,pidgeot,rattata,raticate,spearow,fearow,ekans,arbok,pikachu,raichu,sandshrew,sandslash,nidoran f,nidorina,nidoqueen,nidoran m,nidorino,nidoking,clefairy,clefable,vulpix,ninetales,jigglypuff,wigglytuff,zubat,golbat,oddish,gloom,vileplume,paras,parasect,venonat,venomoth,diglett,dugtrio,meowth,persian,psyduck,golduck,mankey,primeape,growlithe,arcanine,poliwag,poliwhirl,poliwrath,abra,kadabra,alakazam,machop,machoke,machamp,bellsprout,weepinbell,victreebel,tentacool,tentacruel,geodude,graveler,golem,ponyta,rapidash,slowpoke,slowbro,magnemite,magneton,farfetchd,doduo,dodrio,seel,dewgong,grimer,muk,shellder,cloyster,gastly,haunter,gengar,onix,drowzee,hypno,krabby,kingler,voltorb,electrode,exeggcute,exeggutor,cubone,marowak,hitmonlee,hitmonchan,lickitung,koffing,weezing,rhyhorn,rhydon,chansey,tangela,kangaskhan,horsea,seadra,goldeen,seaking,staryu,starmie,mr mime,scyther,jynx,electabuzz,magmar,pinsir,tauros,magikarp,gyarados,lapras,ditto,eevee,vaporeon,jolteon,flareon,porygon,omanyte,omastar,kabuto,kabutops,aerodactyl,snorlax,articuno,zapdos,moltres,dratini,dragonair,dragonite,mewtwo,mew",b"0,none;,fainted,burned,frozen,paralyzed,poisoned,sleeping",b"0,NON;,FNT,BRN,FZN,PAR,PSN,SLP",b[[0;j,0,a,%km;1;j,0,a,normal,15,0,13,.5;2;j,5,a,fire,8,2,10,2,11,2,2,.5,4,.5,13,.5,14,.5;3;j,2,a,fighting,10,2,1,2,13,2,15,0,11,.5,9,.5,5,.5,12,.5;4;j,4,a,water,2,2,7,2,13,2,14,.5,8,.5,4,.5;5;j,1,a,poison,11,2,8,2,15,.5,7,.5,5,.5,13,.5;6;j,6,a,electric,9,2,4,2,7,0,14,.5,6,.5,8,.5;7;j,2,a,ground,6,2,2,2,5,2,13,2,9,0,11,.5,8,.5;8;j,3,a,grass,7,2,13,2,4,2,11,.5,14,.5,2,.5,9,.5,8,.5,5,.5;9;j,0,a,flying,11,2,3,2,8,2,6,.5,13,.5;10;j,4,a,ice,14,2,9,2,8,2,2,.5,10,.5,4,.5;11;j,3,a,bug,8,2,12,2,3,.5,2,.5,9,.5,15,.5,5,.5;12;j,1,a,psychic,3,2,5,2,12,.5;13;j,0,a,rock,11,2,2,2,9,2,10,2,3,.5,7,.5;14;j,0,a,dragon,14,2;15;j,1,a,ghost,15,2,1,0,12,0;17;j,0,a,bird;]],b[[sv,confused,eq,disable,xn,digging,xt,flying,xe,prepare,kq,recharge,lw,flinch,kx,thrashing,kv,trapping,kk,trapped,kz,enraged,xs,decoyed,mw,focus,ub,mist,cz,reflect,cq,screened,cj,seeded,im,toxiced,cn,tranform]],b[[ae,spc,ti,att,ef,def,tn,spd,ez,acc,oc,eva]],b[[0;j,6,op,13;;j,14,op,4;;j,9,op,4;;j,11,op,3;;j,12,op,5;;j,8,op,2;;j,10,op,4]],b[[0;a,status;;a,physical;;a,special;]],b[[]],_split"youngstr,bugcatch,junior,brock,lass,hiker,swimmer,misty,gentlman,sailor,rocker,ltsurge,channelr,gambler,beauty,erika,biker,birdkeep,juggler,koga,blckbelt,rocket,psychic,sabrina,scientst,pkmaniac,suprnerd,blaine,cooltrnr,fishrman,tamer,giovanni,lorelei,bruno,agatha,lance,blue,green,red,legendry",function(i,x)
if x.ey then
i:aw(x.ey)
else
i:ts()
end
end,function(sw,sq)
return b([[sw,@,sq,@,k,~sq,eg,1,ty,%bw,tx,%bk,nm,%bx,tt,%bv]],sw,sq or 0)
end,function(sw,eg)
return ex(rq(sw),[[eh,0,eg,@,ty,%by,hx,%bb]],eg or 1)
end,function(e,fx,wo)
while _deli(e)do end
for t=1,#fx do
_add(e,(wo or y)(fx[t],t))
end
end,function(i)
i:ts()
tp"154"
end,function(e,hi,wr)
if wr then
local oe=e.eh+hi*e.eg
if oe==_mid(0,oe,#e-1)then
e.eh=oe
if 0+hi ~=0 then tp"154" end
else
aj()
end
else
local oe=e.eh+hi
local mo=e.eh-e.eh%e.eg
if oe==_mid(mo,oe,mo+e.eg-1)then
e.eh=oe
if 0+hi ~=0 then tp"154" end
else
aj()
end
end
e.eh=_mid(0,e.eh,#e-1)
if e.eh\e.eg<e.k then e.k=e.eh\e.eg end
if e.eh\e.eg>e.k+2 then e.k=e.eh\e.eg-2 end
e.k=_mid(0,e.k,(#e-1)\e.eg)
end,function(i)
local e=i.e
if sn then e.nm(i)end
if nt then i:sj()end
e.k+=lp
if lg ~=0 then i:uq(lg)end
local gb=e.k
e.k=_mid(e.sq,e.k,#e-3)
if e.k ~=gb then
aj()
elseif lp ~=0 then
tp"154"
end
end,function(i)
local e=i.e
e:hx"0"
e:hx(lp,true)
e:hx(lg)
if nt then
local x=e[e.eh+1]
if x.eq then
aj()
elseif x.el then
tp"155"
x.el(i,x)
end
end
if sn then e.nm(i)end
end,function(i)
local e=i.e
local hn=e.eg>1 and 10 or 40
local ny=20-(e.eg*hn)/2
ep(_rectfill,[[;,0,0,39,39,1;;,0,@,39,@,13]],5-e.k*10,4+(_max(_ceil(#e/e.eg),3)-e.k)*10)
for t=-1,e.eg*5-1 do
local iq=(e.k-1)*e.eg+t+1
local x=e[iq]
if x then
local rt,g,w=x.te or 1,ny+t%e.eg*10,t\e.eg*10
if x.eq then rt=3 end
if iq-1==e.eh then rt+=1 end
if not x.lf then
_rectfill(g,w-5,g+hn-1,w+4,pi[rt].j)
rm(t%e.eg*hn+ny+hn/2,t\e.eg*10-3,function()
e.sw(x,pi[rt])
end)
end
end
end
end,function(x,te)
if x.r then
local te=kf[sk[x.r.ot].j]
ep(_rectfill,[[;,-20,-2,19,17,@;;,-20,14,19,17,@]],te.j,te.op)
x.r:to(0,8,te.op,1,1)
else
mb(x.a,0,0,te.ss)
end
end,function(x,te)
x.r:to(0,3,te.nz,.375,.375)
end,function(m)
local l=da(m.l)
_del(l,m.c.tb)
if #l>0 then
return l[ta(#l)+1]
end
end,function(tq,oo,md)
local ut=tq.nk[oo]
if not tq.ub or md>0 then
tq.nk[oo]=_mid(-6,6,ut+md)
end
return ut ~=tq.nk[oo]
end,function(tq,oo)
local ob=tq.nk[oo]
return _ceil(_mid(1,999,
tq[oo]*(
(oo=="oc"or oo=="ez")
and _mid(1,1+ob/3,3)/_mid(1,1-ob/3,3)
or _mid(2,2+ob,8)/_mid(2,2-ob,8)
)
))
end,function(_ENV)
v(u,"|not|implemented")
end,function(_ENV)
if f.dp>0 then return true end
local av=rk(f)
if #av==0 then return true end
f.dp=ta"6"+2
f.nc=av[ta(#av)+1].ev
v(tr,"|"..f.z[f.nc].a.."|disabled")
if f.eb and f.eb.ev==f.nc then
f.ab=0
end
end,function(_ENV,s,ev)
local rh=ej(s,ev)
rh.oh,rh.ux=5,5
z[ev]=rh
return rh
end,function(_ENV)
local ud=rk(f,true)
v(u,"|copied|"..ft(d,ud[ta(#ud)+1].s,o.ev).a)
end,function(_ENV)
if d.cn then
return true
else
v(u,"|copied|"..f.a,function()
d.cn=true
_foreach(_split"s,ti,ef,tn,ae,ot,ow",function(et)
d[et]=f[et]
end)
d.z={}
_foreach(f.z,function(eu)
ft(d,eu.s,eu.ev)
end)
end)
end
end,function(_ENV)
ex(d,[[ot,@,ow,@,xr,%au]],f.ot,f.ow)
v(u,"|copied|types")
end,function(_ENV)
_foreach({tr,u},function(m)
ex(m.c.nk,[[ae,0,ti,0,ef,0,tn,0,ez,0,oc,0]])
v(m,"|reset|modifiers")
end)
end,function(_ENV,m,sx)
sx=_min(sx,m.c.tf-m.c.em)
if sx>0 then
v(m,rx(sx,"|hitpoints"),function()
m.c.tb.em+=sx
end)
else
return true
end
end,function(_ENV)
return ry(_ENV,u,d.tf\2)
end,function(_ENV)
lz(u,ej(ta(164)+1,o.ev))
end,function(_ENV)
if d.rd>0 then
lz(u,ej(d.rd,o.ev))
else
return true
end
end,function(_ENV)
local r=fe(tr)
if r then
lj(tr,r)
else
return true
end
end,function(_ENV)
local r=fe(u)
if r then
lj(u,r)
else
return true
end
end,function(s,gs)
return(_sgn(s)>0 and "|+"or "|-").._abs(s)..gs
end,function(_ENV,al,...)return al(_ENV,u,...)end,function(_ENV,al,...)return al(_ENV,tr,...)end,function(_ENV,m,et,ob)
if yf(m.c,et,ob)then
v(m,rx(ob,"/6|"..ku[et]))
else
return true
end
end,function(_ENV)
if en(_ENV,5)and f.ec ~=5 then
return true
end
return ei(_ENV,ia,"|badly|poisoned","im",1)
end,function(_ENV)
v(u,"|does|nothing")
end,function(_ENV,uj)
if dt(o,f)>0 and f.tb.ec==0 then
v(tr,"|is|"..ps[uj],function()
f.tb.ec=uj
end)
else
return true
end
end,function(_ENV,m,iv,uv,q)
if(m.c[uv]or 0)==0 then
m.c[uv]=q or 1
v(m,iv)
else
return true
end
end,function(_ENV,m)
m.c.lw=true
end,function(_ENV,m)
return ia(_ENV,m,"|becomes|confused","sv",ta"4"+1)
end,function(_ENV)
local hy=d.tf\4
if hy>=d.em or d.oa>0 then
return true
end
nl(_ENV,hy)
v(u,"|created|substitute",function()
d.oa=hy
end)
end,function(_ENV)
d.tb.ec=6
v(u,"|is|sleeping")
ry(_ENV,u,d.tf)
d.im=0
end,function(_ENV)
if nf[d.rd].oy%2==1 then
return ad(_ENV,(d.ca-d.em)*2)
else
return true
end
end,function(_ENV,si,ho)
if si>0 then
v(u,"|begin|hit #"..si,function()
_ENV.f=tr.c
if h(_ENV)then
v(u,"|failed|hit #"..si)
end
sd(_ENV,si-1,ho)
end)
else
ho()
end
end,function(_ENV,si)
sd(_ENV,2+ta"4",y)
end,function(_ENV)
sd(_ENV,2,function()
if _rnd"100"<20 then
en(_ENV,5)
end
end)
end,function(_ENV)
nn(d,-1,ej(o.s,o.ev))
h(_ENV)
end,function(_ENV)
nn(d,ta"2"+1,ej(o.s,o.ev))
h(_ENV)
if d.ab==0 then
ek(_ENV,sh,"sv")
end
end,function(_ENV)
if not d.eb then
nn(d,ta"4"+1,ej(o.s,o.ev))
v(u,"|"..o.a.."|begins")
end
h(_ENV)
if d.ab==0 then
v(u,"|"..o.a.."|ended")
end
end,function(_ENV,tw)
if d.eb then
h(_ENV)
else
v(u,"|started|"..tw,function()
nn(d,1,ej(o.s,o.ev))
end)
end
end,function(_ENV)
if d.eb then
v(u,"|recharging|energy")
else
h(_ENV)
local eu=ej(o.s,o.ev)
eu.ez=0
nn(d,1,eu)
end
end,function(_ENV)
if d.eb then
h(_ENV)
else
nn(d,1,o)
v(u,"|preparing|attack")
o.oh+=1
end
end,function(_ENV)
local tl=he(d,f,o)
if ad(_ENV,tl)then
return true
else
nl(_ENV,_max(1,tl\4))
end
end,function(_ENV,gu,al,...)
if ad(_ENV,he(d,f,o))then
return true
else
if _rnd"100"<(gu or 0)then
al(_ENV,...)
end
end
end,function(_ENV)
if d.ec==6 then
rb(_ENV)
else
return true
end
end,function(_ENV)
local tl=he(d,f,o)
if ad(_ENV,tl)then
return true
else
ry(_ENV,u,_max(tl\2,1))
end
end,function(_ENV)
if d.tn>=f.tn then
return ad(_ENV,f.em)
else
return true
end
end,function(_ENV)
return ad(_ENV,1+ta"75")
end,function(_ENV)
return ad(_ENV,_max(f.em\2,1))
end,function(_ENV,tl)
if tl>0 and dt(o,f)>0 then
v(tr,rx(-tl,"|hitpoints"),function()
if f.oa>0 then
f.oa=_max(f.oa-tl,0)
else
f.tb.em=_max(f.tb.em-tl,0)
end
end,f.oa>0 and "substitute")
else
return true
end
end,function(_ENV,tl)
v(u,rx(-tl,"|hitpoints"),function()
d.tb.em=_max(d.tb.em-tl,0)
end)
end,function(kw)
return _ceil(kw+.5*93)+5
end,function()
return b([[tj,%au,mt,50,ti,0,ef,0,ae,0,tn,0,tf,0,em,0,hu,0,ez,1,oc,1,pl,0,pc,0,pd,0,dx,0,ph,0,s,-1,ir,-1,a, ,ot,0,ow,0,oj,#,ox,#,st,#,to,%vw,z,@]],rz())
end,function()
local ib=_peek2"0xa"
td[-1]=fc()
for s=0,151 do
local tc,lc={},false
while@ib ~=255 do
if@ib==254 then
lc=true
elseif lc then
for t=tc[#tc]+1,@ib do
_add(tc,t)
end
lc=false
else
_add(tc,@ib)
end
ib+=1
end
ib+=1
local ir=s-tc[1]
local r=fc()
ex(r,[[s,@,ir,@,a,@,ot,@,ow,@,pl,@,pc,@,pd,@,dx,@,ph,@]],s,
ir,
po[s+1],
tc[2],
tc[3],
tc[4],
tc[5],
tc[6],
tc[7],
tc[8]
)
local ls=r.oj
for t=9,#tc do
local q=tc[t]
if q==253 then
ls=r.ox
elseif q==252 then
ls=r.st
else
_add(ls,q)
end
end
if ir<s then
_foreach(td[ir].oj,function(o)_add(r.oj,o)end)
_foreach(td[ir].ox,function(o)_add(r.ox,o)end)
_foreach(td[ir].st,function(o)_add(r.st,o)end)
end
local cm,cu={},{}
_foreach(r.ox,function(o)cm[o]=true end)
for t=1,54 do
if cm[t]then _add(cu,t)end
end
r.ox=cu
do local _ENV=r
ex(_ENV,[[ti,@,ef,@,ae,@,tn,@,tf,@,em,~tf,mt,50]],sp(pc),
sp(pd),
sp(ph),
sp(dx),
sp(pl)+5+50
)
hu=ti+ef+ae+tn+tf
end
td[s]=r
end
end,function(s,z)
return _setmetatable(b([[z,@,ec,0,tj,%am]],z),{__index=td[s]})
end,function(ed)
local av={}
_foreach(ed.z,function(eu)
_add(av,eu)
end)
return _setmetatable(b([[ws,%au,rd,0,ez,1,oc,1,ab,0,dp,0,sv,0,oa,0,im,0,tb,@,z,@,ca,@;nk;ae,0,ti,0,ef,0,tn,0,ez,0,oc,0]],ed,av,ed.em),{__index=ed})
end,function(sz)
_foreach(di(sz.l),function(r)
_poke(0x5e5a+r.s,1)
end)
end,function(l)
local od={}
_foreach(l,function(r)
if r.s>-1 and r.ec==1 then
_add(od,r)
end
end)
return od
end,function(l,ki)
local od={}
_foreach(l,function(r)
if r.s>(ki and 0 or-1)and r.ec ~=1 then
_add(od,r)
end
end)
return od
end,function(l)
return da(l)[1]
end,function(i)
local l=i:is"ew"
l[i:ee"an"+1]=rj(-1,rz())
oz(i:ee"ew",l)
i:ts()
end,function(l,lm,s)
l[lm]=rj(s,va(s))
return l
end,function(hm)
local rl=pa[hm]
local l=b[[]]
for t=1,6 do
local so,z,mu=rl+(t-1)*5,{},false
for t=1,4 do
z[t]=ej(_peek(so+t),t)
if z[t].s>0 then
mu=true
else
z[t]=ej(-1)
end
end
l[t]=rj(mu and@so or-1,z)
end
return l
end)
ex(_g,[[oz,@,yc,@,va,@,ej,@,rz,@,dh,@,wg,@,du,@,dr,@,lk,@,ni,@,vf,@,xo,@,wb,@,fr,@,rf,@,ds,@,su,@,dc,@,fs,@,fu,@,yo,@,ys,@,no,@,vm,@,wp,@,vu,@,bz,@,fg,@,ke,@,ww,@,fp,@,vk,@,vd,@,wx,@,yg,@,yp,@,mz,@,wv,@,wz,@,wy,@,yi,@,yn,@,sr,@,xi,@,vp,@,wq,@,ya,@,wf,@,vz,@,vq,@,vv,@,vc,@,vs,@,vi,@,vl,@,vh,@,vr,@,bp,@,fn,@,bg,@,bf,@,ym,@,vj,@,fb,@,vx,@,mg,@,tp,@,ac,@,mq,@,mb,@,na,@,vg,@,ns,@,vy,@,fm,@,dl,@,vw,@,wu,@,ye,@,bq,@,bj,@,vt,@,fh,@,wj,@,is,@,sf,@,lj,@,lz,@,nn,@,yh,@,dd,@,yl,@,rg,@,nd,@,it,@,sg,@,ve,@,wm,@,yu,@]],function(hm,l)
local rl=pa[hm]
_memset(rl,0,30)
for t=1,6 do
local so,r=rl+(t-1)*5,l[t]
_poke(so,_max(0,r.s))
for t=1,4 do
_poke(so+t,r.z[t].s>0 and r.z[t].s or 0)
end
end
end,function()
local ix=_peek2"0x8"
for t=-1,164 do
local pv=_peek(ix+0)
local oh=_peek(ix+1)*5-5
local tl=_peek(ix+2)*5-5
local ky=_peek(ix+3)*5-5
local a=_deli(dv[t],1)
local ol=_deli(dv[t],1)
nf[t]=b([[al,@,s,@,a,@,oy,@,oh,@,ux,~oh,dw,@,ez,@,ol,@]],function(ih)
return o[6](ih,_unpack(dv[t]))
end,t,a,pv,oh,tl,ky,ol)
_printh("memloc: "..ix.." | ")
ix+=4
end
end,function(s)
local r,se=td[s],rz()
for t=1,_min(4,#r.oj)do
se[t]=ej(r.oj[t],t)
end
return se
end,function(wh,ev)
return _setmetatable(b([[ev,@]],ev or 0),{__index=nf[wh]})
end,function()
local se={}
for t=1,4 do _add(se,ej(-1))end
return se
end,function(i)
fn(i)
mb("team #"..i:ee"ew"+1,20,27,1)
end,function(_ENV)
local pe,iy,iw=il.c,tu.c,aa.c
local gw,gp=iy==pe,iw==pe
local us,un=gw and 6 or 1,gp and 6 or 1
ep(_rectfill,[[;,0,0,39,6,5;;,0,33,39,39,5]])
ep(_rectfill,[[;,-1,33,@,41,@;;,40,-2,@,6,@]],-1+_max(_ceil(iy.em/iy.tf*40),0),us,
40-_max(_ceil(iw.em/iw.tf*40),0),un)
ep(_rectfill,[[;,0,6,24,6,13;;,0,5,23,5,13;;,15,33,39,33,13;;,16,34,39,34,13]])
ep(na,[[;,@,2,34,13,-1;;,@,41,29,@,1;;,@,40,1,13,1;;,@,1,5,@,-1]],iy.em,pn[iy.ec],us,iw.em,pn[iw.ec],un)
iy:to(10,23,5,1)
iw:to(30,17,5,-1)
end,function(i)vy(td[i:ee"tj"])end,function(i)ie("spot #"..(i:ee"an"+1))end,function(i)ie("move #"..(i:ee"ag"+1))end,function(i)ie(i.og)end,function(i)ie"match over" end,function(kb)end,function(i)
local o=i:x"nb"
ie(o and o.gr)
end,function()
_rectfill(0,0,46,13,13)
_pal(7,1)
local hc=0
for t,k in _ipairs(_split"6,5,5,6,6,5,6")do
_sspr(6*8+hc,6*8,k,8,hc+3,3.5+_cos((_t()+t)/4))
hc+=k
end
_pal()
end,function(i)ie(i.il.m.a)end,function(i)
fm(i:sf())
end,function(i)
local o=i:x(i.up).o
if o.s>=0 then
ax(sk[o.oy].a.."|"..o.oh.."/"..o.ux.."|"..(o.dw>=0 and o.dw or "??").."P "..(o.ez>=0 and o.ez or "??").."A")
else
ax"????|?/?|?P ?A"
end
end,function(i)
fm(i:x"tj".r)
end,function(i)ax(i:x"ij".tw)end,function(_ENV)
if s>-1 then
ax(a.."|"..em.."/"..tf.."|"..ps[ec])
else
ax"?????????|???/???|"
end
end,function(_ENV)fu(_ENV:x"hq".r)end,function(_ENV)fu(p.c)end,function(i)
local of,uo=0,0
for t=1,6 do
local s=i:x().l[t]
if s then
of+=1
uo+=td[s].hu
end
end
ax(i:x().a.."|pkmn "..of.."/6|pow "..uo)
end,function(i)
ax(i.p.a.."|is the|winner")
end,function(i)
ax(i.il.a..i.il.iv)
end,function(_ENV)
local dz,uz=p,nd(_ENV,p)
dz:pm(uz)
e:tt{}
e.nm=function(i)
i:rn"hf"
end
for m in _all{dz,uz}do
ex(e,[[k,0;;r,@;;lf,%au;;a,@,te,5;;a,@;;a,@]],m.c.tb,m.a,(#da(m.l,true)).." live",(#di(m.l)).." dead")
end
end,function(_ENV)
local of=0
for t=0,151 do of+=td[t]:ns()and 1 or 0 end
e:tt(
b([[;a,browse,ey,tj,el,%ai,tw,@;;a,edit,ey,ew,el,%ai,tw,edit|stored|teams;;a,league,ey,cl,el,%ai,tw,@;;a,player,ey,cd,el,%ai,tw,player|custom|battles;;a,?????,ey,cc,el,%ai,tw,?????|beat|league,eq,%au;;a,credits,ey,fz,el,%ai,tw,credits|amorg|games]],"browse|"..of.."/151|pokemon","league|"..(@0x5efd).."/40|trainers")
)
if@0x5efd>=40 then
ex(e[5],[[eq,%am,a,horde,tw,@]],"horde|"..(@0x5efe).."/151|hi-score")
end
end,function(_ENV,ga)
local nv={}
for t=0,151 do
_add(nv,t)
end
e:tt(
nv,
function(s)
local r=td[s]
return{
el=ga,
eq=not r:ns(),
r=r
}
end
)
end,function(_ENV)
fg(_ENV,function(_ENV)
_ENV:aw"pr"
end)
end,function(_ENV)
fg(_ENV,function(_ENV)
oz(_ENV:ee"ew",lx(_ENV:is"ew",_ENV:ee"an"+1,_ENV:ee"tj"))
_ENV:ts()
end)
end,function(_ENV)
wu(e,_ENV:x"tj".r)
end,function(_ENV)
e:tt(
_split"106,,!alanxoc3,code+sfx,design,6,,!gr8cadet,graphics,playtest,129,,!wadlo,magikarp,playtest,145,,!zep,pico-8,px9 func,137,,!pkmndata,blbpedia,pokeapi,serebii,smogon,upokcntr,volvox,nintendo",
function(az)
if _type(az)=="number"then
return{r=rj(az,rz())}
end
local te=1
if _sub(az,1,1)=="!"then
az,te=_sub(az,2),5
end
return{a=az,te=te,lf=az==""}
end
)
e.k=0
end,function(_ENV)
e:tt(hh,function(sz,s)
return{
a=sz.a,
l=sz,
eq=s-1>@0x5efd,
el=function(i,x)
fw(i,x.l,x.a,y,function(m,tr)
_poke(0x5efd,_mid(@0x5efd,s,#hh))
mv(tr)
end,y)
end
}
end)
end,function(_ENV)
e:tt(b[[;a,moves,ey,ag,el,%ai;;a,switch,ey,hw,el,%ai;;a,delete,el,%wk]])
nb.e.eh=0
end,function(_ENV)
local ed=_ENV:sf()
local of=0
for mi=1,4 do
if ed.z[mi].s>0 then of+=1 end
end
e:tt(b([[;a,change,ey,nb,el,%ai;;a,switch,ey,cw,el,%ai;;a,delete,eq,@,el,%yp]],of==1))
end,function(_ENV)
local ed,l=_ENV:sf()
ed.z[_ENV:ee"ag"+1]=ej(-1)
oz(_ENV:ee"ew",l)
_ENV:ts()
end,function(_ENV,sy,ov)
local ed,l=_ENV:sf()
e:tt(b[[,1,2,3,4]],function(t)
local o=ed.z[t]
return{
o=o,
a=o.a,
el=function(_ENV)ov(_ENV,t,ed,l)end,
eq=t==sy
}
end)
end,function(_ENV)
mz(_ENV,0,function(_ENV,t,ed)
_ENV:aw(ed.z[t].s>0 and "uy"or "nb")
end)
end,function(_ENV)
local sy=_ENV:ee"ag"+1
mz(_ENV,sy,function(_ENV,t,ed,l)
ed.z[t],ed.z[sy]=ed.z[sy],ed.z[t]
oz(_ENV:ee"ew",l)
_ENV:rn"ag"
end)
e.eh=ag.e.eh
end,function(_ENV)
local ed=_ENV:sf()
local r=td[ed.s]
local ug={}
ep(function(uw,gl)
for t=1,#uw do
local ln=uw[t]
_add(ug,{a=nf[ln].a,eq=ed:lq(ln),s=ln,tw=gl..t})
end
end,[[;,@,learn #;;,@,teach #;;,@,event #]],r.oj,r.ox,r.st)
e:tt(ug,function(eu)
return{
a=eu.a,
eq=eu.eq,
o=nf[eu.s],
gr=eu.tw,
el=function()
local l=_ENV:is"ew"
l[_ENV:ee"an"+1].z[_ENV:ee"ag"+1]=ej(eu.s)
oz(_ENV:ee"ew",l)
_ENV:rn"ag"
end
}
end)
end,function(_ENV)
local nx=fd(p.c)
if p.c.eb then
rg(p,p.c.eb)
_ENV:ts()_ENV:ts()
elseif #nx==0 then
rg(p,ej(0))
_ENV:ts()_ENV:ts()
end
e:tt(p.c.z,function(o)
return b([[eq,@,a,@,o,@,el,@]],
not nx[o],
o.a,
o,
function()
_ENV:ts()_ENV:ts()
rg(p,o)
end
)
end)
end,function(_ENV)
e:tt(b[[;a,fight,tw,fight|select|move,el,%ai,ey,ue;;a,switch,tw,switch|active|pokemon,el,%ai,ey,hq;;a,forfeit,tw,forfeit|pokemon|battle,el,%yr]])
end,function(_ENV)
e:tt(b[[,1,2,3]],function(t)
local l=sm(t-1)
local od={}
local ms=true
for t=1,6 do
od[t]=l[t].s
if not l[t]:mj()then
ms=false
end
end
return{
a="team #"..t,
l=od,
el=function()_ENV:ov()end,
eq=sb and ms
}
end)
end,function(l,t)
return l[t]and l[t].s or-1
end,function(_ENV)
local l=_ENV:is"ew"
e:tt(b[[,1,2,3,4,5,6]],function(t)
return{
r=l[t],
el=function(_ENV)
if l[_ENV:ee"an"+1]:ns()then
_ENV:aw"ch"
else
_ENV:aw"ed"
end
end
}
end)
end,function(_ENV)
local l=_ENV:is"ew"
e:tt(b[[,1,2,3,4,5,6]],function(t)
return{
eq=t==_ENV:ee"an"+1,
el=function(_ENV)
local ml,mh=_ENV:ee"an"+1,_ENV:ee"hw"+1
l[ml],l[mh]=l[mh],l[ml]
oz(_ENV:ee"ew",l)
_ENV:rn"an"
end,
r=l[t]
}
end)
e.eh=an.e.eh
end,function(_ENV)
local l=_ENV:is"ew"
e:tt(b[[,1,2,3,4,5,6]],function(t)
local eq=p.l[t]:mj()or p.c.tb==p.l[t]or p.l[t].ec==1
return{
eq=eq,
el=function()
_ENV:ts()_ENV:ts()
lj(p,p.l[t])
end,
r=p.l[t]
}
end)
end,function(_ENV)
local tu,aa=tu,aa
if tu.ok==aa.ok then aa.ok+=_sgn(_rnd"2"-1)end
p=tu.ok>aa.ok and tu or aa
end,function(_ENV,lh)
local cb=true
for t=tj.e.eh+lh,75.5+75.5*lh,lh do
if td[t]:ns()then
tj.e.eh=t
cb=false
tp"154"
break
end
end
if cb then aj()end
fp(_ENV)
end,function(i)tp(i:ee"tj")end,function()tp(ta"152")end,function(_ENV)tp(p.c.s)end,function(_ENV)
local l={}
for lm,s in _pairs(_split"133,7,35,1,25,4")do
lx(l,lm,s)
_poke(0x5e5a+s,1)
end
if@0x5efc==0 then
_poke(0x5efc,1)
oz(0,l)
end
tk=my[[ee,%bg,x,%bf,aw,%bc,ts,%bm,rn,%bu,r,%y,ty,%y,tx,%y,er,%y,es,%y,om,ij;fk;e,%am,og,error,xa,%y,ea,%y,uq,%aj,sj,%y,ty,%bp,up,%am,tx,%fn,er,%y,es,%y;ij;ea,~bz,er,~fr,es,~fs;tj;ea,%ke,er,%du,es,%dc;pr;ea,%fp,er,%du,es,%dc,uq,%vz,sj,%vq;an;ea,%vp,er,%dr,es,%ds,tx,%dh;hw;ea,%wq,er,%dr,es,%ds,tx,%dh;ed;ea,%ww,er,%du,es,%dc;ch;ea,%wx,er,%dr,es,%ds;uy;ea,%yg,er,%lk,es,%su,up,ag;nb;ea,%wy,er,%wb,es,%su;ag;ea,%wv,er,%lk,es,%su;cw;ea,%wz,er,%lk,es,%su;ew;og,player,ea,%sr,er,%ni,es,%no,sb,%am,ov,%wj;cl;og,player,ea,%sr,er,%ni,es,%no,sb,%au,ov,%ye;cd;og,player 1,ea,%sr,er,%ni,es,%no,sb,%au,ov,%bq;cc;og,player,ea,%sr,er,%ni,es,%no,sb,%au,ov,%vt;hp;og,player 2,ea,%sr,er,%ni,es,%no,sb,%au,ov,%bj;hf;og,trainer,ea,%vd,er,%ni,es,%no;ly;ea,%vu,er,%vf,es,%vm,sj,%vc;hz;ea,%yn,er,%rf,es,%ys;ue;ea,%yi,er,%rf,es,%su;hq;ea,%ya,er,%rf,es,%yo,tx,%dh;gg;tm,gf,ea,%mx,ty,%y,tx,%y,ur,tu;gf;tm,ci,ea,%mx,ty,%y,tx,%y,ur,aa;ci;tm,gg,ea,%wf,ty,%wm,tx,%wg,er,%rf,es,%wp,il,%am;fz;ea,%vk,er,%fr,es,%fs,sj,%vv;]]
ep(function(ik,kd,...)
tk[ik].e=kd(...)
end,[[;,tj,~th,~ht,4;;,pr,~rq,~tg;;,fz,~rq,~tg;;,ly,~rq,~tg;;,an,~th,~ht,3;;,hw,~th,~ht,3;;,ij,~th,~tg;;,ch,~th,~tg;;,uy,~th,~tg;;,nb,~th,~tg;;,ag,~th,~tg;;,cw,~th,~tg;;,ew,~th,~tg;;,hf,~th,~tg;;,hp,~th,~tg]])
ex(tk,[[hg,@,kp,@;ij;e;nm,%aj;hz;e;nm,%aj;cc;e,~hg;cd;e,~hg;cl;e,~hg;ed;e,~kp;]],tk.ew.e,tk.tj.e)
tp"152"
_menuitem(1,"close picodex",function()
_menuitem(1)
_menuitem(2)
_ENV:ak"db"
end)
_menuitem(2,"swap 🅾️/❎",function()
_poke(0x5eff,@0x5eff==0 and 1 or 0)
end)
end,function(gh)
gh.tk:ey()
end,function()ne.tk:tx()end,function()ne.tk:er()end,function()ne.tk:es()end,function(_ENV)e.ty(_ENV)end,function(_ENV)e.tx(_ENV)end,function(_ENV,ik)
return _ENV[ik].e.eh
end,function(_ENV,ik)
local e=ik and _ENV[ik].e or e
return e[e.eh+1]
end,function()
_sfx(-2,1)
end,function(_ENV)
_menuitem(1,"factory reset",function()
_memset(0x5e00,0,0x100)
_ENV:ak"cx"
end)
end,function()
return _btn()& 0x3f ~=0
end,function(_ENV)
if not fb()and hl then
hl=false
_ENV:ak()
_menuitem(1)
elseif fb()then
hl=true
_menuitem(1)
end
end,0,function(s)
_g.mg=_max(0,0+s-152)
_sfx(54+s\16,0,s%16*2,2)
end,function(_ENV)
_cls"0"
rm(0,128+_sin(_ENV:mf"uf"/4)*128,function()
ep(na,[[;,aMORG gAMES,64,-68,7,0;;,pRESENTS,64,-61,7,0;;,a pICO-8 pOKEDEX sIM,64,15,7,0]])
ep(wc,[[;,102,64,11,5,1]])
local cr,
dk,
os=
tk and tk.ij.e.eh,
tk and tk.cv-1,
ao=="rs"and 1
or ao=="id"and-1
or(ao=="lo"and-1 or 1)*_cos(_ENV:mf(ao)/2)
rm(30-(os+1)*15+(om=="cx"and ta"3"-1 or 0),27,function()
ep(_rectfill,[[;,14,18,@,87,5]],63+_max(0,os*54))
if oq==0 then
ep(_rectfill,[[;,14,18,117,87,13]])
ep(vg,[[;,14,21,40,40,@;;,71,18,46,13,@;;,71,67,46,21,@]],tx,er,es)
end
ep(_map,[[;,24,0,2,1,8,3;;,8,0,2,9,8,11]])
ep(function(ah,gv,gy,wd,g,w)
return _spr((oq<=ah)and(mg==ah and _stat"46">=0 and wd or gy)or gv,g,w)
end,[[;,0,135,133,134,6,3;;,1,132,128,131,12,3;;,2,132,129,131,17,3;;,3,132,130,131,22,3]])
ep(function(hd,gn,gi,g,w)
_spr(_btn(hd)and gn or gi,g,w)
end,[[;,0,186,154,10,77;;,1,188,156,26,77;;,2,171,139,18,73;;,3,187,155,18,81;;,4,170,138,42,77;;,5,172,140,50,77]])
if os<=0 then
mq(0,2+64*(1-_abs(os)),_abs(os))
if os==-1 and hl then _spr(123,6,49)end
else
mq(16,62,os)
if os==1 then
if cr then _spr(153,70+cr*8,41)end
if dk and dk>=0 then _spr(153,70+dk*8,49)end
end
end
end)
end)
end,function(kl,cg,tz)
tz*=64
for w=9,96 do
_tline(cg,w,cg+tz-1,w,kl,w/8-1.125,8/tz,0)
end
end,function(ap,g,w,nu)
local cp,cf="",""
for t=1,#ap do
local ma,cy=_sub(ap,t,t),t%2==0
cp..=cy and " "or ma
cf..=cy and ma or " "
end
na(cp,g,w,nu,0)
na(cf,g,w+1,nu,0)
end,function(ap,g,w,nu,pu)
ap=""..ap
if pu==0 then g-=#ap*2
elseif pu>0 then g-=#ap*4+1 end
_print(ap,g,w,nu)
end,function(ny,dq,iu,rc,go)
_clip(-%0x5f28+ny,-%0x5f2a+dq,iu,rc)
rm(ny,dq,go)
_clip()
end,function(_ENV)
if s>=0 then
return not tj or@(0x5e5a+s)>0
end
end,function(r)
ie("pkmn #"..r.s)
end,function(r)
if r:ns()then
ax(r.a.."|"..sk[r.ot].a.."|"..sk[r.ow].a)
else
ax"?????????|????|??????"
end
end,function(s,g,w,tz,on)
tz=tz or 1
on=on or 1
local hj=s/8\1
local dy=s%8
if hj ~=mp then
mp=hj
_memcpy(0x0000,0x8000+0x400*hj,0x400)
end
local iu,rc=16*tz,16*on
_sspr(dy*16,0,16,16,g-iu/2,w-rc/2,iu,rc)
end,function(_ENV,g,w,dy,ic,nw)
local s=_ENV:ns()and s or-1
if s==25 and _ENV:lq(53)then s=152 end
if s==54 and _ENV:lq(143)then s=153 end
if oa and oa>0 then s=154 end
if not ws or ec ~=1 and not mr and not(ab ~=0 and eb.ol==sc)then
if s<0 then _spr(107,g-4,w-4)return end
ic,nw=ic or 1,nw or 1
local nq=_max(_abs(ic),1)\ 1
ep(function(nu,py,pw,pg,pp)
for eh=1,15 do _pal(eh,nu)end
for t=-nq,nq,nq*2 do
dl(s,g+(py or t),w+(pw or t),ic,nw)
dl(s,g+(pg or t),w+(pp or t),ic,nw)
end
end,[[;,@,@,%am,@,%am;;,1,%am,0,0,%am]],dy,-nq,nq)
_pal()dl(s,g,w,ic,nw)
end
end,function(e,r)
e:tt{}
ex(e,[[;r,@;;lf,%au;;a,lvl 50,te,5;;a,@]],r,(r.em or r.tf).."/"..r.tf)
_foreach(b[[;et,ae,a,spc;;et,ti,a,att;;et,ef,a,def;;et,tn,a,spd;;et,hu,a,tot]],function(nj)
if not nj.et then
_add(e,{a=nj.a,te=5})
elseif r[nj.et]then
_add(e,{a=nj.a.." "..r[nj.et]})
end
end)
ep(function(a,et)
if #td[r.s][et]>0 then
_add(e,{a=a,te=5})
_foreach(td[r.s][et],function(eu)
_add(e,{a=nf[eu].a})
end)
end
end,[[;,learn,oj;;,teach,ox;;,event,st]])
end,function(i)i:aw"hf" end,function(i)i:aw"hp" end,function(_ENV)
fy(_ENV,
{sm(_ENV:ee"ew"),"player 1",false,y,y},
{sm(_ENV:ee"hp"),"player 2",false,y,y}
)
end,function(_ENV)
local uu={}
for t=1,152 do _add(uu,t%152)end
fw(_ENV,uu,"horde",y,
function(kb,tr)fh(tr)end,
fh
)
end,function(mc)
mv(mc)
_poke(0x5efe,_mid(@0x5efe,#di(mc.l),255))
end,function(i)
i:aw"an"
end,function(i,ee)
return sm(i:ee(ee))
end,function(i)
local l=sm(i:ee"ew")
return l[i:ee"an"+1],l
end,function(m,r)
sg(m,m,"|comes|back",function(tv)
tv.u.c=rp(r)
tv.u.c.mr=true
sg(m,m,"|comes|out",function(_ENV)
d.mr=false
end)
end)
m.ok=3000
end,function(u,o)
sg(u,u,"|uses|"..o.a,function(tv)
tv.o=o
local _ENV=tv
if o.s>0 then
o.oh-=1
end
if o.s==47 or o.s==36 then
nl(_ENV,d.em)
end
if vb(d,f,o)then
v(u,"|missed|"..o.a)
if o.s==145 or o.s==73 then
nl(_ENV,1)
end
else
if o.ez ~=0 then
f.rd=o.s
end
if o.al(_ENV)then
v(u,"|failed|"..o.a)
end
end
end)
end,function(_ENV,oe,gq)
if not eb and ab==0 then
ab,eb=oe,gq
end
end,function(u,o)
sg(u,u,false,function(tv)
tv.o=o
local _ENV=tv
d:dd("ab",y)
if d.ec==6 then
end
if d.ec==3 then
if _rnd"1"<.2 then
v(u,"|thawed|out")
d.tb.ec=0
else
v(u,"|is|frozen")
return
end
end
if f.eb and f.eb.ol==nh then
v(u,"|is|trapped")
return
end
if d.nc==o.ev then
v(u,"|is|disabled")
return
end
if d.sv>0 and ta"2"==0 then
v(u,"|confuse|damage")
nl(_ENV,he(d,f,ej(-1)))
return
end
if d.lw then
v(u,"|is|flinching")
return
end
lz(u,o)
end)
end,function(c,et,ho)
if c[et]>0 then
c[et]-=1
if c[et]==0 then
ho()
end
end
end,function(u)
return it(u,false,function(_ENV)
if d.ec==6 or d.ec==3 then
d.ab=0
end
if d.ab==0 then
d.eb=nil
end
local hv=_max(d.tf\16,1)
local lu=function(pk)
v(u,pk.."|damage")
nl(_ENV,hv)
end
if d.ec==5 then
if d.im>0 then
hv*=d.im
d.im+=1
end
lu"|poison"
end
if d.ec==2 then lu"|burn" end
if d.cj then
lu"|seed"
if f.em<f.tf then
v(tr,"|seed|leeching")
ry(_ENV,tr,hv)
end
end
d:dd("sv",function()
v(u,"|confusion|ended")
end)
d:dd("dp",function()
v(u,"|"..d.z[d.nc].a.."|enabled")
d.nc=0
end)
end)
end,function(m,o)
m.ng={}
local le=1000
yh(m,o)
if o.s==120 then le=2000 end
if o.s==18 or o.s==4 or o.s==89 or o.s==30 then
le=0000
end
m.ok=_min(3000,le+m.c:nr"tn")
end,function(i,m)
return m==i.tu and i.aa or i.tu
end,function(la,iv,ll,a)
return{m=la,a=a or la.c.a,c=la.c,iv=iv,ll=ll or y}
end,function(p,...)
_add(p.ng,it(...))
end,function(_ENV)
d.tb.ec=1
u:kr()
end,function(i)
if sn then aj()end
if nt then tp"154" end
if nt or not i.il then
while true do
for ay in _all{i.tu,i.aa}do
if not rv(ay.l)then
i.p=nd(i,ay)
i:ak"ly"
return
end
end
local aq=yu(i)
if aq then
local dj=aq.c==i.tu.c and i.tu or i.aa
local ih=b([[o,@,u,@,tr,@,v,@]],o,dj,nd(i,dj),function(...)
sg(dj,...)
end)
ih.d=ih.u.c
ih.f=ih.tr.c
aq.ll(ih)
if aq.iv then
i.il=aq
return
else
end
else
i:ak()
return
end
end
end
end,function(i)
for ay in _all{i.tu,i.aa}do
if ay.c.em<=0 then
if ay.c.ec ~=1 then
return it(ay,"|is|fainted",ve)
elseif ay ~=i.p then
ay.c=rp(rv(ay.l))
return it(ay,"|comes|out")
end
end
end
for at in _all{i.p,nd(i,i.p)}do
local gk=nd(i,at)
while #at.ng>0 do
local aq=_deli(at.ng,1)
if aq.c.ec ~=1 and(aq.c==at.c or aq.c==gk.c)then
return aq
end
end
if at.c.em<=0 and at.c.ec==1 then
at.c=rp(rv(at.l))
return it(at,"|comes|out")
end
if not at.co then
at.co=true
return yl(at)
end
end
end)
ex(_g,[[lq,@,mj,@,rk,@,fd,@,yt,@,vo,@,vb,@,fl,@,dt,@,he,@,mx,@,yr,@,fy,@,fw,@,dn,@,lv,@,lb,@,mk,@,vn,@]],function(_ENV,gz)
for eu in _all(z)do
if eu.s==gz then
return true
end
end
end,function(_ENV)
return #rk(_ENV,true)==0
end,function(r,wi)
local av={}
_foreach(r.z,function(eu)
if eu.s>0 and(wi or eu.oh>0 and r.nc ~=eu.ev)then
_add(av,eu)
av[eu]=true
end
end)
return av
end,function(_ENV)
if ab ~=0 then
return{eb}
else
return rk(_ENV)
end
end,function(c)
local nx=fd(c)
return nx[ta(#nx)+1]or ej(0)
end,function(_ENV,sa)
local df=1024
if sa==-1 then return 1 end
if sa==107 or sa==164 or sa==57 or sa==157 then df*=.3 end
if mw then df*=.3 end
return _rnd"1"<_min(.99,(dx+76)/df)and 2 or 1
end,function(af,ar,o)
if o.ez<=0 then return false end
if(o.ol==sl or o.ol==sc)and not af.eb then return false end
if ar.eb and ar.eb.ol==sc then return true end
if af.eb and af.eb.ol==nh then return false end
return _rnd(ar.oc)>o.ez/100*af:nr"ez"or ta"256"==0 and ta"256"==0
end,function(we,gc)
return sk[we][gc]or 1
end,function(o,ar)
return fl(o.oy,ar.ot)*fl(o.oy,ar.ow)
end,function(af,ar,o)
local ti,ef=af:nr"ae",ar:nr"ae"
if o.oy%2==1 then
ti,ef=af:nr"ti",ar:nr"ef"
if ar.cz then
ef*=2
end
elseif ar.cq then
ef*=2
end
local kg=_mid(
3,997,
(2*af.mt*vo(af,o.s)/5+2)/50
*o.dw
*_mid(10,.2,ti/ef)
)+2
return kg
*((o.oy==af.ot or o.oy==af.ow)and 1.5 or 1)
*dt(o,ar)
*(_rnd".15"+.85)\1
end,function(_ENV)
p=_ENV[ur]
do local _ENV=p.c
ca=em
lw=false
end
p.co=false
if p.wn then
rg(p,yt(p.c))
_ENV:ak()
elseif #p.ng>0 then
_ENV:ak()
else
hz.e,
ue.e,
hq.e,
il,
oi[#oi]=p.uk,
p.wa,
p.wt,
it(p,""),
om
_ENV:aw"hz"
end
end,function(_ENV)
_ENV:ts()
p=_ENV:nd(p)
_ENV:ak"ly"
end,function(_ENV,fq,fj)
fq.et,fj.et="tu","aa"
for dg in _all{fq,fj}do
_ENV[dg.et]=b([[ng,#,ok,1,uk,@,wa,@,wt,@,l,@,a,@,wn,@,kr,@,pm,@]],th(tg),
th(tg),
th(ht,3),
_unpack(dg))
local _ENV=_ENV[dg.et]
uk.nm=aj
c=rp(rv(l))
_add(ng,it(_ENV,"|comes|out"))
end
p=tu
_ENV:aw"ci"
end,function(_ENV,ui,a,kh,gd,kc)
local pt={}
for t=1,#ui do
lx(pt,t,ui[t])
end
fy(_ENV,
{_ENV:is"ew","player",false,y,gd},
{pt,a,true,kh,kc}
)
end,function(iq)
mk(_peek2(iq),
function(...)return lv(0x8000+iq*0x1000,...)end,
function(...)return lb(0x8000+iq*0x1000,...)end)
end,function(li,g,w)
g=_min(_max(0,g),127)\1
w=w\1
local q=_peek(w*64+li+g\2)
if g%2==1 then return(q & 0xf0)>>>4
else return(q & 0x0f)end
end,function(li,g,w,q)
g=_min(_max(0,g),127)\1
w=w\1
local lr=w*64+li+g\2
local uc=_peek(lr)
if g%2==1 then _poke(lr,(uc & 0x0f)|(((q or 0)& 0x0f)<<4))
else _poke(lr,(uc & 0xf0)|(((q or 0)& 0x0f)<<0))
end
end,function(ck,lv,lb)
local function ct(ah,q)
local k,t=ah[1],1
while k!=q do
t+=1
k,ah[t]=ah[t],k
end
ah[1]=q
end
local hr,hs=0,0
function mm(np)
if hs<8 then
hs+=8
hr+=@ck>>hs
ck+=1
end
hr<<=np
local q=hr&0xffff
hr^^=q
hs-=np
return q
end
function iz(n)
local np=0
repeat
np+=1
local ce=mm(np)
n+=ce
until ce<(1<<np)-1
return n
end
local iu,wl,kn,dm,ua,g,w,hk,lt=iz"1",iz"0",iz"1",{},{},0,0,0
for t=1,iz"1" do _add(dm,mm(kn))end
for w=0,wl do
for g=0,iu-1 do
hk-=1
if(hk<1)then
hk,lt=iz"1",not lt
end
local tq=w>0 and lv(g,w-1)or 0
local ah=ua[tq]or{_unpack(dm)}
ua[tq]=ah
local k=ah[lt and 1 or iz"2"]
ct(ah,k)
ct(dm,k)
lb(g,w,k)
end
end
end,function(ey)
tp(ey.ri)
ey:ro()
end)
po[0]=""
_g.dv=b[[-1;,none,%h;0;,struggle,%rw;;,megapnch,%h;;,razrwind,%sl;;,sworddnc,%ek,%eo,ti,2;;,whrlwind,%fo;;,megakick,%h;;,toxic,%yy;;,horndril,%de;;,bodyslam,%h,30,%en,4;;,takedown,%rw;;,doubedge,%rw;;,bublbeam,%h,10,%ei,%eo,tn,-1;;,watergun,%h;;,icebeam,%h,10,%en,3;;,blizzard,%h,10,%en,3;;,hyprbeam,%bn;;,payday,%h;;,submsion,%rw;;,counter,%bl;;,seistoss,%ad,50;;,rage,%yq;;,megdrain,%rb;;,solrbeam,%sl;;,drgnrage,%ad,40;;,thndrblt,%h,10,%en,4;;,thunder,%h,10,%en,4;;,earthqke,%h;;,fissure,%de;;,dig,%sc,digging;;,psychic,%h,30,%ei,%eo,ae,-1;;,teleport,%yb;;,mimic,%ba;;,doubteam,%ek,%eo,oc,1;;,reflect,%ek,%ia,|raises|defense,cz;;,bide,%bi;;,metrnome,%bo;;,selfdstr,%h;;,eggbomb,%h;;,fireblst,%h,30,%en,2;;,swift,%h;;,skulbash,%sl;;,softboil,%fi;;,dreameat,%br;;,skyattck,%sl;;,rest,%yj;;,thndrwav,%en,4;;,psywave,%yz;;,explsion,%h;;,rockslid,%h;;,triattck,%h;;,substute,%yk;;,cut,%h;;,fly,%sc,flying;;,surf,%h;;,strength,%h;;,flash,%ei,%eo,ez,-1;;,pound,%h;;,karatchp,%h;;,doubslap,%ii;;,comtpnch,%ii;;,firepnch,%h,10,%en,2;;,icepnch,%h,10,%en,3;;,thndpnch,%h,10,%en,4;;,scratch,%h;;,vicegrip,%h;;,guilotin,%de;;,gust,%h;;,wingatck,%h;;,bind,%nh;;,slam,%h;;,vinewhip,%h;;,stomp,%h,30,%ei,%io;;,doubkick,%sd,2,%y;;,jumpkick,%h;;,rllngkck,%h,30,%ei,%io;;,sandatck,%ei,%eo,ez,-1;;,headbutt,%h,30,%ei,%io;;,hornatck,%h;;,furyatck,%ii;;,tackle,%h;;,wrap,%nh;;,thrash,%fa;;,tailwhip,%ei,%eo,ef,-1;;,psnsting,%h,20,%en,5;;,twineedl,%be;;,pinmisil,%ii;;,leer,%ei,%eo,ef,-1;;,bite,%h,10,%ei,%io;;,growl,%ei,%eo,ti,-1;;,roar,%fo;;,sing,%en,6;;,sprsonic,%ei,%sh;;,sonicbom,%ad,20;;,disable,%bh;;,acid,%h,10,%ei,%eo,ef,-1;;,ember,%h,10,%en,2;;,flamthwr,%h,10,%en,2;;,mist,%ek,%ia,|stat lower|immunity,ub;;,hydropmp,%h;;,psybeam,%h,10,%ei,%sh;;,aurorabm,%h,10,%ei,%eo,ti,-1;;,peck,%h;;,drillpck,%h;;,lowkick,%h,30,%ei,%io;;,absorb,%rb;;,leechsed,%ei,%ia,|is now|seeded,cj;;,growth,%ek,%eo,ae,1;;,razrleaf,%h;;,psnpowdr,%en,5;;,stunspor,%en,4;;,slppowdr,%en,6;;,petldanc,%fa;;,strngsht,%ei,%eo,tn,-1;;,firespin,%nh;;,thndshck,%h,10,%en,4;;,rockthrw,%h;;,cnfusion,%h,10,%ei,%sh;;,hypnosis,%en,6;;,meditate,%ek,%eo,ti,1;;,agility,%ek,%eo,tn,2;;,quickatk,%h;;,ngtshade,%ad,50;;,screech,%ei,%eo,ef,-2;;,recover,%fi;;,harden,%ek,%eo,ef,1;;,minimize,%ek,%eo,oc,1;;,smokscrn,%ei,%eo,ez,-1;;,cnfusray,%ei,%sh;;,withdraw,%ek,%eo,ef,1;;,dfnscurl,%ek,%eo,ef,1;;,barrier,%ek,%eo,ef,2;;,lghtscrn,%ek,%ia,|raises|spcdefense,cq;;,haze,%bs;;,fcsenrgy,%ek,%ia,|raises|crit ratio,mw;;,mirrmove,%bt;;,lick,%h,30,%en,4;;,smog,%h,30,%en,5;;,sludge,%h,30,%en,5;;,boneclub,%h,10,%ei,%io;;,watrfall,%h;;,clamp,%nh;;,spikcann,%ii;;,constrct,%h,10,%ei,%eo,tn,-1;;,amnesia,%ek,%eo,ae,2;;,kinesis,%ei,%eo,ez,-1;;,hijmpkck,%h;;,glare,%en,4;;,poisngas,%en,5;;,barrage,%ii;;,leechlif,%rb;;,lovekiss,%en,6;;,tranform,%yw;;,bubble,%h,10,%ei,%eo,tn,-1;;,dizypnch,%h;;,spore,%en,6;;,splash,%yx;;,acidarmr,%ek,%eo,ef,2;;,crabhamr,%h;;,furyswps,%ii;;,bonerang,%sd,2,%y;;,hyprfang,%h,10,%ei,%io;;,sharpen,%ek,%eo,ti,1;;,convrson,%bd;;,suprfang,%yv;;,slash,%h]]
pi=b[[;j,13,ss,1,nz,5;;j,6,ss,13,nz,13;;j,5,ss,1,nz,5;;j,6,ss,5,nz,5;;j,1,ss,13,nz,5]]
pa=b[[0,0x5e00,1,0x5e1e,2,0x5e3c]]
mp=16
function _init()
local _ENV=_g
_memset(0x8000,0,0x7fff)
ne=my[[om,pf;ea,%vn,oq,4;fk;ao,id,oq,4,ri,-1,hl,%am,ro,%y,ty,%y,to,%y,tx,%y,er,%y,es,%y,tk,;pf;tm,uf,as,.5,to,%ac;uf;tm,id,as,.5,to,%ac,ro,%ym;cx;ao,id,tm,id,as,.5,to,%ac;id;ao,id,tm,lo,ro,%vj,to,%ac,ty,%vx;lo;ao,lo,tm,ge,as,.2,to,%ac;ge;ao,rs,tm,pz,oq,3,as,.2,ri,155,to,%ac;pz;ao,rs,tm,pq,oq,2,as,.2,ri,154,to,%ac;pq;ao,rs,tm,i,oq,1,as,.2,ri,153,to,%ac;i;ao,rs,tm,db,oq,0,ro,%vs,to,%ac,ty,%vi,tx,%vl,er,%vh,es,%vr;db;ao,db,tm,id,as,.25,to,%ac,ty,%y;]]
ac(ne)
_flip()
tp"158"
dn(0x0)
dn(0x2)
dn(0x4)
ep(_poke,[[;,0x5f5c,8;;,0x5f5d,2;;,0x5f56,0xe0]])
mk(_peek2"0x6",_mget,_mset)
yc()
yd()
local cs=_peek2"0xc"
for t,k in _pairs(hh)do
local nv={a=k}
for mi=1,6 do
_add(nv,_peek(cs))
cs+=1
end
hh[t]=nv
end
_memcpy(0x0000,0xc000,0x2000)
end
function _update60()
local _ENV=_g
sn,nt=_btnp"4",_btnp"5"
lg,lp=ff(_btnp,0,1),ff(_btnp,2,3)
if@0x5eff==1 then
sn,nt=nt,sn
end
ne:ey()
end
function _draw()
local _ENV=_g
ne:to()
end