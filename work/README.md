# Plan for a new syntax

```
-- overall syntax
x=VAL;     -- set x to VAL
x=y=VAL;   -- set x and y to VAL
=VAL;      -- set '' to VAl

x:VAL;     -- set x to [VAL]
x:VAL:VAL; -- set x to [VAL,VAL]
:VAL;      -- set '' to [VAL]

VAL;       -- set 1 to VAL
VAL;VAL    -- set 1 to VAL, set 2 to VAL

-- VAL interpretations
nop;  -- empty function
yes;  -- true
no;   -- false
null; -- nil
@;    -- parameter
~x;   -- backtrack value
%x;   -- _g table value

-- EXAMPLE STATE SYSTEM WITH NEW SYNTAX

-- usage: _g.apple()
create_actor[[apple,drawable|
    jump   :i:%apple_i1 :hit:%apple_hit1 :u:%apple_u1 :state_duration:.1  :state_next:walk;
    walk   :i:nf        :hit:%apple_hit2 :u:%apple_u2 :state_duration:.75 :state_next:run;
    run    :i:%apple_i2 :hit:nf          :u:%apple_u1 :state_duration:.15 :state_next:crouch :ax:0 :ay:0 :dx:0 :dy:0;
    crouch :i:%apple_ht :hit:%apple_hit3 :u:%apple_u3 :state_duration:1   :state_next:jump;

    start=~jump;
]]

-- usage: _g.brang(player)
create_actor[[brang,timed_state,confined,anim,col,mov,tcol|
    rel_actor=@;

    did_brang_hit = no;
    item_stop     = yes;
    tile_solid    = no;
    being_held    = yes;
    touchable     = no;
    item_slow     = yes;
    anim_len      = 4;
    anim_spd      = 3;

    ix = .8;   iy = .8;
    rx = .375; ry = .375;

    sinds:4:19:20:21;
]]

-- usage: _g.test(1, 5, 9)
create_actor[[test|
    x=y=z=@;
]]

-- and a batch call example
batch_call(_g.static_block, ztable([[
    x=y=@;
    1:~x:~y:-.75:0:.25:.5;
    2:~x:~y:.75:0:.25:.5;
    3:~x:~y:0:-.5:1:.25;
]], 3, 5)) 

create_actor[[pot,drawable,bounded,confined,tcol,spr,mov,anchored|
    x=y=spawn_id=@;
    sind=49; rx=.375; ry=.375;
    touchable=yes;
]]
```
