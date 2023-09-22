|[f_beep]| function()
    f_minisfx'B_ERROR'
end $$

-- gives a discrete random number: [0, x)
|[f_flr_rnd]| function(x)
    return flr(rnd(x))
end $$

-- used everwhere
|[f_zcall]| function(func, text, ...)
    foreach(f_zobj(text, ...), function(params)
        func(unpack(params))
    end)
end $$

|[f_zcamera]| function(nx, ny, func)
    local ox, oy = %0x5f28, %0x5f2a
    camera(ox-nx, oy-ny)
    func()
    camera(ox, oy)
end $$
