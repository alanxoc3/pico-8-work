-- tbox

-- vars:
g_tbox_messages, g_tbox_anim, g_tbox_max_len = {}, 0, 25
-- listen to 'g_tbox_active', to listen if tbox is active.

-- if you press the button while text is still being displayed, then the text
-- finishes its display.
function tbox_interact()
   if g_tbox_update then
      if g_tbox_writing then
         g_tbox_anim = #g_tbox_active.l1+#g_tbox_active.l2
      else
         del(g_tbox_messages, g_tbox_active)
         g_tbox_active, g_tbox_anim = g_tbox_messages[1], 0
      end

      g_tbox_update = false
   end

   if g_tbox_active then
      g_tbox_anim += .5
      -- pause'tbox'

      g_tbox_writing = g_tbox_anim < #g_tbox_active.l1+#g_tbox_active.l2
      if not g_tbox_writing then
         g_tbox_anim = #g_tbox_active.l1+#g_tbox_active.l2
      end

      if g_tbox_writing then
         -- zsfx(0,0)
      end

      if btnp'4' or btnp'5' and g_tbox_anim > .5 then
         g_tbox_update = true
      end
   end
end

function tbox(str, trigger)
   g_tbox_messages.trigger = trigger or nf

   for i, x in pairs(split(str, "^")) do
      if i % 2 == 1 then
         add(g_tbox_messages, {l1=x, l2=''})
      else
         g_tbox_messages[#g_tbox_messages].l2=x
      end
   end

   g_tbox_active = g_tbox_messages[1]
end

-- draw the text boxes (if any)
-- foreground color, background color, border width
function tbox_draw(x, y)
    if g_tbox_active then -- only draw if there are messages
        camera(-x,-y)
        rectfill(0,0,96,32,0)
        rect(1,1,95,31,7)
        rect(6,6,25,26,7)

        -- print the message
        batch_call_new(print, [[
            @1, 31, 10,  7;
            @2, 31, 18, 7;
        ]],
            sub(g_tbox_active.l1, 1, g_tbox_anim),
            sub(g_tbox_active.l2, 0, max(g_tbox_anim - #g_tbox_active.l1, 0))
        )

        -- draw the arrow
        if not g_tbox_writing then
            spr(123, 88, ti(.6,.3) and 25 or 26)
        end
        camera()
    end
end

function tbox_clear()
   g_tbox_messages, g_tbox_anim, g_tbox_active = {}, 0, false
end
