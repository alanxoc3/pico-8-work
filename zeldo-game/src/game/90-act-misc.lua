-- SECTION: INVENTORY SELECTION
create_actor([[item_selector;1;rel,|rel_actor:@1;u:@2]], function(a)
   function zero_to_two(num)
      return max(0,min(num,2))
   end

   -- from coordinate to index
   local thing = g_selected-1
   local next_selected = zero_to_two(flr(thing/3) + ybtnp())*3 + zero_to_two(thing%3 + xbtnp())+1
   if g_selected != next_selected then
      g_items_drawn[g_selected].outline_color = 1
      g_items_drawn[next_selected].outline_color = 2
      g_selected = next_selected
   end
end
)

create_actor([[inventory_item;6;rel,above_map_drawable,spr;|
   rel_actor:@1;rel_x:@2;rel_y:@3;enabled:@4;flippable:@5;sind:@6;visible:@6;i:@7;
]], function(a)
   if not a.enabled then a.sind = 0 end
end)

-- params: initCallback, endCallback
create_actor([[fader_out;2;act,;update,|
   i:@1;e:@2;u:@3;

   tl_max_time=FADE_TIME,
]], function(a)
   g_card_fade = max(a.tl_tim/a.tl_max_time*10, g_card_fade)
end)

-- params: initCallback, endCallback
create_actor([[fader_in;2;act,;update,|
   i:@1;e:@2;u:@3;

   tl_max_time=FADE_TIME,
]], function(a)
   g_card_fade = min((a.tl_max_time-a.tl_tim)/a.tl_max_time*10, g_card_fade)
end)

-- SECTION: VIEW
create_actor([[view;4;act,confined;center_view,update_view|
   x:0;y:0;room_crop:2;
   tl_loop:yes;
   w:@1;h:@2;follow_dim:@3;follow_act:@4;
   update_view:@5;
   center_view:@6;
   change_ma:@7;
   ,;
]],
function(a)
   if a.follow_act and not a.follow_act.alive then
      a.follow_act = nil
   end

   batch_call_new(update_view_helper, [[@1,x,w,ixx;@1,y,h,iyy]], a)
end, function(a)
   if a.follow_act then
      a.x, a.y = a.follow_act.x, a.follow_act.y
      a.name = a.follow_act.name
   end
   a:update_view()
end, function(a, other)
   -- Only include actors that are ma_able. Allow nil too though, to reset the actor.
   if not other or other.ma_able then
      a.follow_act = other
   end
end)
