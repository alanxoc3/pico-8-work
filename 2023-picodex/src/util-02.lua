|[f_beep]| function()
    f_minisfx'B_ERROR'
end $$

-- gives a discrete random number: [0, x)
|[f_flr_rnd]| function(x)
    return _flr(_rnd(x))
end $$

-- used everwhere
|[f_zcall]| function(func, text, ...)
    _foreach(f_zobj(text, ...), function(params)
        func(_unpack(params))
    end)
end $$

|[f_zcamera]| function(nx, ny, func)
    local ox, oy = %0x5f28, %0x5f2a
    _camera(ox-nx, oy-ny)
    func()
    _camera(ox, oy)
end $$
