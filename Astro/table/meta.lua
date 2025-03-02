
local function setIndex( tbl, __index )

    local hasMeta = getmetatable(tbl)

    local meta = getmetatable(tbl) or {}          meta.__index = __index

    if not hasMeta then setmetatable( tbl, meta ) end

    return tbl

end

return { setIndex = setIndex }