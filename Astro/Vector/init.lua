
local path = Astro.Path .. "Vector/"


local astro = Astro.Type

local isTable = astro.isTable

astro = Astro.Table


local vector = require( path .. "math" )


local coords = { 'x', 'y', 'z' }

-- Array to a very basic vector.

local function array(a)

    for k,v in pairs(coords) do a[v] = a[k]     a[k] = nil end

	return a

end

local function __add( a, b )

    for k,v in pairs(coords) do a[v] = a[v] + b[v] end

    return a

end

local function __sub( a, b )

    for k,v in pairs(coords) do a[v] = a[v] - b[v] end

    return a

end

local function __mul( a, b ) -- Scalar multiplication.

    for k,v in pairs(coords) do a[v] = a[v] * b end

    return a

end

local function __unm(a)

    for k,v in pairs(a) do a[k] = - v end           return a

end

local function __eq( a, b )

    for k,v in pairs(coords) do 
        
        if a[v] ~= b[v] then return false end 
    
    end

    return true

end

local function __tostring(a)

    local s = { a:unpack() }        s = table.concat( s, ", " )

    return table.concat { "Vector( ", s, " )" }

end

local function isVector(a)

    if not isTable(a) then return false end

    local meta = getmetatable(a)        if not meta then return false end

    return meta.__tostring == __tostring

end

local Meta = { 
    
    __add = __add,      __sub = __sub,      __mul = __mul,

    __unm = __unm,      __eq = __eq,        __tostring = __tostring

}

local functions = astro.Copy.shallow(vector)

local mergeLibs = require( Astro.Path .. "mergeLibs" )

-- No need to have a function that returns the merged libs?

local function builder( __index )

    __index = __index or {}         table.insert( __index, "unpack" ) -- Add unpack by default.
    
    __index = mergeLibs( __index, functions )
    

    -- Define the vector position defaults.

    for i,v in ipairs(coords) do __index[v] = __index[v] or 0 end


    return function(...)
    
        local vector = {...}
        

        local isValid = #vector == 1 and isTable( vector[1] )
        
        if isValid then vector = vector[1] end


        vector = array(vector) -- Convert if it's an array.


        astro.Meta.setIndex( vector, __index )


        local meta = getmetatable(vector)       Astro.Table.merge( meta, Meta )


        return vector
    
    end

end

local t = { isVector = isVector, builder = builder }        astro.merge( vector, t )

return vector