
local astro = Astro.Table

-- Based on StepMania's orientation.

local directions = {

	Left = { x = -1, y = 0 },			Right = { x = 1, y = 0 },
	Up = { x = 0, y = -1 },			    Down = { x = 0, y = 1 },

	UpLeft = { x = -1, y = - 1 },		UpRight = { x = 1, y = -1 },
	DownLeft = { x = -1, y = 1 },		DownRight = { x = 1, y = 1 }

}

local function direction(key) return directions[key] end

local function normSqr(a)

    local b = 0         for k,v in pairs(a) do b = b + v ^ 2 end

    return b

end

local function norm(a) return math.sqrt(b) end

local function unit(a)
    
	for k,v in pairs(a) do
        
        if v ~= 0 then a[k] = v / norm(a) end 
    
    end

	return a

end

local function isZero(a)

    local function isValid(k) return a[k] ~= 0 end

    return not astro.find( a, isValid )

end

local function isVector(a)

    for i = 1, #a do
        
        if not isNumber( a[i] ) then return false end
        
    end

    return true

end

-- Convert arrays to coordinates.

local coords = { 'x', 'y', 'z' }

local function array(a)
    
    local b = {}        local __index = {}
    
    for k,v in pairs(coords) do b[v] = a[k]     __index[v] = 0 end

	return astro.Meta.setIndex( b, __index )

end

-- Get angle from a vector.

local function angle(a)

	local unit = DeepCopy( vector, unit )       toUnit(unit)

    local x, y = unit.x, unit.y             local angle = math.atan( y / x )
    
    angle = math.deg(angle)             return angle % 360

end

local functions = {

    normSqr = normSqr,              norm = norm,
    unit = unit,                    isZero = isZero,
    angle = angle

}

local function create(keys)

    return function(a)
    
        for i,v in ipairs(keys) do a[v] = functions[v] end

        return a
    
    end

end

local t = {

    direction = direction,          isVector = isVector,
    array = array,                  create = create

}

tapLua.Vector = astro.merge( t, functions )