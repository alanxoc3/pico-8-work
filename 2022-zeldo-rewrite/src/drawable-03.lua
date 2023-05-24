-- start with drawlayer_50 and divide by 2 if something needs to go forward or backward
-- max = 99, min = 00
zclass[[drawlayer_25|]] -- spikes
zclass[[drawlayer_50|]] -- main game layer
zclass[[drawlayer_75|]] -- brang

zclass[[drawlayer_90|]] -- above the card, stat
zclass[[drawlayer_95|]] -- above the card, inventory
zclass[[drawlayer_99|]] -- above the card, title, textbox

-- just a common timer so animation syncs between everything
zclass[[animation,actor|
    index,0,
    init,%f_animation_init;

    start; duration,@, next,start
]]

|[f_animation_init]| function(a)
    a.index += 1
    a.index %= 60 -- smooth because divisible by 2,3,4,5,6
end $$

zclass[[auto_outline,timer|
    draw,%f_auto_outline_draw,
    outline_color,1
]]
|[f_auto_outline_draw]| function(a)
    local ox, oy = %0x5f28, %0x5f2a
    local injured = a:is_active'injured'
    local stunned = a:is_active'stunned'
    local yoff = ((does_entity_exist'banjo' and a.should_dance or stunned) and sin(g_fi/5) or 0) + sin(a:get_elapsed_percent'jumpanim'/2)*8+sin(a:get_elapsed_percent'stunned_jump'/2)*5+sin(a:get_elapsed_percent'injured'/2)*5
    local xoff = 0

    camera(ox-xoff, oy-yoff)
    f_draw_outline(1, function() a:drawout() end)
    if stunned then gray_fade(1) end
    if injured then red_fade(1) end
    a:drawout()
    pal()
    camera(ox, oy)
end $$

|[f_draw_outline]| function(color, drawfunc)
    for c=1,15 do pal(c,color) end
    -- cache the old camera coords and restore them
    local ox, oy = %0x5f28, %0x5f2a
    for y=-1,1 do for x=-1,1 do
        camera(ox+x, oy+y) drawfunc()
    end end
    camera(ox, oy)
    pal()
end $$

-- sort based on y position for some draw layers
function isorty(t)
    for n=2,#t do
        local i=n
        while i>1 and t[i].y<t[i-1].y do
            t[i],t[i-1]=t[i-1],t[i]
            i=i-1
        end
    end
end

-- for enemies, player, and people...
-- stunned: purple outline & shaking.
