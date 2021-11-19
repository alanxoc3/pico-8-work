function _g.destroy_effect(a)
   for i=0,3 do
      _g.thing_destroyed(a, cos(i/4+.125)/8, sin(i/4+.125)/8, 1)
   end
end

-- this file contains the logic for loading and saving a game.
g_save_spots = ztable[[
   0:x=4,y=4,room=R_00;
     x=6,y=5,room=R_13;
]]

-- To transition rooms.
function transition(new_room_index, room_x, room_y, follow_actor)
   _g.fader_out(function()
      pause'transitioning'
   end, function()
      load_room(new_room_index, room_x, room_y, follow_actor)
      _g.fader_in(tbox_clear, unpause)
   end)
end
