|[f_print_draw2_message]| function(txt)
    f_zprint(txt or '', 23, 4, 1, 0)
end $$

|[f_print_draw3_message]| function(tbl)
    f_zcall(_rectfill, [[;,0,0,45,6,1]])
    f_zcall(f_zprint, [[
       ;,@,23,1,13,0
      ;;,@,23,8,1,0
      ;;,@,23,15,1,0
    ]], unpack(tbl))
end $$
