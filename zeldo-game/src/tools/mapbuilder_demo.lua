EXA=0 MOV=1 INS=2 DEL=3
COL=4 MUS=5 SAV=6

dir_arr = {'l', 'r', 'u', 'd'}
met_arr = {'m', 'c', 'w', 'h'}

obj_templates = {
   {k="box"          , s=35,  sw=1, sh=1, xf=false, p={'box'          , 0,0                         }},
   {k="pot"          , s=49,  sw=1, sh=1, xf=false, p={'pot'          , 0,0                         }},
   {k="slimy"        , s=118, sw=1, sh=1, xf=false, p={'slimy'        , 0,0,3                       }},
   {k="quack"        , s=32,  sw=1, sh=1, xf=false, p={'quack'        , 0,0                         }},
   {k="topy"         , s=112, sw=1, sh=1, xf=false, p={'topy'         , 0,0                         }},
   {k="save_spot"    , s=78,  sw=2, sh=2, xf=false, p={'save_spot'    , 0,0                         }},
   {k="pillow"       , s=39,  sw=1, sh=1, xf=false, p={'pillow'       , 0,0                         }},
   {k="bed"          , s=55,  sw=1, sh=1, xf=false, p={'bed'          , 0,0                         }},
   {k="spikes"       , s=53,  sw=1, sh=1, xf=false, p={'spikes'       , 0,0,0                       }},
   {k="f_spikes"     , s=53,  sw=1, sh=1, xf=true , p={'spikes'       , 0,0,0,true                  }},
   {k="spikes_1"     , s=53,  sw=1, sh=1, xf=false, p={'spikes'       , 0,0,.25                     }},
   {k="f_spikes_1"   , s=53,  sw=1, sh=1, xf=true , p={'spikes'       , 0,0,.25,true                }},
   {k="spikes_2"     , s=53,  sw=1, sh=1, xf=false, p={'spikes'       , 0,0,.7                      }},
   {k="f_spikes_2"   , s=53,  sw=1, sh=1, xf=true , p={'spikes'       , 0,0,.7,true                 }},
   {k="spikes_3"     , s=53,  sw=1, sh=1, xf=false, p={'spikes'       , 0,0,.95                     }},
   {k="f_spikes_3"   , s=53,  sw=1, sh=1, xf=true , p={'spikes'       , 0,0,.95,true                }},
   {k="grave"        , s=45,  sw=1, sh=1, xf=false, p={'grave'        , 0,0, "a dead dude is here"  }},
   {k="sign"         , s=43,  sw=1, sh=1, xf=false, p={'sign'         , 0,0, "this is a sign"       }},
   {k="tall_tree"    , s=26,  sw=1, sh=2, xf=false, p={'tall_tree'    , 0,0                         }},
   {k="chest"        , s=50,  sw=1, sh=1, xf=false, p={'chest'        , 0,0,false,HAS_BANJO         }},
   {k="f_chest"      , s=50,  sw=1, sh=1, xf=true,  p={'chest'        , 0,0,true,HAS_BANJO          }},

   {k="house"        , s=46,  sw=2, sh=2, xf=false, p={'house'        , 0,0,58,4,7.5,46             }},
   {k="shop_brang"   , s=4,   sw=1, sh=1, xf=false, p={'shop_brang'   , 0,0                         }},
   {k="shop_shield"  , s=6,   sw=1, sh=1, xf=false, p={'shop_shield'  , 0,0                         }},
   {k="navy_blocking", s=97,  sw=1, sh=1, xf=false, p={'navy_blocking', 0,0                         }},
   {k="navy_house",    s=97,  sw=1, sh=1, xf=false, p={'navy_house',    0,0                         }},
   {k="teach"        , s=96,  sw=1, sh=1, xf=false, p={'teach'        , 0,0                         }},
   {k="keep"         , s=83,  sw=1, sh=1, xf=false, p={'keep'         , 0,0                         }},
   {k="jane"         , s=81,  sw=1, sh=1, xf=false, p={'jane'         , 0,0                         }},
   {k="bob_build"    , s=80,  sw=1, sh=1, xf=false, p={'bob_build'    , 0,0                         }},
   {k="lark"         , s=99,  sw=1, sh=1, xf=false, p={'lark'         , 0,0                         }},
}

function btn_helper(f, a, b)
   return f(a) and f(b) and 0 or f(a) and 0xffff or f(b) and 1 or 0
end

function xbtnp() return btn_helper(btnp, 0, 1) end
function ybtnp() return btn_helper(btnp, 2, 3) end

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

function sort(t)
   if t then
      for n=2,#t do
         local i=n
         while i>1 and t[i]<t[i-1] do
            t[i],t[i-1]=t[i-1],t[i]
            i=i-1
         end
      end
   end
end

function is_selectable_mode()
   return cur_mode == EXA or cur_mode == MOV or cur_mode == DEL
end

function sort_by_k(t)
   if t then
      for n=2,#t do
         local i=n
         while i>1 and t[i].k<t[i-1].k do
            t[i],t[i-1]=t[i-1],t[i]
            i=i-1
         end
      end
   end
end

function num_to_r(num)
   if num < 10 then
      num = "0"..num
   end
   return 'R_'..num
end

function is_in_array(v, array)
   for x in all(array) do
      if x == v then
         return true
      end
   end
   return false
end

function room_to_str(room)
   local array_vals, dir_vals, met_vals = {}, {}, {}
   local str = "   "
   for k, v in pairs(room) do
      if is_in_array(k, dir_arr) then
         dir_vals[k] = v
      elseif is_in_array(k, met_arr) then
         met_vals[k] = v
      else
         add(array_vals, v)
      end
   end

   for k in all(met_arr) do
      if met_vals[k] ~= nil then
         str=str..k.."="..array_tostring(met_vals[k])..","
      end
   end

   for k in all(dir_arr) do
      if dir_vals[k] ~= nil then
         str=str.."\n   "..k.."="..dir_array_to_str(dir_vals[k])..","
      end
   end

   str = str.."\n"
   if #array_vals > 0 then
      for i=1,#array_vals do
         str=str.."\n   "..obj_array_to_str(array_vals[i])..","
      end
      str = str.."\n"
   end
   return str
end

function rooms_to_str(rooms)
   local str = ""
   local new_rooms = {}
   for k, v in pairs(rooms) do
      add(new_rooms, {k=k, v=v})
   end

   sort_by_k(new_rooms)

   for i=1,#new_rooms do
      str=str.."; "..num_to_r(new_rooms[i].k)..":\n"..room_to_str(new_rooms[i].v).."\n"
   end

   return str
end

function obj_array_to_str(t)
   local str = ""
   for i=1,#t do
      if i == 1 then
         str=str..t[i]
      else
         str=str..array_tostring(t[i])
      end
      if i ~= #t then
         str=str.."/"
      end
  end
  return str
end

function dir_array_to_str(t)
   local str = ""
   for i=1,#t do
      if i == 1 then
         str=str..num_to_r(t[i])
      else
         str=str..array_tostring(t[i])
      end
      if i ~= #t then
         str=str.."/"
      end
  end
  return str
end

function array_tostring(any)
   if type(any) == "string" then
      return "\""..any.."\""
   elseif any == true then
	return "yes"
   elseif any == false then
	return "no"
   elseif any == nil then
	return "null"
   elseif type(any)~="table" then
      return tostr(any)
   end

   local str = ""
   for x in all(any) do
      str=str..","
      str=str..array_tostring(x)
   end
   return str
end

-- Here is the logic for the map builder tool.
function create_button(mode, text)
   local hw = #text*2
   return {
      x=115+hw, y=mode*8+3, mode=mode, rx=hw, ry=3, text=text,
   }
end

function is_hovering_button(b)
   return mouse_x < b.x+b.rx and
      mouse_x > b.x-b.rx and
      mouse_y < b.y+b.ry and
      mouse_y > b.y-b.ry
end

function draw_button(b)
   if b.mode == cur_mode then
      local l = #b.text*4 - 3*4
      rectfill(b.x-b.rx-l,b.y-b.ry,b.x+b.rx,b.y+b.ry,12)
      print(b.text, b.x-b.rx-l+1, b.y-b.ry+1, 1)
   else
      rectfill(b.x-b.rx,b.y-b.ry,b.x+b.rx,b.y+b.ry,9)
      print(b.text, b.x-b.rx+1, b.y-b.ry+1, 7)
   end
end

g_map = {
   x=0,y=0,w=2,h=2
}

off_x = 0
off_y = 0

ht_x, ht_y = 0, 0

function scrx(val)
   return (val or 0) + 64-map_w*4-off_x
end

function scry(val)
   return (val or 0) + 64-map_h*4-off_y
end

function get_cur_selected_obj()
   if is_selected and show_objs then
      for obj in all(cur_room) do
         local x, y = obj[2], obj[3]
         if x > sel_x-.5 and x < sel_x+.5 and
            y > sel_y-.5 and y < sel_y+.5 then
            return obj
         end
      end
   end

   return nil
end

function _init()
   poke(0x5f2d, 1)

   obj_templates_key_to_ind = {}
   for i=1,#obj_templates do
      obj_templates_key_to_ind[obj_templates[i].k] = i
   end

   cur_obj_ind = 1
   show_objs = true

   mouse_x, mouse_y = 0, 0
   prev_mouse_x, prev_mouse_y = 0, 0
   sel_x, sel_y, is_selected = 0, 0, false

   g_room_inds = {}
   g_cur_room_ind = 1
   for k,v in pairs(g_rooms) do
      add(g_room_inds, k)
   end
   sort(g_room_inds)

   cur_mode = 0 -- noop
   butts = {
      create_button(EXA, "examine"),
      create_button(MOV, "move"),
      create_button(INS, "insert"),
      create_button(DEL, "delete"),
      create_button(COL, "color"),
      create_button(MUS, "music"),
      create_button(SAV, "exit")
   }
end

start = 0
function _update60()
   is_mouse_pressed = not is_mouse_down and stat(34) == 1
   is_mouse_down = stat(34) == 1

   local lr = xbtnp()
   if lr != 0 then
      g_cur_room_ind = mid(1, g_cur_room_ind+lr, #g_room_inds)
   end

   if btnp(5) then
      show_objs = not show_objs
      is_moving = false
   end

   local k = g_room_inds[g_cur_room_ind]
   local qx, qy = flr(k/10 % 4), flr(k/40)
   local t_ind = k % 10

   cur_room = g_rooms[k]
   map_x = qx*32 + g_room_template[t_ind].x
   map_y = qy*32 + g_room_template[t_ind].y
   map_w = cur_room.w or g_room_template[t_ind].w
   map_h = cur_room.h or g_room_template[t_ind].h
   map_c = cur_room.c or 0

   if start == 0 or lr != 0 then
      start = 1
      music(cur_room.m)
   end

   mouse_x = mid(0, stat(32), 128)
   mouse_y = mid(0, stat(33), 128)

   ht_x = min(max(flr((mouse_x - scrx()-3)/4)/2, 0), map_w-1)
   ht_y = min(max(flr((mouse_y - scry()-3)/4)/2, 0), map_h-1)

   local ud = ybtnp()
   if ud != 0 then
      if cur_mode == INS then
         if show_objs then
            cur_obj_ind = mid(1, cur_obj_ind + ud, #obj_templates)
         end
      elseif cur_mode == MUS then
         cur_room.m = mid(0, cur_room.m + ud, 63)
         music(cur_room.m)
      elseif cur_mode == COL then
         cur_room.c = mid(0, (cur_room.c or 0) + ud, 15)
      elseif cur_mode == DEL then
         if cur_selected_obj then
            del(cur_room, cur_selected_obj)
         end
      elseif cur_mode == MOV then
         if cur_selected_obj then
            is_moving = true
         end
      elseif cur_mode == SAV then
          local final_str = "g_rooms = ztable[".."[\n"..rooms_to_str(g_rooms).."]".."]\n"
          for line in all(split(final_str, "\n")) do
             printh(line)
          end
         extcmd("shutdown")
      end
   end

   -- For insert
   ins_obj = obj_templates[cur_obj_ind]

   if not btn(4) then
      prev_mouse_x, prev_mouse_y = mouse_x, mouse_y

      if mouse_x > scrx(0) and mouse_y > scry(0) and
         mouse_x < scrx(map_w*8) and mouse_y < scry(map_h*8) then
         is_hover = true
         if is_mouse_pressed then
            is_selected = true
            sel_x = ht_x
            sel_y = ht_y

            local new_cur_obj = get_cur_selected_obj()
            if cur_mode == MOV and cur_selected_obj and is_moving then
               is_moving = false
               if new_cur_obj then
                  --sfx(7)
               else
                  cur_selected_obj[2] = sel_x
                  cur_selected_obj[3] = sel_y
               end
            elseif cur_mode == INS and show_objs then
               if new_cur_obj then
                  --sfx(7)
               else
                  local new_obj = tabcpy(ins_obj.p)
                  new_obj[2] = sel_x
                  new_obj[3] = sel_y
                  add(cur_room, new_obj)
               end
            end
         end
      else
         is_hover = false
         is_moving = false
         if is_mouse_pressed then
            is_selected = false
         end
      end
   else
      off_x = prev_mouse_x - mouse_x
      off_y = prev_mouse_y - mouse_y
   end

   if is_selectable_mode() then
      cur_selected_obj = get_cur_selected_obj()
   end

   if btnp(4,1) then
      cur_mode = (cur_mode + 1) % 7
      is_moving = false
   end

   foreach(butts, function(b)
      if is_hovering_button(b) then
         is_hover = false
         is_moving = false
         if stat(34) == 1 then
            is_selected = false
            cur_mode = b.mode
         end
      end
   end)
end

function _draw()
   cls(map_c)

   map(map_x, map_y, scrx(0), scry(0), map_w, map_h)

   if show_objs then
      for obj in all(cur_room) do
         local id = obj[1]
         if id == 'spikes' and obj[5] then id = 'f_spikes' end
         if id == 'chest' and obj[4] then id = 'f_chest' end
         local temp = obj_templates[obj_templates_key_to_ind[id]]
         local x, y = obj[2], obj[3]

         spr(temp.s, scrx(x*8+4)-temp.sw*4, scry(y*8+4)-temp.sh*4, temp.sw, temp.sh, temp.xf)
      end
   end

   foreach(butts, function(b)
      draw_button(b)
   end)

   if show_objs then
      print("on", 2, 115, 10)
   else
      print("off", 2, 115, 2)
   end
   print("room #"..g_room_inds[g_cur_room_ind], 2, 121, 7)

   if is_hover then
      rect(scrx(ht_x*8), scry(ht_y*8), scrx(ht_x*8)+7, scry(ht_y*8)+7, 6)
   end
   if is_selected then
      rect(scrx(sel_x*8), scry(sel_y*8), scrx(sel_x*8)+7, scry(sel_y*8)+7, 10)
   end

   if is_hover then
      print(ht_x, 92, 121, 7)
      print(ht_y, 111, 121, 7)
   end

   if cur_mode == INS and show_objs then
      spr(ins_obj.s, 9-ins_obj.sw*4, 9-ins_obj.sh*4, ins_obj.sw, ins_obj.sh, ins_obj.xf)
      print(ins_obj.k, 21, 1, 7)
      print('⬆️/⬇️ to change item.', 21, 7, 7)
      print("click to insert!", 21, 13, 7)
   elseif cur_mode == MUS then
      print("song: "..cur_room.m, 1, 1, 7)
      print('⬆️/⬇️ to change song.', 1, 7, 7)
   elseif cur_mode == COL then
      print("color: "..(cur_room.c or 0), 1, 1, 7)
      print('⬆️/⬇️ to change color.', 1, 7, 7)
   elseif cur_mode == SAV then
      print('⬆️/⬇️ to save and exit!', 1, 1, 7)
   elseif is_selectable_mode() then
      if cur_selected_obj then
         print("obj: "..cur_selected_obj[1], 1, 1, 10)
         if cur_mode == DEL then
            print('⬆️/⬇️ to delete.', 1, 7, 7)
         elseif cur_mode == MOV then
            if is_moving then
               print('click a new square to move!', 1, 7, 7)
            else
               print('⬆️/⬇️ to start moving.', 1, 7, 7)
            end
         end
      elseif cur_mode == EXA then
         print('⬅️/➡️ to change room.', 1, 1, 7)
         print("🅾️=pan. ❎=show objs.", 1, 7, 7)
         print("tab=change mode", 1, 13, 7)
      elseif cur_mode == DEL then
         print("select an obj to delete it!", 1, 1, 7)
      elseif cur_mode == MOV then
         print("select an obj to move it!", 1, 1, 7)
      end
   end

   if is_selected then
      print(sel_x, 92, 115, 10)
      print(sel_y, 111, 115, 10)
   end

   spr(12, mouse_x-4, mouse_y-4)
end
