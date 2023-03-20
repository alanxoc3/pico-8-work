function ru(q,table,gc)
if _ord(q)==37 then return _g[_sub(q,2)]
elseif q=="~"then return table
elseif _ord(q)==126 then return table[_sub(q,2)]
elseif q=="@"then return _deli(gc,1)
elseif q=="#"then return{}end
return q ~=""and q or nil
end
function ex(table,hb,...)
local ta,pk,od={...},_split(hb,";"),table
_foreach(pk,function(im)
local iu=_split(im)
if #iu>1 then
if iu[1]==""then
_foreach(iu,function(q)
_add(od,ru(q,table,ta))
end)
else
for t=1,#iu,2 do
od[iu[t]]=ru(iu[t+1],table,ta)
end
end
od=table
else
if im==""then im=#od+1 end
if _type(od[im])~="table"then
od[im]={}
end
od=od[im]
end
end)
return table
end
function b(...)
return ex(_setmetatable({},{__index=_g}),...)
end
ex(_g,[[au,@,am,@,kc,@,y,@]],true,false,"",function(...)return...end)
ex(_g,[[mw,@,kt,@,fb,@,ke,@,vz,@,bd,@,bc,@,bl,@,b,@,ex,@,ru,@,wl,@,aj,@,to,@,ep,@,rm,@,fm,@,oq,@,ax,@,td,@,pa,@,pn,@,pi,@,sk,@,xs,@,kd,@,ku,@,xn,@,nm,@,hh,@,ai,@,rq,@,tl,@,by,@,bv,@,bw,@,bp,@,bg,@,bb,@,tg,@,ht,@,mz,@,yu,@,ns,@,ba,@,bs,@,fe,@,be,@,yp,@,bh,@,bi,@,ry,@,fo,@,bt,@,yz,@,fa,@,yw,@,rx,@,ek,@,ei,@,eo,@,yg,@,yv,@,en,@,ie,@,it,@,sh,@,yb,@,yk,@,br,@,sd,@,ia,@,yq,@,yx,@,ft,@,nr,@,sc,@,bo,@,sl,@,rw,@,h,@,bn,@,rb,@,de,@,yj,@,yy,@,ad,@,nh,@,sp,@,fd,@,yh,@,rj,@,rp,@,mb,@,di,@,da,@,rv,@,wb,@,lx,@,sm,@]],function(pv)
return ex(b[[ak,%fb,me,%ke,ey,%vz,mm,%kt,re,0,cv,0,mi,%au,oc,kv,ea,%y,ty,%y;oi;,;]],pv)
end,function(_ENV,et)
if et==oc then
return as and re/as or 0
end
if _ENV[et]and _ENV[et].ki then
return 1
end
return 0
end,function(_ENV,ra)
rr=ra or tm
end,function(_ENV,ra)
re,rr,mi,tm,as=0
_ENV[oc].ki=true
for ld,k in _pairs(fv)do _ENV[ld]=k end
for ld,k in _pairs(_ENV[ra])do _ENV[ld]=k end
oc=ra
_ENV:ea()
cv=#oi
end,function(_ENV)
re+=1/60
if mi then _ENV:me(oc)end
if as and re>=as then
_ENV:ak()
end
while rr do
_ENV:me(rr)
end
_ENV:ty()
end,function(_ENV,py)
while rr ~=py and #oi>0 do
_ENV:tr()
end
end,function(_ENV)
_deli(oi)
_ENV:ak(oi[#oi]or "ix")
end,function(_ENV,um)
_add(oi,um)
_ENV:fb(um)
end,b,ex,ru,function(pz,g,w,tz,on,...)
tz,on=tz or 1,on or 1
_spr(pz,g-tz*4,w-on*4,tz,on,...)
end,function()
tp"153"
end,function(g)
return _flr(_rnd(g))
end,function(al,ap,...)
_foreach(b(ap,...),function(ta)
al(_unpack(ta))
end)
end,function(gk,gv,al)
local ul,uh=%0x5f28,%0x5f2a
_camera(ul-gk,uh-gv)
al()
_camera(ul,uh)
end,function(ha,tq,hd)
return ha(tq)and ha(hd)and 0 or ha(tq)and-1 or ha(hd)and 1 or 0
end,function(az)
nt(az or "",23,4,1,0)
end,function(hb)
ep(_rectfill,[[;,0,0,45,6,1]])
ep(nt,[[;,@,23,1,13,0;;,@,23,8,1,0;;,@,23,15,1,0]],_unpack(_split(hb,"|",false)))
end,b[[]],_split"missingno,bulbasaur,ivysaur,venusaur,charmander,charmeleon,charizard,squirtle,wartortle,blastoise,caterpie,metapod,butterfree,weedle,kakuna,beedrill,pidgey,pidgeotto,pidgeot,rattata,raticate,spearow,fearow,ekans,arbok,pikachu,raichu,sandshrew,sandslash,nidoran f,nidorina,nidoqueen,nidoran m,nidorino,nidoking,clefairy,clefable,vulpix,ninetales,jigglypuff,wigglytuff,zubat,golbat,oddish,gloom,vileplume,paras,parasect,venonat,venomoth,diglett,dugtrio,meowth,persian,psyduck,golduck,mankey,primeape,growlithe,arcanine,poliwag,poliwhirl,poliwrath,abra,kadabra,alakazam,machop,machoke,machamp,bellsprout,weepinbell,victreebel,tentacool,tentacruel,geodude,graveler,golem,ponyta,rapidash,slowpoke,slowbro,magnemite,magneton,farfetchd,doduo,dodrio,seel,dewgong,grimer,muk,shellder,cloyster,gastly,haunter,gengar,onix,drowzee,hypno,krabby,kingler,voltorb,electrode,exeggcute,exeggutor,cubone,marowak,hitmonlee,hitmonchan,lickitung,koffing,weezing,rhyhorn,rhydon,chansey,tangela,kangaskhan,horsea,seadra,goldeen,seaking,staryu,starmie,mr mime,scyther,jynx,electabuzz,magmar,pinsir,tauros,magikarp,gyarados,lapras,ditto,eevee,vaporeon,jolteon,flareon,porygon,omanyte,omastar,kabuto,kabutops,aerodactyl,snorlax,articuno,zapdos,moltres,dratini,dragonair,dragonite,mewtwo,mew",b"0,none;,fainted,burned,frozen,paralyzed,poisoned,sleeping",b"0,NON;,FNT,BRN,FZN,PAR,PSN,SLP",b[[0;j,0,o,%kc;1;j,0,o,normal,15,0,13,.5;2;j,5,o,fire,8,2,10,2,11,2,2,.5,4,.5,13,.5,14,.5;3;j,2,o,fighting,10,2,1,2,13,2,15,0,11,.5,9,.5,5,.5,12,.5;4;j,4,o,water,2,2,7,2,13,2,14,.5,8,.5,4,.5;5;j,1,o,poison,11,2,8,2,15,.5,7,.5,5,.5,13,.5;6;j,6,o,electric,9,2,4,2,7,0,14,.5,6,.5,8,.5;7;j,2,o,ground,6,2,2,2,5,2,13,2,9,0,11,.5,8,.5;8;j,3,o,grass,7,2,13,2,4,2,11,.5,14,.5,2,.5,9,.5,8,.5,5,.5;9;j,0,o,flying,11,2,3,2,8,2,6,.5,13,.5;10;j,4,o,ice,14,2,9,2,8,2,2,.5,10,.5,4,.5;11;j,3,o,bug,8,2,12,2,3,.5,2,.5,9,.5,15,.5,5,.5;12;j,1,o,psychic,3,2,5,2,12,.5;13;j,0,o,rock,11,2,2,2,9,2,10,2,3,.5,7,.5;14;j,0,o,dragon,14,2;15;j,1,o,ghost,15,2,1,0,12,0;17;j,0,o,bird;]],b[[sv,confused,eq,disable,xa,digging,kq,flying,kj,prepare,kk,recharge,lw,flinch,kb,thrashing,kw,trapping,ky,trapped,kx,enraged,xo,decoyed,mg,focus,ub,mist,cz,reflect,cq,screened,cj,seeded,ic,toxiced,cn,tranform]],b[[ae,spc,tn,att,ef,def,ts,spd,ez,acc,ol,eva]],b[[0;j,6,om,13;;j,14,om,4;;j,9,om,4;;j,11,om,3;;j,12,om,5;;j,8,om,2;;j,10,om,4]],b[[0;o,status;;o,physical;;o,special;]],b[[]],_split"youngstr,bugcatch,junior,brock,lass,hiker,swimmer,misty,gentlman,sailor,rocker,ltsurge,channelr,gambler,beauty,erika,biker,birdkeep,juggler,koga,blckbelt,rocket,psychic,sabrina,scientst,pkmaniac,suprnerd,blaine,cooltrnr,fishrman,tamer,giovanni,lorelei,bruno,agatha,lance,blue,green,red,legendry",function(i,x)
if x.ey then
i:aw(x.ey)
else
i:tr()
end
end,function(sw,sq)
return b([[sw,@,sq,@,k,~sq,eg,1,ty,%bp,tk,%bb,nu,%bv,tt,%by]],sw,sq or 0)
end,function(sw,eg)
return ex(rq(sw),[[eh,0,eg,@,ty,%bg,hx,%bw]],eg or 1)
end,function(e,fk,wt)
while _deli(e)do end
for t=1,#fk do
_add(e,(wt or y)(fk[t],t))
end
end,function(i)
i:tr()
tp"154"
end,function(e,hi,wn)
if wn then
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
if sn then e.nu(i)end
if ne then i:sj()end
e.k+=lp
if lg ~=0 then i:uq(lg)end
local gw=e.k
e.k=_mid(e.sq,e.k,#e-3)
if e.k ~=gw then
aj()
elseif lp ~=0 then
tp"154"
end
end,function(i)
local e=i.e
e:hx"0"
e:hx(lp,true)
e:hx(lg)
if ne then
local x=e[e.eh+1]
if x.eq then
aj()
elseif x.el then
tp"155"
x.el(i,x)
end
end
if sn then e.nu(i)end
end,function(i)
local e=i.e
local hn=e.eg>1 and 10 or 40
local nw=20-(e.eg*hn)/2
ep(_rectfill,[[;,0,0,39,39,1;;,0,@,39,@,13]],5-e.k*10,4+(_max(_ceil(#e/e.eg),3)-e.k)*10)
for t=-1,e.eg*5-1 do
local ij=(e.k-1)*e.eg+t+1
local x=e[ij]
if x then
local rt,g,w=x.te or 1,nw+t%e.eg*10,t\e.eg*10
if x.eq then rt=3 end
if ij-1==e.eh then rt+=1 end
if not x.lf then
_rectfill(g,w-5,g+hn-1,w+4,po[rt].j)
rm(t%e.eg*hn+nw+hn/2,t\e.eg*10-3,function()
e.sw(x,po[rt])
end)
end
end
end
end,function(x,te)
if x.r then
local te=ku[sk[x.r.ot].j]
ep(_rectfill,[[;,-20,-2,19,17,@;;,-20,14,19,17,@]],te.j,te.om)
x.r:ti(0,8,te.om,1,1)
else
my(x.o,0,0,te.ss)
end
end,function(x,te)
x.r:ti(0,3,te.nq,.375,.375)
end,function(m)
local l=da(m.l)
_del(l,m.c.tb)
if #l>0 then
return l[to(#l)+1]
end
end,function(tq,oo,ml)
local ut=tq.nv[oo]
if not tq.ub or ml>0 then
tq.nv[oo]=_mid(-6,6,ut+ml)
end
return ut ~=tq.nv[oo]
end,function(tq,oo)
local ow=tq.nv[oo]
return _ceil(_mid(1,999,
tq[oo]*(
(oo=="ol"or oo=="ez")
and _mid(1,1+ow/3,3)/_mid(1,1-ow/3,3)
or _mid(2,2+ow,8)/_mid(2,2-ow,8)
)
))
end,function(_ENV)
v(u,"|not|implemented")
end,function(_ENV)
if f.dp>0 then return true end
local av=rk(f)
if #av==0 then return true end
f.dp=to"6"+2
f.nd=av[to(#av)+1].ev
v(th,"|"..f.z[f.nd].o.."|disabled")
if f.eb and f.eb.ev==f.nd then
f.ab=0
end
end,function(_ENV,s,ev)
local rh=ej(s,ev)
rh.ip,rh.ux=5,5
z[ev]=rh
return rh
end,function(_ENV)
local ud=rk(f,true)
v(u,"|copied|"..fe(d,ud[to(#ud)+1].s,a.ev).o)
end,function(_ENV)
if d.cn then
return true
else
v(u,"|copied|"..f.o,function()
d.cn=true
_foreach(_split"s,tn,ef,ts,ae,ot,op",function(et)
d[et]=f[et]
end)
d.z={}
_foreach(f.z,function(eu)
fe(d,eu.s,eu.ev)
end)
end)
end
end,function(_ENV)
ex(d,[[ot,@,op,@,xi,%au]],f.ot,f.op)
v(u,"|copied|types")
end,function(_ENV)
_foreach({th,u},function(m)
ex(m.c.nv,[[ae,0,tn,0,ef,0,ts,0,ez,0,ol,0]])
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
lz(u,ej(to(164)+1,a.ev))
end,function(_ENV)
if d.rd>0 then
lz(u,ej(d.rd,a.ev))
else
return true
end
end,function(_ENV)
local r=mz(th)
if r then
lj(th,r)
else
return true
end
end,function(_ENV)
local r=mz(u)
if r then
lj(u,r)
else
return true
end
end,function(s,gi)
return(_sgn(s)>0 and "|+"or "|-").._abs(s)..gi
end,function(_ENV,al,...)return al(_ENV,u,...)end,function(_ENV,al,...)return al(_ENV,th,...)end,function(_ENV,m,et,ow)
if yu(m.c,et,ow)then
v(m,rx(ow,"/6|"..kd[et]))
else
return true
end
end,function(_ENV)
if en(_ENV,5)and f.ec ~=5 then
return true
end
return ei(_ENV,ie,"|badly|poisoned","ic",1)
end,function(_ENV)
v(u,"|does|nothing")
end,function(_ENV,uj)
if dt(a,f)>0 and f.tb.ec==0 then
v(th,"|is|"..pn[uj],function()
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
return ie(_ENV,m,"|becomes|confused","sv",to"4"+1)
end,function(_ENV)
local hy=d.tf\4
if hy>=d.em or d.oa>0 then
return true
end
nh(_ENV,hy)
v(u,"|created|substitute",function()
d.oa=hy
end)
end,function(_ENV)
d.tb.ec=6
v(u,"|is|sleeping")
ry(_ENV,u,d.tf)
d.ic=0
end,function(_ENV)
if nm[d.rd].og%2==1 then
return ad(_ENV,(d.ca-d.em)*2)
else
return true
end
end,function(_ENV,si,ho)
if si>0 then
v(u,"|begin|hit #"..si,function()
_ENV.f=th.c
if h(_ENV)then
v(u,"|failed|hit #"..si)
end
sd(_ENV,si-1,ho)
end)
else
ho()
end
end,function(_ENV,si)
sd(_ENV,2+to"4",y)
end,function(_ENV)
sd(_ENV,2,function()
if _rnd"100"<20 then
en(_ENV,5)
end
end)
end,function(_ENV)
ni(d,-1,ej(a.s,a.ev))
h(_ENV)
end,function(_ENV)
ni(d,to"2"+1,ej(a.s,a.ev))
h(_ENV)
if d.ab==0 then
ek(_ENV,sh,"sv")
end
end,function(_ENV)
if not d.eb then
ni(d,to"4"+1,ej(a.s,a.ev))
v(u,"|"..a.o.."|begins")
end
h(_ENV)
if d.ab==0 then
v(u,"|"..a.o.."|ended")
end
end,function(_ENV,tw)
if d.eb then
h(_ENV)
else
v(u,"|started|"..tw,function()
ni(d,1,ej(a.s,a.ev))
end)
end
end,function(_ENV)
if d.eb then
v(u,"|recharging|energy")
else
h(_ENV)
local eu=ej(a.s,a.ev)
eu.ez=0
ni(d,1,eu)
end
end,function(_ENV)
if d.eb then
h(_ENV)
else
ni(d,1,a)
v(u,"|preparing|attack")
a.ip+=1
end
end,function(_ENV)
local tx=he(d,f,a)
if ad(_ENV,tx)then
return true
else
nh(_ENV,_max(1,tx\4))
end
end,function(_ENV,gd,al,...)
if ad(_ENV,he(d,f,a))then
return true
else
if _rnd"100"<(gd or 0)then
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
local tx=he(d,f,a)
if ad(_ENV,tx)then
return true
else
ry(_ENV,u,_max(tx\2,1))
end
end,function(_ENV)
if d.ts>=f.ts then
return ad(_ENV,f.em)
else
return true
end
end,function(_ENV)
return ad(_ENV,1+to"75")
end,function(_ENV)
return ad(_ENV,_max(f.em\2,1))
end,function(_ENV,tx)
if tx>0 and dt(a,f)>0 then
v(th,rx(-tx,"|hitpoints"),function()
if f.oa>0 then
f.oa=_max(f.oa-tx,0)
else
f.tb.em=_max(f.tb.em-tx,0)
end
end,f.oa>0 and "substitute")
else
return true
end
end,function(_ENV,tx)
v(u,rx(-tx,"|hitpoints"),function()
d.tb.em=_max(d.tb.em-tx,0)
end)
end,function(kp)
return _ceil(kp+.5*93)+5
end,function()
return b([[tj,%au,mt,50,tn,0,ef,0,ae,0,ts,0,tf,0,em,0,hu,0,ez,1,ol,1,ph,0,pd,0,pl,0,dx,0,pr,0,s,-1,ii,-1,o, ,ot,0,op,0,ok,#,ov,#,se,#,ti,%vp,z,@]],rz())
end,function()
local ib=_peek2"8"
td[-1]=fd()
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
local ii=s-tc[1]
local r=fd()
ex(r,[[s,@,ii,@,o,@,ot,@,op,@,ph,@,pd,@,pl,@,dx,@,pr,@]],s,
ii,
pa[s+1],
tc[2],
tc[3],
tc[4],
tc[5],
tc[6],
tc[7],
tc[8]
)
local ls=r.ok
for t=9,#tc do
local q=tc[t]
if q==253 then
ls=r.ov
elseif q==252 then
ls=r.se
else
_add(ls,q)
end
end
if ii<s then
_foreach(td[ii].ok,function(a)_add(r.ok,a)end)
_foreach(td[ii].ov,function(a)_add(r.ov,a)end)
_foreach(td[ii].se,function(a)_add(r.se,a)end)
end
local cm,cu={},{}
_foreach(r.ov,function(a)cm[a]=true end)
for t=1,54 do
if cm[t]then _add(cu,t)end
end
r.ov=cu
do local _ENV=r
ex(_ENV,[[tn,@,ef,@,ae,@,ts,@,tf,@,em,~tf,mt,50]],sp(pd),
sp(pl),
sp(pr),
sp(dx),
sp(ph)+5+50
)
hu=tn+ef+ae+ts+tf
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
return _setmetatable(b([[wi,%au,rd,0,ez,1,ol,1,ab,0,dp,0,sv,0,oa,0,ic,0,tb,@,z,@,ca,@;nv;ae,0,tn,0,ef,0,ts,0,ez,0,ol,0]],ed,av,ed.em),{__index=ed})
end,function(sz)
_foreach(di(sz.l),function(r)
_poke(0x5e5a+r.s,1)
end)
end,function(l)
local oh={}
_foreach(l,function(r)
if r.s>-1 and r.ec==1 then
_add(oh,r)
end
end)
return oh
end,function(l,ka)
local oh={}
_foreach(l,function(r)
if r.s>(ka and 0 or-1)and r.ec ~=1 then
_add(oh,r)
end
end)
return oh
end,function(l)
return da(l)[1]
end,function(i)
local l=i:io"ew"
l[i:ee"an"+1]=rj(-1,rz())
oj(i:ee"ew",l)
i:tr()
end,function(l,lm,s)
l[lm]=rj(s,ve(s))
return l
end,function(hm)
local rl=pt[hm]
local l=b[[]]
for t=1,6 do
local sa,z,mc=rl+(t-1)*5,{},false
for t=1,4 do
z[t]=ej(_peek(sa+t),t)
if z[t].s>0 then
mc=true
else
z[t]=ej(-1)
end
end
l[t]=rj(mc and@sa or-1,z)
end
return l
end)
ex(_g,[[oj,@,yl,@,ve,@,ej,@,rz,@,dh,@,wf,@,du,@,dr,@,lk,@,no,@,vu,@,xe,@,ww,@,fs,@,rf,@,ds,@,su,@,dc,@,fn,@,fc,@,yt,@,yi,@,na,@,vc,@,wm,@,vd,@,bj,@,fp,@,vq,@,wp,@,ff,@,vb,@,vh,@,wv,@,yf,@,ym,@,mq,@,wy,@,wj,@,wg,@,ya,@,yo,@,sr,@,xt,@,vm,@,wx,@,ye,@,wu,@,vj,@,vx,@,vy,@,vl,@,vi,@,va,@,vr,@,vs,@,vn,@,bm,@,fi,@,bf,@,bu,@,yc,@,vk,@,fy,@,vv,@,mp,@,tp,@,ac,@,mj,@,my,@,nt,@,vf,@,nn,@,vg,@,fu,@,dl,@,vp,@,wd,@,wq,@,bx,@,bk,@,bz,@,fr,@,wk,@,io,@,sf,@,lj,@,lz,@,ni,@,ys,@,dd,@,yr,@,rg,@,nl,@,oz,@,sg,@,bq,@,wc,@,yd,@]],function(hm,l)
local rl=pt[hm]
_memset(rl,0,30)
for t=1,6 do
local sa,r=rl+(t-1)*5,l[t]
_poke(sa,_max(0,r.s))
for t=1,4 do
_poke(sa+t,r.z[t].s>0 and r.z[t].s or 0)
end
end
end,function()
for t=-1,#dv do
local a,ta={},{}
for so=1,#dv[t]do
_add(so<=6 and a or ta,dv[t][so])
end
nm[t]=b([[al,@,s,@,o,@,og,@,ip,@,ux,~ip,dw,@,ez,@,iy,@]],function(is)
return a[6](is,_unpack(ta))
end,t,_unpack(a))
end
end,function(s)
local r,nz=td[s],rz()
for t=1,_min(4,#r.ok)do
nz[t]=ej(r.ok[t],t)
end
return nz
end,function(ws,ev)
return _setmetatable(b([[ev,@]],ev or 0),{__index=nm[ws]})
end,function()
local nz={}
for t=1,4 do _add(nz,ej(-1))end
return nz
end,function(i)
fi(i)
my("team #"..i:ee"ew"+1,20,27,1)
end,function(_ENV)
local fz,iw,ig=ir.c,tu.c,aa.c
local gp,gm=iw==fz,ig==fz
local us,un=gp and 6 or 1,gm and 6 or 1
ep(_rectfill,[[;,0,0,39,6,5;;,0,33,39,39,5]])
ep(_rectfill,[[;,-1,33,@,41,@;;,40,-2,@,6,@]],-1+_max(_ceil(iw.em/iw.tf*40),0),us,
40-_max(_ceil(ig.em/ig.tf*40),0),un)
ep(_rectfill,[[;,0,6,24,6,13;;,0,5,23,5,13;;,15,33,39,33,13;;,16,34,39,34,13]])
ep(nt,[[;,@,2,34,13,-1;;,@,41,29,@,1;;,@,40,1,13,1;;,@,1,5,@,-1]],iw.em,pi[iw.ec],us,ig.em,pi[ig.ec],un)
iw:ti(10,23,5,1)
ig:ti(30,17,5,-1)
end,function(i)vg(td[i:ee"tj"])end,function(i)oq("spot #"..(i:ee"an"+1))end,function(i)oq("move #"..(i:ee"ag"+1))end,function(i)oq(i.of)end,function(i)oq"match over" end,function(kg)end,function(i)
local a=i:x"ny"
oq(a and a.gn)
end,function()
_rectfill(0,0,46,13,13)
_pal(7,1)
local hc=0
for t,k in _ipairs(_split"6,5,5,6,6,5,6")do
_sspr(6*8+hc,6*8,k,8,hc+3,3.5+_cos((_t()+t)/4))
hc+=k
end
_pal()
end,function(i)oq(i.ir.m.o)end,function(i)
fu(i:sf())
end,function(i)
local a=i:x(i.up).a
if a.s>=0 then
ax(sk[a.og].o.."|"..a.ip.."/"..a.ux.."|"..(a.dw>=0 and a.dw or "??").."P "..(a.ez>=0 and a.ez or "??").."A")
else
ax"????|?/?|?P ?A"
end
end,function(i)
fu(i:x"tj".r)
end,function(i)ax(i:x"ix".tw)end,function(_ENV)
if s>-1 then
ax(o.."|"..em.."/"..tf.."|"..pn[ec])
else
ax"?????????|???/???|"
end
end,function(_ENV)fc(_ENV:x"hq".r)end,function(_ENV)fc(p.c)end,function(i)
local ou,uo=0,0
for t=1,6 do
local s=i:x().l[t]
if s then
ou+=1
uo+=td[s].hu
end
end
ax(i:x().o.."|pkmn "..ou.."/6|pow "..uo)
end,function(i)
ax(i.p.o.."|is the|winner")
end,function(i)
ax(i.ir.o..i.ir.iv)
end,function(_ENV)
local dz,uz=p,nl(_ENV,p)
dz:pu(uz)
e:tt{}
e.nu=function(i)
i:rn"hf"
end
for m in _all{dz,uz}do
ex(e,[[k,0;;r,@;;lf,%au;;o,@,te,5;;o,@;;o,@]],m.c.tb,m.o,(#da(m.l,true)).." live",(#di(m.l)).." dead")
end
end,function(_ENV)
local ou=0
for t=0,151 do ou+=td[t]:nn()and 1 or 0 end
e:tt(
b([[;o,browse,ey,tj,el,%ai,tw,@;;o,edit,ey,ew,el,%ai,tw,edit|stored|teams;;o,league,ey,cl,el,%ai,tw,@;;o,player,ey,cd,el,%ai,tw,player|custom|battles;;o,?????,ey,cc,el,%ai,tw,?????|beat|league,eq,%au;;o,credits,ey,fq,el,%ai,tw,credits|amorg|games]],"browse|"..ou.."/151|pokemon","league|"..(@0x5efd).."/40|trainers")
)
if@0x5efd>=40 then
ex(e[5],[[eq,%am,o,horde,tw,@]],"horde|"..(@0x5efe).."/151|hi-score")
end
end,function(_ENV,ge)
local nb={}
for t=0,151 do
_add(nb,t)
end
e:tt(
nb,
function(s)
local r=td[s]
return{
el=ge,
eq=not r:nn(),
r=r
}
end
)
end,function(_ENV)
fp(_ENV,function(_ENV)
_ENV:aw"ps"
end)
end,function(_ENV)
fp(_ENV,function(_ENV)
oj(_ENV:ee"ew",lx(_ENV:io"ew",_ENV:ee"an"+1,_ENV:ee"tj"))
_ENV:tr()
end)
end,function(_ENV)
wd(e,_ENV:x"tj".r)
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
return{o=az,te=te,lf=az==""}
end
)
e.k=0
end,function(_ENV)
e:tt(hh,function(sz,s)
return{
o=sz.o,
l=sz,
eq=s-1>@0x5efd,
el=function(i,x)
fg(i,x.l,x.o,y,function(m,th)
_poke(0x5efd,_mid(@0x5efd,s,#hh))
mb(th)
end,y)
end
}
end)
end,function(_ENV)
e:tt(b[[;o,moves,ey,ag,el,%ai;;o,switch,ey,hw,el,%ai;;o,delete,el,%wb]])
ny.e.eh=0
end,function(_ENV)
local ed=_ENV:sf()
local ou=0
for so=1,4 do
if ed.z[so].s>0 then ou+=1 end
end
e:tt(b([[;o,change,ey,ny,el,%ai;;o,switch,ey,cw,el,%ai;;o,delete,eq,@,el,%ym]],ou==1))
end,function(_ENV)
local ed,l=_ENV:sf()
ed.z[_ENV:ee"ag"+1]=ej(-1)
oj(_ENV:ee"ew",l)
_ENV:tr()
end,function(_ENV,sy,oy)
local ed,l=_ENV:sf()
e:tt(b[[,1,2,3,4]],function(t)
local a=ed.z[t]
return{
a=a,
o=a.o,
el=function(_ENV)oy(_ENV,t,ed,l)end,
eq=t==sy
}
end)
end,function(_ENV)
mq(_ENV,0,function(_ENV,t,ed)
_ENV:aw(ed.z[t].s>0 and "uy"or "ny")
end)
end,function(_ENV)
local sy=_ENV:ee"ag"+1
mq(_ENV,sy,function(_ENV,t,ed,l)
ed.z[t],ed.z[sy]=ed.z[sy],ed.z[t]
oj(_ENV:ee"ew",l)
_ENV:rn"ag"
end)
e.eh=ag.e.eh
end,function(_ENV)
local ed=_ENV:sf()
local r=td[ed.s]
local ug={}
ep(function(uw,gr)
for t=1,#uw do
local ln=uw[t]
_add(ug,{o=nm[ln].o,eq=ed:lq(ln),s=ln,tw=gr..t})
end
end,[[;,@,learn #;;,@,teach #;;,@,event #]],r.ok,r.ov,r.se)
e:tt(ug,function(eu)
return{
o=eu.o,
eq=eu.eq,
a=nm[eu.s],
gn=eu.tw,
el=function()
local l=_ENV:io"ew"
l[_ENV:ee"an"+1].z[_ENV:ee"ag"+1]=ej(eu.s)
oj(_ENV:ee"ew",l)
_ENV:rn"ag"
end
}
end)
end,function(_ENV)
local nk=fl(p.c)
if p.c.eb then
rg(p,p.c.eb)
_ENV:tr()_ENV:tr()
elseif #nk==0 then
rg(p,ej(0))
_ENV:tr()_ENV:tr()
end
e:tt(p.c.z,function(a)
return b([[eq,@,o,@,a,@,el,@]],
not nk[a],
a.o,
a,
function()
_ENV:tr()_ENV:tr()
rg(p,a)
end
)
end)
end,function(_ENV)
e:tt(b[[;o,fight,tw,fight|select|move,el,%ai,ey,ue;;o,switch,tw,switch|active|pokemon,el,%ai,ey,hq;;o,forfeit,tw,forfeit|pokemon|battle,el,%yn]])
end,function(_ENV)
e:tt(b[[,1,2,3]],function(t)
local l=sm(t-1)
local oh={}
local mn=true
for t=1,6 do
oh[t]=l[t].s
if not l[t]:mx()then
mn=false
end
end
return{
o="team #"..t,
l=oh,
el=function()_ENV:oy()end,
eq=sb and mn
}
end)
end,function(l,t)
return l[t]and l[t].s or-1
end,function(_ENV)
local l=_ENV:io"ew"
e:tt(b[[,1,2,3,4,5,6]],function(t)
return{
r=l[t],
el=function(_ENV)
if l[_ENV:ee"an"+1]:nn()then
_ENV:aw"ch"
else
_ENV:aw"ed"
end
end
}
end)
end,function(_ENV)
local l=_ENV:io"ew"
e:tt(b[[,1,2,3,4,5,6]],function(t)
return{
eq=t==_ENV:ee"an"+1,
el=function(_ENV)
local mh,mr=_ENV:ee"an"+1,_ENV:ee"hw"+1
l[mh],l[mr]=l[mr],l[mh]
oj(_ENV:ee"ew",l)
_ENV:rn"an"
end,
r=l[t]
}
end)
e.eh=an.e.eh
end,function(_ENV)
local l=_ENV:io"ew"
e:tt(b[[,1,2,3,4,5,6]],function(t)
local eq=p.l[t]:mx()or p.c.tb==p.l[t]or p.l[t].ec==1
return{
eq=eq,
el=function()
_ENV:tr()_ENV:tr()
lj(p,p.l[t])
end,
r=p.l[t]
}
end)
end,function(_ENV)
local tu,aa=tu,aa
if tu.ob==aa.ob then aa.ob+=_sgn(_rnd"2"-1)end
p=tu.ob>aa.ob and tu or aa
end,function(_ENV,lh)
local cb=true
for t=tj.e.eh+lh,75.5+75.5*lh,lh do
if td[t]:nn()then
tj.e.eh=t
cb=false
tp"154"
break
end
end
if cb then aj()end
ff(_ENV)
end,function(i)tp(i:ee"tj")end,function()tp(to"152")end,function(_ENV)tp(p.c.s)end,function(_ENV)
local l={}
for lm,s in _pairs(_split"133,7,35,1,25,4")do
lx(l,lm,s)
_poke(0x5e5a+s,1)
end
if@0x5efc==0 then
_poke(0x5efc,1)
oj(0,l)
end
tv=mw[[ee,%bf,x,%bu,aw,%bl,tr,%bc,rn,%bd,r,%y,ty,%y,tk,%y,er,%y,es,%y,oc,ix;fv;e,%am,of,error,kz,%y,ea,%y,uq,%aj,sj,%y,ty,%bm,up,%am,tk,%fi,er,%y,es,%y;ix;ea,~bj,er,~fs,es,~fn;tj;ea,%vq,er,%du,es,%dc;ps;ea,%ff,er,%du,es,%dc,uq,%vj,sj,%vx;an;ea,%vm,er,%dr,es,%ds,tk,%dh;hw;ea,%wx,er,%dr,es,%ds,tk,%dh;ed;ea,%wp,er,%du,es,%dc;ch;ea,%wv,er,%dr,es,%ds;uy;ea,%yf,er,%lk,es,%su,up,ag;ny;ea,%wg,er,%ww,es,%su;ag;ea,%wy,er,%lk,es,%su;cw;ea,%wj,er,%lk,es,%su;ew;of,player,ea,%sr,er,%no,es,%na,sb,%am,oy,%wk;cl;of,player,ea,%sr,er,%no,es,%na,sb,%au,oy,%wq;cd;of,player 1,ea,%sr,er,%no,es,%na,sb,%au,oy,%bx;cc;of,player,ea,%sr,er,%no,es,%na,sb,%au,oy,%bz;hp;of,player 2,ea,%sr,er,%no,es,%na,sb,%au,oy,%bk;hf;of,trainer,ea,%vh,er,%no,es,%na;ly;ea,%vd,er,%vu,es,%vc,sj,%vl;hz;ea,%yo,er,%rf,es,%yi;ue;ea,%ya,er,%rf,es,%su;hq;ea,%ye,er,%rf,es,%yt,tk,%dh;gf;tm,gu,ea,%mk,ty,%y,tk,%y,ur,tu;gu;tm,ci,ea,%mk,ty,%y,tk,%y,ur,aa;ci;tm,gf,ea,%wu,ty,%wc,tk,%wf,er,%rf,es,%wm,ir,%am;fq;ea,%vb,er,%fs,es,%fn,sj,%vy;]]
ep(function(ik,kh,...)
tv[ik].e=kh(...)
end,[[;,tj,~tl,~ht,4;;,ps,~rq,~tg;;,fq,~rq,~tg;;,ly,~rq,~tg;;,an,~tl,~ht,3;;,hw,~tl,~ht,3;;,ix,~tl,~tg;;,ch,~tl,~tg;;,uy,~tl,~tg;;,ny,~tl,~tg;;,ag,~tl,~tg;;,cw,~tl,~tg;;,ew,~tl,~tg;;,hf,~tl,~tg;;,hp,~tl,~tg]])
ex(tv,[[hg,@,km,@;ix;e;nu,%aj;hz;e;nu,%aj;cc;e,~hg;cd;e,~hg;cl;e,~hg;ed;e,~km;]],tv.ew.e,tv.tj.e)
tp"152"
_menuitem(1,"close picodex",function()
_menuitem(1)
_menuitem(2)
_ENV:ak"db"
end)
_menuitem(2,"swap 🅾️/❎",function()
_poke(0x5eff,@0x5eff==0 and 1 or 0)
end)
end,function(gs)
gs.tv:ey()
end,function()iz.tv:tk()end,function()iz.tv:er()end,function()iz.tv:es()end,function(_ENV)e.ty(_ENV)end,function(_ENV)e.tk(_ENV)end,function(_ENV,ik)
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
if not fy()and hl then
hl=false
_ENV:ak()
_menuitem(1)
elseif fy()then
hl=true
_menuitem(1)
end
end,0,function(s)
_g.mp=_max(0,0+s-152)
_sfx(54+s\16,0,s%16*2,2)
end,function(_ENV)
_cls"0"
rm(0,128+_sin(_ENV:mm"uf"/4)*128,function()
ep(nt,[[;,aMORG gAMES,64,-68,7,0;;,pRESENTS,64,-61,7,0;;,a pICO-8 pOKEDEX sIM,64,15,7,0]])
ep(wl,[[;,102,64,11,5,1]])
local cr,
dk,
os=
tv and tv.ix.e.eh,
tv and tv.cv-1,
ao=="rs"and 1
or ao=="ih"and-1
or(ao=="lo"and-1 or 1)*_cos(_ENV:mm(ao)/2)
rm(30-(os+1)*15+(oc=="cx"and to"3"-1 or 0),27,function()
ep(_rectfill,[[;,14,18,@,87,5]],63+_max(0,os*54))
if ox==0 then
ep(_rectfill,[[;,14,18,117,87,13]])
ep(vf,[[;,14,21,40,40,@;;,71,18,46,13,@;;,71,67,46,21,@]],tk,er,es)
end
ep(_map,[[;,24,0,2,1,8,3;;,8,0,2,9,8,11]])
ep(function(ah,gy,gg,wh,g,w)
return _spr((ox<=ah)and(mp==ah and _stat"46">=0 and wh or gg)or gy,g,w)
end,[[;,0,135,133,134,6,3;;,1,132,128,131,12,3;;,2,132,129,131,17,3;;,3,132,130,131,22,3]])
ep(function(hd,go,ga,g,w)
_spr(_btn(hd)and go or ga,g,w)
end,[[;,0,186,154,10,77;;,1,188,156,26,77;;,2,171,139,18,73;;,3,187,155,18,81;;,4,170,138,42,77;;,5,172,140,50,77]])
if os<=0 then
mj(0,2+64*(1-_abs(os)),_abs(os))
if os==-1 and hl then _spr(123,6,49)end
else
mj(16,62,os)
if os==1 then
if cr then _spr(153,70+cr*8,41)end
if dk and dk>=0 then _spr(153,70+dk*8,49)end
end
end
end)
end)
end,function(kr,cg,tz)
tz*=64
for w=9,96 do
_tline(cg,w,cg+tz-1,w,kr,w/8-1.125,8/tz,0)
end
end,function(ap,g,w,nc)
local cp,cf="",""
for t=1,#ap do
local ma,cy=_sub(ap,t,t),t%2==0
cp..=cy and " "or ma
cf..=cy and ma or " "
end
nt(cp,g,w,nc,0)
nt(cf,g,w+1,nc,0)
end,function(ap,g,w,nc,pc)
ap=""..ap
if pc==0 then g-=#ap*2
elseif pc>0 then g-=#ap*4+1 end
_print(ap,g,w,nc)
end,function(nw,dq,id,rc,gt)
_clip(-%0x5f28+nw,-%0x5f2a+dq,id,rc)
rm(nw,dq,gt)
_clip()
end,function(_ENV)
if s>=0 then
return not tj or@(0x5e5a+s)>0
end
end,function(r)
oq("pkmn #"..r.s)
end,function(r)
if r:nn()then
ax(r.o.."|"..sk[r.ot].o.."|"..sk[r.op].o)
else
ax"?????????|????|??????"
end
end,function(s,g,w,tz,on)
tz=tz or 1
on=on or 1
local hj=s/8\1
local dy=s%8
if hj ~=mf then
mf=hj
_memcpy(0x0000,0x8000+0x400*hj,0x400)
end
local id,rc=16*tz,16*on
_sspr(dy*16,0,16,16,g-id/2,w-rc/2,id,rc)
end,function(_ENV,g,w,dy,il,ng)
local s=_ENV:nn()and s or-1
if s==25 and _ENV:lq(53)then s=152 end
if s==54 and _ENV:lq(143)then s=153 end
if oa and oa>0 then s=154 end
if not wi or ec ~=1 and not ms and not(ab ~=0 and eb.iy==sc)then
if s<0 then _spr(107,g-4,w-4)return end
il,ng=il or 1,ng or 1
local nj=_max(_abs(il),1)\ 1
ep(function(nc,pw,pg,pp,pf)
for eh=1,15 do _pal(eh,nc)end
for t=-nj,nj,nj*2 do
dl(s,g+(pw or t),w+(pg or t),il,ng)
dl(s,g+(pp or t),w+(pf or t),il,ng)
end
end,[[;,@,@,%am,@,%am;;,1,%am,0,0,%am]],dy,-nj,nj)
_pal()dl(s,g,w,il,ng)
end
end,function(e,r)
e:tt{}
ex(e,[[;r,@;;lf,%au;;o,lvl 50,te,5;;o,@]],r,(r.em or r.tf).."/"..r.tf)
_foreach(b[[;et,ae,o,spc;;et,tn,o,att;;et,ef,o,def;;et,ts,o,spd;;et,hu,o,tot]],function(nx)
if not nx.et then
_add(e,{o=nx.o,te=5})
elseif r[nx.et]then
_add(e,{o=nx.o.." "..r[nx.et]})
end
end)
ep(function(o,et)
if #td[r.s][et]>0 then
_add(e,{o=o,te=5})
_foreach(td[r.s][et],function(eu)
_add(e,{o=nm[eu].o})
end)
end
end,[[;,learn,ok;;,teach,ov;;,event,se]])
end,function(i)i:aw"hf" end,function(i)i:aw"hp" end,function(_ENV)
fw(_ENV,
{sm(_ENV:ee"ew"),"player 1",false,y,y},
{sm(_ENV:ee"hp"),"player 2",false,y,y}
)
end,function(_ENV)
local uu={}
for t=1,152 do _add(uu,t%152)end
fg(_ENV,uu,"horde",y,
function(kg,th)fr(th)end,
fr
)
end,function(md)
mb(md)
_poke(0x5efe,_mid(@0x5efe,#di(md.l),255))
end,function(i)
i:aw"an"
end,function(i,ee)
return sm(i:ee(ee))
end,function(i)
local l=sm(i:ee"ew")
return l[i:ee"an"+1],l
end,function(m,r)
sg(m,m,"|comes|back",function(ta)
ta.u.c=rp(r)
ta.u.c.ms=true
sg(m,m,"|comes|out",function(_ENV)
d.ms=false
end)
end)
m.ob=3000
end,function(u,a)
sg(u,u,"|uses|"..a.o,function(ta)
ta.a=a
local _ENV=ta
if a.s>0 then
a.ip-=1
end
if a.s==47 or a.s==36 then
nh(_ENV,d.em)
end
if vw(d,f,a)then
v(u,"|missed|"..a.o)
if a.s==145 or a.s==73 then
nh(_ENV,1)
end
else
if a.ez ~=0 then
f.rd=a.s
end
if a.al(_ENV)then
v(u,"|failed|"..a.o)
end
end
end)
end,function(_ENV,oe,gx)
if not eb and ab==0 then
ab,eb=oe,gx
end
end,function(u,a)
sg(u,u,false,function(ta)
ta.a=a
local _ENV=ta
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
if f.eb and f.eb.iy==nr then
v(u,"|is|trapped")
return
end
if d.nd==a.ev then
v(u,"|is|disabled")
return
end
if d.sv>0 and to"2"==0 then
v(u,"|confuse|damage")
nh(_ENV,he(d,f,ej(-1)))
return
end
if d.lw then
v(u,"|is|flinching")
return
end
lz(u,a)
end)
end,function(c,et,ho)
if c[et]>0 then
c[et]-=1
if c[et]==0 then
ho()
end
end
end,function(u)
return oz(u,false,function(_ENV)
if d.ec==6 or d.ec==3 then
d.ab=0
end
if d.ab==0 then
d.eb=nil
end
local hv=_max(d.tf\16,1)
local lu=function(pb)
v(u,pb.."|damage")
nh(_ENV,hv)
end
if d.ec==5 then
if d.ic>0 then
hv*=d.ic
d.ic+=1
end
lu"|poison"
end
if d.ec==2 then lu"|burn" end
if d.cj then
lu"|seed"
if f.em<f.tf then
v(th,"|seed|leeching")
ry(_ENV,th,hv)
end
end
d:dd("sv",function()
v(u,"|confusion|ended")
end)
d:dd("dp",function()
v(u,"|"..d.z[d.nd].o.."|enabled")
d.nd=0
end)
end)
end,function(m,a)
m.np={}
local le=1000
ys(m,a)
if a.s==120 then le=2000 end
if a.s==18 or a.s==4 or a.s==89 or a.s==30 then
le=0000
end
m.ob=_min(3000,le+m.c:ns"ts")
end,function(i,m)
return m==i.tu and i.aa or i.tu
end,function(la,iv,ll,o)
return{m=la,o=o or la.c.o,c=la.c,iv=iv,ll=ll or y}
end,function(p,...)
_add(p.np,oz(...))
end,function(_ENV)
d.tb.ec=1
u:kn()
end,function(i)
if sn then aj()end
if ne then tp"154" end
if ne or not i.ir then
while true do
for ay in _all{i.tu,i.aa}do
if not rv(ay.l)then
i.p=nl(i,ay)
i:ak"ly"
return
end
end
local aq=yd(i)
if aq then
local dj=aq.c==i.tu.c and i.tu or i.aa
local is=b([[a,@,u,@,th,@,v,@]],a,dj,nl(i,dj),function(...)
sg(dj,...)
end)
is.d=is.u.c
is.f=is.th.c
aq.ll(is)
if aq.iv then
i.ir=aq
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
return oz(ay,"|is|fainted",bq)
elseif ay ~=i.p then
ay.c=rp(rv(ay.l))
return oz(ay,"|comes|out")
end
end
end
for at in _all{i.p,nl(i,i.p)}do
local gb=nl(i,at)
while #at.np>0 do
local aq=_deli(at.np,1)
if aq.c.ec ~=1 and(aq.c==at.c or aq.c==gb.c)then
return aq
end
end
if at.c.em<=0 and at.c.ec==1 then
at.c=rp(rv(at.l))
return oz(at,"|comes|out")
end
if not at.co then
at.co=true
return yr(at)
end
end
end)
ex(_g,[[lq,@,mx,@,rk,@,fl,@,wz,@,vt,@,vw,@,fh,@,dt,@,he,@,mk,@,yn,@,fw,@,fg,@,dn,@,lv,@,lb,@,mv,@,vo,@]],function(_ENV,gj)
for eu in _all(z)do
if eu.s==gj then
return true
end
end
end,function(_ENV)
return #rk(_ENV,true)==0
end,function(r,wa)
local av={}
_foreach(r.z,function(eu)
if eu.s>0 and(wa or eu.ip>0 and r.nd ~=eu.ev)then
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
local nk=fl(c)
return nk[to(#nk)+1]or ej(0)
end,function(_ENV,st)
local df=1024
if st==-1 then return 1 end
if st==107 or st==164 or st==57 or st==157 then df*=.3 end
if mg then df*=.3 end
return _rnd"1"<_min(.99,(dx+76)/df)and 2 or 1
end,function(af,ar,a)
if a.ez<=0 then return false end
if(a.iy==sl or a.iy==sc)and not af.eb then return false end
if ar.eb and ar.eb.iy==sc then return true end
if af.eb and af.eb.iy==nr then return false end
return _rnd(ar.ol)>a.ez/100*af:ns"ez"or to"256"==0 and to"256"==0
end,function(gq,gl)
return sk[gq][gl]or 1
end,function(a,ar)
return fh(a.og,ar.ot)*fh(a.og,ar.op)
end,function(af,ar,a)
local tn,ef=af:ns"ae",ar:ns"ae"
if a.og%2==1 then
tn,ef=af:ns"tn",ar:ns"ef"
if ar.cz then
ef*=2
end
elseif ar.cq then
ef*=2
end
local kf=_mid(
3,997,
(2*af.mt*vt(af,a.s)/5+2)/50
*a.dw
*_mid(10,.2,tn/ef)
)+2
return kf
*((a.og==af.ot or a.og==af.op)and 1.5 or 1)
*dt(a,ar)
*(_rnd".15"+.85)\1
end,function(_ENV)
p=_ENV[ur]
do local _ENV=p.c
ca=em
lw=false
end
p.co=false
if p.wo then
rg(p,wz(p.c))
_ENV:ak()
elseif #p.np>0 then
_ENV:ak()
else
hz.e,
ue.e,
hq.e,
ir,
oi[#oi]=p.uk,
p.we,
p.gz,
oz(p,""),
oc
_ENV:aw"hz"
end
end,function(_ENV)
_ENV:tr()
p=_ENV:nl(p)
_ENV:ak"ly"
end,function(_ENV,fj,fx)
fj.et,fx.et="tu","aa"
for dg in _all{fj,fx}do
_ENV[dg.et]=b([[np,#,ob,1,uk,@,we,@,gz,@,l,@,o,@,wo,@,kn,@,pu,@]],tl(tg),
tl(tg),
tl(ht,3),
_unpack(dg))
local _ENV=_ENV[dg.et]
uk.nu=aj
c=rp(rv(l))
_add(np,oz(_ENV,"|comes|out"))
end
p=tu
_ENV:aw"ci"
end,function(_ENV,ui,o,ks,gh,kl)
local pe={}
for t=1,#ui do
lx(pe,t,ui[t])
end
fw(_ENV,
{_ENV:io"ew","player",false,y,gh},
{pe,o,true,ks,kl}
)
end,function(ij)
mv(_peek2(ij*2),
function(...)return lv(0x8000+ij*0x2000,...)end,
function(...)return lb(0x8000+ij*0x2000,...)end)
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
function mu(nf)
if hs<8 then
hs+=8
hr+=@ck>>hs
ck+=1
end
hr<<=nf
local q=hr&0xffff
hr^^=q
hs-=nf
return q
end
function iq(n)
local nf=0
repeat
nf+=1
local ce=mu(nf)
n+=ce
until ce<(1<<nf)-1
return n
end
local id,wr,ko,dm,ua,g,w,hk,lt=iq"1",iq"0",iq"1",{},{},0,0,0
for t=1,iq"1" do _add(dm,mu(ko))end
for w=0,wr do
for g=0,id-1 do
hk-=1
if(hk<1)then
hk,lt=iq"1",not lt
end
local tq=w>0 and lv(g,w-1)or 0
local ah=ua[tq]or{_unpack(dm)}
ua[tq]=ah
local k=ah[lt and 1 or iq"2"]
ct(ah,k)
ct(dm,k)
lb(g,w,k)
end
end
end,function(ey)
tp(ey.ri)
ey:ro()
end)
pa[0]=""
_g.dv=b[[-1;,none,17,0,40,0,%h;0;,struggle,17,0,50,100,%rw;;,megapnch,1,20,80,85,%h;;,razrwind,1,10,80,75,%sl;;,sworddnc,1,30,0,0,%ek,%eo,tn,2;;,whrlwind,1,20,0,100,%fa;;,megakick,1,5,120,75,%h;;,toxic,5,10,0,85,%yg;;,horndril,1,5,-1,30,%de;;,bodyslam,1,15,85,100,%h,30,%en,4;;,takedown,1,20,90,85,%rw;;,doubedge,1,15,100,100,%rw;;,bublbeam,4,20,65,100,%h,10,%ei,%eo,ts,-1;;,watergun,4,25,40,100,%h;;,icebeam,10,10,95,100,%h,10,%en,3;;,blizzard,10,5,120,90,%h,10,%en,3;;,hyprbeam,1,5,150,90,%bo;;,payday,1,20,40,100,%h;;,submsion,3,20,80,80,%rw;;,counter,3,20,-1,100,%br;;,seistoss,3,20,-1,100,%ad,50;;,rage,1,20,20,100,%yx;;,megdrain,8,10,40,100,%rb;;,solrbeam,8,10,120,100,%sl;;,drgnrage,14,10,-1,100,%ad,40;;,thndrblt,6,15,95,100,%h,10,%en,4;;,thunder,6,10,120,70,%h,10,%en,4;;,earthqke,7,10,100,100,%h;;,fissure,7,5,-1,30,%de;;,dig,7,10,100,100,%sc,digging;;,psychic,12,10,90,100,%h,30,%ei,%eo,ae,-1;;,teleport,12,20,0,0,%yw;;,mimic,1,10,0,100,%be;;,doubteam,1,15,0,0,%ek,%eo,ol,1;;,reflect,12,20,0,0,%ek,%ie,|raises|defense,cz;;,bide,1,10,-1,100,%ba;;,metrnome,1,10,0,0,%bt;;,selfdstr,1,5,260,100,%h;;,eggbomb,1,10,100,75,%h;;,fireblst,2,5,120,85,%h,30,%en,2;;,swift,1,20,60,-1,%h;;,skulbash,1,15,100,100,%sl;;,softboil,1,10,0,0,%fo;;,dreameat,12,15,100,100,%bn;;,skyattck,9,5,140,90,%sl;;,rest,12,10,0,0,%yk;;,thndrwav,6,20,0,100,%en,4;;,psywave,12,15,-1,80,%yj;;,explsion,1,5,340,100,%h;;,rockslid,13,10,75,90,%h;;,triattck,1,10,80,100,%h;;,substute,1,10,0,0,%yb;;,cut,1,30,50,95,%h;;,fly,9,15,70,95,%sc,flying;;,surf,4,15,95,100,%h;;,strength,1,15,80,100,%h;;,flash,1,20,0,70,%ei,%eo,ez,-1;;,pound,1,35,40,100,%h;;,karatchp,3,25,55,100,%h;;,doubslap,1,10,15,85,%ia;;,comtpnch,1,15,18,85,%ia;;,firepnch,2,15,75,100,%h,10,%en,2;;,icepnch,10,15,75,100,%h,10,%en,3;;,thndpnch,6,15,75,100,%h,10,%en,4;;,scratch,1,35,40,100,%h;;,vicegrip,1,30,55,100,%h;;,guilotin,1,5,-1,30,%de;;,gust,9,35,40,100,%h;;,wingatck,9,35,35,100,%h;;,bind,1,20,15,75,%nr;;,slam,1,20,80,75,%h;;,vinewhip,8,10,35,100,%h;;,stomp,1,20,65,100,%h,30,%ei,%it;;,doubkick,3,30,30,100,%sd,2,%y;;,jumpkick,3,20,70,95,%h;;,rllngkck,3,15,60,85,%h,30,%ei,%it;;,sandatck,7,15,0,100,%ei,%eo,ez,-1;;,headbutt,1,15,70,100,%h,30,%ei,%it;;,hornatck,1,25,65,100,%h;;,furyatck,1,20,15,85,%ia;;,tackle,1,35,35,95,%h;;,wrap,1,20,15,85,%nr;;,thrash,1,20,90,100,%ft;;,tailwhip,1,30,0,100,%ei,%eo,ef,-1;;,psnsting,5,35,15,100,%h,20,%en,5;;,twineedl,11,20,25,100,%yq;;,pinmisil,11,20,14,85,%ia;;,leer,1,30,0,100,%ei,%eo,ef,-1;;,bite,1,25,60,100,%h,10,%ei,%it;;,growl,1,40,0,100,%ei,%eo,tn,-1;;,roar,1,20,0,100,%fa;;,sing,1,15,0,55,%en,6;;,sprsonic,1,20,0,55,%ei,%sh;;,sonicbom,1,20,-1,90,%ad,20;;,disable,1,20,0,55,%bs;;,acid,5,30,40,100,%h,10,%ei,%eo,ef,-1;;,ember,2,25,40,100,%h,10,%en,2;;,flamthwr,2,15,95,100,%h,10,%en,2;;,mist,10,30,0,0,%ek,%ie,|stat lower|immunity,ub;;,hydropmp,4,5,120,80,%h;;,psybeam,12,20,65,100,%h,10,%ei,%sh;;,aurorabm,10,20,65,100,%h,10,%ei,%eo,tn,-1;;,peck,9,35,35,100,%h;;,drillpck,9,20,80,100,%h;;,lowkick,3,20,50,90,%h,30,%ei,%it;;,absorb,8,20,20,100,%rb;;,leechsed,8,10,0,90,%ei,%ie,|is now|seeded,cj;;,growth,1,40,0,0,%ek,%eo,ae,1;;,razrleaf,8,25,55,95,%h;;,psnpowdr,5,35,0,75,%en,5;;,stunspor,8,30,0,75,%en,4;;,slppowdr,8,15,0,75,%en,6;;,petldanc,8,20,70,100,%ft;;,strngsht,11,40,0,95,%ei,%eo,ts,-1;;,firespin,2,15,15,70,%nr;;,thndshck,6,30,40,100,%h,10,%en,4;;,rockthrw,13,15,50,65,%h;;,cnfusion,12,25,50,100,%h,10,%ei,%sh;;,hypnosis,12,20,0,60,%en,6;;,meditate,12,40,0,0,%ek,%eo,tn,1;;,agility,12,30,0,0,%ek,%eo,ts,2;;,quickatk,1,30,40,100,%h;;,ngtshade,15,15,-1,100,%ad,50;;,screech,1,10,0,85,%ei,%eo,ef,-2;;,recover,1,20,0,0,%fo;;,harden,1,30,0,0,%ek,%eo,ef,1;;,minimize,1,20,0,0,%ek,%eo,ol,1;;,smokscrn,1,20,0,100,%ei,%eo,ez,-1;;,cnfusray,15,10,0,100,%ei,%sh;;,withdraw,4,40,0,0,%ek,%eo,ef,1;;,dfnscurl,1,40,0,0,%ek,%eo,ef,1;;,barrier,12,30,0,0,%ek,%eo,ef,2;;,lghtscrn,12,30,0,0,%ek,%ie,|raises|spcdefense,cq;;,haze,10,30,0,-1,%bi;;,fcsenrgy,1,30,0,0,%ek,%ie,|raises|crit ratio,mg;;,mirrmove,9,20,-1,0,%yz;;,lick,15,30,20,100,%h,30,%en,4;;,smog,5,20,20,100,%h,30,%en,5;;,sludge,5,20,65,100,%h,30,%en,5;;,boneclub,7,20,65,85,%h,10,%ei,%it;;,watrfall,4,15,80,100,%h;;,clamp,4,10,35,75,%nr;;,spikcann,1,15,20,100,%ia;;,constrct,1,35,10,100,%h,10,%ei,%eo,ts,-1;;,amnesia,12,20,0,0,%ek,%eo,ae,2;;,kinesis,12,15,0,80,%ei,%eo,ez,-1;;,hijmpkck,3,20,85,90,%h;;,glare,1,30,0,75,%en,4;;,poisngas,5,40,0,55,%en,5;;,barrage,1,20,15,85,%ia;;,leechlif,11,15,20,100,%rb;;,lovekiss,1,10,0,75,%en,6;;,tranform,1,10,0,0,%yp;;,bubble,4,30,20,100,%h,10,%ei,%eo,ts,-1;;,dizypnch,1,10,70,100,%h;;,spore,8,15,0,100,%en,6;;,splash,1,40,0,0,%yv;;,acidarmr,5,40,0,0,%ek,%eo,ef,2;;,crabhamr,4,10,90,85,%h;;,furyswps,1,15,10,80,%ia;;,bonerang,7,10,50,90,%sd,2,%y;;,hyprfang,1,15,80,90,%h,10,%ei,%it;;,sharpen,1,30,0,0,%ek,%eo,tn,1;;,convrson,1,30,0,0,%bh;;,suprfang,1,10,-1,90,%yy;;,slash,1,20,70,100,%h]]
po=b[[;j,13,ss,1,nq,5;;j,6,ss,13,nq,13;;j,5,ss,1,nq,5;;j,6,ss,5,nq,5;;j,1,ss,13,nq,5]]
pt=b[[0,0x5e00,1,0x5e1e,2,0x5e3c]]
mf=16
function _init()
local _ENV=_g
_memset(0x8000,0,0x7fff)
iz=mw[[oc,pm;ea,%vo,ox,4;fv;ao,ih,ox,4,ri,-1,hl,%am,ro,%y,ty,%y,ti,%y,tk,%y,er,%y,es,%y,tv,;pm;tm,uf,as,.5,ti,%ac;uf;tm,ih,as,.5,ti,%ac,ro,%yc;cx;ao,ih,tm,ih,as,.5,ti,%ac;ih;ao,ih,tm,lo,ro,%vk,ti,%ac,ty,%vv;lo;ao,lo,tm,pq,as,.2,ti,%ac;pq;ao,rs,tm,pj,ox,3,as,.2,ri,155,ti,%ac;pj;ao,rs,tm,px,ox,2,as,.2,ri,154,ti,%ac;px;ao,rs,tm,i,ox,1,as,.2,ri,153,ti,%ac;i;ao,rs,tm,db,ox,0,ro,%vi,ti,%ac,ty,%va,tk,%vr,er,%vs,es,%vn;db;ao,db,tm,ih,as,.25,ti,%ac,ty,%y;]]
ac(iz)
_flip()
tp"158"
dn(0)
dn(1)
dn(2)
ep(_poke,[[;,0x5f5c,8;;,0x5f5d,2;;,0x5f56,0xe0]])
mv(_peek2(3*2),_mget,_mset)
yl()
yh()
local cs=_peek2"0xa"
for t,k in _pairs(hh)do
local nb={o=k}
for so=1,6 do
_add(nb,_peek(cs))
cs+=1
end
hh[t]=nb
end
_memcpy(0x0000,0xc000,0x2000)
end
function _update60()
local _ENV=_g
sn,ne=_btnp"4",_btnp"5"
lg,lp=fm(_btnp,0,1),fm(_btnp,2,3)
if@0x5eff==1 then
sn,ne=ne,sn
end
iz:ey()
end
function _draw()
local _ENV=_g
iz:ti()
end