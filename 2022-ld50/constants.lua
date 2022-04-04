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
-- FONTMODELS_FONT_E:  lines;1;,7,-1,yes,1.9,-2.8,-0.8,-2.8,-1.1,-2.7,-1.3,-2.5,-1.5,-2,-1.5,1.5,-1.3,1.9,-1,2.3,-0.7,2.5,-0.1,2.6,0.7,2.7,1.7,2.7,2,2.6,2.2,2.5,2.3,2,2.3,1.2,2.1,0.9,1.7,0.8,0.8,0.8,0.6,0.7,0.6,0.4,0.8,0.2,1.5,0.2,1.7,0.1,1.8,-0.1,1.8,-0.4,1.7,-0.5,0.7,-0.5,0.5,-0.7,0.5,-1,1.1,-1.2,1.7,-1.3,2.1,-1.5,2.3,-1.7,2.3,-2.5,2.2,-2.7,1.9,-2.8;
-- FONTMODELS_FONT_D:  lines;1;,7,-1,yes,-1.9,-2.9,-1.1,-2.9,-0.1,-2.8,1,-2.5,1.6,-2.1,1.7,-1.5,1.9,-0.2,1.9,0.9,1.7,2,1.4,2.8,1.1,2.9,-0.1,2.9,-1.3,2.8,-1.6,2.5,-1.7,2,-1.7,1.1,-1.6,0,-1.5,-1.1,-1.5,-1.5,-1.6,-1.6,-1.9,-1.7,-2,-2,-2,-2.8,-1.9,-2.9;lines;2;,7,-1,yes,-0.3,-0.6,0.3,-0.4,0.5,0,0.4,0.5,0.1,0.8,-0.4,0.8,-0.5,0.6,-0.3,-0.6;
-- FONTMODELS_FONT_H:  lines;1;,7,-1,yes,-0.5,-0.7,0.5,-0.7;lines;2;,7,-1,yes,-0.5,0.6,0.5,0.6;lines;3;,7,-1,yes,-0.5,-0.7,-0.5,-2.4,-0.7,-2.6,-1.2,-2.8,-1.7,-2.7,-2.1,-2.4,-2.2,-1.5,-2.2,1.5,-2,3,-1.7,3.2,-1.3,3.2,-0.8,3,-0.7,2.6,-0.6,0.6;lines;4;,7,-1,yes,0.6,0.6,0.8,2.6,1.1,3,1.6,3.2,2.1,3.1,2.3,2.6,2.4,1.2,2.3,-1.1,2.2,-2.4,1.9,-2.8,1.2,-2.9,0.7,-2.8,0.5,-2.4,0.5,-1.9,0.6,-0.7;
-- FONTMODELS_FONT_K:  lines;1;,7,-1,yes,0.5,1.6,1,2.7,1.5,2.9,1.9,2.9,2.2,2.6,2.2,2,1.7,0.8,1.4,0.1,1.9,-1;lines;2;,7,-1,yes,1.9,-1,2.3,-2,2.3,-2.6,2.1,-2.8,1.3,-2.8,0.9,-2.6,0.4,-1.6;lines;3;,7,-1,yes,0,-1.7,0,-0.9,0.4,-1.6;lines;4;,7,-1,yes,-1,-2.8,-1.3,-2.6,-1.5,-2,-1.5,0.5,-1.4,1.7,-1.3,2.8,-1.1,3;lines;5;,7,-1,yes,-1,-2.8,-0.4,-2.8,-0.1,-2.5,0,-1.9,0,-0.9;lines;6;,7,-1,yes,-1.1,3,-0.4,3,-0.2,2.9,0,2.1,0,0.9;lines;7;,7,-1,yes,0.5,1.6,0,0.9;
-- FONTMODELS_FONT_L:  lines;1;,7,-1,yes,0,-1.9,0,0.8,0.2,1.1,0.4,1.2,1.4,1.2,1.7,1.3,1.9,1.5,1.9,2.2,1.8,2.6,1.4,2.8,0.8,2.9,-1.3,2.9,-1.6,2.8,-1.8,2.5,-1.9,1.5,-1.9,-1.5,-1.8,-2.2,-1.5,-2.6,-1.1,-2.8,-0.4,-2.8,-0.1,-2.7,0,-2.2,0,-1.9;
-- FONTMODELS_FONT_B:  lines;1;,7,-1,yes,0.8,-0.4,1.2,-0.8,1.3,-1.1,1.3,-1.8,1.2,-2.3,0.9,-2.7,0.4,-2.9,0,-3,-0.7,-3,-1.2,-2.9,-1.9,-2.8,-2.2,-2.7,-2.5,-2.5,-2.5,-2.3,-2.4,-2,-2.2,-1.9,-1.9,-1.9,-1.7,-1.6,-1.6,-1.1,-1.5,-0.6,-1.5,0,-1.6,0.8,-1.7,1.5,-1.9,2.2,-1.9,2.4,-1.8,2.6,-1.3,2.8,-0.6,2.9,-0.1,2.9,0.5,2.8,1.1,2.6,1.4,2.5,1.6,2.1,1.7,1.7,1.7,1.3,1.6,0.8,1.3,0.4,0.9,0.1,0.5,-0.1,0.8,-0.4;lines;2;,7,-1,yes,-0.6,-1.7,-0.5,-1.5,-0.5,-1.1,-0.2,-1.1,0,-1.2,0.1,-1.4,0,-1.7,-0.3,-1.9,-0.7,-1.9,-0.6,-1.7;lines;3;,7,-1,yes,-0.5,0.8,-0.6,1.2,-0.8,1.6,-0.5,1.8,0,1.8,0.4,1.6,0.4,1.3,0.3,1,0,0.8,-0.5,0.7,-0.5,0.8;
-- FONTMODELS_FONT_F:  lines;1;,7,-1,yes,-1.5,2.1,-1.5,-2.2,-1.3,-2.5,-0.9,-2.8,1.8,-2.8,2.2,-2.7,2.4,-2.4,2.4,-1.4,2.2,-1,1.7,-0.8,0.7,-0.8,0.5,-0.7,0.5,-0.4,0.8,-0.2,1.5,-0.2,1.7,-0.1,1.8,0.1,1.8,0.6,1.6,0.8,1.4,0.9,0.5,0.9,0.3,1.1,0.2,1.5,0.2,2.4,0.1,2.6,-0.1,2.8,-1.1,2.8,-1.3,2.6,-1.5,2.1;
-- FONTMODELS_FONT_A:  lines;1;,7,-1,yes,1.5,0,2.3,0,2.5,-0.2,2.8,-1.3,2.5,-3.4,2.1,-4.3,1.6,-4.7,0.4,-4.8,-0.3,-4.7,-0.8,-4.1,-0.8,-4,-0.8,-3.9,-1.7,-0.8,-1.5,-0.3,-1,-0.1,-0.4,-0.1,0,-0.4,0.5,-1,0.9,-1.1,1.2,-1,1.4,-0.5,1.5,0;lines;2;,7,-1,yes,1,-3.5,1.3,-3.1,1.4,-2.5,1.3,-2.3,0.9,-2.2,0.5,-2.5,0.5,-3,0.9,-3.4,1.1,-3.5;
-- FONTMODELS_FONT_I:  lines;1;,7,-1,yes,-0.4,2.8,0.4,2.8,0.7,2.6,0.9,2.2,0.9,0.2,0.7,-1.5,0.6,-2.3,0.4,-2.5,0,-2.6,-0.4,-2.5,-0.7,-2.3,-0.8,-1.9,-1,-0.1,-1,1.9,-0.9,2.5,-0.7,2.7,-0.4,2.8;
-- FONTMODELS_FONT_C:  lines;1;,7,-1,yes,1.2,-0.2,1.8,-0.5,2.4,-1.1,2.7,-1.8,2.6,-2.1,2.2,-2.3,1.9,-2.2,1.4,-2.5,0.6,-2.7,-0.4,-2.7,-1.2,-2.5,-1.9,-2,-2.5,-1.3,-2.8,-0.7,-2.8,0.5,-2.5,1.2,-2.1,1.9,-1.5,2.4,-0.8,2.8,-0.1,2.9,0.7,2.8,1.5,2.5,2.2,2,2.3,1.7,2.3,1.5,2.1,1.1,1.6,0.6,1.2,0.6,0.9,0.8,0.5,1,0,1,-0.4,0.7,-0.6,0.3,-0.6,-0.1,-0.4,-0.4,0,-0.6,0.4,-0.5,0.8,-0.3,1,-0.2,1.2,-0.2;
-- FONTMODELS_FONT_P:  lines;1;,7,-1,yes,0,-2.7,0.6,-2.7,1.3,-2.4,1.7,-1.9,1.9,-1.3,1.9,-0.6,1.7,-0.1,1.3,0.4,0.8,0.6,0,0.7;lines;2;,7,-1,yes,0,-2.7,-1,-2.6,-2,-2.5,-2.2,-2.3,-2.2,-1.7,-2.2,-1.5,-2,-1.3,-1.7,-1.3,-1.5,-1,-1.4,0.1,-1.4,1.9,-1.4,2.6,-1.3,2.9,-1.1,3,-0.5,3,-0.1,2.9,0,2.6,0,0.7;lines;3;,7,-1,yes,-0.1,-1.5,0.2,-1.5,0.5,-1.3,0.6,-1,0.4,-0.7,0,-0.6,-0.2,-0.6,-0.3,-1,-0.4,-1.4,-0.1,-1.5;
-- FONTMODELS_FONT_G:  lines;1;,7,-1,yes,2.2,0.9,2.2,1.9,2,2.3,1.6,2.5,0.7,2.6,-0.2,2.6;lines;2;,7,-1,yes,1.7,-1.9,1,-2.3,0.2,-2.5,-0.7,-2.4,-1.4,-2,-1.9,-1.6,-2.2,-1.1,-2.5,-0.2,-2.5,0.6,-2.2,1.3,-1.7,1.9,-1.1,2.3,-0.4,2.6,0.5,2.7,1.6,2.5,2,2.3,2.2,1.9,2.2,1,2.3,0.7,2.6,0.4,2.7,0.1,2.6,0;lines;3;,7,-1,yes,2.6,0,2.3,-0.1,1,-0.1,0.7,-0.1,0.5,0,0.5,0.2,0.7,0.4,0.6,0.7,0.2,0.8,-0.2,0.7,-0.4,0.3,-0.3,-0.2,0,-0.7,0.4,-0.8,1,-1,1.5,-0.9,2,-0.8,2.2,-1,2.3,-1.4,2.3,-1.9,2.1,-2,1.8,-1.9;
-- FONTMODELS_FONT_M:  lines;1;,7,-1,yes,1,-2.5,1.7,-2.5,2.1,-2.3,2.3,-1.7,2.6,0,2.6,1.1,2.4,2.3,2,2.8,1.2,2.9,0.8,2.8;lines;2;,7,-1,yes,1,-2.5,0.7,-2.5,0.3,-2.2,0.1,-1.8;lines;3;,7,-1,yes,0.1,-1.7,-0.2,-2.2,-0.7,-2.5,-1.6,-2.5,-2,-2.2;lines;4;,7,-1,yes,-2,-2.2,-2.3,-1.2,-2.4,1.4,-2.2,2.6,-1.9,2.9,-1.1,2.9,-0.7,2.8,-0.5,2.4,-0.5,1.5;lines;5;,7,-1,yes,-0.5,1.5,-0.5,0.4,-0.2,0.6,0,0.6,0.3,0.4,0.5,0.3,0.6,1.3,0.8,2.8;
-- FONTMODELS_FONT_N:  lines;1;,7,-1,yes,-2.2,-0.6,-2.2,2.5,-2,2.8,-1.6,2.9,-0.9,2.9,-0.6,2.7,-0.4,1,0.4,2.6,0.8,2.9,1.5,2.9,1.9,2.8,2.1,2.3,2.2,1.3,2.2,-1.5,2,-2.2,1.6,-2.5,1.1,-2.5,0.7,-2.5,0.6,-2.3,0.5,-1.9;lines;2;,7,-1,yes,0.5,-1.9,0.4,-0.7,-0.6,-2.4,-0.9,-2.5,-2.2,-2.5,-2.5,-2.4,-2.5,-1.7,-2.5,-1.3,-2.3,-1.1,-2.2,-0.9,-2.2,-0.6;
-- FONTMODELS_FONT_J:  lines;1;,7,-1,yes,1.7,-1.5,1.7,0.8,1.6,1.6,1.1,2.3,0.5,2.6,-0.4,2.8,-1,2.6,-1.5,2.3,-1.9,1.7,-2,1,-1.9,0.6,-1.6,0.4,-1.2,0.2;lines;2;,7,-1,yes,-1.2,0.2,-1.1,0.3,-0.7,1,-0.3,1.3,0,1.4,0.4,1.3,0.6,0.7,0.5,-0.2,0.4,-0.6,0.1,-0.7,-0.3,-0.8,-0.9,-0.8,-1.1,-1,-1.2,-1.4,-1.2,-1.9,-1,-2.2,-0.5,-2.3,0.2,-2.3,1.3,-2.3,1.5,-2.2,1.7,-1.8,1.7,-1.5;
-- FONTMODELS_FONT_O:  lines;1;,7,-1,yes,-0.5,-2.5,0.6,-2.5,1.2,-2.3,1.9,-1.6,2.2,-0.8,2.2,1.1,1.9,1.9,1.3,2.5,0.4,2.9,-0.4,2.9,-1.4,2.4,-1.8,1.9,-2.2,1,-2.2,-0.7,-1.8,-1.7,-1.3,-2.2,-0.5,-2.5;lines;2;,7,-1,yes,-0.2,-0.7,0.2,-0.7,0.5,-0.2,0.5,0.3,0.2,0.7,-0.2,0.7,-0.5,0.2,-0.5,-0.2,-0.2,-0.7;

