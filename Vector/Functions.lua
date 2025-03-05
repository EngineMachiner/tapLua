
local astro = Astro.Table


local function normSqr(a)

    local b = 0         for k,v in pairs(a) do b = b + v ^ 2 end

    return b

end

local function norm(a)
    
    local normSqr = normSqr(a)          return math.sqrt(normSqr) 

end

local function unit(a)
    
    local norm = norm(a)

	for k,v in pairs(a) do
        
        if v ~= 0 then a[k] = v / norm end 
    
    end

	return a

end

local function isZero(a)

    local function isValid(k) return a[k] ~= 0 end

    return not astro.find( a, isValid )

end

-- Get angle from a vector.

local function angle(a)

	local vector = DeepCopy( a, {} )        unit(vector)

    local x = vector.x or vector[1]
    local y = vector.y or vector[2]

    local angle = math.atan( y / x )        angle = math.deg(angle)

    return angle % 360

end


-- Based on StepMania's orientation.

local directions = {

	Left = { x = -1, y = 0 },			Right = { x = 1, y = 0 },
	Up = { x = 0, y = -1 },			    Down = { x = 0, y = 1 },

	UpLeft = { x = -1, y = - 1 },		UpRight = { x = 1, y = -1 },
	DownLeft = { x = -1, y = 1 },		DownRight = { x = 1, y = 1 }

}

for k,v in pairs(directions) do directions[k] = unit(v) end

local function direction(key) return directions[key] end

local function isVector(a)

    for i = 1, #a do
        
        if not isNumber( a[i] ) then return false end
        
    end

    return true

end

local t = {

    normSqr = normSqr,              norm = norm,
    unit = unit,                    isZero = isZero,
    angle = angle,

    direction = direction,          isVector = isVector

}

local vector = tapLua.Vector        astro.merge( vector, t )