-- lib. make sure this is included second (after loading string data).

-- allows playing partial sound effects.
function zsfx(num, sub_num)
    sfx(num,-1,sub_num*4,4)
end

function bool_to_num(condition)
    return condition and 0xffff or 1
end

function get(a, ...)
   local arr, cur_act = ztable(...), a or {}
   for i=1,#arr do
      cur_act = cur_act[arr[i]]
      if not cur_act then
         break
      end
   end
   return cur_act
end

-- stole this from a forum
function approx_dist(dx,dy)
    local maskx,masky=dx>>31,dy>>31
    local a0,b0=(dx+maskx)^^maskx,(dy+masky)^^masky
    if a0>b0 then
        return a0*0.9609+b0*0.3984
    end
    return b0*0.9609+a0*0.3984
end

function btn_helper(f, a, b)
   return f(a) and f(b) and 0 or f(a) and 0xffff or f(b) and 1 or 0
end

function xbtn()
    return btn_helper(btn, 0, 1)
end

function ybtn()
    return btn_helper(btn, 2, 3)
end

function xbtnp()
    return btn_helper(btnp, 0, 1)
end

function ybtnp()
    return btn_helper(btnp, 2, 3)
end

function zsgn(num)
    return num == 0 and 0 or sgn(num)
end

function round(num)
    return flr(num + .5)
end

-- -1, 0, or 1
function rnd_one(val)
    return (flr_rnd'3'-1)*(val or 1)
end

function ti(period, length)
   return t() % period < length
end

function flr_rnd(x)
   return flr(rnd(x))
end

-- A random item from the list.
function rnd_item(list)
   return list[flr_rnd(#list)+1]
end

-- Recursively copies table attributes.
function tabcpy(src, dest)
   dest = dest or {}

   for k,v in pairs(src or {}) do
      if type(v) == 'table' and not v.is_tabcpy_disabled then
         dest[k] = tabcpy(v)
      else
         dest[k] = v
      end
   end
   return dest
end

-- Call a function if the table and the table key are not nil
function call_not_nil(table, key, ...)
   if table and table[key] then
      return table[key](...)
   end
end

function batch_call_table(func,tbl)
    foreach(tbl, function(t) func(unpack(t)) end)
end

function batch_call_new(func, ...)
    batch_call_table(func, ztable(...))
end

-- Assumes that each parent a has at least one item in it.
-- Example: tl_node(actor)
-- vars: tl_tim, tl_cur, tl_max_time, tl_next, tl_loop, next, tl_continued
function tl_node(a)
   a.tl_cur = a.tl_cur or 1

   if not a.tl_continued then
      a.next = function()
         if a.tl_loop then
            a.tl_next = (a.tl_cur % #a) + 1
         else
            a.tl_next = a.tl_cur + 1
         end
      end

      a.tl_tim, a.tl_max_time, a.tl_continued = 0, nil, true
      tabcpy(a[a.tl_cur] or {}, a)
      call_not_nil(a, 'i', a)
   end

   if call_not_nil(a, 'u', a) then a:next() end

   a.tl_tim += 1/60

   -- Switch to the next state if time is up.
   if a.tl_max_time and a.tl_tim >= a.tl_max_time then
      a:next()
   end

   if a.tl_next then
      local old_tl_next = a.tl_next
      a.tl_cur, a.tl_continued, a.tl_next = old_tl_next, nil, nil
      call_not_nil(a, 'e', a)
      return old_tl_next > #a or old_tl_next < 1
   end
end

function isorty(t)
    if t then
        for n=2,#t do
            local i=n
            while i>1 and t[i].y<t[i-1].y do
                t[i],t[i-1]=t[i-1],t[i]
                i=i-1
            end
        end
    end
end

-- If the game is paused, only run paused functions.
function acts_loop(id, func_name, ...)
   for a in all(g_act_arrs[id]) do
      call_not_nil(a, func_name, a, ...)
   end
end

-- Converts anything to a string.
function tostring(any)
    if type(any)~="table" then return tostr(any) end
    local str = "{"
    for k,v in pairs(any) do
        if str~="{" then str=str.."," end
        str=str..tostring(k).."="..tostring(v)
    end
    return str.."}"
end

function _g.plus(a,b) return a+b end
function _g.minus(a,b) return a-b end
