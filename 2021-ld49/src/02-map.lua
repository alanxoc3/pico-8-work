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

        -- Swap value at current i with value at the random position
        local x = arr[i]
        arr[i] = arr[j]
        arr[j] = x
    end
    return arr
end

function create_map()
    local floor = {
        map    = {},
        width  = 32,
        height = 32,

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

        -- Convert every position in the map into ratio*ratio positions (ratio must be a positive int).
        scale = function(this, ratio)
            local newMap = {}
            for x = 1,this.width do
                for x2 = 1,ratio do
                    newMap[(x-1)*ratio+x2] = {}
                    for y = 1,this.height do
                        for y2 = 1,ratio do
                            newMap[(x-1)*ratio+x2][(y-1)*ratio+y2] = { type= this.map[x][y].type, seen= 1 }
                        end
                    end
                end
            end
            this.map = newMap
            this.width = ratio*this.width
            this.height = ratio*this.height
        end,

        draw = function(this)
            --TODO
        end
    }

    -- First build a perfect maze.
    floor:prefill()
    floor:carve(floor.width/2, floor.height/2)

    -- Clear out walls from a lot of relatively small areas, to make interestingly-shaped "rooms".
    local scoops = randBetween(floor:area()/200, floor:area()/50)
    for i = 1,scoops do
        floor:clearArea(floor:randArea(3, 8, 3, 8))
    end

    return floor
end
