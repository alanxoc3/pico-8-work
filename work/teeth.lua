-- "Teeth". Colored teeth in a #pico8 #tweetcart.

b=0c=cos s=sin::_::x=rnd()y=rnd()if t()%7.5 < 1.5 then
pset(x*128,y*128,b)w=x
f=b+1+x*15\1else
for i=-1,1,2do
pset(64+s(w+x)*c(w+y)*64,64+i*16+i*s(y%.25+x%.25+.5)*64,f)end
b=x*6\1end
goto _
