-- the parameter is what should happen when the player opens the chest.
function gen_chest(x,y, func)
	local chest = gen_interactable(x, y)
	chest.spr=114
	chest.interact=
		function()
			if chest.spr != 115 then
				chest.spr = 115
				sfx(62)
				func()
			end
		end
	return chest
end

function gen_grave(x,y, str)
	local grave = gen_sign(x, y, str)
	grave.spr=4
	return grave
end

-- func is what should happen when the player tries reading the sign.
function gen_sign(x,y, str)
	local sign = gen_interactable(x, y)
	sign.spr = 19
	sign.interact = function() tbox(":"..str) end
	return sign
end

-- people have states so they may say different things at different times.
function gen_oldman(x,y, func)
	local oldie = gen_interactable(x, y)
	oldie.interact = function() func(oldie) end
	oldie.spr=97
	oldie.state=0
	return oldie
end

function gen_item(x,y, price, spr_ind, func)
	local item = gen_interactable(x, y)
	item.spr = spr_ind
	item.static = true
	item.price = price
	item.draw=
		function(self)
			draw_text(self.price, item.x-.5, item.y-1.3, 1)
			draw_actor(self)
		end

	-- only buy the item if you have enough power orbs.
	item.interact =
		function()
			if power_orb_count >= item.price then
				func(item)
				power_orb_count -= item.price
				item.alive = false
			else
				tbox("shopkeeper:hey, you don't have enough power orbs to buy that!")
			end
		end

	return item
end


-- things that are operated by pressing z below the object.
function gen_interactable(x, y, func)
	local thing = make_actor(x,y)
	thing.static=true
	if func != nil then
		thing.interact=func
	else
		thing.interact=function() end
	end

	thing.move=actor_interact

	return thing
end

function actor_interact(self)
	local x1 = -self.w
	local x2 =  self.w
	local y1 =  self.h
	local y2 =  2.5*self.h

	if is_pl_in_box_rel(self, x1, x2, y1, y2)
	and btnp(4) then
		self.interact()
	end
end

-- what happens when you find a heart container.
function heart_container()
	tbox(":you got a heart container.")
	tbox(":your max health is now increased by one.")
	pl.max_hearts += 1
	pl.hearts = pl.max_hearts

end

function gen_collectable(x, y)
	local collectable = make_actor(x, y)
	collectable.hit_boom = false
	collectable.inertia = 0
	collectable.touchable = false
	collectable.solid = false

	-- use a closure!
	collectable.hit=
		function(other)
			-- only collision with player if not hit boomerang.
			if other == pl and not collectable.hit_boom then
				collectable.alive = false
			elseif other == pl.boomerang and not collectable.hit_boom then
				collectable.hit_boom = true
				other.collect(collectable)
			end
		end

	return collectable
end

function gen_heart(x,y)
	local heart = gen_collectable(x,y)
	heart.spr = 35

	heart.destroy =
		function(self)
			pl.heal()
		end
	return heart
end

function gen_power_orb(x, y)
	local orb = gen_collectable(x,y)
	orb.spr = 55

	orb.destroy =
		function(self)
			power_orb_count += 1
		end
	return orb
end

function gen_sword_stand(x, y)
	-- create the sword first
	local sword = make_actor(x, y-1)
	sword.spr = 16
	sword.static = false
	sword.touchable = false
	sword.h = .4
	sword.draw=
		function(a)
			draw_actor(a, 1, 2, nil, nil)
		end

	-- now create the stand
	local stand = gen_interactable(x, y)
	stand.spr = 27
	stand.static = true
	stand.w = .5
	stand.interact = 
		function()
			if sword.alive then
				sfx(62)
				tbox(":you got the master sword. you can now deflect bullets.|voice:hero of hiroll, we entrust this sword with you.:beware of your friends.|lank:that was creepy.|ivan:hey, listen! you shouldn't listen to spontaneous voices like that.|lank:okay")
				sword.alive=false
				pl.has_sword = true
				pl.has_master = true
			end
		end

	stand.sw = 16
	stand.draw=
		function(a)
			draw_actor(a, 2, 1, nil, nil)
		end
end
