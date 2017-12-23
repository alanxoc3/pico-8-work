function _init()
	tbox("bob@he:hello, my name is bob and my real name is not sid.:i am a carpenter")
end

function _update60()
	tbox_interact()
end

function _draw()
	cls()
	tbox_draw(7, 1)
	print('pico_project!', 20, 20, 7)
	print(g_tbox_anim, 20, 50, 7)
end
