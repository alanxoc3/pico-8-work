function _init()
	global_time = 0
	tbox("bob@he:hello, my name is bob and my real name is not sid.:i am a carpenter")
end

function _update()
	tbox_interact()
	global_time += 1
end

function _draw()
	cls()
	tbox_draw()
	print('pico_project!', 20, 20, 7)
end
