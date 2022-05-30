|[slimy]| function(x, y)
    _g.explode(x, y, 4, 1, function() _g.slimy_actual(x, y) end)
end $$

|[miny]| function(x, y)
    _g.explode(x, y, 4, 1, function() _g.miny_actual(x, y) end)
end $$


zclass[[slimy_actual,simple_spr,drawlayer_50,actor|
    x,@, y,@,
    cspr,118, cname,"slimy", sind,118
]]

zclass[[miny_actual,simple_spr,drawlayer_50,actor|
    x,@, y,@,
    cspr,116, cname,"miny", sind,116
]]
