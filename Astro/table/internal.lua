
local isTable = Astro.Type.isTable

-- Keep the next table with the former metatable.

local function meta( to, from, meta )

    meta = meta == nil and true

    local metatable = getmetatable(from)            if not isTable(metatable) then return to end

    if meta == false then return to end             return setmetatable( to, metatable )

end

return { meta = meta }