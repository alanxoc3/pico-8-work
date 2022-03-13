function inventory_init()
   -- global_items
   g_selected, g_items = 5, ztable[[
      mem_loc=HAS_FORCE,     enabled=no,  name=force   , xoff=-7, yoff=-9, sind=36;
      mem_loc=HAS_BOOMERANG, enabled=no,  name=brang   , xoff=0, yoff=-10, sind=4;
      mem_loc=HAS_BOMB,      enabled=yes, name=bomb    , xoff=7, yoff=-9, sind=5;

      mem_loc=HAS_SHIELD,    enabled=no,  name=shield  , xoff=-8, yoff=-3, sind=6;
      mem_loc=ALWAYS_TRUE,   enabled=yes, name=interact, interact=yes, xoff=0, yoff=-3, sind=no;
      mem_loc=HAS_BOW,       enabled=no,  name=bow     , xoff=8, yoff=-3, sind=7;

      mem_loc=HAS_SHOVEL,    enabled=no,  name=shovel  , xoff=-7, yoff=4, sind=3;
      mem_loc=HAS_SWORD,     enabled=no,  name=sword   , xoff=0, yoff=6, sind=2;
      mem_loc=HAS_BANJO,     enabled=no,  name=banjo   , xoff=7, yoff=4, sind=1;
   ]]
end

function gen_pl_item(pl)
   return get_selected_item() and call_not_nil(_g, get_selected_item().name, pl)
end

function get_selected_item(ind)
   local item = g_items[ind or g_selected]
   return item.enabled and item or g_items[5]
end

function inventory_update()
   -- tbox logic
   local item = get_selected_item()

   if not is_game_paused'tbox' and not g_menu_open and btn'5' then
      g_selected = 5
   end

   g_menu_open = g_pl and not g_pl:get[[item;banjo]] and g_pl:get[[alive]] and not is_game_paused'tbox' and btn'5'

   if g_menu_open then -- create_inventory_items
      if not g_items_drawn then
         zsfx(2,0)
         g_item_selector = _g.item_selector(g_pl)
         g_items_drawn = {}
         for ind=1,9 do
            local item = g_items[ind]
            item.enabled = zdget(item.mem_loc)
            g_items_drawn[ind] = _g.inventory_item(g_pl, item.xoff/8, item.yoff/8, item.enabled, item.flippable, item.sind)
         end
      end

      if g_pl.item then g_pl.item.being_held = false end
   elseif g_item_selector then -- destroy_inventory_items
      zsfx(2,1)
      foreach(g_items_drawn, function(a) a.alive = false end)
      g_item_selector.alive = false

      g_pl.outline_color, g_items_drawn, g_item_selector = BG_UI
   end
end
