zclass[[person,actor,solid,simple_spr,drawlayer_50|
    text,,rx,.375,ry,.375,
    init,%person_init
]]

|[person_init]| function(a)
    _g.target(.5, .25, 0, 0, a,function()
        a.xf = a.x > g_pl.x

        if a.xf ~= g_pl.xf then
            if not a.stat then a.stat = _g.stat(1, 119, a) end
            if btnp'4' and not does_entity_exist'tbox' then
                _g.tbox(a.text, function()
                    poke(MEM_IS_NAVY_HOME, 1)
                    load_room(%MEM_ROOM_IND, g_pl.x, g_pl.y, g_pl.xf)
                end)
            end
        end
    end, function()
        if a.stat then a.stat:load'ending' a.stat = nil end
    end)
end $$

zclass[[navyblock,person|
    x,@, y,@,
    sy,-2,
    cname,"navy",
    cspr,SPR_NAVY,
    sind,SPR_NAVY,
    text,"TEXT_NAVY_BLOCK"
|MEM_IS_NAVY_HOME|0
]]
