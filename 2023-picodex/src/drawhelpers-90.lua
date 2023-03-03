|[f_print_draw2_message]| function(txt)
    f_zprint(txt or '', 23, 4, 1, 0)
end $$

-- todo: always fill in for i=0... no dot logic
|[f_print_draw3_message]| function(tbl)
    for i=0,2 do
        local txt, bg, fg = tbl[i+1], 13, 1
        if _sub(txt, 1, 1) == '.' then
            txt, bg, fg = _sub(txt, 2), 1, 13
        end
        _rectfill(0, i*7, 45, i*7+7, bg)
        f_zprint(txt, 23, 1+i*7, fg, 0)
    end
end $$
