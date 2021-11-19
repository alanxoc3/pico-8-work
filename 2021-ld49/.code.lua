tc={}
function hf(fo,mk,...)
local mv,cj=unpack(split(mk,"|"))
local ce,tm,dz,cg,dg={...},unpack(td(mv))
_g[tm]=function(...)
local rq,ir,e={...},ox(ce),{}
if fo then
e=deli(rq,1)
end
for w=1,dz do
add(ir,rq[w]or false,w)
end
if not e[tm]then
foreach(cg,function(il)
if type(il)~="table"then
il={il}
end
e=_g[il[1]](e,unpack(il,2))
end)
ox(td(cj,unpack(ir)),e)
if not e[tm]then
tc[tm]=tc[tm]or{}
add(tc[tm],e)
end
e.tm,e[tm],e.pause=tm,true,e.pause or{}
foreach(dg,function(ad)
e.pause[ad]=true
end)
end
an(e,"pc",e)
return e
end
end
function d(...)hf(true,...)end
function _(...)hf(false,...)end
function oi(tm,ih,...)
for e in all(tc[tm])do
if not e.im[ih]then
an(e,ih,e,...)
end
end
end
function po(ok,ft)
sfx(ok,-1,ft*4,4)
end
function nn(ad,e,ee)
return ad(e)and ad(ee)and 0 or ad(e)and 0xffff or ad(ee)and 1 or 0
end
function _g.ak(e,ee)return e+ee end
function _g.pa(e,ee)return e-ee end
function fv(dk)return dk and 0xffff or 1 end
function lv(e,...)
local ll,nb=td(...),e or{}
for w=1,#ll do
nb=nb[ll[w]]
if not nb then
break
end
end
return nb
end
function nx(f,y)
local lk,rw=f>>31,y>>31
local sy,sa=(f+lk)^^lk,(y+rw)^^rw
if sy>sa then
return sy*0.9609+sa*0.3984
end
return sa*0.9609+sy*0.3984
end
function rm()return nn(btn,0,1)end
function rs()return nn(btn,2,3)end
function pi()return nn(btnp,0,1)end
function ph()return nn(btnp,2,3)end
function nq(ok)return ok==0 and 0 or sgn(ok)end
function rv(ok)return flr(ok+.5)end
function dq(cs)return(te"3"-1)*(cs or 1)end
function pe(db,od)
return t()%db<od
end
function te(a)
return flr(rnd(a))
end
function hc(nk)
return nk[te(#nk)+1]
end
function ox(me,is)
is=is or{}
for eh,g in pairs(me or{})do
if type(g)=="table"and not g.mq then
is[eh]=ox(g)
else
is[eh]=g
end
end
return is
end
function an(table,rg,...)
if table and table[rg]then
return table[rg](...)
end
end
function mz(sc,ej)
foreach(ej,function(t)sc(unpack(t))end)
end
function tp(sc,...)
mz(sc,td(...))
end
function rb(e)
e.iu=e.iu or 1
if not e.hn then
e.nw=function()
if e.sw then
e.it=(e.iu%#e)+1
else
e.it=e.iu+1
end
end
e.ae,e.eb,e.hn=0,nil,true
ox(e[e.iu]or{},e)
an(e,"w",e)
end
if an(e,"en",e)then e:nw()end
e.ae+=1/60
if e.eb and e.ae>=e.eb then
e:nw()
end
if e.it then
local sm=e.it
e.iu,e.hn,e.it=sm,nil,nil
an(e,"dt",e)
return sm>#e or sm<1
end
end
function fe(t)
if t then
for n=2,#t do
local w=n
while w>1 and t[w].o<t[w-1].o do
t[w],t[w-1]=t[w-1],t[w]
w=w-1
end
end
end
end
function lt(ts,dc,oo,sg,um,k,e,hj,iw)
local rj=function(ts,lh)
return flr(ts-lh),-flr(-(ts+lh))-1
end
local rk,lb=rj(ts+oo,sg)
local mr,di=rj(dc,um)
for lf=mr,di do
if oo<0 and iw(e,rk,lf)then
hj(e,k)
return rk+sg+1,0
elseif oo>0 and iw(e,lb,lf)then
hj(e,k+1)
return lb-sg,0
end
end
return ts,oo
end
cf=split("0x8000,0x8000,0x7fff,0x7fff,@1|!ak/@1/-2,!ak/@2/-2,!ak/@3/2,!ak/@4/2,13;!ak/@1/-1,!ak/@2/-1,!ak/@3/1,!ak/@4/1,1;|0,0,0,0,0,0,0;1,1,1,0,0,0,0;2,2,2,1,0,0,0;3,3,3,1,0,0,0;4,2,2,2,1,0,0;5,5,1,1,1,0,0;6,13,13,5,5,1,0;7,6,13,13,5,1,0;8,8,2,2,2,0,0;9,4,4,4,5,0,0;10,9,4,4,5,5,0;11,3,3,3,3,0,0;12,12,3,1,1,1,0;13,5,5,1,1,1,0;14,13,4,2,2,1,0;15,13,13,5,5,1,0;|ou;3;eq,;aj,|ul:@1;w:@2;dt:@3;en:@4;eb=@1,|ii;3;eq,;aj,|aa;0;,;|on:,;rd:@1;er:@2;b:@3;ni:@4;|eq;0;aa,;dw,nu,nc,sk|aj:@1;nc:@2;nu:@3;sk:@4;lv:@5;im:,;r:h;w:c;en:c;dw:c;tk:c;|mx;0;eq,;|ex:thing;|el;0;eq,;r_,|r_:c;|fj;0;eq,;|sw:h;|ts;0;eq,;|a:0;o:0;|fq;0;x,;|;|pl;0;x,;|ow;0;x,of;|tb;0;x,of;|hr;0;x,;|ig:@1;|io;0;x,;|ig:@1;lq:es;|af;0;ao,;|c_:@1;|au;0;ao,;|dm:@1;|a_;0;ts,;|f:0;y:0;dl:@1;|ty;0;a_,;|us:.90;my:.90;et:0;ef:0;cy:@1;stop:@2;|ao;0;ts,;|q:.375;j:.375;|oz;0;eq,;hq,|ei:hb;hi:0;lx:0;iq:0;ru:0;mo:es;hq:@1;|tl;0;ts,;uk,|nj:0;tg:0;op:0;ap:0;cl:h;uk:@1;|tj;0;tl,;s,|s:c;|uu;0;tl,;s,|d_;0;tl,;s,|oq;0;tj,ts;|s:c;ue:@1;th:hb;|sj;0;tl,;s,|mb;0;tl,;s,|lo;0;tl,;s,|li;0;tl,;s,|dn;0;tl,;s,|lr;0;tl,;s,|nr;0;tl,;s,|ro;0;tl,;s,|al;0;a_,tl,;|i:0;pu:BG_UI;oy:1;tr:1;ea:es;mi:es;|spr;0;al,;|s:@1;|nf;0;ty,aa,;|ab:@1;nz:@2;st:0;rt:0;|of;0;eq,;|tn:1;ob:1;hx:60;de:c;hy:c;tu:c;ie:@1;fy:@2;|se;1;a_,ao;|em:@1;ig:c;|x;0;a_,ao;|em:h;ig:c;ac:@1;|f:0;y:0|a,f,@1,@2,@3,@4;o,y,@1,@2,@5,@6;|ai;0;a_,ao;|cr:h;ri:c;dh:@1;|ed;4;eq,el;cp,sh|a:0;o:0;pt:2;sw:h;t_:@1;tq:@2;ol:@3;tv:@4;sh:@5;cp:@6;pd:@7;,;|@1,a,t_,nj;@1,o,tq,tg|ho;0;el,sj|s:@1;w:@2;em:es;q:.25;j:.5;i:0;|dy;4;ho,|a:@1;o:@2;ea:@3;i:@4;em:es;q:.25;j:.5;|lg;4;ho,|a:@1;o:@2;ea:@3;i:@4;w:@5;en:@6;em:es;q:.25;j:.5;|fi;3;x,el,oz,io|ei:@1;a:@2;o:@3;w:@4;em:es;q:.5;j:1;eb=.16,;|ek;3;tj,x,el,ty,af,au,nf,of,al,tb,ai|i:66;a:@1;o:@2;tw:@3;en:@4;tu:@5;tk:@6;s:%ld;tn:3;ob:3;tr:2;tg:-5;q:.375;j:.375;em:es;|ey;3;oq,tj,x,el,ty,af,au,al,ai|i:98;a:@1;o:@2;tw:@3;en:@4;s:%ld;tr:2;tg:-5;q:.375;j:.375;em:es;|sq;0;el,ty,;|hw:@1;ck:@2;cm:@3;lw:@4;|ev;3;lo,sq|a:@1;o:@2;color:@3;s:$hw;w:$cm;eb=.25,;|ci;3;nr,sq|a:@1;o:@2;color:@3;s:$hw;w:$lw;eb=.25,;|mf;3;nr,sq|a:@1;o:@2;color:@3;s:$ck;w:$lw;eb=.25,;|ry;5;ao,el|color:8;q:@1;j:@2;cc:@3;dj:@4;ud:@5;lz:@6;|fh;3;x,el,oz,io|ei:@1;a:@2;o:@3;w:@4;em:es;q:.75;j:.75;eb=.5,;|ti;3;tj,x,el,ty,af,au,nf,of,al,tb,ai|i:9;a:@1;o:@2;tw:@3;en:@4;tu:@5;tk:@6;s:%mj;tn:3;ob:3;tr:2;tg:-5;q:.375;j:.375;em:es;|to;3;oq,tj,x,el,ty,af,au,al,ai|i:41;a:@1;o:@2;tw:@3;en:@4;s:@5;i:41;tr:2;tg:-5;q:.375;j:.375;em:es;|ly;0;x,el,oz|w:@1;em:es;q:.375;j:.75;eb=.33,;|lu;3;ly,hr|ei:@1;a:@2;o:@3;|up;3;ly,io|rn;1;tj,ts,el,ty,af,au,x,al,nf,of,ai;|hx:90;hv:@1;nt:@2;tk:@2;s:@3;eo:1;k:0;oj:h;ea:h;tn:3;ob:3;tu:c;ha:c;l_:c;aq:c;tr:2;tg:-5;|lj;0;rn/es,|tu:@1;de:@2;hy:@3;ha:@4;l_:@5;aq:@6;eo:0;|la;0;rn/h,|tu:@1;|hm;3;x,a_,el,oz,io,li,ai|a:@1;o:@2;f:@3;s:@4;ri:@5;tk:@6;lq:h;em:es;q:.375;j:.25;tg:-6;eb=1,;|am;3;tj,x,el,ty,af,au,nf,of,al,tb,ai|i:192;a:@1;o:@2;tw:@3;en:@4;tu:@5;tk:@6;s:@7;s:%ps;tn:3;ob:3;tr:2;tg:-5;q:.375;j:.375;em:es;|ay;3;oq,tj,x,el,ty,af,au,al,ai|a:@1;o:@2;tw:@3;en:@4;s:@5;i:224;tr:2;tg:-5;q:.375;j:.375;em:es;|sb;3;ry/.125/.125/1/3/%ci,ro|a:@1;o:@2;ux:@3;en:@4;s:@5;color:8;|ia;5;ry/2/.125/1/1/%mf,ro|a:@1;o:@2;rx:@3;color:@4;i:@5;en:@6;s:@7|fl;2;nr,el|a:@1;o:@2;s:@3;dr:5;|sf;2;lr,el|a:@1;o:@2;en:@3;s:@4;j:.25;ij:.2;em:es;oe:0;|om;2;x,sj,el|a:@1;o:@2;en:@3;s:@4;q:.125;j:.125;ij:.2;em:es;|ne;0;x,|ig:@1;sr:es;|fa;2;la,ow,ne|a:@1;o:@2;en:@3;tk:@4;|m_;2;la,ow,ne|cz;2;lj,ow,ne|mh;3;lj,tb|tn:4;ob:4;em:es;a:@1;o:@2;tw:@3;w:@4;en:@5;tk:@6;;|a=102,o=4,m=%ek,u=%ey,r=h;a=14,o=26,m=%ek,u=%ey,r=h;a=18,o=13,m=%ek,u=%ey,r=h;a=45,o=28,m=%ek,u=%ey,r=h;a=48,o=3,m=%ek,u=%ey,r=h;a=4,o=28,m=%ek,u=%ey,r=h;a=53,o=9,m=%ek,u=%ey,r=h;a=70,o=13,m=%ek,u=%ey,r=h;a=76,o=18,m=%ek,u=%ey,r=h;a=76,o=7,m=%ek,u=%ey,r=h;a=81,o=4,m=%ek,u=%ey,r=h;a=65,o=23,m=%ek,u=%ey,r=h;a=9,o=17,m=%ek,u=%ey,r=h;a=20,o=18,m=%ek,u=%ey,r=h;a=30,o=6,m=%ek,u=%ey,r=h;a=4,o=3,m=%ek,u=%ey,r=h;a=3,o=18,m=%ti,u=%to,r=h;a=63,o=8,m=%ti,u=%to,r=h;a=70,o=8,m=%ti,u=%to,r=h;a=15,o=18,m=%ti,u=%to,r=h;a=102,o=13,m=%ti,u=%to,r=h;a=106,o=20,m=%ti,u=%to,r=h;a=49,o=19,m=%ti,u=%to,r=h;a=9,o=23,m=%ti,u=%to,r=h;a=9,o=28,m=%ti,u=%to,r=h;a=76,o=12,m=%ti,u=%to,r=h;a=76,o=3,m=%ti,u=%to,r=h;a=82,o=4,m=%ti,u=%to,r=h;a=89,o=15,m=%ti,u=%to,r=h;a=18,o=26,m=%am,u=%ay,r=h;a=44,o=4,m=%am,u=%ay,r=h;a=54,o=4,m=%am,u=%ay,r=h;a=90,o=4,m=%am,u=%ay,r=h;a=105,o=28,m=%am,u=%ay,r=h;a=102,o=4,m=%am,u=%ay,r=h;a=66,o=29,m=%am,u=%ay,r=h;a=41,o=18,m=%am,u=%ay,r=h;|a=126,o=8,si=%mh,r=h;|el,r_;el,nu;el,sk;|ex:m;a:0;o:0;t_:108;tq:32;|ex:u;a:0;o:0;t_:108;tq:32;|ex:si;a:108;o:0;t_:20;tq:16;|aa,rd;eq,aj;eq,nc;|aa,rd;eq,aj;ty,cy;ow,ac,@1;tb,ac,@1;hr,ac,@2;io,ac,@3;ne,ac,@4;ai,dh,@5;oz,hq;a_,dl;af,c_;au,dm;ed,sh;eq,nc;|sj,s;mb,s;lo,s;|tj,s;uu,s;d_,s;li,s;dn,s;lr,s;oq,ue;|nr,s;ro,s;|sw:h;a=64,o=64,w=@2,en=c,s=@1,eb=2.5;w=@3,en=@4,s=@5;w=@6,en=@7,s=@8;w=@9,en=@10,s=@11;|","|")
rp={}
function c()end
function td(cu,...)
local oa=cf[0+cu]
local ej,ar=unpack(rp[oa]or{})
if not ej then
ej,ar={},{}
for re in all(split(oa,";"))do
local eh,g=he(re,":",ej)
local le=function(uf,co,ct)
return fd(ct or ej,co or eh,uf,ar)
end
local as,hp={},split(g,",")
for re in all(hp)do
local eh,g=he(re,"=",as)
if #hp==1 then
as=le(g)
else
as[eh]=le(g,eh,as)
end
end
ej[eh]=as
end
rp[oa]={ej,ar}
end
local ir={...}
foreach(ir,dp)
foreach(ar,function(fs)
local t,eh,ad=unpack(fs)
t[eh]=ad(ir)
end)
return ej
end
function he(nk,ug,ej)
local iz=split(nk,ug)
return iz[#iz-1]or #ej+1,iz[#iz]
end
function fd(ej,eh,g,ar)
local av=split(g,"/")
local sp,hh,ih=#av>1
if ord(g)==33 then
sp,ih=true,deli(av,1)
hh={
ej,eh,function()
return _g[sub(ih,2)](unpack(av))
end
}
end
for w,a in ipairs(av)do
local nl,sn=sub(a,2),ej
if sp then
sn,eh=av,w
end
if ord(a)==64 then
add(ar,{
sn,eh,function(mw)
return mw[nl+0]
end
})
elseif ord(a)==36 then
a=function(e,...)
e[nl](e,...)
end
elseif ord(a)==37 then
a=_g[nl]
elseif ord(a)==126 then
add(ar,{
sn,eh,function()
return ej[nl]
end
})
elseif a=="h"or a=="es"then a=a=="h"
elseif a=="hb"or a==""then a=nil
elseif a=="c"then a=function()end
end
av[w]=a
end
add(ar,hh)
if sp then
return av
else
return av[1]
end
end
function dp(t)
if type(t)=="table"then
t.mq=true
end
return t
end
function ep(i,a,o,oy,tr,...)
oy,tr=oy or 1,tr or 1
spr(i,a-oy*4,o-tr*4,oy,tr,...)
end
function e_(oa,a,o,color,hg)
if hg==0 then a-=#oa*2
elseif hg>0 then a-=#oa*4+1 end
print(oa,a,o,color)
end
function du(eg,ew,ec,eu)
clip(eg,ew,ec+1-flr(eg),eu+1-flr(ew))
end
function fw(x)
tp(rectfill,[[1]],x or 0)
end
function fz(eg,ew,ec,eu)
tp(rect,
[[2]],eg,ew,ec,eu)
end
function ag(e,cn,...)
if e and e.cl then
(cn or ep)(e.i,e.a*8+e.nj+e.op,e.o*8+e.tg+e.ap,e.oy,e.tr,e.ea,e.mi,...)
end
end
function fx(flip,ng,ao)
ng=ng-ao*4
if flip then
return ao*8-1+ng,-1
else
return ng,1
end
end
ml=td[[3]]
function ib(w)
for ax=0,15 do
pal(ax,ml[ax+1][min(flr(w+1),7)])
end
end
_([[4|5]],function(e)
ot=max(e.ae/e.eb*10,ot)
end)
_([[6|5]],function(e)
ot=min((e.eb-e.ae)/e.eb*10,ot)
end)
d([[7|8]],function(e)
local lp={}
for eh,g in pairs(e.on)do
g.t+=1
if g.t>g.np then
add(lp,eh)
end
end
for eh in all(lp)do
local g=e.on[eh]
e.on[eh]=nil
g.rf(e)
end
end,function(e,ic,np,rf)
e.on[ic]={t=0,np=np,rf=(rf or c)}
end,function(e,...)
for ic in all{...}do
if e.on[ic]~=nil then
return true
end
end
return false
end,function(e,ic)
local aa=e.on[ic]
return aa and(aa.t/aa.np)or 1
end)
d([[9|10]],function(e)
if e.r and rb(e)then
e.r=false
end
end,function(e)
if not e.r then
e:tk()
e:sk()
end
end,function(e)
e.r=nil
end,function(e)
for eh,g in pairs(tc)do
if e[eh]then del(g,e)end
end
end,lv)
d[[11|12]]
d[[13|14]]
d[[15|16]]
d[[17|18]]
d[[19|20]]
d[[21|20]]
d[[22|20]]
d[[23|20]]
d([[24|25]],function(e,p)
if p.tb then
p:tu(e)
end
end)
d([[26|27]],function(e,p)
if p.ow then
p:tu(e)
end
if e.lq then
e:nu()
end
end)
d([[28|29]],function(e)
if e.a+e.f<v.a+e.q then
e.a=v.a+e.q
e.f=0
end
if e.a+e.f>v.a+v.t_-e.q then
e.a=v.a+v.t_-e.q
e.f=0
end
end)
d([[30|31]],function(e)
if e.o+e.y<v.o+e.j then
e.o=v.o+e.j
e.y=0
end
if e.o+e.y>v.o+v.tq-e.j then
e.o=v.o+v.tq-e.j
e.y=0
end
end)
d([[32|33]],function(e)
e.a+=e.f
e.o+=e.y
end)
d([[34|35]],function(e)
e.f+=e.et e.y+=e.ef
e.f*=e.us e.y*=e.my
if e.et==0 and abs(e.f)<.01 then e.f=0 end
if e.ef==0 and abs(e.y)<.01 then e.y=0 end
end,function(e)
e.et,e.ef,e.f,e.y=0,0,0,0
end)
d[[36|37]]
d([[38|39]],function(e)
local at=e.ei
if at then
if at.r then
e.a,e.o=at.a+e.hi,at.o+e.lx
e.f,e.y=at.f+e.iq,at.y+e.ru
e.hi+=e.iq
e.lx+=e.ru
e.op,e.ap=at.op,at.ap
if e.mo then
e.ea=at.ea
end
else
e.r=false
end
end
end)
d([[40|41]],function(e)
e.op,e.ap=0,0
end)
d[[42|43]]
d[[44|43]]
d[[45|43]]
d([[46|47]],function(e)
if e.th and nx(l.a-e.a,l.o-e.o)<1 then
e_(e.th,e.a*8,(e.o-2.5)*8+1,1,0)
e_(e.th,e.a*8,(e.o-2.5)*8-1,1,0)
e_(e.th,e.a*8-1,(e.o-2.5)*8,1,0)
e_(e.th,e.a*8+1,(e.o-2.5)*8,1,0)
e_(e.th,e.a*8,(e.o-2.5)*8,7,0)
end
end)
d[[48|43]]
d[[49|43]]
d[[50|43]]
d[[51|43]]
d[[52|43]]
d[[53|43]]
d[[54|43]]
d[[55|43]]
d[[56|57]]
d([[58|59]],ag)
d([[60|61]],function(e,ff)
if not e:b("knockback")then
e.st=.075
e.rt=ff
e:er("knockback",4)
end
end,function(e)
e.et=cos(e.rt)*e.st
e.ef=sin(e.rt)*e.st
end)
d([[62|63]],function(e,tu)
tu=tu or 1
if not e:b("hurt_cooldown")then
e.tn=max(0,e.tn-tu)
if e.tn==0 then
e.r=false
return
end
e:er("hurt_cooldown",e.hx,e.hy)
e:de()
end
end,function(e,tn)
e.tn=min(e.ob,e.tn+tn)
end)
d[[64|65]]
d([[66|67]],function(e,ca)
local ix={}
local ac=function(f,y)
local as=f+y
local dv=function(hu,nm,e,ee,ts,oo)
if oo!=0 and ts<abs(e[hu]-ee[hu])then
if e.em and ee.em then
local lm=function(ax)
if not ax.se then
ax[nm]=(e[nm]+ee[nm])/2
end
end
lm(e)lm(ee)
as=0
end
ix[ee][nm]=nq(oo)
end
end
foreach(ca,function(ee)
if e!=ee and(not e.se or not ee.se)then
local a,o=abs(e.a+f-ee.a),abs(e.o+y-ee.o)
if a<e.q+ee.q and o<e.j+ee.j then
ix[ee]=ix[ee]or td[[68]]
tp(dv,[[69]],e,ee,a,f,o,y)
end
end
end)
return as
end
e.f,e.y=ac(e.f,0),ac(0,e.y)
for ee,s in pairs(ix)do
e:ig(ee,s.f,s.y)
end
end)
d([[70|71]],function(e,iw)
local a,f=lt(e.a,e.o,e.f,e.q,e.j,0,e,e.ri,iw)
local o,y=lt(e.o,e.a,e.y,e.j,e.q,2,e,e.ri,function(e,o,a)return iw(e,a,o)end)
if e.cr then
e.a,e.o,e.f,e.y=a,o,f,y
end
end)
function dd(ed,i_,iy,fg)
if not ed.tv then return end
local nd=ed.tv[i_]
local tz=ed[i_]
local lc=ed[iy]
local nh=v[iy]/2-lc/2
local ip=v[i_]+v[iy]/2
local ol=rv(ed.ol*(lc/2))/8
if nd<tz-ol then tz=nd+ol end
if nd>tz+ol then tz=nd-ol end
if tz<ip-nh then tz=ip-nh end
if tz>ip+nh then tz=ip+nh end
if v[iy]<=ed[iy]then tz=ip end
ed[i_]=tz
end
function fb(a,o,ax)
pset(a*8,o*8,ax)
end
function ss(eg,ew,ec,eu,x)
line(eg*8,ew*8,ec*8,eu*8,x)
end
function ch(eg,ew,ec,eu,x)
rectfill(eg*8,ew*8,ec*8,eu*8,x)
end
function fk(eg,ew,ec,eu,x)
oval(eg*8,ew*8,ec*8,eu*8,x)
end
function un(eg,ew,ec,eu,x)
ovalfill(eg*8,ew*8,ec*8,eu*8,x)
end
function uz(mn,cx,da,mm,...)
map(mn,cx,da*8,mm*8,...)
end
function h_(a,o,s_,x)
circfill(a*8,o*8,s_*8,x)
end
function pn(a,o,s_,x)
circ(a*8,o*8,s_*8,x)
end
_([[72|73]],
function(e)
if e.tv and not e.tv.r then
e.tv=nil
end
tp(dd,[[74]],e)
end,function(e)
if e.tv then
e.a,e.o=e.tv.a,e.tv.o
e.ex=e.tv.ex
end
e:sh()
end,function(e,p)
if not p or p.mx then
e.tv=p
end
end)
_([[75|76]],function(e)
local i=e.i
if v.ex=="hospital"then i+=16 end
ep(i,e.a*8+e.op,e.o*8+e.ap,2,1,e.ea,false)
end)
_[[77|78]]
_([[79|80]],function(e)
e:er("ma",30)
end,function(e)
if e:b"ma"then
_g.ev(e.a,e.o,8)
e.op=te(3)-2
e.ap=te(3)-2
end
end)
function rl(tw,...)
add(_g.sd[v.ex],{...})
_g.sz[v.ex][tw].r=false
_g.lg(...)
end
function _g.ld(e)
e.i=66
if e:b"prepare"then
e.i=69
elseif e:b"attack"then
e.i=70
if e:ni"attack">.50 then
e.i=71
end
elseif abs(e.f)>.005 or abs(e.y)>.005 then
local ta=e.ae%.5/.5
if ta<.25 then e.i=66
elseif ta<.5 then e.i=67
elseif ta<.75 then e.i=66
else e.i=68
end
end
if v.ex=="u"then
e.i+=32
end
ag(e)
end
_([[81|82]],function(e)
e.iq=nq(cos(e.ei.k))*.05
end)
_([[83|84]],function(e)
if not e:b("cooldown","walk","prepare","attack")then
e.k=atan2(l.a-e.a,l.o-e.o)+rnd(.125)-.125/2
e:er("walk",te(10)+30,function()
e:er("cooldown",te(120),function()
e:er("prepare",40,function()
_g.fi(e,e.a,e.o)
e:er("attack",10)
end)
end)
end)
end
if e:b"hurt_cooldown"then
_g.ev(e.a,e.o+.5,8)
end
if e:b"knockback"then
e:nz()
elseif e:b"walk"then
e.et=cos(e.k)*.01
if e.et>0 then
e.ea=false
elseif e.et<0 then
e.ea=true
end
e.ef=sin(e.k)*.01
else
e.et=0
e.ef=0
end
end,function(e,p)
local ik=e:b"hurt_cooldown"
e:ie(l.eo)
e:ab(atan2(e.a-p.a,e.o-p.o))
if p.ei then
p.ei:ab(atan2(l.a-e.a,l.o-e.o))
if not ik then
an(p.ei,"increment_strength",p.ei)
end
end
end,function(e)
rl(e.tw,e.a,e.o,e.ea,96)
end)
_([[85|86]],function(e)
if not e:b("cooldown","walk")then
e.k=atan2(l.a-e.a,l.o-e.o)+rnd(.125)-.125/2
e:er("walk",te(10)+30,function()
e:er("cooldown",te(120)+50)
end)
end
if z.tx>0 then
e.th="you monster!"
else
e.th="you're healed!"
end
if e:b"walk"then
e.et=cos(e.k)*.01
if e.et>0 then
e.ea=false
elseif e.et<0 then
e.ea=true
end
e.ef=sin(e.k)*.01
else
e.et=0
e.ef=0
end
end)
d([[87|88]],function(e)
h_(e.a,e.o,.125,e.color)
end,function(e)
h_(e.a,e.o,.375,e.color)
end,function(e)
e.f=rnd(.2)-.1
e.y=-rnd(.2)-.1
end,function(e)
e.f=rnd(.05)-.025
e.y=rnd(.05)-.025
end)
_[[89|90]]
_[[91|92]]
_[[93|94]]
d([[95|96]],function(e)
for w=1,e.cc do
if te(e.dj)==0 then
e.ud(
e.a+rnd(e.q*2)-e.q,
e.o+rnd(e.j*2)-e.j,
e.color
)
end
end
end)
function _g.mj(e)
e.i=9
if e:b"prepare"then
e.i=10
elseif e:b"charge"then
local ez=e:ni"charge"
if ez<.2 then e.i=11
elseif ez<.4 then e.i=12
elseif ez<.75 then e.i=13
else e.i=10
end
end
if v.ex=="u"then
e.i+=32
end
ag(e)
end
_([[97|98]])
_([[99|100]],function(e)
if not e:b("cooldown","charge","prepare","attack")then
e.k=atan2(l.a-e.a,l.o-e.o)+rnd(.125)-.125/2
_g.fh(e,e.a,e.o)
e:er("charge",20,function()
e:er("cooldown",te(60)+60,function()
e:er("prepare",60)
end)
end)
end
if e:b"hurt_cooldown"then
_g.ev(e.a,e.o+.5,8)
end
if e:b"knockback"then
e:nz()
elseif e:b"charge"then
e.et=cos(e.k)*.03
e.ef=sin(e.k)*.03
if e.et>0 then
e.ea=false
elseif e.et<0 then
e.ea=true
end
else
if abs(e.f)<.01 then
e.ea=e.a-l.a>0
end
e.et=0
e.ef=0
end
end,function(e,p)
local ik=e:b"hurt_cooldown"
e:ie(l.eo)
e:ab(atan2(e.a-p.a,e.o-p.o))
if p.ei then
p.ei:ab(atan2(l.a-e.a,l.o-e.o))
if not ik then
an(p.ei,"increment_strength",p.ei)
end
end
end,function(e)
rl(e.tw,e.a,e.o,e.ea,14)
end)
_([[101|102]],function(e)
e.ea=e.a-l.a>0
if t()%5<.5 then
e.nj=te(3)-1
e.i=hc{41,42,43}
else
e.nj=0
end
if z.tx>0 then
e.th="don't kill me too!"
else
e.th="play with me!"
end
end,ag)
d([[103|104]],function(e)
e.iq=cos(e.ei.k)*.03
e.ru=sin(e.ei.k)*.03
end)
_[[105|106]]
_[[107|106]]
d([[108|109]],function(e)
local i=e.hv and 80 or 64
_g.lg(e.a,e.o,e.ea,i)
end,function(e)
e.i=134
e.ap=0
if e:b"punch"then
local ez=e:ni"punch"
if ez>=.90 then e.i=133
elseif ez>=.80 then e.i=132
elseif ez>=.50 then e.i=131
elseif ez>=.30 then e.i=130
elseif ez>=.10 then e.i=129
else e.i=128
end
e.ap=sin(ez/2)*5
elseif e:b"roll"then
local ez=e:ni"roll"
if ez>=.90 then e.i=140
elseif ez>=.80 then e.i=139
elseif ez>=.50 then e.i=138
elseif ez>=.30 then e.i=137
else e.i=136
end
elseif abs(e.f)>.005 or abs(e.y)>.005 then
local ta=(e.ae%.4)/.4
if ta>=.8 then e.i=134
elseif ta>=.5 then e.i=142
elseif ta>=.3 then e.i=134
else e.i=143
end
else
local ta=e.ae and(e.ae%1)or 0
if ta<.25 then e.i=141 end
end
e.ea=e.oj
if e.hv then e.i+=32 end
ag(e)
end)
d([[110|111]],function(e,p)
if not e:b"roll"then
e:ie()
e:ab(atan2(e.a-p.a,e.o-p.o))
end
end,function(e)
e:aq(4)
end,function(e)
e:aq(0)
end,function(e)
if e.eo<3 then
e:aq(e.eo+1)
end
end,function(e)
if e.eo>3 then
e:aq(0)
elseif e.eo>0 then
e:aq(e.eo-1)
end
end,function(e,hl)
if hl ~=e.eo then
e.eo=hl
e:er("strength_timeout",60*5,function()
e:l_()
end)
end
end)
d([[112|113]],function(e,p)
if not e:b"roll"then
if not e:b"hurt_cooldown"then
if p.ei then
p.ei:ha()
end
end
e:ie()
e:ab(atan2(e.a-p.a,e.o-p.o))
end
end)
function ns(e,oh,n_,uj,uh,rz,eo)
if not e.rn then return end
if e.sr then
e.tg-=.25
e.et=0 e.ef=0
return
end
local sl=1
if eo then
sl=1+e.eo/10
if eo==4 then _g.ev(e.a,e.o+.5,8)
elseif eo==3 then _g.ev(e.a,e.o+.5,12)
elseif eo==2 then _g.ev(e.a,e.o+.5,9)
elseif eo==1 then _g.ev(e.a,e.o+.5,3)
end
elseif e:b("hurt_cooldown")then
_g.ev(e.a,e.o+.5,8)
end
if eo==4 then e.uq=2
else e.uq=1 end
if not e:b("cooldown","roll","punch")then
if uj then
e:er("roll",20,function()e.f/=3 e.y/=3 e:er("cooldown",20)end)
elseif uh then
if rz then
e:er("punch",20,function()e:er("cooldown",10)end)
rz(e,e.a,e.o)
end
end
end
local ut=oh ~=0 or n_ ~=0
if e:b"knockback"then
e:nz()
elseif e:b"roll"then
e.et=cos(e.k)*.03
e.ef=sin(e.k)*.03
elseif e:b"punch"then
e.et=cos(e.k)*.005
e.ef=sin(e.k)*.005
elseif ut then
if oh ~=0 then
e.oj=oh<0
end
e.k=atan2(oh==0 and(e.oj and-1 or 1)or oh,n_)
local k=atan2(oh,n_)
e.et=cos(k)*.015
e.ef=sin(k)*.015
else
e.k=atan2(e.oj and-1 or 1,0)
e.et=0
e.ef=0
end
e.et*=sl
e.ef*=sl
end
_([[114|115]],function(e)
e.hz=not e.hz
e.i=e.hz and 197 or 198
e.ea=e.f<0
ag(e)
end,function(e)
e.r=false
end,function(e)
_g.ev(e.a,e.o,8)
_g.ev(e.a,e.o,8)
_g.ev(e.a,e.o,8)
_g.ev(e.a,e.o,8)
_g.ev(e.a,e.o,8)
_g.ev(e.a,e.o,8)
end)
_([[116|117]],function(e)
local nv=.2
if not e:b("walk","wait","aim","shoot")then
e:er("walk",120+rnd(60),function()
e:er("wait",te(20)+10,function()
e:er("aim",10,function()
_g.hm(e.a,e.o,e.ea and-nv or nv)
e:er("aim",10,function()_g.hm(e.a,e.o-1,e.ea and-nv or nv)end)
e:er("shoot",40,c)
end)
end)
end)
end
if e:b"hurt_cooldown"then
_g.ev(e.a,e.o+.5,8)
end
if not e:b"shoot"then
if abs(e.f)<.01 then
e.ea=e.a-l.a>0
end
end
if e:b"knockback"then
e:nz()
elseif e:b"walk"then
e.k=atan2(l.a-e.a,l.o-e.o)+rnd(.125)-.125/2
e.et=0
e.ef=sin(e.k)*.03
else
e.et=0
e.ef=0
end
end,function(e,p)
local ik=e:b"hurt_cooldown"
e:ie(l.eo)
e:ab(atan2(e.a-p.a,e.o-p.o))
if p.ei then
p.ei:ab(atan2(l.a-e.a,l.o-e.o))
if not ik then
an(p.ei,"increment_strength",p.ei)
end
end
end,function(e)
rl(e.tw,e.a,e.o,e.ea,227)
end,function(e)
if e:b"aim"then
e.i=195
elseif e:b"shoot"then
e.i=196
elseif abs(e.f)>.01 or abs(e.y)>.01 then
local ta=e.ae%.5/.5
if ta<.25 then e.i=193
elseif ta<.5 then e.i=192
elseif ta<.75 then e.i=193
else e.i=194
end
end
ag(e)
end)
_([[118|119]],function(e)
e.ea=t()%10>5
if t()%7<1 then
if e.ea then
e.et=.005
else
e.et=-.005
end
else
e.et=0
end
if z.tx>0 then
e.th="killer, thriller!"
else
e.th="abc, 123, you & me!"
end
local sx=t()%5
if sx<1 then e.i=224
elseif sx<2 then e.i=225
elseif sx<3 then e.i=226
else e.i=225 end
end,ag)
_([[120|121]],function(e)
e:lz()
if l.tn<e.ux then
e:nu()
end
end,function(e)
ep(16,e.a*8,e.o*8+1)
end)
_([[122|123]],function(e)
if l.r and l.eo==e.rx then
e:lz()
end
end,function(e)
if l.r and l.eo==e.rx then
ep(e.i,e.a*8,e.o*8,2,2,l.oj,false)
end
end)
_([[124|125]],function(e)
if z.oc-z.tx<=e.dr then
ch(.125,e.o-.5,15.75,e.o+.5,1)
local hk=""..z.tx.."/"..z.oc
if z.tx==z.oc then
hk="all"
end
e_("killed "..hk.." enemies",e.a*8,e.o*8-2,8,0)
end
end)
_([[126|127]],function(e)
local oe
local ov
for uw in all{"tb","om"}do
for ee in all(tc[uw])do
local o_=nx(l.a-ee.a,l.o-ee.o)
if not oe or o_<oe then
oe=o_
ov=ee
end
end
end
e.oe=oe
e.ov=ov
end,function(e)
if e.ov and e.oe>3.5 then
local k=atan2(e.ov.a-l.a,e.ov.o-l.o)
k=rv(k*16)/16
local f=cos(k)
local y=sin(k)
local ht=-.5
local color=1
local rh=1.75
if t()%.5<.25 then
rh*=1.125
end
local eg=l.a+f
local ew=ht+l.o+y
local ec=l.a+f*rh
local eu=ht+l.o+y*rh
ss(eg,ew,ec,eu,color)
local na=.375
local od=.375
local fc=ec+cos(k+na)*od
local mg=eu+sin(k+na)*od
local fn=ec+cos(k-na)*od
local mp=eu+sin(k-na)*od
ss(ec,eu,fc,mg,color)
ss(ec,eu,fn,mp,color)
end
end)
_([[128|129]],function(e)
if nx(l.a-e.a,l.o-e.o)<16 then
_g.ev(e.a+rnd(.5)-.25,e.o+rnd(.5)-.25,hc{1,2})
e.ij=(sin(t())*.2+.5)
end
end,function(e)
un(e.a-e.ij,e.o-.2,e.a+e.ij,e.o+.2,1)
end)
d([[130|131]],function(e,p)
if p.om and not e.sr then
e.sr=true
_g.ou(1,c,function()
if v.ex=="dungeon"then
ah=mc
ah()
elseif v.ex=="bossroom"then
ah=ds
ah()
elseif v.ex=="hospital"then
os:nw()
end
end)
end
end)
_([[132|133]],function(e)
ns(e,rm(),rs(),btn(4),btn(5),_g.lu)
end,function(e)
e:nt()
z.aw=z.aw+1
_g.ou(1,c,ah)
end)
_([[134|133]],function(e)
ns(e,rm(),rs(),btn(4),btn(5))
end,function(e)
e:nt()
z.aw=z.aw+1
_g.ou(1,c,ah)
end)
_([[135|133]],function(e)
ns(e,rm(),rs(),btn(4),btn(5),_g.lu,e.eo)
end,function(e)
e:nt()
z.aw=z.aw+1
_g.ou(1,c,ah)
end)
_([[136|137]],function(e)
e:aq(3)
end,function(e)
local a=nq(l.a-e.a)
local o=nq(l.o-e.o)
ns(e
,a
,o
,te(80)==0
,te(20)==0
,_g.up
,e.eo
)
end,function(e)
e:nt()
_g.om(118,8)
end)
function df()
local hd=ox(td[[138]])
return{
m=hd,
u=hd,
si=ox(td[[139]])
}
end
function cb()
for a=0,107 do
for o=0,31 do
local g=mget(a,o)
if g>=1 and g<=4 then g+=4
elseif g>=17 and g<=20 then g+=4
elseif g>=33 and g<=36 then g+=4
elseif g>=49 and g<=52 then g+=4
elseif g==32 or g==46 or g==47 then g+=16
elseif g==117 then g+=1
end
mset(a,o,g)
end
end
end
function sv()
_g.sb(6.5,1,3)
_g.sb(9.5,1,2)
_g.sb(8,1,1)
end
function dx()
_g.ia(3,1,0,13,72)
_g.ia(4,15,1,3,74)
_g.ia(8,15,2,9,76)
_g.ia(12,15,3,12,78)
_g.ia(13,1,4,8,104)
end
function su()
for w,ny in pairs(_g.sz[v.ex])do
if ny.r then
ny[v.ex](ny.a,ny.o,w)
end
end
end
function rr()
for ms in all(_g.sd[v.ex])do
_g.dy(unpack(ms))
end
end
function so()
tp(oi,[[140]])
end
function uv()
so()
_g.ii(.5,c,c)
l=_g.cz(18,3)
tf=_g.ed(15.25,11.5,3,l)
v=td[[141]]
_g.om(94,13)
rr()
su()
sv()
dx()
_g.fl(8,13)
_g.sf(8,13)
end
function ds()
cb()
so()
_g.ii(.5,c,c)
_g.om(18,3)
l=_g.m_(94,13)
tf=_g.ed(15.25,11.5,3,l)
v=td[[142]]
rr()
su()
sv()
_g.sf(8,13)
end
function mc()
so()
_g.ii(.5,c,c)
l=_g.fa(110,8)
tf=_g.ed(15.25,11.5,3,l)
v=td[[143]]
rr()
su()
sv()
_g.sf(8,13)
end
function ur(e)
_g.ii(.5,c,function()ra=true end)
ra=false
f_=0
end
function mu(e)
if ra and(btn(4)or btn(5))then
ra=false
_g.ou(.5,c,function()
os.it=2
end)
end
tp(oi,[[144]])
end
function fm(e)
ib(ot)
ep(200,64,16+8,8,3)
local tt=48
ep(72,16,tt,2,2)
ep(74,16,tt+16,2,2)
ep(76,16,tt+32,2,2)
ep(78,16,tt+48,2,2)
ep(104,16,tt+64,2,2)
local az
if z.iv<60 then
az="hyperactive"
elseif z.tx==0 then
az="healthy"
elseif z.tx==z.oc then
if z.aw==0 then
if z.iv<180 then
az="possessed"
else
az="obsessive"
end
else
az="insane"
end
else
az="unstable"
end
e_("diagnosis: "..az,16+12,tt-1,13,-1)
e_("-----------------------",16+12,tt+8-1,1,-1)
e_("kills : "..z.tx.."/"..z.oc,16+12,tt+16-1,3,-1)
e_("deaths: "..z.aw,16+12,tt+16+8-1,4,-1)
e_("time  : "..fr(),16+12,tt+32-1,9,-1)
e_("-----------------------",16+12,tt+32+8-1,1,-1)
e_("@alanxoc3: code/music",16+12,tt+48-1,12,-1)
e_("@denial: code/design",16+12,tt+48+8-1,14,-1)
e_("@thegreatcadet: gfx/map",16+12,tt+64-1,8,-1)
end
function ub()
for e in all(tc.tb)do
local o_=nx(e.a-l.a,e.o-l.o)
if o_>14 then
e.im.aj=true
if o_>17 then e.im.s=true end
else
e.im.aj=nil
e.im.s=nil
end
end
end
function md()
reload(0x2000,0x2000,0x1000)
local hs={}_g.sd={m=hs,si={},u=hs}
_g.sz=df()
z={
iv=0,
aw=0,
tx=0,
oc=0
}
ah=uv
ah()
end
function uc()
z.iv=min(7200,z.iv+1/60)
tp(oi,[[145]],tc["fp"],tc["tb"],tc["ow"],tc["om"],function(e,a,o)
return a>=v.a and a<v.a+v.t_ and
o>=v.o and o<v.o+v.tq and
(fget(mget(a,o),0)or(e.tb or e.oq)and fget(mget(a,o),1))
end)
if t()%.5==0 then ub()end
z.tx=#_g.sd.m
z.oc=#_g.sz.m
end
function ui(ed)return(ed.a-ed.u_-8)*8 end
function mt(ed)return(ed.o-ed.cw-8)*8 end
function cv(ed)camera(ui(ed),mt(ed))end
function ua()
ib(ot)
local a,o=8,8
local q=a-tf.t_/2
local j=o-tf.tq/2
tf.u_=-(16-tf.t_)/2+q
tf.cw=-(16-tf.tq)/2+j
local eg,ec=q*8,(q+tf.t_)*8-1
local ew,eu=j*8,(j+tf.tq)*8-1
rect(eg-2,ew-2,ec+2,eu+2,1)
du(eg,ew,ec,eu)
cv(tf)
uz(0,0,0,0,128,32)
tp(oi,[[146]])
fe(tc.tj)
tp(oi,[[147]])
camera()
clip()
tp(oi,[[148]])
end
function fr()
local no=flr(z.iv)
local og=flr(no/60)
local id=flr(og/60)
no=no%60
og=og<10 and "0"..og or og
id=id<10 and "0"..id or id
return ""..id..":"..og..":"..no
end
function fu(e)
_g.ii(.5,c,function()rc=true end)
rc=false
pr=0
end
function uy(e)
if rc and(btn(4)or btn(5))then
rc=false
_g.ou(.5,c,function()
os:nw()
end)
end
tp(oi,[[144]])
end
function uo(e)
ib(ot)
ep(72,64+cos(t()/5+.0)*45,64+sin(t()/3+.0)*45,2,2,t()%5<2.5,false)
ep(74,64+cos(t()/5+.2)*45,64+sin(t()/3+.2)*45,2,2,false,t()%5>2.5)
ep(76,64+cos(t()/5+.4)*45,64+sin(t()/3+.4)*45,2,2,t()%5<2.5,false)
ep(78,64+cos(t()/5+.6)*45,64+sin(t()/3+.6)*45,2,2,t()%5>2.5,false)
ep(104,64+cos(t()/5+.8)*45,64+sin(t()/3+.8)*45,2,2,false,t()%5<2.5)
ep(200,64,64,8,3)
end
ot=8
poke(0x5f5c,15)
poke(0x5f5d,15)
function _init()
music(0,3000)
sfx(63)
os=td([[149]],cq,function()end,
fu,uy,uo,
md,uc,ua,
ur,mu,fm
)
end
function _update60()
rb(os)
end
function _draw()
cls()
an(os,"s",os)
end
function cq(e)
local ln=8+cos(e.ae/e.eb)*4-4
ib(ln)
camera(ln>1 and dq())
ep(108,e.a,e.o,4,2)
ib"0"
camera()
end