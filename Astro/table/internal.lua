
local isTable = Astro.Type.isTable

-- Get and remove action.

local function action( tbl, key )
    
    local val = tbl[key]            tbl[key] = nil              return val
    
end

-- Keep the next table with the former metatable.

local function meta( to, from )

    local metatable = getmetatable(from)            if not isTable(metatable) then return to end

    local meta = action( from, "__meta" )           if meta == false then return to end

    return setmetatable( to, metatable )

end

return { action = action,       meta = meta }