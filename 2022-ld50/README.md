# Model Tool Cheat Sheet
To load the model tool from PICO-8:

    load model_tool.lua

Cheat sheet:

    "t" - toggle on/off gui
    "m" - switch modes, you can only do this in a brand new layer
    "c" - change the color, doesn't work in some modes
    "d" - delete the current layer
    "s" - save - copies the model to the clipboard
    "r" - reload - deletes the current model and replaces it with the clipboard copy
                   you need to "ctrl+v" into pico-8 first, then press "r" to reload
    "-" - zoom out
    "+" - zoom in
    "=" - zoom to "1"

    left/right - move between layers
    up/down - zoom in/out
    left click - add point

Here is a sample model. To load this model, copy the text below, load the model
tool, paste the text into the model tool (ctrl+v), then press "r" to reload:

    1;,lines,9,0.5,0,-0.5,-0.3,-0.3,0,-0.5,0.3,0.5,0;

And here's another model, because why not:

    1;,lines,12,0.9,0,0.5,-0.8,-0.5,-1,-1,0,-0.8,0.5,-0.3,0.8,0.2,0.8,0.8,0.5,0.9,0;2;,lines,14,-0.3,-0.5,-0.5,-0.4,-0.5,-0.2,-0.3,-0.1,-0.1,-0.2,-0.1,-0.4,-0.3,-0.5;3;,lines,14,0.1,-0.4,0.1,-0.2,0.3,-0.1,0.5,-0.2,0.5,-0.4,0.3,-0.5,0.1,-0.4;4;,lines,8,-0.7,0.1,-0.5,0.3,-0.3,0.4,0,0.4,0.3,0.4,0.5,0.3,0.7,0.1;5;,lines,11,-0.5,-1,-0.3,-1.3,-0.1,-1.1,0.1,-1.2,0.2,-1.1,0.3,-1.3,0.5,-0.8;
