t1=particle engine
t2=by alan morgan
files= src/brimstone.p8 src/firework.p8 src/lightning.p8 src/particle_engine.p8 src/rain.p8 src/smoke.p8 src/void.p8 src/colors.p8

out.p8: code.p8 res.p8
	cat code.p8 > out.p8
	tail --lines=+5 res.p8 >> out.p8
	rm code.p8

code.p8: src/demo.p8 $(files)
	echo -e "pico-8 cartridge // http://www.pico-8.com\nversion 8\n__lua__\n-- $(t1)\n-- $(t2)\n\n" > code.p8
	cat $^ >> code.p8

clean:
	rm out.p8
