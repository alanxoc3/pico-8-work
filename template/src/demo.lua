function _init()

end

function _update60()

end

function _draw()
   cls(1)
   local str = "amorg"
   print(str,64-#str*2+cos(t())*10,64+sin(t()/3)*20,8)
end

