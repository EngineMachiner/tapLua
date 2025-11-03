
local isTable = Astro.Type.isTable              local meta = Astro.Table.Internal.meta

local function shallow(tbl)

    local t = {}        for k,v in pairs(tbl) do t[k] = v end       return meta( t, tbl )

end

local function deep(tbl)

    local t = {}    for k,v in pairs(tbl) do if isTable(v) then v = deep(v) end     t[k] = v end

    return meta( t, tbl )

end

return { shallow = shallow,     deep = deep }