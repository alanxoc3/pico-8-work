-- tbox

-- vars:
g_tbox_messages, g_tbox_anim, g_tbox_max_len = {}, 0, 25
-- listen to 'g_tbox_active', to listen if tbox is active.

-- if you press the button while text is still being displayed, then the text
-- finishes its display.
function tbox_interact()
   if g_tbox_active then
      g_tbox_anim += .5
      pause'tbox'

      g_tbox_writing = g_tbox_anim < #g_tbox_active.l1+#g_tbox_active.l2
      if not g_tbox_writing then
         g_tbox_anim = #g_tbox_active.l1+#g_tbox_active.l2
      end

      if g_tbox_writing then
         zsfx(0,0)
      end

      if btnp'4' and g_tbox_anim > .5 then
         g_tbox_update = true
      end
   end
end

function tbox(str, trigger)
   g_tbox_messages.trigger = trigger or nf

   -- DEBUG_BEGIN
   if type(trigger) ~= "function" then
      printh("ohal: "..tostring(trigger))
   end
   -- DEBUG_END
   --
   for i, x in pairs(split(str, "^")) do
      if i % 2 == 1 then
         add(g_tbox_messages, {l1=x, l2=''})
      else
         g_tbox_messages[#g_tbox_messages].l2=x
      end
   end

   g_tbox_active = g_tbox_messages[1]
end

function _g.tbox_closure(obj)
   return function()
      tbox(obj)
   end
end

function tbox_basic_draw(x, y)
   if g_tbox_active then -- only draw if there are messages
      camera(-x,-y)
      -- print the message
      batch_call_new(zprint, [[
         @1, 3, 3,  -1, FG_WHITE, BG_WHITE;
         @2, 3, 11, -1, FG_WHITE, BG_WHITE;
      ]],
         sub(g_tbox_active.l1, 1, g_tbox_anim),
         sub(g_tbox_active.l2, 0, max(g_tbox_anim - #g_tbox_active.l1, 0))
      )

      -- draw the arrow
      if not g_tbox_writing then
         spr(38, 100, ti(.6,.3) and 13 or 14)
      end
      camera()
   end
end

-- draw the text boxes (if any)
-- foreground color, background color, border width
function ttbox_draw(x, y)
   if g_tbox_active then -- only draw if there are messages
      camera(-x,-y)
      rectfill(-1,0,105,19,0)
      zrect(1,2,103,17)
      camera()

      tbox_basic_draw(x,y)
   end
end

function tbox_clear()
   g_tbox_messages, g_tbox_anim, g_tbox_active = {}, 0, false
end
