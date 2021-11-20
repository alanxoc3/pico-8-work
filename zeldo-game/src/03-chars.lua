function _g.look_at_pl(a)
   if g_pl then
      a.xf = a.x-g_pl.x > 0
   end
end

function npc_able_to_interact(a, other)
   return (a.x > other.x-INTERACT_SPACE and not other.xf or a.x < other.x+INTERACT_SPACE and other.xf)
end

function able_to_interact()
   return not g_menu_open
      and get_selected_item().interact
      and not is_game_paused()
      and btnp'4'
end

function _g.memloc_money(mem_loc,money)
   return function()
      if not zdget(mem_loc) then
         add_money(money)
         zdset(mem_loc)
      end
   end
end

function tbox_logic_help(params)
   for i=1,#params,3 do
      local memloc, text, func = unpack(params, i)
      if zdget(memloc) then
         tbox(text, func or nf)
         break
      end
   end
end

_g.tbox_actor_logic = function(...)
   local params = {...}
   return function()
      tbox_logic_help(params)
   end
end

function _g.npc_dance_logic(bad_text, good_text, good_trigger, bad_trigger)
   return function(a)
      if g_pause_reason == 'dancing' then
         change_cur_ma(a)
         tbox_logic_help{
            BANJO_TUNED, good_text, good_trigger,
            ALWAYS_TRUE, bad_text, bad_trigger or nf
         }
      end
   end
end

function _g.get_npc_reload_room(mem_loc, val)
   return function()
      zdset(mem_loc, val)
      transition(g_cur_room_index, g_pl.x-g_cur_room.x, g_pl.y-g_cur_room.y, g_pl)
   end
end
