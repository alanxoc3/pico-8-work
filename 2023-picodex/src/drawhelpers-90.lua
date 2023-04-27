|[f_print_draw2_message]| function(txt)
    f_zprint(txt or '', 23, 4, 1, 0)
end $$

-- format is "a|b|c". first three fields separated by pipe are understood.
|[f_print_draw3_message]| function(str)
    f_zcall(rectfill, [[;,0,0,45,6,1]])
    f_zcall(f_zprint, [[
       ;,@,23,1,13,0
      ;;,@,23,8,1,0
      ;;,@,23,15,1,0
    ]], unpack(split(str, "|", false)))
end $$
