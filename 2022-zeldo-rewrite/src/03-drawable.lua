-- start with drawlayer_50 and divide by 2 if something needs to go forward or backward
-- max = 99, min = 00
zclass[[drawlayer_50|]]

-- these layers are above the card
zclass[[drawlayer_99|]]

-- for now, only one outline layer, this is like cell shading
zclass[[outlayer_50|]]

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
    for c=1,15 do pal(c,1) end
    -- cache the old camera coords and restore them
    local ox, oy = peek2(0x5f28), peek2(0x5f2a)
    for i=0,8 do
        camera(ox+i%3-1, oy+i\3-1) a:draw()
    end
    camera(ox, oy)
    pal()
end $$
