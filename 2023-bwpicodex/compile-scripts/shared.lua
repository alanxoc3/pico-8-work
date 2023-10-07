-- requires init to be set.
-- requires param that specifies where to start writing bytes to.

function log(logstr)
    logstr = logstr or ''
    logstr = "pos: "..tostr(ENCODE_OFFSET, 0x1).." | "..logstr

    printh(logstr or '')
    color(7)
    print(logstr or '')
    flip()
end

-- poke a 1 byte val and increment offset
function offsetpoke(val)
    poke(ENCODE_OFFSET, val)
    ENCODE_OFFSET += 1
end

function strip_spaces(data)
    local newdata = ""
    for i=1,#data do
        local c = sub(data, i, i)
        if c ~= " " then
            newdata = newdata..c
        end
    end
    return newdata
end

function datastr_to_arr(datastr)
  local arrs = {}

  for x in all(split(datastr, "\n")) do
    local l = split(x, " ")
    local newarr = {}
    for y in all(l) do
      if y != "" then
        add(newarr, y)
      end
    end

    if #newarr > 0 then
      add(arrs, newarr)
    end
  end

  return arrs
end

-- basic sort for tostring. tostring for debugging.
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

memset(0x0000, 0, 0x8000) -- start with a clean slate
memset(0x8000, 0, 0x8000)

ENCODE_OFFSET = tonum(stat(6), 0x1)
START_OFFSET = ENCODE_OFFSET
log("BEGIN SCRIPT")
cls()
init()
cstore(START_OFFSET, START_OFFSET, ENCODE_OFFSET-START_OFFSET, "game.p8")
log("END SCRIPT")
