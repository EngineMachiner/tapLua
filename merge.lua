
-- Based off Astro implementation. It does not merge actor tables.

local astro = Astro.Type                local isTable = astro.isTable

local isVector = Astro.Vector.isVector


-- This looks suspicious...

local function isObject(a)
    
    local meta = getmetatable(a)        local k = "__concat"

    return meta and meta[k] == DefMetatable[k]

end

local function value( new, current )
    
    local isNew = not isTable(new) or isObject(new)

    if isNew or not isTable(current) then return new end

    if isVector(new) then return new:copy() end         current = current or {}
    
    for k,v in pairs(new) do current[k] = value( v, current[k] ) end

    return current

end

local function deepMerge( to, from )

    if not from then return to end

    for k,v in pairs(from) do to[k] = value( v, to[k] ) end         return to

end

tapLua.deepMerge = deepMerge