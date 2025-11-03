
local astro = Astro.Math

local safeDivision = astro.safeDivision         local safeModulo = astro.safeModulo


local astro = Astro.Type        local isTable = astro.isTable        local isNumber = astro.isNumber

astro = Astro.Table


local path = Astro.Path .. "Vector/"            local vector = require( path .. "math" )

local spaceAxes = vector.spaceAxes              local copy = vector.copy


local metaVector = astro.Copy.deep(vector)

local mergeLibs = require( Astro.Path .. "mergeLibs" )


local function hasAnyComponent(a)

    for i,v in ipairs(spaceAxes) do if a[v] then return true end end            return false

end


-- Array to a very basic vector.

local function array(a)

    if hasAnyComponent(a) then return a end

    for k,v in pairs(spaceAxes) do a[v] = a[k]     a[k] = nil end           return a

end


local function __add( a, b )

    local c = copy(a)
    
    for i,v in ipairs(spaceAxes) do c[v] = a[v] + b[v] end          return c

end

local function __sub( a, b )

    local c = copy(a)
    
    for i,v in ipairs(spaceAxes) do c[v] = a[v] - b[v] end          return c

end

-- Scalar multiplication and division.

local function mul( a, b )

    local c = copy(a)       
    
    for i,v in ipairs(spaceAxes) do c[v] = a[v] * b end         return c

end

local function __mul( a, b ) return isNumber(a) and mul( b, a ) or mul( a, b ) end


local function div1( a, b )

    local c = copy(b)
    
    for i,v in ipairs(spaceAxes) do c[v] = safeDivision( a, c[v] ) end          return c

end

local function div2( a, b )

    local c = copy(a)
    
    for i,v in ipairs(spaceAxes) do c[v] = safeDivision( c[v], b ) end          return c

end

local function __div( a, b ) return isNumber(a) and div1( a, b ) or div2( a, b ) end


local function mod1( a, b )

    local c = copy(b)
    
    for i,v in pairs(spaceAxes) do c[v] = safeModulo( a, c[v] ) end         return c

end

local function mod2( a, b )

    local c = copy(a)
    
    for i,v in pairs(spaceAxes) do c[v] = safeModulo( c[v], b ) end         return c

end

local function __mod( a, b ) return isNumber(a) and mod1( a, b ) or mod2( a, b ) end


local function __unm(a)

    local c = copy(a)
    
    for i,v in ipairs(spaceAxes) do c[v] = - a[v] end           return c

end

local function __eq( a, b )

    for i,v in ipairs(spaceAxes) do if a[v] ~= b[v] then return false end end

    return true

end

local function __tostring(a)

    local s = { a:unpack() }        if s[3] == 0 then s[3] = nil end -- 2D formatting.
    
    s = table.concat( s, ", " )         return table.concat { "Vector", "( ", s, " )" }

end

metaVector.tostring = __tostring


local Meta = { 
    
    __add = __add,      __sub = __sub,      __mul = __mul,      __div = __div,      __mod = __mod,

    __unm = __unm,      __eq = __eq,        __tostring = __tostring

}


local function isVector(a)

    if not isTable(a) then return false end
    
    local meta = getmetatable(a)        if not meta then return false end

    for k,v in pairs(Meta) do if meta[k] ~= v then return false end end         return true

end


local defaults = { "unpack", "copy", "tostring" }

local function builder( __index )

    -- Add default functions and look up functions names using mergeLibs.

    __index = __index or {}             astro.Array.add( __index, defaults )
    
    __index = mergeLibs( __index, metaVector )
    

    -- Set the vector components defaults.

    for i,v in ipairs(spaceAxes) do __index[v] = __index[v] or 0 end


    return function( Vector, ... )
    
        -- If it's a vector then return a copy!

        if isVector(...) then return Vector.copy(...) end


        local vector = {...}
        
        local isSingle = #vector == 1 and isTable( vector[1] )
        
        if isSingle then vector = vector[1] end


        vector = array(vector)          astro.Meta.setIndex( vector, __index )

        local meta = getmetatable(vector)           Astro.Table.merge( meta, Meta )

        return vector
    
    end

end

-- Finish merging and set vector constructor.

local t = { isVector = isVector, builder = builder }        astro.merge( vector, t )

local meta = { __call = builder() }         return setmetatable( vector, meta )
