
local function setIndex( tbl, __index )

    local meta = getmetatable(tbl)          local hasMeta = meta
    
    meta = meta or {}          meta.__index = __index

    return hasMeta and tbl or setmetatable( tbl, meta )

end

return { setIndex = setIndex }