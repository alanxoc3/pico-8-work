function _init()
    poke(0x5f2d, 1) -- enable keyboard
    g_help_mode = {name = "help", update = help_update, draw = help_draw}
    g_help_on = false

    g_modes = {
        {
            name = "link", update = link_update, draw = link_draw,
            help = {
                "l: link"
            }
        },
        {
            name = "wall", update = wall_update, draw = wall_draw,
            help = {
                "w: wall"
            }
        }
    }

    g_mode_index = 1
end

function _update60()

    local is_keydown, char = stat(30)
    if is_keydown then char = stat(31) end

    if char == "h"     then char = nil g_help_on = not g_help_on
    elseif char == "m" then char = nil g_mode_index = g_mode_index % #g_modes + 1
    end

    if g_help_on then
        g_mode = g_help_mode
    else
        g_mode = g_modes[g_mode_index]
    end

    g_mode.update(char)
end

function _draw()
    cls()

    local mode_name = g_mode.draw()

    rectfill(0, 0, 127, 10, 1)
    zprint("mode: "..mode_name, 5, 3, -1, 7)
end

function zspr(sind, x, y, sw, sh, ...)
   sw, sh = sw or 1, sh or 1
   spr(sind, x-sw*4, y-sh*4, sw, sh, ...)
end

function zprint(str, x, y, align, color)
    if align == 0    then x -= #str*2
    elseif align > 0 then x -= #str*4+1 end
    print(str, x, y, color)
end

function link_update() end
function link_draw() return g_mode.name end

function wall_update() end
function wall_draw() return g_mode.name end

function help_update() end
function help_draw()
    local current_mode = g_modes[g_mode_index]
    local top_align, left_align = 16, 5
    local texts = {
        "h: toggle mode help",
        "m: switch mode",
        "------------------------------"
    }

    for helptext in all(current_mode.help) do
        add(texts, helptext)
    end

    for i, t in pairs(texts) do
        zprint(t, left_align, (i-1)*8+top_align, -1, 7)
    end

    return "help "..current_mode.name
end
