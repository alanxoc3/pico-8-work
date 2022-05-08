-- start with drawlayer_50 and divide by 2 if something needs to go forward or backward
-- max = 99, min = 00
zclass[[drawlayer_50|]]

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