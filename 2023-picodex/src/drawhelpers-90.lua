function print_draw2_message(txt)
    zprint(txt or '', 23, 4, 1, 0)
end

function print_draw3_message(tbl)
    for i=0,2 do
        local txt, bg, fg = tbl[i+1], 13, 1
        if sub(txt, 1, 1) == '.' then
            txt, bg, fg = sub(txt, 2), 1, 13
        end
        rectfill(0, i*7, 45, i*7+7, bg)
        zprint(txt, 23, 1+i*7, fg, 0)
    end
end
