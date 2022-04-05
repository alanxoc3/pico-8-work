-- file for zobjs relating to drawing.
zclass[[drawlayer_03|]] -- background player shoot ui
zclass[[drawlayer_05|]] -- background player anchor lines
zclass[[drawlayer_10|]] -- stars
zclass[[drawlayer_20|]] -- ships, planet, etc
zclass[[drawlayer_40|]] -- overlay text

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
