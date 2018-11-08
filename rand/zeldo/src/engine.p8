scene_actors = {}
draw_map_funcs = {}
triggers = {}
marker = "title"  -- where you are in the story, start on title screen.
prev_marker = marker
global_time=0 -- the global timer of the game, used by text box functions

sleep = false -- used to sleep the update function

actors = {} -- all actors in world.
offh = 64
offw = 96

viewx = 0
viewy = 0


-------------------------
-- pico main
-------------------------
function _init()
	color(0)
	palt(0,false)
	srand(time())

	init_game()
	make_scenes()
	make_triggers()

	scene_init()
end

function _update()
	shake(true) -- reset the shake.

	-- only update if we are not in the middle of a marker change.
	if prev_marker == marker and not sleep then
		prev_marker = marker

		if marker == "title" then
			title_update()
		else
			scene_update()
		end

		if prev_marker != marker then
			scene_init()
			prev_marker = marker
		end
	end

	global_time=global_time+1 -- increment the clock
end

function is_pl_in_box(box)
	return pl.x > box.x1 and pl.x < box.x2 and pl.y > box.y1 and pl.y < box.y2
end

-- relative to the actor a passed.
function is_pl_in_box_rel(a, x1, y1, x2, y2)
	local box = {x1=a.x+x1, y1=a.y+y1, x2=a.x+x2, y2=a.y+y2}
	return is_pl_in_box(box)
end

-- make an actors and add to global collection.
-- x,y means center of the actors, in map tiles (not pixels).
function make_actor(x, y)
	local a={}

	-- if true, then this object cannot be moved by other objects.
	a.static=false

	-- if false, then you can walk through walls.
	a.solid=true

	-- if false, then you can go through other actors.
	-- but the hit function will still be called.
	a.touchable=true

	-- which side are you on?
	a.good = false
	a.bad  = false

	-- if this number is higher than zero, then the move function won't be
	-- called for your sprite until the timer goes down.
	a.stun  = 0

	-- if false, then the draw function for the sprite is not called.
	a.visible=true

	-- position and speed.
	a.x = x
	a.y = y
	a.dx = 0.0
	a.dy = 0.0

	-- images
	a.spr = 16

	-- sprite width and sprite height used to get a correct offset.
	a.sw = 8
	a.sh = 8

	-- frame  = current frame
	-- frames = number of frames
	a.frame = 0
	a.frames=1

	-- every actor has a relative time.
	-- time is stopped when off the screen.
	a.t = 0

	-- if 0, then no friction. if 1, then lots of friction.
	a.inertia = 0.6

	-- if 1, then no loss of speed when you bounce.
	a.bounce  = .3

	-- if false, then object is removed from the actors.
	a.alive = true

	-- if true, then you are out of the main screen and the buffer.
	-- see is_in_bounds for buffer information.
	a.is_outside = false
	
	-- radius width and height
	-- .5 would be one block
	-- make it a bit smaller to fit through smaller holes
	a.w = 0.4
	a.h = 0.4
	
	-- draw with draw actor. it makes white transparent.
	-- called every frame as long as actor is alive
	a.draw = draw_actor

	-- called every frame as long as actor is alive
	a.move = function(self) end

	-- called if two actors are in bounds (not outside) and are touching each
	-- other.
	a.hit = function(other) end

	-- gets called if the actor is leaving the scene
	a.unload = function() end

	-- gets called if the actor is entering the scene
	a.load = function() end

	-- gets called if the actor is out of bounds.
	a.outside = function(self) end

	-- gets called right before the actor is deleted.
	a.destroy = function(self) end

	add(actors,a)
	
	return a
end

-- returns true if the coordinate is solid on the map.
function solid_on_map(x, y)
	local val=mget(x, y)
	return fget(val, 1)
end

-- returns true if the dimensions given touch a wall.
-- only works for dimensions smaller than .5 (1 tile big)
function solid_area(x,y,w,h)
	return 
		solid_on_map(x-w,y-h) or
		solid_on_map(x+w,y-h) or
		solid_on_map(x-w,y+h) or
		solid_on_map(x+w,y+h)
end

-- returns true if character is within the buffer.
-- the buffer is the bounds of the screen (16x16 tiles) plus 8 tiles.
-- so in all it is a 24x24 region.
function is_in_bounds(a)
	local left = pl.x - 16
	local right = pl.x + 16
	local top = pl.y - 16
	local bottom = pl.y + 16
	return a.x > left and a.x < right and a.y > top and a.y < bottom
end

-- updates the status of whether actors are out of bounds or not.
-- also calls the the outside function if
function update_outside()
	for a in all(actors) do
		a.is_outside = not is_in_bounds(a)
		if a.is_outside then
			a.outside(a)
		end
	end
end

-- returns a list of all actors hit. will return nil if none were hit.
-- or if this is out of bounds.
-- bounds. won't check for actors that are out of bounds.
-- also does not work with overlapping actors.
function actor_collision(a, dx, dy)
	local retlist = {}

	if not a.is_outside then
		for a2 in all(actors) do
			if not a2.is_outside and a != a2 then
				local x=(a.x+dx) - a2.x
				local y=(a.y+dy) - a2.y
				if ((abs(x) < (a.w+a2.w)) and
					(abs(y) < (a.h+a2.h)))
				then 
					-- check if moving together
					if (dx != 0 and abs(x) <
							abs(a.x-a2.x)) then
						if a.touchable and a2.touchable then
							v=a.dx + a2.dx
							if not a.static then a.dx = v/2 end
							if not a2.static then a2.dx = v/2 end
						end
						add(retlist, a2)
					elseif (dy != 0 and abs(y) <
									abs(a.y-a2.y)) then
						if a.touchable and a2.touchable then
							v=a.dy + a2.dy
							if not a.static then a.dy = v/2 end
							if not a2.static then a2.dy = v/2 end
						end
						add(retlist, a2)
					end
				end
			end
		end
	end

	return retlist
end

-- checks just walls
function touching_wall(a, dx, dy)
	return a.solid and solid_area(a.x+dx,a.y+dy, a.w,a.h)
end

-- calls the hit function for each actor touching a.
function hit_actors(a,alist)
	-- hits with the main actor.
	for other in all(alist) do
		a.hit(other)
		other.hit(a)
	end
end

-- existential function for touchable items.
function has_touchable(actor_list)
	for a in all(actor_list) do
		if a.touchable then
			return true
		end
	end
	return false
end

-- figures out speed for collisions or doesn't change the speed.
-- and hurts the actors.
function move_actor_check(a, dx, dy)
	if not touching_wall(a, dx, dy) then
		local other_list = actor_collision(a, dx, dy) 

		if #other_list != 0 then
			hit_actors(a,other_list)

			if a.touchable and has_touchable(other_list) then
				dx *= -a.bounce
				dy *= -a.bounce
				--sfx(60)
			end
		end

	else   
		-- otherwise bounce
		dx *= -a.bounce
		dy *= -a.bounce
		--sfx(60)
	end

	return dx + dy
end


function move_actors()
	-- first set all actor's speed.
	foreach(actors, set_actor_speed)

	-- then set all of their coordinates.
	foreach(actors, set_actor_pos)
end

function set_actor_speed(a)
	if a.is_outside then
		return
	end

	if a.move != nil then
		if a.stun <= 0 then
			a.move(a)
		else
			a.stun -= 1
		end

	a.dx = move_actor_check(a, a.dx, 0)
	a.dy = move_actor_check(a, 0, a.dy)
	end
end

function set_actor_pos(a)
	if a.is_outside then
		return
	end

	-- update the position then apply inertia.
	a.x += a.dx
	a.y += a.dy

	a.dx *= a.inertia
	a.dy *= a.inertia
	
	-- advance one frame every
	-- time actors moves 1/4 of
	-- a tile
	a.frame += abs(a.dx) * 4
	a.frame += abs(a.dy) * 4
	a.frame %= a.frames

	a.t += 1
end

function offset_x()
	return -viewx * 8 + 64
end

function offset_y()
	return -viewy * 8 + 64
end

function scene_update()
	if not tbox_active() then
		map_update()
		trigger_update()
		view_update()
	else
		tbox_interact()
	end
end

-- triggers are boxes you collide with that can make events happen.
-- pos is where the player gets teleported to if the trigger is touched.
function make_trigger(name, x1, y1, x2, y2, pos, mark, mus, snd)
	local func=nil
	if mark != nil then
		func = function() transition(mark, mus, snd) end
	end

	triggers[name] = {box={x1=x1, y1=y1, x2=x2, y2=y2}, active=true, pos=pos, func=func}
end

-- used for debugging purposes.
--function draw_triggers()
--	for k,v in pairs(triggers) do
--		rect(v.box.x1*8 + offset_x(),
--			  v.box.y1*8 + offset_y(),
--			  v.box.x2*8 + offset_x(),
--			  v.box.y2*8 + offset_y(), 10)
--	end
--end

function trigger_update()
	for k, v in pairs(triggers) do
		if v.active and is_pl_in_box(v.box) then
			v.func()
			if v.pos != nil then
				pl.x = v.pos.x
				pl.y = v.pos.y
			end
		end
	end
end

-- updates the view with the player's coordinates. call whenever the player
-- changes position.
function view_update()
	viewx = pl.x
	viewy = pl.y
end

function title_update()
	if btnp(4) then
		transition("hut", 63, 63)
	end
end

-- a super useful function. pass in the sprite id and this will return the
-- transparency color.
function get_alt(id)
	if id == 43 or
	   id == 44 or
	   id == 56 or
	   id == 57 then
		return 15
	elseif id == 16 or
	       id == 27 or
	       id == 28 or
	       id == 32 or
	       id == 48 or
	       id == 112 or
	       id == 119 or
	       id == 113 then
		return 0
	end

	-- def is 7 for this game.
	return 7
end

function del_if_enemy(enemy)
	-- all enemies are bad.
	if enemy.bad then
		del(actors, enemy)
	end
end

function clean_enemies()
	foreach(actors, del_if_enemy)
end

-- use right before changing the scene.
function save_scene()
	-- should call this on multiple actors eventually.
	for a in all(actors) do
		a.unload()
	end
	actors = {}
end

-- use when switching to a new scene.
-- x and y are the player's new coordinates.
function load_scene(scene_name)
	save_scene()
	actors = scene_actors[scene_name]

	add(actors, pl)

	for a in all(actors) do
		a.load()
	end

	view_update()

end

function draw_wrap(x,y,w,h, off)
	if off == nil then
		off = 2
	end

	-- first calculate how many times the loop must go.
	-- the screen midpoint is 8. so i need to wrap to 8 at least.
	local count= flr((8-off)/off)

	local offx = -pl.x*8+64
	local offy = -pl.y*8+64

	-- rest is for wrapping.
	for i=1, count, 1 do
		-- left part screen
		map(x, y, x*8 + -i*8*off + offx, y*8 + offy, off, h)

		-- top part screen
		map(x, y, x*8 + offx, y*8 + -i*8*off + offy, w, off)
	end

	for i=0, count-1, 1 do
		-- right part screen
		map(x+w - off, y, (x+w)*8 + i*8*off + offx, y*8 + offy, off, h)

		-- bottom part screen
		map(x, y+h - off, x*8 + offx, (y+h)*8 + i*8*off + offy, w, off)
	end

	for i=0, count-1, 1 do
		for j=0, count-1, 1 do
			-- bl corner
			map(x, (y+h)-off, x*8 + i*8*off - count*8*off + offx, j*8*off + (y+h)*8 + offy, off, off)

			-- br corner
			map((x+w)-off, (y+h)-off, i*8*off + (x+w)*8 + offx, j*8*off + (y+h)*8 + offy, off, off)

			-- tr corner
			map((x+w)-off, y, i*8*off + (x+w)*8 + offx, y*8 + j*8*off - count*8*off + offy, off, off)

			-- tl corner
			map(x, y, x*8 + i*8*off - count*8*off + offx, y*8 + j*8*off - count*8*off + offy, off, off)
		end
	end
end

------------------
-- game control!!!
------------------
function garbage_collection()
	foreach(actors,
		function(a)
			if a.alive == false then
				a.destroy()
				del(actors, a)
			end
		end)
end

function map_update()
	if pl.alive then
		move_actors()
	end

	-- call outside and destroy functions
	update_outside()
	garbage_collection()
end

function dice_roll(sides)
	return flr(rnd(sides)) == 1
end

