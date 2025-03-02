
local astro = Astro.Type

local isTable = astro.isTable

astro = Astro.Table

local meta = astro.Internal.meta

local function last(tbl) return tbl[#tbl] end

local function add( to, from )

    for k,v in ipairs(from) do table.insert( to, v ) end

end

--[[

    Returns a table with the first table values without
    the values of the other table.

]]

local function sub( a, b )

    local function isValid(key)
    
        local val = a[key]          

        for k,v in pairs(b) do  if val == v then return false end   end
    
        return true

    end

    return astro.filter( a, isValid )

end

local function reverse(t)

    local output = {}

    for i = #t, 1, -1 do table.insert( output, t[i] ) end

    return meta( output, t )

end

-- Returns an array without repeated values.

-- It's better to be aware on how you're adding things to the array instead.

local function distinct( array, recursive )

    local seen, output = {}, {}

    local function add(v)

        if seen[v] then return end          seen[v] = true
        
        if isTable(v) and recursive then v = distinct( v, true ) end

        table.insert( output, v )

    end

    for i,v in ipairs(array) do add(v) end           return meta( output, t )

end

return {

    last = last,        add = add,          sub = sub,
    
    reverse = reverse,          distinct = distinct

}