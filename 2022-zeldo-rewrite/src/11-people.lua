zclass[[person,actor,solid,simple_spr,drawlayer_50|
    text,,rx,.375,ry,.375,
    cspr,SPR_NAVY,
    init,%person_init
]]

|person_init| function(a)
    _g.target(.5, .25, 0, 0, a,function()
        a.xf = a.x > g_pl.x

        if a.xf ~= g_pl.xf then
            if not a.stat then a.stat = _g.stat(1, 119, a) end
            if btnp'4' and not does_entity_exist'tbox' then
                _g.tbox(a.text, function()
                    g_state:load'room'
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
    sind,SPR_NAVY,
    text,"TEXT_NAVY_BLOCK"
|MEM_IS_NAVY_HOME
]]
