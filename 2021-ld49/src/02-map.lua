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
        -- The width and height will be scaled so that the full_map is 128x32 tiles
        map      = {},
        width    = 32,
        height   = 8,
        full_map = {},

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

        -- Build the "full" map by converting every position in the (mini-)map into ratio*ratio positions (ratio must be a positive int).
        scale = function(this)
            local ratio = 4
            this.full_map = {}
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
        mset_all = function(this)
            for x=1,128 do
                for y=1,32 do
                    local tile = this:get_tile_for_square(x, y)
                    mset(x-1, y-1, tile)
                end
            end
        end,

        -- Get the tile to draw for this square, based on its type and the surrounding squares' types.
        get_tile_for_square = function(this, x, y)
            local FLOOR = 52
            local SOLID = 19
            local U     = 19
            local D     = 19
            local L     = 19
            local R     = 19
            local UR_E  = 19
            local UL_E  = 19
            local DR_E  = 19
            local DL_E  = 19
            --local UR_I  = 9
            --local UL_I  = 10
            --local DR_I  = 11
            --local DL_I  = 12
            
            local square = this.full_map[x][y]
            if square.type == 1 then return FLOOR
            else
                local floorU = y>1 and this.full_map[x][y-1].type != 0
                local floorL = x>1 and this.full_map[x-1][y].type != 0
                local floorR = x<this.width  and this.full_map[x+1][y].type != 0
                local floorD = y<this.height and this.full_map[x][y+1].type != 0

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
        floor:mset_all()
    end
    return floor
end
