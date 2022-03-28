-- zebra print
cls()::_::for i=-4,4do
x=rnd()
pset(-40+(t()/4)*128+cos(x)*32,64+i*9+cos(x)*sin(x)*32,(i+x*14+t()*8)%2+5)
end goto_
