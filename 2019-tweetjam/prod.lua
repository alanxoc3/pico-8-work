--twep
cartdata("twep")l,h,s,a=btn,rnd,0,{"웃",12,o=0,e=0}r={a}poke(12801,26)function _update60()c=dget(0)u=sin(t())*16
a.o+=(l(0)and-.5 or l(1)and.5 or 0)a.e+=(l(2)and-.5 or l(3)and.5 or 0)if t()%1==0 then
m=h(64)-32
add(r,{m<0 and"🐱",h(4)+8,o=m+a.o,e=h(64)-32+a.e})s=s+1
sfx"0"
end
for f=2,#r do
d=r[f]
d.o+=h(2)-1
d.e+=h(2)-1
if abs(a.o-d.o)<u
and abs(a.e-d.e)<u then
r={a}dset(0,s>c and s or c)s=0
break
end
end
cls()for i in all(r)do
circ(i.o-a.o+60,i.e-a.e+62,u/2,i[2])
?i[1]or"😐",i.o-a.o+57,i.e-a.e+60,i[2]
end
e="+"..s.."/"..c
?e,60-#e*2,9
end
