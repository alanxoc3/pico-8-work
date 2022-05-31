pb=split[[fm,gs,gu,ud,wg,yt,cr,yi,mj,uk,ww,ue,wu,ft,gn,cn,ut,wn,f_,ux,fy,mf,cf,gt,mi,gy,ma,gg,db,wm,cj,ca,fc,rr,me,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil]]
function mm()
local li,nt={},0x2000
local nl=function()
nt+=1
return@(nt-1)
end
while@nt ~=255 do
local m,rk=im[[ir;,;nb;,;hd;,;il,12,ic,10,color,0,music,0]],nl()
if rk>223 then m.il,m.ic=8,6 end
m.color=0x0f &@nt
m.music=(0xf0 & nl())>>>4
local ew,nq,ay,ti,eu,eh,sx=0,true,m.ir,0,0,0
while ew ~=255 do
ew=nl()
if ew>=248 and ew<=253 then
sx,nq=nil
end
if ew==248 then nq=true ay=m.ir
elseif ew==249 then nq=true ay=m.nb
elseif ew==250 then eu=0 eh=0
elseif ew==251 then eu=.5 eh=0
elseif ew==252 then eu=0 eh=.5
elseif ew==253 then eu=.5 eh=.5
elseif ew==254 then sx=true
elseif ew<128 then ti=ew
elseif ew<255 then
local oq=0x7f & ew
if nq then
if sx then
ay[oq]=ti+128
else
local dt=0x7f & nl()
for st=oq\12,dt\12 do
for sa=oq%12,dt%12 do
ay[st*12+sa]=ti+128
end
end
end
else
add(m.hd,{ee=ti+1,a=oq%12+eu,o=oq\12+eh})
end
end
end
li[rk]=m
end
return li
end
sl,tl,nu={},{},{}
function i(ui)
local wy,fb,hj,gz=unpack(split(ui,"|"))
local on=split(wy)
local ep=deli(on,1)
tl[ep]=tl[ep]or{}
sl[ep]=function(to,od,...)
foreach(on,function(la)
if not od[la]then sl[la](to,od)end
end)
od[ep]=true
to.on[ep]=true
add(nu,{ep,to})
return hh(to,fb,...)
end
_g[ep]=function(...)if not hj or peek(hj)==gz then return sl[ep]({nm=ep,on={},rf={}},{},...)end end
end
function ms()
while #nu>0 do
local ep,to=unpack(deli(nu))
if not to.rf[ep]then add(tl[ep],to)end
end
end
function dh(to,...)
for ep,sm in pairs(tl)do
del(sm,to)
end
end
function un(table,dy,...)
if table and table[dy]then
return table[dy](...)
end
end
function ed(ws)
return #tl[ws]>0
end
function am(ep,cl,...)
for to in all(tl[ep])do
un(to,cl,to,...)
end
end
function md(...)
local hw,dg={},{}
foreach({...},function(mb)dg[mb]=true end)
for ep,sm in pairs(tl)do
for hf in all(sm)do
hw[hf]=hf.nm
end
end
for el,nm in pairs(hw)do
if not dg[nm]then
dh(el)
end
end
nu={}
end
function f()end
function lt(em,table,uj)
if ord(em)==37 then return _g[sub(em,2)]
elseif em=="~"then return table
elseif ord(em)==126 then return table[sub(em,2)]
elseif em=="@"then return deli(uj,1)
elseif em=="_"or em=="ez"then return em=="_"
elseif em=="dc"or em==""then return
elseif em=="f"then return f
end return em
end
function hh(table,af,...)
local nw,cs,oa={...},split(af,";"),table
foreach(cs,function(nv)
local op=split(nv)
if #op>1 then
if op[1]==""then
foreach(op,function(em)
add(oa,lt(em,table,nw))
end)
else
for u=1,#op,2 do
oa[op[u]]=lt(op[u+1],table,nw)
end
end
oa=table
else
if type(oa[nv])~="table"then
oa[nv]={}
end
oa=oa[nv]
end
end)
return table
end
function im(...)
return hh({},...)
end
_g=im([[co,@,wa,@,wt,@,uw,@,cy,@,us,@,pz,@,pw,@,ry,@,di,@,we,@,wc,@,mn,@,px,@,ck,@,mc,@,ps,@,fk,@,mu,@,ff,@,uu,@,ga,@,rm,@,sh,@,fz,@,gp,@,gw,@,sk,@,nd,@,nz,@,sv,@,u_,@,fx,@,ug,@,pu,@,ye,@,s_,@,pg,@,gj,@,cu,@,c_,@,gi,@,rv,@,cq,@,cw,@,uz,@,lw,@,sn,@,ce,@,gc,@,pp,@,ya,@,w_,@,fh,@,pl,@,m_,@,dq,@,pt,@,fo,@,pk,@,du,@,du,@,fd,@,wf,@,dp,@,py,@,gf,@,pr,@,hm,@,gx,@,uh,@,lz,@,pj,@,pe,@,fc,@,rr,@,wk,@,cm,@,fa,@,pa,@,fv,@,ci,@,fj,@,mz,@,go,@,wz,@,mp,@,cc,@,wo,@,mq,@,mk,@,uo,@,fn,@,sq,@,ml,@,cg,@,wr,@,fp,@]],function(e,rs)
if rs then
e.x,e.l=nil
for ua,mr in pairs(e[rs])do e[ua]=mr end
e.tx=rs
e:gv(e.tx,e.l,e.l and function()e:load(e.x)end)
else
e.al=false
end
end,function(e)
if e:na(e.tx)==nil then e:load(e.tx)end
if e:na(e.tx)==false then e:fq(e.tx)e:b()end
e:j()
end,function(e)
return not e:na"ea"and e.al
end,function(e)
if e.ea then
if e.tx=="k"then
e.x="ea"
elseif not e:na"ea"then
e:load"ea"
end
else
e.al=nil
end
end,function(e)if not e.al then e:oc()dh(e)end end,function(e)
e.ee+=1
e.ee%=60
end,function(e)
rb(e.wx,function()e:th()end)
e:th()
end,function(...)
_g.ry(...)
_g.di(...)
end,function(e,e_,l,sj)
e.tq[e_]={tc=false,l=0+(l or 32767),sj=sj or function()end}
end,function(e,e_)
if e.tq[e_]and not e.tq[e_].tc then
e.tq[e_].tc=0
end
end,function(e,e_)
e.tq[e_]=nil
end,function(e,e_)
local q=e.tq[e_]
return q and(q.tc or false)
end,function(e,e_)
local q=e.tq[e_]
return q and min(1,(q.tc or 0)/q.l)
end,function(e,e_)
local q=e.tq[e_]
return q and q.tc and q.tc<q.l
end,function(e)
local rx={}
for ae,q in pairs(e.tq)do
if q.tc and q.tc<=q.l then
q.tc=q.tc+1/60
if q.tc>=q.l then
add(rx,q)
end
end
end
foreach(rx,function(q)
q.sj(e)
end)
end,function(e,w)
return not e:ox(w)and not e:sf(w)
end,function(e,w)
local eb,tj,ie,id=e:ij(w)
return eb<=-1-ie or eb>=1+ie or tj<=-1-id or tj>=1+id
end,function(e,w)
local eb,tj,ie,id=e:ij(w)
return eb>-1+ie and eb<1-ie and tj>-1+id and tj<1-id
end,function(e,w)
return(e.a-w.a)/w.r,(e.o-w.o)/w.h,e.r/w.r,e.h/w.h
end,function(e,w)
local eb,tj=e:ij(w)
if abs(tj)>abs(eb)
then return 0,sgn(tj)
else return sgn(eb),0 end
end,function(e,w,c,g)
local te,tk=e:ig(w)
local eb,tj=e:ij(w)
if not e:ox(w)then
if te ~=0 and ny(c)==-te then
c=nh(c,e.a,e.r,w.a,w.r)
elseif tk ~=0 and ny(g)==-tk then
g=nh(g,e.o,e.h,w.o,w.h)
elseif tk ~=0 then
c=nh(c,e.a,e.r,w.a,w.r)
elseif te ~=0 then
g=nh(g,e.o,e.h,w.o,w.h)
end
end
return c,g
end,function(e,a,o)
local c,g=a-e.a,o-e.o
local lb,rj=c>>31,g>>31
local si,ro=(c+lb)^^lb,(g+rj)^^rj
if si>ro then
return si*0.9609+ro*0.3984
end
return ro*0.9609+si*0.3984
end,function(e)
e.a+=e.c
e.o+=e.g
end,function(e)
local dv,hr=e.ev*cos(e.tm),e.ev*sin(e.tm)
e.c+=dv e.g+=hr
e.c*=.80 e.g*=.80
if dv==0 and abs(e.c)<.01 then e.c=0 end
if hr==0 and abs(e.g)<.01 then e.g=0 end
end,function(e,a,o)
e.tm=atan2(a-e.a,o-e.o)
end,function(e)
for u=0,e.su-1 do
up(e.a+sin(e:td"k"/2)*cos(u/e.su+.125),e.o+sin(e:td"k"/2)*sin(u/e.su+.125),u%e.hc*.125+.125,u%e.hc*.125+.125,1)
end
end,function(e)
_g.ni(e.a,e.o,4,1,f)
end,function(e,w)
local ef={a=w.a-e.c,o=w.o-e.g,r=w.r,h=w.h}
return e:ds(ef,e.c,e.g)
end,function(e,nc)
foreach(nc,function(w)
local ef={a=w.a-e.c,o=w.o-e.g,r=w.r,h=w.h}
e.c,e.g=e:ds(ef,e.c,e.g)
end)
end,function(e,m)
for ok=max(flr(e.a-e.r)-1,0),min(ceil(e.a+e.r),12-1)do
for ow=flr(e.o-e.h)-1,ceil(e.o+e.h)do
local s=ct(m,ow*12+ok)
if s then
local r,h=.5,.5
if not fget(s,1)or fget(s,1)and e.dx then
if fget(s,2)then r,h=.375,.375 end
e.c,e.g=e:sk{a=ok+.5,o=ow+.5,r=r,h=h}
end
end
end
end
end,function(e)
if e.lx then
local ef={a=ai.a-e.c,o=ai.o-e.g,r=ai.r,h=ai.h}
e.c=lu(e.c,e.a,e.r,ef.a,ef.r)
e.g=lu(e.g,e.o,e.h,ef.o,ef.h)
end
end,function(e,wi)
e.aj=max(0,min((e.aj or e.aa)-wi,e.aa))
end,function(e)
e.aj=e.aj or e.aa
e.ne=e.ne or e.aj/e.aa
local o_=e.aj/e.aa-e.ne
e.ne+=ny(o_)*min(abs(o_),.05)
if e.aj<=0 then e:iu()end
end,function(e)
e.stat=peek"0x5d08" ~=4 and{ey=e[peek"0x5d08"+1].s}
end,function(e)
d_:ot(e.stat)
if not ed"ts"and not ed"tb"and not ed"nr"and btn"5"then
poke(0x5d08,9)
e.ti=4
e:load"le"
end
end,function(e)
e.ti=mid(0,2,e.ti%3+iz(btnp,0))+mid(0,2,e.ti\3+iz(btnp,2))*3
if ed"ts"or ed"tb"or not btn"5"then
poke(0x5d08,peek(e[e.ti+1].tu)~=0 and e.ti or 4)
e:load"sw"
end
end,function(e)
local tp=e.tx=="sw"and(1-e:td"sw")or e:td"le"
ln(e.at.a*8,e.at.o*8-2,tp*8,tp*8,1)
for p in all(e)do
local rc=peek(p.tu)~=0
local s=rc and p.s or 0
local tt,tr=rc and p.tt or 0,rc and p.tr or 0
local oj=function()
tf(s,tt+e.at.a*8+p.tw*tp,tr+e.at.o*8+p.tg*tp,1,1,p.wq and e.at.d)
end
rb(p.ee==e.ti and 2 or 1,oj)
oj()
end
end,function(e)
tf(e.s,e.a*8+e.oz,e.o*8+e.oo,e.as,e.t_,e.d,e.oh)
end,function(e)
e.eu+=e.iv e.eh+=e.oe
e.a,e.o=e.et.a+e.eu,e.et.o+e.eh
end,function(ab,uv)
foreach(uv,function(e)
if ab:ox(e)then
ab:gb(e)
else
ab:pv(e)
end
end)
end,function(e)
ld(e.a,e.o,e.c,0,3)
pset(e.a*8,e.o*8,12)
end,function(e)
_g.sn(e)
_g.fw(e.a,e.o-.125,e.d*.25,e.d)
end,function(e)
e.et.c-=e.da*e.d
end,function(e)
sfx(5,0)
sfx(6,1)
sfx(7,2)
end,function(e)
sfx(5,-2)
sfx(6,-2)
sfx(7,-2)
if(aq:hb()or{}).nm=="db"and e:td"rl"and e:td"rl">=1 then
eo(poke,[[1;,0x5d02,@;2;,0x5d03,@;3;,0x5d04,@;]],e.et.a*16,
e.et.o*16,
(e.et.d+1)\2
)
memcpy(0x5e00,0x5d00,64)
_g.tb("great banjo playing.^saving complete!",f)
end
end,function(e)e.iv=e.d*e.az end,function(e)e.eu=abs(e.eu*8)\1/8*sgn(e.eu)end,function(e)e:ge()e.iv=-e.d*e.az end,function(e)
tf(e.s,e.a*8+e.oz,e.o*8+e.oo,1,1,cos(sd/5),sin(sd/5))
end,function(e)
e.a,e.o=e.et.a,e.et.o
e.tm=atan2(e.d,0)
end,function(e)
e.ev=0
if ik|ix ~=0 then
e.tm,e.ev=atan2(ik,ix),.0375
end
end,function(e)
e.lq,e.hi=e.a,e.o
end,function(e)
local tp=e:td"ea"
e.a=e.lq+(e.et.a-e.lq)*tp
e.o=e.hi+(e.et.o-e.hi)*tp
end,function(e)
e.a,e.o=e.et.a+e.d,e.et.o
e.c=e.c+e.d*.125
end,function(e)
_g.ni(e.a,e.o,8,2,f)
end,function(e)
e.r+=.05
e.h+=.05
end,function(e)
uf:ot(e)
local p=e.p
if not p.al then p=e.lf end
if btn(5)or ed"tb"or ed"ts"or e.ob or not btn"4"then
p:iu()
elseif not e.ob and p.uq and btn"4"then
local lk=e.um[peek"0x5d08"]
if lk then
p=lk(e,e.d)
e.oi+=p.tz
end
end
e.ev=0
if not e:sf(ai)then
e.tm,e.ev=atan2(e:ig(ai)),.025
elseif not ed"ts"and not ed"tb"and not btn(5)then
if ik|ix ~=0 then
e.tm,e.ev=atan2(ik,ix),.025*p.ao
if not p.ad and cos(e.tm)~=0 then
e.d=sgn(cos(e.tm))
end
end
end
e.oi=max(0,e.oi+p.ac)
if e.oi==0 then e.ob=false
elseif e.oi>=1 then e.ob=true
end
local o_=e.oi-e.sg
e.sg+=ny(o_)*min(abs(o_),.03125)
e.p,e.s=p,e.c|e.g ~=0 and 88+t()*12%3 or 88
end,function(e)
local d=e.d
local lj=91
if ed"nr"then
lj=92
end
tf(e.s,e.a*8,e.o*8-2,1,1,d)
tf(lj,e.a*8,e.o*8-2,1,1,d)
if e.p.an then
tf(e.p.s,e.p.a*8,e.p.o*8-2,1,1,d)
end
end,function(e)
local os=e.os
e.os={}
local fl,lp=e.stat and e.stat.el,os[1]
for el in all(os)do
if fl==el then return end
end
if ed"tb"then return end
if e.stat then e.stat:load"ea" end
e.stat=lp and _g.stat(e.es,e.a,lp)
end,function(e,ch)
add(e.os,ch)
end,function(e)
return e.stat and e.stat.el
end,function(e)
return e.stat and e.stat.el
end,function(e)
local el=e.el
if es ~=0 then
sy(e.a+2,e.o,function()
local i_=-8*e.es-1
if el.ex then ax(el.ex,i_,-10,e.es,7,5)end
if el.on and el.on.nn then
hp(i_,-2,i_-35*e.es,1,el.ne,-1,11,3)
ax(flr(el.aj).."/"..el.aa,i_,4,e.es,7,5)
end
end)
end
ng(e.a,e.o+(ed"tb"and 0 or-cos(au/4)*e.es),6,8,2,4,function()
spr(el.ey,0,0,1,1,e.es>0)
end,f)
end,function(e)
e.so=split(e.fs,"^")
end,function(e)
local rg=e.so[e.no]
local rz=e.so[e.no+1]or ""
local nk=#rg+#rz+4
e.rq=sub(rg,1,e.ta)
e.ht=sub(rz,1,max(0,e.ta-#rg))
if e.ta==nk then
e.od=true
end
if btnp(4)or btnp(5)then
if e.ta==nk then
if e.no+2>#e.so then
e:load"ea"
else
e.no+=2
e:load"eq"
end
else
e.ta=nk
end
end
e.ta=min(nk,e.ta+.5)
end,function(e)
ng(65,e.o,46.5,10,2.5,5,
function()
eo(ax,[[1;,@,0,-2,-1,7,5;2;,@,0,6,-1,7,5;]],e.rq or "",e.ht or "")
end,function()
if e.od then
tf(38,44,16+au%2)
end
end)
end,function(e)
local ho=aq:hb()or z
local eu,eh=ho.a+(t()\10%2==0 and 1 or-1)*cos(t()*.75),ho.o+sin(t()*.75)-.25
e:uc(eu,eh)
e.ev=e:dj(eu,eh)*.013
end,function(e)
ld(e.a,e.o,e.c,e.g,6)
cv(e.a,e.o,13)
end,function(e)
de(_g.pc,e.ov)
end,function(e)
_g.hm(e)
eo(_g.ab,[[1;,.125,.375,0,.5,@,@,f;]],e,function()
eo(poke,[[1;,0x5d05,@;2;,0x5d06,@;3;,0x5d07,@;]],peek"0x5d01",
e.a*16,
(e.o+1.5)*16
)
ol(e.m,4,5,z.d)
end)
end,function(e)
local te=e:ig(z)
e.d=sgn(z.a-e.a)
return peek"0x5d08" ~=4 or te==-z.d
end,function(e)
poke(e.lc,e.hv)
ol(%0x5d01,z.a,z.o,z.d)
end,function(e)
_g.ab(e.ru,e.rw,e.ok,e.ow,e,function()
if not e:sc()then
aq:ot(e)
if btnp"4"and not ed"tb"then
_g.tb(e.ei,function()
e:ra()
end)
end
end
end,f)
end,function(e)
return peek"0x5d08" ~=4
end,function(a,o)
_g.ni(a,o,4,1,function()_g.hg(a,o)end)
end,function(a,o)
_g.ni(a,o,4,1,function()_g.ur(a,o)end)
end,function(e)
_g.rr(e.a,e.o-.5)
_g.rr(e.a,e.o+.5)
end,function(e)
if e.ia then aq:ot(e)end
e.d=sgn(z.a-e.a)
e.pm=atan2(z.a-e.a,z.o-e.o)
end,function(e)
if e.ia then aq:ot(e)end
e.oz=dk()
end,function(e)
if e.ia then aq:ot(e)end
e.tm=e.pm
e.oo=sin(e:td"l_"/2)*8
end,function(e,p_)
foreach(p_,function(p)
if not e:ox(p)and p:wh()then
e:r_("ia",1.5,function()e.ia=false end)
e.ia=true
if not e:cb"mo"then
e:r_("mo",p.ii,f)
e:gh(p.ih)
end
p:ip()
if p.iy then
e.c+=p.av*p.d
else
local te,tk=e:ig(p)
e.c+=p.av*te
e.g+=p.av*tk
end
end
end)
end,function(e)
if not e:ox(z)then
aq:ot(e)
end
end,function(e)
poke(0x5f43,0xff)
it=e:td"k"
end,function(e)
it=1-e:td"k"
end,function()sfx(63,0)end,function(e)
it=cos(e:td"cz")+1
camera(it>.5 and dk())
tf(108,64,64,4,2)
camera()
end,function(e)
_g.rp(function()rh:load"m" end)
end,function(ec)
_g.wp()
ec.hl,ec.wd=unpack(dr(im[[1;,32,quack quack;2;,68,and play with me;3;,9,to save hi-roll;4;,81,in time for dinner;5;,83,and make me rich;6;,96,the banjo awaits you;7;,99,for your fans;8;,118,splat splat boing;]]))
end,function(ec)
local oj=function()
tf(ec.hl,0,au%2,1,1,true,false,1)
end
eo(ax,[[1;,come back lank,64,38,0,10,4,1;2;,@,64,69,0,7,5,1;]],ec.wd)
ng(64,56+au%2,6,8,2,4,function()
spr(ec.hl,0,0)
end,f)
end,function(ec)
local aw=of[peek"0x5d01"]
local sp=flr(aw.music/2)*8+(aw.music%2)*5
poke(0x5f43,0)
if gk ~=sp then
gk=sp
music(sp,0,7)
end
ai=_g.ul(aw.il/2,aw.ic/2,aw.il/2-.375,aw.ic/2-.375)
z=_g.at(peek"0x5d02"/16,peek"0x5d03"/16,peek"0x5d04"*2-1)
yd=_g.ub(z.a,z.o-.125)
uf,d_,aq=_g.nf(-1,10),_g.nf(0,64),_g.nf(1,118)
_g.mt(z)
foreach(aw.hd,function(re)
_g[pb[re.ee]](re.a+.5,re.o+.5)
end)
end,function(ec)
eo(am,[[1;,q,se;2;,y,ec;3;,io,sh;4;,oy,nd,@;5;,oy,nz,@;6;,oy,sv;7;,ar,rm;8;,hg,wv,@;9;,ou,fr;10;,ab,uy,@;11;,nf,j;12;,nn,gm;]],tl.ty,of[peek"0x5d01"],tl.og,tl.at)
if not ed"ts"and not z:sf(ai)then
local te,tk=z:ig(ai)
local rd=peek"0x5d01"+tk*16+te
if peek"0x5d01">223 then
ol(peek"0x5d05",peek"0x5d06"/16,peek"0x5d07"/16,z.d)
elseif of[rd]then
if te ~=0 then ol(rd,6-te*6+1.25*te,z.o,te)
else ol(rd,z.a,5-tk*5+1.25*tk+.25,z.d)
end
else
eo(ol,[[1;,151,6,5,@;]],z.d)
end
end
end,function(ec)
wb(tl["en"])
ly(of[peek"0x5d01"],64,57,function()
eo(am,[[1;,iq,v;2;,en,v;3;,pi,v;]])
end,function()
eo(am,[[1;,hk,v;2;,hy,v;3;,ib,v;]])
end)
eo(hp,[[1;,18,6,109,11,@,0,@,@]],z.sg,z.ob and 13 or 8,z.ob and 1 or 2)
end,function()
_g.g_()
end,function()
if ed"ts"then return end
eo(am,[[1;,q,se;2;,y,ec;]])
end,function()
ly(of[136],64,57,f,f)
eo(am,[[1;,ib,v;]])
eo(ax,[[1;,code/sfx:  @alanxoc3  ,64,104,0,7,5;2;,tile/spr:  @greatcadet,64,114,0,7,5;3;,amorg games presents,64,6,0,7,5;]])
end,function(e)
if btnp"4"or btnp"5"then
_g.rp(function()rh:load"m" end)
end
end,function(e)
for u=-2,2 do
tf(45+u,u*10+64,57+cos((au+u)/4)/2,1,2)
end
eo(ax,[[1;,not the story of,64,39,0,10,4;]])
if au%2==0 then
eo(ax,[[1;,🅾️ or ❎ to play  ,64,68,0,7,5;]])
end
end,function(ec)
md"is"
_g.po()
gl=_g.lv".5"
fi=_g.lv".05"
ec:np()
end)
function dr(nc)return nc[mv(#nc)+1]end
function dk(em)return dr{-1,0,1}end
function mv(a)return flr(rnd(a))end
function iz(ns,e)return ns(e)and ns(e+1)and 0 or ns(e)and-1 or ns(e+1)and 1 or 0 end
function tf(s,a,o,as,t_,d,oh)
as,t_=as or 1,t_ or 1
d,oh=d and d<0,oh and oh<0
a,o=a-as*4,o-t_*4
spr(s,flr(a+.5),flr(o+.5),as,t_,d,oh)
end
function sy(a,o,tv)
camera(-a,-o)tv()camera()
end
function dl(af,a,o,es,color)
if es==0 then a-=#af*2
elseif es>0 then a-=#af*4+1 end
print(af,a,o,color)
end
function ax(af,a,o,es,sz,rn)
dl(af,a,o+1,es,rn)
dl(af,a,o,es,sz)
end
function de(tv,n_)
foreach(n_,function(nw)
tv(unpack(nw))
end)
end
function eo(tv,ei,...)
de(tv,im(ei,...))
end
function ln(a,o,r,h,color)rect(a-r,o-h,a+r-1,o+h-1,color)end
function pd(a,o,r,h,color)rectfill(a-r,o-h,a+r-1,o+h-1,color)end
function rt(tv,er,ek,ej,tn,color)tv(8*er,8*ek,8*ej,8*tn,color)end
function up(...)rt(ln,...)end
function ys(...)rt(pd,...)end
function pq(...)rt(line,...)end
function cv(a,o,color)pset(8*a,8*o,color)end
i[[y,q|load,%co,ec,%wa,iu,%uw,hs,%cy,wh,%wt,al,_,l,dc,tx,k,x,dc,b,f,j,f,oc,f;]]
i[[iq|]]
i[[en|]]
i[[pi|]]
i[[hk|]]
i[[hy|]]
i[[ib|]]
i[[lv,y|ee,0,b,%us;k;l,@,x,k]]
i[[sb|v,%pz,wx,1]]
function rb(color,oj)
for a_=1,15 do pal(a_,color)end
local lm,hz=%0x5f28,%0x5f2a
for o=-1,1 do for a=-1,1 do
camera(lm+a,hz+o)oj()
end end
camera(lm,hz)
pal()
end
function wb(t)
for n=2,#t do
local u=n
while u>1 and t[u].o<t[u-1].o do
t[u],t[u-1]=t[u-1],t[u]
u=u-1
end
end
end
i[[q|tq;,;r_,%pw,gv,%ry,fq,%di,cb,%px,yu,%we,na,%wc,td,%mn,se,%ck,]]
function gr(m,tv)
for pn in all{m.ir,m.nb}do
for he,ee in pairs(pn)do
local a,o=he%12,he\12
tv(mg(ee),a*8,o*8)
end
end
end
function ly(m,lr,lg,dz,ri)
local er,ek=lr-m.il*8\2,lg-m.ic*8\2
ng(lr,lg,m.il*4-2,m.ic*4-2,-2,-2,function()
rectfill(0,0,127,127,m.color)
gr(m,spr)
dz(er,ek)
end,ri)
end
function gq(m)
local dn={}
for ay in all{m.ir,m.nb}do
for a=0,11 do
local n_={}
for o=0,9 do add(n_,ay[o*12+a])end
dn[ay[a]or 0]=n_
end
end
return dn
end
function mg(s)
local ta=mx[s]
return ta and ta[au%#ta+1]or s
end
i[[ef,nj|r,0,h,0,yr,%mc,sf,%fk,ox,%ps,ij,%mu,ig,%ff,ds,%uu]]
function ny(hn)
return hn==0 and 0 or sgn(hn)
end
function nh(c,a,r,iw,ag)
local eb=(a-iw)/ag
return abs(eb)-r/ag<1 and iw+sgn(eb)*(r+ag)-(a-c)or c
end
i[[nj|a,0,o,0,dj,%ga]]
i[[ar,nj|c,0,g,0,rm,%rm]]
i[[io,ar|tm,0,ev,0,sh,%sh,uc,%fz]]
i[[ni,y,en|a,@,o,@,su,@,hc,@,oc,@,v,%gp;k;l,.25;]]
function ct(m,ee)
local om=m.nb[ee]
if om then return fget(om,0)and om end
om=m.ir[ee]
return fget(om,0)and om
end
i[[oy,ef,ar|sk,%sk,dx,_,lx,_,nd,%nd,nz,%nz,sv,%sv]]
function lu(c,a,r,iw,ag)
local eb=(a-iw)/ag
if abs(eb)+r/ag>1 then
return iw+sgn(eb)*(ag-r)-(a-c)
else
return c
end
end
i[[nn|aa,1,gh,%u_,gm,%fx]]
i[[mt,y,hk|at,@,ti,4;k;b,%ug,j,%pu,v,f;gd;b,f,j,%ye,v,%s_;le;b,f,j,f,v,%s_,l,.0625,x,gd;sw;b,f,j,f,v,%s_,l,.0625,x,k;1;tu,0x5d12,ee,0,ae,dw,tt,-1,tr,1,tw,-7,tg,-9,s,5;2;tu,0x5d10,ee,1,ae,yn,tt,0,tr,-1,tw,0,tg,-10,s,8;3;tu,0x5d15,ee,2,ae,hu,tt,1,tr,1,tw,7,tg,-9,s,3;4;tu,0x5d13,ee,3,ae,dd,tt,0,tr,0,tw,-8,tg,-2,s,6;5;tu,0x5dff,tt,0,tr,0,tw,0,tg,0,s,0;6;tu,0x5d16,ee,5,ae,lh,tt,1,tr,0,tw,8,tg,-2,s,2;7;tu,0x5d17,ee,6,ae,nr,tt,1,tr,0,tw,-7,tg,5,s,1;8;tu,0x5d11,ee,7,ae,ll,tt,1,tr,1,tw,0,tg,6,s,4;9;tu,0x5d14,ee,8,ae,lo,tt,0,tr,0,tw,7,tg,5,s,7;10;tu,0x5d00,ee,4,tt,0,tr,-2,tw,0,tg,0,s,103,wq,ym;]]
i[[ty,ef|]]
i[[pc,ty,ou|et,@,eu,@,eh,@,r,@,h,@]]
i[[eg,sb,nj|th,%pg,s,0,as,1,t_,1,d,1,oh,1,oz,0,oo,0]]
i[[ou,nj|fr,%gj;eu,0,eh,0,iv,0,oe,0,et;,]]
i[[ab,ou,ef|r,@,h,@,eu,@,eh,@,et,@,pv,@,gb,@,uy,%cu]]
i[[og,ef|]]
i[[sr,ou|az,0,ge,%lw;k;b,%uz,l,.08,x,eq;eq;b,%lw,iv,0;ea;b,%sn,l,.08;]]
i[[hu,ou,y|et,@,d,@,an,_,ad,ez,ao,2,tz,.125,ac,.0078125,eh,.2,s,3;k;oe,-.0625,l,.08,x,eq;eq;eh,-.125,oe,0;ea;oe,.0625,l,.08;]]
i[[lo,sr,y|et,@,d,@,an,_,ad,_,ao,.5,tz,.25,ac,0,az,.105,s,7;ea;b,%sn,l,.08;ea;b,%gi,l,.08;]]
i[[fw,ar,y,en,og|a,@,o,@,c,@,d,@,ih,1,ii,.125,av,.375,iy,_,ip,~iu,r,.375,h,.125,oc,%gw,v,%c_;k;l,.5;]]
i[[dd,sr,y,og|et,@,d,@,r,.25,h,.5,ih,0,ii,2,av,.25,iy,_,ip,%rv,da,.125,an,_,ad,_,ao,.5,tz,.125,ac,0,az,.105,s,6;]]
i[[lh,sr,y,og|et,@,d,@,r,.375,h,.25,ih,2,ii,.25,av,.125,iy,_,ip,%rv,da,.25,an,_,ad,_,ao,.5,tz,.25,ac,0,az,.125,s,2;]]
i[[nr,ou,y|et,@,d,@,an,_,ad,ez,ao,.5,tz,.125,ac,0,eh,-.05,s,1;k;b,%cq,oe,.0625,l,.08,x,rl;rl;b,f,oe,0,l,2,x,eq;eq;b,f,eh,.25,x,ea;ea;b,%cw,oe,-.0625,l,.08;]]
i[[ll,oy,eg,en,io,y,og|et,@,d,@,r,.25,h,.25,ih,0,ii,.25,av,.25,iy,ez,ip,~iu,an,ez,ad,_,ao,.25,tz,.25,ac,0,dx,ez,az,.125,th,%ce,s,4;k;b,%gc,ev,.075,l,.125,x,eq;eq;b,f,ev,0,l,1.5,j,%pp,x,ea;ea;b,%ya,ev,0,ev,0,j,%w_,l,.125,nd,f,nz,f;yc;b,f,j,f,al,ez;]]
i[[dw,y,ar,eg,en,og|et,@,d,@,s,5,oo,-2,ih,1,ii,5,av,.25,iy,_,ip,f,an,ez,ad,ez,ao,1,tz,.25,ac,0,az,.185;k;b,%fh,g,.08,l,.08,x,eq;eq;b,f,l,.5,c,0,g,0,x,cx;cx;b,%pl,j,%m_,l,.25,x,ea,v,f;ea;b,f,al,ez;]]
i[[at,y,io,oy,sb,nn,en|ex,lank,ey,103,aa,10,a,@,o,@,d,@,s,88,r,.375,h,.375,lx,ez,j,%dq,sg,0,ob,ez,oi,0,th,%pt;um;5,%lh,2,%hu,8,%lo,3,%dd,0,%dw,6,%nr,7,%ll;lf;an,ez,uq,_,ad,ez,ao,1,al,_,ac,-.0078125,tz,0,iu,f;p,~lf;]]
function hp(er,ek,ej,tn,tp,es,sz,rn)
if er>ej then er-=3 ej-=3 end
local ss=ej-er-min(tp,1)*(ej-er)
if es==0 then ss/=2 end
if tp>0 then
local sa=ceil(er+(es>=0 and ss or 0))
local st=flr(ej-(es<=0 and ss or 0))
rectfill(er,ek,er,tn,13)
rectfill(ej,ek,ej,tn,13)
rectfill(sa,ek,st,tn,sz)
rectfill(sa,tn,st,tn,rn)
end
end
function ng(a,o,r,h,mw,wl,ph,ri)
local er,ej,ek,tn=a-r,a+r-1,o-h,o+h-1
local dm,h_=er+mw,ek+wl
clip(er,ek,ej-er,tn-ek)
rectfill(-100,-100,9000,9000,1)
sy(dm,h_,ph)
clip()
for u,a_ in pairs{1,13,0}do
u=2-u
color(a_)
if a_ ~=0 then rect(er+u,ek+u,ej-u,tn-u)end
u+=1
pset(er+u,ek+u)pset(er+u,tn-u)
pset(ej-u,ek+u)pset(ej-u,tn-u)
end
sy(dm,h_,ri)
end
i[[nf|es,@,a,@,j,%fo,ot,%pk,hb,%du;os;,;]]
i[[stat,ar,y,hy|es,@,a,@,el,@,o,138,v,%fd;k;g,-2,l,.2,x,eq;eq;g,0;ea;g,2,l,.2;]]
i[[tb,ar,y,ib|fs,@,oc,@,o,138,no,1,ta,0,rq,,ht,,j,%dp,v,%py;so;,;k;g,-2,l,.2,x,eq,j,f,b,%wf;eq;g,0,ta,0,od,ez,j,%dp,b,f;ea;g,2,j,f,l,.2,b,f;]]
i[[ub,y,io,en|a,@,o,@,j,%gf,v,%pr]]
function ld(a,o,c,g,hx)
for u=-2,2 do
local hq=.125*sgn(u)
pq(a+abs(u)\2*hq,o+u%2*hq,a-c*hx,o-g*hx,1)
end
end
i[[wm,ty,en,eg|a,@,o,@,r,.375,h,.375,v,~th,s,16]]
i[[cj,ty,en,eg|a,@,o,@,r,.375,h,.375,v,~th,s,17]]
i[[ca,ty,en,eg|a,@,o,@,r,.375,h,.375,v,~th,s,18]]
i[[gu,ty,en,eg|a,@,o,@,r,.375,h,.375,v,~th,s,49]]
i[[me,ty,en,eg|a,@,o,@,r,.375,h,.375,v,~th,s,35]]
i[[gs,y,eg,en|a,@,o,@,s,55,b,%hm;ov;1;,~,-.25,.25,.25,.25;ov;2;,~,.25,.25,.25,.25;]]
i[[fm,eg,iq|a,@,o,@,s,39]]
i[[ak,y,eg,en|ey,174,s,174,as,2,t_,2,b,%gx;ov;1;,~,.75,.5,.25,.75;ov;2;,~,-.75,.5,.25,.75;ov;3;,~,0,0,.75,.25;]]
i[[ud,ak|a,@,o,@,m,231]]
i[[ue,ak|a,@,o,@,m,224]]
i[[wu,ak|a,@,o,@,m,225]]
i[[ft,ak|a,@,o,@,m,226]]
i[[gn,ak|a,@,o,@,m,227]]
i[[cn,ak|a,@,o,@,m,228]]
i[[ut,ak|a,@,o,@,m,229]]
i[[ah,df,ty,eg,en|ei,,r,.375,h,.375,oo,-2,ru,.5,rw,.25,ow,.25,sc,%uh]]
i[[wg,ah|a,@,o,@,ex,navy,ey,97,s,97,ei,my sister has been in^the forest all day.^find something to^protect yourself with^and bring her home.,h,1,lc,0x5d09,hv,1,ra,%lz|0x5d09|0]]
i[[wn,ah|a,@,o,@,ex,navy,ey,97,s,97,ei,im navy in a house|0x5d09|1]]
i[[f_,ah|a,@,o,@,ex,bob,ey,80,s,80,ei,im bob outside,h,1,lc,0x5d18,hv,1,ra,%lz|0x5d18|0]]
i[[ux,ah|a,@,o,@,ex,bob,ey,80,s,80,ei,im bob in a house|0x5d18|1]]
i[[cf,ah|a,@,o,@,ex,jane,ey,81,s,81,ei,im jane in a house]]
i[[mf,ah|a,@,o,@,ex,teach,ey,96,s,96,ei,im teach in a house]]
i[[fy,ah|a,@,o,@,ex,keep,ey,83,s,83,ei,im keep in a house]]
i[[gt,ah|a,@,o,@,ex,lark,ey,99,s,99,ei,im lark in a house]]
i[[df,y|b,%pj,ru,0,rw,0,ok,0,ow,0,sc,f,ra,f]]
i[[ap,df,ty,eg,en|ei,,r,.375,h,.375,oo,-2,sc,%pe,ex,sign,ey,24,s,24,ru,.125,rw,.375,ok,0,ow,.25]]
i[[yl,ap|a,@,o,@,ei,mary had a^little lamb^little lamb^little lamb^mary had a^little lamb^whose fleece was^white as yo face]]
i[[yt,ap|a,@,o,@,ei,lanks house]]
i[[cr,ap|a,@,o,@,ei,keeps house]]
i[[yi,ap|a,@,o,@,ei,navys house]]
i[[mj,ap|a,@,o,@,ei,teachs house]]
i[[uk,ap|a,@,o,@,ei,larks house]]
i[[ww,ap|a,@,o,@,ei,janes house]]
i[[hg,ef,io,eg,en,oy,nn,y|a,@,o,@,r,.375,h,.375,ey,118,ex,slimy,s,118,oc,%wk,wv,%fv,aa,5;k;s,118,ev,0,oz,0,oo,0,j,%cm,l,1,x,fg;fg;ev,0,j,%fa,l,.25,x,l_;l_;s,119,ev,.05,oz,0,j,%pa,l,.25,x,k;]]
i[[ur,eg,ar,en,y|a,@,o,@,ey,116,ex,miny,s,116]]
i[[nx,eg,y,iq|s,52,v,~th;k;x,ha;ha;s,52,l,.5,x,pf;pf;s,53,l,.125,x,fu;fu;s,54,l,.25,x,fe;fe;s,53,l,.125,x,ha;]]
i[[mi,nx|a,@,o,@,d,1;k;l,0;]]
i[[gy,nx|a,@,o,@,d,1;k;l,.5;]]
i[[ma,nx|a,@,o,@,d,-1;k;l,0;]]
i[[gg,nx|a,@,o,@,d,-1;k;l,.5;]]
i[[db,ef,eg,y,iq|a,@,o,@,r,.375,h,.375,ex,save,ey,10,s,40,as,2,t_,2,v,~th,j,%ci;]]
it,cp=1,im[[0;,0,0,0,0,0,0,0,0;1;,1,1,1,1,0,0,0,0;2;,2,2,2,1,0,0,0,0;3;,3,3,3,3,1,1,0,0;4;,4,4,2,2,2,1,0,0;5;,5,5,5,1,0,0,0,0;6;,6,6,13,13,5,5,0,0;7;,7,7,6,13,13,5,0,0;8;,8,8,8,2,2,2,0,0;9;,9,9,4,4,4,5,0,0;10;,10,10,9,4,4,5,0,0;11;,11,11,3,3,3,3,0,0;12;,12,12,12,3,1,0,0,0;13;,13,13,5,5,1,0,0,0;14;,14,14,13,4,2,2,0,0;15;,15,15,13,13,5,5,0,0;]]
function yo(my)
for a_=0,15 do
pal(a_,cp[a_][1+flr(7*min(1,max(0,my)))],1)
end
end
i[[ts,y|rf;y,_,q,_;]]
i[[rp,ts|k;l,.5,oc,@,j,%fj]]
i[[po,ts|k;l,.5,j,%mz]]
i[[wp,y|k;l,.75,x,ea;ea;b,%mp;]]
i[[ul,ef|a,@,o,@,r,@,h,@]]
function ol(mh,a,o,d)
if not ed"ts"then
_g.rp(function()
eo(poke,[[1;,0x5d01,@;2;,0x5d02,@;3;,0x5d03,@;4;,0x5d04,@;]],mh,
a*16,
o*16,
(d+1)\2
)
rh:load"m"
end)
end
end
i[[g_,y,sb,ib|j,%cg,th,%wr;]]
cartdata"zeldo_rewrite"
menuitem(1,"reset save data",function()
memset(0x5e00,0,64)
extcmd"reset"
end)
i[[is,y|rf;y,_,q,_;tx,m,b,%fp;cz;np,%go,j,%sq,v,%wz,l,2.5,x,wj;wj;np,%fn,j,%sq,v,%ml;m;np,%mq,j,%mk,v,%uo;yh;np,%cc,j,%sq,v,%wo;]]
function _init()
memcpy(0x5d00,0x5e00,64)
if peek"0x5d00"==0 then
eo(poke,[[1;,0x5d00,1;2;,0x5d01,136;3;,0x5d02,48;4;,0x5d03,48;5;,0x5d04,1;6;,0x5d08,4;7;,0x5d16,1;8;,0x5d15,1;10;,0x5d14,1;11;,0x5d13,1;12;,0x5d12,1;13;,0x5d17,1;14;,0x5d11,1;]])
end
au,sd,rh,of=0,0,_g.is(),mm()
mx=gq(of[0])
end
function _update60()
ik,ix=iz(btn,0),iz(btn,2)
eo(am,[[1;,y,hs;2;,ts,hs;]])
ms()
eo(am,[[1;,ts,se;2;,is,se;3;,ts,ec;4;,is,ec;]])
end
function _draw()
au,sd=gl.ee,fi.ee
cls()
am("is","v")
yo(it)
end