function _init()
	tbox("@he:0 1 2 3 4 5 6 7 8 9 0 1 2 3 4:hello, my name is bob and my real name is not sid.:i am a carpenter|hello:meep:no")
end

function _update60()
	tbox_interact()
end

function _draw()
	cls()
	print("cpu: "..stat(1), 2, 64, 7)
	tbox_draw(7, 0, 2, true)
	tbox_draw(7, 0, 2, false)
end
