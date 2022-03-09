ACTOR_BEGIN(pot_projectile)
    KEY(init) function(a) a.ax = bool_to_num(a.xf)*.04 end
ACTOR_END

ACTOR_BEGIN(other_thing)
    KEY(meow) function() print("hello world") end
ACTOR_END

_g.actor_keys=ztable([[ACTOR_TEMPLATE_KEYS]], ACTOR_TEMPLATE_VALS)
