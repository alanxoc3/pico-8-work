function draw_particles(_state)
	for p in all(_state.cont) do
		_state.draw(p)
	end
end

function create_particles(_state, _x, _y)
	for i=1, _state.num do add(_state.cont, _state.create(_x, _y)) end
end

function update_particles(_state)
	for p in all(_state.cont) do
		if not _state.update(p) then
			del(_state.cont, p)
		end
	end
end
