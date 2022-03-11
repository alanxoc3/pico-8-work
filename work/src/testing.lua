function _init()
    old_tbl = ztable([[:uno;]], "hello")
    new_tbl = ztable_no_cache("1;2;3;@", "hello")
end

function _update60()
end

function _draw()
    cls()
    print("old", 32, 10, 7)
    print(old_tbl[1])
    -- print(old_tbl[2])
    -- print(old_tbl[3])
    -- print(old_tbl[4])

    print("new", 64+32, 10, 7)
    print(new_tbl[1])
    print(new_tbl[2])
    print(new_tbl[3])
    print(new_tbl[4])
end
