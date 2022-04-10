-- PLAYER...
_g.PLAYER_SPACESHIP = parse_model[[collisions;1;,0,0,0.1;collisions;2;,0.1,0,0.1;lines;1;,7,1,yes,0.4,0,-0.3,0.3,-0.2,0,-0.3,-0.3,0.4,0;]]
_g.MISSILE          = parse_model[[collisions;1;,0,0,0.3;lines;1;,7,-1,no,-0.1,0,0.1,0;]]
_g.MISSILE_POP      = parse_model[[lines;1;,7,-1,no,-0.2,0,0,0.2,0.2,0,0,-0.2,-0.2,0;]]

-- NPCS...
_g.PLANET_SMALL     = parse_model[[lines;1;,3,-1,yes,0,-2,0.6,-1.9,1.2,-1.6,1.6,-1.2,1.9,-0.6,2,0;lines;2;,3,-1,yes,0,2,0.6,1.9,1.2,1.6,1.6,1.2,1.9,0.6,2,0;lines;3;,3,-1,yes,0,-2,-0.6,-1.9,-1.2,-1.6,-1.6,-1.2,-1.9,-0.6,-2,0;lines;4;,3,-1,yes,0,2,-0.6,1.9,-1.2,1.6,-1.6,1.2,-1.9,0.6,-2,0;collisions;1;,0,0,1.9999;]]
_g.CHASER           = parse_model[[collisions;1;,0,0,0.3;lines;1;,8,1,yes,-0.1,-0.4,-0.6,-0.1,-0.1,-0.1,-0.2,0,-0.1,0.1,-0.6,0.1,-0.1,0.4,0.7,0,-0.1,-0.4;]]
_g.BLACK_HOLE       = parse_model[[collisions;1;,0,0,0.8;lines;1;,5,1,no,-1,0,0,1,1,0,0,-1,-1,0;lines;2;,13,0,no,0.7,-0.7,0.7,0.7,-0.7,0.7,-0.7,-0.7,0.7,-0.7;lines;3;,13,0,no,0.7,-0.7,-0.7,-0.7,-0.7,0.7,0.7,0.7,0.7,0.7;lines;4;,6,0,no,-0.4,0,0,-0.4,0.4,0,0,0.4,-0.4,0;lines;5;,1,0,no,-1.5,0,0,1.5,1.5,0,0,-1.5,-1.5,0;lines;6;,1,0,no,1,1.1,1,-1.1,-1,-1.1,-1,1.1,1,1.1;]]
_g.ZIPPER           = parse_model[[collisions;1;,0,0,0.2;lines;1;,11,1,yes,0.4,0,-0.3,0.3,-0.2,0,-0.3,-0.3,0.4,0;]]
_g.ASTEROID   = parse_model[[collisions;1;,0,-0,1.1999;lines;1;,13,1,yes,0,1.2,-0.6,1,-1.1,0.5,-1.2,-0.2,-0.7,-1.1,0.2,-1.2,0.9,-0.7,1.2,-0.2,0.8,0.8,0.8,1,0,1.2;]]

-- ANIMALS...
_g.MOUSE      = parse_model[[collisions;1;,0,-0,1.0999;lines;1;,7,1,yes,0.3,-0.9,0.4,-1.2,0.8,-1.2,1.1,-0.8,0.8,-0.4;lines;2;,7,1,yes,-0.4,-1.2,-0.8,-1.2,-1.1,-0.8,-0.8,-0.4,-0.3,-0.9,-0.4,-1.2;lines;3;,7,1,yes,0.8,-1.2,1.1,-0.8,0.8,-0.4,0.3,-0.9,0.4,-1.2;lines;4;,7,1,yes,0.3,-0.9,-0.3,-0.9;lines;5;,7,1,yes,0.8,-0.4,1,0.1,0.8,0.6,0.1,1.1,0,1.2;lines;6;,7,-0.8,yes,-1,0.1,-0.8,0.6,-0.1,1.1,0,1.2;lines;7;,7,1,yes,-0.8,-0.4,-1,0.1;lines;8;,7,1,yes,0,0.8,0.2,0.9,0,1.2,-0.2,0.9,0,0.8;lines;9;,7,1,yes,0.2,0.9,1,0.6;lines;10;,7,1,yes,0.2,0.9,0.9,1;lines;11;,7,-0.2,yes,-0.9,1,-0.2,0.9,-0.9,1,-0.3,0.9,-0.2,0.9;lines;12;,7,-0.2,yes,-1,0.6,-1,0.6,-0.2,0.9;lines;13;,7,1,yes,1,0.6;lines;14;,7,1,yes,0.4,0.3,0.3,0.2,0.3,-0,0.4,-0.1,0.5,-0,0.5,0.2,0.4,0.3;lines;15;,7,-0.4,yes,-0.3,0.2,-0.3,-0,-0.4,-0.1,-0.5,-0,-0.5,0.2,-0.4,0.3,-0.3,0.2;lines;16;,7,1,yes,0.3,-0.9,-0.3,-0.9,-0.8,-0.4,-1,0.1,-0.8,0.6,0,1.2,0.8,0.6,1,0.1,0.8,-0.4,0.3,-0.9;]]
_g.CAT        = parse_model[[collisions;1;,0,0,1.3;lines;1;,1,1,yes,0.9,-1.5,0.5,-1,1.2,-0.6,1.2,-1,0.9,-1.5;lines;2;,7,-1,yes,0,0.4,0,0.5,-0.1,0.6,-0.2,0.6;lines;3;,7,-1,yes,0,0.4,0,0.5,0.1,0.6,0.2,0.6;lines;4;,7,-1,yes,0.6,0.2,0.5,0.1,0.5,-0.1,0.6,-0.2,0.7,-0.1,0.7,0.1,0.6,0.2;lines;5;,7,-1,yes,-0.6,0.2,-0.5,0.1,-0.5,-0.1,-0.6,-0.2,-0.7,-0.1,-0.7,0.1,-0.6,0.2;lines;6;,7,-1,yes,0.9,-1.5,0.8,-1.2,0.8,-0.8;lines;7;,7,-1,yes,-0.9,-1.5,-0.8,-1.2,-0.8,-0.8;lines;8;,7,-1,yes,0.9,0.3,1.2,0.3;lines;9;,7,-1,yes,-0.9,0.3,-1.2,0.3;lines;10;,7,-1,yes,0.9,0.2,1.1,0;lines;11;,7,-1,yes,-0.9,0.2,-1.1,0;lines;12;,7,-1,yes,0.9,0.4,1.1,0.6;lines;13;,7,-1,yes,-0.9,0.4,-1.1,0.6;lines;14;,7,-1,yes,0.9,-1.5,0.5,-1,0,-1.1,-0.5,-1,-0.9,-1.5,-1.1,-1.1,-1.2,-0.5,-1.3,0,-1.2,0.5,-0.8,0.9,-0.4,1,0.4,1,0.8,0.9,1.2,0.5,1.3,0,1.2,-0.5,1.1,-1.1,0.9,-1.5,0.5,-1,0.5,-1;lines;15;,-1,1,yes,0.5,-1,0,-1.1,-0.5,-1,-1.2,-0.6,-1.3,0,-1.2,0.5,-0.8,0.9,-0.4,1,0.4,1,0.8,0.9,1.2,0.5,1.3,0,1.2,-0.6,0.5,-1.1,0.5,-1;lines;16;,-1,1,yes,-0.9,-1.5,-0.5,-1,-1.2,-0.6,-1.2,-0.9,-0.9,-1.5;]]
_g.PIG        = parse_model[[collisions;1;,0,-0,1.1999;lines;1;,7,-0.5,yes,-0.4,0.1,-0.4,-0.1,-0.5,-0.2,-0.6,-0.1,-0.6,0.1,-0.6,0.1,-0.5,0.2,-0.4,0.1;lines;2;,7,-1,yes,0.2,0.2,-0.2,0.2,-0.3,0.3,-0.3,0.5,-0.2,0.6,0.2,0.6,0.3,0.5,0.3,0.3,0.2,0.2;lines;3;,7,-1,yes,0.1,0.3,0.1,0.4;lines;4;,7,-1,yes,-0.1,0.3,-0.1,0.4;lines;5;,7,-1,yes,0.5,-0.8,0.7,-0.7,0.8,-0.2,1.1,-0.2;lines;6;,7,-1,yes,-0.5,-0.8,-0.7,-0.7,-0.8,-0.2,-1.1,-0.2;lines;7;,7,1,yes,-0.9,1,-1.3,0.3,-1.1,-0.2,-1.2,-0.4,-1.1,-0.7,-0.8,-1,0,-1.2,0.8,-1,1.1,-0.7,1.2,-0.4,1.1,-0.2,1.3,0.3,0.9,1,0,1.1,-0.9,1;lines;8;,7,-1,yes,0.6,0.5,0,0.8,-0.6,0.5;lines;9;,7,-1,yes,0.4,-0.1,0.5,-0.2,0.6,-0.1,0.6,0.1,0.6,0.1,0.5,0.2,0.4,0.1,0.4,-0.1;]]
_g.BEAR       = parse_model[[collisions;1;,0,-0,1.0999;lines;1;,7,-1,yes,0.5,-0.2,0.4,-0.1,0.4,0.1,0.5,0.2,0.6,0.1,0.6,-0.1,0.5,-0.2;lines;2;,7,-0.5,yes,-0.4,-0.1,-0.4,0.1,-0.5,0.2,-0.6,0.1,-0.6,-0.1,-0.5,-0.2,-0.5,-0.2,-0.4,-0.1;lines;3;,7,-1,yes,0,0.2,0.2,0.2,0,0.4,-0.2,0.2,0,0.2;lines;4;,7,-1,yes,0,0.4,0,0.5,-0.2,0.6;lines;5;,7,-1,yes,0,0.5,0.2,0.6;lines;6;,7,-1,yes,0.6,-0.9,0.9,-1,1.1,-0.8,1.1,-0.4;lines;7;,7,-1,yes,-1.1,-0.5,-1.1,-0.8,-0.9,-1,-0.6,-0.9;lines;8;,7,-1,yes,0,-1.1,-0.6,-0.9,-1.1,-0.4,-1.2,0.2,-0.7,1,0,1.1;lines;9;,7,0,yes,0.6,-0.9,1.1,-0.4,1.2,0.2,0.7,1,0,1.1;lines;10;,7,-1,yes,0,-1.1,0.6,-0.9;lines;11;,7,1,yes,0.9,-1,0.6,-0.9,0,-1.1,-0.6,-0.9,-0.9,-1,-1.1,-0.8,-1.1,-0.4,-1.2,0.2,-0.7,1,0,1.1,0.7,1,1.2,0.2,1.1,-0.4,1.1,-0.8,0.9,-1;lines;12;,7,-1,yes,0.2,-0.4,0.7,-0.6,0.9,-0.3,0.2,-0.4;lines;13;,7,-0.2,yes,-0.7,-0.6,-0.9,-0.3,-0.2,-0.4,-0.7,-0.6;]]
_g.RHINO      = parse_model[[collisions;1;,0,-0,1.0999;lines;1;,7,-1,yes,0.5,-0.2,0.4,-0.1,0.4,0.1,0.5,0.2,0.6,0.1,0.6,-0.1,0.5,-0.2;lines;2;,7,-0.5,yes,-0.4,-0.1,-0.4,0.1,-0.5,0.2,-0.6,0.1,-0.6,-0.1,-0.5,-0.2,-0.5,-0.2,-0.4,-0.1;lines;3;,7,-1,yes,0,0.2,0.2,0.2,0,0.4,-0.2,0.2,0,0.2;lines;4;,7,-1,yes,0,0.4,0,0.5,-0.2,0.6;lines;5;,7,-1,yes,0,0.5,0.2,0.6;lines;6;,7,-1,yes,0.6,-0.9,0.9,-1,1.1,-0.8,1.1,-0.4;lines;7;,7,-1,yes,-1.1,-0.5,-1.1,-0.8,-0.9,-1,-0.6,-0.9;lines;8;,7,-1,yes,0,-1.1,-0.6,-0.9,-1.1,-0.4,-1.2,0.2,-0.7,1,0,1.1;lines;9;,7,0,yes,0.6,-0.9,1.1,-0.4,1.2,0.2,0.7,1,0,1.1;lines;10;,7,-1,yes,0,-1.1,0.6,-0.9;lines;11;,7,1,yes,0.9,-1,0.6,-0.9,0,-1.1,-0.6,-0.9,-0.9,-1,-1.1,-0.8,-1.1,-0.4,-1.2,0.2,-0.7,1,0,1.1,0.7,1,1.2,0.2,1.1,-0.4,1.1,-0.8,0.9,-1;lines;12;,7,-1,yes,0.2,-0.4,0.7,-0.6,0.9,-0.3,0.2,-0.4;lines;13;,7,-0.2,yes,-0.7,-0.6,-0.9,-0.3,-0.2,-0.4,-0.7,-0.6;]]
_g.CROC       = parse_model[[collisions;1;,0,-0,1.0999;lines;1;,7,-1,yes,0.5,-0.2,0.4,-0.1,0.4,0.1,0.5,0.2,0.6,0.1,0.6,-0.1,0.5,-0.2;lines;2;,7,-0.5,yes,-0.4,-0.1,-0.4,0.1,-0.5,0.2,-0.6,0.1,-0.6,-0.1,-0.5,-0.2,-0.5,-0.2,-0.4,-0.1;lines;3;,7,-1,yes,0,0.2,0.2,0.2,0,0.4,-0.2,0.2,0,0.2;lines;4;,7,-1,yes,0,0.4,0,0.5,-0.2,0.6;lines;5;,7,-1,yes,0,0.5,0.2,0.6;lines;6;,7,-1,yes,0.6,-0.9,0.9,-1,1.1,-0.8,1.1,-0.4;lines;7;,7,-1,yes,-1.1,-0.5,-1.1,-0.8,-0.9,-1,-0.6,-0.9;lines;8;,7,-1,yes,0,-1.1,-0.6,-0.9,-1.1,-0.4,-1.2,0.2,-0.7,1,0,1.1;lines;9;,7,0,yes,0.6,-0.9,1.1,-0.4,1.2,0.2,0.7,1,0,1.1;lines;10;,7,-1,yes,0,-1.1,0.6,-0.9;lines;11;,7,1,yes,0.9,-1,0.6,-0.9,0,-1.1,-0.6,-0.9,-0.9,-1,-1.1,-0.8,-1.1,-0.4,-1.2,0.2,-0.7,1,0,1.1,0.7,1,1.2,0.2,1.1,-0.4,1.1,-0.8,0.9,-1;lines;12;,7,-1,yes,0.2,-0.4,0.7,-0.6,0.9,-0.3,0.2,-0.4;lines;13;,7,-0.2,yes,-0.7,-0.6,-0.9,-0.3,-0.2,-0.4,-0.7,-0.6;]]
_g.DRAGON     = parse_model[[collisions;1;,0,-0,1.0999;lines;1;,7,-1,yes,0.5,-0.2,0.4,-0.1,0.4,0.1,0.5,0.2,0.6,0.1,0.6,-0.1,0.5,-0.2;lines;2;,7,-0.5,yes,-0.4,-0.1,-0.4,0.1,-0.5,0.2,-0.6,0.1,-0.6,-0.1,-0.5,-0.2,-0.5,-0.2,-0.4,-0.1;lines;3;,7,-1,yes,0,0.2,0.2,0.2,0,0.4,-0.2,0.2,0,0.2;lines;4;,7,-1,yes,0,0.4,0,0.5,-0.2,0.6;lines;5;,7,-1,yes,0,0.5,0.2,0.6;lines;6;,7,-1,yes,0.6,-0.9,0.9,-1,1.1,-0.8,1.1,-0.4;lines;7;,7,-1,yes,-1.1,-0.5,-1.1,-0.8,-0.9,-1,-0.6,-0.9;lines;8;,7,-1,yes,0,-1.1,-0.6,-0.9,-1.1,-0.4,-1.2,0.2,-0.7,1,0,1.1;lines;9;,7,0,yes,0.6,-0.9,1.1,-0.4,1.2,0.2,0.7,1,0,1.1;lines;10;,7,-1,yes,0,-1.1,0.6,-0.9;lines;11;,7,1,yes,0.9,-1,0.6,-0.9,0,-1.1,-0.6,-0.9,-0.9,-1,-1.1,-0.8,-1.1,-0.4,-1.2,0.2,-0.7,1,0,1.1,0.7,1,1.2,0.2,1.1,-0.4,1.1,-0.8,0.9,-1;lines;12;,7,-1,yes,0.2,-0.4,0.7,-0.6,0.9,-0.3,0.2,-0.4;lines;13;,7,-0.2,yes,-0.7,-0.6,-0.9,-0.3,-0.2,-0.4,-0.7,-0.6;]]

-- MISC/INVISIBLE
_g.LEVEL_NEXT = parse_model[[collisions;1;,0,0,1.4999;lines;1;,9,-1,yes,1.7,0,0,1.7,-1.7,0,0,-1.7,1.7,0;lines;2;,9,-1,yes,1.2,-1.2,1.2,1.2,-1.2,1.2,-1.2,-1.2,1.2,-1.2;lines;3;,9,-1,yes,0,-1.7,-1.2,-1.2,-1.7,0,-1.2,1.2,0,1.7,1.2,1.2,1.7,0,1.2,-1.2,0,-1.7;]]
_g.LEVEL_DONE = parse_model[[collisions;1;,0,0,1.4999;lines;1;,11,-1,yes,1.7,0,0,1.7,-1.7,0,0,-1.7,1.7,0;lines;2;,11,-1,yes,1.2,-1.2,1.2,1.2,-1.2,1.2,-1.2,-1.2,1.2,-1.2;lines;3;,11,-1,yes,0,-1.7,-1.2,-1.2,-1.7,0,-1.2,1.2,0,1.7,1.2,1.2,1.7,0,1.2,-1.2,0,-1.7;]]
_g.STARTING_CIRCLE       = parse_model[[collisions;1;,0,0,1;lines;1;,7,-1,yes,0,-1,0.4,-0.9,0.7,-0.7,0.9,-0.4,1,0,0.9,0.5,0.5,0.9,0,1,-0.5,0.9,-0.8,0.6,-1,0,-0.8,-0.6,-0.5,-0.9,0,-1;]]
_g.VIEW_COLLISION_CIRC   = parse_model[[collisions;1;,0,0,7;]]
_g.FOCUS_POINT           = parse_model[[collisions;1;,0,0,1;]]

g_font = {
    a = parse_model[[collisions;1;,0,0,.5;lines;1;,7,-1,no,-0.2,0.3,0,-0.3,0.2,0.3;lines;2;,7,-1,no,0.1,0,-0.1,0;]],
    b = parse_model[[collisions;1;,0,0,.5;lines;1;,7,-1,no,-0.2,0.3,-0.2,-0.3;lines;2;,7,-1,no,-0.2,-0.3,0,-0.3,0.1,-0.2,0.1,-0.1,0,0,-0.2,0;lines;3;,7,-1,no,0,0,0.1,0,0.2,0.1,0.2,0.2,0.1,0.3,-0.2,0.3;]],
    c = parse_model[[collisions;1;,0,0,.5;lines;1;,7,-1,no,0.2,-0.2,0,-0.3,-0.2,-0.2,-0.2,0.2,0,0.3,0.2,0.2;]],
    d = parse_model[[collisions;1;,0,0,.5;lines;1;,7,-1,no,-0.2,0.3,0,0.3,0.2,0,0,-0.3,-0.2,-0.3,-0.2,0.3;]],
    e = parse_model[[collisions;1;,0,0,.5;lines;1;,7,-1,no,-0.2,-0.3,-0.2,0.3,0.2,0.3;lines;2;,7,-1,no,-0.2,0,0,0;lines;3;,7,-1,no,-0.2,-0.3,0.2,-0.3;]],
    f = parse_model[[collisions;1;,0,0,.5;lines;1;,7,-1,no,0.2,-0.3,-0.2,-0.3,-0.2,0.3;lines;2;,7,-1,no,-0.2,0,0,0;]],
    g = parse_model[[collisions;1;,0,0,.5;lines;1;,7,-1,no,0.2,-0.2,0,-0.3,-0.2,-0.2,-0.2,0.2,0,0.3,0.2,0.2,0.2,0,0,0;]],
    h = parse_model[[collisions;1;,0,0,.5;lines;1;,7,-1,no,0.2,-0.3,0.2,0.3;lines;2;,7,-1,no,0.2,0,-0.2,0;lines;3;,7,-1,no,-0.2,-0.3,-0.2,0.3; ]],
    i = parse_model[[collisions;1;,0,0,.5;lines;1;,7,-1,no,-0.2,-0.3,0.2,-0.3;lines;2;,7,-1,no,0,-0.3,0,0.3;lines;3;,7,-1,no,0.2,0.3,-0.2,0.3;]],
    j = parse_model[[collisions;1;,0,0,.5;lines;1;,7,-1,no,-0.2,-0.3,0.2,-0.3;lines;2;,7,-1,no,0,-0.3,0,0.2,-0.1,0.3,-0.2,0.2,-0.2,0;]],
    k = parse_model[[collisions;1;,0,0,.5;lines;1;,7,-1,no,-0.2,-0.3,-0.2,0.3;lines;2;,7,-1,no,-0.2,0,-0.1,0,0.2,-0.3;lines;3;,7,-1,no,-0.1,0,0.2,0.3;]],
    l = parse_model[[collisions;1;,0,0,.5;lines;1;,7,-1,no,-0.2,-0.3,-0.2,0.3,0.2,0.3;]],
    m = parse_model[[collisions;1;,0,0,.5;lines;1;,7,-1,no,-0.2,0.3,-0.2,-0.3,0,0,0.2,-0.3,0.2,0.3;]],
    n = parse_model[[collisions;1;,0,0,.5;lines;1;,7,-1,no,-0.2,0.3,-0.2,-0.3,0.2,0.3,0.2,-0.3;]],
    o = parse_model[[collisions;1;,0,0,.5;lines;1;,7,-1,no,0,-0.3,-0.1,-0.3,-0.2,-0.2,-0.2,0.2,-0.1,0.3,0.1,0.3,0.2,0.2,0.2,-0.2,0.1,-0.3,0,-0.3;]],
    p = parse_model[[collisions;1;,0,0,.5;lines;1;,7,-1,no,-0.2,0.3,-0.2,-0.3,0.1,-0.3,0.2,-0.2,0.2,-0.1,0.1,0,-0.2,0;]],
    q = parse_model[[collisions;1;,0,0,.5;lines;1;,7,-1,no,0,-0.3,-0.1,-0.3,-0.2,-0.2,-0.2,0.2,-0.1,0.3,0.1,0.3,0.2,0.2,0.2,-0.2,0.1,-0.3,0,-0.3;lines;2;,7,-1,no,0,0.2,-0.1,0.3,-0.2,0.3;]],
    r = parse_model[[collisions;1;,0,0,.5;lines;1;,7,-1,no,-0.2,-0.3,-0.2,0.3;lines;2;,7,-1,no,-0.2,-0.3,0.1,-0.3,0.2,-0.2,0.2,-0.1,0.1,0,-0.2,0;lines;3;,7,-1,no,0,0,0.2,0.3;]],
    s = parse_model[[collisions;1;,0,0,.5;lines;1;,7,-1,no,0.2,-0.1,0.2,-0.2,0,-0.3,-0.2,-0.2,-0.2,-0.1,0.2,0.1,0.2,0.2,0,0.3,-0.2,0.2,-0.2,0.1;]],
    t = parse_model[[collisions;1;,0,0,.5;lines;1;,7,-1,no,0,0.3,0,-0.3;lines;2;,7,-1,no,-0.2,-0.3,0.2,-0.3;]],
    u = parse_model[[collisions;1;,0,0,.5;lines;1;,7,-1,no,-0.2,-0.3,-0.2,0.2,-0.1,0.3,0.1,0.3,0.2,0.2,0.2,-0.3;]],
    v = parse_model[[collisions;1;,0,0,.5;lines;1;,7,-1,no,-0.2,-0.3,0,0.3,0.2,-0.3;]],
    w = parse_model[[collisions;1;,0,0,0.5;lines;1;,7,-1,no,-0.2,-0.3,-0.2,0.3,0,0,0.2,0.3,0.2,-0.3;]],
    x = parse_model[[collisions;1;,0,0,.5;lines;1;,7,-1,no,-0.2,-0.3,0.2,0.3;lines;2;,7,-1,no,0.2,-0.3,-0.2,0.3;]],
    y = parse_model[[collisions;1;,0,0,.5;lines;1;,7,-1,no,-0.2,-0.3,0,0,0.2,-0.3;lines;2;,7,-1,no,0,0,0,0.3;]],
    z = parse_model[[collisions;1;,0,0,.5;lines;1;,7,-1,no,-0.2,-0.2,-0.2,-0.3,0.2,-0.3,-0.2,0.3,0.2,0.3,0.2,0.2;]],

    ["1"] = parse_model[[collisions;1;,0,0,0.5;lines;1;,7,-1,no,-0.2,0.3,0.2,0.3;lines;2;,7,-1,no,-0.2,-0.1,0,-0.3,0,0.3;]],
    ["2"] = parse_model[[collisions;1;,0,0,0.5;lines;1;,7,-1,no,-0.2,-0.2,-0.1,-0.3,0.1,-0.3,0.2,-0.2,0.2,-0.1,-0.2,0.3,0.2,0.3;]],
    ["3"] = parse_model[[collisions;1;,0,0,0.5;lines;1;,7,-1,no,-0.2,-0.2,-0.1,-0.3,0.1,-0.3,0.2,-0.2,0.2,-0.1,0.1,0,-0.1,0;lines;2;,7,-1,no,-0.2,0.2,-0.1,0.3,0.1,0.3,0.2,0.2,0.2,0.1,0.1,0;]],
    ["4"] = parse_model[[lines;1;,7,-1,no,-0.2,-0.3,-0.2,0,0.2,0,0.2,-0.3;lines;2;,7,-1,no,0.2,0,0.2,0.3;]],
    ["5"] = parse_model[[collisions;1;,0,0,0.5;lines;1;,7,-1,no,0.2,-0.3,-0.2,-0.3,-0.2,-0.1,0,-0.1,0.2,0,0.2,0.2,0,0.3,-0.2,0.3;]],
    ["6"] = parse_model[[lines;1;,7,-1,no,0.2,0,0.2,0.3,-0.2,0.3,-0.2,0,-0.2,-0.3,0.2,-0.3;lines;2;,7,-1,no,0.2,0,-0.2,0;]],
    ["7"] = parse_model[[lines;1;,7,-1,no,-0.2,-0.2,-0.2,-0.3,0.2,-0.3,0.2,0.2;]],
    ["8"] = parse_model[[collisions;1;,0,0,0.5;lines;1;,7,-1,no,-0.1,0,-0.2,-0.1,-0.2,-0.2,-0.1,-0.3,0.1,-0.3,0.2,-0.2,0.2,-0.1,0.1,0,-0.1,0,-0.2,0.1,-0.2,0.2,-0.1,0.3,0.1,0.3,0.2,0.2,0.2,0.1,0.1,0;]],
    ["9"] = parse_model[[lines;1;,7,-1,no,-0.2,0,-0.2,-0.3,0.2,-0.3,0.2,0,0.2,0.3,-0.2,0.3;lines;2;,7,-1,no,-0.2,0,0.2,0;]],
    ["0"] = parse_model[[collisions;1;,0,0,0.5;lines;1;,7,-1,no,-0.1,-0.3,-0.2,-0.2,-0.2,0.2,-0.1,0.3,0.1,0.3,0.2,0.2,0.2,-0.2,0.1,-0.3,-0.1,-0.3;lines;2;,7,-1,no,-0.2,0.3,0.2,-0.3;]],

    [" "] = parse_model[[]],

    ["?"] = parse_model[[collisions;1;,0,0,.5;lines;1;,7,-1,no,-0.2,-0.1,-0.2,-0.2,-0.1,-0.3,0.1,-0.3,0.2,-0.2,0.2,-0.1,0.1,0,0,0,0,0.1;lines;2;,7,-1,no,0,0.3,0.1,0.2,0,0.2,0,0.3;]],
    ["!"] = parse_model[[collisions;1;,0,0,.5;lines;1;,7,-1,no,0,0.1,-0.2,-0.3,0.2,-0.3,0,0.1;lines;2;,7,-1,no,-0.1,0.2,0.1,0.2,0,0.3,-0.1,0.2;]],
    ["."] = parse_model[[collisions;1;,0,0,.5;lines;1;,7,-1,no,0,0.3,0.1,0.2,0,0.2,0,0.3;]],

    nil
}
