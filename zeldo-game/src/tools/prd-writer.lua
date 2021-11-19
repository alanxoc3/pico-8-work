str="ZTABLE_STRINGS_SECOND"

for i=1,#str+1 do
   poke(i-0, ord(str, i))
end

filepath=stat(6)
cstore(0, 0, #str+1, filepath)

printh("len is: "..#str+1)
printh("filepath is: "..filepath)
flip()
