create_actor[[pot:drawable:bounded:confined:tcol:spr:mov:anchored;|
   @:x:y:spawn_id;
   &:i;
   sind:49; rx:.375; ry:.375;
   touchable:yes;
]] 

-- tmp = _g.ref.pot
-- &:i, set i to tmp.i
-- _g.ref.pot.i
pot:i { function(a)
   _g.gen_trigger_block(a, 0, .25, .5, .25, nf, function(trig, other)
      if btnp(4) and not other.item and zdget'CAN_THROW_POTS' then
         other.item = _g.grabbed_item(g_pl, a.sind, -7, function(x, y, xf)
            _g.pot_projectile(other.x, other.y, xf)
         end)
         local rnd_num = flr_rnd'5'
         if rnd_num == 0 then
            _g.money(a.x, a.y)
         elseif rnd_num == 1 then
            _g.health_obj(a.x, a.y)
         end
         a:kill()
      end
   end)
end
}

new_create_actor[[:pot:drawable:bounded:confined:tcol:spr:mov:anchored; anchored:yes:;|
    @:x:y:spawn_id;
    %pot_i;
    sind:49; rx:.375; ry:.375;
]]

ztable([[
    pot:@:;
]], func

)

(pot_i) { function(a)
   _g.gen_trigger_block(a, 0, .25, .5, .25, nf, function(trig, other)
      if btnp(4) and not other.item and zdget'can_throw_pots' then
         other.item = _g.grabbed_item(g_pl, a.sind, -7, function(x, y, xf)
            _g.pot_projectile(other.x, other.y, xf)
         end)
         local rnd_num = flr_rnd'5'
         if rnd_num == 0 then
            _g.money(a.x, a.y)
         elseif rnd_num == 1 then
            _g.health_obj(a.x, a.y)
         end
         a:kill()
      end
   end)
end }

new_create_actor[[:house:drawable:confined:spr|
    @:x:y:room:room_x:room_y:sind;
    i:$;
    iyy:-4;sw:2;sh:2;
]]

(house) { function(a)
    batch_call_new(_g.static_block, [[
        @:x:y;
        !:%plus:~x:-.75; :!!:~y:.25:.5;
        !:%plus:~x:.75;  :!!:~y:.25:.5;
        !:%plus:~y:-.5;  :~x:!!:1:.25;
    ]], a.x, a.y)

    batch_call_new(_g.gen_trigger_block, [[
        @:a:hit;
        .#:~a,0,.125,.5,.625,hit,nf;
    ]], a, function(trig, other)
        if other.pl then
            transition(a.room, a.room_x, a.room_y, g_pl)
        end
    end)
end }

new_create_actor[[:pillow:pre_drawable:spr:confined|
    @:x:y;
    sind:39;iyy:0;
]]

create_actor[[:pot_projectile:drawable:col:confined:mov:spr:bounded:tcol|
    @:x:y:xf;
    $:i:u:destroyed:hit;

    tile_hit:%next;
    tile_solid:yes;
    sind:49;
    touchable:no;

    :tl_max_time:.3;
]]

(pot_projectile) { function(a)
   a.ax = bool_to_num(a.xf)*.04
end }

(pot_projectile) { function(a)
   a.iyy = -cos(a.tl_tim/a.tl_max_time/4)*8
end }

(pot_projectile) { function(a)
   zsfx(2, 7)
   _g.destroy_effect(a, 1)
end }

(pot_projectile) { function(a, o)
   if o.touchable and not o.pl then
      call_not_nil(o, 'hurt', o, 0, 60)
      call_not_nil(o, 'knockback', o, .6, bool_to_num(a.xf), 0)
      a:next()
   end
end }

create_actor[[brang;confined;anim;col;mov;tcol|
    did_brang_hit:no;
    item_stop:yes;
    tile_solid:no;
    being_held:yes;
    anim_len:4;
    anim_spd:3;
    touchable:no;
    item_slow:yes;

    ix:.8; iy:.8;
    rx:.375; ry:.375;

    @:rel_actor;
    $:i1:hit1:u1:hit2:u2:hit3:u3:i2:tile_hit;

    sinds:4:19:20:21;

    :i:~i1 :hit:~hit1 :u:~u1 :tl_max_time:.1;
    :i:nf  :hit:~hit2 :u:~u2 :tl_max_time:.75;
    :i:~i2 :hit:nf    :u:~u1 :tl_max_time:.15 :ax:0:ay:0:dx:0:dy:0;
    :i:nf  :hit:~hit3 :u:~u3 :tl_max_time:3;
]]

function(a) -- init 1
   a.x, a.y = a.rel_actor.x, a.rel_actor.y
   a.xf = a.rel_actor.xf
   a.ax = bool_to_num(a.xf)*.1
   use_energy(10)
end

brang_hit_func

function(a) -- update 1
   pause_energy()
end

function(a, other) -- hit 2
   if other.pl then
      a.alive = false
   end
   brang_hit_func(a, other)
end

function(a) -- update 2
   pause_energy()
   a.ax = xbtn()*.05
   a.ay = ybtn()*.05
   return not a.being_held or a.did_brang_hit
end

function(a, other) -- hit 3
   if other.pl then
      a.alive = false
   elseif other.touchable and not a.did_brang_hit then
      if other.knockable then
         other.knockback(other, .05, a.xf and -1 or 1, 0)
      end
      a.did_brang_hit = true
   end
end

function(a) -- update 3
   pause_energy()
   amov_to_actor(a, a.rel_actor, .1)
end

function(a)
   if a.did_brang_hit then
      zsfx(2, 7)
   end
end

function(a)
   a.did_brang_hit = true
end
