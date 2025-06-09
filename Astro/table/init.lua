
-- All isValid functions are basically compare functions.

local astro = Astro.Type

local isFunction = astro.isFunction         local isNumber = astro.isNumber
local isTable = astro.isTable


local path = Astro.Path .. "table/"         local internal = require( path .. "internal" )

local meta = internal.meta


local function pair( k, v ) return { key = k, value = v } end

local function value( new, current )

    local isVector = Astro.Vector.isVector              if not isTable(new) then return new end

    if isVector(new) then return new:copy() end         current = current or {}
    
    for k,v in pairs(new) do current[k] = value( v, current[k] ) end

    return current

end

local function deepMerge( to, from )

    for k,v in pairs(from) do to[k] = value( v, to[k] ) end         return to

end

local function merge( to, from )

    for k,v in pairs(from) do to[k] = v end         return to

end

local function keys(tbl)
    
    local t = {}        for k,v in pairs(tbl) do table.insert( t, k ) end

    return meta( t, tbl )

end

local function values(tbl)
    
    local t = {}        for k,v in pairs(tbl) do table.insert( t, v ) end

    return meta( t, tbl )

end

local function random(tbl)
    
    local values = values(tbl)          local i = math.random( #values )

    return values[i]

end

local function isValid( tbl, x )

    local default = function( k, v ) return v == x end

    return isFunction(x) and x or default

end

-- Returns a pair with the key and value if the value is found.
-- The x parameter can be the function to compare or the value to search.

local function find( tbl, x )

    local isValid = isValid( tbl, x )

    for k,v in pairs(tbl) do

        if isValid( k, v ) then return pair( k, v ) end
    
    end

    return {}
    
end

local function contains( tbl, x )
    
    return find( tbl, x ).value and true

end

-- Returns filtered values using a function with the key as argument.

local function filter( tbl, x )

    local isValid = isValid( tbl, x )           local t = {}

    local function add(k)

        if not isValid(k) then return end       local v = tbl[k]        t[k] = v

    end

    for k,v in pairs(tbl) do add(k) end         return meta( t, tbl )

end

--[[

    Returns a table with the first table values without the same 
    key-values of the other table.

]]

local function sub( a, b )

    local function isValid(key)
    
        local val = a[key]          

        for k,v in pairs(b) do
            
            local isValid = key == k and val == v           if isValid then return false end
        
        end
    
        return true

    end

    return filter( a, isValid )

end

-- Returns a table minus the value first found.

local function minus( tbl, val )

    local t = {}        local key = find( tbl, val ).key

    for k,v in pairs(tbl) do if k ~= key then t[k] = v end end

    return meta( t, tbl )

end

local function isEmpty(t)
  
    local next = next(t)      return next == nil
    
end


local mergeLibs = require( Astro.Path .. "mergeLibs" )

astro = {
    
    deepMerge = deepMerge,

    merge = merge,          keys = keys,        values = values,

    random = random,        find = find,        filter = filter,        
    
    contains = contains,        sub = sub,
    
    minus = minus,      isEmpty = isEmpty,      pair = pair,

    table = function(input) return mergeLibs( input, table ) end

}

Astro.Table = astro -- Store temporarily first.

-----------------------------------------------------------------------------------------------------------------

astro.Internal = internal

local paths = { Array = "array",    Copy = "copy",      Meta = "meta" }

local function name(key) return paths[key] or key end


local keys = { "Array", "Copy", "Meta", "intersect", "readOnly", "create" }

for i,v in ipairs(keys) do astro[v] = require( path .. name(v) ) end


astro.concat = loadfile( path .. "concat.lua" )             astro.Internal = nil

return astro
