
local astro = Astro.Table


local function normSqr(a)

    local b = 0         for k,v in pairs(a) do b = b + v ^ 2 end

    return b

end

local function norm(a)
    
    local normSqr = normSqr(a)          return math.sqrt(normSqr) 

end


local coords = { 'x', 'y', 'z' }

local function unit(a)
    
    local norm = norm(a)

	for i,v in ipairs(coords) do
        
        local k = v         v = a[v]
        
        if v and v ~= 0 then a[k] = v / norm end 
    
    end

	return a

end

local function isZero(a)

    for i,v in ipairs(coords) do 
        
        if a[v] ~= 0 then return false end 
    
    end

    return true

end

local Vector

-- Get angle from a vector in degrees.

local function angle(a)

    Vector = Vector or tapLua.Vector.builder()


	local copy = {}        for i,v in ipairs(coords) do copy[v] = a[v] end


    local vector = Vector(copy):unit()          local x, y = vector:unpack()

    
    local angle = math.atan( y / x )          angle = math.deg(angle)
    
    return angle % 360

end

local function unpack(a) return a.x, a.y, a.z end


-- Based on StepMania's orientation.

local directions = {

	Left = { x = -1, y = 0 },			Right = { x = 1, y = 0 },
	Up = { x = 0, y = -1 },			    Down = { x = 0, y = 1 },

	UpLeft = { x = -1, y = - 1 },		UpRight = { x = 1, y = -1 },
	DownLeft = { x = -1, y = 1 },		DownRight = { x = 1, y = 1 }

}

for k,v in pairs(directions) do directions[k] = unit(v) end

local function direction(key) return directions[key] end

local t = {

    normSqr = normSqr,              norm = norm,
    unit = unit,                    isZero = isZero,
    angle = angle,                  unpack = unpack,

    direction = direction

}

local vector = tapLua.Vector        astro.merge( vector, t )