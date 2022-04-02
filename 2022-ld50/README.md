# Model Tool Cheat Sheet
To load the model tool from PICO-8:

    load model_tool.lua

Cheat sheet:

    ALL MODES:
    "f" - to forward to a different mode
    "b" - go back to a different mode
    "t" - toggle on/off gui
    "s" - save - copies the model to the clipboard
    "r" - reload - deletes the current model and replaces it with the clipboard copy you need to "ctrl+v" into pico-8 first, then press "r" to reload
    "-" - zoom out
    "+" - zoom in
    "=" - zoom to "1"

    LINES MODE:
    "d" - delete the current layer
    "x" - add new layer that flips current layer on x axis
    "y" - add new layer that flips current layer on y axis
    left/right - move between layers
    up/down - change the color of the current layer
    left click - add point

    COLLISIONS MODE:
    "d" - delete the current collision circle
    left/right - move between collision circles
    up/down - change the size of the current collision circle
    left click - move or create a collision circle

Here is a sample model. To load this model, copy the text below, load the model
tool, paste the text into the model tool (ctrl+v), then press "r" to reload:

    lines;1;,9,0.5,0,-0.5,-0.3,-0.3,0,-0.5,0.3,0.5,0;

And here's another model, because why not:

    lines;1;,12,0.9,0,0.5,-0.8,-0.5,-1,-1,0,-0.8,0.5,-0.3,0.8,0.2,0.8,0.8,0.5,0.9,0;lines;2;,14,-0.3,-0.5,-0.5,-0.4,-0.5,-0.2,-0.3,-0.1,-0.1,-0.2,-0.1,-0.4,-0.3,-0.5;lines;3;,14,0.1,-0.4,0.1,-0.2,0.3,-0.1,0.5,-0.2,0.5,-0.4,0.3,-0.5,0.1,-0.4;lines;4;,8,-0.7,0.1,-0.5,0.3,-0.3,0.4,0,0.4,0.3,0.4,0.5,0.3,0.7,0.1;lines;5;,11,-0.5,-1,-0.3,-1.3,-0.1,-1.1,0.1,-1.2,0.2,-1.1,0.3,-1.3,0.5,-0.8;
