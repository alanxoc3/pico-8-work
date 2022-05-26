-- start with drawlayer_50 and divide by 2 if something needs to go forward or backward
-- max = 99, min = 00
zclass[[drawlayer_50|]] -- main game layer
zclass[[drawlayer_60|]] -- house
zclass[[drawlayer_70|]] -- fairy

zclass[[drawlayer_90|]] -- above the card, stat
zclass[[drawlayer_95|]] -- above the card, inventory
zclass[[drawlayer_99|]] -- above the card, title, textbox

zclass[[fader,actor|
    ecs_exclusions;actor,yes,timer,yes; -- remove game_state from the actor group
]]

zclass[[fader_out,fader|
    start; duration,FADE_SPEED, destroyed,@, update,%fader_out_update
]]

|[fader_out_update]| function(a)
    g_fade = a:get_elapsed_percent'state'
end $$

zclass[[fader_in,fader|
    start; duration,FADE_SPEED, update,%fader_in_update
]]

|[fader_in_update]| function(a)
    g_fade = 1 - a:get_elapsed_percent'state'
end $$

-- just a common timer so animation syncs between everything
zclass[[animation,actor|
    index,0,
    init,%animation_init;

    start; duration,@, next,start
]]

|[animation_init]| function(a)
    a.index += 1
    a.index %= 60 -- smooth because divisible by 2,3,4,5,6
end $$

zclass[[auto_outline|
    draw,%auto_outline_draw,
    outline_color,1
]]
|[auto_outline_draw]| function(a)
    draw_outline(a.outline_color, function() a:drawout() end)
    a:drawout()
end $$

function draw_outline(color, drawfunc)
    for c=1,15 do pal(c,color) end
    -- cache the old camera coords and restore them
    local ox, oy = %0x5f28, %0x5f2a
    for y=-1,1 do for x=-1,1 do
        camera(ox+x, oy+y) drawfunc()
    end end
    camera(ox, oy)
    pal()
end

-- sort based on y position for some draw layers
function isorty(t)
    if t then
        for n=2,#t do
            local i=n
            while i>1 and t[i].y<t[i-1].y do
                t[i],t[i-1]=t[i-1],t[i]
                i=i-1
            end
        end
    end
end
