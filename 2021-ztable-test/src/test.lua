function _init()
    ta("{a=a,b=b}", ztable":a:a:b:b")
    ta("{a,b,c,d}", ztable",a,b,c,d")
    ta("{{1,2,3}}", ztable"1;,1,2,3")
    ta("{no=false,nop=[function],yes=true}", ztable":yes:yes:no:no:null:null:nop:nop")

    print("all tests passed")
    printh("all tests passed")
end

function ta(expected, actual)
    actual = tostring(actual)
    assert(expected == actual, "expect: "..expected.." | actual: "..actual)
end

-- basic sort
function sort(t, compare_func)
    compare_func = compare_func or function(a, b) return a < b end
    if t then
        for n=2,#t do
            local i=n
            while i>1 and compare_func(t[i], t[i-1]) do
                t[i],t[i-1]=t[i-1],t[i]
                i=i-1
            end
        end
    end
end

-- converts anything to a string
function tostring(any)
    if type(any)~="table" then return tostr(any) end
    local str = "{"
    local keys = {}
    for i=1,#any do
        if str~="{" then str=str.."," end
        keys[i] = true
        str=str..tostring(any[i])
    end
    local sortedkeys = {}
    for k,v in pairs(any) do
        if not keys[k] then
            add(sortedkeys, k)
        end
    end

    sort(sortedkeys)
    for k in all(sortedkeys) do
        if str~="{" then str=str.."," end
        str=str..tostring(k).."="..tostring(any[k])
    end
    return str.."}"
end
