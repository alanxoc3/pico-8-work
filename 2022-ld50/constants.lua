-- USED CONSTANTS...
_g.CATEROID         = parse_model[[collisions;1;,0.3,0,1;collisions;2;,-0.3,0,1;collisions;3;,-0.8,-0.9,0.4;collisions;4;,-0.9,-1.3,0.2;collisions;5;,-0.8,-0.6,0.4;collisions;6;,0.8,-0.9,0.4;collisions;7;,0.9,-1.3,0.2;collisions;8;,0.8,-0.6,0.4;collisions;9;,0,-0.3,0.9;lines;1;,7,-1,yes,0,0.4,0.2,0.3,0.1,0.2,-0.1,0.2,-0.2,0.3,0,0.4;lines;2;,7,-1,yes,0,0.4,0,0.5,-0.1,0.6,-0.2,0.6;lines;3;,7,-1,yes,0,0.4,0,0.5,0.1,0.6,0.2,0.6;lines;4;,7,-1,yes,0.6,0.2,0.5,0.1,0.5,-0.1,0.6,-0.2,0.7,-0.1,0.7,0.1,0.6,0.2;lines;5;,7,-1,yes,-0.6,0.2,-0.5,0.1,-0.5,-0.1,-0.6,-0.2,-0.7,-0.1,-0.7,0.1,-0.6,0.2;lines;6;,7,-1,yes,0.9,-1.5,0.8,-1.2,0.8,-0.8;lines;7;,7,-1,yes,-0.9,-1.5,-0.8,-1.2,-0.8,-0.8;lines;8;,7,-1,yes,0.9,0.3,1.2,0.3;lines;9;,7,-1,yes,-0.9,0.3,-1.2,0.3;lines;10;,7,-1,yes,0.9,0.2,1.1,0;lines;11;,7,-1,yes,-0.9,0.2,-1.1,0;lines;12;,7,-1,yes,0.9,0.4,1.1,0.6;lines;13;,7,-1,yes,-0.9,0.4,-1.1,0.6;lines;14;,7,-1,yes,0.9,-1.5,0.5,-1,0,-1.1,-0.5,-1,-0.9,-1.5,-1.1,-1.1,-1.2,-0.5,-1.3,0,-1.2,0.5,-0.8,0.9,-0.4,1,0.4,1,0.8,0.9,1.2,0.5,1.3,0,1.2,-0.5,1.1,-1.1,0.9,-1.5,0.5,-1;lines;15;,-1,1,yes,0.5,-1,0,-1.1,-0.5,-1,-1.2,-0.6,-1.3,0,-1.2,0.5,-0.8,0.9,-0.4,1,0.4,1,0.8,0.9,1.2,0.5,1.3,0,1.2,-0.6,0.5,-1.1,0.5,-1;lines;16;,-1,1,yes,0.9,-1.5,1.1,-1,1.2,-0.6,0.5,-1,0.9,-1.5;lines;17;,-1,1,yes,-0.9,-1.5,-1.1,-1.1,-1.2,-0.6,-0.8,-0.8,-0.5,-1,-0.9,-1.5;]]
_g.PLAYER_SPACESHIP = parse_model[[collisions;1;,0,0,0.2;lines;1;,7,1,yes,0.4,0,-0.3,0.3,-0.2,0,-0.3,-0.3,0.4,0;]]
_g.LEVEL_CATEROID   = parse_model[[collisions;1;,0,-0.2,1.4999;lines;1;,7,-1,yes,0,0.4,0,0.5,-0.1,0.6,-0.2,0.6;lines;2;,7,-1,yes,0,0.4,0,0.5,0.1,0.6,0.2,0.6;lines;3;,7,-1,yes,0.6,0.2,0.5,0.1,0.5,-0.1,0.6,-0.2,0.7,-0.1,0.7,0.1,0.6,0.2;lines;4;,7,-1,yes,-0.6,0.2,-0.5,0.1,-0.5,-0.1,-0.6,-0.2,-0.7,-0.1,-0.7,0.1,-0.6,0.2;lines;5;,7,-1,yes,0.9,-1.5,0.8,-1.2,0.8,-0.8;lines;6;,7,-1,yes,-0.9,-1.5,-0.8,-1.2,-0.8,-0.8;lines;7;,7,-1,yes,0.9,0.3,1.2,0.3;lines;8;,7,-1,yes,-0.9,0.3,-1.2,0.3;lines;9;,7,-1,yes,0.9,0.2,1.1,0;lines;10;,7,-1,yes,-0.9,0.2,-1.1,0;lines;11;,7,-1,yes,0.9,0.4,1.1,0.6;lines;12;,7,-1,yes,-0.9,0.4,-1.1,0.6;lines;13;,7,-1,yes,0.9,-1.5,0.5,-1,0,-1.1,-0.5,-1,-0.9,-1.5,-1.1,-1.1,-1.2,-0.5,-1.3,0,-1.2,0.5,-0.8,0.9,-0.4,1,0.4,1,0.8,0.9,1.2,0.5,1.3,0,1.2,-0.5,1.1,-1.1,0.9,-1.5,0.5,-1,0.5,-1;lines;14;,-1,1,yes,0.5,-1,0,-1.1,-0.5,-1,-1.2,-0.6,-1.3,0,-1.2,0.5,-0.8,0.9,-0.4,1,0.4,1,0.8,0.9,1.2,0.5,1.3,0,1.2,-0.6,0.5,-1.1,0.5,-1;lines;15;,9,-1,yes,1.7,-0.2,0,1.5,-1.7,-0.2,0,-1.9,1.7,-0.2;lines;16;,9,1,yes,1.2,-1.4,1.2,1,-1.2,1,-1.2,-1.4,1.2,-1.4;lines;17;,9,0,yes,0,-1.9,-1.2,-1.4,-1.7,-0.2,-1.2,1,0,1.5,1.2,1,1.7,-0.2,1.2,-1.4,0,-1.9;lines;18;,-1,1,yes,-0.9,-1.5,-0.5,-1,-1.2,-0.6,-1.2,-0.9,-0.9,-1.5;lines;19;,1,1,yes,0.9,-1.5,0.5,-1,1.2,-0.6,1.2,-1,0.9,-1.5;]]
_g.MISSILE          = parse_model[[lines;1;,7,-1,yes,-0.1,0,0.1,0;collisions;1;,0,0,0.2;]]
_g.MISSILE_POP      = parse_model[[lines;1;,7,-1,yes,-0.2,0,0,0.2,0.2,0,0,-0.2,-0.2,0;]]
_g.PLANET_SMALL     = parse_model[[lines;1;,3,-1,yes,0,-2,0.6,-1.9,1.2,-1.6,1.6,-1.2,1.9,-0.6,2,0;lines;2;,3,-1,yes,0,2,0.6,1.9,1.2,1.6,1.6,1.2,1.9,0.6,2,0;lines;3;,3,-1,yes,0,-2,-0.6,-1.9,-1.2,-1.6,-1.6,-1.2,-1.9,-0.6,-2,0;lines;4;,3,-1,yes,0,2,-0.6,1.9,-1.2,1.6,-1.6,1.2,-1.9,0.6,-2,0;collisions;1;,0,0,1.9999;]]

_g.TEST_LET_R = parse_model[[lines;1;,7,-1,yes,-0.5,0.9,-0.5,-0.6,0.2,-0.7,0.7,-0.3,0.2,0.1,-0.5,0.1,0.5,0.8;]]
_g.TEST_LET_E = parse_model[[lines;1;,7,-1,yes,0.5,-0.7,-0.6,-0.7,-0.6,0.1,0.1,0.1;lines;2;,7,-1,yes,-0.6,0.1,-0.5,0.9,0.4,0.7;]]
_g.TEST_LET_W = parse_model[[lines;1;,7,-1,yes,-0.7,-0.5,-0.3,0.6,-0.1,0.2,0.1,0.6,0.7,-0.4;]]
_g.TEST_LET_O = parse_model[[lines;1;,7,-1,yes,-0.1,-0.7,-0.5,-0.3,-0.5,0.3,0,0.7,0.5,0,0.2,-0.5,-0.1,-0.7;]]
_g.TEST_LET_B = parse_model[[lines;1;,7,-1,yes,-0.5,-0.6,-0.4,0.9,0.3,0.4,0.2,0.2,-0.4,0.1,0.1,-0.2,0.1,-0.5,-0.5,-0.6;]]

-- MODIFIED
_g.STARTING_CIRCLE       = parse_model[[collisions;1;,0,0,1;lines;1;,7,-1,yes,0,-1,0.4,-0.9,0.7,-0.7,0.9,-0.4,1,0,0.9,0.5,0.5,0.9,0,1,-0.5,0.9,-0.8,0.6,-1,0,-0.8,-0.6,-0.5,-0.9,0,-1;]]
_g.VIEW_COLLISION_CIRC   = parse_model[[collisions;1;,0,0,6;]]

-- UNUSED CONSTANTS...

-- PLAYER:             collisions;1;,0,0,0.2;lines;1;,7,1,yes,0.4,0,-0.3,0.3,-0.2,0,-0.3,-0.3,0.4,0;

-- CITY_OUTPOST:       lines;1;,11,-1,yes,-0.6,0,-0.6,-0.5,-0.3,-0.5,-0.3,-1,0,-1,0,-0.7,0.3,-0.7,0.3,-0.8,0.6,-0.8,0.6,-0.3,0.7,-0.3,0.7,0;lines;2;,11,-1,yes,0.3,-0.7,0.3,-0.1;lines;3;,11,-1,yes,-0.3,-0.5,-0.3,-0.1;lines;4;,11,-1,yes,0,-0.7,0,-0.1;
-- METEOR_BASIC:       lines;1;,8,-1,yes,-0.4,-0.8,0.1,-0.8,0.7,-0.5,0.8,-0.1,0.8,0,0.5,0.3,0.3,0.8,-0.3,0.8,-0.7,0.3,-0.9,-0.1,-0.7,-0.6,-0.4,-0.8;collisions;1;,-0.1,0,0.9;
-- CARTOON_SPACESHIP:  collisions;1;,-0.4,0,0.6;collisions;2;,0.2,0,0.3;collisions;3;,0.5,0,0.3;collisions;4;,0.8,0,0.2;collisions;5;,-0.7,-0.4,0.2;collisions;6;,-0.7,0.4,0.2;lines;1;,7,-1,yes,-0.5,-0.2,-0.7,-0.3,-0.8,-0.1,-0.8,0.1,-0.7,0.3,-0.5,0.2;lines;2;,13,-1,yes,0,-0.3,-0.2,-0.5,-0.6,-0.6,-0.8,-0.6,-0.9,-0.5,-0.6,-0.4,-0.5,-0.2;lines;3;,13,-1,yes,0,0.3,-0.2,0.5,-0.6,0.6,-0.8,0.6,-0.9,0.5,-0.6,0.4,-0.5,0.2;lines;4;,13,-1,yes,0,0,-0.9,0;lines;5;,7,-1,yes,1,0,0.7,-0.2,0.2,-0.3,0,-0.3,-0.5,-0.2,-0.6,0;lines;6;,7,-1,yes,1,0,0.7,0.2,0.2,0.3,0,0.3,-0.5,0.2,-0.6,0;lines;7;,13,2,yes,0.7,-0.2,1,0,0.7,0.2,0.6,0.1,0.6,-0.1,0.7,-0.2;lines;8;,13,1,yes,0.5,0,0.4,-0.1,0.3,-0.1,0.2,0,0.3,0.1,0.4,0.1,0.5,0;
-- SPACESHIP_VARIANT1: collisions;1;,0.2,0,0.5;collisions;2;,-0.3,0,0.7;collisions;3;,0.7,0,0.3;collisions;4;,-0.6,-0.5,0.2;collisions;5;,-0.6,0.5,0.2;lines;1;,7,-1,yes,1,0,0.9,-0.1,0.7,-0.2,-0.5,-0.2,-0.6,-0.1,-0.6,0;lines;2;,7,-1,yes,1,0,0.9,0.1,0.7,0.2,-0.5,0.2,-0.6,0.1,-0.6,0;lines;3;,5,-1,yes,-0.6,-0.1,-0.9,-0.2,-0.9,0;lines;4;,5,-1,yes,-0.6,0.1,-0.9,0.2,-0.9,0;lines;5;,3,-1,yes,0.5,-0.4,-0.5,-0.4,-0.5,-0.6,-0.4,-0.7,0.5,-0.4;lines;6;,5,-1,yes,-0.5,-0.6,-0.7,-0.7,-0.7,-0.3,-0.5,-0.4;lines;7;,7,-1,yes,-0.4,-0.4,-0.3,-0.3,-0.3,-0.2;lines;8;,7,-1,yes,0.3,-0.4,0.2,-0.3,0.2,-0.2;lines;9;,7,-1,yes,0.3,0.4,0.2,0.3,0.2,0.2;lines;10;,7,-1,yes,-0.4,0.4,-0.3,0.3,-0.3,0.2;lines;11;,5,-1,yes,-0.5,0.6,-0.7,0.7,-0.7,0.3,-0.5,0.4;lines;12;,3,-1,yes,0.5,0.4,-0.5,0.4,-0.5,0.6,-0.4,0.7,0.5,0.4;lines;13;,3,-1,yes,0.7,0,0.6,-0.1,0.4,-0.1,0.3,0,0.4,0.1,0.6,0.1,0.7,0;lines;14;,3,-1,yes,0.2,0,0.1,-0.1,-0.1,-0.1,-0.2,0,-0.1,0.1,0.1,0.1,0.2,0;lines;15;,3,-1,yes,0.9,-0.1,0.9,0.1,1,0,0.9,-0.1;
-- FILL_SPACESHIP:     collisions;1;,0.2,0,0.5;collisions;2;,-0.3,0,0.7;collisions;3;,0.7,0,0.3;collisions;4;,-0.6,-0.5,0.2;collisions;5;,-0.6,0.5,0.2;lines;1;,2,2,yes,1,0,0.9,-0.1,0.7,-0.2,-0.5,-0.2,-0.6,-0.1,-0.6,0,-0.6,0.1,-0.5,0.2,0.7,0.2,0.9,0.1;lines;2;,2,2,yes,0.5,-0.4,-0.5,-0.4,-0.5,-0.6,-0.4,-0.7,0.5,-0.4;lines;3;,1,1,yes,-0.5,-0.6,-0.7,-0.7,-0.7,-0.3,-0.5,-0.4,-0.5,-0.4;lines;4;,1,1,yes,0.7,0,0.6,-0.1,0.4,-0.1,0.3,0,0.4,0.1,0.6,0.1,0.7,0;lines;5;,1,1,yes,0.2,0,0.1,-0.1,-0.1,-0.1,-0.2,0,-0.1,0.1,0.1,0.1,0.2,0;lines;6;,1,1,yes,0.9,-0.1,0.9,0.1,1,0,0.9,-0.1;lines;7;,1,1,yes,-0.6,-0.1,-0.9,-0.2,-0.9,0.2,-0.6,0.1,-0.6,-0.1;lines;8;,1,1,yes,0.2,-0.3,0.3,-0.4,-0.4,-0.4,-0.3,-0.3,-0.3,-0.2,0.2,-0.2,0.2,-0.3;lines;9;,2,2,yes,0.5,0.4,-0.5,0.4,-0.5,0.6,-0.4,0.7,0.5,0.4;lines;10;,1,1,yes,-0.5,0.6,-0.7,0.7,-0.7,0.3,-0.5,0.4,-0.5,0.4;lines;11;,1,1,yes,0.2,0.3,0.3,0.4,-0.4,0.4,-0.3,0.3,-0.3,0.2,0.2,0.2,0.2,0.3;lines;12;,7,-1,yes,1,0,0.7,-0.2,0.2,-0.2,0.2,-0.3,0.3,-0.4,0.5,-0.4,-0.4,-0.7,-0.5,-0.6,-0.7,-0.7,-0.7,-0.3,-0.5,-0.4,-0.4,-0.4,-0.3,-0.3,-0.3,-0.2,-0.5,-0.2,-0.6,-0.1,-0.9,-0.2,-0.9,0.2,-0.6,0.1,-0.5,0.2,-0.3,0.2,-0.3,0.3,-0.4,0.4,-0.5,0.4,-0.7,0.3,-0.7,0.7,-0.5,0.6,-0.4,0.7,0.5,0.4,0.3,0.4,0.2,0.3,0.2,0.2,0.7,0.2,1,0;
-- CAT_COLLISIONS:     lines;1;,7,-1,yes,-1.2,-0.4,-1.3,0,-1.2,0.5,-0.8,0.9,-0.4,1,0,1;lines;2;,7,-1,yes,1.2,-0.4,1.3,0,1.2,0.5,0.8,0.9,0.4,1,0,1;lines;3;,7,-1,yes,0,0.4,0.2,0.3,0.1,0.2,-0.1,0.2,-0.2,0.3,0,0.4;lines;4;,7,-1,yes,0,0.4,0,0.5,-0.1,0.6,-0.2,0.6;lines;5;,7,-1,yes,0,0.4,0,0.5,0.1,0.6,0.2,0.6;lines;6;,7,-1,yes,0.6,0.2,0.5,0.1,0.5,-0.1,0.6,-0.2,0.7,-0.1,0.7,0.1,0.6,0.2;lines;7;,7,-1,yes,-0.6,0.2,-0.5,0.1,-0.5,-0.1,-0.6,-0.2,-0.7,-0.1,-0.7,0.1,-0.6,0.2;lines;8;,7,-1,yes,-1,-0.6,-0.8,-0.8,-0.5,-1,-0.1,-1.1,0,-1.1;lines;9;,7,-1,yes,1,-0.6,0.8,-0.8,0.5,-1,0.1,-1.1,0,-1.1;lines;10;,7,-1,yes,-1.2,-0.5,-1.1,-1.1,-0.9,-1.5,-0.5,-1;lines;11;,7,-1,yes,1.2,-0.5,1.1,-1.1,0.9,-1.5,0.5,-1;lines;12;,7,-1,yes,0.9,-1.5,0.8,-1.2,0.8,-0.8;lines;13;,7,-1,yes,-0.9,-1.5,-0.8,-1.2,-0.8,-0.8;lines;14;,7,-1,yes,0.9,0.3,1.2,0.3;lines;15;,7,-1,yes,-0.9,0.3,-1.2,0.3;lines;16;,7,-1,yes,0.9,0.2,1.1,0;lines;17;,7,-1,yes,-0.9,0.2,-1.1,0;lines;18;,7,-1,yes,0.9,0.4,1.1,0.6;lines;19;,7,-1,yes,-0.9,0.4,-1.1,0.6;collisions;1;,0.3,0,1;collisions;2;,-0.3,0,1;collisions;3;,-0.8,-0.9,0.4;collisions;4;,-0.9,-1.3,0.2;collisions;5;,-0.8,-0.6,0.4;collisions;6;,0.8,-0.9,0.4;collisions;7;,0.9,-1.3,0.2;collisions;8;,0.8,-0.6,0.4;collisions;9;,0,-0.3,0.9;
-- SAMPLE_FACE:        lines;1;,12,-1,yes,0.9,0,0.5,-0.8,-0.5,-1,-1,0,-0.8,0.5,-0.3,0.8,0.2,0.8,0.8,0.5,0.9,0;lines;2;,14,-1,yes,-0.3,-0.5,-0.5,-0.4,-0.5,-0.2,-0.3,-0.1,-0.1,-0.2,-0.1,-0.4,-0.3,-0.5;lines;3;,14,-1,yes,0.1,-0.4,0.1,-0.2,0.3,-0.1,0.5,-0.2,0.5,-0.4,0.3,-0.5,0.1,-0.4;lines;4;,8,-1,yes,-0.7,0.1,-0.5,0.3,-0.3,0.4,0,0.4,0.3,0.4,0.5,0.3,0.7,0.1;lines;5;,11,-1,yes,-0.5,-1,-0.3,-1.3,-0.1,-1.1,0.1,-1.2,0.2,-1.1,0.3,-1.3,0.5,-0.8;collisions;1;,0,-0.1,1;collisions;2;,0,-0.8,0.6;
-- PLAYER_MODEL:       lines;1;,9,-1,yes,0.5,0,-0.5,-0.3,-0.3,0,-0.5,0.3,0.5,0;collisions;1;,-0.3,0,0.3;collisions;2;,0,0,0.2;collisions;3;,0.2,0,0.1;collisions;4;,0.3,0,0.1;collisions;5;,0.4,0,0.1;






--_g.CATEROID         = parse_model[[collisions;1;,0.3,0,1;collisions;2;,-0.3,0,1;collisions;3;,-0.8,-0.9,0.4;collisions;4;,-0.9,-1.3,0.2;collisions;5;,-0.8,-0.6,0.4;collisions;6;,0.8,-0.9,0.4;collisions;7;,0.9,-1.3,0.2;collisions;8;,0.8,-0.6,0.4;collisions;9;,0,-0.3,0.9;lines;1;,7,-1,0,0.4,0.2,0.3,0.1,0.2,-0.1,0.2,-0.2,0.3,0,0.4;lines;2;,7,-1,0,0.4,0,0.5,-0.1,0.6,-0.2,0.6;lines;3;,7,-1,0,0.4,0,0.5,0.1,0.6,0.2,0.6;lines;4;,7,-1,0.6,0.2,0.5,0.1,0.5,-0.1,0.6,-0.2,0.7,-0.1,0.7,0.1,0.6,0.2;lines;5;,7,-1,-0.6,0.2,-0.5,0.1,-0.5,-0.1,-0.6,-0.2,-0.7,-0.1,-0.7,0.1,-0.6,0.2;lines;6;,7,-1,0.9,-1.5,0.8,-1.2,0.8,-0.8;lines;7;,7,-1,-0.9,-1.5,-0.8,-1.2,-0.8,-0.8;lines;8;,7,-1,0.9,0.3,1.2,0.3;lines;9;,7,-1,-0.9,0.3,-1.2,0.3;lines;10;,7,-1,0.9,0.2,1.1,0;lines;11;,7,-1,-0.9,0.2,-1.1,0;lines;12;,7,-1,0.9,0.4,1.1,0.6;lines;13;,7,-1,-0.9,0.4,-1.1,0.6;lines;14;,7,-1,0.9,-1.5,0.5,-1,0,-1.1,-0.5,-1,-0.9,-1.5,-1.1,-1.1,-1.2,-0.5,-1.3,0,-1.2,0.5,-0.8,0.9,-0.4,1,0.4,1,0.8,0.9,1.2,0.5,1.3,0,1.2,-0.5,1.1,-1.1,0.9,-1.5,0.5,-1;lines;15;,-1,1,0.5,-1,0,-1.1,-0.5,-1,-1.2,-0.6,-1.3,0,-1.2,0.5,-0.8,0.9,-0.4,1,0.4,1,0.8,0.9,1.2,0.5,1.3,0,1.2,-0.6,0.5,-1.1,0.5,-1;lines;16;,-1,1,0.9,-1.5,1.1,-1,1.2,-0.6,0.5,-1,0.9,-1.5;lines;17;,-1,1,-0.9,-1.5,-1.1,-1.1,-1.2,-0.6,-0.8,-0.8,-0.5,-1,-0.9,-1.5;]]
--

-- A : lines;1;,7,-1,-0.2,0.3,0,-0.3,0.2,0.3;lines;2;,7,-1,0.1,0,-0.1,0;
-- B : lines;1;,7,-1,-0.2,0.3,-0.2,-0.3;lines;2;,7,-1,-0.2,-0.3,0,-0.3,0.1,-0.2,0.1,-0.1,0,0,-0.2,0;lines;3;,7,-1,0,0,0.1,0,0.2,0.1,0.2,0.2,0.1,0.3,-0.2,0.3;
-- C : lines;1;,7,-1,0.2,-0.2,0,-0.3,-0.2,-0.2,-0.2,0.2,0,0.3,0.2,0.2;
-- D : lines;1;,7,-1,-0.2,0.3,0,0.3,0.2,0,0,-0.3,-0.2,-0.3,-0.2,0.3;
-- E : lines;1;,7,-1,-0.2,-0.3,-0.2,0.3,0.2,0.3;lines;2;,7,-1,-0.2,0,0,0;lines;3;,7,-1,-0.2,-0.3,0.2,-0.3;
-- F : lines;1;,7,-1,0.2,-0.3,-0.2,-0.3,-0.2,0.3;lines;2;,7,-1,-0.2,0,0,0;
-- G : lines;1;,7,-1,0.2,-0.2,0,-0.3,-0.2,-0.2,-0.2,0.2,0,0.3,0.2,0.2,0.2,0,0,0;
-- H : lines;1;,7,-1,0.2,-0.3,0.2,0.3;lines;2;,7,-1,0.2,0,-0.2,0;lines;3;,7,-1,-0.2,-0.3,-0.2,0.3; 
-- I : lines;1;,7,-1,-0.2,-0.3,0.2,-0.3;lines;2;,7,-1,0,-0.3,0,0.3;lines;3;,7,-1,0.2,0.3,-0.2,0.3;
-- J : lines;1;,7,-1,-0.2,-0.3,0.2,-0.3;lines;2;,7,-1,0,-0.3,0,0.2,-0.1,0.3,-0.2,0.2,-0.2,0;
-- K : lines;1;,7,-1,-0.2,-0.3,-0.2,0.3;lines;2;,7,-1,-0.2,0,-0.1,0,0.2,-0.3;lines;3;,7,-1,-0.1,0,0.2,0.3;
-- L : lines;1;,7,-1,-0.2,-0.3,-0.2,0.3,0.2,0.3;
-- M : lines;1;,7,-1,-0.2,0.3,-0.2,-0.3,0,0,0.2,-0.3,0.2,0.3;
-- N : lines;1;,7,-1,-0.2,0.3,-0.2,-0.3,0.2,0.3,0.2,-0.3;
-- O : lines;1;,7,-1,0,-0.3,-0.1,-0.3,-0.2,-0.2,-0.2,0.2,-0.1,0.3,0.1,0.3,0.2,0.2,0.2,-0.2,0.1,-0.3,0,-0.3;
-- P : lines;1;,7,-1,-0.2,0.3,-0.2,-0.3,0.1,-0.3,0.2,-0.2,0.2,-0.1,0.1,0,-0.2,0;
-- Q : lines;1;,7,-1,0,-0.3,-0.1,-0.3,-0.2,-0.2,-0.2,0.2,-0.1,0.3,0.1,0.3,0.2,0.2,0.2,-0.2,0.1,-0.3,0,-0.3;lines;2;,7,-1,0,0.2,-0.1,0.3,-0.2,0.3;
-- R :