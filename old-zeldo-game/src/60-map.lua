g_card_fade = 0

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

function load_room(new_room_index, rx, ry, follow_actor)
   -- reload the map (remove shovel things).
   reload(0x1000, 0x1000, 0x2000)

   -- todo: refactor here
   g_cur_room_index = new_room_index
   g_cur_room = g_rooms[new_room_index]

   switch_song(g_cur_room.m)

   -- take care of actors.
   batch_call_new(acts_loop, [[confined,room_end;confined,kill;confined,delete]])

   if follow_actor then
      follow_actor.x = rx + g_cur_room.x
      follow_actor.y = ry + g_cur_room.y
   end

   if g_cur_room.i then g_cur_room.i() end

   g_main_view = _g.view(min(14, g_cur_room.w), min(12, g_cur_room.h), 2, follow_actor)
   g_left_ma_view = _g.view(2.75, 3, 0, follow_actor)
   g_right_ma_view = _g.view(2.75, 3, 0, nil)

   acts_loop('view', 'center_view')
end

function room_update(fa)
   -- plus .5 and minus .375 is because there is a screen border.
   if not is_game_paused() and g_cur_room then
      local dir = nil
      if     fa.y > g_cur_room.y+g_cur_room.h-.375 then dir = 'd'
      elseif fa.y < g_cur_room.y + .5              then dir = 'u'
      elseif fa.x > g_cur_room.x+g_cur_room.w-.375 then dir = 'r'
      elseif fa.x < g_cur_room.x +.5               then dir = 'l'
      end

      if dir != nil and g_cur_room[dir] then
         transition(g_cur_room[dir][1], g_cur_room[dir][2], g_cur_room[dir][3], fa)
      end
   end
end

function map_init()
   for k, v in pairs(g_rooms) do
      if tonum(k) then
         local qx, qy = flr(k/10 % 4), flr(k/40)
         local template = g_room_template[k%10]

         v.x,v.y = template.x+qx*32, template.y+qy*32
         v.w, v.h = v.w or template.w, v.h or template.h

         v.i=function()
            batch_call_table(function(att_name, x, y, ...)
               _g[att_name](v.x+x+.5, v.y+y+.5, ...)
            end, v)

            acts_loop('act', 'room_init')
         end
      end
   end
end
