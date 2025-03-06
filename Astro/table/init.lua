
-- All isValid functions are basically compare functions.

local path = Astro.Path .. "table/"


local astro = Astro.Type

local isFunction = astro.isFunction
local isNumber = astro.isNumber
local isTable = astro.isTable
local isNil = astro.isNil


local internal = require( path .. "internal" )

local action = internal.action
local meta = internal.meta


local function merge( to, from )

    for k,v in pairs(from) do to[k] = v end         return to

end

local function keys(tbl)
    
    local t = {}
    
    for k,v in pairs(tbl) do table.insert( t, k ) end

    return meta( t, tbl )

end

local function values(tbl)
    
    local t = {}       for k,v in pairs(tbl) do table.insert( t, v ) end

    return meta( t, tbl )

end

local function random(tbl)
    
    local values = values(tbl)          local i = math.random( #values )

    return values[i]

end

local function isValid( tbl, x )

    local default = function(k) return tbl[k] == x end

    return isFunction(x) and x or default

end

-- Returns a value and key if the value is found.
-- The x parameter can be the function to compare or the value to search.

local function find( tbl, x )

    local isValid = isValid( tbl, x )

    for k,v in pairs(tbl) do    if isValid(k) then return v, k end  end
    
end

--[[

    Returns filtered values using a function with the key as argument.

    It can return an ordered array values setting __orderArray to true 
    in the table and then calling the function. When the function is run
    it will remove the value.

]]

local function filter( tbl, x )

    local orderArray = action( tbl, "__orderArray" )
    
    local isValid = isValid( tbl, x )           local t = {}

    local function add(k)

        if not isValid(k) then return end           local v = tbl[k]

        if orderArray and isNumber(k) then table.insert(t, v) return end
        
        t[k] = v

    end

    for k,v in pairs(tbl) do add(k) end

    return meta( t, tbl )

end

--[[

    Returns a table with the first table values without the same 
    key-values of the other table.

]]

local function sub( a, b )

    local function isValid(key)
    
        local val = a[key]          

        for k,v in pairs(b) do
            
            local isValid = key == k and val == v

            if isValid then return false end
        
        end
    
        return true

    end

    return filter( a, isValid )

end

-- Returns a table minus the value first found.

local function minus( tbl, val )

    local t = {}        local val, key = find( tbl, val )

    for k,v in pairs(tbl) do if k ~= key then t[k] = v end end

    return meta( t, tbl )

end

local function isEmpty(t)
  
    local next = next(t)      return isNil(next)
    
end


local mergeLibs = require( Astro.Path .. "mergeLibs" )

local tbl = {
    
    merge = merge,          keys = keys,        values = values,

    random = random,        find = find,        filter = filter,        sub = sub,
    
    minus = minus,      isEmpty = isEmpty,

    table = function(input) return mergeLibs( input, table ) end

}

Astro.Table = tbl -- Store temporarily first.


-- We're removing the internal table later.

Astro.Table.Internal = internal

local paths = { Array = "array",    Copy = "copy",      Meta = "meta" }

local function name(key) return paths[key] or key end

local keys = { "Array", "Copy", "Meta", "intersect", "readOnly", "create" }

for i,v in ipairs(keys) do tbl[v] = require( path .. name(v) ) end

tbl.concat = loadfile( path .. "concat.lua" )

Astro.Table.Internal = nil


return tbl
