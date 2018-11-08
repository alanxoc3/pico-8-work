t1=the story of zeldo
t2=by alan morgan
files=src/engine.p8 src/boss.p8 src/canon.p8 src/draw.p8 src/enemy.p8 src/items.p8 src/lostwoods.p8 src/map.p8 src/move.p8 src/objects.p8 src/people.p8 src/pl.p8 src/shake.p8 src/story.p8 src/tbox.p8

out.p8: code.p8 res.p8
	cat code.p8 > out.p8
	tail --lines=+5 res.p8 >> out.p8
	rm code.p8

code.p8: $(files)
	echo -e "pico-8 cartridge // http://www.pico-8.com\nversion 8\n__lua__\n-- $(t1)\n-- $(t2)\n\n" > code.p8
	cat $^ >> code.p8

clean:
	rm out.p8
