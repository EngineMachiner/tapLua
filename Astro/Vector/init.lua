
local path = Astro.Path .. "Vector/"


local astro = Astro.Type

local isTable = astro.isTable

local isNumber = astro.isNumber

astro = Astro.Table


local vector = require( path .. "math" )

local spaceAxes = vector.spaceAxes          local copy = vector.copy


local function hasCoordinate(a)

    for i,v in ipairs(spaceAxes) do   if a[v] then return true end   end

    return false

end


-- Array to a very basic vector.

local function array(a)

    if hasCoordinate(a) then return a end

    for k,v in pairs(spaceAxes) do a[v] = a[k]     a[k] = nil end

	return a

end


local function __add( a, b )

    local c = copy(a)       for i,v in ipairs(spaceAxes) do c[v] = a[v] + b[v] end

    return c

end

local function __sub( a, b )

    local c = copy(a)       for i,v in ipairs(spaceAxes) do c[v] = a[v] - b[v] end

    return c

end

-- Scalar multiplication and division.

local function mul( a, b )

    local c = copy(a)       for i,v in ipairs(spaceAxes) do c[v] = a[v] * b end

    return c

end

local function __mul( a, b ) return isNumber(a) and mul( b, a ) or mul( a, b ) end


local function __div( a, b ) return isNumber(a) and mul( b, 1 / a ) or mul( a, 1 / b ) end


local function mod( a, b )

    local c = copy(a)       for i,v in pairs(spaceAxes) do c[v] = a[v] % b end

    return c

end

local function __mod( a, b ) return isNumber(a) and mod( b, a ) or mod( a, b ) end


local function __unm(a)

    local c = copy(a)       for i,v in ipairs(spaceAxes) do c[v] = - a[v] end

    return c

end

local function __eq( a, b )

    for i,v in ipairs(spaceAxes) do    if a[v] ~= b[v] then return false end    end

    return true

end

local function __tostring(a)

    local s = { a:unpack() }        s = table.concat( s, ", " )

    return table.concat { "Vector( ", s, " )" }

end


local Meta = { 
    
    __add = __add,      __sub = __sub,      __mul = __mul,	__div = __div,  __mod = __mod,

    __unm = __unm,      __eq = __eq,        __tostring = __tostring

}


local functions = astro.Copy.shallow(vector)

local mergeLibs = require( Astro.Path .. "mergeLibs" )

local defaults = { "unpack", "copy" }

local function builder( __index )

    -- Add default functions and look up functions names using mergeLibs.

    __index = __index or {}             astro.Array.add( __index, defaults )
    
    __index = mergeLibs( __index, functions )
    

    -- Set the vector position defaults.

    for i,v in ipairs(spaceAxes) do __index[v] = __index[v] or 0 end


    return function( Vector, ... )
    
        -- If it's a vector then return a copy!

        if Vector.isVector(...) then return Vector.copy(...) end


        local vector = {...}
        

        local isSingle = #vector == 1 and isTable( vector[1] )
        
        if isSingle then vector = vector[1] end


        vector = array(vector)          astro.Meta.setIndex( vector, __index )

        local meta = getmetatable(vector)       Astro.Table.merge( meta, Meta )

        return vector
    
    end

end


local function isVector(a)

    if not isTable(a) then return false end

    local meta = getmetatable(a)        if not meta then return false end

    return meta.__tostring == __tostring

end


local t = { isVector = isVector, builder = builder }        astro.merge( vector, t )


local meta = { __call = builder() } -- Astro.Vector constructor.

return setmetatable( vector, meta )
