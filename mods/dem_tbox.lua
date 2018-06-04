--- tokens: 49
function _init()
	tbox("sidney@idnum%23%199%3%10%293%19%0%-1:how old are you.:that's nice to know you are that old.|simon:wait what did you say?")
	tbox("|bob:hi")
end

function _update60()
	tbox_interact(function() end)
end

function _draw()
	cls()
	print("cpu: "..stat(1), 2, 64, 7)
	ttbox_draw(6, 1)
end
