zclass[[sign,actor,auto_outline,drawlayer_50,outlayer_50|
    x,@,y,@,
    cname,"sign",cspr,SPR_SIGN,
    health,10,max_health,10,
    init,%sign_init,
    draw,%sign_draw
]]

|sign_init| function(a)
    _g.stat(1, 119, a)
    _g.tbox(split"testing a sign,this must be a sign,how are you,this is just,a textbox system!,yeah")
end $$

|sign_draw| function(a)
    zspr(a.cspr, a.x*8, a.y*8)
end $$
