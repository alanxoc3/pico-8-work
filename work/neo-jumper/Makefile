# jogging lawerence, made with <3 by Alan Morgan.

out.p8: code.p8 res.p8
	cat code.p8 > out.p8
	tail --lines=+5 res.p8 >> out.p8
	rm code.p8

code.p8: src/vars.p8 src/demo.p8 src/tile_collision.p8 src/box_in_collision.p8 src/structures.p8 src/pl.p8 src/buffers.p8 src/levels.p8 src/helpers.p8 src/logo.p8 src/title_screen.p8
	echo -e "pico-8 cartridge // http://www.pico-8.com\nversion 8\n__lua__\n-- the neo jumper\n-- by alan morgan\n\n" > code.p8
	cat $^ >> code.p8

clean:
	rm out.p8
