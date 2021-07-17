function _init()

end

function _update60()

end

function _draw()
    cls()
    for out=0, 1, 0.1 do
        for i=0,127,0.3 do
            pset(sin(i/128+out+t()/5)*64+64,i*2,1)
        end
    end

   local str1 = "thank you      "
   coolprint(str1,64-#str1*2+cos(t())*7,58+sin(t()/3)*20,10)

   local str4 = "          caleb"
   coolprint(str4,64-#str1*2+cos(t())*7,58+sin(t()/3)*20,(t()*5+1)%4+8)

   local str2 = "for reviewing my pr"
   coolprint(str2,64-#str2*2+cos(t())*5,70+sin(t()/3)*17,12)

    local str3 = "a pico-8 thank you from alan"
    coolprint(str3,64-#str3*2-cos(t())*5,100-sin(t()/3)*5,t()*5%4+8)
end

function coolprint(str, x, y, color)
    for i=-1,1 do
    for j=-1,1 do
        print(str, x + i, y + j, 1)
    end
    end
    print(str, x, y, color)
end
