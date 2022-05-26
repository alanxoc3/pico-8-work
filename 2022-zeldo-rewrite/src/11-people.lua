-- shared person/sign logic:
-- both have targets
-- both bring up a text box when interacted with

-- for people, the text is dependent on memory state
-- for people, when the text box finishes, something can be done

zclass[[person,target_with_tbox,solid,simple_spr,drawlayer_50|
    text,, rx,.375, ry,.375,
    trx,.5, try,.25,
    target_with_tbox_disable_callback,%person_target_with_tbox_disable_callback,
    target_with_tbox_finish_callback,%person_target_with_tbox_finish_callback;
]]

|[person_target_with_tbox_disable_callback]| function(a)
    a.xf = a.x > g_pl.x
    return a.xf == g_pl.xf
end $$

|[person_target_with_tbox_finish_callback]| function(a)
    poke(MEM_IS_NAVY_HOME, 1)
    load_room(%MEM_ROOM_IND, g_pl.x, g_pl.y, g_pl.xf)
end $$

-- _g.target(.5, .25, 0, 0, a,function()
--         a.xf = a.x > g_pl.x
-- 
--         if a.xf ~= g_pl.xf then
--             if not a.stat then a.stat = _g.stat(1, 119, a) end
--             if btnp'4' and not does_entity_exist'tbox' then
--                 _g.tbox(a.text, function()
--                     poke(MEM_IS_NAVY_HOME, 1)
--                     load_room(%MEM_ROOM_IND, g_pl.x, g_pl.y, g_pl.xf)
--                 end)
--             end
--         end
--     end, function()
--         if a.stat then a.stat:load'ending' a.stat = nil end
--     end)
-- end $$

zclass[[navyblock,person|
    x,@, y,@,
    sy,-2,
    cname,"navy",
    cspr,SPR_NAVY,
    sind,SPR_NAVY,
    text,"TEXT_NAVY_BLOCK"
|MEM_IS_NAVY_HOME|0
]]
