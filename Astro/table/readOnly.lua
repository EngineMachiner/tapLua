
local astro = Astro.Type        local isTable = astro.isTable       local isNil = astro.isNil


-- Return the table as read-only.

local msg = "Astro: Attempt to update a read-only table."

local function onWrite() error(msg) end

local function isFalse(a) return a == false end

local function readOnly( tbl, recursive )

    local isReadOnly = tbl.readOnly

    if isFalse(isReadOnly) then return tbl end


    recursive = isNil(recursive) and true

    local function onNested()

        if not recursive then return end
    
        for k,v in pairs(tbl) do
            
            if isTable(v) then tbl[k] = readOnly(v) end  
        
        end
    
    end

    onNested()


    local t, meta = {}, getmetatable(tbl)
    
    meta = isTable(meta) and meta or {}


    meta.__index = tbl          meta.__newindex = onWrite

    meta.__metatable = "Astro: This table is read-only."


    return setmetatable( t, meta )

end

return readOnly