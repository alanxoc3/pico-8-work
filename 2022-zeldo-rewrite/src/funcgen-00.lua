function create_coin(memloc)
    return function(x, y)
        if peek(memloc) == 0 then
            _g.coin(x, y, memloc)
        end
    end
end

