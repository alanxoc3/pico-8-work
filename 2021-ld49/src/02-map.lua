-- Random number between lo and hi, inclusive.
function randBetween(lo, hi)
    local diff = hi-lo+1
    local norm = flr(rnd() * diff)
    return lo + norm
end

-- Shuffle an array.
function shuffleArr(arr)
    for i = 1,#arr do
        local j = 1 + flr(rnd() * i) -- Random position between 1 and i
        arr[i], arr[j] = arr[j], arr[i]
    end
    return arr
end

function create_map()
    local floor = {
        map      = {},
        full_map = {},

        -- The width and height will be scaled so that the full_map is 108x32 tiles (saving 20x32 for boss room).
        -- These are currently UNCONFIGURABLE.
        width    = 27,
        height   = 8,
        ratio    = 4,

        dirs = {
            { dy = -1 }, -- N
            { dy =  1 }, -- S
            { dx =  1 }, -- E
            { dx = -1 }  -- W
        },

        area = function(this)
            return this.width * this.height
        end,

        -- Intialize the map to a matrix of width*height containing only walls.
        prefill = function(this)
            for x = 1,this.width do
                this.map[x] = {}
                for y = 1,this.height do
                    this.map[x][y] = { type= 0, seen= x==1 or x==this.width or y==1 or y==this.height }
                end
            end
        end,

        -- Recursively carve out a perfect maze from the map, starting at the given position.
        carve = function(this, x0, y0)
            -- Check that curr position was not seen before (accounts for bounds checking).
            if this.map[x0][y0].seen then return end
            this.map[x0][y0].seen = true
            local dir_ids = shuffleArr({1,2,3,4})

            -- If at most 1 surrounding square is already carved, then carve this one.
            local count = 0
            foreach(dir_ids, function(dir_id)
                local dir = this.dirs[dir_id]
                local x1 = x0 + (dir.dx or 0)
                local y1 = y0 + (dir.dy or 0)
                if this.map[x1][y1].type != 0 then count = count + 1 end
            end)
            if count > 1 then return end
            this.map[x0][y0].type = 1 -- Carve!

            -- Try to carve surrounding squares (can bias order here for different effects).
            foreach(dir_ids, function(dir_id)
                local dir = this.dirs[dir_id]
                local x1 = x0 + (dir.dx or 0)
                local y1 = y0 + (dir.dy or 0)
                this:carve(x1, y1)
            end)
        end,

        -- Clear all walls within the given area.
        clearArea = function(this, area)
            for x = 1,area.w do
                for y = 1,area.h do
                    this.map[x+area.x][y+area.y] = { type= 1, seen= true }
                end
            end
        end,

        -- Create a randomly-sized area within the given size bounds, at a random position such that the area fits in the map.
        randArea = function(this, wmin, wmax, hmin, hmax)
            wmin = mid(1, wmin, this.width-2)
            wmax = mid(1, wmax, this.width-2)
            hmin = mid(1, hmin, this.height-2)
            hmax = mid(1, hmax, this.height-2)
            local w = randBetween(wmin, wmax)
            local h = randBetween(hmin, hmax)
            local x = randBetween(1, this.width-2-w)
            local y = randBetween(1, this.height-2-h)
            return { x=x, y=y, w=w, h=h }
        end,

        -- Build the "full" map by converting every position in the (mini-)map into ratio*ratio positions.
        scale = function(this)
            this.full_map = {}
            local ratio = this.ratio
            for x = 1,this.width do
                for x2 = 1,ratio do
                    this.full_map[(x-1)*ratio+x2] = {}
                    for y = 1,this.height do
                        for y2 = 1,ratio do
                            this.full_map[(x-1)*ratio+x2][(y-1)*ratio+y2] = { type= this.map[x][y].type }
                        end
                    end
                end
            end
            -- Look for kitty-corner walls in the mini-map, and add tiles to smooth them out.
            local loc = function(p) return (p-1)*ratio+1 end
            for x = 1,this.width do
                for y = 1,this.height do
                    -- I am a wall, with floor to my bottom and right, and wall to my bottom-right.
                    -- I am a wall, with floor to my bottom and left,  and wall to my bottom-left.
                    if this.map[x][y].type == 0 then -- I am a wall...
                        local wallL  = x>1           and this.map[x-1][y].type == 0
                        local wallR  = x<this.width  and this.map[x+1][y].type == 0
                        local wallD  = y<this.height and this.map[x][y+1].type == 0
                        local wallDL = x>1           and y<this.height and this.map[x-1][y+1].type == 0
                        local wallDR = x<this.width  and y<this.height and this.map[x+1][y+1].type == 0

                        if not wallD and not wallR and wallDR then
                            this.full_map[loc(x)+ratio][loc(y)+ratio-1] = { type=0 }
                            this.full_map[loc(x)+ratio-1][loc(y)+ratio] = { type=0 }
                        end
                        if not wallD and not wallL and wallDL then
                            this.full_map[loc(x)][loc(y)+ratio]     = { type=0 }
                            this.full_map[loc(x)-1][loc(y)+ratio-1] = { type=0 }
                        end
                    end
                end
            end
        end,

        -- Draw the mini-map in the bottom-right of the screen.
        draw_mini = function(this)
            local x0 = 127-this.width
            local y0 = 127-this.height
            for x=1,this.width do
                for y=1,this.height do
                    local color = this.map[x][y].type == 0 and 8 or 9
                    pset(x0+x, y0+y, color)
                end
            end
        end,

        -- mset all squares onto the pico8 map.
        mset_all = function(this, theme)
            for x=1,108 do
                for y=1,32 do
                    local tile = this:get_tile_for_square(x, y, theme)
                    mset(x-1, y-1, tile)
                end
            end
        end,

        -- Get the tile to draw for this square, based on its type and the surrounding squares' types.
        get_tile_for_square = function(this, x, y, theme)
            local FLOOR1 =  4
            local FLOOR2 = 52
            local SOLID  = theme and 48 or 32
            local U      = theme and 23 or 19
            local D      = theme and 38 or 34
            local L      = theme and 23 or 19
            local R      = theme and 23 or 19
            local UR_E   = theme and 23 or 19
            local UL_E   = theme and 23 or 19
            local DR_E   = theme and 38 or 34
            local DL_E   = theme and 38 or 34
            
            local square = this.full_map[x][y]
            if square.type == 1 then return rnd() < .5 and FLOOR1 or FLOOR2
            else
                local floorU = y>1 and this.full_map[x][y-1].type != 0
                local floorL = x>1 and this.full_map[x-1][y].type != 0
                local floorR = x<this.width*this.ratio  and this.full_map[x+1][y].type != 0
                local floorD = y<this.height*this.ratio and this.full_map[x][y+1].type != 0

                if     floorU and floorR then return UR_E
                elseif floorU and floorL then return UL_E
                elseif floorD and floorR then return DR_E
                elseif floorD and floorL then return DL_E
                elseif floorU then return U
                elseif floorD then return D
                elseif floorL then return L
                elseif floorR then return R
                else return SOLID end
            end
        end
    }

    -- First build a perfect maze.
    floor:prefill()
    floor:carve(flr(floor.width/2), flr(floor.height/2))

    -- Clear out walls from a lot of relatively small areas, to make interestingly-shaped "rooms".
    local scoops = randBetween(flr(floor:area()/200), flr(floor:area()/50))
    for i = 1,scoops do
        floor:clearArea(floor:randArea(2, 5, 2, 5))
    end

    floor:scale()
    if _g.c_enable_procgen_map then
        floor:mset_all(true) -- false for "dark", true for "light"
    end
    return floor
end
