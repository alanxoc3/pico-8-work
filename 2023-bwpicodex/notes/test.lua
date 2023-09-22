function _init()

end

-- just store decompressed stuff to 0x8000

VGET_OFFSET = 0x0000
VSET_OFFSET = 0x6000

-- get pixels, but not limited to the graphics data section, can go beyond.
function vget(x, y)
    x = min(max(0, x), 127)\1
    y = y\1

    local val = peek(y*64+VGET_OFFSET+x\2)
    if x%2 == 1 then return (val & 0xf0) >>> 4
    else             return (val & 0x0f) end
end

-- set a pixel, but not limited to the graphics data section.
function vset(offset, x, y, val)
    x = min(max(0, x), 127)\1
    y = y\1

    local mem_coord = y*64+offset+x\2
    local oldval = peek(mem_coord)

    if x%2 == 1 then poke(mem_coord, (oldval & 0x0f) | ((val & 0x0f) << 4))
                else poke(mem_coord, (oldval & 0xf0) | ((val & 0x0f) << 0))
    end
end

function _draw()
    cls()
    for j=0,127 do
        for i=0,127 do
            vset(i, j, vget(i, j))
        end
    end
end
