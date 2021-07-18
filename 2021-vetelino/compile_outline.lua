function array_to_string(any)
  if type(any)~="table" then return tostr(any) end
  local str = ""
  for v in all(any) do
     str=str..tostr(v)..","
  end
  return sub(str, 1, #str-1)
end

function printarr(arr)
   local str = ""
   for i=1,#arr do
      str = str..array_to_string(arr[i])..((i == #arr) and "" or ",")
   end
   return str
end

function does_a_contain_b(a, b)
   return b[1] >= a[1] and b[3] <= a[3] and b[2] >= a[2] and b[4] <= a[4]
end

g_out_cache = {}
function create_outline(sind, sw, sh)
   sw*=8 sh*=8 sh-=1

   local bounds, is_bkgd = {}, function(x, y)
      return mid(0,x,sw-1) == x and sget(x+sind*8%128, y+flr(sind/16)*8) != 0
   end

   local calc_bound = function(x)
      local top, bot

      for i=0,sh do
         top, bot = top or is_bkgd(x,i) and i-1, bot or is_bkgd(x,sh-i) and sh+1-i
      end

      return {
         top=top or sh+1,
         bot=bot or 0
      }
   end

   local outline = {}

   -- Phase 1. Generate verticals.
   for i=0xffff,sw do
      -- prev, cur, next
      local p, c, n = calc_bound(i-1), calc_bound(i), calc_bound(i+1)
      local top, bot = min(min(p.top, c.top), n.top), max(max(p.bot, c.bot), n.bot)

      if bot >= top then
         add(outline, {i,top,i,bot})
      end
   end

   -- Phase 2. Expand horizontally.
   for i=1,#outline do
      local head = outline[i]
      local new_x2

      for j=i,#outline do
         local tail = outline[j]
         if head[2] >= tail[2] and head[4] <= tail[4] then
            new_x2 = tail[1]
         else
            break
         end
      end

      head[3] = new_x2
   end

   -- Phase 3. Remove contained rects.
   for i=#outline,1,-1 do
      local tail = outline[i]

      for j=i-1,1,-1 do
         local body = outline[j]
         if does_a_contain_b(body, tail) then
            del(outline, tail)
            break
         end
      end
   end

   if #outline == 0 then
      add(outline, {3,3,4,4})
   end

   g_out_cache[sind] = outline
end

-- manually putting in all the indexes.

for i=0,255 do
  if fget(i,5) and fget(i,4) then
    create_outline(i, 2, 2)
  elseif fget(i,5) then
    create_outline(i, 1, 1)
  elseif fget(i,4) then
    create_outline(i, 1, 2)
  elseif fget(i,3) then
    create_outline(i, 2, 3)
  end
end

printh("g_out_cache=ztable[[")
for k,v in pairs(g_out_cache) do
   printh(k..":"..printarr(v)..";")
end
printh("]]")
