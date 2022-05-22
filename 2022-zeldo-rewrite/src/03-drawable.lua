-- start with drawlayer_50 and divide by 2 if something needs to go forward or backward
-- max = 99, min = 00
zclass[[drawlayer_50|]] -- pl
zclass[[drawlayer_70|]] -- fairy
zclass[[drawlayer_75|]] -- inventory

zclass[[drawlayer_99|]] -- above the card, title

zclass[[outlayer_50|]] -- cell shading
zclass[[outlayer_99|]] -- inventory

zclass[[fader_out,actor|
    start; duration,@, destroyed,@, update,%fader_out_update
]]

|fader_out_update| function(a)
    g_fade = a:get_elapsed_percent'state'
end $$

zclass[[fader_in,actor|
    start; duration,@, update,%fader_in_update
]]

|fader_in_update| function(a)
    g_fade = 1 - a:get_elapsed_percent'state'
end $$

-- just a common timer so animation syncs between everything
zclass[[animation,actor|
    index,0,
    init,%animation_init;

    start; duration,@, next,start
]]

|animation_init| function(a)
    a.index += 1
    a.index %= 60 -- smooth because divisible by 2,3,4,5,6
end $$

zclass[[auto_outline|drawout,%auto_outline_drawout]]
|auto_outline_drawout| function(a)
    draw_outline(1, function() a:draw() end)
end $$

function draw_outline(color, drawfunc)
    for c=1,15 do pal(c,color) end
    -- cache the old camera coords and restore them
    local ox, oy = %0x5f28, %0x5f2a
    for i=0,8 do
        camera(ox+i%3-1, oy+i\3-1) drawfunc()
    end
    camera(ox, oy)
    pal()
end
