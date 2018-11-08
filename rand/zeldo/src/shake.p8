------------------------------------------------------------------------------
-- screen shake implementation, taken from https://github.com/jessemillar/pico-8
-- slightly modified
------------------------------------------------------------------------------
function shake(reset) -- shake the screen
	camera(0,0) -- reset to 0,0 before each shake so we don't drift

	if not reset then -- if the param is true, don't shake, just reset the screen to default
		camera(flr(rnd(2)-1),flr(rnd(2)-1)) -- define shake power here (-1 to shake equally in all directions)
	end
end
