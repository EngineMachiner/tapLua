
local astro = Astro.Table


local vector = {}       tapLua.Vector = vector

tapLua.Load("Vector/Functions")


-- Array to a very basic vector.

local coords = { 'x', 'y', 'z' }

local function array(a)

    for k,v in pairs(coords) do a[v] = a[k]     a[k] = nil end

	return a

end


local functions = {

    normSqr = vector.normSqr,           norm = vector.norm,
    unit = vector.unit,                 isZero = vector.isZero,
    angle = vector.angle

}

local mergeLibs = require( Astro.Path .. "mergeLibs" )

local function create(input)

    input = input or {}
    
    for i,v in ipairs(coords) do input[v] = input[v] or 0 end

    return function(a)
    
        a = a or {}
    
        local __index = mergeLibs( input, functions )
        
        return astro.Meta.setIndex( a, __index )
    
    end

end

local t = { array = array, create = create }

astro.merge( vector, t )